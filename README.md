======================================================
README.txt - File Renaming and Snowflake Decoding Scripts
======================================================

-------------------
English
-------------------

These scripts are used for renaming files in a specific format and decoding the filenames for details.

1. rename_files.sh
-------------------
This script renames files in the current directory and subdirectories using a specific format:
YYYYMMDDHHMMSS-timestamp-randomNumber-staticPart.ext

Usage:
1. Ensure exiftool is installed.
2. Save rename_files.sh and make it executable:
   chmod +x rename_files.sh
3. Run the script:
   ./rename_files.sh

The script will prompt for confirmation before renaming the files. A log of renamed files will be saved in rename_log.txt.

2. decode_snowflake.sh
-----------------------
This script decodes filenames to extract the date, timestamp, random number, and static part.

Usage:
1. Save decode_snowflake.sh and make it executable:
   chmod +x decode_snowflake.sh
2. Run the script with the filename as an argument:
   ./decode_snowflake.sh <filename>

The script will print the extracted components of the filename.

-------------------
Español
-------------------

Estos scripts se utilizan para renombrar archivos en un formato específico y decodificar los nombres de los archivos para obtener detalles.

1. rename_files.sh
-------------------
Este script renombra archivos en el directorio actual y subdirectorios utilizando un formato específico:
YYYYMMDDHHMMSS-timestamp-númeroAleatorio-parteEstática.ext

Uso:
1. Asegúrese de que exiftool esté instalado.
2. Guarde rename_files.sh y hágalo ejecutable:
   chmod +x rename_files.sh
3. Ejecute el script:
   ./rename_files.sh

El script solicitará confirmación antes de renombrar los archivos. Se guardará un registro de los archivos renombrados en rename_log.txt.

2. decode_snowflake.sh
-----------------------
Este script decodifica los nombres de los archivos para extraer la fecha, marca de tiempo, número aleatorio y parte estática.

Uso:
1. Guarde decode_snowflake.sh y hágalo ejecutable:
   chmod +x decode_snowflake.sh
2. Ejecute el script con el nombre del archivo como argumento:
   ./decode_snowflake.sh <nombre_del_archivo>

El script imprimirá los componentes extraídos del nombre del archivo.

-------------------
Português
-------------------

Estes scripts são usados para renomear arquivos em um formato específico e decodificar os nomes dos arquivos para obter detalhes.

1. rename_files.sh
-------------------
Este script renomeia arquivos no diretório atual e subdiretórios usando um formato específico:
YYYYMMDDHHMMSS-timestamp-númeroAleatório-parteEstática.ext

Uso:
1. Certifique-se de que exiftool esteja instalado.
2. Salve rename_files.sh e torne-o executável:
   chmod +x rename_files.sh
3. Execute o script:
   ./rename_files.sh

O script solicitará confirmação antes de renomear os arquivos. Um log dos arquivos renomeados será salvo em rename_log.txt.

2. decode_snowflake.sh
-----------------------
Este script decodifica nomes de arquivos para extrair a data, marca de tempo, número aleatório e parte estática.

Uso:
1. Salve decode_snowflake.sh e torne-o executável:
   chmod +x decode_snowflake.sh
2. Execute o script com o nome do arquivo como argumento:
   ./decode_snowflake.sh <nome_do_arquivo>

O script imprimirá os componentes extraídos do nome do arquivo.
