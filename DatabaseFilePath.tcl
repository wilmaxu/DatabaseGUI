package require Tk

# To get the directory of where DataBase GUI is installed
set myMainLocation [file normalize [info script DatabaseFilePath.tcl]]
set FnameLength [string length [file native DatabaseFilePath.tcl]]
set PathLength [string length $myMainLocation]
set difference [expr $PathLength - $FnameLength]
set myMainLocationPath [string range $myMainLocation 0 $difference-1]

set optfilename data.txt
set spectrumfilename AbsorptionSpectrum.txt

set OpticalDataPath  $myMainLocationPath$optfilename

set AbsorptionSpectrumPath $myMainLocationPath$spectrumfilename




