#!/bin/bash
vagrant up --provider=libvirt
vagrant rsync-auto &
#--provision-with