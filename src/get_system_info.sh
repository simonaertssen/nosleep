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
	local battery_level=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
	echo "$battery_level"
}

is_external_display_connected() {
	local external_display=false
	if [[ $(system_profiler SPDisplaysDataType | grep -c Resolution) -gt 1 ]]
	then
		external_display=true
	fi
	echo "$external_display"
}

is_lid_closed() {
	local lid_closed=true
	OUTPUT=$(ioreg -r -k AppleClamshellState | grep '"AppleClamshellState"' | cut -f2 -d"=")
	if [[ "$OUTPUT" == " No" ]]
	then
		lid_closed=false
	fi
	echo "$lid_closed"
}

is_external_keyboard_connected() {
	local external_keyboard=false
	OUTPUT=$(ioreg -p IOUSB -w0 | sed 's/[^o]*o //; s/@.*$//' | grep -v '^Root.*' | grep -c 'USB Receiver')
	if [[ "$OUTPUT" -gt 0 ]]
	then
		external_keyboard=true
	fi
	echo "$external_keyboard"
}


