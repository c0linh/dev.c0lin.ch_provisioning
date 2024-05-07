#!/bin/bash
ansible-galaxy install --roles-path ".vagrant/galaxy-roles" -g -f -r "provisioning/roles/requirements.yml"

#Patch Unattended upgrade to tread osmc like Debian
cp .vagrant/galaxy-roles/hifis.unattended_upgrades/vars/Debian.yml .vagrant/galaxy-roles/hifis.unattended_upgrades/vars/OSMC.yml 

ansible-lint provisioning/playbook.yml --exclude .vagrant/galaxy-roles &&
ansible-playbook provisioning/playbook.yml -i provisioning/environments/prod "$@"
