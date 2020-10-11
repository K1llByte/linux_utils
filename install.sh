#!/bin/bash

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
cp -rf scripts/* $SCRIPTS && echo "Installed scripts on $SCRIPTS"

unset INSTANCE