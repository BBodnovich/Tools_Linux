#!/bin/bash
#
# Is this script really necessary? Probably not, but the easier you make something the more you'll do it
# Tool creates backup of target file or directory and sends it to /tmp/$1
# This tool is a quality of life item for me to make backing items up second nature and not cumbersome

if [ $# -eq 0 ]; then
    echo "No target file or directory stated"
    exit 1
fi

mkdir -p /tmp/backups

for item in "$@"; do
    
    if [ ! -e "$item" ]; then
        echo "Warning: $item does not exist."
        continue
    fi

    diskspace_used=$(df "$item" | tail -1 | awk '{ print $5 }' | sed 's/%//')

    if [ "$diskspace_used" -ge 90 ]; then
        echo "Warning: Low disk space, $diskspace_used% used."
        # break | continue
    fi

    # backup_name="/tmp/backups/$(basename "$item")_$(date +%y_%m_%d).bak"
    backup_name="/tmp/backups/$(basename "$item").bak"
    cp -r "$item" "$backup_name"

    if [ $? -eq 0 ]; then
        echo "Backup created: $backup_name"
    else
        echo "Error: Failed to create backup for $item"
done