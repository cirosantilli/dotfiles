#!/usr/bin/env bash

set -u # error on undefined variable
set -e # stop execution if one command goes wrong

d=files/

for f in `ls -A "$d"` ; do
  ln "$d$f" ~/"$f"
  echo "$d"$f
  echo ~/$f
  echo
done < file-list

exit 0
