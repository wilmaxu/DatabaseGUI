package require Tk


#Window Settings
wm title . "FullMonte"
wm geometry . 350x400
grid [ttk::frame .m -padding "100 100 30 30"] -column 0 -row 0 -sticky nwes

#Buttons for four options
grid [ttk::button .m.optb -text "Optical Properties" -command makeOpticalFrame] -column 2 -row 1 -sticky we 
grid [label .m.space1 -text ""] -column 2 -row 2 -sticky w
grid [ttk::button .m.simulator -text "Simulator Properties" -command makeSimFrame] -column 2 -row 3 -sticky we
grid [label .m.space2 -text ""] -column 2 -row 4 -sticky w
grid [ttk::button .m.sourcep -text "Source Placement" -command makeLightSourceFrame] -column 2 -row 5 -sticky we
grid [label .m.space3 -text ""] -column 2 -row 6 -sticky w
grid [ttk::button .m.mesh -text "Mesh Properties" -command makeMeshFrame] -column 2 -row 7 -sticky we



#Create optical property window.
proc makeOpticalFrame {} {
    if {[catch {toplevel .opt }]} {
       error "One window is already open. Please close it before open a new window"    
    }
    
    wm title .opt "Optical Properties"
    wm geometry .opt 750x550
    source opt_gui.tcl
}

#Create light source placement window.
proc makeLightSourceFrame {} {
    if {[catch {toplevel .ls }]} {
       error "One window is already open. Please close it before open a new window"    
    }

    wm title .ls "Point Source Placement"
    wm geometry .ls 850x300
    source source_gui.tcl
}

#Create mesh property window. This is an empty window for now. Will add content if needed.
proc makeMeshFrame {} {
    if {[catch {toplevel .mesh }]} {
       error "One window is already open. Please close it before open a new window"    
    }

    wm title .mesh "Mesh Properties"
    wm geometry .mesh 550x250
    grid [ttk::label .mesh.wavelbl -text "To be continue"] -column 1 -row 1 
}

#Create simulator property window.
proc makeSimFrame {} {
    if {[catch {toplevel .sim }]} {
       error "One window is already open. Please close it before open a new window"    
    }
    wm title .sim "Simulator Properties"
    wm geometry .sim 550x250
    source simulator_gui.tcl
}


