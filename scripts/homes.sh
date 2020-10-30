#!/bin/bash

# sethome [tag] \ Sets current directory as a home identified by the tag
# delhome [tag] \ Deletes a home by the tag
# home [tag]	\ Go to a home identified by the tag 
# homes	        \ Lists all homes avaiable
# work [tag]	\ Open vscode editor with the specified home


# File Format 
# 'tag path/to/dir'
HOMES=~/.config/homes/config

# Create Homes file if not exists
[ ! -f "$HOMES" ] &&        \
mkdir -p ~/.config/homes && \
touch $HOMES

function sethome
{
    if [ ! -z "$1" ]; then

        #[[ ! -e $HOMES ]] && touch $HOMES
        
        # Check if home tag exists
        [ $(cat $HOMES | awk -v key="$1" '{ if($1 == key) print $1 }') ] && \
        echo "Home already exists" && return

        DIR=$(pwd)

        [ -f "$2" ] && DIR=$(realpath $(dirname $2))
        [ -d "$2" ] && DIR=$(realpath $2)
        echo "$1 $DIR" >> $HOMES
        echo "Home set: $DIR"

    else
        >&2 echo "error: sethome [tag] <[dir]>"
    fi
}

function homes
{
    if [ ! -e $HOMES ] || [ ! -s $HOMES ]; then
        >&2 echo "error: no homes avaiable :("
        return;
    fi

    case "$1" in

    "-f" | "--full") # List homes and paths
        cat $HOMES
    ;;

    "") # List homes
        cat $HOMES | awk '{print $1}'
    ;;

    *) # Find home by name
        cat $HOMES | grep -i "^${1}.*$"
    ;;
    esac
}

function home
{
    if [ -z "$1" ]; then
        >&2 echo "error: home [tag]"
        return
    fi

    local VAL=$(cat $HOMES | awk -v key="$1" '{ if($1 == key) print $2 }')
    if [ $VAL ]; then
        cd $VAL
    else
        >&2 echo "error: home not found"
    fi
    
}

function delhome
{
    if [ -z "$1" ]; then
        >&2 echo "error: delhome [tag]"
    else
        sed -i "/$1 /d" $HOMES
    fi
}

function work
{
    if [ -z "$1" ]; then
        >&2 echo "error: work [tag]"
        return
    fi

    local VAL=$(cat $HOMES | awk -v key="$1" '{ if($1 == key) print $2 }')
    if [ $VAL ]; then
        code $VAL
    else
        >&2 echo "error: home not found"
    fi
}