#!/bin/zsh

networkservice="Ethernet" #Ethernet|FireWire|Wi-Fi|Bluetooth PAN|Thunderbolt Bridge

if  (nc -zw1 1.1.1.1 443) 2>/dev/null; then
    printf "\e[32mconnection ok\e[0m\n"
    exit
else
    1>&2 printf "\e[0m[$(date +'%Y-%m-%d %H:%M:%S')] \e[33mretrying in 10s\e[0m\n"
    sleep 10

    if (nc -zw1 1.1.1.1 443) 2>/dev/null; then
        1>&2 printf "\e[0m[$(date +'%Y-%m-%d %H:%M:%S')] \e[32mconnection ok\e[0m\n"
        exit
    else
        1>&2 printf "\e[0m[$(date +'%Y-%m-%d %H:%M:%S')] \e[31mrestarting connection\e[0m\n"
        networksetup -setnetworkserviceenabled $networkservice off
        sleep 5
        networksetup -setnetworkserviceenabled $networkservice on
        1>&2 printf "\e[0m[$(date +'%Y-%m-%d %H:%M:%S')] \e[36mconnection restarted\e[0m\n"
    fi
fi