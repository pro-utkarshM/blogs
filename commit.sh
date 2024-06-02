#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <commit-message>"
  exit 1
fi

COMMIT_MESSAGE="$1"

git add .
git commit -m "$COMMIT_MESSAGE"
git push
if [ $? -eq 0 ]; then
  echo "   "
  echo "   "
  echo "   "
  echo "Changes pushed successfully!"
else
  echo "Failed to push changes."
fi
