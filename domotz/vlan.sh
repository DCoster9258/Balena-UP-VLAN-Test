#!/bin/sh
set -e

echo "Modprobe 1 to fail"
modprobe 8021q || true
sleep 1

echo "vconfig 1 to fail"
vconfig add enp2s0 20 || true
sleep 1

echo "Modprobe should work"
modprobe 8021q || true
sleep 1

echo "Creating Interface"
vconfig add enp2s0 20 || true
sleep 1

echo "IP Assign 1"
ifconfig enp2s0.20 192.168.0.100 netmask 255.255.255.0 up
sleep 1

echo "IP Assign 2"
ifconfig enp2s0.20 192.168.0.100 netmask 255.255.255.0 up
sleep 1


(
while [ $run -le 2 ]
run=0
do
	echo "IP Assign Loop"
	ifconfig enp2s0.20 192.168.0.100 netmask 255.255.255.0 up
	sleep 60
done
)