#!/bin/bash

# How does a Pomodoro timer work?
# Set timer for 25 minutes, your Pomodoro block
# When 25 minute timer is over, set a 5 minute break timer
# Repeat 4 times, then take a 15-30 minute break

# Task Overview
# 1.    Work            25 minute timer
# 2.    Short Break      5 minute timer
# 3.    Work            25 minute timer
# 4.    Short Break      5 minute timer
# 5.    Work            25 minute timer
# 6.    Short Break      5 minute timer
# 7.    Work            25 minute timer
# 8.    Long Break      30 minute timer

# TODO
# 1. Output timer in '00m 00s' format instead of '00000 seconds'
# 2. Between breaks put some text on the screen notifying 
# 3. Make an attempt to integrate an audible alarm when timers end


# Initialize Default Values
pomodoro_round_target=1
minutes_work=25
minutes_break_short=5
minutes_break_long=30
seconds_work=0
seconds_break_short=0
seconds_break_long=0


# Usage Report
usage() {
    cat <<EOF
Usage: $0 [options]

-h      Help menu

-w      Work block time in minutes      (default: 25)
-b      Short break time in minutes     (default: 5)
-B      Long break time in minutes      (default: 30)
-t      How many rounds of Pomodoro     (default: 1)

EOF
}


# Input validation for positive integers only
integer_validation() {
    [[ $1 =~ ^[0-9]+$ ]]
}


# Parameters to set default values to target values
while getopts "w:b:B:t:" opt 2>/dev/null; do
    case $opt in
        w) 
            minutes_work="$OPTARG"
            if ! integer_validation "$minutes_work"; then
                echo "Error: Work block time in minutes must be a positive integer"
                usage
                exit 1
            ;;
        b) 
            minutes_break_short="$OPTARG" 
            if ! integer_validation "$minutes_break_short"; then
                echo "Error: Short break time in minutes must be a positive integer"
                usage
                exit 1
            ;;
        B) 
            minutes_break_long="$OPTARG" 
            if ! integer_validation "$minutes_break_long"; then
                echo "Error: Long break time in minutes must be a positive integer"
                usage
                exit 1
            ;;
        t) 
            pomodoro_round_target="$OPTARG"
            if ! integer_validation "$pomodoro_round_target"; then
                echo "Error: Number of Pomodoro rounds must be a positive integer"
                usage
                exit 1
            ;;
        h) usage; exit 0 ;;
        *) usage; exit 0 ;;
    esac
done


# Convert minutes to Seconds for use with timer
minutes_to_seconds() {
    seconds_work=$(( minutes_work * 60 ))
    seconds_break_short=$(( minutes_break_short * 60 ))
    seconds_break_long=$(( minutes_break_long * 60))
}


# Start the timer countdown with work, short break, or long break seconds as input
start_timer() {
    local counter="$1"

    while [ $counter -ge 0 ]; do
        echo -ne "$counter seconds remaining\r"
        counter=$((counter - 1))
        sleep 1
    done
}


# Pomodoro Timer Logic
minutes_to_seconds
pomodoro_block=1
pomodoro_round=0


while [ $pomodoro_round -lt $pomodoro_round_target ]; do
    case $pomodoro_block in 
        1|3|5|7)
            echo 'Work'
            (( pomodoro_block += 1))
            start_timer "$seconds_work"
            ;;
        2|4|6)
            echo 'Short Break'
            (( pomodoro_block += 1))
            start_timer "$seconds_break_short"
            ;;
        8)
            echo 'Long Break'
            (( pomodoro_block += 1))
            start_timer "$seconds_break_long"
            ;;
        9)
            pomodoro_block=1
            ((pomodoro_round += 1))
            exit 0
            ;;
        *)
            echo 'Something catastrophically bad has happened'
            exit 1
            ;;
    esac
done