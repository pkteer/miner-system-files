#!/bin/bash

INTERNAL_DEV=$(ip link show | grep '^3: ' | sed 's/^[0-9]\+: \([a-zA-Z0-9]\+\): .*$/\1/')
echo "It looks like the internal device is $INTERNAL_DEV"
echo $INTERNAL_DEV | grep -q '^[a-zA-Z0-9]\+$' || exit 1

ifconfig $INTERNAL_DEV down
ifconfig $INTERNAL_DEV up
nmcli connection show
DEV_UUID=$(nmcli -c=no connection show | grep $INTERNAL_DEV | sed 's/^.* \([a-f0-9-]\{36\}\) .*$/\1/')
echo "It looks like the UUID is $DEV_UUID"
echo $DEV_UUID | grep -q '^[a-f0-9-]\{36\}$' || exit 1

INTERNAL_IP=$(ip route get 8.8.8.8 | sed -ne 's/.* src [0-9]\+\.\([0-9\.]\+\) .*/10.\1/p')
echo "The internal IP will be $INTERNAL_IP"

nmcli connection modify $DEV_UUID IPv4.address ${INTERNAL_IP}/8
nmcli connection modify $DEV_UUID IPv4.method manual
nmcli connection down $DEV_UUID
nmcli connection up $DEV_UUID