#/bin/bash

# Add redirection to remove unnecessary outputs

CURRUSER=$(id -u)
if [[ ${CURRUSER} -ne 0 ]]
then
    echo "Please run the script as root user. " 1>&2 # 1 not necessary
    exit 1
fi

if [[ ${#} -lt 1 ]]
then 
    echo "Usage: $(basename ${0}) USERNAME [COMMENT]..." >&2
    echo 'Create an account on the local system with the name of USER_NAME and a comment field COMMENT'  >&2
    exit 1
fi

USERNAME=${1}
shift               # This shifts positional parameters by 1
COMMENT=${@}
PASSWORD="$(echo '${RANDOM}$(date +%sN)${RANDOM}' | sha256sum | head -c16)"
useradd -c "${COMMENT}" -m ${USERNAME} &> /dev/null # send all output to null

# Check if the account was created

if [[ ${?} -ne 0 ]]
then
    echo "The account cannot be created" >&2
    exit 1
fi

echo ${PASSWORD} | passwd --stdin ${USERNAME} &> /dev/null

if [[ ${?} -ne 0 ]]
then
    echo "The password cannot be set" >&2
    exit 1
fi

# To force password change on first login 
passwd --expire ${USERNAME} &> /dev/null

# Display the details
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Hostname: ${HOSTNAME}"

exit 0