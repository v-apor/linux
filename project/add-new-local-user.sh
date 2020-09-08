#/bin/bash

#storing username
CURRUSER=$(id -u)

if [[ ${CURRUSER} -ne 0 ]]
then
    echo "Please run the script as root user, syntax: "    
    echo "sudo $(basename ${0}) [USERNAME] [COMMENT]"
    exit 1
fi
USERNAME=${1}
shift
FULLNAME=${@}
echo ${@}
PASSWORD="${RANDOM}$(date +%sN)${RANDOM}"
useradd -c "${FULLNAME}" ${USERNAME}

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

passwd --expire ${USERNAME}

echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Hostname: ${HOSTNAME}"

exit 0