#!/bin/bash

openApps() {
    IFS=""
    local appsOptions=()
    local appsCount=0
    while read line || [ -n "$line" ]; do
        appsOptions+=($line)
        (( appsCount++ ))
    done < $automationScriptsDirectory/personal_automation_info/set_up_apps.txt
    appsOptions+=("go back")
    appsOptions+=("exit")
    
    promptUser "${appsOptions[@]}" 

    read -p "Which app would you like to open: " appChoice

    if [[ $appChoice == "go back" || $appChoice -eq $(( appsCount + 1 )) ]]; then
        return
    elif [[ $appChoice == "exit" || $appChoice -eq $(( appsCount + 2 )) ]]; then
        exit
    # if the user types a number, then map it to the appropriate app name
    elif [[ $appChoice =~ ^[+-]?[0-9]+$ ]]; then
        # check to see if the inputted number is less than or equal to fileOrDirectoryCount to make sure it is a valid option
        if [[ $appChoice -le $appsCount && $appChoice -gt 0 ]]; then
            # if the user is using MacOS, use the open command, otherwise, run the Linux command of xdg-open
            if [[ $OSTYPE == "darwin"* ]]; then
                open -a ${appsOptions[$(( $appChoice - 1 ))]}
            else
                xdg-open ${appsOptions[$(( $appChoice - 1 ))]}
            fi
        else
            echo -e "\nInvalid selection. If you want to open a new file or directory, please make sure that the name and path are added to the \"set_up_apps.txt\" file."
            echo -e "This is what your \"set_up_apps.txt\" file has right now.\n"
            cat $automationScriptsDirectory/personal_automation_info/set_up_apps.txt
            echo -e "\n"
        fi
    # if the user types the name of the app instead, then just use the app name
    else
    # if the user is using MacOS, use the open command, otherwise, run the Linux command of xdg-open
        if [[ $OSTYPE == "darwin"* ]]; then
            open -a $appChoice
        else
            xdg-open $appChoice
        fi
    fi
}

# check if the path to the current directory was passed
if [[ -z "$1" ]]; then
    echo "Error in running set_up_apps.sh."
	echo "Note: You must specify the path to the automation scripts src folder as an argument."
	exit
else    
    automationScriptsDirectory=$1
fi