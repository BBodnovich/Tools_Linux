#!/bin/bash
int_count=0

function confirm_termination() {
    ((int_count++))
    echo
    if [[ $int_count == 1 ]]; then
        echo "Are you sure you want to terminate? Press Ctrl+C again to confirm."
    else
        echo "Terminating Process."
        exit
    fi
}

trap confirm_termination INT


# Script Body Starts Here
echo "Running... Press Ctrl+C to terminate."
counter=60
while [[ counter > 0 ]]; do
    echo "$counter"
    ((counter+=1))
    sleep 1
done