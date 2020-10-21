#!/bin/bash

# Brief: Why is this brainlet monkey installing scripts
# in an hidden folder instead of moving them to a dir 
# in the PATH var. Well that's because i want to source 
# the files, not executing them (shell global vars go brrrrrr)

# Because they're in WIP or testing
BLACKLIST=("auto_firewall.sh")

SCRIPTS=~/.scripts/

# temporary var containing scripts call string 
INSTANCE=$'[ -d "$HOME/.scripts" ] && for s in $HOME/.scripts/*; do [ ! -d $s ] && source $s ; done'

# if string 'INSTANCE' is in bashrc then no need to append it
if ! grep -Fxq "$INSTANCE" ~/.bashrc; then
    echo "$INSTANCE" >> ~/.bashrc
    echo "Not found Instance in .bashrc"
fi

[ ! -d "$SCRIPTS" ] && mkdir $SCRIPTS && echo "Created $SCRIPTS"

# Copy all scripts to default scripts folder
cp -rf scripts/* $SCRIPTS

# Remove blacklist scripts
for file in $BLACKLIST; do
    rm $SCRIPTS/$file
done

echo "Installed scripts on $SCRIPTS"

for i in "$@"; do
    case $i in
        --help)
            usage
            shift
            ;;
        *)
            echo "flag provided but not defined: ${i%%=*}"
            echo "See '$0 --help'."
            exit 0
        ;;
    esac
done

