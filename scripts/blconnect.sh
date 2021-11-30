#!/bin/sh

set -euC

connect() {
	local mac=$(echo "$1" | cut -d ' ' -f2)

	# Otherwise audio devices can't connect; usually started on the first audio
	# application, but this may not have happened yet.
	pulseaudio --start
	echo 'power on'     | bluetoothctl
	echo "connect $mac" | bluetoothctl
}

devs=$(echo 'devices' | bluetoothctl | grep '^Device')

IFS="
"

if [ -n "${1:-}" ]; then
	for dev in $(echo "$devs"); do
		if echo "$dev" | grep -iq "$1$"; then
			connect "$dev"
			break
		fi
	done
	exit 0
fi

i=0
for dev in $(echo "$devs" | cut -d ' ' -f3-); do
	echo "$(( i=i+1 )) $dev"
done

printf "Which? "
read n
connect $(echo "$devs" | sed "${n}p;d")