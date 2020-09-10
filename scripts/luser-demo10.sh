#/bin/bash

# log() {
#     echo 'You called the log function!'
# }

# log

# log2(){
#     local MESSAGE=${@}  # local variable def
#     echo "${MESSAGE}"
# }

# log2 "Hello!"
# log2 "This is v-apor!"

# log3(){
#     local MESSAGE=${@}  
#     if [[ "${VERBOSE}" = 'true' ]]      # Global variable
#     then
#         echo "${MESSAGE}"
#     fi
# }

# log3 "Hello!"
# VERBOSE='true'
# log3 "This is v-apor!"

# log3(){
#     local MESSAGE=${@}  
#     if [[ "${VERBOSE}" = 'true' ]]      # Global variable
#     then
#         echo "${MESSAGE}"
#     fi
# }

# log3 "Hello!"
# readonly VERBOSE='true'         # This makes it kinda final (it won't change ever)
# log3 "This is v-apor!"

log3(){
    # This function sends a message to syslog and to standard output if VERBOSE is true
    local MESSAGE=${@}  
    if [[ "${VERBOSE}" = 'true' ]]      
    then
        echo "${MESSAGE}"
    fi
    logger -t luser-demo10.sh "${MESSAGE}"  # This pushes to the log file /var/log/messages
}

backup_file() {
    # This function creates a backup of a file. Returns non-zero status as an error.

    local FILE="${1}"

    # Make sure the file exists.
    if [[ -f "${FILE}" ]]
    then    
        local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
        log3 "Backing up ${FILE} to ${BACKUP_FILE}."

        # The exit status of the function will be the exit status of the cp command.
        cp -p ${FILE} ${BACKUP_FILE}    # -p retains timestamp
    else
        # The file does not exists, so return a non-zero exit status.
        return 1
    fi
}

# log3 "Hello!"
# readonly VERBOSE='true'         
# log3 "This is v-apor!"

VERBOSE='true'
backup_file '/vagrant/luser-demo10.sha'

# Make a decision based on the exit status of the function.
if [[ "${?}" -eq '0' ]]
then    
    log3 'File backup succeeded!'
else    
    log3 'File backup failed!'
    exit 1
fi