#!/usr/bin/env bash

# Alternate input validation
# (( $# != 2 )) && { echo "Usage: hamming.sh <string1> <string2>"; exit 1; }
# (( ${#str1} != ${#str2} )) && { echo "strands must be of equal length"; exit 1; }

validate_inputs() {
    if (( $# != 2 )); then
        echo "Usage: hamming.sh <string1> <string2>"
        exit 1
    fi

    if (( ${#1} != ${#2} )); then
        echo "Strands must be of equal length"
        exit 1
    fi
}

# Validate inputs and set variables
validate_inputs "$@"
strand1="$1"
strand2="$2"

# Iterate over the strands using a range and slicing
for (( i=0; i<${#strand1}; i++ )); do
        if [[ "${strand1:$i:1}" != "${strand2:$i:1}" ]]; then
                (( distance++ ))
        fi
done

# Report hamming count, default value 0 if none present
echo "${distance:-0}"