#!/usr/bin/bash

# log()
# {
#     echo "$1" >> ~/chconfig.log
# }

assign_config()
{
    if [ -f ~/.config/i3/config.$1 ]; then
        ln -sf ~/.config/i3/config.$1 ~/.config/i3/config
        i3-msg -q restart
    else
        exit 1
    fi
}

case "$1" in
    "")
        exit 1
    ;;

    *)
        assign_config $1
    ;;
esac