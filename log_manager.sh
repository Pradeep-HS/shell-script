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