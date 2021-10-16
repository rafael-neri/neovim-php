#!/usr/bin/env bash

# Check if user has sudo access
function identify_sudo() {
    local prompt

    prompt=$(sudo -nv 2>&1)
    if [ $? -eq 0 ]
    then
        HAS_SUDO=1
    elif echo $prompt | grep -q '^sudo:'
    then
        HAS_SUDO=1
    else
        HAS_SUDO=0
    fi
}

# Get user info
function user_info()
{
    USER=$(whoami)
    HOME=$(eval echo ~$USER)
}

# Get Password to user or root
function get_password()
{
    if [ "$EUID" -ne 0 ]
    then
        local prompt="[sudo] password for $USER: "

        if [[ $HAS_SUDO == 0 ]]
        then
            prompt="[sudo] password for root: "
        fi
        
        local charcount='0'
        local reply=''
        while IFS='' read -n '1' -p "${prompt}" -r -s 'char'
        do
            case "${char}" in
            # Handles NULL
            ( $'\000' )
                break
                ;;
            # Handles BACKSPACE and DELETE
            ( $'\010' | $'\177' )
                if (( charcount > 0 )); then
                prompt=$'\b \b'
                reply="${reply%?}"
                (( charcount-- ))
                else
                prompt=''
                fi
                ;;
            ( * )
                prompt='*'
                reply+="${char}"
                (( charcount++ ))
                ;;
            esac
        done
        PASSWORD=$reply
        printf '\n' >&2
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
        if [[ $HAS_SUDO == 0 ]]
        then
            
        elif [[ $HAS_SUDO == 0 ]]
        then

        else

        fi
    elif [ "$PACKAGE_MANAGER" == "pacman" ]
    then
        echo "b"
    else
        echo "Not Set"
    fi
}

echo -n "Identify user informations......... "
identify_sudo
user_info
sleep 3
echo "[OK]"

get_password

echo -n "Installing dependencies............ "
identify_os
install_dependencies
echo "[OK]"

echo "My package manager is $PACKAGE_MANAGER"
