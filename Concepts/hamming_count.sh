#!/usr/bin/env bash

str1="$1"
str2="$2"

# If there are not 2 inputs
(( $# != 2 )) && { echo "Usage: hamming.sh <string1> <string2>"; exit 1; }

# If two inputs are not equal in length
(( ${#str1} != ${#str2} )) && { echo "strands must be of equal length"; exit 1; }

# Iterate over the string using a range and slicing
for (( i=0; i<${#str1}; i++ )); do
        if [[ "${str1:$i:1}" != "${str2:$i:1}" ]]; then
                (( distance++ ))
        fi
done

# Report hamming count, default value 0 if none present
echo "${distance:-0}"