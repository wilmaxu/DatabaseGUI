package require Tk

# Function to add entered optical property values into the database----- "data.txt" file. 
proc AddToDatabase {} {
  global db_wavelength
  global db_status
  global db_organ
  global db_species
  global db_a
  global db_s
  global db_s1
  global db_g
  global db_n
  global db_r
  
  # Change file name here if a different database is to be used(1/2)
  set f [open "data.txt" r+]
  set AllInfo [split [read $f] \n] 
  close $f
  
  # Change file name here if a different database is to be used(2/2)
  lappend AllInfo "$db_wavelength $db_organ $db_status $db_species $db_a $db_s $db_s1 $db_g $db_n $db_r"
  set f [open "data.txt" "w"]
  puts $f [join $AllInfo "\n"]
  close $f
}
