#!/bin/bash

# Input and output files
USER_LIST="user_list.txt"
CREDENTIALS_FILE="credentials.txt"

# Clear previous credentials file
> "$CREDENTIALS_FILE"

# Check if user_list.txt exists
if[[ ! -f "$USER_LIST" ]]; then
    echo "Error: $USER_LIST not found!"
    exit 1
fi

# Read each username from the file
while IFS= read -r username || [[ -n "$username" ]]; do
    if id "$username" &>/dev/null; then
        echo"User '$username' already exists. Skipping."
    else
        # Create user without password
        sudo useradd "$username"

        # Generate random password (12 characters)
        password=$(openssl rand -base64 12)

        # Set the password for the user
        echo"$username:$password" | sudo chpasswd

        # Save username and password to credentials.txt
        echo"$username : $password" >> "$CREDENTIALS_FILE"

        echo"User '$username' created."
    fi
done < "$USER_LIST"

echo"All users processed. Credentials saved in '$CREDENTIALS_FILE'."
