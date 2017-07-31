package require Tk


grid [label .aopt.wavelbl -text "Wavelength(nm)"] -column 1 -row 1 -sticky w
grid [label .aopt.orglbl -text "organ"] -column 1 -row 3 -sticky w
grid [label .aopt.spelbl -text "species"] -column 1 -row 5 -sticky w

grid [ttk::combobox .aopt.wlval -values [list 100 200 300 400 500] -textvariable wavelength] -column 2 -row 1 -sticky w
grid [ttk::combobox .aopt.organval -values [list brain bladder liver fat] -textvariable organ] -column 2 -row 3 -sticky w
grid [ttk::combobox .aopt.speciesval -values [list human rat rabbit pig none] -textvariable species] -column 2 -row 5 -sticky w


grid [label .aopt.uclbl -text "uncertainty"] -column 1 -row 2 -sticky w
grid [label .aopt.sttlbl -text "status"] -column 1 -row 4 -sticky w

grid [ttk::combobox .aopt.ucval -values [list 0 10 20 30 40 50] -textvariable uncertainty] -column 2 -row 2 -sticky w
grid [ttk::combobox .aopt.sttval -values [list healthy tumor none] -textvariable status] -column 2 -row 4 -sticky w


######################################################################################################

listbox .aopt.lb -selectmode multiple -height 10
scrollbar .aopt.sb -command [list .aopt.lb yview]
.aopt.lb configure -yscrollcommand [list .aopt.sb set]
.aopt.lb insert 0 sample stuff colors red yellow green another another yoyo hi yes no ops haha
grid .aopt.lb -column 1 -row 6 -sticky nw
grid .aopt.sb -column 2 -row 6 -sticky nw

.aopt.lb insert 2 "dogs are great"
