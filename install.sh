#!/bin/bash

SCRIPTS=~/.scripts/

# temporary var containing scripts call string 
INSTANCE=$'for s in $HOME/.scripts/*; do [ ! -d $s ] && source $s ; done'

# if string 'INSTANCE' is in bashrc then no need to append it
if ! grep -Fxq "$INSTANCE" ~/.bashrc; then
    echo "$INSTANCE" >> ~/.bashrc
fi

# copy all scripts to default scripts folder
\cp -rf scripts/* $SCRIPTS

echo "Installed scripts on $SCRIPTS"

unset INSTANCE