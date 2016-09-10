# Source bashrc if running bash.
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

#<ciro>

  # Misc preferences:

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
    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
    # Remove leading : or else the current directory is added to the search path.
    LD_LIBRARY_PATH="${LD_LIBRARY_PATH#:}"
    export LD_LIBRARY_PATH

  ## Default programs

    #export BROWSER=firefox
    export EDITOR=vim
    #export PAGER=less

  ## Directory structure

    export BAK_DIR="$HOME/bak"
      export PROGRAM_DIR="$BAK_DIR/git"
        export ALGORITHM_DIR="$PROGRAM_DIR/algorithm-cheat"
        export ANDROID_DIR="$PROGRAM_DIR/android-cheat"
        export ART_DIR="$PROGRAM_DIR/art"
        export BASH_DIR="$PROGRAM_DIR/bash-cheat"
        export CPP_DIR="$PROGRAM_DIR/cpp-cheat"
        export DEVBIN="$PROGRAM_DIR/devbin"
        export LATEX_BIN_DIR="$PROGRAM_DIR/latex"
        export LINUX_DIR="$PROGRAM_DIR/linux-cheat"
        export JAVA_DIR="$PROGRAM_DIR/java-cheat"
        export NETWORKING_DIR="$PROGRAM_DIR/networking-cheat"
        export NOTES_DIR="$PROGRAM_DIR/notes"
        export PYTHON_BASE_DIR="$PROGRAM_DIR/python"
          export PYTHON_DEVPATH_DIR="$PYTHON_BASE_DIR/devpath"
        export PYTHON_DIR="$PROGRAM_DIR/python-cheat"
        export RAILS_DIR="$PROGRAM_DIR/rails/cheat"
        export WEBSITE_DIR="$PROGRAM_DIR/cirosantilli.github.io"
          export GIT_TUTORIAL_DIR="$WEBSITE_DIR/git-tutorial"
          export DB_DIR="$WEBSITE_DIR/db"
          export WEB_DIR="$WEBSITE_DIR/web"
        export UBUNTU_DIR="$PROGRAM_DIR/ubuntu-cheat"
      export TEST_DIR="$HOME/test"
    export DOTFILES_REPO="$HOME/.homesick/repos/dotfiles"
    export DOWNLOAD_DIR="$HOME/down"
    export HOME_DIR="$HOME"
    export MY_GIT_DIR="$HOME/git"
    export MEDIA_DIR="$HOME/media"
      export MUSIC_DIR="$MEDIA_DIR/music"
        export CHINESE_MUSIC_DIR="$MUSIC_DIR/chinese traditional"
        export INDIAN_MUSIC_DIR="$MUSIC_DIR/indian classical"
        export JAZZ_MUSIC_DIR="$MUSIC_DIR/jazz"
      export GAME_DIR="$MEDIA_DIR/game"
    export GOPATH="$HOME/.go"

    # Single char shortcuts.
    export ART_DIR_SHORTCUT='a'
    export ALGORITHM_DIR_SHORTCUT='A'
    export BASH_DIR_SHORTCUT='b'
    export CPP_DIR_SHORTCUT='c'
    export ANDROID_DIR_SHORTCUT='d'
    export DOWNLOAD_DIR_SHORTCUT='D'
    export GIT_TOPLEVEL_DIR_SHORTCUT='g'
    export MY_GIT_DIR_SHORTCUT='G'
    export HOME_DIR_SHORTCUT='h'
    export LINUX_DIR_SHORTCUT='l'
    export NOTES_DIR_SHORTCUT='n'
    export NETWORKING_DIR_SHORTCUT='N'
    export PROGRAM_DIR_SHORTCUT='p'
    export TEST_DIR_SHORTCUT='t'
    export UBUNTU_DIR_SHORTCUT='u'
    export PYTHON_DIR_SHORTCUT='y'
    export WEBSITE_DIR_SHORTCUT='w'
    export WEB_DIR_SHORTCUT='W'
    # Current main project.
    export Z_DIR_SHORTCUT='z'

    # Linux from scratch home.
    export LFS=/media/lfs/

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

      # Append to the history file, don't overwrite it
      shopt -s histappend
      # ignoredups: ignore duplicate commands
      # ignorespace: ignore commands that start with space
      # ignoreboth: both the above
      export HISTCONTROL='ignoredups:erasedups'
      export HISTSIZE=1000000
      export HISTFILESIZE=10000000
      #export HISTFILE=~/.new_bash_history
      export HISTTIMEFORMAT='%Y-%m-%d %H:%M:%S '
      # Expressions that match will not be put on ~/.bash_history
      # and will not reappear on current bash session after <UP>.
      # TODO ignore anything that contains only whitespace, not just space.
      # Could be achieved with `HISTCONTROL=ignorespace`, but I copy paste
      # from Markdown indented code blocks too often. ` *` does not work
      # as it is BRE that does the same as `ignorespace.`
      export HISTIGNORE=' :  :   :    :ls:cd*:[bf]g:exit:history:sudo reboot*:sudo shutdown*'
      #export PROMPT_COMMAND='history -a' #this command is executed once when shell is ready

  ## Texlive

    export MANPATH="/usr/local/texlive/2013/texmf-dist/doc/man:$MANPATH"
    export INFOPATH="/usr/local/texlive/2013/texmf-dist/doc/info:$INFOPATH"

  ## Java

    #export JAVA_HOME='/usr/lib/jvm/java-7-openjdk-amd64'
    export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
    #export JAVA_HOME='/usr/lib/jvm/java-8-oracle'
    #export CATALINA_HOME=''

    # Android

      export ANDROID_SDK="$HOME/android-sdk"
      export ANDROID_HOME="$ANDROID_SDK"
      export ANDROID_NDK="$HOME/android-ndk"
      export ANDROID_NDK_HOME="$ANDROID_NDK"
      export ANDROID_NDK_ROOT="$ANDROID_NDK"
      export ANDROID_ABI='armeabi-v7a'
      export ANDROID_JAVA_HOME="$JAVA_HOME"
      export ANDROID_STUDIO="$HOME/android-studio/"
      export PATH="$ANDROID_SDK/platform-tools:$ANDROID_SDK/tools:${ANDROID_STUDIO}/bin:${ANDROID_NDK}:${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:${PATH}"

  ## PATH

    # Before:

      PATH="$PATH:$LATEX_BIN_DIR"
      # Texlive
      PATH="/usr/local/texlive/2013/bin/$(uname -i)-linux:$PATH"
      PATH="$HOME/bin:$PATH"
      PATH="$DEVBIN:$PATH"

    # After:

      PATH="$PATH:$HOME/.cabal/bin"
      PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
      export PATH

  # For VM SSH development as git user so I can run X programs:

    xhost + &>/dev/null

  # Not tracked in dotfiles.

    if [ -r "$HOME/.profile_local" ]; then
      . "$HOME/.profile_local"
    fi

#</ciro>
