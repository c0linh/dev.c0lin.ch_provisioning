Introduction
============
development envirnment for a container based media server

folder structure from [Varun Palekar] (https://github.com/varunpalekar/ansible-structure)

#Install
./setup-dev-env.sh

#Start 
./start-dev-env.sh

#Sync changes from ./ansible to /ansible
vagrant rsync-auto &

#Apply playbook
vagrant provision --provision-with 'ansible'