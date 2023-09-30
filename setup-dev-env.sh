#!/bin/bash

sudo apt-get purge vagrant-libvirt
sudo apt-mark hold vagrant-libvirt

sudo apt-get install -y libvirt-dev libvirt-daemon-system-sysv libvirt-clients \
     virt-manager spice-vdagent xserver-xorg-video-qxl vagrant ruby-libvirt \
     libguestfs-tools
     
export CONFIGURE_ARGS="with-libvirt-include=/usr/include/libvirt with-libvirt-lib=/usr/lib64"
vagrant plugin install vagrant-libvirt

#vagrant plugin install vagrant-libvirt vagrant-disksize vagrant-hostmanager