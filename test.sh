#!/usr/bin/env bash
# Simple test runner. Exits with failure if any test fails.

export TODO_FILE="test_tasks.txt"
FAILED=0

setup() { rm -f "$TODO_FILE"; }

check() {
  if [ "$2" = "$3" ]; then
    echo "PASS: $1"
  else
    echo "FAIL: $1 (expected '$3', got '$2')"
    FAILED=1
  fi
}

# Test 1: adding a task
setup
./todo.sh add "Buy milk" > /dev/null
check "add task" "$(cat "$TODO_FILE")" "[ ] Buy milk"

# Test 2: empty title is rejected
setup
./todo.sh add "" > /dev/null 2>&1
check "empty title rejected" "$?" "1"

# Test 3: completing a task
setup
./todo.sh add "Learn CI" > /dev/null
./todo.sh "done" 1 > /dev/null
check "complete task" "$(cat "$TODO_FILE")" "[x] Learn CI"

# Test 4: completing a missing task fails
setup
./todo.sh "done" 99 > /dev/null 2>&1
check "missing task rejected" "$?" "1"

rm -f "$TODO_FILE"
exit $FAILED
