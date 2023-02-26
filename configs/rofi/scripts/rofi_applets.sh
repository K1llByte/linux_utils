#!/usr/bin/env bash

# home
# work
# drun
# find
# emojis

if [ "$*" ]
then
    killall rofi
    case "$*" in
        "home")
            rofi -show home -modi "home:~/.config/rofi/scripts/rofi_home.sh"
        ;;
        "work")
            rofi -show work -modi "work:~/.config/rofi/scripts/rofi_work.sh"
        ;;
        "drun")
            rofi -show drun
        ;;
        "find")
            rofi -show find -modi "find:~/.config/rofi/scripts/rofi_finder.sh"
        ;;
        "emojis")
            rofi -show emoji
        ;;
        "bluetooth")
            rofi-bluetooth
        ;;
    esac
    # work "$*"
    exit 0
fi

if [ "$@" ]; then
    # Override the previously set prompt.
    echo -en "\x00prompt\x1fChange prompt\n"
    echo "$@"
    echo "$*"
else
    echo "home"
    echo "work"
    echo "drun"
    echo "find"
    echo "emojis"
    echo "bluetooth"
    echo "quit"
fi