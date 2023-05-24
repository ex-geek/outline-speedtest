#!/bin/bash

echo "-----------SPEEDTEST WITHOUT OUTLINE - IRAN (PISHGAMAN)-----------"
echo "yes" | speedtest -s 32500 -f json
echo "-----------SPEEDTEST WITHOUT OUTLINE - GERMANY (RETN)-----------"
speedtest -s 31120 -f json
ip link set dev outline-tap0 up
ip addr add 10.0.0.1/24 dev tun0
ip -4 route add 0.0.0.0/0 via 10.0.85.1 dev outline-tap0 onlink
./tun2socks -tunName outline-tap0 -tunDNS 1.1.1.1,9.9.9.9 -tunAddr 10.0.85.2 -tunGw 10.0.85.1 -tunMask 255.255.255.0 -proxyHost $OUTLINE_IP -proxyPort $OUTLINE_PORT -proxyPassword $OUTLINE_PASS -proxyCipher $OUTLINE_CIPHER -proxyPrefix $OUTLINE_PREFIX &
echo "-----------SPEEDTEST WITH OUTLINE - GERMANY (RETN)-----------"
speedtest -s 31120 -f json
killall tun2socks
killall tun2socks