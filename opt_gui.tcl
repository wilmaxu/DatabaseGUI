package require Tk

wm title . "Optical Properties"
grid [ttk::frame .c -padding "4 4 12 12"] -column 0 -row 0 -sticky nwes
grid columnconfigure . 0 -weight 1; grid rowconfigure . 0 -weight 1

grid [ttk::label .c.wavelbl -text "Wavelength(nm)"] -column 1 -row 1 -sticky w
grid [ttk::label .c.orglbl -text "organ"] -column 1 -row 2 -sticky w
grid [ttk::label .c.spelbl -text "species"] -column 1 -row 3 -sticky w

grid [ttk::combobox .c.wlval -values [list 100 200 300 400 500] -textvariable wavelength] -column 2 -row 1 -sticky w
grid [ttk::combobox .c.organval -values [list "Brain" "Bladder" "liver" "Fat"] -textvariable organ] -column 2 -row 2 -sticky w
grid [ttk::combobox .c.speciesval -values [list "Human" "Rat" "Rabbit" "Pig" None] -textvariable species] -column 2 -row 3 -sticky w


grid [ttk::label .c.uclbl -text "uncertainty"] -column 3 -row 1 -sticky w
grid [ttk::label .c.sttlbl -text "status"] -column 3 -row 2 -sticky w

grid [ttk::combobox .c.ucval -values [list 5 10 15 20 25 None] -textvariable uncertainty] -column 4 -row 1 -sticky w
grid [ttk::combobox .c.sttval -values [list Healthy Tumor None] -textvariable status] -column 4 -row 2 -sticky w



grid [ttk::button .c.search -text "Search" -command search] -column 4 -row 4 -sticky e




grid [ttk::label .c.albl -text "mu_a"] -column 2 -row 7 -sticky w
grid [ttk::label .c.slbl -text "mu_s"] -column 3 -row 7 -sticky w
grid [ttk::label .c.glbl -text "g"] -column 4 -row 7 -sticky w
grid [ttk::label .c.nlbl -text "n"] -column 5 -row 7 -sticky w

grid [ttk::label .c.avglbl -text "Average"] -column 1 -row 8 -sticky w
grid [ttk::label .c.minlbl -text "Min"] -column 1 -row 9 -sticky w
grid [ttk::label .c.maxlbl -text "Max"] -column 1 -row 10 -sticky w
grid [ttk::label .c.sourcelbl -text "Source"] -column 1 -row 12 -sticky w

grid [ttk::label .c.avg_a -textvariable avg_a] -column 2 -row 8 -sticky we
grid [ttk::label .c.avg_s -textvariable avg_s] -column 3 -row 8 -sticky we
grid [ttk::label .c.avg_g -textvariable avg_g] -column 4 -row 8 -sticky we
grid [ttk::label .c.avg_n -textvariable avg_n] -column 5 -row 8 -sticky we

grid [ttk::label .c.min_a -textvariable min_a] -column 2 -row 9 -sticky we
grid [ttk::label .c.min_s -textvariable min_s] -column 3 -row 9 -sticky we
grid [ttk::label .c.min_g -textvariable min_g] -column 4 -row 9 -sticky we
grid [ttk::label .c.min_n -textvariable min_n] -column 5 -row 9 -sticky we

grid [ttk::label .c.max_a -textvariable max_a] -column 2 -row 10 -sticky we
grid [ttk::label .c.max_s -textvariable max_s] -column 3 -row 10 -sticky we
grid [ttk::label .c.max_g -textvariable max_g] -column 4 -row 10 -sticky we
grid [ttk::label .c.max_n -textvariable max_n] -column 5 -row 10 -sticky we

grid [ttk::label .c.source -textvariable source] -column 2 -row 12 -sticky we


#-------

#-------

proc search {} {
   global wavelength
   global organ
   global species
   global status
   global uncertainty

 
   set ResultList [UpdateData wavelength uncertainty organ status species]
   set ::avg_a [lindex $ResultList 0]
   set ::avg_s [lindex $ResultList 1]
   set ::avg_g [lindex $ResultList 2]
   set ::avg_n [lindex $ResultList 3]

   set ::min_a [lindex $ResultList 4]
   set ::min_s [lindex $ResultList 5]
   set ::min_g [lindex $ResultList 6]
   set ::min_n [lindex $ResultList 7]

   set ::max_a [lindex $ResultList 8]
   set ::max_s [lindex $ResultList 9]
   set ::max_g [lindex $ResultList 10]
   set ::max_n [lindex $ResultList 11]

   set ::source "www.path_to_source.com"
  
}



#==================================
proc UpdateData {w u o st sp} {
 
  set infile [open "data.txt" r+]
  set AllInfo [split [read $infile] ;] 


  set LWavelength []
  set LOrgan []
  set LStatus []
  set LSpecies []
  upvar $LWavelength ListWavelength 
  upvar $LOrgan ListOrgan
  upvar $LStatus ListStatus
  upvar $LSpecies ListSpecies



  foreach i $AllInfo {
     if [WithinRange [lindex [split $i ,] 0]] {
         lappend ListWavelength $i
     } 
  }
   
  foreach i $ListWavelength {   
     if [expr {$o == [lindex [split $i ,] 1]}] {
         lappend ListOrgan $i
     } 
  }


  foreach i $ListOrgan {
     if [expr {$st == [lindex [split $i ,] 2]}] {
         lappend ListStatus $i
     } 
  }


  foreach i $ListStatus {
     if [expr {$sp == [lindex [split $i ,] 3]}] {
         lappend ListSpecies $i
     } 
  }

######################################################
  foreach i $ListSpecies {
     lappend LMuA [lindex [split $i /] 1]
     lappend LMuS [lindex [split $i /] 2]
     lappend LG [lindex [split $i /] 3]
     lappend LN [lindex [split $i /] 4] 
  }

  lappend ListOfResult [list [FindAvg $LMuA]]
  lappend ListOfResult [list [FindAvg $LMuS]]
  lappend ListOfResult [list [FindAvg $LG]]
  lappend ListOfResult [list [FindAvg $LN]]

  lappend ListOfResult [list [FindMin $LMuA]]
  lappend ListOfResult [list [FindMin $LMuS]]
  lappend ListOfResult [list [FindMin $LG]]
  lappend ListOfResult [list [FindMin $LN]]

  lappend ListOfResult [list [FindMax $LMuA]]
  lappend ListOfResult [list [FindMax $LMuS]]
  lappend ListOfResult [list [FindMax $LG]]
  lappend ListOfResult [list [FindMax $LN]]

  return $ListOfResult
  
}






#####################################################-----------Helper Functions
proc MeetLower {x} {
  global wavelength
  global uncertainty
  set Lower [list [expr {$wavelength - $uncertainty}]];
  set y [expr {$x >= $Lower}];
  return $y
}

proc MeetUpper {x} {
  global wavelength
  global uncertainty
  set Upper [expr {$wavelength + $uncertainty}];
  set y [expr {$Upper >= $x}];
  return $y
}

proc WithinRange {x} {
  set y [expr {[MeetLower $x] & [MeetUpper $x]}]
  return $y
}

proc FindMin {x} {
  set mi [lindex $x 0]
  foreach i $x {
   if [expr {$i < $mi}] {
       set mi $i
    }
  }
  return $mi
}

proc FindMax {x} {
  set ma [lindex $x 0]
  foreach i $x {
     if [expr {$i > $ma}] {
         set ma $i
     }
  }
  return $ma
}

proc FindAvg {x} {
  set sumall 0
  set count 0
  foreach i $x {
    set sumall [expr {$sumall + $i}]
    set count  [expr {$count + 1}]
  }
  
  return [expr {$sumall / $count}]
}






