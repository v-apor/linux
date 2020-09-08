#!/bin/bash

# Demonstrate the use of shift and while loops

# Display the first 3 parameters.
echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"
echo

# Simple While loop
X=1
while [[ "${X}" -eq 1 ]]
do 
    echo "The value of X is: ${X}"
    X=8
done

# Infinite loop
#while [[ true ]]
#do  
#    echo ${RANDOM}
#    sleep 1
#done

# Shift: Shift positional parameters
# Loop through all the parameters
while [[ "${#}" -gt 0 ]]
do  
    echo "Number of parameters: ${#}"
    echo "Parameter 1: ${1}"
    echo "Parameter 2: ${2}"
    echo "Parameter 3: ${3}"
    echo
    shift
done    