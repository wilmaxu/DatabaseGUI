package require Tk
source database_function.tcl



#-----------Window settings of the database editor---------------
grid [label .db.orglbl -text "organ"] -column 1 -row 1 -pady 5 -sticky w
grid [label .db.sttlbl -text "status"] -column 1 -row 2 -pady 5 -sticky w
grid [label .db.spelbl -text "species"] -column 1 -row 3 -pady 5 -sticky w
grid [label .db.wavelbl -text "Wavelength(nm)"] -column 1 -row 4 -pady 5 -sticky w
grid [label .db.albl -text "mu_a"] -column 1 -row 5 -pady 5 -sticky w
grid [label .db.slbl -text "mu_s"] -column 1 -row 6 -pady 5 -sticky w
grid [label .db.slbl1 -text "mu_s'"] -column 1 -row 7 -pady 5 -sticky w
grid [label .db.glbl -text "g"] -column 1 -row 8 -pady 5 -sticky w
grid [label .db.nlbl -text "n"] -column 1 -row 9 -pady 5 -sticky w
grid [label .db.rlbl -text "Reference"] -column 1 -row 10 -pady 5 -sticky w

grid [entry .db.waveval -textvariable db_wavelength ] -column 2 -row 4 -pady 5 -sticky we
grid [ttk::combobox .db.organval -values [list air bladder blood bone brain breast CSF fat gray_matter heart liver lung muscle scalp&skull skin water white_matter] -textvariable db_organ] -column 2 -row 1 -pady 5 -sticky w
grid [ttk::combobox .db.sttval -values [list healthy tumor none] -textvariable db_status] -column 2 -row 2 -pady 5 -sticky w
grid [ttk::combobox .db.speciesval -values [list human rat rabbit pig dog none] -textvariable db_species] -column 2 -row 3 -pady 5 -sticky w

grid [entry .db.a -textvariable db_a ] -column 2 -row 5 -pady 5 -sticky we
grid [entry .db.s -textvariable db_s ] -column 2 -row 6 -pady 5 -sticky we
grid [entry .db.s1 -textvariable db_s1 ] -column 2 -row 7 -pady 5 -sticky we
grid [entry .db.g -textvariable db_g ] -column 2 -row 8 -pady 5 -sticky we
grid [entry .db.n -textvariable db_n ] -column 2 -row 9 -pady 5 -sticky we
grid [entry .db.r -textvariable db_r ] -column 2 -row 10 -pady 5 -sticky we

grid [button .db.addopt -text "Add to Database" -command AddToDatabase] -column 2 -row 11 -pady 5 -sticky we


