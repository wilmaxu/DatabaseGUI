package require Tk



wm title . "FullMonte"
wm geometry . 350x400

grid [ttk::frame .m -padding "100 100 30 30"] -column 0 -row 0 -sticky nwes

grid [ttk::button .m.optb -text "Optical Properties" -command makeOpticalFrame] -column 2 -row 1 -sticky we 
grid [label .m.space1 -text ""] -column 2 -row 2 -sticky w
grid [ttk::button .m.simulator -text "Simulator Properties" -command makeSimFrame] -column 2 -row 3 -sticky we
grid [label .m.space2 -text ""] -column 2 -row 4 -sticky w
grid [ttk::button .m.sourcep -text "Source Placement" -command makeLightSourceFrame] -column 2 -row 5 -sticky we
grid [label .m.space3 -text ""] -column 2 -row 6 -sticky w
grid [ttk::button .m.mesh -text "Mesh Properties" -command makeMeshFrame] -column 2 -row 7 -sticky we




proc makeOpticalFrame {} {
    toplevel .opt 
    wm title .opt "Optical Properties"
    wm geometry .opt 650x350
    source opt_gui.tcl
}

proc makeLightSourceFrame {} {
    toplevel .ls
    wm title .ls "Point Source Placement"
    wm geometry .ls 850x300
    source sou_gui.tcl
}

proc makeMeshFrame {} {
    toplevel .mesh
    wm title .mesh "Mesh Properties"
    wm geometry .mesh 550x250
    grid [ttk::label .mesh.wavelbl -text "To be continue"] -column 1 -row 1 
}

proc makeSimFrame {} {
    toplevel .sim
    wm title .sim "Simulator Properties"
    wm geometry .sim 550x250
    source sim_gui.tcl
}


