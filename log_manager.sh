#!/bin/bash

get_user_input() {
  echo "Enter the log directory path:"
  read log_dir

  echo "Enter number of days old:"
  read days_old

  echo "Enter search pattern (ERROR, WARN,INFO etc):"
  read search_pattern

  echo "Do you want to count (c) or extract (e) matches? (c/e):"
  read mode

  echo "Do you want to archive old logs? (yes/no):"
  read archive_choice

  if [ "$archive_choice" = "yes" ];
  then
    echo "Enter archive destination folder path:"
    read archive_dir
    mkdir -p "$archive_dir"
  fi
}

search_logs() {
  echo "Searching logs older than $days_old days in $log_dir..."
  find "$log_dir" -type f -mtime +"$days_old" | while read file; do
    echo "Processing $file"
    if [ "$mode" = "c" ]; then
      grep -i "$search_pattern" "$file" | wc -l
    else
      grep -i "$search_pattern" "$file"
    fi
  done
}

archive_logs() {
  echo "Archiving logs older than $days_old days..."
  timestamp=$(date +%Y%m%d_%H%M%S)
  archive_file="$archive_dir/logs_archive_$timestamp.tar.gz"

  files_to_archive=$(find "$log_dir" -type f -mtime +"$days_old")

  if [ -n "$files_to_archive" ]; then
    tar -czf "$archive_file" $files_to_archive
    echo "Archive created: $archive_file"
    tar -tf "$archive_file" > /dev/null && echo "Archive verified"
    echo "$files_to_archive" | xargs rm -f
    echo "Old logs deleted after archiving."
  else
    echo "No files found to archive."
  fi
}