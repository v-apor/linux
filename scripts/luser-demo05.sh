#!/bin/bash

# This Script generates a list of random passwords

# A random number as a password
PASSWORD=${RANDOM}
echo ${PASSWORD}

# Three random numbers together
PASSWORD=${RANDOM}${RANDOM}${RANDOM}
echo ${PASSWORD}

# Using date as password, %s returns seconds since 01/01/1970
PASSWORD=$(date +%s)
echo $PASSWORD          # This can be guessed 

# We can use both seconds and nano seconds since 01/01/1970
PASSWORD=$(date +%N%s)
echo $PASSWORD

# Using checksums
PASSWORD=$(date +%s%N | sha256sum)
echo ${PASSWORD}                # We see that it's quite big

# Trimming checksum using head
PASSWORD=$(date +%sN | sha256sum | head -c10)
echo ${PASSWORD}                # Now it's 10 char long (using head with c option)

# Making it a bit more secure
PASSWORD=$(date +%sN${RANDOM}${RANDOM} | sha256sum | head -c16)
echo ${PASSWORD}         

# Adding special character
SPECIAL_CHARACTER=$(echo '!@#$%^&*()-_=+' | fold -w1 | shuf | head -c1)
PASSWORD=$(date +%sN${RANDOM}${RANDOM} | sha256sum | head -c16)
echo ${SPECIAL_CHARACTER}${PASSWORD}