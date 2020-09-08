#!/bin/bash

# This script generates a random password for each user specified on the command line.

# Display what the user typed on the command line.
echo "You executed this command: ${0}"   # ${0} is positional parameter (name of script called).
# Note diff b/w argument and parameter; parameter is a variable, arg is the value passed to the variable.

# Display the path and filename of the script
echo "You used $(basename ${0}) script of $(dirname ${0}) directory"

# Tell how many arguments they passed in
NUMBER_OF_PARAMETERS="${#}"     # for number of arguments passed
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line"

# Make sure they supply atleast 1 arguments
if [[ ${NUMBER_OF_PARAMETERS} -lt 1 ]]
then 
    echo "Usage: ${0} USER_NAME [USER_NAME]..."
    exit 1
fi

# Generate and displau a password for each parameter
for USER_NAME in "${@}"     # Note ${@} is a special list of all arguments (space seperated).
do 
    PASSWORD=$(date +%s%N | sha256sum | head -c48)
    echo "${USER_NAME}: ${PASSWORD}"
done
