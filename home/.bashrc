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

#<custom>

  ## variables

    # Variables that are required by multiple following commands.
    # Must come before everything else.

    vim=`type -P vim`
    if [ "$vim" == "" ]; then
      vim="gvim -v"
    fi

  ## alias

    # Misc aliases.

    alias ack='ack-grep --smart-case'
    # Beep. Notify after a long command. Usage:
    # long-command;b
    alias b='zenity --info --text "BEEP!"'
    alias c='cd'
    function cdl { cd "$1" && ls; }
    # cd Up
    alias cdu='cd ..'
    # TODO make a version that also cats the command and pwd.
    #function b { "$@"; zenity --info --text "$*"; }
    alias c='cd'
    # -r so that ANSI color will be shown.
    alias l='less -r'
    # External IP.
    alias eip='curl ipecho.net/plain'
    alias cla11='clang++ -std=c++11'
    # Disk Fill, Human readable, Sort by total size.
    alias dfhs='df -h | sort -hrk2'
    function dpx { dropbox puburl "$1" | xsel --clipboard; }
    alias fbr='find_basename_res.py'
    alias g='grep -E'
    alias gi='grep -Ei'
    alias fmmmr='find-music-make-m3u .'
    # GCC from String.
    # Usage: gccs '1 + 1'
    function gccs { echo "$2 int main(int argc, char** argv){$1; return 0;}" | gcc -std="c${2:-1x}"   -Wall -Wextra -pedantic -xc   -; }
    function gpps { echo "$2 int main(int argc, char** argv){$1; return 0;}" | g++ -std="c++${2:-0x}" -Wall -Wextra -pedantic -xc++ -; }
    alias golly='env UBUNTU_MENUPROXY=0 golly'
    alias ja='java'
    alias jac='javac'
    alias jaj='java -jar'
    alias jartf='jar -tf'
    alias jav='java -version'
    alias md='mkdir'
    # Make Dir Cd
    function mdc { mkdir "$1" && cd "$1"; }
    alias mupen='mupen64plus --fullscreen'
    alias nets='sudo netstat -tupan'
    alias netsg='nets | grep -Ei'
    alias ncl="while true; do printf '' | nc -l localhost 8000; done"
    function noh { nohup $@ >/dev/null & }
    alias ods='od -Ax -tx1'
    cmd='paplay "$HOME/share/sounds/alert.ogg"'
    # play Alert
    alias playa="$cmd"
    # play alert Infinite. Stop with `kill %1`.
    alias playi="bash -c 'while true; do $cmd; done'"
    alias pdc='pandoc'
    alias rmd='sleep 2 && playa && recordmydesktop --stop-shortcut 'Control+Mod1+z''
    alias pingg='ping google.com'
    alias psg='sudo ps aux | grep -i'
    alias rbul='rename_basename_unidecode_lowercase.py'
    alias rifr='replace_in_files_regex.py'
    alias rmrf='rm -rf'
    alias robots="robots -ta$(for i in {1..1000}; do echo -n n; done)"
    # Source Bashrc.
    alias s='. ~/.bashrc'
    alias sha2='sha256sum'
    # Filter tex Errors only:
    alias texe="perl -0777 -ne 'print m/\n! .*?\nl\.\d.*?\n.*?(?=\n)/gs'"
    alias timestamp='date "+%Y-%m-%d-%H-%M-%S"'
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
    alias xselb='xsel --clipboard'
    function xselssh { xsel -b < "$HOME/.ssh/id_rsa${1}.pub"; }
    # wget Mirror. My favorite mirror command:
    alias wgetm='wget -E -k -l inf -np -p -r'
    # Usage: unizipd d.zip
    # Outcome: unzips the content of `a.zip` into a newly created `d` directory
    function unzipd { unzip -d "${1%.*}" "$1"; }

    ## Provision machines

      alias provision-min-ssh='wget -O- https://raw.githubusercontent.com/cirosantilli/linux/master/ubuntu/install-min-ssh.sh | bash'
      alias provision-min='wget -O- https://raw.githubusercontent.com/cirosantilli/linux/master/ubuntu/install-ssh.sh | bash'

  ## aptitude

      alias acse='apt-cache search'
      alias acde='apt-cache depends'
      alias acsh='apt-cache show'
      alias afse='apt-file search'
      alias afsh='apt-file show'
      alias dplg='dpkg -l | grep -Ei'
      alias saii='sudo aptitude install'
      alias sair='sudo aptitude remove'
      alias saiu='sudo aptitude update'
      alias saip='sudo aptitude purge'
      function saap { sudo apt-add-repository -y "$1" && sudo aptitude update; }

  ## Bash options

    # Bash set or shopt options.

    set -o vi

    # Check the window size after each command and,
    # if necessary, update the values of LINES and COLUMNS.

    shopt -s checkwinsize

  ## ctags

      alias ctam="ctags -R --c-kinds=-m" #ctags without member fields!

  ## dirs

    ## bookmarks

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

    ## ls

      alias ls='ls -1 --color=auto --group-directories-first'
      alias lsa='ls -A'
      alias ll='ls -hl'
      alias lls='ls -hl | sort -k5hr' #by Size
      alias lla='ll -A'
      alias llas='ls -a -h -l | sort -k5hr' #by Size
      alias lsg='ls | grep -Ei'

  ## docker

    alias sdo='sudo docker'
    alias sdob='sudo docker build'
    function sdobt { sudo docker build -t "$1" .; }
    alias sdoh='sudo docker help'
    alias sdoi='sudo docker images'
    alias sdop='sudo docker ps'
    alias sdor='sudo docker run'
    function sdorit { sudo docker run -it "$1" /bin/bash; }
    function sdorp { sudo docker run -d -p 127.0.0.1:8000:80 "$1"; }
    function sdornp { sudo docker run -d --name "$1" -p 127.0.0.1:8000:80 "$2"; }
    alias sdorma='sudo docker rm $(sudo docker ps -aq --no-trunc)'
    alias sdos='sudo docker stop'

  ## export

    # MISC exports.

    export EDITOR="$vim"
    export LC_COLLATE=C

    # OSX
    export CLICOLOR=1

    ## PS1

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

  ## Git

    export GIT_EDITOR="$vim"

		# Fails for aliases that autocomplete like `g co branch<tab>`,
		# still does not expand.
    #alias i='git'
    alias gad='git add -A'
    alias gadcm='git add -A . && git commit'
    alias gadcman='git add . && gcman'
    alias gadcmanpsf='git add . && gcmanpsf'
    alias gadcmm='git add -A . && git commit -m'
    alias gadcp='git add -A . && git commit && git push'
    function gadcmp { git add . && git commit -m "$1" && git push; }
    alias garcp='git add --ignore-errors README.md index.html index.md && commit --amend --no-edit && push -f'
    alias gbl='git blame'
    alias gbr='git branch'
    function gbrdd { git branch -d "$1"; git push --delete origin "$1"; }
    alias gbra='git branch -a'
    alias gbrg='git log --abbrev-commit --decorate --graph --pretty=oneline --simplify-by-decoration' # BRanch Graph
    alias gbrv='git branch -vv'
    alias gcl='git clone --recursive'
    alias gclb='git clone --bare'
    alias gcf='git cat-file'
    alias gcfp='git cat-file -p'
    alias gcm='git commit'
    alias gcmm='git commit -m'
    alias gcma='git commit --amend'
    alias gcman='git commit --amend --no-edit'
    alias gcmanpsf='git commit --amend --no-edit && git push -f'
    alias gce='git clean'
    function gcmp { git commit -am "$1"; git push --tags -u origin master; }
    alias gco='git checkout'
    alias gcob='git checkout -b'
    function gcobm { git checkout -b "$1" master; }
    alias gcod='git checkout --conflict=diff3'
    alias gcom='git checkout master'
    # Slash Dot
    alias gcosd='git checkout -- .'
    alias gcoo='git checkout --ours'
    alias gcot='git checkout --theirs'
    alias gcou='git checkout up'
    alias gcn='git config'
    alias gcng='git config --global'
    alias gcngh='git config user.email "ciro.santilli@gmail.com"'
    alias gcp='git cp'
    alias gcr='git cherry-pick'
    alias gdf='git diff'
    function gdf12 { git diff ":1:./$1" ":2:./$1"; }
    function gdf13 { git diff ":1:./$1" ":3:./$1"; }
    function gdf123 {
      git --no-pager diff ":1:./$1" ":2:./$1";
      python -c 'print "\n" + (80 * "=") + "\n"';
      git --no-pager diff ":1:./$1" ":3:./$1";
    }
    alias gdfc='git diff --cached'
    alias gdfhh='git diff HEAD~ HEAD'
    alias gfe='git fetch'
    alias gfeomm='git fetch origin master:master'
    alias gfeumm='git fetch up master:master'
    function gfeommcob { git fetch origin master:master && git checkout -b "$1" master; }
    alias gg='git grep --color'
    alias ggi='git grep --color -i'
    alias gka='gitk --all'
    alias gin='git init'
    # Init Add Commit
    alias ginac='git init && git add . && git commit -m "init"'
    alias gls='git ls-files'
    alias glso='git ls-files --other'
    alias glsg='git ls-files | grep'
    alias glsr='git ls-remote'
    alias glo='git log'
    alias glog='git log --all --abbrev-commit --decorate --graph'
    # One line
    alias gloo='git log --all --abbrev-commit --decorate --pretty=oneline'
    # One line Graph
    alias gloog='git log --all --abbrev-commit --decorate --graph --pretty=oneline'
    #alias glop='git log --pretty=oneline --decorate'
    alias glop='git log --all --pretty=format:"%C(yellow)%h|%Cred%ad|%Cblue%an|%Cgreen%d %Creset%s" --date=short | column -ts"|" | less -r'
    alias gme='git merge'
    alias gmea='git merge --abort'
    alias gmem='git merge master'
    alias gmt='git mergetool'
    alias gmv='git mv'
    alias gppp='git push prod prod'
    alias gps='git push'
    alias gpsf='git push -f'
    alias gpsum='git push -u mine'
    alias gpsom='git push --tags -u origin master'
    alias gpl='git pull'
    alias gplr='git pull --rebase'
    alias gplum='git pull up master'
    alias gplrum='git pull --rebase up master'
    alias gplom='git pull origin master'
    alias grb='git rebase'
    alias grbm='git rebase master'
    alias grbc='git rebase --continue'
    alias grs='git reset'
    alias grsh='git reset --hard'
    alias grsH='git reset HEAD~'
    alias grshH='git reset --hard HEAD~'
    alias grm='git rm'
    alias grt='git remote'
    alias grta='git remote add'
    alias grtao='git remote add origin'
    alias grtv='git remote -v'
    alias grtr='git remote rename'
    alias grtro='git remote rename origin'
    alias grtrou='git remote rename origin up && git remote add origin'
    alias grtso='git remote set-url origin'
    alias gsa='git stash'
    alias gsaa='git stash apply'
    alias gsh='git show'
    function gshm { git show "master:./$1"; }
    function gshmo { git show "master:./$1" > "old_$1"; }
    alias gst='git status'
    alias gsu='git submodule'
    alias gsua='git submodule add'
    alias gta='git tag'
    alias gtas='git tag | sort -V'
    alias gtr='git ls-tree HEAD'

    alias vgig='vim .gitignore'
    alias lngp='latex-new-github-project.sh cirosantilli'

    # GitHub

      alias ghb='git browse-remote'
      alias ghpb='git push && git browse-remote'
      alias gpsbr='gps && git browse-remote'
      alias gcmanpsfbr='gcmanpsf && git browse-remote'

  ## gitlab elearn ssh

    alias sugqa='ssh ubuntu@gitlab-elearn-qa'
    alias sugpr='ssh ubuntu@gitlab-elearn-prod'

  ## grunt

    alias gru='grunt'
    alias gruc='grunt clean'
    alias gruh='grunt --help'
    alias grur='grunt run'
    alias grut='grunt test'
    alias gruw='grunt watch'

  ## heroku

    alias hrk='heroku'
    alias hrkc='heroku create'
    alias hrko='heroku open'
    alias hrkr='heroku run'
    alias gphm='git push heroku master'

  ## make

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
    # Stop background watch.
    alias mkk='make kill'
    alias mkr='make run'
    alias mkt='make test'
    alias mku='sudo make uninstall'
    alias mkv='make view'
    alias mkw='make watch'

    # From Git root:

      alias gmk='git !exec make'
      alias gmkc='git !exec make clean'
      alias gmkd='git !exec make dist'
      alias gmkr='git !exec make run'
      alias gmkt='git !exec make test'

      alias cmk='mkdir -p build && cd build && cmake .. && cmake --build .'
      alias cmkt='cmk && ctest -V .'

  ## mass regex operations

    # Mass Regex Refactor.
    #
    # Shows old and new lines.
    #
    # Dry run:
    #
    #    find . -type f | mrr 'a/b/g'
    #    git ls-files | mrr 'a/b/g'
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
    # Replace (Not Dry run)
    #
    #  find . -type f | mrr "a/b/g" D
    #
    # # Caveats
    #
    # - will transform symlinks into files
    # - will add trailing newlines to files that end without them
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
    alias mvr='move_regex.py'

  ## mysql

    alias myr='mysql -u root -p'

    # Before using this you ran:
    #mysql -u root -h localhost -p -e '
      #CREATE USER 'a'@'localhost' IDENTIFIED BY 'a';
      #CREATE DATABASE test;
      #GRANT ALL ON a.* TO 'a'@'localhost';
    #'
    alias myt='mysql -u a -h localhost -pa a' #MYsql Test

  ## music

    alias mitm="nohup vlc \"$INDIAN_MUSIC_DIR\" >/dev/null &"
    alias mctm="nohup vlc \"$CHINESE_MUSIC_DIR\" >/dev/null &"
    alias mjfr="nohup vlc \"$JAZZ_MUSIC_DIR\" >/dev/null &"
    alias mroc="nohup vlc \"$MUSIC_DIR/rock\" >/dev/null &"

  ## Maven

    alias mva='mvn assembly:single'
    alias mvc='mvn clean'
    alias mvca='mvn clean assembly:single'
    alias mvcca='mvn clean compile assembly:single'
    alias mvccej='mvn clean compile exec:java'
    alias mvct='mvn clean test'
    alias mvci='mvn clean install'
    alias mvcis='mvn clean install -DskipTests'
    alias mvej='mvn exec:java'
    alias mvi='mvn install'
    alias mvj='mvn javadoc:javadoc'
    alias mvjo='mvn javadoc:javadoc && xdg-open target/site/apidocs/index.html'
    alias mvo='mvn compile'
    alias mvp='mvn package'
    alias mvt='mvn test'

  ## npm

    alias npmi='npm install'
    alias npmis='npm install --save'
    alias npmisd='npm install --save-dev'

  ## power

    alias pmhi='sudo ps-hibernate'
    alias pmsh='sudo shutdown'
    alias pmsu='sudo ps-suspend'
    alias pmre='sudo reboot'

  ## python

    export PYTHONSTARTUP="$HOME/.pythonrc.py"

    alias py='python'
    alias py3='python3'
    alias ipy='ipython'
    alias tipy='touch __init__.py'
    alias pyserve='python -m SimpleHTTPServer'
    alias pydoc='python -m doctest'

    ## pip

      alias spii='sudo pip install'
      alias spiu='sudo pip uninstall'
      alias pise='pip search'
      alias pifr='pip freeze'

    ## django

      alias dmrs='./manage.py runserver' #Django Manage Run Server
      alias dmds='./manage.py dbshell' #Db Shell
      alias dmsd='./manage.py syncdb' #Sync Db
      alias dmcs='echo "yes" | ./manage.py collectstatic' #Collect Static

      ## south

        alias dmscts='./manage.py convert_to_south'
        alias dmssi='./manage.py schemamigration --initial'
        alias dmssa='./manage.py schemamigration --auto'

  ## rake

    alias rk='rake'
    alias rkc='rake clean'

  ## rails

    alias rdcm='rake db:drop db:migrate'
    alias be='bundle exec'
    alias bei='bundle exec spinach'
    alias bec='bundle exec rspec'
    alias befs='bundle exec foreman start'
    alias bejs='firefox localhost:4000 && bundle exec jekyll serve -tw'
    alias ber='bundle exec rake'
    alias berc='bundle exec rake clean'
    alias berco='bundle exec rake compile'
    alias berr='bundle exec rake routes'
    alias berrl='bundle exec rake routes | less'
    alias bert='bundle exec rake test'
    alias bers='bundle exec rake spec'
    alias berT='bundle exec rake -T'
    alias bes='bundle exec spring'
    alias bi='bundle install'
    alias ra='bundle exec rails'
    alias rac='bundle exec rails console'
    alias ras='bundle exec rails server'
    alias rasp='bundle exec rails server -p4000'

  ## services

    function sso { sudo service "$1" stop ; }
    function ssr { sudo service "$1" restart ; }
    function sss { sudo service "$1" start ; }
    function sst { sudo service "$1" status ; }
    function ssta { sudo service --status-all ; }
    alias ssar='sudo service apache2 restart'
    alias sslr='sudo service lightdm restart'

  ## update-rc.d

    function surd { sudo update-rc.d "$1" disable; }

  ## vagrant

    alias vde='vagrant destroy'
    alias vdef='vagrant destroy -f'
    alias vdu='vagrant destroy -f && vagrant up'
    alias vdus='vagrant destroy -f && vagrant up && vagrant ssh'
    alias vpr='vagrant provision'
    alias vss='vagrant ssh'
    alias vup='vagrant up'
    alias vups='vagrant up && vagrant ssh'
    alias vus='vagrant up --no-provision && vagrant ssh'

  ## vim

    alias vim="$vim"
    # osx vim
    if [ -x '/Applications/MacVim.app/Contents/MacOS/Vim' ]; then
      PATH="/Applications/MacVim.app/Contents/MacOS/:${PATH}"
    fi

  ## source lines and path modifications

    # Should come at the end.

    # Enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if [ -f '/etc/bash_completion' ] && ! shopt -oq 'posix'; then
        . '/etc/bash_completion'
    fi

    ## GCE
    if [ -d "$HOME/google-cloud-sdk" ]; then
      # The next line updates PATH for the Google Cloud SDK.
      . "$HOME/google-cloud-sdk/path.bash.inc"
      # The next line enables bash completion for gcloud.
      . "$HOME/google-cloud-sdk/completion.bash.inc"
    fi

    ## Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"

    ## node

      ## NVM
      if [ -r "$HOME/.nvm/nvm.sh" ]; then
        . "$HOME/.nvm/nvm.sh" &>'/dev/null'
        nvm use '0.10.26' &>'/dev/null'
      fi

      # Use local executables at correct version.
      export PATH="./node_modules/.bin:$PATH"

    ## RVM
    if [ -r "$HOME/.rvm/scripts/rvm" ]; then
      # Load RVM into a shell session *as a function*
      . "$HOME/.rvm/scripts/rvm"
      PATH="$PATH:$HOME/.rvm/bin"
    fi

    # Not tracked in dotfiles.
    if [ -r "$HOME/.bashrc_local" ]; then
      . "$HOME/.bashrc_local"
    fi

    [ -s "$HOME/.gvm/scripts/gvm" ] && . "$HOME/.gvm/scripts/gvm"

#</custom>
