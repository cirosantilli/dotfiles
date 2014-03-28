#!/usr/bin/env bash
set -eu
cp -r /vagrant "$HOME/dotfiles"
cd $HOME/dotfiles
./install.sh
