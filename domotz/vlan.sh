#!/bin/sh
set -e


IP=192.168.0.100 #IP Address for VLAN
NETMASK=255.255.255.0 #VLAN Netmask
INTERFACE=enp2s0 #The Interface to VLAN on, enp2s0 or enp3s0
VLANID=20 #The 802.1q VLAN ID
#VLANINTERFACE=enp2s0.20 #Interface name + VLAN ID seperated by a '.'
VLANINTERFACE=$INTERFACE"."$VLANID

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
ifconfig $VLANINTERFACE $IP netmask $NETMASK 
sleep 1
echo "VLAN IP Assignment is "$IP" on Interface "$INTERFACE" With VLAN ID "$VLANID
(
while true
do
	sleep 60
	echo "IP Loop"
	ifconfig $VLANINTERFACE $IP netmask $NETMASK up
done
)
exit 0