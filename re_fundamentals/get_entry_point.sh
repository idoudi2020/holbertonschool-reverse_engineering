#!/bin/bash

# Vérifier si le fichier est fourni en argument
if [ -z "$1" ]; then
    echo "Erreur : Aucun fichier ELF spécifié."
    exit 1
fi

file_name=$1

# Vérifier si le fichier existe et s'il est un fichier ELF valide
if [ ! -f "$file_name" ]; then
    echo "Erreur : Le fichier '$file_name' n'existe pas."
    exit 1
fi

# Vérification du type ELF
file_type=$(file "$file_name" | grep -o 'ELF')
if [ "$file_type" != "ELF" ]; then
    echo "Erreur : Le fichier '$file_name' n'est pas un fichier ELF valide."
    exit 1
fi

# Extraire les informations de l'en-tête ELF
magic_number=$(xxd -l 4 -p "$file_name")
class=$(readelf -h "$file_name" | grep "Class" | awk '{print $2}')
byte_order=$(readelf -h "$file_name" | grep "Data" | awk '{print $2}')
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address" | awk '{print $4}')

# Formater et afficher les informations
source ./messages.sh

magic_number="0x$magic_number"
display_elf_header_info

