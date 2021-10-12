#!/usr/bin/env bash

# Get user info
function get_user_info()
{
    USER=$(whoami)
    HOME=$(eval echo ~$USER)
}

# Elevate permission to root
function elevate_root()
{
    if [ "$EUID" -ne 0 ]
    then   
        echo -ne "\033[0K\r[sudo] password for $USER: "
    
        while IFS= read -p "" -r -s -n 1 char
        do
            # Enter - accept password
            if [[ $char == $'\0' ]]
            then
                break
            fi
            # Backspace
            if [[ $char == $'\177' ]]
            then
                PROMPT="${PROMPT%?}"
                PASSWORD="${PASSWORD%?}"
                echo -ne "\033[0K\r[sudo] password for $USER: $PROMPT"
            else
                PROMPT+='*'
                PASSWORD+="$char"
                echo -ne "\033[0K\r[sudo] password for $USER: $PROMPT"
            fi
        done
        echo
    fi
}

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
    if [ "$PACKAGE_MANAGER" == "apt-get" ]
    then
        echo "a"
    elif [ "$PACKAGE_MANAGER" == "pacman" ]
    then
        echo "b"
    else
        echo "Not Set"
    fi
}

get_user_info
elevate_root
echo $PASSWORD
exit
identify_os
install_dependencies

echo "My package manager is $PACKAGE_MANAGER"
