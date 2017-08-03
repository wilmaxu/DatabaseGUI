package require Tk



frame .aopt.frame1 -padx 1 -pady 10 -height 200 -width 100 

grid configure .aopt.frame1 -columnspan 6 -row 6 -sticky we
grid [label .aopt.frame1.wlbl -text "wavelength"] -column 1 -row 1 -padx 10 -sticky w
grid [label .aopt.frame1.albl -text "mu_a"] -column 2 -row 1 -padx 10 -sticky w
grid [label .aopt.frame1.slbl -text "mu_s"] -column 3 -row 1 -padx 10 -sticky w
grid [label .aopt.frame1.glbl -text "g"] -column 4 -row 1 -padx 10 -sticky w
grid [label .aopt.frame1.nlbl -text "n"] -column 5 -row 1 -padx 10 -sticky w
grid [label .aopt.frame1.rlbl -text "Reference"] -column 6 -row 1 -padx 10 -sticky w



for {set i 1} {$i < 15} {incr i} {
    grid [ttk::label .aopt.frame1.w$i -textvariable w$i] -column 1 -row [expr $i +1] -padx 10 -sticky w
    grid [ttk::label .aopt.frame1.a$i -textvariable a$i] -column 2 -row [expr $i +1] -padx 10 -sticky w
    grid [ttk::label .aopt.frame1.s$i -textvariable s$i] -column 3 -row [expr $i +1] -padx 10 -sticky w
    grid [ttk::label .aopt.frame1.g$i -textvariable g$i] -column 4 -row [expr $i +1] -padx 10 -sticky w
    grid [ttk::label .aopt.frame1.n$i -textvariable n$i] -column 5 -row [expr $i +1] -padx 10 -sticky w
    grid [ttk::label .aopt.frame1.r$i -textvariable r$i] -column 6 -row [expr $i +1] -padx 10 -sticky w
}   

######################################################################################################

source AllOpt_function.tcl
