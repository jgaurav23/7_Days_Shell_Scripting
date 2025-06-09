#!/bin/bash

# function to display system matrics (CPU, memory & disk space)

function view_system_matrics() {
	echo "------System Matrics-------"
	
	# fetch CPU usage using `top` command and extract value using awk command.
	cpu_usage=$( top -bn 1 | grep '%cpu' | awk '{print $2}' )

	# fetch memory usage using 'free' command and extract the value using awk
	mem_usage=$( free | grep Mem | awk '{ print("%.1f", $3/$2 * 100}' )

	#fetch disk space usage using  'df' command and extract the value using awk
	disk_usage-$( df -h | tail -1 | awk '{print 5}')

	echo "CPU Usage: $cpu_usage%  Mem Usage: $mem_usage  Disk Space: $disk_usage"
	
}


function monitor_service() {

	echo "----- Monitor Specific Service -----"
	read -p "Enter the service name to monitor:" service_name
	
	# check if service running using systemctl command.
	if systemctl is-active --quite $service_name;
	then
		echo "$service_name is running."

	else 
		echo "$service_name is not running"
		read -p "Do You want to start the $service_name? (Y/N): " choice
		if ["$choice" = "Y" ] || [ "$choice" = "y"];
		then 
			# start a service using 'systemctl' command
			systemctl start $service_name
			echo "Service started succesfully."
		fi
	fi

}

# Main loop for continues monitoring

while true;
do
	echo "----- Monitor matrics script -----"
	echo "1. View System Matrics"
	echo "2. Monitor a specific service"
	echo "3. Exit"

	read -p "Enter Your choice (1, 2, 3 ): " choice

	case $choice in 
		1) 
			view_system_matrics
			;;
		2) 
			monitor_service
			;;
		3) 
			echo "Exiting the script. Goodbye!!"
			exit 0
			;;
		*)
			echo "erro: This is not a valid option, Options are (1, 2, 3.)"
			;;
	esac

	# sleep for 5 minutes before dispalying the menu again.
	sleep 5

done

