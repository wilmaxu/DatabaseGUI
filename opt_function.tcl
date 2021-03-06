package require Tk
source AllOpt_function.tcl


################################ Function of buttons ##############################

# Button "Show All"
proc ShowAllOpt {} {
    toplevel .aopt
    wm title .aopt "All Optical Properties"
    wm geometry .aopt 750x550
    source AllOpt_gui.tcl

}


# Button "Edit Database"
proc MakeDatabase {} {
    toplevel .db
    wm title .db "Optical Properties Database"
    wm geometry .db 400x500
    source database_gui.tcl

}

# Button "Search"
proc search {} {
   global wavelength
   global organ
   global species
   global status
   global uncertainty

   # the search engine only works when all fields have non-empty value

   if {[catch {set ResultList [UpdateData $wavelength $uncertainty $organ $status $species]}]} {
      error "Please fill in all fields"    
  }

   if {$status=="" || $species=="" || $organ==""} {
      error "Please fill in all fields"    
   }
   
   # Output the data in the ResultList. Everytime "search" is clicked, ResultList is updated by "UpdateData" function
   set ::avg_a [format "%-6.3f" [lindex $ResultList 0]]
   set ::avg_s [format "%-6.3f" [lindex $ResultList 1]]
   set ::avg_s1 [format "%-6.3f" [lindex $ResultList 2]]
   set ::avg_g [format "%-6.3f" [lindex $ResultList 3]]
   set ::avg_n [format "%-6.3f" [lindex $ResultList 4]]

   set ::min_a [format "%-6.3f" [lindex $ResultList 5]]
   set ::min_s [format "%-6.3f" [lindex $ResultList 6]]
   set ::min_s1 [format "%-6.3f" [lindex $ResultList 7]]
   set ::min_g [format "%-6.3f" [lindex $ResultList 8]]
   set ::min_n [format "%-6.3f" [lindex $ResultList 9]]

   set ::max_a [format "%-6.3f" [lindex $ResultList 10]]
   set ::max_s [format "%-6.3f" [lindex $ResultList 11]]
   set ::max_s1 [format "%-6.3f" [lindex $ResultList 12]]
   set ::max_g [format "%-6.3f" [lindex $ResultList 13]]
   set ::max_n [format "%-6.3f" [lindex $ResultList 14]]
   
   # Update the data in the window displaying all qualified optical properties
   UpdateAllOpt
}





# Button "Generate/Overwrite an opt file with name"
proc generate {} {
    global fname
    # existing file will be overwritten!!!
    if {[catch {set f [open $fname w]}]} {
       error "Please choose a name"
    }
    puts $f 1
    close $f
    # Update the window displaying the data in the opt file
    UpdateOPTWindow
}





# Button "Set number of total organs"
proc SetOrgan {} {
    global norgan
    global fname
    if {[catch {set f [open $fname a]}]} {
       error "Please create a file first"
    }

    if {$norgan == ""} {
       error "Please put a number"
    }

    puts $f $norgan
    close $f
    # Update the window displaying the data in the opt file
    UpdateOPTWindow
}




# Button "Add current property to file"
proc AddOpt {} {
   global fname
   global avg_a
   global avg_s
   global avg_s1
   global avg_g
   global avg_n

   if {[catch {set f [open $fname a]}]} {
      error "Please create a file first"
   }
   # Add the AVERAGE value of the optical property to the newly created/selected opt file
   if {[catch {puts $f "$avg_a $avg_s $avg_s1 $avg_g $avg_n"}]} {
      error "No optical property selected"
   }
   
   close $f
   # Update the window displaying the data in the opt file
   UpdateOPTWindow  
}




# Button "Delete last line"
proc DeleteOpt {} {
   global fname
   if {[catch {set f [open $fname r+]}]} {
      error "Please create a file first"
   }

   set file_data [read $f]
   close $f
   set lines [split $file_data "\n"]
   set listlength [llength $lines]
   
   for {set i 0} {$i < [expr {$listlength -2}]} {incr i} {
       lappend newline [lindex $lines $i]
   }

   set f [open $fname "w"]
   if {[catch {puts $f [join $newline "\n"]}]} {
      error "File $fname is now empty. Please click on the generate buttom again to avoid errors. You can also generate new files with different names"
   }
   
   close $f
   # Update the window displaying the data in the opt file
   UpdateOPTWindow  
}



# Button "Finish opt file"
proc FinishOpt {} {
    global fname
    if {[catch {set f [open $fname a]}]} {
       error "Please create a file first"
    }

    puts $f 1
    puts $f 1.0
    close $f 
    # Update the window displaying the data in the opt file
    UpdateOPTWindow

}

# Function to display the content in the opt file
proc UpdateOPTWindow {} {
    global fname
    global filedis
    set f [open $fname r+]
    set filedis [read $f]
    
}



################################ Helper Functions ##############################

# Search qualified data and return as a list to the "search" function
proc UpdateData {w u o st sp} {
  source DatabaseFilePath.tcl
  global QualifiedOpt
  set infile [open $OpticalDataPath r+]
  set AllInfo [split [read $infile] \n] 

  # the following parameters are used to check if no data in the database matches the searching criteria. Passing empty list to next level of searching will cause error.
  set no_wavelength 0
  set no_organ 0
  set no_status 0
  set no_species 0
  
  # Collect all data(from entire database) that match the given wavelength(range)
  foreach i $AllInfo {
     if [WithinRange [lindex [regexp -all -inline {\S+} $i] 0]] {
         lappend ListWavelength $i
         incr no_wavelength
     } 
  }

  # Collect all data(from the data list with desired wavelength) that match the given organ
  if [expr {$no_wavelength != 0}] {      
      foreach i $ListWavelength { 
         if [expr {$o == [lindex [regexp -all -inline {\S+} $i] 1]}] {
             lappend ListOrgan $i
             incr no_organ
         } 
      }
  }


  # Collect all data(from the data list with desired wavelength,organ) that match the given health status
  if [expr {$no_organ != 0}] { 
      foreach i $ListOrgan {
         if [expr {$st == [lindex [regexp -all -inline {\S+} $i] 2]}] {
             lappend ListStatus $i
             incr no_status
         } elseif [expr {$st == "none"}] {
             lappend ListStatus $i
             incr no_status
         }
      }
   }

  # Collect all data(from the data list with desired wavelength,organ,status) that match the given health species
  if [expr {$no_status != 0}] { 
      foreach i $ListStatus {
         if [expr {$sp == [lindex [regexp -all -inline {\S+} $i] 3]}] {
             lappend ListSpecies $i
             incr no_species
         } elseif [expr {$sp == "none"}] {
             lappend ListSpecies $i
             incr no_species
         }
      }
   }
  
  # Parse the qualified data list and add to each category 
  if [expr {$no_species != 0}] { 
      # When the list is not empty. i.e. there is matched data for the searching criteria
      set QualifiedOpt $ListSpecies
      # QualifiedOpt will pass the list to "All Optical Property" window
      foreach i $ListSpecies {
         lappend LMuA [lindex [regexp -all -inline {\S+} $i] 4]
         lappend LMuS [lindex [regexp -all -inline {\S+} $i] 5]
         lappend LMuS1 [lindex [regexp -all -inline {\S+} $i] 6]
         lappend LG [lindex [regexp -all -inline {\S+} $i] 7]
         lappend LN [lindex [regexp -all -inline {\S+} $i] 8] 
      }
   } else {
      # When there is no data matching the criteria, output "0" or "N/A"
      set QualifiedOpt ""
      lappend QualifiedOpt "N/A N/A N/A N/A N/A N/A N/A N/A N/A"
      lappend LMuA 0
      lappend LMuS 0
      lappend LMuS1 0
      lappend LG 0
      lappend LN 0 
   }

  # Append all data as a single list in the order: avg_a, avg_s, avg_s1,min_a, min_s, min_s1,max_a, max_s, max_s1,
  lappend ListOfResult [list [FindAvg $LMuA]]
  lappend ListOfResult [list [FindAvg $LMuS]]
  lappend ListOfResult [list [FindAvg $LMuS1]]
  lappend ListOfResult [list [FindAvg $LG]]
  lappend ListOfResult [list [FindAvg $LN]]

  lappend ListOfResult [list [FindMin $LMuA]]
  lappend ListOfResult [list [FindMin $LMuS]]
  lappend ListOfResult [list [FindMin $LMuS1]]
  lappend ListOfResult [list [FindMin $LG]]
  lappend ListOfResult [list [FindMin $LN]]

  lappend ListOfResult [list [FindMax $LMuA]]
  lappend ListOfResult [list [FindMax $LMuS]]
  lappend ListOfResult [list [FindMax $LMuS1]]
  lappend ListOfResult [list [FindMax $LG]]
  lappend ListOfResult [list [FindMax $LN]]

  return $ListOfResult
}





# Helper functions for UpdateData

proc MeetLower {x} {
  global wavelength
  global uncertainty
  # The exception here might be unecessary
  if {[catch {set Lower [list [expr {$wavelength - $uncertainty}]]} ermsg]} {
      error "Please select wavelength"    
  }
 
  set y [expr {$x >= $Lower}];
  return $y
}

proc MeetUpper {x} {
  global wavelength
  global uncertainty
  #The exception here might be unecessary
  if {[catch {set Upper [expr {$wavelength + $uncertainty}]} ermsg]} {
      error "Please select wavelength"    
  }

  set y [expr {$Upper >= $x}];
  return $y
}

proc WithinRange {x} {
  set y [expr {[MeetLower $x] & [MeetUpper $x]}]
  return $y
}

proc FindMin {x} {
  set NoneZeroList ""
  set mi 0

  foreach i $x {
     if {$i !=0} {
        lappend NoneZeroList $i
     }
  }

  if {$NoneZeroList != ""} {
     set mi [lindex $NoneZeroList 0]
     foreach i $NoneZeroList {
        if [expr {$i < $mi}] {
           set mi $i
        }
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
    if {$i != 0} {
       set sumall [expr {$sumall + $i}]
       set count [expr {$count + 1}]
    }
  }
  if {$count != 0} {
      return [expr {$sumall / $count}]
  } else {
      return 0
  }

}

