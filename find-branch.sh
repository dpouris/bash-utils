#!/usr/bin/env bash
#
# This script searches through all local Git branches for a given file that contains 
# a specified string. It outputs the branches and  number of branches where the file includes the search string.
#
# Usage: find-branch <file_path> <file_contents>
#
# Example:
#   ./find-branch.sh install_util.sh "bin"
#
# Note: Run this script from within a Git repository
#

if [ $# -lt 2 ]; then
  echo "Usage: $(basename "$0") <file_path> <file_contents>"
  exit 1
fi

file=$1
file_contents=$2
found_branch=0

for branch in $(git for-each-ref --format '%(refname:short)' refs/heads/); do
    if git show "$branch":"$file" 2>/dev/null | grep -q "$file_contents"; then
		echo -e "\x1b[1;32m$branch\x1b[0m"
        found_branch=$((found_branch + 1))
    fi
done
echo -e "Found (\x1b[0;33m$found_branch\x1b[0m) branches"

