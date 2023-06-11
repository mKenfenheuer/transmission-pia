#!/bin/bash

if [ "$PIA_USERNAME" == "replaceme" ]
then
    echo "Please set ENV \$PIA_USERNAME. Exiting."
    exit 1
fi

if [ "$PIA_PASSWORD" == "replaceme" ]
then
    echo "Please set ENV \$PIA_PASSWORD. Exiting."
    exit 1
fi


wget -O openvpn.zip "$PIA_OPENVPN_URL"
unzip openvpn.zip > /dev/null 2>&1

echo "Available configuration files:"
ls *.ovpn
echo ""

echo "Selected OpenVPN file: $PIA_OPENVPN_FILE"
echo ""
echo ""

sed -i -E "s/auth-user-pass/auth-user-pass \/app\/openvpn.pass/" "$PIA_OPENVPN_FILE"

echo "$PIA_USERNAME" > "openvpn.pass"
echo "$PIA_PASSWORD" >> "openvpn.pass"

echo "redirect-gateway def1" >> "$PIA_OPENVPN_FILE"
echo "dhcp-option DNS 10.0.0.241" >> "$PIA_OPENVPN_FILE"

openvpn "$PIA_OPENVPN_FILE" > openvpn.log 2>&1 &

sleep 1
echo "Waiting for OpenVPN ..."
until ping -c1 10.0.0.241 >/dev/null 2>&1; do :; done

echo "OpenVPN is online."

echo "nameserver 10.0.0.241" > /etc/resolv.conf
echo ""

echo "Current IP from VPN is:"
curl -m 1 http://ip-api.com/line?fields=country,city,query
echo ""

echo "Starting Transmission Daemon ..."
transmission-daemon  -a "*.*.*.*" --auth --username "$TRANSMISSION_USERNAME" --password "$TRANSMISSION_PASSWORD" --logfile /app/transmission.log &
echo "Transmission started."
echo ""

while pgrep -x "openvpn" > /dev/null; do sleep 1; done

echo "OpenVPN is process disappeared, killing transmission!"
pkill transmission

rm "openvpn.pass"

echo ""
echo ""
echo "##### BEGIN OPENVPN LOG #####"
cat openvpn.log
echo "##### END OPENVPN LOG #####"

echo ""
echo ""
echo "##### BEGIN TRANSMISSION LOG #####"
cat transmission.log
echo "##### END TRANSMISSION LOG #####"
echo ""
echo ""
