#!/bin/bash

# gitall <message>    \ Adds, commits and pushes all changes with and optional commit message 
# setwall path/to/img \ Sets i3 wallpaper
# mkfile path/to/file \ Creates necessary folders and then creates a file
# battery             \ Prints battery percentage
# screenshot

gitall() 
{
    # Depends on 'git'
    if [ ! -z "$1" ]; then
        git add .; git commit -m "$1"; git push
    else
        git add .; git commit -m "General commit"; git push
    fi
}


setwall()
{
    # Depends on 'i3'
    if [ ! -z "$1" ]; then
        cp $1 ~/.config/i3/wallpaper
        feh --bg-fill ~/.config/i3/wallpaper
        # i3-msg -q restart
    else
        >&2 echo "error: setwall [img_path]"
    fi
}


mkfile()
{
    if [ -z $1 ]; then
        >&2 echo "error: mkfile [file_path]"
    else
        mkdir -p "$(dirname "$1")" && touch "$1"
    fi
}


battery()
{
    usage()
    {
        echo "Usage: 
        $0         Prints computer battery level
        $0 --help  Shows this message
        $0 -a      Prints all batteries level
        $0 -n      Prints number of batteries
        $0 [0-9]   Prints specific battery level"
    }

    number_of_batteries()
    {
        wc -w  $(ls /sys/class/power_supply/BAT**/capacity) | awk '{n=$1} END {print n}'
    }

    case "$1" in
    "--help")
        usage
    ;;
    
    "-a")
        cat $(ls /sys/class/power_supply/BAT**/capacity)
    ;;
    
    "-n") # Prints number of batteries
        number_of_batteries
    ;;

    "") # Prints computer battery level
        #local BATTERIES=$(ls /sys/class/power_supply/BAT*/capacity)
        cat $(ls /sys/class/power_supply/BAT**/capacity) | awk -v n=$(number_of_batteries) '{s+=$1} END {printf "%.0f%\n", s/n}'
    ;;

    *) # Prints specific battery level
        [ -z $(echo "$1" | grep -Eo "^[0-9]+$" ) ] && echo "error: invalid argument" && return 1
        [ $1 -lt $(number_of_batteries) ] && \
        echo "$(cat /sys/class/power_supply/BAT$1/capacity)%" || \
        >&2 echo "error: invalid battery number" && return 1
    ;;
    esac
}


screenshot()
{
    # Dependes on 'maim' and 'xclip'
    [ ! -z $1 ] && [ "$1" == "-s" ] 
    local FILENAME="$(date +%s).png"
    maim $1 ~/Pictures/Screenshots/$FILENAME && \
    cat ~/Pictures/Screenshots/$FILENAME | xclip -selection clipboard -t image/png
}


manual()
{
    MANUALS_DIR="$HOME/Documents/Projects/linux_utils/manuals"

    usage()
    {
        echo "Usage:
        $0            Shows this message
        $0 --help     Shows this message
        $0 -l         Prints list of manuals
        $0 <pattern>  Opens first matched manual in editor"
    }

    case "$1" in
    "--help"|"")
        # Print usage
        usage
    ;;

    "-l")
        # List all manuals
        tree -iF $MANUALS_DIR | sed '/\//d' | head -n -2
    ;;

    *)
        # Opens first matched manual in editor
        VALUE=$(tree -iF $MANUALS_DIR | sed '/\//d' | head -n -2 | grep "$1")

        if [ ! -z $VALUE ]; then
            if [ -e $VALUE ]; then
                $EDITOR "$MANUALS_DIR/$VALUE"
            else
                $EDITOR "$MANUALS_DIR/other/$VALUE"
            fi
        else
            >&2 echo "error: pattern doen't match any manual" && return 1
        fi
    ;;
    esac
}


getvol()
{
    pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'
}

setvol()
{
    usage()
    {
        echo "Usage:
        $0            Shows this message
        $0 --help     Shows this message
        $0 <volume>   Set volume level"
    }

    case "$1" in
    "--help"|"")
        # Print usage
        usage
    ;;

    *)
        VOL=$(echo $1 | grep -E "^[0-9]{1,3}$")
        if [ ! -z VOL ]; then
            pactl -- set-sink-volume @DEFAULT_SINK@ $VOL%
        else
            >&2 echo "error: invalid volume" && return 1
        fi
    ;;
    esac
}

xmaker()
{
    usage()
    {
        echo "Usage: xmaker [target]"
    }

    case "$1" in
    "--help"|"")
        # Print usage
        usage
    ;;

    *)
        XMAKE_TARGET="$1"
        shift
        xmake build $XMAKE_TARGET && \
        ./bin/$XMAKE_TARGET $@
    ;;
    esac
}