#!/bin/bash

usage()
{
    echo "Usage: install [configs]"
}

install_configs()
{
    #CONFIGS=~/to/
    #[ -f arg ] && mkdir -p $(dirname "arg");[ -d arg ] && mkdir -p arg;
    #[ -f "" ] && mkdir -p $(dirname "");[ -d arg ] && mkdir -p "";
    


    #MK_DIR_INE=""
    
    AWK_SCRIPT='
    /[ ]*#.*/ {}

    function aux(str)
    {
        return "[ \"${asd: -1}\" = \"/\" ] && mkdir -p "str" || mkdir -p $(dirname "str");"
    }

    /[^:]*:[ ]+[^ ]+[ ]+[^ ]+/ {
        print aux($3)" cp -r",$2,$3,"&& echo \"Installed "substr($1,1,length($1)-1)" config"
    }
    '
    awk "$AWK_SCRIPT" configs_tests.txt
}


testing()
{
    echo "coisas"
}


[ "$#" == 0 ] && usage
while [ "$#" -gt 0 ]
do
    case "$1" in

    "--help" | "")
        usage
    ;;

    configs)
        install_configs
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