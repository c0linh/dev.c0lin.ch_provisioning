#!/bin/bash
ansible-galaxy install --roles-path ./.vagrant/galaxy-roles -g -f -r provisioning/roles/requirements.yml 
ANSIBLE_CONFIG=provisioning/ansible.cfg ansible-playbook provisioning/playbook.yml
