#!/bin/bash

if [ ! -e $HOMES ] || [ ! -s $HOMES ]; then
    echo "No homes avaiable :("
    return;
fi

echo "1"
case "$1" in

    "-f" | "--full") # List homes and paths
    echo "1"
    cat $HOMES
    ;;
    
    "") # List homes
    echo "2"
    cat $HOMES | awk '{print $1}'
    ;;
    
    *) # Find home by name
    echo "3"
    cat $HOMES | grep -i "^${1}.*$"
    ;;
esac