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

  #history

    #whenever you stop a shell, it dumps all the commands you did into ~/.bash_history
    #these options customize how that is done

    #<UP> <DOWN>: first goes back on commands you did
    #in current section, and then goes back on ~/.bash_history

    shopt -s histappend # append to the history file, don't overwrite it
    export HISTCONTROL=ignoreboth #ignores both whitespace only commands and dupes
    export HISTSIZE=10000
    export HISTFILESIZE=100000
    #export HISTFILE=~/.new_bash_history
    export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S  '
    export HISTIGNORE='ls:cd*:[bf]g:exit:history'
      #expressions that match will not be put on ~/.bash_history
      #and will not reappear on current bash session after <UP>
    #export PROMPT_COMMAND='history -a' #this command is executed once when shell is ready

  #directory structure

    MYID=cirosantilli

    export ROOT_DIR="$HOME"
     
    export BAK_DIR="$ROOT_DIR/bak"
    export BIN_DIR="$ROOT_DIR/bin"
     
    export SHARE_DIR="$BAK_DIR/share"
    export NOSHARE_DIR="$BAK_DIR/noshare"

    export MUSIC_DIR="$SHARE_DIR/music"
    export GAME_DIR="$SHARE_DIR/game"

    export CHINESE_MUSIC_DIR="$MUSIC_DIR/chinese traditional"
    export INDIAN_MUSIC_DIR="$MUSIC_DIR/indian classical"
    export JAZZ_MUSIC_DIR="$MUSIC_DIR/instrumental jazz fusion rock"

    export PROGRAM_DIR="$NOSHARE_DIR/program"
    export HOMEFILES_DIR="$NOSHARE_DIR/homefiles"

    export MY_BASH_DIR="$PROGRAM_DIR/bash/$MYID"
    export MY_BASH_BIN_DIR="$PROGRAM_DIR/bash/$MYID/bin"
    export ASSEMBLER_DIR="$PROGRAM_DIR/assembler/$MYID/"
    export C_DIR="$PROGRAM_DIR/c/$MYID/"
    export CPP_DIR="$PROGRAM_DIR/c/$MYID/"
    export LATEX_BIN_DIR="$PROGRAM_DIR/latex"
    export WEBDEV_DIR="$PROGRAM_DIR/web"
    export MY_LINUX_DIR="$PROGRAM_DIR/linux/$MYID"

    export PYTHON_DIR="$PROGRAM_DIR/python"
    export PYTHON_DEVPATH_DIR="$PYTHON_DIR/devpath"
    export MY_PYTHON_DIR="$PYTHON_DIR/$MYID/"
    export MY_PYTHON_BIN_DIR="$PYTHON_DIR/$MYID/bin"
    export PYTHON_DIST_PKG_DIR="/usr/local/lib/python2.7/dist-packages"

    export TEST_DIR="~/test"

  ##environment

    PATH="$PATH:$BIN_DIR"
    PATH="$PATH:$MY_PYTHON_BIN_DIR"
    PATH="$PATH:$MY_BASH_BIN_DIR"
    PATH="$PATH:$LATEX_BIN_DIR"
    export PATH 

    PYTHONPATH="$PYTHONPATH:$PYTHON_DEVPATH_DIR:/var/www/django/devpath"
      #adding to path is the only way I found to dev most modules with git
      #because the module often is a subdir of the git root and you can't
      #clone modify commit subdirs in git.
    export PYTHONPATH

    export LFS=/media/lfs/
      #linux from scratch home

#</ciro>
