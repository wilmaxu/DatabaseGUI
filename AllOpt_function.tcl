package require Tk

# Update the optical propertires displayed in the window. This function is called everytime when "search" is clicked
proc UpdateAllOpt {} {
    # Clear the previous display, otherwise the new output will be added to the old display
    ClearAllDisplay
    # QualifiedOpt carries the data obtained after "search" is clicked
    global QualifiedOpt
    # count is used to iterate elements is the QualifiedOpt list
    set count 1
    foreach i $QualifiedOpt {
        global w$count
        global a$count
        global s$count
        global ss$count
        global g$count
        global n$count
        global r$count  
        set w$count [lindex [regexp -all -inline {\S+} $i] 0]    
        set a$count [lindex [regexp -all -inline {\S+} $i] 4]
        set s$count [lindex [regexp -all -inline {\S+} $i] 5]
        set ss$count [lindex [regexp -all -inline {\S+} $i] 6]
        set g$count [lindex [regexp -all -inline {\S+} $i] 7]
        set n$count [lindex [regexp -all -inline {\S+} $i] 8]
        set r$count [lindex [regexp -all -inline {\S+} $i] 9]
        incr count
    }

}

# Clear all the content before display the updated optical properties
proc ClearAllDisplay {} {
    for {set i 1} {$i < 15} {incr i} {
        global w$i
        global a$i
        global s$i
        global ss$i
        global g$i
        global n$i
        global r$i
        set w$i ""      
        set a$i ""
        set s$i ""
        set ss$i ""
        set g$i ""
        set n$i ""
        set r$i ""
    }

}
