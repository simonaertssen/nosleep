#!/bin/bash
source src/config.sh
source src/get_system_info.sh

# Log start of the program:
log=logs/log_file.txt
echo "$(date) Program Start" >> $log

# Trap CRTL+C to cleanup resources and reset the pmset settings to normal
trap reset_settings SIGINT
reset_settings() {
	# sudo pmset -b disablesleep 0
    # sudo pmset -b sleep $B_SLEEP
    # sudo pmset -b displaysleep 1
    echo "$(date) Program Stop" >> $log
    exit
}

# Set default here to track change over time:
lid_closed_before=false
xtrnl_display_before=false
external_keyboard_before=false

# Main event loop:
while :
do
	# Perform loop with some time off
    sleep 1

	# # Check if lid is closed:
	# lid_closed_now="$(is_lid_closed)"
	# if [ "$lid_closed_now" = false ]; then # Continue loop if lid is open
	# 	continue
	# fi
	# if [ "$lid_closed_now" == "$lid_closed_before" ]; then # Continue loop if no change occured
	# 	continue
	# fi
	# lid_closed_before=$lid_closed_now

	# echo "A change occured"

	# # Check if external display is connected
	# xtrnl_display_now="$(is_external_display_connected)"
	# if [ "$xtrnl_display_now" = false ]; then # Continue if there is no second display
	# 	continue
	# fi
	# if [ "$xtrnl_display_now" == "$xtrnl_display_before" ]; then # Continue if no change occured
	# 	continue
	# fi
	# xtrnl_display_before=$xtrnl_display_now

	# echo "A change occured"

	# Check if external keyboard is present:
	external_keyboard_now="$(is_external_keyboard_connected)"
	if [ "$external_keyboard_now" = false ]; then # No keyboard: native keys
		continue
	fi
	if [ "$external_keyboard_now" == "$external_keyboard_before" ]; then # Keyboard: use 'Brits - PC' 
		continue
	fi
	external_keyboard_before=$external_keyboard_now

done
