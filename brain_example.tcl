###### Start performance timer
set tStart [clock clicks -milliseconds]

###### Import VTK TCL package
package require vtk
package require FullMonte 1.0


###### Basic parameters: file names

#optfn
set optfn "/home/yiwenxu/Desktop/DatabaseGUI/Human_Brain.opt"

#meshfn
set meshfn "/home/yiwenxu/Desktop/Finished/5post/Separate Vtk/5post_Brain-resampled.mesh.vtk"


###read mesh from VTK file
# VTKLegacyReader R
# R setFileName $meshfn
# set mesh [R mesh]

vtkUnstructuredGridReader VTKR
VTKR SetFileName $meshfn
VTKR Update

vtkFullMonteMeshFromUnstructuredGrid conv
conv unstructuredGrid [VTKR GetOutput]
conv update

TIMOSMaterialReader TR
TR filename $optfn
TR read
set opt [TR materials]


puts "Loading done"

set mesh [conv meshPtr]


set tLoaded [clock clicks -milliseconds]


###### Configure source (Line source with given endpoints)
 
Point P
P position "22 33 55"
 
 
###### Create and configure simulation kernel with surface scoring
TetraVolumeKernel k

k geometry $mesh

k source P
    # the source to launch from

k materials          $opt
    # materials


# Monte Carlo kernel properties
k roulettePrWin      0.1
    # probability of roulette win

k rouletteWMin       1e-1
    # minimum weight "wmin" before roulette takes effect

k maxSteps           100000
    # maximum number of steps to trace a packet

k maxHits            1000
    # maximum number of boundaries a single step can take

k packetCount        1000000
    # number of packets to simulate (more -> better quality, longer run)

k threadCount        8
    # number of threads (set to number of cores, or 2x number of cores if hyperthreading)






###### VTK output pipeline

# wrap FullMonte mesh and make available as vtkPolyData & vtkUnstructuredGrid
vtkFullMonteTetraMeshWrapper VTKM
    VTKM mesh $mesh

# Create fluence wrapper
vtkFullMonteArrayAdaptor vtkPhi

vtkFieldData volumeFieldData

vtkDataObject volumeData
    volumeData SetFieldData volumeFieldData

# merge fluence wrapper onto the tetras of the mesh 
vtkMergeDataObjectFilter mergeFluence
    mergeFluence SetDataObjectInputData volumeData
    mergeFluence SetInputData [VTKM blankMesh]
    mergeFluence SetOutputFieldToCellDataField

# set up writer for the output poly data
vtkUnstructuredGridWriter VTKW
    VTKW SetInputConnection [mergeFluence GetOutputPort]





###### Define progress timer callback function for use during simulation run

proc progresstimer {} {
    # loop while not finished
	while { ![k done] } {
        # display % completed to 2 decimal places
    	puts -nonewline [format "\rProgress %6.2f%%" [expr 100.0*[k progressFraction]]]
	    flush stdout

        # refresh interval: 200ms
	    after 200
	}
	puts [format "\rProgress %6.2f%%" 100.0]
}





# launch kernel, display progress timer, and await finish

k startAsync
progresstimer
k finishAsync 


puts "Kernel is done"

OutputDataSummarize OS

set results [k results]

for { set r 0 } { $r < [$results size] } { incr r } {
    puts ""
#    puts "Result $r"
#    puts "  [$results getByIndex $r] [[[$results getByIndex $r] type] name]"
    OS visit [$results getByIndex $r]
}

puts "** end summary **"

EnergyToFluence EF
EF mesh $mesh
EF materials $opt
EF source [$results getByName "VolumeEnergy"]
EF update

vtkPhi source [EF result]
vtkPhi update

set A [vtkPhi array]
$A SetName "Fluence"

volumeFieldData AddArray $A

set regions [VTKM regions]
$regions SetName "Tissue Type"

volumeFieldData AddArray $regions

# Write volume fluence & tissue type to .vtk file

VTKW SetFileName "demo.vtk"
VTKW SetFileTypeToBinary
VTKW Update

volumeFieldData RemoveArray $A











































