#!/usr/bin/env bash
set -eu

# Needed becaues it is not possible to make hardlinks from host to guest.
cp -r /vagrant "$HOME/dotfiles"
cd $HOME/dotfiles
./install.sh
