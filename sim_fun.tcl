package require Tk


proc OpenOpt {} {
    global optfname
    global simfname

    set file [tk_getOpenFile -parent .]
    set optfname $file

    set f [open $simfname r+]
    set file_data [read $f]
    set lines [split $file_data "\n"]
    close $f
  
    # Find the insertion index in the reversed list
    set idx [lsearch [lreverse $lines] "#optfn"] 
    set lines [linsert $lines end-$idx "set optfn \"$optfname\""]
    
    set f [open $simfname "w"]
    puts $f [join $lines "\n"]
    close $f
}




proc OpenMesh {} {
    global meshfname
    global simfname

    set file [tk_getOpenFile -parent .]
    set meshfname $file

    set f [open $simfname r+]
    set file_data [read $f]
    set lines [split $file_data "\n"]
    close $f
  
    # Find the insertion index in the reversed list
    set idx [lsearch [lreverse $lines] "#meshfn"] 
    set lines [linsert $lines end-$idx "set meshfn \"$meshfname\""]
    
    set f [open $simfname "w"]
    puts $f [join $lines "\n"]
    close $f
}



proc simfile {} {
    global simfname
    set file [tk_getOpenFile -parent .]
    set simfname $file

}





proc run {} {
    global simfname
    global npackets

    set f [open $simfname r+]
    set file_data [read $f]
    set lines [split $file_data "\n"]
    close $f
  
    # Find the insertion index in the reversed list
    set target [lsearch -rege$lines ""]
    
    set f [open $simfname "w"]
    puts $f [join $lines "\n"]
    close $f
   
  
}
