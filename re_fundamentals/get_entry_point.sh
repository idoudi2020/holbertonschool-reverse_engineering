#!/bin/bash

# Charger le script de messages
source ./messages.sh

# Vérifier qu'un seul argument est fourni
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <elf_file>"
    exit 1
fi

# Vérifier si le fichier existe
file_name="$1"
if [ ! -f "$file_name" ]; then
    echo "Error: '$file_name' is not a valid file."
    exit 1
fi

# Vérifier si le fichier est un ELF
if ! file "$file_name" | grep -q "ELF"; then
    echo "Error: '$file_name' is not an ELF file."
    exit 1
fi

# Extraire les informations de l'en-tête ELF avec readelf
magic_number=$(readelf -h "$file_name" | awk '/Magic:/ {print substr($0, index($0,$2))}')
class=$(readelf -h "$file_name" | awk '/Class:/ {print $2}')
byte_order=$(readelf -h "$file_name" | awk -F, '/Data:/ {print $2}' | xargs)
entry_point_address=$(readelf -h "$file_name" | awk '/Entry point address:/ {print $4}')

# Exporter les variables pour messages.sh
export file_name
export magic_number
export class
export byte_order
export entry_point_address

# Afficher les informations formatées
display_elf_header_info

