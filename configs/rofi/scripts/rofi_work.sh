#!/usr/bin/env bash

source ~/.scripts/homes.sh

if [ "$*" ]
then
    cmd=$(work "$*")
    coproc ( $cmd > /dev/null 2>&1 )
    exit 0
fi

if [ "$@" ]; then
    # Override the previously set prompt.
    echo -en "\x00prompt\x1fChange prompt\n"
    echo "$@"
    echo "$*"
else
    homes | awk '{print $1}'
    echo "quit"
fi