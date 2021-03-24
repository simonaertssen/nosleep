#!/bin/bash
source ./src/get_system_info.sh


echo "Charger connected?"
power_adapter_connected="$(is_power_adapter_connected)"
if [ "$power_adapter_connected" = true ]; then
	echo "Yes"
else
	echo "No"
fi


echo "Checking battery level?"
battery_level="$(get_battery_level)"
echo $battery_level


echo "External display?"
external_display="$(is_external_display_connected)"
if [ "$external_display" = true ]; then
	echo "Yes"
else
	echo "No"
fi


echo "Lid closed?"
lid_closed="$(is_lid_closed)"
if [ "$lid_closed" = true ]; then
	echo "Yes"
else
	echo "No"
fi
