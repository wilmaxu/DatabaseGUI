package require Tk



grid [label .opt.wavelbl -text "Wavelength(nm)"] -column 1 -row 1 -sticky w
grid [label .opt.orglbl -text "organ"] -column 1 -row 2 -sticky w
grid [label .opt.spelbl -text "species"] -column 1 -row 3 -sticky w

grid [ttk::combobox .opt.wlval -values [list 100 200 300 400 500] -textvariable wavelength] -column 2 -row 1 -sticky w
grid [ttk::combobox .opt.organval -values [list brain bladder liver fat] -textvariable organ] -column 2 -row 2 -sticky w
grid [ttk::combobox .opt.speciesval -values [list human rat rabbit pig none] -textvariable species] -column 2 -row 3 -sticky w


grid [label .opt.uclbl -text "uncertainty"] -column 3 -row 1 -sticky w
grid [label .opt.sttlbl -text "status"] -column 3 -row 2 -sticky w

grid [ttk::combobox .opt.ucval -values [list 0 10 20 30 40 50] -textvariable uncertainty] -column 4 -row 1 -sticky w
grid [ttk::combobox .opt.sttval -values [list healthy tumor none] -textvariable status] -column 4 -row 2 -sticky w


grid [button .opt.search -text "Search" -command search] -column 4 -row 4 -sticky e


grid [label .opt.albl -text "mu_a"] -column 2 -row 7 -sticky w
grid [label .opt.slbl -text "mu_s"] -column 3 -row 7 -sticky w
grid [label .opt.glbl -text "g"] -column 4 -row 7 -sticky w
grid [label .opt.nlbl -text "n"] -column 5 -row 7 -sticky w

grid [label .opt.avglbl -text "Average"] -column 1 -row 8 -sticky w
grid [label .opt.minlbl -text "Min"] -column 1 -row 9 -sticky w
grid [label .opt.maxlbl -text "Max"] -column 1 -row 10 -sticky w


grid [ttk::label .opt.avg_a -textvariable avg_a] -column 2 -row 8 -sticky we
grid [ttk::label .opt.avg_s -textvariable avg_s] -column 3 -row 8 -sticky we
grid [ttk::label .opt.avg_g -textvariable avg_g] -column 4 -row 8 -sticky we
grid [ttk::label .opt.avg_n -textvariable avg_n] -column 5 -row 8 -sticky we

grid [ttk::label .opt.min_a -textvariable min_a] -column 2 -row 9 -sticky we
grid [ttk::label .opt.min_s -textvariable min_s] -column 3 -row 9 -sticky we
grid [ttk::label .opt.min_g -textvariable min_g] -column 4 -row 9 -sticky we
grid [ttk::label .opt.min_n -textvariable min_n] -column 5 -row 9 -sticky we

grid [ttk::label .opt.max_a -textvariable max_a] -column 2 -row 10 -sticky we
grid [ttk::label .opt.max_s -textvariable max_s] -column 3 -row 10 -sticky we
grid [ttk::label .opt.max_g -textvariable max_g] -column 4 -row 10 -sticky we
grid [ttk::label .opt.max_n -textvariable max_n] -column 5 -row 10 -sticky we

grid [button .opt.advanced -text "Advanced opt" -command advance] -column 4 -row 12 -sticky e



grid [label .opt.space1 -text ""] -column 2 -row 13 -sticky w

grid [button .opt.generatefile -text "Generate/Overwrite an opt file with name:" -command generate] -column 1 -row 14 -sticky we

grid [entry .opt.filename -textvariable fname ] -column 2 -row 14 -sticky we

grid [button .opt.nborgan -text "Set number of total organs:" -command SetOrgan] -column 1 -row 15 -sticky we
grid [entry .opt.norgans -textvariable norgan ] -column 2 -row 15 -sticky we


grid [button .opt.addopt -text "Add current property to file" -command AddOpt] -column 1 -row 16 -sticky we

grid [button .opt.deleteopt -text "Delete last line" -command DeleteOpt] -column 1 -row 17 -sticky we

grid [button .opt.closefile -text "Finish opt file" -command FinishOpt] -column 1 -row 18 -sticky we

grid [label .opt.filedis -textvariable filedis] -column 1 -row 19 -sticky w

#-------

#-------

source opt_function.tcl
source AdvancedOpt_gui.tcl
