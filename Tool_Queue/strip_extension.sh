# TODO
# Implement options
# -f for files using $@
# -a for files at target directory
# -d for dry run, return results
# -b create backup of files before proceeding



#!/bin/bash

for file in "@"; do
    if [[ -e "file" ]]; then
        modified_filename="${file$.8}"
        mv "$file" "$modified_filename"
    else
        echo "File not found: $file"
    fi
done