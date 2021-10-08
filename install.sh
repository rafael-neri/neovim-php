#!/usr/bin/env bash

# Identify OS
function identify_os()
{
    if [ -x "$(command -v apt-get)" ] # Debian, Ubuntu, Mint and etc...
    then
        PACKAGE_MANAGER="apt-get"
    elif [ -x "$(command -v pacman)" ] # Arch, Manjaro and etc...
    then
        PACKAGE_MANAGER="pacman" # Others
    else
        echo "Operating System is not supported...." >&2
        exit 1
    fi
}

# Install Dependencies
function install_dependencies()
{
    if [ -n "$PACKAGE_MANAGER" ]
    then
        echo "Set"
    else
        echo "Not Set"
    fi
}

identify_os
install_dependencies

echo "My package manager is $PACKAGE_MANAGER"