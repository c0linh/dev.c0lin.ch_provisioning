#!/bin/bash


#playbook uses 'pass' to read secrets 
sudo apt install pass gpg

#pass init $MY_EMAIL_OR_GPG_ID
#see  https://git.zx2c4.com/password-store/about/#EXTENDED%20GIT%20EXAMPLE


sudo apt-get purge vagrant-libvirt
sudo apt-mark hold vagrant-libvirt

sudo apt-get install -y libvirt-dev libvirt-daemon-system-sysv libvirt-clients \
     virt-manager spice-vdagent xserver-xorg-video-qxl vagrant ruby-libvirt \
     libguestfs-tools

vagrant plugin install vagrant-libvirt