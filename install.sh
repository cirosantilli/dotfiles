#!/usr/bin/env bash

set -eu

ORIGIN_DIR='home'
BACKUP_SUFFIX='.dotfiles.bak'

cd "$ORIGIN_DIR"
for FILE in $(ls -A); do
  ORIGIN="$FILE"
  DEST="$HOME"
  cp -blr --parents -S "$BACKUP_SUFFIX" "$ORIGIN" "$DEST"
done
