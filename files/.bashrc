# Sorced whenever you run an interactive shell, not when running `bash -c` or `./program.sh`.

# Changes made to ~/.profile apply immediately without having to log out and in again.
# Must be at the top to that changes on bashrc will have precedence.
#source ~/.profile

# If not running interactively, don't do anything.
[ -z "$PS1" ] && return

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
  # List files from highest priority to lowest. As soon as the loop finds one that works, it will exit.
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

parse_git_branch () {
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

#<ciro>

  ##variables

    # Variables that are required by multiple following commands.
    # Must come before everything else.

    vim=`type -P vim`
    if [ "$vim" == "" ]; then
      vim="gvim -v"
    fi

  ##alias

    # Misc aliases.

    alias ack="ack-grep -a --smart-case"
    alias cla11="clang++ -std=c++11"
    alias dfhs="df -h | sort -hrk2" #disk fill, human radable, sort by total Size
    function dpx { dropbox puburl "$1" | xsel --clipboard; }
    alias fbr="find_basename_res.py"
    alias fmmmr="find-music-make-m3u ."
    alias golly="env UBUNTU_MENUPROXY=0 golly"
    function mdc { mkdir "$1" && cd "$1"; } # Make Dir Cd
    alias mupen="mupen64plus --fullscreen"
    alias nets='sudo netstat -tupan'
    alias netsg='nets | grep -Ei'
    alias ods='od -Ax -tx1'

    cmd="paplay ~/share/sounds/alert.ogg"
    alias playa="$cmd" # play Alert
    alias playi="bash -c 'while true; do $cmd; done'" # play alert Infinite. Stop with `kill %1`.
    alias pdc='pandoc'
    alias rmd="sleep 2 && playa && recordmydesktop --stop-shortcut 'Control+Mod1+z'"
    alias pingg='ping google.com'
    alias psg='sudo ps aux | grep -i'
    alias rbul="rename_basename_unidecode_lowercase.py"
    alias rifr="replace_in_files_regex.py"
    alias robots="robots -ta`for i in {1..1000}; do echo -n n; done`"
    # Filter tex Errors only:
    alias texe="perl -0777 -ne 'print m/\n! .*?\nl\.\d.*?\n.*?(?=\n)/gs'"
    alias timestamp="date '+%Y-%m-%d-%H-%M-%S'"
      # Fail when no non-hidden files. globnull would solve, but hard to restore shell state afterwards.
      alias dush="du -sh .[^.]* * 2>/dev/null | sort -hr"
      alias dushf='dush | tee ".dush$(timestamp)"' # to File
    # Normally, sudo cannot see your personal path variable. now it can:
    #alias sudo='sudo env PATH=$PATH'
    alias tree='tree --charset=ascii'
    alias vrmm='vim README.md'
    # Ubuntu 1 Public url to Clipboard:
    function u1pc { u1sdtool --publish-file "$1" | perl -ple 's/.+\s//' | xsel -b; }
    alias xar="xargs -I'{}'"
    alias xar0="xargs -0I'{}'"
    alias xselb="xsel --clipboard"
    # wget Mirror. My favorite mirror command:
    alias wgetm="wget -E -k -l inf -np -p -r"

    ##Provision machines

      alias provision-min-ssh="wget -O- https://raw.githubusercontent.com/cirosantilli/linux/master/ubuntu/install-min-ssh.sh | bash"
      alias provision-min="wget -O- https://raw.githubusercontent.com/cirosantilli/linux/master/ubuntu/install-ssh.sh | bash"

  ##aptitude

      alias acse="apt-cache search"
      alias acde="apt-cache depends"
      alias acsh="apt-cache show"
      alias afse="apt-file search"
      alias afsh="apt-file show"
      alias dplg="dpkg -l | grep -Ei"
      alias saii="sudo aptitude install"
      alias sair="sudo aptitude remove"
      alias saiu="sudo aptitude update"
      alias saip="sudo aptitude purge"
      function saap { sudo apt-add-repository -y "$1" && sudo aptitude update; }

  ##ctags

      alias ctam="ctags -R --c-kinds=-m" #ctags without member fields!
      function ctag { grep "^$1" tags; } #CTAgs Grep
      function rctag { cd `git rev-parse --show-toplevel` && grep "^$1" tags; } #Root CTAgs Gre

  ##dirs

    ##bookmarks

      # These will open krusader where I want.

      # Better with "single instance mode on", or new windows will be opened.

      alias krpr='krusader "$PROGRAM_DIR"'
        alias kras='krusader "$ASSEMBLER_DIR"'
        alias krba='krusader "$MY_BASH_DIR"'
        alias krcp='krusader "$CPP_DIR"'
        alias krli='krusader "$MY_LINUX_DIR"'
        alias krpy='krusader "$MY_PYTHON_DIR"'
        alias krpydp='krusader "$PYTHON_DIST_PKG_DIR"'
        alias krror='krusader "$PROGRAM_DIR/rails-cheat/cirosantilli"'
        alias krgitl='krusader "$PROGRAM_DIR/rails-cheat/cookbook-gitlab"'

      alias krtst='krusader "$TEST_DIR"'

      alias krmsc='krusader "$MUSIC_DIR"'
        alias krctm='krusader "$CHINESE_MUSIC_DIR"'
        alias kritm='krusader "$INDIAN_MUSIC_DIR"'

      alias krgm='krusader "$GAME_DIR"'

      alias krusd='krusader "/usr/share/doc/"'

    ##ls

      alias ls='ls -1 --color=auto --group-directories-first'
      alias lsa='ls -A'
      alias ll="ls -hl"
      alias lls="ls -hl | sort -k5hr" #by Size
      alias lla="ll -A"
      alias llas="ls -a -h -l | sort -k5hr" #by Size
      alias lsg="ls | grep -Ei"

  ##export

    # MISC exports.

    export EDITOR="$vim"
    export LC_COLLATE=C

    # OSX
    export CLICOLOR=1

    ##PS1

      # Set variable identifying the chroot you work in (used in the prompt below).
      if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
      fi
      PS1='\[\033[01;31m\]\w\[\033[00m\]\n${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h\[\033[00m\]\$ '

      # If this is an xterm set the title to user@host:dir
      case "$TERM" in
      xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
      *)
        ;;
      esac

      # Add git and svn branch names
      export PS1="$PS1\$(parse_git_branch)\$(parse_svn_branch) "

  ##git

    export GIT_EDITOR="$vim"

    alias gad="git add"
    alias gadcm="git add . && git commit"
    alias gadcp="git add . && git commit && git push"
    function gadcmp { git add . && git commit -m "$1" && git push; }
    alias garcp="git add --ignore-errors README.md index.html index.md && commit --amend --no-edit && push -f"
    alias gbl="git blame"
    alias gbr="git branch"
    function gbrdd { git branch -d "$1"; git push --delete origin "$1"; }
    alias gbrv="git branch -vv"
    alias gcl="git clone --recursive"
    alias gcm="git commit"
    alias gcman="git commit --amend --no-edit"
    alias gcmanpsf="git commit --amend --no-edit && git push -f"
    alias gadcmanpsf="git add . && gcmanpsf"
    function gcmp { git commit --allow-empty-message -am "$1"; git push --tags -u origin master; }
    alias gco="git checkout"
    alias gcom="git checkout master"
    alias gcoo="git checkout --ours"
    alias gcot="git checkout --theirs"
    alias gcou="git checkout up"
    alias gcn="git config"
    alias gcng="git config --global"
    alias gcp="git cp"
    alias gcr="git cherry-pick"
    alias gdf="git diff"
    alias gdfc="git diff --cached"
    alias gdfhh="git diff HEAD~ HEAD"
    alias gfe="git fetch"
    alias ggr="git grep --color"
    alias gka="gitk --all"
    alias giac="git init && git add . && git commit -m 'Init.'" #Git Init Add Commit
    alias gls="git ls-files"
    alias glso="git ls-files --other"
    alias glsg="git ls-files | grep"
    alias glo="git log --decorate"
    #alias glop="git log --pretty=oneline --decorate"
    alias glop="git log --pretty=format:'%C(yellow)%h|%Cred%ad|%Cblue%an|%Cgreen%d %Creset%s' --date=short | column -ts'|' | less -r"
    alias glog="git log --pretty=oneline --decorate --graph --all"
    alias gme="git merge"
    alias gmt="git mergetool"
    alias gmv="git mv"
    alias gppp="git push prod prod"
    alias gps="git push"
    alias gpsom="git push --tags -u origin master"
    alias gpl="git pull"
    alias gplum="git pull up master"
    alias gplom="git pull origin master"
    alias grb="git rebase"
    alias grbc="git rebase --continue"
    alias grs="git reset"
    alias grshh="git reset --hard HEAD~"
    alias grm="git rm"
    alias grt="git remote"
    alias grtv="git remote -v"
    alias gsa="git stash"
    alias gsaa="git stash apply"
    alias gst="git status"
    alias gta="git tag"
    alias gtas="git tag | sort -V"
    alias gtr="git ls-tree HEAD"

    alias vgig="vim .gitignore"
    alias lngp="latex-new-github-project.sh cirosantilli"

    # GitHub

      alias ghb="git browse-remote"
      alias ghpb="git push && git browse-remote"
      alias ghcmanpsf="gcmanpsf && git browse-remote"

  ##gitlab elearn ssh

    alias sugqa='ssh ubuntu@gitlab-elearn-qa'
    alias sugpr='ssh ubuntu@gitlab-elearn-prod'

  ##heroku

    alias hrk="heroku"
    alias hrkc="heroku create"
    alias hrko="heroku open"
    alias hrkr="heroku run"
    alias gphm="git push heroku master"

  ##make

    alias mk='make'
    alias mkc='make clean'
    alias mkd='make dist'
    alias mkdc='make distclean'
    alias mkde='make deps'
    alias mkh='make help'
    # It is better to `make` first without the sudo so that the generated build
    # will not be owned, or else it could only be cleaned with by sudo.
    alias mki='make && sudo make install'
    alias mkir='make && sudo make install && make install-run'
    alias mkr='make run'
    alias mkt='make test'
    alias mku='sudo make uninstall'
    alias mkv='make view'

    # From Git root:

      alias gmk='cd `git rev-parse --show-toplevel` && make'
      alias gmkc='cd `git rev-parse --show-toplevel` && make clean'
      alias gmkd='cd `git rev-parse --show-toplevel` && make dist'
      alias gmkr='cd `git rev-parse --show-toplevel` && make run'
      alias gmkt='cd `git rev-parse --show-toplevel` && make test'

      alias cmk='mkdir build && cd build && cmake .. && make'

  ##mass regex operations

    # Mass Regex Refactor.
    #
    # Shows old and new lines.
    #
    # Dry run:
    #
    #    find . -type f | mrr "a/b/g"
    #    git ls-files | mrr "a/b/g"
    #
    # Sample output:
    #
    #   a:1
    #   a
    #   c
    #
    #   b:1
    #   b
    #   c
    #
    # Replace (Not Dry run): WARNING: will transform symlinks into files. TODO how to avoid?
    #
    #  find . -type f | mrr "a/b/g" D
    #
    function mrr {
      if [ $# -gt 1 ]; then
        if [ "$2" = "D" ]; then
          xargs perl -lapi -e "s/$1"
        fi
      else
        sed "s|^\./||" | xargs -L1 perl -lane '$o = $_; if (s/'"$1"') { print $ARGV . ":" . $. . "\n" . $o . "\n" . $_ . "\n" }'
      fi
    }

    # "grep" only in Basename.
    #
    # Sample usage:
    #
    #   git ls-files | grepb a.c
    #
    # Highlight breaks if Perl pattern is not POSIX ERE.
    #
    function grepb { perl -ne "print if m/$1(?!.*\/.)/i" | grep --color -Ei "$1|\$";}

    # Find files recursively filtering by regex.
    #
    # Basename only, prune hidden.
    function fin { find . -path '*/.*' -prune -o ! -name '.' -print | sed "s|^\./||" | grepb "$1" ;}
    # Also Hidden.
    function finh { find . ! -path . | sed "s|^\./||" | grepb "$1" ;}
    # full Path.
    function finp { find . ! -path . | sed "s|^\./||" | perl -ne "print if m/$1/" ;}

    function grr { grep -Er "$1" . ; }

    # Mass rename refactoring.
    alias mvr="move_regex.py"

  ##mysql

    alias myr="mysql -u root -p"

    # Before using this you ran:
    #mysql -u root -h localhost -p -e "
      #CREATE USER 'a'@'localhost' IDENTIFIED BY 'a';
      #CREATE DATABASE test;
      #GRANT ALL ON a.* TO 'a'@'localhost';
    #"
    alias myt="mysql -u a -h localhost -pa a" #MYsql Test

  ##music

    alias mitm="nohup vlc \"$INDIAN_MUSIC_DIR/all.m3u\" >/dev/null &"
    alias mctm="nohup vlc \"$CHINESE_MUSIC_DIR/all.m3u\" >/dev/null &"
    alias mjfr="nohup vlc \"$JAZZ_MUSIC_DIR/all.m3u\" >/dev/null &"
    alias mroc="nohup vlc \"$MUSIC_DIR/rock/all.m3u\" >/dev/null &"

  ##options

    # Bash set or shopt options.

    set -o vi

    # Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
    shopt -s checkwinsize

  ##power

    alias pmhi="sudo ps-hibernate"
    alias pmsh="sudo shutdown"
    alias pmsu="sudo ps-suspend"
    alias pmre="sudo reboot"

  ##python

    export PYTHONSTARTUP=~/.pythonrc.py

    alias py='python'
    alias py3='python3'
    alias ipy='ipython'
    alias tipy='touch __init__.py'

    ##pip

      alias spii="sudo pip install"
      alias spiu="sudo pip uninstall"
      alias pise="pip search"
      alias pifr="pip freeze"

    ##django

      alias dmrs="./manage.py runserver" #Django Manage Run Server
      alias dmds="./manage.py dbshell" #Db Shell
      alias dmsd="./manage.py syncdb" #Sync Db
      alias dmcs="echo "yes" | ./manage.py collectstatic" #Collect Static

      ##south

        alias dmscts="./manage.py convert_to_south"
        alias dmssi="./manage.py schemamigration --initial"
        alias dmssa="./manage.py schemamigration --auto"

  ##rails

    alias rdcm="rake db:drop db:migrate"
    alias be="bundle exec"
    alias bi="bundle install"

  ##services

    function sso { sudo service "$1" stop ; }
    function ssr { sudo service "$1" restart ; }
    function sss { sudo service "$1" start ; }
    function sst { sudo service "$1" status ; }
    function ssta { sudo service --status-all ; }
    alias ssar="sudo service apache2 restart"
    alias sslr="sudo service lightdm restart"

  ##vagrant

    alias vde="vagrant destroy"
    alias vdef="vagrant destroy -f"
    alias vdu="vagrant destroy -f && vagrant up"
    alias vdus="vagrant destroy -f && vagrant up && vagrant ssh"
    alias vpr="vagrant provision"
    alias vss="vagrant ssh"
    alias vup="vagrant up"
    alias vups="vagrant up && vagrant ssh"
    alias vus="vagrant up --no-provision && vagrant ssh"

  ##vim

    alias vim="$vim"
    # osx vim
    if [ -x "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
      PATH=/Applications/MacVim.app/Contents/MacOS/:$PATH
    fi

  ##source lines

    # Should come at the end.

    # Enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi

    ##GCE
    if [ -d ~/google-cloud-sdk ]; then
      # The next line updates PATH for the Google Cloud SDK.
      source ~/google-cloud-sdk/path.bash.inc
      # The next line enables bash completion for gcloud.
      source ~/google-cloud-sdk/completion.bash.inc
    fi

    ##Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"

    ##NVM
    if [ -r ~/.nvm/nvm.sh ]; then
      source ~/.nvm/nvm.sh
      nvm use 0.10.26 &>/dev/null
    fi

    ##RVM
    if [ -r "$HOME/.rvm/scripts/rvm" ]; then
      # Load RVM into a shell session *as a function*
      source "$HOME/.rvm/scripts/rvm"
      PATH=$PATH:$HOME/.rvm/bin
    fi

    # Not tracked by git.
    if [ -r "$HOME/.bashrc_local" ]; then
      . "$HOME/.bashrc_local"
    fi

#</ciro>
