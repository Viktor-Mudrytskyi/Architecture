#!/usr/bin/env bash

LIB_DIR="lib"

generate_barrel() {
  local dir="$1"
  local dir_name
  dir_name=$(basename "$dir")
  local barrel_file="${dir}/${dir_name}_src.dart"

  # Create / overwrite barrel file
  > "$barrel_file"

  # Optional header
  {
    echo "// GENERATED CODE - DO NOT MODIFY BY HAND"
    echo ""
  } >> "$barrel_file"

  # Export dart files in this directory
  for file in "$dir"/*.dart; do
    [ -f "$file" ] || continue
    local filename
    filename=$(basename "$file")

    # Skip barrel files and other generated files
    if [[ "$filename" == *_src.dart || "$filename" == *.g.dart ]]; then
      continue
    fi

    echo "export '$filename';" >> "$barrel_file"
  done

  # Recurse into subdirectories
  for subdir in "$dir"/*/; do
    [ -d "$subdir" ] || continue

    generate_barrel "$subdir"

    local subdir_name
    subdir_name=$(basename "$subdir")
    local sub_barrel="${subdir_name}_src.dart"

    echo "export '$subdir_name/$sub_barrel';" >> "$barrel_file"
  done

  echo "Created barrel: $barrel_file"
}

# Start recursion from lib subdirectories
for dir in "$LIB_DIR"/*/; do
  [ -d "$dir" ] || continue
  generate_barrel "$dir"
done
