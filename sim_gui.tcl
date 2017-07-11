package require Tk


set types {
        {"All"   {.tcl .opt .vtk .mesh.vtk}  }
        {"Opt Files"   {.opt}  }
        {"VTK Files"   {.vtk .mesh.vtk}  }
        {"Tcl Files"   {.tcl}  }
}





grid [ttk::label .sim.simfile -textvariable simfname] -column 2 -row 1 -sticky w
grid [button .sim.selectfile -text "Choose tcl file:" -command simfile] -column 1 -row 1 -sticky w


grid [ttk::label .sim.optfile -textvariable optfname] -column 2 -row 2 -sticky w
grid [button .sim.selectoptfile -text "Choose opt file:" -command OpenOpt] -column 1 -row 2 -sticky w

grid [ttk::label .sim.meshfile -textvariable meshfname] -column 2 -row 3 -sticky w
grid [button .sim.selectmeshfile -text "Choose mesh file:" -command OpenMesh] -column 1 -row 3 -sticky w

grid [label .sim.space -text ""] -column 1 -row 4 -sticky w

grid [label .sim.packets -text "Number of Packets"] -column 1 -row 5 -sticky w
grid [entry .sim.npacket -textvariable npackets ] -column 2 -row 5 -sticky w


grid [label .sim.output -text "Output file name:"] -column 1 -row 6 -sticky w
grid [entry .sim.outputn -textvariable outputname] -column 2 -row 6 -sticky w

grid [label .sim.space2 -text ""] -column 1 -row 7 -sticky w

grid [button .sim.run -text "Run FullMonte" -command run] -column 2 -row 8 -sticky e


#-------

#-------

source sim_fun.tcl

