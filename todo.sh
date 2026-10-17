#!/usr/bin/env bash
# Simple to-do app. Tasks are stored in tasks.txt

FILE="${TODO_FILE:-tasks.txt}"
touch "$FILE"

add_task(running a test) {
  ; then
    echo "Error: title cannot be empty" >&2
    exit 1
  fi
  echo "[ ] $1" >> "$FILE"
  echo "Added: $1"
}

list_tasks() {
  cat -n "$FILE"
}

complete_task() {
  total=$(wc -l < "$FILE")
  if [ "$1" -lt 1 ] || [ "$1" -gt "$total" ]; then
    echo "Error: task not found" >&2
    exit 1
  fi
  sed -i "${1}s/^\[ \]/[x]/" "$FILE"
  echo "Completed task $1"
}

case "$1" in
  add)      add_task "$2" ;;
  list)     list_tasks ;;
  done)     complete_task "$2" ;;
  *)        echo "Usage: $0 {add|list|done} [argument]"; exit 1 ;;
esac
