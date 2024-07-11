#!/bin/bash
#===============================================================================
#
#          FILE: decode_snowflake.sh
#
#         USAGE: ./decode_snowflake.sh <filename>
#
#   DESCRIPTION: Bash script to decode Snowflake ID from filenames and extract
#                timestamp, random number, and static part.
#                Script Bash para decodificar o ID Snowflake de nomes de arquivos
#                e extrair marca de tempo, número aleatório e parte estática.
#
#       OPTIONS: -h for help
#                -h para ajuda
#  REQUIREMENTS: bash
#          BUGS: n/a
#         NOTES: None
#        AUTHOR: marcelositr - marcelost@riseup.net
#       CREATED: 2024/07/11
#       VERSION: 1.0
#      REVISION: n/a
#
#===============================================================================

# Function to decode the filename
# Función para decodificar el nombre del archivo
# Função para decodificar o nome do arquivo
decode_snowflake() {
    local filename="$1"
    # Extract the filename without extension
    # Extraer el nombre del archivo sin extensión
    # Extrair o nome do arquivo sem a extensão
    local base_name
    base_name=$(basename "$filename" | sed 's/\.[^.]*$//')
    # Extract components of the Snowflake
    # Extraer componentes del Snowflake
    # Extrair componentes do Snowflake
    local date timestamp random_number identifier
    date=$(echo "$base_name" | cut -d '-' -f 1)
    timestamp=$(echo "$base_name" | cut -d '-' -f 2)
    random_number=$(echo "$base_name" | cut -d '-' -f 3)
    identifier=$(echo "$base_name" | cut -d '-' -f 4)

    echo "Date: $date"
    echo "Fecha: $date"
    echo "Data: $date"
    echo "Timestamp: $timestamp"
    echo "Marca de tiempo: $timestamp"
    echo "Carimbo de data/hora: $timestamp"
    echo "Random Number: $random_number"
    echo "Número Aleatorio: $random_number"
    echo "Número Aleatório: $random_number"
    echo "Identifier: $identifier"
    echo "Identificador: $identifier"
    echo "Identificador: $identifier"
}

# Check if filename was provided
# Verificar si se proporcionó el nombre del archivo
# Verificar se o nome do arquivo foi fornecido
if [ -z "$1" ]; then
    echo "Usage: $0 <filename>"
    echo "Uso: $0 <nombre_del_archivo>"
    echo "Uso: $0 <nome_do_arquivo>"
    exit 1
fi

decode_snowflake "$1"
