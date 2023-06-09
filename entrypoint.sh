#!/bin/bash

echo "-----------SPEEDTEST WITHOUT OUTLINE - IRAN (PISHGAMAN)-----------"
speedtest -s 32500 -f json --accept-license --accept-gdpr
echo "-----------SPEEDTEST WITHOUT OUTLINE - GERMANY (RETN)-----------"
speedtest -s 31120 -f json --accept-license --accept-gdpr
ip tuntap add dev outline-tap0 mode tun
ip link set dev outline-tap0 up
read IP_ROUTE <<< $(ip route | awk '/default/{ $1=""; print $0 }')
ip route add $OUTLINE_IP/32 $IP_ROUTE metric 0
ip route del default
ip addr add 10.0.85.2/24 dev outline-tap0
ip route add default via 10.0.85.1 onlink dev outline-tap0 metric 0
./tun2socks -tunName outline-tap0 -proxyHost $OUTLINE_IP -proxyPort $OUTLINE_PORT -proxyPassword $OUTLINE_PASS -proxyCipher $OUTLINE_CIPHER -proxyPrefix $OUTLINE_PREFIX -dnsFallback -logLevel debug &
echo "-----------SPEEDTEST WITH OUTLINE - GERMANY (RETN)-----------"
speedtest -s 31120 -f jsonl --accept-license --accept-gdpr