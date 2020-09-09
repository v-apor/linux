#/bin/bash
# Creates a new user on local system
# You must supply a username as an argument of the script
#storing username
CURRUSER=$(id -u)

if [[ ${CURRUSER} -ne 0 ]]
then
    echo "Please run the script as root user. "    
    exit 1
fi

if [[ ${#} -lt 1 ]]
then 
    echo "Usage: $(basename ${0}) USERNAME [COMMENT]..."
    echo 'Create an account on the local system with the name of USER_NAME and a comment field COMMENT'
    exit 1
fi

USERNAME=${1}
shift               # This shifts positional parameters by 1
COMMENT=${@}
PASSWORD="$(echo '${RANDOM}$(date +%sN)${RANDOM}' | sha256sum | head -c16)"
useradd -c "${COMMENT}" -m ${USERNAME}

# Check if the account was created

if [[ ${?} -ne 0 ]]
then
    echo "The account cannot be created"
    exit 1
fi

echo ${PASSWORD} | passwd --stdin ${USERNAME} 

if [[ ${?} -ne 0 ]]
then
    echo "The password cannot be set"
    exit 1
fi

# To force password change on first login 
passwd --expire ${USERNAME}

# Display the details
echo
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Hostname: ${HOSTNAME}"

exit 0