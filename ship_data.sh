#!/bin/bash

# Check if directory is provided
if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/tarballs"
  exit 1
fi

TARGET_DIR="$1"

# Walk through the directory and process each .tar.gz file
find "$TARGET_DIR" -type f -name "*.tar.gz" | while read -r tar_file; do
  base_name=$(basename "$tar_file" .tar.gz)

  echo "Processing: $tar_file"
  python3 scripts/data-shippers/Mordor-Elastic.py --url http://localhost:9200 -i "$base_name" --input "$tar_file"
done

echo "Data shipping completed."

