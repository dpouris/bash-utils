#!/usr/bin/env bash

if [ $# = 0 ]; then
  echo "Usage: $(basename "$0") <util-name>"
  exit 1
fi

if [ ! -f "$1" ]; then 
  echo "file \`$1\` doesn't exist"
  exit 1
fi

cp "$1" /usr/local/lib/"$1" && \
ln -s /usr/local/lib/"$1" /usr/local/bin/"$(basename "$1" .sh)" && \
echo "Successfully installed \`$1\`"

