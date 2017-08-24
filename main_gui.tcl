package require Tk



#Window Settings
wm title . "FullMonte"
wm geometry . 350x350

tk_setPalette snow2

#Buttons for four options
grid [button .optb -text "Optical Properties" -command makeOpticalFrame ] -column 2 -row 1 -pady 20 -padx 80 -sticky we 

grid [button .simulator -text "Simulator Properties" -command makeSimFrame] -column 2 -row 3 -pady 20 -padx 80 -sticky we

grid [button .sourcep -text "Source Placement" -command makeLightSourceFrame] -column 2 -row 5 -pady 20 -padx 80 -sticky we

grid [button .spec -text "Absorption Spectrum" -command makeSpectrumFrame] -column 2 -row 7 -pady 20 -padx 80 -sticky we



#Create optical property window.
proc makeOpticalFrame {} {
    if {[catch {toplevel .opt }]} {
       error "One window is already open. Please close it before open a new window"    
    }
    
    wm title .opt "Optical Properties"
    #.opt configure -background "white"
    #wm geometry .opt 750x550
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
proc makeSpectrumFrame {} {
    if {[catch {toplevel .spec }]} {
       error "One window is already open. Please close it before open a new window"    
    }

    wm title .spec "Absorption Spectrum"
    wm geometry .spec 550x250
    source spectrum_gui.tcl
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


