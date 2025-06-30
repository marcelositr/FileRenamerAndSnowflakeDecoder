# File Renamer & Snowflake Decoder

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Language](https://img.shields.io/badge/language-Python-blue.svg)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow.svg)
![Build](https://img.shields.io/github/actions/workflow/status/marcelositr/FileRenamerAndSnowflakeDecoder/ci.yml?branch=main)
![Feito com](https://img.shields.io/badge/feito%20com-%F0%9F%A4%96%20%2B%20%F0%9F%A4%BB-critical)

[![Último commit](https://img.shields.io/github/last-commit/marcelositr/FileRenamerAndSnowflakeDecoder)](https://github.com/marcelositr/FileRenamerAndSnowflakeDecoder/commits/main)
[![Releases](https://img.shields.io/github/v/release/marcelositr/FileRenamerAndSnowflakeDecoder?label=release)](https://github.com/marcelositr/FileRenamerAndSnowflakeDecoder/releases)
[![Issues](https://img.shields.io/github/issues/marcelositr/FileRenamerAndSnowflakeDecoder)](https://github.com/marcelositr/FileRenamerAndSnowflakeDecoder/issues)
[![Stars](https://img.shields.io/github/stars/marcelositr/FileRenamerAndSnowflakeDecoder?style=social)](https://github.com/marcelositr/FileRenamerAndSnowflakeDecoder/stargazers)


A set of powerful Bash scripts to batch-rename media files into a unique, information-rich "snowflake" format and a companion script to easily decode them. This project is designed to bring order and traceability to large collections of photos and videos.

## The Problem It Solves

Standard camera-generated filenames like `IMG_1234.JPG` or `VID_5678.MP4` are not chronological and often lead to naming collisions when merging files from multiple sources. This project solves that by creating a descriptive and unique filename for every file.

## The Snowflake Filename Structure

The core of this project is its unique filename format, which embeds crucial metadata directly into the name.

**Format:** `FileDate-ExecTimestamp-RandomNum-StaticID.extension`

**Example:** `20230520153000-20240115100000-12345-marcelositr.jpg`

*   **`FileDate`**: The original creation date of the media (`YYYYMMDDHHMMSS`).
*   **`ExecTimestamp`**: The exact timestamp when the script renamed the file.
*   **`RandomNum`**: A random number to prevent collisions.
*   **`StaticID`**: Your personal or project-specific identifier.

> For a complete breakdown of the filename structure, please see the **[The Filename Structure](https://github.com/marcelositr/FileRenamerAndSnowflakeDecoder/wiki/The-Filename-Structure)** page on our Wiki.

---

## Key Features

-   **Intelligent Date Detection**: Prioritizes the EXIF `DateTimeOriginal` tag for accuracy and falls back to the file's modification time if EXIF is unavailable.
-   **Guaranteed Uniqueness**: A combination of two timestamps and a random number virtually eliminates the possibility of filename collisions.
-   **Idempotent by Design**: Safe to run multiple times in the same directory. The script automatically detects and skips files that have already been renamed.
-   **Traceability**: Each filename contains a record of when it was processed.
-   **Easy Decoding**: A simple companion script instantly translates any filename back into human-readable information.
-   **Detailed Logging**: All operations (renames, skips, errors) are logged to a file for review.
-   **User-Friendly**: Includes a confirmation prompt to prevent accidental execution.

---

## Getting Started

### Prerequisites

You must have the following tools installed:

1.  **Bash**: Standard on most Linux and macOS systems.
2.  **ExifTool**: A powerful command-line tool for reading and writing metadata.

To install `exiftool` on Debian/Ubuntu-based systems:
```bash
sudo apt-get update && sudo apt-get install libimage-exiftool-perl
```

### Installation

1.  Clone the repository to your local machine:
    ```bash
    git clone https://github.com/marcelositr/FileRenamerAndSnowflakeDecoder.git
    ```
2.  Navigate into the project directory:
    ```bash
    cd FileRenamerAndSnowflakeDecoder
    ```
3.  Make the scripts executable:
    ```bash
    chmod +x rename_files.sh decode_snowflake.sh
    ```

### Configuration

Before running the script, open `rename_files.sh` and customize the `STATIC_PART` variable with your own identifier.

```bash
# --- Configuration ---
readonly STATIC_PART="marcelositr" # <-- Change this to your handle!
```

---

## Usage / Workflow

### Step 1: Renaming Your Files

Run the `rename_files.sh` script from the directory containing your media files. It will recursively scan all subdirectories.

```bash
./rename_files.sh
```

The script will ask for confirmation and then begin processing.

**Example Output:**
> ```
> Renaming: 'IMG_5432.JPG' -> '20230520153000-20240115100000-12345-marcelositr.JPG'
> Skipping (already renamed): 20221110090000-20240110183000-54321-marcelositr.MOV
> ```

### Step 2: Decoding a Filename

To verify the information embedded in a new filename, use the `decode_snowflake.sh` script.

```bash
./decode_snowflake.sh 20230520153000-20240115100000-12345-marcelositr.JPG
```

**Example Output:**
> ```
> --- Decoded Information for: 20230520153000-20240115100000-12345-marcelositr.JPG ---
> File Date           : 20230520153000
> Execution Timestamp : 20240115100000
> Random Number       : 12345
> Static Identifier   : marcelositr
> ----------------------------------------------------
> ```

---

## Detailed Documentation

For more in-depth information, guides, and explanations, please visit the **[Official Project Wiki](https://github.com/marcelositr/FileRenamerAndSnowflakeDecoder/wiki)**.

## Contributing

Contributions are welcome! If you find a bug or have an idea for an improvement, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
