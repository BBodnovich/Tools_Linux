#!/bin/bash

COUNTER=10
COUNTER=$(( COUNTER * 60 ))

while [ $COUNTER -ge 0 ]; do
    echo -ne "$COUNTER seconds remaining\r"
    COUNTER=$((COUNTER - 1))
    sleep 1
done

echo -ne "\r                    \r"
echo "Time's up!"