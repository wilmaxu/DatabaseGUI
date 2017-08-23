package require Tk



#-----------Window settings---------------

grid [label .spec.photosensitizerlbl -text "Photosensitizer"] -column 1 -row 1 -sticky w
grid [ttk::combobox .spec.photosensitizer -values [list PPIX AlPcS BPD-MA Chle6 HPPH Lutex m-THPC HPD SnEt2 ZnPcHe] -textvariable photos] -column 2 -row 1 -sticky we
grid [button .spec.photosensitizerb -text "Search" -command SearchSpectrum] -column 3 -row 1 -sticky we

grid [label .spec.speclbl -text "Absorption Spectrum"] -column 1 -row 2 -sticky wn
grid [listbox .spec.myList ] -column 2 -row 2 -sticky we
#grid [label .spec.wavelbl -text "Wavelength"] -column 1 -row 2 -sticky we
#grid [ttk::spinbox .spec.wlval -textvariable specwave -from 100.0 -to 1500.0 -increment 1] -column 2 -row 2 -sticky we

#grid [label .spec.uncertaintylbl -text "Uncertainty"] -column 1 -row 3 -sticky we
#grid [ttk::spinbox .spec.ulbl -textvariable swuncertainty -from 5.0 -to 500.0 -increment 1] -column 2 -row 3 -sticky we

grid [label .spec.reflbl -text "Reference"] -column 1 -row 3 -sticky wn
grid [text .spec.reftxt -height 10 -width 30] -column 2 -row 3 -sticky we

source spectrum_function.tcl
