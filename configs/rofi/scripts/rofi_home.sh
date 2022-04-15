#!/usr/bin/env bash

source ~/.scripts/homes.sh

if [ "$*" ]
then
    
    # $0~h in awk will match the contents of the variable 'h'
    # homes -f | awk -v h="$*" '$0~h{ print $2 }'; Will fetch the
    # corresponding path for the home tag
    tag_path=$(homes -f | awk -v h="$*" '$0~h{ print $2 }')
    coproc ( xdg-open $tag_path > /dev/null 2>&1 )
    exit 0
fi
# xdg-mime default Thunar.desktop inode/directory

if [ "$@" ]
then
    # Override the previously set prompt.
    echo -en "\x00prompt\x1fChange prompt\n"
    echo "$@"
    echo "$*"
else
    # List homes names in rofi
    homes | awk '{print $1}'
    echo "quit"
fi