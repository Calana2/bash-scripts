#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [input_file]"
  exit 1
fi

input_file="$1"
line_number=1

# Extract and process base64 images inside a svg image
grep -oP 'data:image\/\w+;base64,[^"]+' "$input_file" | while IFS= read -r line
do
  # Extract MIME type and base64 data
  mime_type=$(echo "$line" | grep -oP 'data:image\/\w+' | sed 's/data:image\///')
  base64_data=$(echo "$line" | sed 's/^[^,]*,//')

  # Decode and save with the correct extension
  if [ -n "$mime_type" ]; then
    echo "$base64_data" | base64 --decode > "image_$line_number.$mime_type"
    ((line_number++))
  else
    echo "Could not determine MIME type for image $line_number"
  fi
done
