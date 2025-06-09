#!/bin/bash

# function to check if the specified process is running
function is_process_running() {
	if pgrep -x "$1" >/dev/null;
	then
		return 0;
	else
		return 1
	fi
}


# function to reatart process using systemctl
function restart_process() {
	local process_name="$1"
	echo "process $process_name is not running , Attempting to restart...."

	# check if user have the privilage to restart the process
	if sudo systemctl restart "$process_name"; 
	then 
		echo "Process $process_name restarted successfully."
	else 
		echo "Failed to restart $process_name. please check th process manually."
	fi

}

#checking argument passes or not.
if [ $# -eq 0 ];
then
	echo "Usage: $0 <process_name>"
    	exit 1
fi


process_name=$1
max_attempts=3
attempt=0

while [ $attempt -le $max_attemps ];
do
	if is_process_running "$process_name";
	then
		echo "Process $process_name is running."
	else
		restart_process "$procss_name"
	fi

	attempt=$((attempt + 1))
	sleep 5 #wait for 5 seconds before the next check
done

echo "Maximum restart attempts reached. Please check the process manually."







