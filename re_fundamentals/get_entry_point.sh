#!/bin/bash
source ./messages.sh
# Fixed file name
file_name="task1"

# Check if the file exists and is readable
if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

# Check if the file is an ELF file
if ! file "$file_name" | grep -q "ELF"; then
    echo "Error: File '$file_name' is not a valid ELF file."
    exit 1
fi

# Extract ELF header information using readelf
magic_number=$(readelf -h "$file_name" | grep "Magic:" | awk '{$1=""; print $0}')
class=$(readelf -h "$file_name" | grep "Class:" | awk '{print $2}')
byte_order=$(readelf -h "$file_name" | grep "Data:" | awk -F, '{print $2}' | xargs)
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | awk '{print $NF}')

display_elf_header_info
