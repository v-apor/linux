#!/bin/bash

# This script creates an account on the local system.
# You'll be prompted for the account name and password.

# psedu code
# Ask for the user name
# Ask for the real name
# Ask for the password
# Create the user
# Set password for the user
# Force password change on the first login


# Ask for the user name
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set password for the user
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on the first login
passwd -e ${USER_NAME}
