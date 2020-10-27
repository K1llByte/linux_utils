#!/bin/bash

# home -s|set [tag] <path> \ Sets current directory as a home identified by the tag
# home -d|delete [tag]     \ Deletes a home by the tag
# home |-g|goto [tag] 	   \ Go to a home identified by the tag 
# home -l|list [tag]       \ Lists all homes avaiable
# home -w|work [tag]       \ Open vscode editor with the specified home


# File Format 
# 'tag path/to/dir'
HOMES=~/.config/homes/config

# Create file and parent folder if not exists
[ ! -f "$HOMES" ] &&        \
mkdir -p ~/.config/homes && \
touch $HOMES

usage()
{
    echo -e """
    Usage: $0 
        asdasd"""
}


function sethome
{
    if [ ! -z "$1" ]; then
        
        # Check if home tag exists
        [ $(cat $HOMES | awk -v key="$1" '{ if($1 == key) print $1 }') ] && \
        echo "Home already exists" && return 

        DIR=$(pwd)

        [ -f "$2" ] && DIR=$(realpath $(dirname $2))
        [ -d "$2" ] && DIR=$(realpath $2)
        echo "$1 $DIR" >> $HOMES
        echo "Home set: $DIR"

    else
        echo "error: sethome [tag] ([dir])"
    fi
}

function homes
{
    # Checks if file
    if [ ! -f $HOMES ] || [ ! -s $HOMES ]; then
        echo "No homes avaiable :("
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
        echo "error: home [tag]"
        return
    fi

    local VAL=$(cat $HOMES | awk -v key="$1" '{ if($1 == key) print $2 }')
    if [ $VAL ]; then
        cd $VAL
    else
        echo "error: home not found"
    fi
    
}

function delhome
{
    if [ -z "$1" ]; then	
        echo "error: delhome [tag]"
    else
        sed -i "/$1 /d" $HOMES
    fi
}

function work
{
    if [ -z "$1" ]; then
        echo "error: work [tag]"
        return
    fi

    local VAL=$(cat $HOMES | awk -v key="$1" '{ if($1 == key) print $2 }')
    if [ $VAL ]; then
        code $VAL
    else
        echo "error: home not found"
    fi
}


[ "$#" == 0 ] && usage
case $1 in 
    --help)
        usage
    ;;

    -s|set)
        shift
        sethome $@
    ;;

    -d|delete)
        shift
        delhome $@
    ;;

    -g|goto|"")
        shift
        home $@
    ;;

    -l|list)
        shift
        homes $@
    ;;

    -w|work)
        shift
        work $@
    ;;

    *)
        echo "error: Invalid subcommand $@"
    ;;
esac


# alias sethome "home set"
# alias delhome "home delete"
# alias homes "home list"
# alias home "home goto"
# alias work "home work"