#!/bin/bash

#playbook uses 'pass' to read secrets
sudo apt install ansible ansible-lint pass gpg python3-passlib python3-paramiko

#pass init $MY_EMAIL_OR_GPG_ID
#see  https://git.zx2c4.com/password-store/about/#EXTENDED%20GIT%20EXAMPLE

# sudo apt-get purge vagrant-libvirt
# sudo apt-mark hold vagrant-libvirt

# sudo apt-get install -y libvirt-dev libvirt-daemon-system-sysv ruby-libvirt \
#      virt-manager spice-vdagent xserver-xorg-video-qxl vagrant ruby-libvirt \
#      libguestfs-tools

sudo apt install vagrant ruby-libvirt
vagrant plugin install vagrant-libvirt vagrant-host-shell