package require Tk


wm title . "FullMonte"
wm geometry . 250x200
grid [ttk::frame .m -padding "4 4 12 12"] -column 0 -row 0 -sticky nwes
grid columnconfigure . 0 -weight 1; grid rowconfigure . 0 -weight 1

grid [ttk::button .m.optb -text "Optical Properties" -command makeOpticalFrame] -column 2 -row 1 -sticky we 
grid [ttk::button .m.source -text "Source Placement" -command makePointSourceFrame] -column 2 -row 2 -sticky we
grid [ttk::button .m.mesh -text "Mesh Properties" -command makeMeshFrame] -column 2 -row 3 -sticky we
grid [ttk::button .m.simulator -text "Simulator Properties" -command makeSimFrame] -column 2 -row 4 -sticky we



proc makeOpticalFrame {} {
    toplevel .opt 
#    grid [ttk::frame .opt -padding "4 4 12 12"] -column 0 -row 0 -sticky nwes
    wm title .opt "Optical Properties"

    source opt_gui.tcl
}

proc makePointSourceFrame {} {
    toplevel .sp
    wm title .sp "Point Source Placement"
    wm geometry .sp 550x250
    grid [ttk::label .sp.wavelbl -text "To be continue"] -column 1 -row 1 
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

open brain.opt w