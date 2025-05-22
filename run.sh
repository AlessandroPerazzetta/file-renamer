#!/bin/bash

# Check if path argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Store the base path
BASE_PATH="$1"

# Check if the directory exists
if [ ! -d "$BASE_PATH" ]; then
    echo "Error: Directory does not exist"
    exit 1
fi

# Find all files matching the pattern E\d\d_*.* recursively
find "$BASE_PATH" -type f -regextype posix-extended -regex ".*/E[0-9][0-9]_.*\.[^/]*" | while read -r file; do
    # Get the directory name (will be used as S00)
    dir_name=$(basename "$(dirname "$file")")
    
    # Convert directory name to proper format (S1 -> S01)
    if [[ $dir_name =~ ^S[0-9]$ ]]; then
        dir_name=$(echo "$dir_name" | sed 's/S\([0-9]\)/S0\1/')
    fi
    
    # Get the file name without the path
    file_name=$(basename "$file")
    
    # Extract the episode number (E00)
    episode_num=$(echo "$file_name" | grep -oP "E\d{2}")
    
    # Extract the rest of the filename after E00_
    remaining=$(echo "$file_name" | sed 's/^E[0-9][0-9]_//')
    
    # Create the new filename
    new_name="${dir_name}${episode_num}_${remaining}"
    
    # Get the directory path
    dir_path=$(dirname "$file")
    
    # Create the full new path
    new_path="$dir_path/$new_name"
    
    # Rename the file
    mv "$file" "$new_path"
    echo "Renamed: $file -> $new_path"
done