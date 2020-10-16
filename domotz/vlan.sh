#!/bin/sh
set -e
IP=192.168.0.100
NETMASK=255.255.255.0
INTERFACE=enp2s0
VLANID=20
VLANINTERFACE=enp2s0.20
echo "Modprobe 1 to fail"
modprobe 8021q || true
sleep 1

echo "vconfig 1 to fail"
vconfig add $INTERFACE $VLANID || true
sleep 1

echo "Modprobe should work"
modprobe 8021q || true
sleep 1

echo "Creating Interface if not pre-existing"
vconfig add $INTERFACE $VLANID || true
sleep 1

echo "IP Assign 1"
ifconfig $VLANINTERFACE $IP netmask $NETMASK up
sleep 10

echo "IP Assign 2"
ifconfig $VLANINTERFACE $IP netmask $NETMASK up
(
while true
do
	sleep 60
	echo "IP Loop"
	ifconfig $VLANINTERFACE $IP netmask $NETMASK up
done
)
exit 0