#!/bin/bash

# install.sh               \ Prints Usage
# install.sh --help        \ Prints Usage
# install.sh all           \ Installs all scripts and all config files
# install.sh scripts       \ Installs all scripts
# install.sh configs       \ Installs all config files
# [WIP] install.sh script [name] \ Installs script by name
# [WIP] install.sh config [name] \ Installs config by name

usage()
{
    echo "Usage: install [all|scripts|configs]"
}

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
        echo "Not found Instance in .bashrc"
        echo "$INSTANCE" >> ~/.bashrc
    fi

    # If scripts folder doesn't exist will create it
    [ ! -d "$SCRIPTS" ] && mkdir $SCRIPTS && echo "Created $SCRIPTS"

    # Copy all scripts to default scripts folder
    cp -rf scripts/* $SCRIPTS

    # Remove blacklist scripts
    for file in $BLACKLIST; do
        rm $SCRIPTS/$file
    done

    echo "Installed scripts in $SCRIPTS"
}

install_configs()
{
    # This awk script string parses the config installation
    # file and at the end performs and action in this case
    # we have 'print $3' and 'print "cp -rfv",$2,$3'

    local AWK_SCRIPT_AUX='
    BEGIN {FS="[,()]"}
    /#.*/ {}
    /[a-zA-Z_][a-zA-Z0-9_]*[ ]*\([ ]*"[a-zA-Z0-9_\/.~\- ]+"[ ]*,[ ]*"[a-zA-Z0-9_\/.~\- ]+"[ ]*\)/ {
    gsub(/[ ]*"/,"\"");
    gsub(/"[ ]*/,"\"");
    gsub(/[ ]+/,"",$1);
    $2 = substr($2,2,length($2)-2);
    $3 = substr($3,2,length($3)-2);'
    local AWK_SCRIPT_1="$AWK_SCRIPT_AUX print \$3 }"
    local AWK_SCRIPT_2="$AWK_SCRIPT_AUX print \"cp -rfv\",\$2,\$3 }"
    
    # Default config files src/dest
    [ -z $1 ] && echo '
    i3       ("configs/i3/"                   , "~/.config/"                  )
    i3blocks ("configs/i3blocks/"             , "~/.config/"                  )
    neofetch ("configs/neofetch/"             , "~/.config/"                  )
    rofi     ("configs/rofi/"                 , "~/.config/"                  )
    Thunar   ("configs/Thunar/accels.scm"     , "~/.config/Thunar/accels.scm" )
    Thunar   ("configs/Thunar/gtkrc-2.0.mine" , "~/.gtkrc-2.0.mine"           )
    Thunar   ("configs/Thunar/gtkrc-2.0"      , "~/.gtkrc-2.0"                )
    urxvt    ("configs/urxvt/urxvt"           , "~/.config/Xresources.d/urxvt")
    urxvt    ("configs/urxvt/Xresources"      , "~/.Xresources"               )
    xserver  ("configs/.xinitrc"              , "~/.xinitrc"                  )
    bash     ("configs/.bashrc"               , "~/.bashrc"                   )
    bash     ("configs/.bash_profile"         , "~/.bash_profile"             )
    bash     ("configs/aliases.sh"            , "~/.config/aliases.sh"        )
    git      ("configs/.gitignore"            , "~/.config/.gitignore"        )
    ' > /tmp/.tmp.txt

    [ ! -z $1 ] && IN_CONFIG="$1" || IN_CONFIG="/tmp/.tmp.txt"

    for item in $(awk "$AWK_SCRIPT_1" $IN_CONFIG); do
        # Create destination parent folders
        if [ "${item: -1}" = "/" ]; then
            mkdir -p "$item"
        else
            # If file already exists rename to {name}.old
            [ -f "$item" ] && mv "$item" "$item.old"
            mkdir -p "$(dirname $item)"
        fi
    done
    eval "$(awk "$AWK_SCRIPT_2" $IN_CONFIG)"
    echo "Installed configs"
}

# Main execution

[ "$#" == 0 ] && usage
while [ "$#" -gt 0 ]; do
    case "$1" in

    "--help" | "")
        usage
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