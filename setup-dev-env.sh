#!/bin/bash
#Install requirements to setup vm's with vagrant
if pidof /sbin/init > /dev/null; then 
    libvirt_daemon=libvirt-daemon-system-sysv 
elif pidof systemd  > /dev/null; then
    libvirt_daemon=libvirt-daemon-system-systemd
else
    libvirt_daemon=libvirt-daemon-system
fi 

# https://vagrant-libvirt.github.io/vagrant-libvirt/installation.html#ubuntu--debian
# vagrant-libvirt install guide does not recommend vagrant-libvirt deb
sudo apt-get purge vagrant-libvirt
sudo apt-mark hold vagrant-libvirt

sudo apt-get install -y qemu-kvm $libvirt_daemon libvirt-clients virt-manager \
     spice-vdagent xserver-xorg-video-qxl vagrant ruby-libvirt gh
# vagrant-libvirt install guide also suggest these packages: 
#   ibvirt-dev ebtables libguestfs-tools ruby-fog-libvirt 

#Vagrant Cache see - https://github.com/fgrehm/vagrant-cachier
vagrant plugin install vagrant-libvirt vagrant-hostmanager #vagrant-cachier 

#generate ssh-keys to for ansible controller
mkdir ansible/.ssh
if [ ! -f ansible/.ssh/id_ed25519 ]; then 
    ssh-keygen -t ed25519 -C "ansible@controller" -f ansible/.ssh/id_ed25519 -q -N ""
    # needed to download requirements(.yml) directly form github
    gh ssh-key add ansible/.ssh/id_ed25519.pub -t "ansible@localhost"
fi