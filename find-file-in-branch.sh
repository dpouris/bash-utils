#!/usr/bin/env bash

file_to_search="$1"
branches=$(git branch -a | cut -c 3-)
base_path=$(pwd)

for branch in $branches; do
    git checkout "$branch" &> /dev/null

    if [ -e "$file_to_search" ]; then
        file_path="$base_path/$file_to_search"
        echo "File found in branch: $branch"
        echo "Absolute path: $file_path"
    fi
done

git checkout - &> /dev/null

echo "Search complete."
