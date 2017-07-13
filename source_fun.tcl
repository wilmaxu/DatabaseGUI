package require Tk


proc makePoint {} {
     grid [label .ls.plbl -text "Point:"] -column 2 -row 1 -sticky w
     grid [entry .ls.pxaxis -textvariable px ] -column 3 -row 1 -sticky w
     grid [entry .ls.pyaxis -textvariable py ] -column 4 -row 1 -sticky w
     grid [entry .ls.pzaxis -textvariable pz ] -column 5 -row 1 -sticky w
     grid [button .ls.setpoint -text "Set" -command ChangePointSource] -column 6 -row 1 -sticky w
     proc ChangePointSource {} {
          upvar 1 px px
          upvar 1 py py
          upvar 1 pz pz
          global simfname

          if {[catch {set f [open $simfname r+]} ermsg]} {
              error "Please select tcl file first"    
          }
          set file_data [read $f]
          set lines [split $file_data "\n"]
          close $f
  
          # Change mesh file path
          set index1 [expr [lsearch -regexp $lines "###### Configure source.?"]+1]
          set index2 [expr [lsearch -regexp $lines "###### Create and configure simulation kernel.?"]-1]
          set lines [lreplace $lines $index1 $index2 " " "Point P" "P position \"$px $py $pz\"" " " " "]
    
          set f [open $simfname "w"]
          puts $f [join $lines "\n"]
          close $f      
          
     }
}



proc makeLine {} {
     grid [label .ls.linelbl1 -text "Point1:"] -column 2 -row 3 -sticky w
     grid [entry .ls.lxaxis -textvariable lx ] -column 3 -row 3 -sticky w
     grid [entry .ls.lyaxis -textvariable ly ] -column 4 -row 3 -sticky w
     grid [entry .ls.lzaxis -textvariable lz ] -column 5 -row 3 -sticky w
     grid [label .ls.linelbl2 -text "Point2:"] -column 2 -row 4 -sticky w
     grid [entry .ls.lxaxis2 -textvariable lx2 ] -column 3 -row 4 -sticky w
     grid [entry .ls.lyaxis2 -textvariable ly2 ] -column 4 -row 4 -sticky w
     grid [entry .ls.lzaxis2 -textvariable lz2 ] -column 5 -row 4 -sticky w
     grid [button .ls.setline -text "Set" -command ChangeLineSource] -column 6 -row 4 -sticky w

     proc ChangeLineSource {} {
          upvar 1 lx lx
          upvar 1 ly ly
          upvar 1 lz lz
          upvar 1 lx2 lx2
          upvar 1 ly2 ly2
          upvar 1 lz2 lz2
          global simfname

          if {[catch {set f [open $simfname r+]} ermsg]} {
              error "Please select tcl file first"    
          }
          set file_data [read $f]
          set lines [split $file_data "\n"]
          close $f
  
          # Change mesh file path
          set index1 [expr [lsearch -regexp $lines "###### Configure source.?"]+1]
          set index2 [expr [lsearch -regexp $lines "###### Create and configure simulation kernel.?"]-1]
          set lines [lreplace $lines $index1 $index2 " " "Line P" "P endpoint 0 \"$lx $ly $lz\"" "P endpoint 1 \"$lx2 $ly2 $lz2\"" " " " "]
    
          set f [open $simfname "w"]
          puts $f [join $lines "\n"]
          close $f      
          
     }
}


proc makePencil {} {
     grid [label .ls.pblbl -text "Point:"] -column 2 -row 6 -sticky w
     grid [entry .ls.pbxaxis -textvariable pbx ] -column 3 -row 6 -sticky w
     grid [entry .ls.pbyaxis -textvariable pby ] -column 4 -row 6 -sticky w
     grid [entry .ls.pbzaxis -textvariable pbz ] -column 5 -row 6 -sticky w
     grid [label .ls.pblbl2 -text "Direction:"] -column 2 -row 7 -sticky w
     grid [entry .ls.pbxaxis2 -textvariable pbx2 ] -column 3 -row 7 -sticky w
     grid [entry .ls.pbyaxis2 -textvariable pby2 ] -column 4 -row 7 -sticky w
     grid [entry .ls.pbzaxis2 -textvariable pbz2 ] -column 5 -row 7 -sticky w
     grid [button .ls.setpb -text "Set" -command ChangePencilBeamSource] -column 6 -row 7 -sticky w

     proc ChangePencilBeamSource {} {
          upvar 1 pbx pbx
          upvar 1 pby pby
          upvar 1 pbz pbz
          upvar 1 pbx2 pbx2
          upvar 1 pby2 pby2
          upvar 1 pbz2 pbz2
          global simfname

          if {[catch {set f [open $simfname r+]} ermsg]} {
              error "Please select tcl file first"    
          }
          set file_data [read $f]
          set lines [split $file_data "\n"]
          close $f
  
          # Change mesh file path
          set index1 [expr [lsearch -regexp $lines "###### Configure source.?"]+1]
          set index2 [expr [lsearch -regexp $lines "###### Create and configure simulation kernel.?"]-1]
          set lines [lreplace $lines $index1 $index2 " " "PencilBeam P 1.0 \"$pbx $pby $pbz\" \"$pbx2 $pby2 $pbz2\"" " " " "]
    
          set f [open $simfname "w"]
          puts $f [join $lines "\n"]
          close $f      
          
     }
}





