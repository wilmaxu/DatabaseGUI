**Computer Requirement:** 
- tcl/tk version 8.5 or higher(This is usually pre-installed in the computer. Run "tclsh" in terminal to see if tcl is installed. Then run "puts $tcl_version" to check the version of installed tcl.




**Running the user interface:**
1. Download or clone a copy of the code on this page to a local directory.
2. Enter the local directory and run "tclsh main_gui.tcl" in terminal.
3. The user interface should appear on sreen now.




**Module 1: Optical Properties**
- Choose from "Organ", "Wavelength", "Uncertainty", "Status", "Species" to search for optical properties(all criteria must not be blank)
- Click on "Show All" to view details of qualified properties(exact wavelength, reference, .etc)
- Generate opt file: extension must but .opt
- Set number of organs: must be added right after an opt file is generated.
- Add current property to file: this adds the AVERAGE value of the property shown in the window.
- Delete last line: content in the opt file is shown on the right side of the window. Modify according to needs.
- Finish opt file: Add default codes to the opt file. 

- Edit Database:The database is in a separate txt file "data.txt". You can add more optical properties to the database using this user interface. "Organ", "Status", "Species", "Wavelength" must not be blank, others(e. "mu_s") can be set to 0 if the data is missing.




**Module 2: Simulator Properties**
- Choose tcl file: this must be the first step before modifying the simulator
- Choose opt/mesh file: You can view the file path to the right of the buttons
- Number of Packets: Usually set to 10e7 or 10e8 for real application. Can set to a smaller number if just testing the simulator.
- Output file name: The extension must be .vtk
- Setup Simulator: Pass the previous settings to the tcl file




**Module 3: Source Placement**
- A tcl file must be selected in the "Simulator Properties" window before one can add any light source.



