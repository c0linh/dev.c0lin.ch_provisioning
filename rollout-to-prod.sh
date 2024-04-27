#!/bin/bash
ansible-galaxy install --roles-path ".vagrant/galaxy-roles" -g -f -r "provisioning/roles/requirements.yml"

ansible-lint playbook.yml --exclude .vagrant/galaxy-roles &&
ansible-playbook playbook.yml --check -i provisioning/environments/prod "$@" &&
ansible-playbook playbook.yml -i provisioning/environments/prod "$@"
