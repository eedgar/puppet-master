VBoxManage createvm --name shoemaker --register
VBoxManage modifyvm shoemaker --memory 512 --acpi on --boot1 dvd || echo "modify mem failed"
# NIC1 (eth0) is NATted, NIC2 (eth1) is on the 'pxeland' intnet
VBoxManage modifyvm shoemaker --nic1 nat --nic2 intnet --intnet2 pxeland||echo "nic mod failed"
# make a 30Gb disk image
VBoxManage createhd --filename  shoemaker.vdi --size 30720 --register

# attach a CentOS ISO and boot the VM
VBoxManage storagectl shoemaker --name "SATA Controller" --add sata --sataportcount 1
VBoxManage storageattach shoemaker \
    --storagectl "SATA Controller" \
    --port 0 \
    --device 0 \
    --type hdd \
    --medium shoemaker.vdi

VBoxManage storagectl shoemaker --name "IDE Controller" --add ide
VBoxManage storageattach shoemaker \
    --storagectl "IDE Controller" \
    --port 1 \
    --device 0 \
    --type dvddrive \
    --medium /<PATH_TO_MEDIA>/CentOS-5.5-i386-bin-DVD.iso

VBoxManage startvm shoemaker

