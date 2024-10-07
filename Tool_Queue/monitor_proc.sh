#!/bin/bash
#
# TODO
# Make this a robust tool that can handle process monitoring on critical processes
# Ran as a background process that should not be terminated
# Consider systemd integration to start on system boot
#
# UPDATE
# Merge with monitor_cpu.sh?
# This has potential for a sys_monitor.sh megatool 

PROCESS='httpd'

while ps aux | grep -v grep | grep $PROCESS > /dev/null; do
    sleep 15
done


logger "$PROCESS Monitor: $PROCESS has stopped at $(date)"

if systemctl start $PROCESS; then
    logger "$PROCESS Monitor: $PROCESS has successfully been restarted at $(date)"
else
    logger "$PROCESS Monitor: $PROCESS failed to restarted at $(date)"
fi

# Sendmail Option
# echo "$MESSAGE" | sendmail you@email.com