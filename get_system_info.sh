#!/bin/bash

is_power_adapter_connected() {
	local power_adapter_connected=true
	if [[ $(pmset -g adapter) =~ "No adapter attached" ]]
	then
		power_adapter_connected
	fi

	echo "$power_adapter_connected"
}

get_battery_level() {
	local battery_level
}

get_power_source () {
	echo "Checking power source"
	current_date=$(date)
	echo "Today is $current_date"

	OUTPUT=$(pmset -g ps)
	echo "$OUTPUT"

	local power_source
	if [[ $OUTPUT =~ "AC Power" ]]
	then
  		power_source = "a"
	elif [[ $OUTPUT =~ "Battery Power" ]]
	then
		power_source = "b"
	fi
}

power_adapter_connected="$(is_power_adapter_connected)"
if [ "$power_adapter_connected" = true ]
then
	echo "Connected"
fi
