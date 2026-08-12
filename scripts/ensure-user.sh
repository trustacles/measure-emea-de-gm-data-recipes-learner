#!/bin/bash
USER_FILE="$(dirname "$0")/../.user.yaml"
if [ ! -f "$USER_FILE" ]; then
  ID=$(python3 -c "import uuid; print(uuid.uuid4())")
  echo "id: $ID" > "$USER_FILE"
  echo "Created .user.yaml with a new developer id."
else
  echo ".user.yaml already exists — skipping."
fi