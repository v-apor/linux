#!/bin/bash
# The above line is (#: Sharp) + (!: Bang) = (#!: Shbang) used to let script know how to run the script at runtime.
# Hence, #!/bin/bash means it'll be executed by bash command inside /bin/ directory (This'll make sure it works on multiple systems)

# This script displays various things on screen
echo "Hello World!"

# Assign a value to a variable
WORD='script'

# Display value stored in variable
echo '$WORD'    # Singl quote to display as it is
echo "$WORD"    # double quote is for expanding value of variable after $

# Combine the variable with hard coded text.
echo "This is a shell $WORD"

# Alternate method for using variables.
echo "This is a shell ${WORD}"

# Append text to the variable
echo "${WORD}ing is fun!!"
echo "$WORDing is fun, if it works :("    # This won't work, b'cos can't decode variable

# Create a new variable
ENDING='ed'

# Combine two variables
echo "This is ${WORD}${ENDING}"

# Reassignment: Change the value stored in the ENDING variable
# This works because bash script is run top to bottom
ENDING='ing'
echo "${WORD}${ENDING} is fun!"