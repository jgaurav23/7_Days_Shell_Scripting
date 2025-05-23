#!/bin/bash

function display_usage {
echo "Usage: $0 [OPTIONS]"
echo "Options:"

echo "-c or --create : will Create a new user account."
echo "-u or --update : will update existing user's data."
echo "-l or --list   : will show all existing user's."
echo "-d or --delete : will delete existing user account."
echo "-r or --reset  : will reset the existing user's password."
echo "-h or --help   : will show the usage/functionality of current file."
}

function create_user {
	read -p "Enter A Username For New Account: " username
	
	# check if username already exits or not!
	if id $username &>/dev/null; then
		echo "Error: This $username Already exists. Please choose different username."
	else
		# get password "NOTE: "-s" is used to hide user_input."
		read -ps "Enter a Password for user $username: " password

		# create a user account
		useradd -m -p "$password" "$username"
		echo "User Account $username Created Successfully!"
	fi
}

function list_users {
	echo "All User's:"
	cat /ect/passwd | awk -F: '{ print "- " $1 "(UID: "$3 ")" }'

}

function reset_password {
	read -p "Enter a Username to reset password: " username
	
	if id "$username" &>/dev/null; 
	then
		read -s "Enter A New Password: " password
		#set new password
		echo "$username:$password" | chpasswd
		echo "password for '$username' reset successfully."
	else
		echo "Error: The Username $username not exists, please enter a valid username."
	fi
}

function delete_user {

	read -p "Enter A username To delete a user: " username
	
	#check is user is present or not
	if id "$username" &>/dev/null;
	then
		userdel -r "$username" # '-r' flag removes the user directory
		echo "User account '$username' deleted successfully."
	else
		echo "Error: The username '$username' does not exist. Please enter a valid username."
	fi

}


function update_user {

read -p "Enter a username: " username

if ! id "$username" &>/dev/null; 
then
	echo "Error: user '$username' does not exists."
	return 1
fi

echo "user $username found."

while true;
	do 
		echo ""
		echo "select the action you want to perform:"
		echo "1. change username"
		echo "2. change home directory"
		echo "3. change login shell"
		echo "4. Exit"
		read -p "Enter choice [1-4]: " choice

		case $choice in 
			1) 
				read -p "Enter a new username : " new_username
				sudo usermod -l "$new_username" "$username"
				echo "Username updated to '$new_username'"
				username="$new_username"
				;;
			2) 
				read -p "Enter a new directory path: " new_home
				sudo usermod -d "$new_home" -m "$username"
				echo "home directory updated to '$new_home'"
				;;
			3) 
				read -p "Enter new shell (e.g /bin/bash): " new_shell
				sudo usermod -s "$new_shell" "$username"
				echo "shell updated to '$new_shell'"
				;;
			4)
				echo "Existng user edit menu."
				break
				;;
			*)
                		echo "Invalid option. Please select between 1-4."
                		;;
		esac
	
	done


}



if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; 
then
	display_usage
	exit 0
fi



#command-line argument passing 
while [ $# -gt 0 ]; 
do
	case "$1" in 
		-c|--create)
			create_user
			;;
		-l|--list)
			list_users
			;;
		-u|--update)
			update_user
			;;
		-r|--reset)
			reset_password
			;;
		-d|--delete)
			delete_user
			;;
		*)
			echo "Error: invalid option '$1'. use '--help' for availabe options."
			exit 1
			;;
	esac
	shift
done
