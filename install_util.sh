#!/usr/bin/env bash

if [ $# = 0 ]; then
  echo "Usage: $(basename "$0") <util-name>"
  exit 1
fi

if [ ! -f "$1" ]; then 
  echo "file \`$1\` doesn't exist"
  exit 1
fi

set -e
bin_name=$(basename "$1" .sh)
if [ -f /usr/local/lib/"$1" ]; then
  rm /usr/local/lib/"$1"
fi
if [ -L /usr/local/bin/"$bin_name" ]; then
  rm /usr/local/bin/"$bin_name"
fi

cp "$1" /usr/local/lib/"$1" && \
ln -s /usr/local/lib/"$1" /usr/local/bin/"$bin_name" && \
echo "Successfully installed \`$1\`"

