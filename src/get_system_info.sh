#!/bin/bash

is_power_adapter_connected() {
	local power_adapter_connected=true
	if [[ $(pmset -g adapter) =~ "No adapter attached" ]]
	then
		power_adapter_connected=false
	fi

	echo "$power_adapter_connected"
}

get_battery_level() {
	echo "Checking battery level"
	local battery_level=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
	echo "$battery_level"
}

get_number_of_displays() {
	echo "Checking number of displays"
	local number_displays=$(system_profiler SPDisplaysDataType | grep -c Resolution)
	echo "$number_displays"
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
	echo "Adapter is connected"
else
	echo "Adapter is not connected"
fi

battery_level="$(get_battery_level)"
echo $battery_level

number_displays="$(get_number_of_displays)"
echo $number_displays
