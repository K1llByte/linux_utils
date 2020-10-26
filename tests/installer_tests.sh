#!/bin/bash

usage()
{
    echo "Usage: install [configs]"
}

install_configs()
{
    #CONFIGS=~/to/
    eval "$(awk '/[ ]*#.*/{} /[^:]*:[ ]+[^ ]+[ ]+[^ ]+/{print "mkdir -p \"$(dirname \"",$3,"\") && cp -r",$2,$3,"&& echo \"Installed ",substr($1,1,length($1)-1),"\" config"}' configs_tests.txt)"
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