#/bin/bash

#This script disables, deletes, and/or archives users on the local system.

ARCHIVE_DIR='/archive'

usage() {
    echo "Usage: ${0} USERNAME [-dra] [USERNAME]...  " >&2
    echo "Disables a local linux account" >&2
    echo '  -d  Deletes account instead of disabling them.' >&2
    echo '  -r  Removes the home directory associated with the account(s).' >&2
    echo '  -a  Creates an archive of the home directory associated with the account(S).' >&2
    exit 1
}

# Check if it is executed as root

if [[ ${UID} -ne 0 ]]
then
    echo "Ensure this cmd is run as root or through sudo." >&2
    exit 1
fi

# Parse the options
while getopts dra OPTION
do
    case ${OPTION} in
        d) DELETE_USER='true' ;;
        r) REMOVE_OPTION='-r' ;;
        a) ARCHIVE='true' ;;
        ?) usage ;;
    esac
done
    
# Remove the options specified

shift $(( OPTIND - 1 ))

# If less than 1 account specified
if [[ ${#} -lt 1 ]]
then
    usage
fi

# Loop through all the usernames supplied as arguments

for USER in ${@}
do 
    echo "Processing user: ${USER}"

    # Make sure the UID of the account is at least 1000. cos lower are system accounts.
    USERID=$(id -u ${USER})
    if [[ ${USERID} -lt 1000 ]]
    then 
        echo "Refusing to remove the ${USER} account with UID ${USERID}." >&2
        exit 1
    fi

    # Create an archife if requested
    if [[ ${ARCHIVE} = 'true' ]]
    then 
        # Make sure the ARCHIVE_DIR directory exists.
        if [[ ! -d "${ARCHIVE_DIR}" ]]
        then
            echo "Creating ${ARCHIVE_DIR} directory."
            mkdir -p ${ARCHIVE_DIR}
            if [[ ${?} -ne 0 ]]
            then    
                echo "The archive directory ${ARCHIVE_DIR} cannot be created." >&2
                exit 1
            fi
        fi

        # Archive the user's home directory and move to ARCHIVE_DIR
        HOME_DIR="/home/${USER}"
        ARCHIVE_FILE="${ARCHIVE_DIR}/${USER}.tgz"

        if [[ -d "${HOME_DIR}" ]]
        then 
            echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
            tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
            if [[ ${?} -ne 0 ]]
            then    
                echo "Could not create ${ARCHIVE_FILE}" >&2
                exit 1
            fi
        else
            echo "${HOME_DIR} doen't exists or is not a directory." >&2
            exit 1
        fi
    fi

    if [[ ${DELETE_USER} = 'true' ]]
    then 
        # Delete the user
        userdel ${REMOVE_OPTION} ${USER}

        # Checking if userdel succeeded.
        if [[ ${?} -ne 0 ]]
        then
            echo "The account ${USER} was NOT deleted." >&2
            exit 1
        fi
        echo "The account was ${USER} was deleted"
    else
        chage -E 0 ${USER}
        if [[ ${?} -ne 0 ]]
        then
            echo "The account ${USER} was NOT disabled." >&2
            exit 1
        fi
        echo "The account was ${USER} was disabled"
    fi
done
