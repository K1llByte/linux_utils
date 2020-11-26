#!/bin/bash

# setalias <name> "<command>" \ Registers an alias to the aliases file 
# delalias <name>             \ Deletes an alias from the aliases file
# aliases                     \ List all avaiable aliases from the alias file

# File Format 
# alias name="command"

############# DEPENDENCIES #############

source $HOME/.scripts/utils.sh

########################################

ALIASES=~/.config/aliases.sh

[ ! -f "$ALIASES" ] && mkfile $ALIASES

source $ALIASES

setalias()
{
    if [ -z "$1" ] || [ -z "$2" ]; then
        >&2 echo "error: setalias [name] [command]"
        return
    fi

    tmp="alias $1="
    # -x Option here should be unchecked since we will 
    # not match the whole line
    if ! grep -Fq "$tmp" $ALIASES; then
        echo "$tmp\"$2\"" >> $ALIASES

        eval "$tmp\"$2\""
        #alias $1="$2"
    else
        >&2 echo "error: alias already exists"
    fi
}

delalias()
{
    if [ -z $1 ]; then
        >&2 echo "error: delalias [name]"
        return
    fi
    sed -i "/alias $1=\".*\"/d" $ALIASES
    unalias $1
}

aliases()
{
    case "$1" in

    "-f" | "--f")
        cat $ALIASES | cut -c7- | tr = ' '2
    ;;

    "")
        cat $ALIASES | awk '{print $2}' | cut -d'=' -f 1
    ;;

    *)
        cat $ALIASES | grep -i "^alias ${1}.*$"
    ;;
    esac
}