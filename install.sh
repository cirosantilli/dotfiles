#!/usr/bin/env bash

set -eu

SOURCE_DIR='home'
SOURCE_DIR="$(cd "$(dirname "$SOURCE_DIR")"; pwd)/$(basename "$SOURCE_DIR")"
BACKUP_SUFFIX='.dotfiles.bak'

echo cp -brs --parents -S "$BACKUP_SUFFIX" "$SOURCE_DIR"/* "$SOURCE_DIR"/.* "$HOME"
cp -brs --parents -S "$BACKUP_SUFFIX" "$SOURCE_DIR"/* "$SOURCE_DIR"/.* "$HOME"
