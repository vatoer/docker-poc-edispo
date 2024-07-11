#!/bin/bash

# Prompt the user to enter a password
echo -n "type your password: "
read -s password
echo

# Function to generate a BCrypt hash
generate_bcrypt_hash() {
    # Using bcrypt utility, adjust path if necessary
    hashed_password=$(htpasswd -bnBC 10 "" "$password" | tr -d ':\n')
    echo "${hashed_password#*\$}"
}

# Generate the hashed password
hashed_password=$(generate_bcrypt_hash)

# Output the hashed password
echo "generated hash: "
echo "USER_SECRET_KEY=$hashed_password"
echo "save this hash to your .env.fileserver"