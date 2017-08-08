package require Tk
source simulator_function.tcl




#-----------Window settings---------------
grid [ttk::label .sim.simfile -textvariable simfname] -column 2 -row 1 -sticky w
grid [button .sim.selectfile -text "Choose tcl file:" -command OpenSimulator] -column 1 -row 1 -sticky we

grid [ttk::label .sim.optfile -textvariable optfname] -column 2 -row 2 -sticky w
grid [button .sim.selectoptfile -text "Choose opt file:" -command OpenOpt] -column 1 -row 2 -sticky we

grid [ttk::label .sim.meshfile -textvariable meshfname] -column 2 -row 3 -sticky w
grid [button .sim.selectmeshfile -text "Choose mesh file:" -command OpenMesh] -column 1 -row 3 -sticky we

grid [label .sim.space -text ""] -column 1 -row 4 -sticky w

grid [label .sim.packets -text "Number of Packets:"] -column 1 -row 5 -sticky we
grid [entry .sim.npacket -textvariable npackets ] -column 2 -row 5 -sticky w


grid [label .sim.output -text "Output file name:"] -column 1 -row 6 -sticky we
grid [entry .sim.outputn -textvariable outputname] -column 2 -row 6 -sticky w

grid [label .sim.space2 -text ""] -column 1 -row 7 -sticky w

grid [button .sim.run -text "Setup Simulator" -command SetSimulator] -column 2 -row 8 -sticky e





