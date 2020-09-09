#!/bin/bash

# This script demonstrates I/O redirection

# Redirect STDOUT to a file
echo
FILE="/tmp/data"
echo "Hello World!" > ${FILE}

# Redirect STDIN to a program
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

# Redirect STDOUT to a file, overwriting the contents
echo 
echo "Contents of FILE before override: "
cat ${FILE}
echo "Overwritten Line" > ${FILE}
echo "Contents after of FILE after overwrite: "
cat ${FILE}


# Appending to a file
echo 
echo "Before Appending: "
cat ${FILE}
echo "Appended line" >> ${FILE}
echo "After Appending: "
cat ${FILE}

# Redirect STDIN to a program using FD 0
read LINE 0< ${FILE}
echo 
echo "LINE contains: ${LINE}"

# Redirecting STDOUT to a file using FD 1, overwriting the file.
head -n3 /etc/passwd 1> ${FILE}
echo 
echo "Contents of ${FILE}"
cat ${FILE}

# Redirecting STDERR to a file using FD 2
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}

# Redirecting both STDOUT and STDERR to a single file
head -n3 /etc/passwd /fakefile &> ${FILE}
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirecting both STDOUT and STDERR through a pipe
echo
head -n3 /etc/passwd /fakefile |& cat -n

# Send output to SRDERR
echo "This is STDERR!" >&2

# Discard STDOUT and STDERR using /dev/null location 
echo 
echo "Discarding both STDIN and STDERR"
head -n3 /etc/passwd /fakefile &> /dev/null

# Clean up
rm ${FILE} ${ERR_FILE} &> /dev/null