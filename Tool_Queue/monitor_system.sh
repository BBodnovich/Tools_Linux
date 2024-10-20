#!/bin/bash

# Testing grounds for combining monitor_cpu and

# TODO
# Break out CPU Utilization and Check Process Alive into seperate functions
# Create main function to tie everything together

PROCESS='httpd'
CPU_THRESHOLD=80
SLEEP_INTERVAL=60

check_top_process() {
    ps -eo pcpu,pid,comm= | sort -k1 -r | head -2 | awk '!/%CPU/ {print $1, $2, $3}'
}

evaluate_cpu_usage() {
    process_info=$(check_top_process)
    read cpu_usage pid pname <<< "$process_info"

    if (( cpu_usage > CPU_THRESHOLD )); then
        sleep $SLEEP_INTERVAL

        process_info_2=$(check_top_process)
        read cpu_usage2 pid2 pname2 <<< "$process_info_2"

        if (( cpu_usage2 > CPU_THRESHOLD )) && [[ "$pid" == "$pid2" ]]; then
            logger "CPU_MONITOR: $pname has a sustained CPU utilization of $cpu_usage2% at $(date)"
        fi
    fi
}

check_process_alive() {
    if ! ps aux | grep -v grep | grep -q "$PROCESS"; then
        logger "$PROCESS Monitor: $PROCESS has stopped at $(date)"

        if systemctl start $PROCESS; then
            logger "$PROCESS Monitor: $PROCESS has successfully been restarted at $(date)"
        else
            logger "$PROCESS Monitor: $PROCESS failed to restarted at $(date)"
        fi
        
    fi
}

main() {
    while true; do
        sleep $SLEEP_INTERVAL
        evaluate_cpu_usage
        check_process_alive
    done
}

main
