#!/bin/bash

files=$(find . -type f|grep -Ev '^\./\.git/'|grep -v setup.sh)
for file in $files; do
  rm "$HOME/$file"
  ln -s "$(pwd)/$file" "$HOME/$file"
done
