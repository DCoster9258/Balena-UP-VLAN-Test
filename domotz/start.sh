#!/bin/sh

MAC_ADDRESS=$(curl -s --header "Content-Type:application/json" "$BALENA_SUPERVISOR_ADDRESS/v1/device?apikey=$BALENA_SUPERVISOR_API_KEY" | jq -r ".mac_address" | cut -d' ' -f1)

[ "$MAC_ADDRESS" ] || { echo "MAC Address could not be discovered" ; exit 1; }

macchanger --mac=$MAC_ADDRESS eth0

exec "$@"