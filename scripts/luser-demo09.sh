#/bin/bash

# This script demonstrates the case statement.

# Traditional way: 
# if [[ ${1} = 'start' ]]
# then 
#     echo "Starting"
# elif [[ ${1} = 'stop' ]]
# then 
#     echo "Stopping"
# elif [[ ${1} = 'status' ]]
# then    
#     echo 'status report'
# else
#     echo 'Enter a valid option. ' 1>&2
#     exit 1
# fi

# Using case

case "${1}" in
    start) echo "Starting" ;;
    stop) echo "Stopping" ;;
    status|state) echo "Status Report" ;; # this is like or statement, matches both status and state 
    *)
        echo "Enter a valid option"
        exit 1
        ;;
esac