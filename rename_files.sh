#!/bin/bash
#===============================================================================
#
#          FILE: rename_files.sh
#
#         USAGE: ./rename_files.sh
#
#   DESCRIPTION: Bash script to rename files in a specified format based on
#                exif data or file modification time and generate a Snowflake ID.
#                Script Bash para renomear arquivos em um formato específico
#                baseado em dados exif ou hora de modificação e gerar um ID Snowflake.
#
#       OPTIONS: -h for help
#                -h para ajuda
#  REQUIREMENTS: bash, exiftool
#          BUGS: n/a
#         NOTES: Requires exiftool for extracting exif data.
#        AUTHOR: marcelositr - marcelost@riseup.net
#       CREATED: 2024/07/11
#       VERSION: 1.0
#      REVISION: n/a
#
#===============================================================================

# Static part of the filename
# Parte estática del nombre del archivo
# Parte estática do nome do arquivo
STATIC_PART="marcelositr"

# File extensions to be processed
# Extensiones de archivo a procesar
# Extensões de arquivo a serem processadas
EXTENSIONS="*.jpg *.jpeg *.mov *.mp4 *.raw *.webm *.webp"

# Check if exiftool is installed
# Verifica si exiftool está instalado
# Verifica se o exiftool está instalado
if ! command -v exiftool &> /dev/null; then
    echo "exiftool is not installed. Please install it and try again."
    echo "exiftool no está instalado. Por favor instálelo y vuelva a intentarlo."
    echo "exiftool não está instalado. Por favor, instale-o e tente novamente."
    exit 1
fi

# Function to generate a Snowflake ID
# Función para generar un ID de Snowflake
# Função para gerar um ID de Snowflake
generate_snowflake() {
    local timestamp random_number
    timestamp=$(date +"%Y%m%d%H%M%S")
    random_number=$(printf "%05d" $RANDOM)
    echo "${timestamp}-${random_number}-${STATIC_PART}"
}

# Function to log actions
# Función para registrar acciones
# Função para registrar ações
log_action() {
    local original_file="$1"
    local new_file="$2"
    echo "Renamed: $original_file -> $new_file" >> rename_log.txt
    echo "Renombrado: $original_file -> $new_file" >> rename_log.txt
    echo "Renomeado: $original_file -> $new_file" >> rename_log.txt
}

# Function to rename files
# Función para renombrar archivos
# Função para renomear arquivos
rename_files() {
    local dir="$1"
    find "$dir" -type f \( $(printf -- '-iname "%s" -o ' $EXTENSIONS | sed 's/ -o $//') \) | while read -r file; do
        # Extract date and time
        # Extraer fecha y hora
        # Extrair data e hora
        local date
        date=$(exiftool -DateTimeOriginal -d "%Y%m%d%H%M%S" "$file" | awk -F': ' '{print $2}')
        if [ -z "$date" ]; then
            date=$(date -r "$file" +"%Y%m%d%H%M%S")
        fi
        # Generate Snowflake ID
        # Generar ID de Snowflake
        # Gerar ID de Snowflake
        local snowflake extension new_name
        snowflake=$(generate_snowflake)
        extension="${file##*.}"
        new_name="${date}-${snowflake}.${extension}"
        mv "$file" "$(dirname "$file")/$new_name"
        log_action "$file" "$(dirname "$file")/$new_name"
    done
}

# Request user confirmation
# Solicitar confirmación del usuario
# Solicitar confirmação do usuário
read -p "Do you want to rename the files in the current directory and subdirectories? (y/n): " confirm
read -p "¿Desea renombrar los archivos en el directorio actual y subdirectorios? (s/n): " confirm
read -p "Deseja renomear os arquivos no diretório atual e subdiretórios? (s/n): " confirm
if [[ $confirm == "y" ]] || [[ $confirm == "s" ]]; then
    rename_files "."
    echo "Files renamed successfully. See rename_log.txt for details."
    echo "Archivos renombrados con éxito. Consulte rename_log.txt para obtener detalles."
    echo "Arquivos renomeados com sucesso. Veja rename_log.txt para detalhes."
else
    echo "Operation cancelled."
    echo "Operación cancelada."
    echo "Operação cancelada."
fi
