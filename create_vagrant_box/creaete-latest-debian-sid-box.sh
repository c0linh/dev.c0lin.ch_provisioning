#!/bin/bash
set -x

if ! command -v expect >/dev/null || ! command -v telnet >/dev/null; then
    echo "apt install expect telnet #Needed to install some packages with expect." >&2
    exit 1
fi

apt list --installed | grep -q "^qemu-system-common/" ||
    { echo "apt install qemu-system-common #Needed to create a bridge network" >&2 && exit 1; }

declare -r box_name="debian-sid-box"
declare -r box_file="debian-sid-nocloud-amd64-daily.qcow2"

if [ ! -f "${box_file}" ]; then
    wget "https://cloud.debian.org/images/cloud/sid/daily/latest/${box_file}"
    chmod g+rwx "${box_file}"
else
    virsh destroy "${box_name}" 2>/dev/null || true
    virsh undefine "${box_name}" 2>/dev/null || true
fi

cp -f "${box_file}" "${box_file}.work"

# https://wiki.archlinux.org/title/QEMU#Bridged_networking_using_qemu-bridge-helper
if [ ! -f /etc/qemu/bridge.conf ]; then
    sudo mkdir -p /etc/qemu/
    sudo chmod 755 /etc/qemu/
    echo "allow virbr0" | sudo tee /etc/qemu/bridge.conf
    sudo chmod 0644 /etc/qemu/bridge.conf
    sudo chmod u+s /usr/libexec/qemu-bridge-helper
fi

virt-install \
    -n "${box_name}" \
    --description "vagrant debian box - ${box_file} $(date)" \
    --os-variant=debiantesting \
    --ram=2048 \
    --vcpus=2 \
    --disk path=./"${box_file}.work",size=10 --import \
    --network bridge:virbr0,model=virtio-net-pci \
    --serial tcp,host=:2222,mode=bind,protocol=telnet \
    --noautoconsole

./debian-sid-setup.expect || { echo "Bootstrap Script was not successfull!" >&2 && exit 1; } # some tests? why?

virsh shutdown ${box_name}

mv "${box_file}.work" box.img
tar cvzf "${box_name}".box ./metadata.json ./Vagrantfile ./box.img
vagrant box add --force --name "${box_name}" "${box_name}.box"
rm -f "*.{box,img}"
