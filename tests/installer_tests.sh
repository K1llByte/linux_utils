#!/bin/bash

CONFIGS="$HOME/.config/"

[ ! -d $CONFIGS ] && mkdir "$CONFIGS"

usage()
{
    echo "Usage: install [configs]"
}


create_dir()
{
    while read dir
    do
        [ "${dir: -1}" = "/" ] && mkdir -p "$dir" || mkdir -p $(dirname "$dir");
    done < "${1:-/dev/stdin}"
}

install_all_configs()
{
    local CONFIG_SRC="from/"
    local CONFIG_DEST="to/"
    cp -rf 
}



install_specific_configs()
{
    #CONFIGS=~/to/
    #[ -f arg ] && mkdir -p $(dirname "arg");[ -d arg ] && mkdir -p arg;
    #[ -f "" ] && mkdir -p $(dirname "");[ -d arg ] && mkdir -p "";



    #MK_DIR_INE=""

    
    
    AWK_SCRIPT='
    /[ ]*#.*/ {}

    function aux(str)
    {
        return "tmp=\""str"\"; [ \"${tmp: -1}\" = \"/\" ] && mkdir -p "str" || mkdir -p $(dirname "str");"
    }

    /[^:]*:[ ]+[^ ]+[ ]+[^ ]+/ {
        print aux($3)" cp -r",$2,$3,"&& echo \"Installed "substr($1,1,length($1)-1)" config\n"
    }
    '
    eval $(awk "$AWK_SCRIPT" configs_tests.txt)
}


testing()
{
    for item in $(ls -a); do
        if [ ! $item = "." ] && [ ! $item = ".." ]; then
            [ -d $item ] && echo "'$item' is folder" || echo "'$item' is file";
        fi
    done
}


[ "$#" == 0 ] && usage
while [ "$#" -gt 0 ]
do
    case "$1" in

    "--help" | "")
        usage
    ;;

    configs)
        install_all_configs
    ;;
    
    test)
        testing
    ;;
    
    *)
        echo "error: Tag '$1' doesn't exists"
    ;;
    
    esac
    exit 1
done

# Expected installation:
# Parse 'configs.txt' file
## File can have specific installation rules or default ones
## urxvt:    from/urxvt/Xresources  to/.Xresources
## default:  from/                  to/
# if no rule is specified nothing will happen