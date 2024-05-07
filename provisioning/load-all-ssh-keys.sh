#!/usr/bin/env bash
set -x
hosts="$(exa ~/.password-store/ansible/)"
export SSH_ASKPASS_REQUIRE="never"

if [ ! -d ".ssh" ]; then
    mkdir "../.ssh"
fi 

for host in $hosts; do 
    file="../.ssh/$host"
    if [ -f "$file" ]; then
        chmod 600 "$file"
        rm "$file"
    fi
    pass file cat "ansible/$host/ssh_id" > "$file"
    chmod 400 "$file"
done;