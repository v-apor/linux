#!/bin/bash

# Display the UID and username of the user executing this script
# Display if the user is 'vagrant' user or not

# psedu:
# Display the UID
echo "Your UID is ${UID}"

# Only display if the UID doesn't match 1000
UID_TO_TEST_FOR='1000'
if [[ "${UID_TO_TEST_FOR}" -ne "${UID}" ]]
then 
    echo "Your UID doesn't match ${UID_TO_TEST_FOR}"
    exit 1      # 1 for unsuccessful completion, there are various codes for different exit (convention)
fi

# Display the username
USER_NAME=$(id -u -n)   # this might fail if we put wrong option eg -x

# Test if the command succeded
if [[ "${?}" -ne 0 ]]   # $? contains exit status of last command
then    
    echo "The id command did not execute successfully"
    exit 1
fi
echo "Your name is ${USER_NAME}"

# Use string test conditional
USER_NAME_TO_TEST_FOR='vagrant'
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]]    # Note inside [[ ]] = is used for equality comparision
then    
    echo "Your username matches ${USER_NAME_TO_TEST_FOR}."
fi

# Test for !- (not equal) for string
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then
    echo "Your username doesn't match ${USER_NAME_TO_TEST_FOR}."
    exit 1
fi

exit 0