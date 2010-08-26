#!/bin/sh
NAME=zcore301
MAC=aaaabbbbff05
VBoxManage createvm --name $NAME --register
VBoxManage modifyvm $NAME --memory 512 --acpi on --boot1 disk --boot2 net || echo "modify mem failed"
# NIC1 (eth0) is on the 'pxeland' intnet
VBoxManage modifyvm $NAME --nic1 intnet --intnet1 pxeland||echo "nic mod failed"
VBoxManage modifyvm $NAME --macaddress1 $MAC
# make a 10Gb disk image
VBoxManage createhd --filename $NAME.vdi --size 10240 --register

# attach a CentOS ISO and boot the VM
VBoxManage storagectl $NAME --name "SATA Controller" --add sata --sataportcount 1
VBoxManage storageattach $NAME \
    --storagectl "SATA Controller" \
    --port 0 \
    --device 0 \
    --type hdd \
    --medium $NAME.vdi
