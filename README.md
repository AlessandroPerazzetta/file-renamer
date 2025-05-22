# File Renamer

A shell script utility to rename TV show episodes with a specific pattern.

## Description

This script renames files in a directory structure, adjusting the episode filenames to include the season number. It processes files matching the pattern `E##_*.*` and prepends the season number from the parent directory name.

## Usage

1. Place the script in the parent directory containing TV show season folders
2. Run the script:
    ```bash
    ./file-renamer.sh <directory_path>
    ```

The script will:
- Search for season directories (format: `Season##`)
- Find episode files (format: `E##_*.extension`)
- Rename them to: `S##E##_*.extension`

Example:
```
Before:
S1/E01_Episode_Name.mp4

After:
S1/S01E01_Episode_Name.mp4
```