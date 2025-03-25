#!/bin/bash

# Check if directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/json/files"
  exit 1
fi

TARGET_DIR="$1"

# Walk through the directory and process each .json file
find "$TARGET_DIR" -type f -name "*.json" | while read -r json_file; do
  dir_name=$(dirname "$json_file")
  full_base_name=$(basename "$json_file" .json)

  # Remove date suffix like _2020-09-22145302 or _2020-09-220415302
  base_name=$(echo "$full_base_name" | sed -E 's/_[0-9]{4}-[0-9]{2}-[0-9]{8}$//')

  tarball="${dir_name}/${base_name}.tar.gz"

  echo "Compressing: $json_file -> $tarball"
  tar -czf "$tarball" -C "$dir_name" "$(basename "$json_file")"
done

echo "Compression completed."

