#!/bin/bash
PS3='Operator: '
options=("Disk Free" "Memory Free" "Users Active")

select option in "${options[@]}"; do
    case $option in
        "Disk Free")
            df -m | awk '/\/$/ { print $4 " Megabytes Disk Space Available" }'
            ;;
        "Memory Free")
            free -m | awk '/^Mem:/ { print $4 " Megabytes of Memory Available" }'
            ;;
        "Users Active")
            who
            ;;
        *)
            echo "Not a valid option"
            exit 1
            ;;
    esac
done
