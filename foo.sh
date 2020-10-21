#!/bin/bash

# Default argument parsing cycle
while [ "$#" -gt 0 ]
do
    case "$1" in

    "--help")
        echo "Usage:
        "
    ;;

    *)
        echo "$arg"
    ;;
    
    esac
    exit 1
done