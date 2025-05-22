#!/bin/bash

echo "Day 2 Shell Scripting challenge where it will do file and directories challenges."


<<note
ls : is for 'listing' all file and dir's
-l : long listing (that show's detail information like permission, owner, size and etc)
-a : shows 'all' files including hidden files
-r : it will sort in 'Reverse' order
-t : sort by 'modification time', newest first
-h : human readble file size like KB, MB, GB and etc.
note

#task 1 : print all files and dir's in curr path
	
echo "File's and directories in current path with detail information."
ls -larth

while true; do

	# task 2 : get input(string) from user and print how many character's in the input 
	read -p "Enter a line of text (press ENTER without any text to 'EXIT') : " input

	if [ -z "$input" ]; then
		echo "Exiting the Interactive exlorer, Goodbye!!"
		break
	fi

	# calculate and print the character's count for the input line
	char_count=$(echo -n "$input" | wc -m)
	echo "Character Count $char_count"

done


