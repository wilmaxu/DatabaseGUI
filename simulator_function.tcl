package require Tk


# Function to locate the simulator (tcl file) in local computer. This must be called before any other fucntion in this file.
proc OpenSimulator {} {
    global simfname
    set file [tk_getOpenFile -parent .]
    set simfname $file

}


# Function to locate the Opt file in local computer
proc OpenOpt {} {
    global optfname
    global simfname

    set file [tk_getOpenFile -parent .]

    if {[catch {set f [open $simfname r+]} ermsg]} {
        error "Please select tcl file first"    
    }
    set file_data [read $f]
    set lines [split $file_data "\n"]
    close $f

    # Change opt file path to the selected path in the simulator (tcl file)
    set optfname $file
    set index [lsearch -regexp $lines "set optfn .?"]
    set lines [lreplace $lines $index $index "set optfn \"$optfname\""]
    
    set f [open $simfname "w"]
    puts $f [join $lines "\n"]
    close $f    
}


# Function to locate the Mesh file in local computer
proc OpenMesh {} {
    global meshfname
    global simfname

    set file [tk_getOpenFile -parent .]

    if {[catch {set f [open $simfname r+]} ermsg]} {
        error "Please select tcl file first"    
    }
    set file_data [read $f]
    set lines [split $file_data "\n"]
    close $f
  
    # Change mesh file path to the selected path in the simulator (tcl file)
    set meshfname $file
    set index [lsearch -regexp $lines "set meshfn .?"]
    set lines [lreplace $lines $index $index "set meshfn \"$meshfname\""]
    
    set f [open $simfname "w"]
    puts $f [join $lines "\n"]
    close $f
}


# Function to edit the parameters in the simulator(Here includes only two parameter. Can add more if needed)
proc SetSimulator {} {
    global simfname
    global npackets
    global outputname

    if {[catch {set f [open $simfname r+]} ermsg]} {
        error "Please select tcl file first"    
    }
    set file_data [read $f]
    set lines [split $file_data "\n"]
    close $f
  
    # Change packet count
    set pindex [lsearch -regexp $lines "k packetCount.?"]
    set lines [lreplace $lines $pindex $pindex "k packetCount        $npackets"]

    # Change output file name
    set oindex [lsearch -regexp $lines "VTKW SetFileName.?"]
    set lines [lreplace $lines $oindex $oindex "VTKW SetFileName \"$outputname\""]

    set f [open $simfname "w"]
    puts $f [join $lines "\n"]
    close $f
   
}
