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

function setalias
{
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "error: setalias [name] [command]"
        return
    fi

    tmp="alias $1=\"$2\""
    if ! grep -Fxq "$tmp" $ALIASES; then

        echo "$tmp" >> $ALIASES

        alias $1="$2"
    else
        echo "error: alias already exists"
    fi
}

function delalias
{
    if [ -z $1 ]; then
        echo "error: delalias [name]"
        return
    fi
    sed -i "/alias $1=\".*\"/d" $ALIASES
    unalias $1
}

function aliases
{
    if [ -z $1]; then
        cat $ALIASES | awk '{print $2}' | cut -d'=' -f 1
    else
        # TODO: show alias command
        return
    fi
}