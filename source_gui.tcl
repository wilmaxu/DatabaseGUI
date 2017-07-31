package require Tk


grid [button .ls.point -text "Point Source:" -command makePoint] -column 1 -row 1 -sticky we

grid [label .ls.space1 -text ""] -column 1 -row 2 -sticky w

grid [button .ls.line -text "Line Source:" -command makeLine] -column 1 -row 3 -sticky we

grid [label .ls.space2 -text ""] -column 1 -row 5 -sticky w

grid [button .ls.pencil -text "Pencil Beam Source:" -command makePencil] -column 1 -row 6 -sticky we

grid [label .ls.space3 -text ""] -column 1 -row 8 -sticky w





source source_function.tcl

