#!/usr/bin/env bash

set -eu

ORIGIN_DIR='home'
BACKUP_SUFFIX='.cirosantilli_dotfiles.bak'

if [ $# -gt 0 ] && [ "$1" = '-r' ]; then
  REVERSE=true
else
  REVERSE=false
fi

if ! $REVERSE; then
  CP_ARGS="-bS $BACKUP_SUFFIX"
fi

cd "$ORIGIN_DIR"
for FILE in $(ls -A); do
  ORIGIN="$FILE"
  DEST="$HOME"
  if $REVERSE; then
    BUFFER="$DEST"
    DEST="$ORIGIN"
    ORIGIN="$BUFFER"
  fi
  cp -lr --parents $CP_ARGS "$ORIGIN" "$DEST"
done
