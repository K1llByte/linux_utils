#!/bin/bash

# gitall <message>    \ Adds, commits and pushes all changes with and optional commit message 
# setwall path/to/img \ Sets i3 wallpaper
# mkfile path/to/file \ Creates necessary folders and then creates a file
# battery             \ Prints battery percentage
# screenshot

function gitall 
{
    # Dependes on 'git'
    if [ ! -z "$1" ]; then
        git add .; git commit -m "$1"; git push
    else
        git add .; git commit -m "General commit"; git push
    fi
}

function setwall
{
    # Dependes on 'i3'
    if [ ! -z "$1" ]; then
        cp $1 ~/.config/i3/wallpaper
        i3-msg -q restart
    else
		echo "error: setwall [img_path]"
	fi
}

function mkfile
{
    if [ -z $1 ]; then
        echo "error: mkfile [file_path]"
    else
		mkdir -p "$(dirname "$1")" && touch "$1"
	fi
}

function battery
{
    # TODO: argument to check specific battery level
    local BATTERIES=$(ls /sys/class/power_supply/BAT*/capacity)
    cat $BATTERIES | awk -v n=$(wc -w $BATTERIES | awk '{n=$1} END {print n}') '{s+=$1} END {printf "%.0f%\n", s/n}'
}

function screenshot
{
    # Dependes on 'maim'
    [ ! -z $1 ] && [ "$1" == "-s" ] 
    local FILENAME="$(date +%s).png"
    maim $1 ~/Pictures/Screenshots/$FILENAME && \
    cat ~/Pictures/Screenshots/$FILENAME | xclip -selection clipboard -t image/png
}