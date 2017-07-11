package require Tk





proc search {} {
   global wavelength
   global organ
   global species
   global status
   global uncertainty
 
   set ResultList [UpdateData $wavelength $uncertainty $organ $status $species]
   set ::avg_a [format "%-6.3f" [lindex $ResultList 0]]
   set ::avg_s [format "%-6.3f" [lindex $ResultList 1]]
   set ::avg_g [format "%-6.3f" [lindex $ResultList 2]]
   set ::avg_n [format "%-6.3f" [lindex $ResultList 3]]

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

  set no_wavelength 0
  set no_organ 0
  set no_status 0
  set no_species 0

  foreach i $AllInfo {
     if [WithinRange [lindex [split $i ,] 0]] {
         lappend ListWavelength $i
         incr no_wavelength
     } 

  }




  if [expr {$no_wavelength != 0}] {      
      foreach i $ListWavelength { 
         if [expr {$o == [lindex [split $i ,] 1]}] {
             lappend ListOrgan $i
             incr no_organ
         } 
      }
  }



  if [expr {$no_organ != 0}] { 
    foreach i $ListOrgan {
        if [expr {$st == [lindex [split $i ,] 2]}] {
             lappend ListStatus $i
             incr no_status
        } elseif [expr {$st == "none"}] {
             lappend ListStatus $i
             incr no_status
        }
     }
   }


  if [expr {$no_status != 0}] { 
      foreach i $ListStatus {
         if [expr {$sp == [lindex [split $i ,] 3]}] {
             lappend ListSpecies $i
             incr no_species
         } elseif [expr {$sp == "none"}] {
             lappend ListSpecies $i
             incr no_species
         }
      }
  }
  

  
  if [expr {$no_species != 0}] { 
      foreach i $ListSpecies {
         lappend LMuA [lindex [split $i /] 1]
         lappend LMuS [lindex [split $i /] 2]
         lappend LG [lindex [split $i /] 3]
         lappend LN [lindex [split $i /] 4] 
      }
   } else {
       lappend LMuA 0
       lappend LMuS 0
       lappend LG 0
       lappend LN 0 
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


proc generate {} {
    global fname
    set f [open $fname w]
    puts $f 1
    close $f



}



proc AddOpt {} {
   global fname
   global avg_a
   global avg_s
   global avg_g
   global avg_n

   set f [open $fname a]
   puts $f "$avg_a $avg_s $avg_g $avg_n"
   close $f
  
}

proc SetOrgan {} {
    global norgan
    global fname
    set f [open $fname a]
    puts $f $norgan
    close $f
}

proc FinishOpt {} {
    global fname
    set f [open $fname a]
    puts $f 1
    puts $f 1.0
    close $f 

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
    set count [expr {$count + 1}]
  }

  return [expr {$sumall / $count}]
}

