#!/bin/bash

# Current Free Space in Megabytes
DISKFREE=$(df -m | grep '/$' | awk '{ print $4 }')
MEMFREE=$(free -m | grep 'Mem' | awk '{ print $4 }')

# Threshold Free Space in Megabytes
DISKFREE_THRESHOLD=$(( 1024 * 3 ))          # 3 GB
MEMFREE_THRESHOLD=512                       # 512 MB

# Logic
if [[ $DISKFREE -lt $DISKFREE_THRESHOLD && $MEMFREE -lt $MEMFREE_THRESHOLD ]]; then
    echo "WARNING: Low system resource"
elif (( $DISKFREE -le $DISKFREE_THRESHOLD )); then
    echo "WARNING: Low disk space available"
elif (( $MEMFREE -le $MEMFREE_THRESHOLD )); then
    echo "WARNING: Low memory available"
else
    echo "All good - system is healthy"
fi
