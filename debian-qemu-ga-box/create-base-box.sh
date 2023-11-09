#!/bin/bash
set -x

if [ ! -f "debian-12-nocloud-amd64.qcow2" ]; then
    wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-nocloud-amd64.qcow2 
    chmod g+rwx debian-12-nocloud-amd64.qcow2
else 
   virsh destroy debian-qemu-ga-box 
   virsh undefine debian-qemu-ga-box 
fi

cp -f debian-12-nocloud-amd64.qcow2 debian-12-nocloud-amd64.disk.qcow2

virt-install \
-n debian-qemu-ga-box  \
--description "vagrant base box - Debian 12 with qemu-agent" \
--os-variant=debiantesting \
--ram=2048 \
--vcpus=2 \
--disk path=./debian-12-nocloud-amd64.disk.qcow2,size=10 --import \
--graphics none \
--network bridge:virbr0 \
--serial tcp,host=:2222,mode=bind,protocol=telnet \
--noautoconsole

./debian-12-setup.expect

#virsh destroy debian-qemu-ga-box 
#virsh undefine debian-qemu-ga-box 

mv  debian-12-nocloud-amd64.disk.qcow2 box.img
tar cvzf debian12-qemu-ga.box ./metadata.json ./Vagrantfile ./box.img
vagrant box add --force --name debian12-qemu-ga debian12-qemu-ga.box
rm -f *.box *.img
