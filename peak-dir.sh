#!/bin/bash

# This script prints a preview of the contents of all files in current directory
#
# Usage: peak-dir <dirname> [...--optional-parameters]
#
# You can provide the '--no-filename' flag to remove the filename from each print
# You can provide the '--no-color' flag to remove the color from file names 

with_filename=1
with_color=1

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
  if [ $with_filename = 1 ]; then
    if [ $with_color = 1 ]; then
      echo -ne '\x1B[1;32m'
	fi
  	echo $file':'
    echo -ne '\x1B[0m'
  fi
  cat $dir/$file; echo -e 
done
