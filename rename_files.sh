#!/bin/bash
#===============================================================================
#          FILE: rename_files.sh
#         USAGE: ./rename_files.sh
#   DESCRIPTION: Renames media files based on EXIF or modification time,
#                adding a unique ID for traceability. The script is idempotent.
#  REQUIREMENTS: bash, exiftool
#        AUTHOR: marcelositr - marcelost@riseup.net
#       VERSION: 1.0
#===============================================================================

# --- Configuration ---
readonly STATIC_PART="marcelositr"
readonly -a EXTENSIONS=("*.jpg" "*.jpeg" "*.mov" "*.mp4" "*.raw" "*.webm" "*.webp")
readonly LOG_FILE="rename_log.txt"

# --- Functions ---

# Checks if a required command is available in the system's PATH.
check_dependency() {
    if ! command -v "$1" &> /dev/null; then
        echo "Error: Required command '$1' is not installed." >&2
        echo "Please install it and try again." >&2
        exit 1
    fi
}

# Extracts the media's creation date.
# Tries EXIF 'DateTimeOriginal' first, then falls back to file modification time.
# @param $1: The path to the file.
# @return: The date in YYYYMMDDHHMMSS format, or empty string if error.
get_media_creation_date() {
    local filepath="$1"
    local file_date

    # Use -s3 (-s -s -s) for terse output, just the value.
    file_date=$(exiftool -s3 -DateTimeOriginal -d "%Y%m%d%H%M%S" "$filepath")

    if [[ -z "$file_date" ]]; then
        # Fallback to file modification time.
        file_date=$(date -r "$filepath" +"%Y%m%d%H%M%S")
    fi
    
    echo "$file_date"
}

# Generates a unique ID part for the filename.
# Format: ExecutionTimestamp-RandomNumber-StaticPart
generate_unique_id() {
    local timestamp
    local random_number
    timestamp=$(date +"%Y%m%d%H%M%S")
    random_number=$(printf "%05d" $RANDOM)
    echo "${timestamp}-${random_number}-${STATIC_PART}"
}

# Logs an action to the log file with a timestamp.
log_action() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Renames a single file according to the defined format.
# @param $1: The path to the file to be renamed.
# @return: 0 for success, 1 for skipped, 2 for error.
rename_file() {
    local filepath="$1"
    local filename
    filename=$(basename "$filepath")

    # Idempotency check: Skip if the file already seems to be in the target format.
    # The regex checks for: 14digits-14digits-5digits-staticpart.extension
    if [[ "$filename" =~ ^[0-9]{14}-[0-9]{14}-[0-9]{5}-${STATIC_PART}\. ]]; then
        echo "Skipping (already renamed): $filename"
        return 1
    fi

    local file_date
    file_date=$(get_media_creation_date "$filepath")

    if [[ -z "$file_date" ]]; then
        echo "Error: Could not determine date for '$filename'."
        log_action "ERROR: Could not get date for '$filepath'."
        return 2
    fi

    local unique_id extension new_name dir_path new_filepath
    unique_id=$(generate_unique_id)
    extension="${filepath##*.}"
    dir_path=$(dirname "$filepath")
    new_name="${file_date}-${unique_id}.${extension}"
    new_filepath="${dir_path}/${new_name}"

    echo "Renaming: '$filename' -> '$new_name'"
    if mv "$filepath" "$new_filepath"; then
        log_action "RENAMED: '$filepath' -> '$new_filepath'"
        return 0
    else
        echo "Error: Failed to rename '$filename'."
        log_action "ERROR: Failed to move '$filepath' to '$new_filepath'."
        return 2
    fi
}

# --- Main Execution ---

main() {
    check_dependency "exiftool"

    read -r -p "Rename files in the current directory and subdirectories? (y/n): " confirm
    echo # Newline for cleaner output

    if ! [[ "$confirm" =~ ^[yYsS] ]]; then
        echo "Operation cancelled by the user."
        exit 0
    fi

    local target_dir="."
    local renamed_count=0
    local skipped_count=0
    local error_count=0

    echo "Starting file renaming process in '$target_dir'..."
    echo "----------------------------------------------------"

    # To build the 'find' command arguments safely, we use an array.
    local find_args=()
    for ext in "${EXTENSIONS[@]}"; do
        find_args+=(-o -iname "$ext")
    done

    # The loop `while ... done < <(find ...)` is used to avoid creating a subshell,
    # allowing the counters (renamed_count, etc.) to be modified within the loop.
    # `find -print0` and `read -d ''` make the script robust against filenames
    # with spaces or special characters.
    while IFS= read -r -d '' file; do
        rename_file "$file"
        case $? in
            0) ((renamed_count++)) ;;
            1) ((skipped_count++)) ;;
            2) ((error_count++)) ;;
        esac
    done < <(find "$target_dir" -type f \( "${find_args[@]:1}" \) -print0)

    echo "----------------------------------------------------"
    echo "Process finished."
    echo "Summary: Renamed: $renamed_count, Skipped: $skipped_count, Errors: $error_count"
    echo "See '$LOG_FILE' for a detailed log."
}

# Run the main function with all script arguments
main "$@"
