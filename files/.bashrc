#source ~/.profile # changes made to ~/.profile apply immediately without having to log out and in again.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#osx color terminal
export CLICOLOR=1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='\[\033[01;31m\]\w\[\033[00m\]\n${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Set up TERM variables.
# vt100 and xterm have no color in vim (at least on unixs), but if we call them xterm-color, they will.
# (vt100 for F-Secure SSH.)
# This may well be the case for some other terms, so I'm putting them here.
# Also set up a variable to indicate whether to set up the title functions.
# TODO gnome-terminal, or however it reports itself
case $TERM in

  screen)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=false
    TERM_CAN_TITLE=true
  ;;

  xterm-color|color_xterm|rxvt|Eterm|screen*) # screen.linux|screen-w
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=true
    TERM_CAN_TITLE=true
  ;;

  linux)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=true
    TERM_CAN_TITLE=false
  ;;

  xterm|vt100)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=true
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=false
    TERM_CAN_TITLE=true
  ;;

  *xterm*|eterm|rxvt*)
    TERM_IS_COLOR=true
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=true
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=true
    TERM_CAN_TITLE=true
  ;;

  *)
    TERM_IS_COLOR=false
    TERM_NOT_RECOGNIZED_AS_COLOR_BY_VIM=false
    TERM_NOT_RECOGNIZED_BY_SUN_UTILS=false
    TERM_CAN_TITLE=false
  ;;

esac

# dircolors... make sure that we have a color terminal, dircolors exists, and ls supports it.
if $TERM_IS_COLOR && ( dircolors --help && ls --color ) &> /dev/null; then
  # For some reason, the unixs machines need me to use $HOME instead of ~
  # List files from highest priority to lowest.  As soon as the loop finds one that works, it will exit.
  for POSSIBLE_DIR_COLORS in "$HOME/.dir_colors" "/etc/DIR_COLORS"; do
    [[ -f "$POSSIBLE_DIR_COLORS" ]] && [[ -r "$POSSIBLE_DIR_COLORS" ]] && eval `dircolors -b "$POSSIBLE_DIR_COLORS"` && break
  done

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  # No color, so put a slash at the end of directory names, etc. to differentiate.
  alias ls="ls -F"
  alias ll="ls -lF"
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# Set $TERM for libvte terminals that set $TERM wrong (like gnome-terminal)
{
  [ "_$TERM" = "_xterm" ] && type ldd && type grep && type tput && [ -L "/proc/$PPID/exe" ] && {
    if ldd /proc/$PPID/exe | grep libvte; then
      if [ "`tput -Txterm-256color colors`" = "256" ]; then
        TERM=xterm-256color
      elif [ "`tput -Txterm-256color colors`" = "256" ]; then
        TERM=xterm-256color
      elif tput -T xterm; then
        TERM=xterm
      fi
    fi
  }
} >/dev/null 2>/dev/null

venwrap=`type -P virtualenvwrapper.sh`
if [ "$venwrap" != "" ]; then
    source $venwrap
fi

vim=`type -P vim`
if [ "$vim" == "" ]; then
    vim="gvim -v"
fi

alias vim="$vim"

# osx vim
if [ -x "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
    PATH=/Applications/MacVim.app/Contents/MacOS/:$PATH
fi

PYTHONSTARTUP=~/.pythonrc.py
export PYTHONSTARTUP

parse_git_branch ()
{
  git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)#(git::\1)#'
}
parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn::"$1 "/" $2 ")"}'
}
parse_svn_url() {
  svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
  svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}
set -o emacs

export EDITOR="$vim"
export GIT_EDITOR="$vim"

# Add git and svn branch names
export PS1="$PS1\$(parse_git_branch)\$(parse_svn_branch) "

#<ciro>

  ##aliases

    #aliases are not exported to subshells!

    #therefore, those will only work if this file gets sourced,
    #whih only happens on interactive shells, and not when executing
    #scripts with ``bash -c`` or ``./``

    alias ack="ack-grep"
    alias dfhs="df -h | sort -hrk2" #disk fill, human radable, sort by total Size
    alias dush="du -sh * | sort -hr 1>&2"
    alias dushf="du -sh * | sort -hr | tee .dush`timestamp` 1>&2" #to File and stdout
    alias fbr="find_basename_res.py"
    alias fmmmr="find-music-make-m3u ."
    alias golly="env UBUNTU_MENUPROXY=0 golly"

    alias mvr="move_regex.py"

    alias pdc='pandoc'

    alias rbul="rename_basename_unidecode_lowercase.py"
    alias rifr="replace_in_files_regex.py"
    alias wgetm="wget -E -k -l inf -np -p -r"
      #wget Mirror. my favorite mirror command

    alias robots="robots -ta`for i in {1..1000}; do echo -n n; done`"
    #alias sudo='sudo env PATH=$PATH'
      #normally, sudo cannot see your personal path variable. now it can.


    alias py='python'
    alias tree='tree --charset=ascii'
    alias tipy='touch __init__.py'

    alias vrmm='vim readme.md'

    alias xar="xargs -0I'{}'" 
    alias xselc="xsel --clipboard" 

    ##aptitude

      alias acse="apt-cache search"
      alias acde="apt-cache depends"
      alias acsh="apt-cache show"
      alias afse="apt-file search"
      alias afsh="apt-file show"
      alias dplg="dpkg -l | grep -i"
      alias saii="sudo aptitude install"
      alias sair="sudo aptitude remove"
      alias saiu="sudo aptitude update"
      alias saip="sudo aptitude purge"

    ##dirs

      LC_COLLATE=C
      export LC_COLLATE
        #dot will come first!

      alias ls='ls -1 --color=auto --group-directories-first'
      alias lsa='ls -A'
      alias ll="ls -h -l"
      alias lls="ls -h -l | sort -k5hr" #by Size
      alias lla="ll -A"
      alias llas="ls -a -h -l | sort -k5hr" #by Size

      ##bookmarks

        #this will open krusader where I want.
        #use this from the embedded terminal emulator
        #must have "single instance mode on", or new windows will be opened
        alias krprg='krusader "$PROGRAM_DIR"'
        alias krba='krusader "$MY_BASH_DIR"'
        alias kras='krusader "$ASSEMBLER_DIR"'
        alias krc='krusader "$C_DIR"'
        alias krcp='krusader "$CPP_DIR"'
        alias krli='krusader "$MY_LINUX_DIR"'
        alias krpy='krusader "$MY_PYTHON_DIR"'
        alias krpydp='krusader "$PYTHON_DIST_PKG_DIR"'

        alias krtst='krusader "$TEST_DIR"'

        alias krmsc='krusader "$MUSIC_DIR"'
        alias krctm='krusader "$CHINESE_MUSIC_DIR"'
        alias kritm='krusader "$INDIAN_MUSIC_DIR"'

        alias krgm='krusader "$GAME_DIR"'

        alias krusd='krusader "/usr/share/doc/"'

    ##django

      alias dmrs="./manage.py runserver" #Django Manage Run Server
      alias dmds="./manage.py dbshell" #Db Shell
      alias dmsd="./manage.py syncdb" #Sync Db
      alias dmcs="echo "yes" | ./manage.py collectstatic" #Collect Static

      ##south

        alias dmscts="./manage.py convert_to_south"
        alias dmssi="./manage.py schemamigration --initial"
        alias dmssa="./manage.py schemamigration --auto"

    ##git

      alias gcam="git-commit"
      alias gcpo="git-commit-push-origin"
      alias gpgm="git push origin master"
      alias gst="git status"
      alias glg="git log"
      alias gco="git checkout"

    ##makefile
      alias mk='make'
      alias mkr='make run'
      alias mkt='make test'
      alias mkc='make clean'

    ##mysql

      alias murp="mysql -u root -p"

    ##music

      alias titm="nohup totem \"$INDIAN_MUSIC_DIR/all.m3u\" >/dev/null &"
      alias tctm="nohup totem \"$CHINESE_MUSIC_DIR/all.m3u\" >/dev/null &"
      alias tjfr="nohup totem \"$JAZZ_MUSIC_DIR/all.m3u\" >/dev/null &"

    ##pip

      alias spii="sudo pip install"
      alias spir="sudo pip remove"
      alias pise="pip search"

    ##services

      alias ssar="sudo service apache2 restart"
      alias sslr="sudo service lightdm restart"

#</ciro>
