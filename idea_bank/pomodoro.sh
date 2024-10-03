# TODO
# Implement options
# -t for work time in minutes, default argument 25 minutes
# -b for break time in minutes, default argument 5 minutes


#!/bin/bash

COUNTER=$1
COUNTER=$(( COUTNER * 60 ))

while true; do
    echo $COUNTER seconds remaining
    COUNTER=$((COUNTER - 1))
    sleep 1
done