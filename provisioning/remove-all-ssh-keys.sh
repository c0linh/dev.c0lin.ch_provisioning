#!/usr/bin/env bash
for file in ../.ssh/*; do 
    chmod 600 "$file"
    shred "$file"
done;

rm -rf .ssh