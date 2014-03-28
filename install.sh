#!/usr/bin/env bash

set -eu

ORIGIN_DIR="files"
BACKUP_SUFFIX=".cirosantilli_dotfiles.bak"

if [ $# -gt 0 ] && [ "$1" = "-r" ]; then
  REVERSE=true
else
  REVERSE=false
fi

if $REVERSE; then
  LN_ARGS="-f"
else
  LN_ARGS="-bS $BACKUP_SUFFIX"
fi

for FILE in $(ls -A "$ORIGIN_DIR"); do
  ORIGIN="$ORIGIN_DIR/$FILE"
  DEST="$HOME/$FILE"
  if $REVERSE; then
    BUFFER="$DEST"
    DEST="$ORIGIN"
    ORIGIN="$BUFFER"
  fi
  if [ -e "$DEST" ] && [ ! $REVERSE ]; then
    echo "$DEST: already exits. Backing to: $DEST$BACKUP_SUFFIX"
  else
    echo "$DEST"
  fi
  ln $LN_ARGS "$ORIGIN" "$DEST"
done
