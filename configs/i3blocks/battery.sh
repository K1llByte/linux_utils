#!/bin/bash

# empty          [0  -  10]
# quarter        [11 -  25]
# half           [26 -  50]
# three quarters [51 -  75]
# full           [76 - 100]


VAL="$(BATTERIES=$(ls /sys/class/power_supply/BAT*/capacity); cat $BATTERIES | awk -v n=$(wc -w $BATTERIES | awk '{n=$1} END {print n}') '{s+=$1} END {printf "%.0f\n", s/n}' ; unset BATTERIES)"
if [[ ! -z $(acpi | grep "Charging") ]]; then
    icons=("" "" "" "" "")
else
    icons=("" "" "" "" "")
fi

if [ $VAL -le 10 ]; then
    echo "<span color=\"#E53935\">${icons[0]} </span>$VAL%"
else
    if [ $VAL -le 25 ]; then
        echo "<span color=\"#f0b40e\">${icons[1]} </span>$VAL%"
    else
        if [ $VAL -le 50 ]; then
            echo "<span color=\"#f0b40e\">${icons[2]} </span>$VAL%"
        else
            if [ $VAL -le 75 ]; then
                echo "<span color=\"#f0b40e\">${icons[3]} </span>$VAL%"
            else
                echo "<span color=\"#f0b40e\">${icons[4]} </span>$VAL%"
            fi
        fi
    fi
fi