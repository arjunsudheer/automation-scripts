# run_set_up_files_and_directories.sh

## Overview
The run_set_up_files_and_directories.sh file is in charge of running set_up_files_and_directories.sh when the user wants to run a command from set_up_files_and_directories.sh. This file will not be used for an automated call for set_up_files_and_directories.sh.

**Required File Parameters:** None

## chooseFunction() 
**Parameters:** None

* Prints the available functions within set_up_files_and_directories.sh to run 

* Asks the user what function they want to run 

* Runs the appropriate function 

* Makes a recursive call for the user to keep running functions until they exit the script or go back to the previous step