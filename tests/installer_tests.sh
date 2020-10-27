#!/bin/bash

CONFIGS="to/" #"$HOME/.config/"

[ ! -d $CONFIGS ] && mkdir "$CONFIGS"

usage()
{
    echo "Usage: install [configs]"
}


install_specific_configs()
{
    for item in $(awk '/[ ]*#.*/{} /[ ]*[^:]*:[ ]*.+[ ]+.*/{ print $3 }' configs_tests.txt); do
        [ "${item: -1}" = "/" ] && mkdir -p "$item" || mkdir -p "$(dirname $item)"
    done
    eval "$(awk '/[ ]*#.*/{} /[ ]*[^:]*:[ ]*.+[ ]+.*/{ print "cp -rfv",$2,$3 }' configs_tests.txt)"

}


[ "$#" == 0 ] && usage
while [ "$#" -gt 0 ]
do
    case "$1" in

    "--help" | "")
        usage
    ;;

    configs)
        install_specific_configs
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