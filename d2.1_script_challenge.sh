#!/bin/bash

<<readme

This is example of Prod ready backup rotation with cronjob 
this backup will store only last 5 days data.

usage:
./d2.1_sripting_challenge.sh <datasource_path> <backup_storing_path>

readme

data_dir=$1    # /c/Users/Lenovo/Desktop/myscripts/tws_scripts/data
backup_dir=$2 #/c/Users/Lenovo/Desktop/myscripts/tws_scripts/backup
timestamp=$(date '+%Y-%m-%d-%H:%M:%S')

function display_usage {

	echo "usage: ./d2.1_sripting_challenge.sh <datasource_path> <backup_storing_path>"
}

if [ $# -eq 0 ]; then 
	display_usage
fi


function create_backup {
	zip -r "${backup_dir}/backup_$timestamp.zip" "${data_dir}" > /dev/null

	if [ $? -eq 0 ]; then 
		echo "Backup generated successfully for ${timestamp}"
	else
       		echo "Error: Failed to create backup."
    	fi
}

function perform_rotation {
	backups=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))
	
	if [ ${#backups[@]} -ge 5 ]; then
		echo "perform rotation for 5 day's"
		
		backups_to_remove=("${backups[@]:5}")

		for backup in "${backups_to_remove[@]}"; 
		do
			rm -f ${backup}
		done	

	fi
	
}


# Do the CronJob in Ubuntu or linux version after pulled this file.
# use crontab -e command
# choose vim editor.

create_backup
perform_rotation
