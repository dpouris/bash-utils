#!/usr/bin/env bash

# This script prints a preview of the contents of all files in current directory
#
# Usage: peak-dir <dirname> [...--optional-parameters]
#
# You can provide the '--no-filename' flag to remove the filename from each print
# You can provide the '--no-color' flag to remove the color from file names 

with_filename=1
with_color=1
preview_whole=0

if [ $# = 0 ]; then
  echo "Usage: $(basename $0) <dirname> [...--optional-parameters]"
  exit 1
fi

if [ ! -d $1 ]; then
  echo "dir \`$1\` doesn't exist"
  exit 1
fi

dir=$1

for param in $@; do
  if [ $param = "--no-filename" ]; then
    with_filename=0
  fi
  if [ $param = "--no-color" ]; then
    with_color=0
  fi
done

for file in $(/bin/ls -p $dir | grep -v /); do
  trunc=0
  file_len=$(($(wc -l "$dir"/"$file" | cut -c 7-8 | cut -d " " -f 2) + 1 - 1))
  if [[ $file_len -lt 10 ]]; then
    preview_whole=1
  else
    trunc=$(($file_len - 10))
    preview_whole=0
  fi

  if [ $with_filename = 1 ]; then
    if [ $with_color = 1 ]; then
      echo -ne '\x1B[1;32m'
	fi
  	echo $file':'
    echo -ne '\x1B[0m'
  fi

  if [ $preview_whole = 0 ]; then
    awk 'NR>10{exit} {print $0}' $dir/$file 
  else
    cat "$dir"/"$file"
  fi
  if [[ $trunc > 0 ]]; then
    echo -e "[Truncated \x1b[1;33m"$trunc"\x1b[0m lines]"
  fi
  echo -e
done
