package require Tk



#-----------Window settings---------------

#photos
proc SearchSpectrum {} {
  ClearAllSpectrum
  source DatabaseFilePath.tcl
  global photos
  global mylist
  set infile [open $AbsorptionSpectrumPath r+]
  set AllInfo [split [read $infile] \n] 
  set RightDrugLocation [lsearch $AllInfo $photos]
  set i 2
  if {$RightDrugLocation >= 0} {
     .spec.reftxt insert end [lindex $AllInfo [expr $RightDrugLocation + 1]] 

     while {[regexp {[0-9][0-9].} [lindex $AllInfo [expr $RightDrugLocation + $i]] match]} {
         .spec.myList insert end [lindex $AllInfo [expr $RightDrugLocation + $i]]
         incr i
     }
  }

}

proc ClearAllSpectrum {} {  
  set CountListBox [.spec.myList index end]
  .spec.myList delete 0 [expr $CountListBox - 1]
  .spec.reftxt delete 1.0 end
}
