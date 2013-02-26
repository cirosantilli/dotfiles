#!/usr/bin/env bash

set -u # error on undefined variable
set -e # stop execution if one command goes wrong

d=files/

while read f; do
  ln -f ~/"$f" ./"$d"
  echo ~/"$f";
  echo ./"$d$f";
  echo
done < file-list

exit 0
