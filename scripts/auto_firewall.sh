#!/bin/bash

# setfw <port> <wl_file>  \ Sets firewall for port with ips in whitelist

#IP_LIST=~/.config.wl

setfw()
{
    if [ -z $1 ] || [ -z $2 ] ; then
        echo "error: setfw <port> <wl_file>"
        return 1
    fi
    sudo iptables -F INPUT
    while read ip; do
        sudo iptables -A INPUT -s "$ip" -p tcp --dport $1 -j ACCEPT
    done <$2
    sudo iptables -A INPUT -p tcp --dport "$1" -j DROP
}