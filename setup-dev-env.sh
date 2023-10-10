#!/bin/bash

sudo apt-get purge vagrant-libvirt
sudo apt-mark hold vagrant-libvirt

sudo apt-get install -y libvirt-dev libvirt-daemon-system-sysv libvirt-clients \
     virt-manager spice-vdagent xserver-xorg-video-qxl vagrant ruby-libvirt \
     libguestfs-tools

vagrant plugin install vagrant-libvirt vagrant-hostmanager