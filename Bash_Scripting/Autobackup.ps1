#!/bin/bash

# Prompt the user for a directory path
read -p "Enter the full path of the directory to back up: " DIR_PATH

# Check if the directory exists
if[[ ! -d "$DIR_PATH" ]]; then
    echo "Error: Directory '$DIR_PATH' does not exist."
    exit 1
fi

# Get the current date in YYYY-MM-DD format
DATE=$(date +%F)

# Extract just the directory name from the path
DIR_NAME=$(basename "$DIR_PATH")

# Set the backup filename
BACKUP_FILE="backup_${DIR_NAME}_${DATE}.tar.gz"

# Compress the directory
tar -czf "$BACKUP_FILE" -C "$(dirname "$DIR_PATH")" "$DIR_NAME"

echo"Backup created successfully: $BACKUP_FILE"
