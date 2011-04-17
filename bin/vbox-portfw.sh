#!/bin/bash

[ $# -eq 3 ] || { echo "usage: `basename $0` vmname guestport hostport"; exit 1; }

name=$1
guestport=$2
hostport=$3
cfgurl='VBoxInternal/Devices/pcnet/0/LUN#0/Config'

VBoxManage -nologo showvminfo $name > /dev/null
[ $? -eq 0 ] || { echo "VM $name not found, try VBoxManage list vms"; exit 1; }

VBoxManage -nologo setextradata $name "$cfgurl/portfw-$guestport/Protocol" TCP
VBoxManage -nologo setextradata $name "$cfgurl/portfw-$guestport/GuestPort" $guestport
VBoxManage -nologo setextradata $name "$cfgurl/portfw-$guestport/HostPort" $hostport
echo "Setup port forwarding on localhost:$hostport to $name:$guestport"

echo "Restart VM to apply the changes"
