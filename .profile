# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
export LANGUAGE="en_US:en"
export LC_MESSAGES="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"

#<ciro>

  export EDITOR=vim

  #bash history
    shopt -s histappend # append to the history file, don't overwrite it
    export HISTCONTROL=ignoreboth
    export HISTSIZE=10000
    export HISTFILESIZE=10000
    export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '

  #directory structure

    export ROOT_DIR="$HOME/ciro" #add indirection for when i'm inside a folder in someone else's computer
     
    export BAK_DIR="$ROOT_DIR/bak"
    export NOBACKUP_DIR="$ROOT_DIR/kab"
    export BIN_DIR="$ROOT_DIR/bin"
     
    export SHARE_DIR="$BAK_DIR/share"
    export NOSHARE_DIR="$BAK_DIR/noshare"

    export MUSIC_DIR="$SHARE_DIR/music"
    export GAME_DIR="$SHARE_DIR/game"

    export CHINESE_MUSIC_DIR="$MUSIC_DIR/chinese traditional"

    export PROGRAM_DIR="$NOSHARE_DIR/program"
     
    export BASH_BIN_DIR="$PROGRAM_DIR/bash/bin"
    export PYTHON_BIN_DIR="$PROGRAM_DIR/python/bin"
    export LATEX_BIN_DIR="$PROGRAM_DIR/latex"

    export TEST_DIR="$NOBACKUP_DIR/test"

  #append to path

    PATH="$PATH:$BIN_DIR"
    PATH="$PATH:$PYTHON_BIN_DIR"
    PATH="$PATH:$BASH_BIN_DIR"
    PATH="$PATH:$LATEX_BIN_DIR"
    export PATH 

#</ciro>
