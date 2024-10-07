#!/bin/bash

# UPDATE
# Merge with monitor_proc.sh?
# This has potential for a sys_monitor.sh megatool 

THRESHOLD=80
SLEEP_INTERVAL=60

process_report() {
    ps -eo pcpu,pid,comm= | sort -k1 -r | head -2 | awk '!/%CPU/ {print $1, $2, $3}'
}

while true; do
    sleep $SLEEP_INTERVAL
    process_info=$(process_report)

    read usage pid pname <<< "$process_info"

    if (( usage > THRESHOLD )); then
        sleep $SLEEP_INTERVAL

        process_info_2=$(process_report)
        read usage2 pid2 pname2 <<< "$process_info_2"

        if (( usage2 > THRESHOLD )) && [[ "$pid" == "$pid2" ]]; then
            logger "CPU_MONITOR: $pname has a sustained CPU utilization of $usage2% at $(date)"
        fi
    fi
done