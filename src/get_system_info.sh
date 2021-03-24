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

is_external_display_connected() {
	echo "Checking number of displays"
	local external_display=false
	if [[ $(system_profiler SPDisplaysDataType | grep -c Resolution) -gt 1 ]]
	then
		external_display=true
	fi
	echo $(system_profiler SPDisplaysDataType | grep -c Resolution)
	echo "$external_display"
}

power_adapter_connected="$(is_power_adapter_connected)"
if [ "$power_adapter_connected" == true ]; then
	echo "Connected"
else
	echo "Not connected"
fi

battery_level="$(get_battery_level)"
echo $battery_level

external_display="$(is_external_display_connected)"
if [ "$external_display" == true ]; then
	echo "External Display"
else
	echo "No External Display"
fi
