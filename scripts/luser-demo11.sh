#!/bin/bash

# This script generates a random password.
# This user can set the password length with -l and add a special character with -s.
# verbose mode can be enabled with -v.

# Set a default password length
LENGTH=48

log() {
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}"
    fi
}

usage() {
    echo
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo "Generate a random password"
    echo "  -l LENGTH   Specify the password length."
    echo '  -s          Append a special character to the password.'
    echo '  -v          Increase verbosity.'
    exit 1

}

while getopts vl:s OPTION
do
    case ${OPTION} in
    v) 
        VERBOSE='true'
        log 'Verbose mode ON.'
        ;;
    l) 
        LENGTH="${OPTARG}"
        ;;
    s)
        USE_SPECIAL_CHARACTER='true'
        ;;
    ?) 
        usage
        ;;
    esac
done

# echo "Number of args: ${#}"
# echo "first arg: ${1}"
# echo "second arg: ${2}"
# echo "thired arg: ${3}"

shift "$(( OPTIND - 1 ))"       # OPTIND contains total number of options passed

# echo "Number of args: ${#}"
# echo "first arg: ${1}"
# echo "second arg: ${2}"
# echo "thired arg: ${3}"

if [[ ${#} -gt 0 ]]
then 
    usage
    exit 1
fi

log "Generating a password."

PASSWORD=$(date +%s%M${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then 
    log 'Selecting a random special character.'
    SPECIAL_CHARACTER=$(echo '!@#$%^&*()-=_+' | fold -w1 | shuf | head -c1)
    PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done'
log 'Here is the password: '

# Display the password.
echo "${PASSWORD}"

exit 0