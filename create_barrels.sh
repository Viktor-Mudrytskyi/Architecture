#!/usr/bin/env bash

ROOT_DIR="lib"

find "$ROOT_DIR" -type d | while read -r dir; do
  dir_name="$(basename "$dir")"
  barrel_file="$dir/${dir_name}_src.dart"

  exports=()

  # Dart files in current directory (non-recursive)
  while IFS= read -r file; do
    file_name="$(basename "$file")"
    exports+=("export '$file_name';")
  done < <(
    find "$dir" -maxdepth 1 -type f -name "*.dart" \
      ! -name "${dir_name}_src.dart"
  )

  # Barrel files from immediate subdirectories
  while IFS= read -r subdir; do
    sub_name="$(basename "$subdir")"
    sub_barrel="$subdir/${sub_name}_src.dart"

    if [[ -f "$sub_barrel" ]]; then
      exports+=("export '${sub_name}/${sub_name}_src.dart';")
    fi
  done < <(
    find "$dir" -maxdepth 1 -type d ! -path "$dir"
  )

  # Skip if nothing to export
  if [[ ${#exports[@]} -eq 0 ]]; then
    continue
  fi

  echo "Generating $barrel_file"

  {
    echo "// GENERATED FILE - DO NOT MODIFY BY HAND"
    echo
    for line in "${exports[@]}"; do
      echo "$line"
    done
  } > "$barrel_file"

done
