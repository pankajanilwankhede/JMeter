#!/bin/bash

# Create a "backup" directory in the user's home directory if it doesn't exist
BACKUP_DIR="$HOME/backup"
mkdir -p "$BACKUP_DIR"

# Get the current date and time in the format YYYY-MM-DD_HH-MM-SS
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Loop over all .txt files in the current directory
for file in *.txt; do
    # Check if any .txt files exist
    if [[ -f "$file" ]]; then
        # Extract filename without extension
        BASENAME=$(basename "$file" .txt)
        # Construct the new filename with the timestamp
        NEW_FILENAME="${BASENAME}_${TIMESTAMP}.txt"
        # Copy the file to the backup directory with the new name
        cp "$file" "$BACKUP_DIR/$NEW_FILENAME"
    fi
done

echo "Backup complete. Files copied to $BACKUP_DIR."
