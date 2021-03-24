#!/bin/bash

# Log start of the program:
log=logs/log_file.txt
echo "$(date) Program Start" >> $log

# Trap CRTL+C to cleanup resources and reset the pmset settings to normal
trap reset_settings SIGINT
reset_settings() {
	sudo pmset -b disablesleep 0
    sudo pmset -b sleep $B_SLEEP
    sudo pmset -b displaysleep 1
    echo "$(date) Program Stop" >> $log
    exit
}

# Main event loop:
while :
do

	# Check if in battery mode:

	# Check if external display is connected
    ((count++))
    sleep 1
done
