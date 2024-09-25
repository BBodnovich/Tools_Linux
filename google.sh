#!/bin/bash

# Check distribution to set package_manager
if grep -i 'ubuntu' /etc/os-release > /dev/null; then
    package_manager='apt install -y'
elif grep -i 'arch' /etc/os-release > /dev/null; then
    package_manager='pacman -S --noconfirm' 
else
    echo "Unsupported distribution."
    exit 1
fi

# Check if w3m installed
if ! command -v w3m &> /dev/null; then
    echo "w3m is not installed"

    read -p 'Install Package? [y/n]: '  install_response

    install_response=$(echo "$install_response" | tr '[:upper:]' '[:lower:]')

    case "$install_response" in
        y|yes) 
            sudo $package_manager w3m 
            ;;
        n|no) 
            exit 1 
            ;;
        *) 
            echo 'Invalid input.'
            exit 1 
            ;;
    esac
fi

# Check for search query
if [ $# -eq 0 ]; then
    read -p 'Enter a search term: ' search_term
else
    search_term=$*
fi

# Convert search_term to URL-friendly format
search_term_formatted=$(echo "$search_term" | sed 's/ /+/g')

# Report google results using w3m
w3m "https://www.google.com/search?q=$search_term_formatted"