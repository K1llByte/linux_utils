#!/usr/bin/env bash

launch_bar() {
    # Terminate already running bar instances
    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


    # Launch the bar
    if type "xrandr"; then
        # Lauch a bar for each monitor
        for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
            MONITOR=$m polybar -q main -c "$HOME/.config/polybar/shades/config.ini" &
        done
    else
        # If xrandr command doesn't exist just launch default bar
        polybar -q main -c "$HOME/.config/polybar/shades/config.ini" &
    fi
}

launch_bar