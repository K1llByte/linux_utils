#!/bin/bash

CONFIGS="to/" #"$HOME/.config/"

[ ! -d $CONFIGS ] && mkdir "$CONFIGS"

usage()
{
    echo "Usage: install [configs]"
}


install_specific_configs()
{
    [ -z $1 ] && echo "
    i3:       from/i3/               to/
    i3blocks: from/i3blocks/         to/
    rofi:     from/rofi/             to/
    urxvt:    from/urxvt/urxvt       to/Xresources.d/urxvt
    urxvt:    from/urxvt/Xresources  to/.Xresources
    Thunar:   from/Thunar/accels.scm to/Thunar/accels.scm'
    " > /tmp/.tmp.txt
    
    
    [ ! -z $1 ] && IN_CONFIG="$1" || IN_CONFIG="/tmp/.tmp.txt"
    [ ! -z $1 ] && echo "input" || echo "no input"

    for item in $(awk '/[ ]*#.*/{} /[ ]*[^:]*:[ ]*.+[ ]+.*/{ print $3 }' $IN_CONFIG); do
        [ "${item: -1}" = "/" ] && mkdir -p "$item" || mkdir -p "$(dirname $item)"
    done
    eval "$(awk '/[ ]*#.*/{} /[ ]*[^:]*:[ ]*.+[ ]+.*/{ print "cp -rfv",$2,$3 }' $IN_CONFIG)"
}


[ "$#" == 0 ] && usage
while [ "$#" -gt 0 ]
do
    case "$1" in

    "--help" | "")
        usage
    ;;

    configs)
        install_specific_configs $2
    ;;
    
    test)
        testing 
    ;;
    
    *)
        echo "error: Tag '$1' doesn't exists"
    ;;
    
    esac
    exit 1
done

# Expected installation:
# Parse 'configs.txt' file
## File can have specific installation rules or default ones
## urxvt:    from/urxvt/Xresources  to/.Xresources
## default:  from/                  to/
# if no rule is specified nothing will happen