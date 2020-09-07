#! /bin/bash

# Display the UID and username of the user executing this script.
# Display if the user is the root user or not.

# pseudo code: 
# Display the UID
# Display the username
# Display if the user is root user or not

# Display the UID
echo "Your UID is ${UID}"   

# Display the username
USER_NAME=$(id -u -n)
echo "Your user name is ${USER_NAME}"

# Display if the user is root user or not
if [[ "${UID}" -eq 0 ]]     # Keep in mind the spacing and quotations in variables
then                        # note [[ condition ]] is used to check condition: it returns 0/1 (for bash)
    echo "You are root!"
else
    echo "You are not root!"
fi