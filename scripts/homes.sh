#!/bin/bash

# sethome [tag] (path/) \ Sets current directory (or argument) as a home identified by the tag
# delhome [tag]         \ Deletes a home by the tag
# home [tag]            \ Go to a home identified by the tag 
# homes	                \ Lists all homes avaiable
# work [tag]            \ Open editor with the specified home


# File Format 
# 'tag path/to/dir'
HOMES=~/.config/homes/config

# Create Homes file if not exists
[ ! -f "$HOMES" ] &&          \
mkdir -p $(dirname $HOMES) && \
touch $HOMES

sethome()
{
    # sethome <tag>
    # sethome -f <tag>
    # sethome <tag> <path/to/dir>

    # Case arguments dont exist
    # Case tag doesn't exist
    case "$1" in
    "-f"|"--force")
        if [ $2 ]; then
            DIR=$(pwd)
            # If is file
            [ -f "$3" ] && DIR=$(realpath $(dirname $3))
            # If is directory
            [ -d "$3" ] && DIR=$(realpath $3)

            # Check if home tag exists
            if [ $(cat $HOMES | awk -F'#' -v key="$2" '{ if($1 == key) print $1 }') ]; then
                sed -i "s/$2[#].*/$2[#]$DIR/g" "$HOMES"
                echo "Home reassign: $DIR"
            else
                echo "$1#$DIR" >> $HOMES
                echo "Home set: $DIR"
            fi
        fi
        shift
    ;;
    
    "")
        >&2 echo "error: $0 [tag] <[dir]>"
    ;;

    *)
        # Check if home tag exists
        [ $(cat $HOMES | awk -F'#' -v key="$1" '{ if($1 == key) print $1 }') ] && \
        echo "Home already exists" && return

        DIR=$(pwd)

        # If is file
        [ -f "$2" ] && DIR=$(realpath $(dirname $2))
        # If is directory
        [ -d "$2" ] && DIR=$(realpath $2)
        echo "$1#$DIR" >> $HOMES
        echo "Home set: $DIR"
    ;;

    esac

    # if [ ! -z "$1" ]; then

    #     if [ "$1" -e "-f" ] || [ "$1" -e "--force" ] && [ ! -z "$2" ]; then
    #         sed -i "/$1#/d" $HOMES # Delete home
    #         shift
    #     else
    #         >&2 echo "error: $0 [tag] <[dir]>"
    #     fi

    #     # Check if home tag exists
    #     [ $(cat $HOMES | awk -F'#' -v key="$1" '{ if($1 == key) print $1 }') ] && \
    #     echo "Home already exists" && return

    #     DIR=$(pwd)

    #     # If is file
    #     [ -f "$2" ] && DIR=$(realpath $(dirname $2))
    #     # If is directory
    #     [ -d "$2" ] && DIR=$(realpath $2)
    #     echo "$1#$DIR" >> $HOMES
    #     echo "Home set: $DIR"

    # else
    #     >&2 echo "error: $0 [tag] <[dir]>"
    # fi
}

homes()
{
    # homes
    # homes -f|--full
    # homes <name>

    if [ ! -e $HOMES ] || [ ! -s $HOMES ]; then
        >&2 echo "error: no homes avaiable :("
        return;
    fi

    case "$1" in

    "-f" | "--full") # List homes and paths
        cat $HOMES | tr '#' ' '
    ;;

    "") # List homes
        cat $HOMES | awk -F'#' '{print $1}'
    ;;

    *) # Find home by name
        cat $HOMES | tr '#' ' ' | grep -i "^${1}.*$"
    ;;
    esac
}

home()
{
    # home <tag>
    
    if [ -z "$1" ]; then
        >&2 echo "error: home [tag]"
        return
    fi

    local VAL=$(cat $HOMES | awk -F'#' -v key="$1" '{ if($1 == key) print $2 }')
    if [ $VAL ]; then
        cd $VAL
    else
        >&2 echo "error: home not found"
    fi
}

delhome()
{
    if [ -z "$1" ]; then
        >&2 echo "error: delhome [tag]"
    else
        sed -i "/$1#/d" $HOMES
    fi
}

work()
{
    # work <tag>

    if [ -z "$1" ]; then
        >&2 echo "error: work [tag]"
        return
    fi

    local VAL=$(cat $HOMES | awk -F'#' -v key="$1" '{ if($1 == key) print $2 }')
    if [ $VAL ]; then
        if [ $EDITOR ]; then
            $EDITOR $VAL
        else
            >&2 echo "error: EDITOR not set"
        fi
    else
        >&2 echo "error: home not found"
    fi
}