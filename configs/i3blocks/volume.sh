#!/bin/bash

# silence    [0  -  20]
# low        [21 -  75]
# high       [76 - inf]


#pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'

VAL="$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')"

# TODO: Do this but for muted
# if [[ ! -z $(acpi | grep "Charging") ]]; then
#     icons=("" "" "" "" "")
# else
#     icons=("" "" "" "" "")
# fi

icons=("奄" "奔" "墳")

if [ $VAL -le 20 ]; then
    echo "<span color=\"#f0b40e\">${icons[0]} </span>$VAL%"
else
    if [ $VAL -le 75 ]; then
        echo "<span color=\"#f0b40e\">${icons[1]} </span>$VAL%"
    else
        echo "<span color=\"#f0b40e\">${icons[2]} </span>$VAL%"
    fi
fi