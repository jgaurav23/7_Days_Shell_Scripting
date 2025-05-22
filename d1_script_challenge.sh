#!/bin/bash

# task 1 : commenting (print comment in file)


echo ""
# task 2 : printing the first line
echo "Second task"


echo ""
# task 3 : variables
name="gaurav"

echo ""
# task 4 : using variable's in echo 
echo "Hello this is $name"

echo ""
# task 5 : add note or declaration in file that does not viible at the time of file execution
<<note 
this is note/comment that don't visible 
at the time you run this file
note

# task 6 : using built in variable's
echo ""
timestamp=$(date '+%Y-%m-%d')
echo $timestamp
echo "My current bash path - $BASH"
echo "Bash version i am using - $BASH_VERSION"
echo "PID of bash i am using - $$"
echo "My home directory - $HOME"
echo "where i am currently? - $PWD"
echo "My Hostname - $HOSTNAME"

# task 7 : wildcards
echo ""
echo "Files with .sh Extension in curren directory"

ls *.sh
# above line wll print the all file that end's with '.sh'





# don't forget to give execution permission to the file, with folowing command
# chmod +x file_name.sh
