#!/bin/bash

if [ ! -e $HOMES ] || [ ! -s $HOMES ]; then
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