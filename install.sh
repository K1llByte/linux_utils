#!/bin/bash

# install.sh
# install.sh all
# install.sh scripts
# install.sh configs

install_scripts()
{
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

    echo "Installed scripts in $SCRIPTS"
}

install_specific_configs()
{
    [ -z $1 ] && echo "
    i3:       from/i3/               to/
    i3blocks: from/i3blocks/         to/
    rofi:     from/rofi/             to/
    urxvt:    from/urxvt/urxvt       to/Xresources.d/urxvt
    urxvt:    from/urxvt/Xresources  to/.Xresources
    Thunar:   from/Thunar/accels.scm to/Thunar/accels.scm'
    " > /tmp/.tmp.txt
    
    
    [ ! -z $1 ] && IN_CONFIG="$1" || IN_CONFIG="/tmp/.tmp.txt"
    #[ ! -z $1 ] && echo "input" || echo "no input"

    for item in $(awk '/[ ]*#.*/{} /[ ]*[^:]*:[ ]*.+[ ]+.*/{ print $3 }' $IN_CONFIG); do
        [ "${item: -1}" = "/" ] && mkdir -p "$item" || mkdir -p "$(dirname $item)"
    done
    eval "$(awk '/[ ]*#.*/{} /[ ]*[^:]*:[ ]*.+[ ]+.*/{ print "cp -rfv",$2,$3 }' $IN_CONFIG)"
}

install_configs()
{
    CONFIGS=~/.config/
    #eval "$(awk '/[ ]*#.*/{} /[^:]*:[ ]+[^ ]+[ ]+[^ ]+/{print "cp -r",$2,$3,"&& echo \"Installed ",$2,"\" config files"}' configs_tests.txt)"
    echo "Installed configs in $CONFIGS"
}

testing()
{
    local STR="to/example/file.txt"
    local PATH_TO_CREATE=$STR
    [ -f $STR ] && PATH_TO_CREATE="$(dirname  $(realpath $STR))"
    mkdir -p $PATH_TO_CREATE
}


[ "$#" == 0 ] && install_scripts #echo "Usage: install [all|scripts|configs]"
while [ "$#" -gt 0 ]
do
    case "$1" in

    "--help" | "")
        echo "Usage: install [all|scripts|configs]"
    ;;

    all)
        install_scripts
        install_configs
    ;;

    scripts)
        install_scripts
    ;;

    configs)
        install_configs
    ;;
    
    "test")
        testing
    ;;

    *)
        echo "error: Tag doesn't exists"
        exit 1
    ;;
    
    esac
    exit 0
done

# jq -r '.configs[] | "\(map(.from)[]) \(map(.to)[])"' config/configs.json