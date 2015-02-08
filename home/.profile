# Executed only by login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists..
# Most of what this does can propagate to subshells, e.g. exports.

# Source bashrc if running bash.
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

#<ciro>

  # Misc preferences:

    export EDITOR=vim
    export LANGUAGE='en_US:en'
    export LC_ADDRESS='en_US.UTF-8'
    export LC_COLLATE=C
    export LC_CTYPE='en_US.UTF-8'
    export LC_IDENTIFICATION='en_US.UTF-8'
    export LC_MEASUREMENT='en_US.UTF-8'
    export LC_MESSAGES='en_US.UTF-8'
    export LC_MONETARY='en_US.UTF-8'
    export LC_NAME='en_US.UTF-8'
    export LC_NUMERIC='en_US.UTF-8'
    export LC_PAPER='en_US.UTF-8'
    export LC_TELEPHONE='en_US.UTF-8'
    export LC_TIME='en_US.UTF-8'
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"

  ## Directory structure

    export BAK_DIR="$HOME/bak"
    export PROGRAM_DIR="$BAK_DIR/git"
      export ASSEMBLER_DIR="$PROGRAM_DIR/assembler"
      export BASH_DIR="$PROGRAM_DIR/bash-cheat"
      export CPP_DIR="$PROGRAM_DIR/cpp/cheat"
      export DEVBIN="$PROGRAM_DIR/devbin"
      export LATEX_BIN_DIR="$PROGRAM_DIR/latex"
      export LINUX_DIR="$PROGRAM_DIR/linux-cheat"
      export JAVA_DIR="$PROGRAM_DIR/java-cheat"
      export PYTHON_BASE_DIR="$PROGRAM_DIR/python"
        export PYTHON_DEVPATH_DIR="$PYTHON_BASE_DIR/devpath"
        export PYTHON_DIR="$PYTHON_BASE_DIR/cheat"
      export RAILS_DIR="$PROGRAM_DIR/rails/cheat"
      export WEB_DIR="$PROGRAM_DIR/cirosantilli.com/web"
    export TEST_DIR="~/test"
    export MEDIA_DIR="$HOME/media"
      export MUSIC_DIR="$MEDIA_DIR/music"
        export CHINESE_MUSIC_DIR="$MUSIC_DIR/chinese traditional"
        export INDIAN_MUSIC_DIR="$MUSIC_DIR/indian classical"
        export JAZZ_MUSIC_DIR="$MUSIC_DIR/jazz"
      export GAME_DIR="$MEDIA_DIR/game"

  ## PATH

    # Before:

      PATH="$PATH:$LATEX_BIN_DIR"
      # Linux from scratch home.
      export LFS=/media/lfs/
      # Texlive
      PATH="/usr/local/texlive/2013/bin/$(uname -i)-linux:$PATH"
      PATH="$HOME/bin:$PATH"

    # After:

      PATH="$ANDROID_ADT_DIR/tools/:$PATH"
      PATH="$ANDROID_ADT_DIR/platform-tools/:$PATH"
      PATH="$DEVBIN:$PATH"
      PATH="$PATH:$HOME/.cabal/bin"
      export PATH

  ## PYTHONPATH

    # Adding to path is the only way I found to dev most modules with Git
    # because the module often is a subdir of the git root and you can't
    # clone modify commit subdirs in git.

      PYTHONPATH="$PYTHONPATH:$PYTHON_DEVPATH_DIR:/var/www/django/devpath"
      export PYTHONPATH

  ## Bash history

    # Whenever you stop a shell, it dumps all the commands you did into ~/.bash_history
    # these options customize how that is done.

    # <UP> <DOWN>: first goes back on commands you did
    # in current section, and then goes back on ~/.bash_history

      shopt -s histappend # append to the history file, don't overwrite it
      export HISTCONTROL=ignoreboth #ignores both whitespace only commands and dupes
      export HISTSIZE=10000
      export HISTFILESIZE=100000
      #export HISTFILE=~/.new_bash_history
      export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
      # Expressions that match will not be put on ~/.bash_history
      # and will not reappear on current bash session after <UP>.
      export HISTIGNORE='ls:cd*:[bf]g:exit:history'
      #export PROMPT_COMMAND='history -a' #this command is executed once when shell is ready

  ## Texlive

    export MANPATH="/usr/local/texlive/2013/texmf-dist/doc/man:$MANPATH"
    export INFOPATH="/usr/local/texlive/2013/texmf-dist/doc/info:$INFOPATH"

  ## Java

    export JAVA_HOME='/usr/lib/jvm/java-7-oracle'
    #export CATALINA_HOME=''

  # For VM SSH development as git user so I can run X programs:

    xhost + &>/dev/null

  # Not tracked in dotfiles.

    if [ -r "$HOME/.profile_local" ]; then
      . "$HOME/.profile_local"
    fi

#</ciro>
