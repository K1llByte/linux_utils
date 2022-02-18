#!/usr/bin/env bash

# empty          [0  -  10]
# quarter        [11 -  25]
# half           [26 -  50]
# three quarters [51 -  75]
# full           [76 - 100]

VAL="$(BATTERIES=$(ls /sys/class/power_supply/BAT*/capacity); cat $BATTERIES | awk -v n=$(wc -w $BATTERIES | awk '{n=$1} END {print n}') '{s+=$1} END {printf "%.0f\n", s/n}' ; unset BATTERIES)"

STATUS_BAT0=$(cat /sys/class/power_supply/BAT0/status)
STATUS_BAT1=$(cat /sys/class/power_supply/BAT1/status)

if [[ $STATUS_BAT0 == "Charging" ]] || [[ $STATUS_BAT1 == "Charging" ]]; then
    icons=("" "" "" "" "")
else
    icons=("" "" "" "" "")
fi

if [ $VAL -le 10 ]; then
    echo "${icons[0]} $VAL%"
else
    if [ $VAL -le 25 ]; then
        echo "${icons[1]} $VAL%"
    else
        if [ $VAL -le 50 ]; then
            echo "${icons[2]} $VAL%"
        else
            if [ $VAL -le 75 ]; then
                echo "${icons[3]} $VAL%"
            else
                echo "${icons[4]} $VAL%"
            fi
        fi
    fi
fi