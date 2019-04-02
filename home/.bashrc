## Environment variables

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
        export LKMC_DIR="$PROGRAM_DIR/linux-kernel-module-cheat"
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
      export DOTFILES_DCONF="${DOTFILES_REPO}/dconf.conf"
    export DOWNLOAD_DIR="$HOME/down"
    export CIROSANTILLI_TMP_DIR="${HOME}/tmp"
    export CIROSANTILLI_BIN_DIR="${HOME}/bin"
    export CIROSANTILLI_VAR_DIR="${HOME}/var"
      export CIROSANTILLI_VAR_LOG_DIR="${CIROSANTILLI_VAR_DIR}/log"
    export CIROSANTILLI_GIT_DIR="$HOME/git"
    export MEDIA_DIR="$HOME/media"
      export MUSIC_DIR="$MEDIA_DIR/music"
        export CHINESE_MUSIC_DIR="$MUSIC_DIR/chinese traditional"
        export INDIAN_MUSIC_DIR="$MUSIC_DIR/indian classical"
        export JAZZ_MUSIC_DIR="$MUSIC_DIR/jazz"
      export GAME_DIR="$MEDIA_DIR/game"
    export GOPATH="$HOME/.go"

    # Single char shortcuts for directory structure.

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

    ## Java
    #export JAVA_HOME='/usr/lib/jvm/java-7-openjdk-amd64'
    export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
    #export JAVA_HOME='/usr/lib/jvm/java-8-oracle'
    #export CATALINA_HOME=''

    # Android

    export ANDROID_SDK="$HOME/android-sdk"
    export ANDROID_HOME="$ANDROID_SDK"
    export ANDROID_NDK="$ANDROID_SDK/ndk-bundle"
    export ANDROID_NDK_HOME="$ANDROID_NDK"
    export ANDROID_NDK_ROOT="$ANDROID_NDK"
    export ANDROID_ABI='armeabi-v7a'
    export ANDROID_JAVA_HOME="$JAVA_HOME"
    export ANDROID_STUDIO="$HOME/android-studio/"
    export USE_CCACHE=1

  ## PATH

    # Before

      PATH="$PATH:$LATEX_BIN_DIR"
      ## Texlive
      PATH="/usr/local/texlive/2013/bin/$(uname -i)-linux:$PATH"
      PATH="$HOME/bin:$PATH"
      PATH="$DEVBIN:$PATH"
      PATH="$ANDROID_SDK/platform-tools:$ANDROID_SDK/tools:${ANDROID_STUDIO}/bin:${ANDROID_NDK}:${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin:${PATH}"
      PATH="/usr/local/heroku/bin:$PATH"
      PATH="./node_modules/.bin:$PATH"
      PATH="$PATH:$HOME/.rvm/bin"
      PATH="$PATH:$HOME/anaconda2/bin"

      # osx vim
      if [ -x '/Applications/MacVim.app/Contents/MacOS/Vim' ]; then
        PATH="/Applications/MacVim.app/Contents/MacOS/:${PATH}"
      fi

    # After

      PATH="$PATH:$HOME/.cabal/bin"
      PATH="$PATH:$GOPATH/bin"

      # pip install --user
      # https://stackoverflow.com/questions/7143077/how-can-i-install-packages-in-my-home-folder-with-pip
      PATH="$PATH:$HOME/.local/bin/"

      # https://github.com/cirosantilli/runlinux
      PATH="$PATH:$PROGRAM_DIR/runlinux"

      export PATH

  ## LD_LIBRARY_PATH

    LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/lib64"
    # Remove leading : or else the current directory is added to the search path.
    LD_LIBRARY_PATH="${LD_LIBRARY_PATH#:}"
    export LD_LIBRARY_PATH

  ## Misc preferences

    #export BROWSER=firefox
    export EDITOR=vim
    export GIT_EDITOR="vim"
    export LANG='en_US:en'
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
    #export PAGER=less
    if [ -n "$PYTHONPATH" ]; then
      export PYTHONPATH="${PYTHONPATH}:"
    fi
    PYTHONPATH="${PYTHONPATH}${PYTHON_DEVPATH_DIR}:/var/www/django/devpath"
    export PYTHONSTARTUP="$HOME/.pythonrc.py"

    # Linux from scratch home.
    export LFS=/media/lfs/

  ## Bash

    export PS1="\[\033[01;31m\]\w\n\
\[\033[01;34m\]\$(timestamp)\
\[\033[01;32m\]@\
\[\033[01;34m\]\u\
\[\033[01;32m\]@\
\[\033[01;34m\]\h\
\[\033[00m\]\$ "

    ## Bash history

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

  ## OSX
  export CLICOLOR=1

  ## Texlive
  export MANPATH="/usr/local/texlive/2013/texmf-dist/doc/man:$MANPATH"
  export INFOPATH="/usr/local/texlive/2013/texmf-dist/doc/info:$INFOPATH"

  # AMD SDK
  export AMDAPPSDKROOT="$HOME/AMDAPPSDK-3.0"
  #export OPENCL_VENDOR_PATH="$HOME/AMDAPPSDK-3.0/etc/OpenCL/vendors/"

## Non env var settings

  ## Bash

    set -o vi

    # Check the window size after each command and,
    # if necessary, update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # Append to the history file, don't overwrite it
    shopt -s histappend

    umask 0002

  # Free up Cq and Cs, and stop Cs from freezing terminal.
  # - http://unix.stackexchange.com/questions/12107/how-to-unfreeze-after-accidentally-pressing-ctrl-s-in-a-terminal
  # - http://unix.stackexchange.com/questions/137842/what-is-the-point-of-ctrl-s
  # Don't do this, as it generates an error window at startup:
  # https://askubuntu.com/questions/918169/error-found-while-loading-home-username-profile/970634#970634
  #stty -ixon

  # This hangs up on certain server setups, need to investigate further.
  # For VM SSH development as git user so I can run X programs:
  #xhost + &>/dev/null

## alias

## functions

  # Because some useless /etc/* files I don't control might set aliases and they conflict with these definitions.
  unalias -a

  alias a='cat'
  adoc() (
    asciidoctor -s - -v "$@"
  )
  alias ack='ack-grep --smart-case'
  b() ( cirosantilli-beep "$@" )
  bao() ( noh baobab "${1:-.}" )
  alias bashx='x | bash'
  bsu() ( bsub -P "$1" -R "${2:-rhe6}" -Ip -XF gnome-terminal -e tmux )
  cdg() { cd "$(git rev-parse --show-toplevel)/${1:-}"; }
  ccache-watch() ( watch -n1 'ccache -s' )
  # Start bash in a clean test environment.
  alias clean='env -i bash --norc'
  camel2under() (
    # https://stackoverflow.com/questions/28795479/awk-sed-script-to-convert-a-file-from-camelcase-to-underscores/43549677#43549677
    # https://unix.stackexchange.com/questions/196239/convert-underscore-to-pascalcase-ie-uppercamelcase
    if [ "$#" -eq 0 ]; then
      sed -r 's/([A-Z])/_\L\1/g' | sed 's/^_//'
    else
      sed -r 's/(^|_)([a-z])/\U\2/g'
    fi
  )
  catf() (
    # Cat with filenames for multiple files.
    tail -c+1 "$@"
  )
  alias chmx='chmod +x'
  chmod-sane() (
    # Set sane permissive permissions for all files
    # and directories under a given directory.
    d="${1:-.}"
    sudo find "$d" -type d | sudo xargs chmod 755
    find "$d" -type f | sudo xargs chmod +644
    find . -type f -perm /u=x,g=x,o=x | sudo xargs -r chmod +111
  )
  chmod-permissive() (
    # Workaround for the age-old problem. OMG, Ubuntu.
    # https://askubuntu.com/questions/12009/solving-permission-problems-when-using-external-ext4-hard-disk-with-multiple-lin
    # https://askubuntu.com/questions/44534/how-to-set-umask-for-a-specific-folder TODO implement this as well.
    d="${1:-.}"
    sudo find "$d" -type d | sudo xargs chmod 777
    find "$d" -type f | sudo xargs chmod +666
    find . -type f -perm /u=x,g=x,o=x | sudo xargs -r chmod +111
  )
  # External IP.
  # DropBox Symlink. Move the given file into Dropbox,
  # and symlink to it from the old location.
  dbs() {
    src="$1"
    path="$(readlink -f "$src")"
    dest="$(dirname "$HOME/Dropbox/home/${path#$HOME}")"
    mkdir -p "$dest"
    mv "$src" "$dest"
    ln -s "$dest/$src" "${src%/}"
  }
  alias cla11='clang++ -std=c++11'
  check-ip() ( curl 'http://checkip.amazonaws.com'; )
  # dD a.img X
  # sudo dd if=a.img of=/dev/sdX
  dD() (
    if [ ! "$#" -eq 2 ]; then
      echo 'error'
      exit 1
    fi
    dev="$2"
    u "$dev"
    sudo dd if="$1" of="/dev/sd$dev"
    sync
    b
  )
  # dd Status. Capital to prevent accidents. Only in newer Ubuntu.
  ddS() ( sudo dd if="$1" of="/dev/sd$2" status=progress && sync; )
  # Disk Fill, Human readable, Sort by total size.
  alias dfhs='df -hT | sort -hrk3'
  # For long lines, while word level diff doesn't arrive...
  diff-long() (
    sep="${3:- }"
    echo "$1"
    echo "$2"
    diff -u \
      <(tr "$sep" '\n' <"$1") \
      <(tr "$sep" '\n' <"$2")
  )
  dpx() ( dropbox puburl "$1" | xclip -selection clipboard; )
  dmes() ( dmesg -T )
  eclipse() (
    # Installed as:
    # download latest from: https://www.eclipse.org/cdt/
    # cd bin
    # lfmd
    # ex eclipse-cpp-*.tar.gz
    noh "$HOME/bin/eclipse/eclipse"
  )
  alias eip='curl ipecho.net/plain'
  alias enmp='ecryptfs-mount-private'
  alias enup='ecryptfs-umount-private'
  alias envg='env | grep -E'
  files-to-markdown() (
    # Serialize multiple files to markdown for SO answers.
    for f in "$@"; do
      echo "$f"
      echo
      sed -r 's/^/    /' "$f"
      echo
    done
  )
  alias gaz='GAZEBO_PLUGIN_PATH="${GAZEBO_PLUGIN_PATH}:build" gazebo'
  alias gnup='gnuplot -p'
  alias golly='env UBUNTU_MENUPROXY=0 golly'
  kdev() (
    # http://kfunk.org/2016/02/16/building-kdevelop-5-from-source-on-ubuntu-15-10/
    export KF5=~/kde-5
    export QTDIR=/usr
    export CMAKE_PREFIX_PATH=$KF5:$CMAKE_PREFIX_PATH
    export XDG_DATA_DIRS=$KF5/share:$XDG_DATA_DIRS:/usr/share
    export XDG_CONFIG_DIRS=$KF5/etc/xdg:$XDG_CONFIG_DIRS:/etc/xdg
    export PATH=$KF5/bin:$QTDIR/bin:$PATH
    export QT_PLUGIN_PATH=$KF5/lib/plugins:$KF5/lib64/plugins:$KF5/lib/x86_64-linux-gnu/plugins:$QTDIR/plugins:$QT_PLUGIN_PATH  
    #   (lib64 instead of lib, on OpenSUSE and similar)
    export QML2_IMPORT_PATH=$KF5/lib/qml:$KF5/lib64/qml:$KF5/lib/x86_64-linux-gnu/qml:$QTDIR/qml  
    export QML_IMPORT_PATH=$QML2_IMPORT_PATH
    export KDE_SESSION_VERSION=5
    export KDE_FULL_SESSION=true
    kdevelop
  )
  h() ( "$1" --help | less; )
  j() ( jobs "$@"; )
  L() ( locate -r "$1"; )
  lob() ( locate -br "$1"; )
  alias lns='ln -s'
  lnmv() (
    # Move and replace with symlink.
    f="$1"
    d="$2"
    mv "$f" "$d"
    ln -s "${d}/$(basename "${f}")" "$f"
  )
  lns-undo() {
    # Remove a symlink, and move the file linked to to the symlink location.
    # Usage: cmd symlink-location
    link_location="$1"
    link_dest="$(readlink -f "$link_location")"
    rm "$link_location"
    mv "$link_dest" "$link_location"
  }
  alias m='man'
  alias m2='man 2'
  alias m3='man 3'
  bak() { for f in "$@"; do mv "${f%/}" "${f%/}.bak"; done; }
  bakk() { for f in "$@"; do cp -r "${f%/}" "${f%/}.bak"; done; }
  kab() { for f in "$@"; do p="${f%/}"; mv "$p" "${p%.bak}" || mv "$p.bak" "${p}"; done }
  kabb() { for f in "$@"; do p="${f%/}"; cp "$p" "${p%.bak}" || cp -r "$p.bak" "${p}"; done }
  markdown-to-adoc() (
    # Markdown to asciidoc the way I like it.
    f="$1"
    shift
    pandoc --atx-headers --base-header-level 2 -o "${f%.*}.adoc" --wrap=none "$f" "$@"
  )
  md() ( mkdir -p "$@"; )
  # Make Dir Cd
  mdc() { md "$1" && cd "$1"; }
  alias mupen='mupen64plus --fullscreen'
  mvc() { mv "$1" "$2" && cd "$2"; }
  # Shutdown but run some scripts it.
  alias my-shutdown='sync-push && sudo shutdown'
  alias nets='sudo netstat -tupan'
  alias netsg='nets | grep -Ei'
  alias ncl="while true; do printf '' | nc -l localhost 8000; done"
  noh() { nohup $@ >/dev/null 2>&1 & }
  # Use all processors, but leave 2 unused if we have that many. TODO: consider case 2 or 1 processors.
  npro() ( printf "$(($(nproc) - 2))" )
  alias o='xdg-open'
  # Open First. When you are in a huge directory with tons of
  # files that share a common prefix, and you just want to open one.
  # Specially for images, since eog moves to the next pick with right arrow.
  of() {
    if [ -z "$1" ]; then
      dir='.'
    else
      dir="$1"
    fi
    xdg-open "$(find "$dir" -maxdepth 1 -type f | sort | head -n1)"
  }
  alias pdc='pandoc'
  pycharm() ( noh "$HOME/bin/pycharm/bin/pycharm.sh" )
  r() {
    ranger --choosedir="$HOME/.rangerdir" "$@"
    c "$(cat "$HOME/.rangerdir")"
  }
  ramfs() {
    dir='/mnt/ramfs'
    mkdir -p "$dir"
    sudo mount -t ramfs -o size=300m ramfs "$dir"
    sudo chmod 777 "$dir"
    cd "$dir"
  }
  ramfsu() (
    sudo umount /dev/ramfs
  )
  # Generate a random login and password to speed up account creation.
  # You should save them to a file immeditaly, and then to the signup.
  randlog () {
    (
      cat /dev/urandom | tr -dc 'a-z0-9' | head -c 10
      echo
      cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c 10 | tr -d '\n'
      echo '0@'
    ) | tee >(xclip -selection clipboard)
  }
  alias R='R --no-save'
  alias rl='readlink'
  alias rlf='readlink -f'
  rlw() ( readlink -f "$(which "$1")" )
  viw() ( v "$(which "$1")" )
  # Run N times. Parallel programming tests.
  runn() {
    n="$1"
    shift
    i=0
    while [ "$i" -lt "$n" ]; do
        if ! $*; then
          echo "FAIL i = $i"
          break
        fi
        i="$(($i + 1))"
    done
  }
  alias pingg='ping google.com'
  alias psg='sudo ps aux | grep -i'
  alias pscpu='sudo ps aux --sort "%cpu"'
  alias psmem='sudo ps aux --sort "%mem"'
  alias rbul='rename_basename_unidecode_lowercase.py'
  alias rifr='replace_in_files_regex.py'
  alias rmd='rmdir'
  rmext() { rm *".$1"; }
  alias rmrf='rm -rf'
  alias rmrfv='rm -rfv'
  rrc() ( rr record "$@" )
  rrp() ( rr replay -o -q -o -ex -o 'b main' -o -ex -o 'c' "$@" )
  rrr() ( rrc "$@" && rrp )
  alias robots="robots -ta$(for i in {1..1000}; do echo -n n; done)"
  # Source Bashrc. Unalias first so that conversions of functions
  # to aliases won't give errors.
  alias S='. ~/.bashrc'
  syslock() (
    # https://askubuntu.com/questions/7776/how-do-i-lock-the-desktop-screen-via-command-line
    gnome-screensaver-command -l
  )
  syssus() (
    # https://askubuntu.com/questions/1792/how-can-i-suspend-hibernate-from-command-line
    systemctl suspend
  )
  alias se='sed -r'
  # Screen TTY.
  alias sha2='sha256sum'
  alias sql='sqlite3'
  alias stra='sudo strace -f -s999 -v'
  stdouttime() (
    # https://stackoverflow.com/questions/49797246/how-to-monitor-for-how-much-time-each-line-of-stdout-was-the-last-output-line-in/49797547#49797547
    tp="$(date +%s%N)"
    while read line; do
      tc="$(date +%s%N)"
      echo $(((tc - tp) / 1000000))
      echo "$line"
      tp=$tc
    done
    tc="$(date +%s%N)";
    echo $(((tc - tp) / 1000000))
  )
  # http://serverfault.com/questions/61321/how-to-pass-alias-through-sudo
  alias sudo='sudo '
  surd() ( sudo update-rc.d "$1" disable; )
  alias t='type'
  # TODO: also cat stdout and stderr.
  testprogs() (
    for f in "$@"; do
      "./$f" &>/dev/null
      if [ "$?" != 0 ]; then
        echo "$f"
      fi
    done
  )
  # Filter tex Errors only:
  alias texe="perl -0777 -ne 'print m/\n! .*?\nl\.\d.*?\n.*?(?=\n)/gs'"
  alias timestamp='date "+%Y-%m-%d-%H-%M-%S"'
  # Unix timtestamp. Seconds since epoch.
  alias timestampu='date "+%s"'
  topp() (
    # http://stackoverflow.com/questions/1221555/how-can-i-get-the-cpu-usage-and-memory-usage-of-a-single-process-on-linux-ubunt/40576129#40576129
    $* &>/dev/null &
    pid="$!"
    #top -p "$pid"
    #watch -n 1 ps --no-headers -p "$pid" -o '%cpu,%mem'

    # Without trap, the background process does not get killed.
    # TODO why `trap '' INT` does not work?
    trap ':' INT
    echo 'CPU  MEM'
    while sleep 1; do ps --no-headers -o '%cpu,%mem' -p "$pid"; done

    kill "$pid"
  )
  # tr Colon to newline. To see paths better.
  alias trc="tr ':' '\n'"
  # Normally, sudo cannot see your personal path variable. now it can:
  #alias sudo='sudo env PATH=$PATH'
  alias tree='tree --charset=ascii'
  # https://stackoverflow.com/questions/49797246/how-to-monitor-for-how-much-time-each-line-of-stdout-was-the-last-output-line-in/49797547#49797547
  alias tsi='ts -i "%.s"'
  alias tss='ts -s "%.s"'
  # http://stackoverflow.com/questions/1969958/how-to-change-tor-exit-node-programmatically/
  alias tornewip='sudo killall -HUP tor'
  torbrowser() ( cd ~/bin/tor-browser_en-US && ./start-tor-browser.desktop )
  torbrowser-hist() (
    # A profile that remembers browsing history and logins.
    # https://tor.stackexchange.com/questions/16326/how-to-use-multiple-profiles-with-tor
    cd ~/bin/tor-browser_en-US-hist
    ./start-tor-browser.desktop
  )
  u() (
    if [ ! "$#" -eq 1 ]; then
      echo 'error'
      exit 1
    fi
    sudo umount /dev/sd"${1}"?*
    lsblk
  )
  mnt() (
    m="$1"
    d="$2"
    mkdir -p "$d"
    if ! mountpoint -q "$d"; then
      mount -t nfs "$m" "$d"
    fi
  )
  # Core dumps.
  ulimc() { ulimit -c "${1:-unlimited}"; }
  ulimsv() { ulimit -Sv "${1:-500}000"; }
  ulimsvu() { ulimit -Sv unlimited; }
  # Ubuntu 1 Public url to Clipboard:
  u1pc() { u1sdtool --publish-file "$1" | perl -ple 's/.+\s//' | xclip -selection clipboard; }
  alias xar="xargs -I'{}'"
  alias xar0="xargs -0I'{}'"
  # wget Mirror. My favorite mirror command:
  alias wgetm='wget -E -k -l inf -np -p -r'
  # Usage: unizipd d.zip
  # Outcome: unzips the content of `a.zip` into a newly created `d` directory
  unzipd() { unzip -d "${1%.*}" "$1"; }
  z() ( zip -r "${1%/}.zip" "$@" )

  bdiff() (
    f() (
      od -An -tx1c -w1 -v "$1" | paste -d '' - -
    )
    diff -u <(f "$1") <(f "$2")
  )

  # http://data.stackexchange.com/stackoverflow/query/edit/392827
  socsv() {
    ls -t ~/down/QueryResults* | head -1
    cat "$(ls -t ~/down/QueryResults* | head -1)" | tr -d '\r' | \
    sed -E \
    -e 's|,.*||' \
    -e 's|"||g' \
    -e 's|^|<a href="https://stackoverflow.com/questions/|' \
    -e 's|$|">aaaaaaaaaaaaaaaaaaa</a><br/>|' \
    -e '0~16s|$|<br/>|' \
    > ~/down/a.html
  }

  ## android

    alias adbc='adb connect'
    alias adbd='adb devices -l'
    alias adbD='adb disconnect'
    alias adbi='adb install'
    alias adbks='sudo "$(which adb)" kill-server && sudo "$(which adb)" start-server'
    alias adbl="adb logcat"
    alias adblc="adb logcat -c"
    alias adbld="adb logcat -d"
    alias adble="adb logcat -v time '*:E'"
    alias adbls="adb logcat -v time -s"
    alias adblsc="adb logcat -v time -s com.cirosantilli"
    alias adbp='adb push'
    alias adbP='adb pull'
    adbpp() (
      # https://stackoverflow.com/questions/11074671/adb-pull-multiple-files
      adbs "ls $1" | xargs -I'{}' -n 1 adb pull '{}' "${2:-.}"
    )
    alias adbsrm='adb shell rm'
    adbs() ( adb shell "$@" )
    alias adbu='adb uninstall'
    adbs-list-packages() ( adb shell pm list packages | cut -d ':' -f 2 | sort | grep "${1:-.}" )
    adbss() (
      # https://stackoverflow.com/questions/4567904/how-to-start-an-application-using-android-adb-tools
      #adb shell am start -n "${1}/${2:-MainActivity}"
      adb shell monkey --pct-syskeys 0 -p "$1" 1
    )
    adbsS() (
      # https://stackoverflow.com/questions/3117095/stopping-an-android-app-from-console
      adb shell am force-stop "$1"
    )
    adbsss() (
      # Shell. Start. Sleep. Stop.
      app="$1"
      sleep="${2:-3}"
      adbss "$app"
      sleep "$sleep"
      adbsS "$app"
    )
    adbsf() (
      adb shell 'find / -iname "*'"$1"'*" 2>/dev/null'
    )
    alias ande='nohup emulator -avd Nexus_One_API_24 >/dev/null 2>&1 &'
    alias ands='nohup studio.sh >/dev/null 2>&1 &'
    # Run app in current directory. Must be run from top level
    # of a project created with `android create project`.
    # Only works if there is only a single file in the `src/` directory.
    adbr() (
      cd 'src/'
      file="$(find * -type f | head -n1)"
      dir="$(dirname "$file")"
      file="$(echo "$file" | sed -r 's/.java$//' | tr '/' '.')"
      dir="$(echo "$dir" | tr '/' '.')"
      adb shell am start -n "${dir}/${file}"
    )
    alias antcdi='ant clean && ant debug && ant installd'
    alias antcndi='ant clean && ndk-build clean && ndk-build && ant debug && ant installd'
    # Clean, build, install and run on device.
    alias antcdir='antcdi && adbr'
    alias antc='ant clean'
    alias antd='ant debug'
    alias antid='ant installd'
    alias grai='./gradlew installDebug'

    grac() ( ./gradlew clean "$@" )
    gracd() ( grac && grad )
    grad() ( ./gradlew assembleDebug "$@" )
    gradi() ( ./gradlew uninstallAll && ./gradlew assembleDebug && ./gradlew installDebug )
    gracdi() ( ./gradlew clean && gradi )

    # Repo.
    repover() (
      # Print the revision of all repos.
      # https://stackoverflow.com/questions/14402425/how-do-i-know-the-current-version-in-an-android-repo/48240508#48240508
      top="$(pwd)/"
      repo forall -c "pwd=\"\$(pwd)\"; echo \"\$(git log -1 --format=\"%H\") \${pwd#$top}\""
    )

  ## aptitude

    alias acse='apt-cache search'
    alias acde='apt-cache depends'
    alias acsh='apt-cache show'
    alias acshs='apt-cache showsrc'
    alias afls='apt-file list'
    alias afse='apt-file search'
    # Binary
    afseb() { apt-file search "$(which "$1")"; }
    alias sabd='sudo apt-get build-dep'
    alias agso='apt-get source'
    alias sdpi='sudo dpkg -i'
    alias dpL='dpkg -L'
    alias dps='dpkg -s'
    alias dpS='dpkg -S'
    dpSw() { dpkg -S "$(which "$1")"; }
    alias dplg='dpkg -l | grep -Ei'
    # Build package downloaded with apt-get source after cd into it.
    dpkgb() ( dpkg-buildpackage -rfakeroot -uc -b )
    alias saig='sudo aptitude upgrade'
    alias saii='sudo aptitude install'
    alias sair='sudo aptitude remove'
    alias sais='sudo aptitude source'
    alias saiu='sudo aptitude update'
    alias saip='sudo aptitude purge'
    saap() { sudo apt-add-repository -y "$1" && sudo aptitude update; }

  ## awk

    mycolumn() (
      # https://stackoverflow.com/questions/12768907/how-to-align-the-columns-of-tables-in-bash/52209504#52209504
      file="${1:--}"
      if [ "$file" = - ]; then
        file="$(mktemp)"
        cat >"${file}"
      fi
      awk '
      FNR == 1 { if (NR == FNR) next }
      NR == FNR {
        for (i = 1; i <= NF; i++) {
          l = length($i)
          if (w[i] < l)
            w[i] = l
        }
        next
      }
      {
        for (i = 1; i <= NF; i++)
          printf "%*s", w[i] + (i > 1 ? 1 : 0), $i
        print ""
      }
      ' "$file" "$file"
      if [ "$file" = - ]; then
        rm "$file"
      fi
    )

  ## bc

    # Convert number between two bases.
    #
    # Usage:
    #
    #     base-convert number [[inbase=10] obase=16]
    #
    # Example:
    #
    #     base-convert 17 10 16
    #
    # Output:
    #
    #     11
    #
    # Example 2:
    #
    #     base-convert 10 10 16
    #
    # Output:
    #
    #     a
    base-convert() (
      val="$(printf $1 | tr a-z A-Z)"
      if [ $# -ge 2 ]; then
        ibase=${2:-}
      else
        ibase=10
      fi
      if [ $# -ge 3 ]; then
        obase=${3:-}
      else
        obase=16
      fi
      echo "obase=${obase}; ibase=${ibase}; ${val}" | bc | tr A-Z a-z
    )

    # Convert from base
    hex() (
      base-convert "$1" 10 16
    )

    # Base 16 to 10, the inverse of xhe.
    xeh() (
      base-convert "$1" 16 10
    )

  ## Binutils

    alias obd='objdump -Cdr'
    alias obD='objdump -CDr'
    alias obimg='objdump -D -b binary -mi386 -Maddr16,data16'
    alias obS='objdump -CSr'
    alias rea='readelf -aW'
    alias red='readelf -dW'
    alias reD='readelf --debug-dump=decodedline'
    alias reh='readelf -h'
    alias reS='readelf -SW'
    alias res='readelf -sW'

    # Convert architecture name to Ubuntu toolchain prefix.
    arch-to-prefix() (
      case "$1" in
        a|arm) echo arm-linux-gnueabihf;;
        A|aarch64) echo aarch64-linux-gnu;;
        x|x86_64) echo x86_64-linux-gnu;;
        *) echo "error: unknown arch: $1"; exit 1;;
      esac
    )

    # Get the encoding for a given assembly instruction.
    #
    # Usage:
    #
    #     encode-asm arm 'add r0, r0, r1'
    #
    # Output:
    #
    #     01 00 80 e0
    #
    # https://stackoverflow.com/questions/8482059/how-to-compile-an-assembly-file-to-a-raw-binary-like-dos-com-format-with-gnu/32237064#32237064
    encode-asm() (
      set -e
      arch="$1"
      shift
      pref="$(arch-to-prefix "$arch")-"
      name="/tmp/encode-asm-$arch"
      in="${name}.S"
      o="${name}.o"
      out="${name}.out"
      raw="${name}.raw"
      printf '.section .text\n.global _start\n_start:\n' > "$in"
      printf '%s ' ${*} >> "$in"
      printf '\n' >> "$in"
      "${pref}as" -o "$o" "$in"
      "${pref}ld" -o "$out" "$o"
      "${pref}objcopy" -O binary "$out" "$raw"
      od-raw "$raw"
    )

    # Usage:
    #
    #     decode-asm arm 01 00 80 e0
    #
    # or equivalently:
    #
    #     decode-asm arm 010080e0
    #     decode-asm arm '01 00 80 e0'
    #
    # Output:
    #
    #     /tmp/decode-asm-arm:     file format binary
    #
    #
    #     Disassembly of section .data:
    #
    #     00000000 <.data>:
    #        0:   e0800001        add     r0, r0, r1
    #
    # Bibliography:
    #
    # - https://stackoverflow.com/questions/1737095/how-do-i-disassemble-raw-x86-code
    # - https://stackoverflow.com/questions/3859453/using-objdump-for-arm-architecture-disassembling-to-arm
    decode-asm() (
      set -e
      arch="$1"
      shift
      f="/tmp/decode-asm-$arch"
      printf '%s' "$@" | xxd -r -p > "$f"
      if [ "$arch" = arm ] || [ "$arch" = aarch64 ]; then
        machine="$arch"
        M=
      elif [ "$arch" = x86_64 ]; then
        machine=i386
        M='-M intel,x86-64'
      fi
      "$(arch-to-prefix "$arch")-objdump" -D -b binary $M -m $machine "$f"
    )

  ## Buildroot

    brmk() (
      unset LD_LIBRARY_PATH
      defconfig="${1:-qemu_x86_64_defconfig}"
      outdir="output/${defconfig}"
      make O="$outdir" "$defconfig"
      printf "
BR2_CCACHE=y
BR2_PACKAGE_HOST_QEMU=y
BR2_PACKAGE_HOST_QEMU_LINUX_USER_MODE=n
BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE=y
BR2_PACKAGE_HOST_QEMU_VDE2=y
${2:-}
" >> "${outdir}/.config"
      make O="$outdir" olddefconfig
      time make O="$outdir" BR2_JLEVEL="$(nproc)" HOST_QEMU_OPTS='--enable-sdl --with-sdlabi=2.0'
      b
    )
    brmkx() (
      # brmkx 'BR2_TARGET_ROOTFS_EXT2_SIZE="256M"\nBR2_PACKAGE_LTP_TESTSUITE=y'
      brmk qemu_x86_64_defconfig "${1}"
    )
    brmkA() (
      brmk qemu_aarch64_virt_defconfig "${1}"
    )
    brmkp() (
      brmk qemu_ppc64_pseries_defconfig "${1}"
    )
    brq() (
      outdir="${1:-output/qemu_x86_64_defconfig}"
      "${outdir}/host/usr/bin/qemu-system-x86_64" \
        -M pc \
        -append 'root=/dev/vda console=ttyS0' \
        -drive file="${outdir}/images/rootfs.ext2,if=virtio,format=raw" \
        -enable-kvm \
        -kernel "${outdir}/images/bzImage" \
        -m 512 \
        -net nic,model=virtio \
        -net user,hostfwd=tcp::2222-:22 \
      ;
    )
    brqa() (
      # Qemu ARM
      qemu-system-arm \
        -M versatilepb \
        -append "root=/dev/sda console=ttyAMA0,115200" \
        -drive file=output/images/rootfs.ext2,if=scsi,format=raw \
        -dtb output/images/versatile-pb.dtb \
        -kernel output/images/zImage \
        -net nic,model=rtl8139 \
        -net user \
        -serial stdio \
        "$@" \
      ;
    )
    brqA() (
      # QEMU aarch64
      # https://github.com/buildroot/buildroot/blob/master/board/qemu/aarch64-virt/readme.txt
      ./output/host/usr/bin/qemu-system-aarch64 \
        -M virt \
        -append "root=/dev/vda console=ttyAMA0" \
        -cpu cortex-a57 \
        -device virtio-blk-device,drive=hd0
        -device virtio-net-device,netdev=eth0 \
        -drive file=output/images/rootfs.ext4,if=none,format=raw,id=hd0 \
        -kernel output/images/Image \
        -netdev user,id=eth0 \
        -nographic \
        -smp 1 \
        "$@" \
      ;
    )
    brqp() (
      qemu-system-ppc64 -M pseries -cpu POWER7 -m 256 -kernel output/images/vmlinux -append 'console=hvc0 root=/dev/sda' -drive file=output/images/rootfs.ext2,if=scsi,index=0,format=raw -serial stdio -display curses
    )

    brmkiq() (
      # initrd and qemu afterwards
      make qemu_x86_64_defconfig
      printf 'BR2_CCACHE=y\n' >>.config
      printf 'BR2_TARGET_ROOTFS_CPIO=y\n' >>.config
      printf 'BR2_TARGET_ROOTFS_EXT2=n\n' >>.config
      make olddefconfig
      time env -u LD_LIBRARY_PATH make BR2_JLEVEL="$(nproc)" linux-reconfigure
      img="${1:-output}"
        qemu-system-x86_64 \
        -M pc \
        -append root=/dev/vda \
        -enable-kvm \
        -kernel "${img}/images/bzImage" \
        -initrd "${img}/images/rootfs.cpio" \
        -net nic,model=virtio \
        -net user,hostfwd=tcp::2222-:22 \
      ;
    )

  ## cd

    c() {
      if [ -n "$1" ]; then
        cd "$1" || return 1
      else
        cd ..
      fi
      ll
    }
    C() { cd; }
    alias cda='c "$ART_DIR"'
    alias cdA='c "$ANDROID_DIR"'
    alias cdc='c "$CPP_DIR"'
    alias cdD='c "$DOWNLOAD_DIR" && lfl'
    # cd Dot
    alias cdd='c ..'
    alias cddd='c ../..'
    alias cdddd='c ../../..'
    alias cdj='c "$JAVA_DIR"'
    alias cdl='c "$LINUX_DIR"'
    alias cdn='c "$NOTES_DIR"'
    alias cdp='c "$PROGRAM_DIR"'
    alias cdq='c "$QUARTET_DIR"'
    # cd Slash
    alias cds='c -'
    alias cdt='c "$TEST_DIR"'
    alias cdu='c "$UBUNTU_DIR"'
    alias cdr='c "$RTL_DIR"'
    alias cdx='c "$(x)"'
    alias cdy='c "$PYTHON_DIR"'
    alias cdw='c "$WEBSITE_DIR"'

    ## build src navigation

      # If you are in directory:

        # /a/b/c/src/d/e/f

      # `gob` puts you in:

        # /a/b/c/build/d/e/f

      # gos does the opposite.

      # This is to navigate projects with separate build and source trees.

        cdb() {
          cd "$(pwd | sed -E 's%^(.*)/src(/.*|$)%\1/build/\2%')"
        }

        cdB() {
          cd "$(pwd | sed -E 's%^(.*)/build(/.*|$)%\1/src/\2%')"
        }

  ## Chromium

    chr() ( noh chromium-browser "$@"; )
    chrt() ( chr --temp-profile "$@"; )
    # Unsafe settings, for quick testing. Don't access any important page with it.
    chr-test() ( chr --allow-file-access-from-files; )

  ## cmake

    cmk() {
      mdc 'build'
      cmake "$@" ..
      cmake --build . -- -j"$(npro)" VERBOSE=1
    }
    cmkn() {
      mdc 'build-ninja'
      cmake "$@" .. -G Ninja
      cmake --build . -- -j"$(npro)" -v
    }
    cmkb() { time cmk; b; }
    cmkd() { cmk -DCMAKE_BUILD_TYPE=Debug; }
    cmks() { cmk -DBUILD_SHARED_LIBS=ON; }
    # Test.
    cmkt() { cmk && ctest -V .; }

  ## CodeCollab

    ccah() ( ccollab addchangelist "$1" HEAD; )
    # Update change to reflect last commit.
    # Get ID from commit Message line of form "CC: 1234".
    ccamh() ( ccollab addchangelist "$(git log -n1 --pretty=format:'%B' | grep -E '^CC: ' | cut -d' ' -f2)" HEAD; )
    # Create new.
    ccanh() ( ccollab addchangelist new HEAD; )
    ccasn() ( ccollab addsvndiffs new; )

  ## crosstool-ng

    ctng() (
      export CT_PREFIX="$(pwd)/.build/install"
      export PATH="/usr/lib/ccache:${PATH}"
      config="${1:-arm-cortex_a15-linux-gnueabihf}"
      ./bootstrap
      ./configure --enable-local
      mkj
      ./ct-ng "$config"
      printf "
CT_LINUX_V_4_14=y
CT_LINUX_VERSION=\"4.14.0\"
${2:-}
" >> .config
      ./ct-ng oldconfig
      env -u LD_LIBRARY_PATH time ./ct-ng build CT_JOBS=`nproc`
      git log -1 --format="%H" | sudo tee "${CT_PREFIX}/${config}/sha"
      sudo cp .config "${CT_PREFIX}/${config}"
      b
    )

    ctngA() (
      ./ct-ng aarch64-unknown-linux-gnu
      env -u LD_LIBRARY_PATH time ./ct-ng build CT_JOBS=`nproc`
      b
    )

  ## ctags

    # - R: Recursive
    # - --c-kinds=+p: function prototypes. Because that is where the docs usually are.
    # - --c-kinds=-m: remove struct member. Too many false positives otherwise.
    #                 Just go to struct definition first instead.
    # - --extra=f: also generate tags for filenames, that point to the first line.
    ctagsr() ( ctags -R --c-kinds=+p-m --c++-kinds=+p-m --extra=+f "$@" "$(pwd)" )
    alias cscopr='cscope -Rb'
    alias ctasc='cdg && ctagsr && cscopr && cd -'

  ## Development boards

    sshr() ( ssh-root "${1}" 'root' )
    scrs() ( screen "/dev/ttyS${1:-0}" "${2:-115200}"; )
    scrsr() ( "$(which screen-tty-root)" "$@"; )
    scrusb() ( screen "/dev/ttyUSB${1:-0}" "${2:-115200}"; )

    losl() (
      # List what each loop device is bound to.
      sudo losetup -l
    )
    loop-mount-partitions() (
      # Works both on multi and single partition images.
      # https://askubuntu.com/questions/69363/mount-single-partition-from-image-of-entire-disk-device/673257#673257
      # https://superuser.com/questions/117136/how-can-i-mount-a-partition-from-dd-created-image-of-a-block-device-e-g-hdd-u/972020#972020
      # https://stackoverflow.com/questions/1419489/loopback-mounting-individual-partitions-from-within-a-file-that-contains-a-parti/39675265#39675265
      # https://superuser.com/questions/211338/mounting-a-multi-partition-disk-image-in-linux/1263401#1263401
      # https://unix.stackexchange.com/questions/87183/creating-formatted-partition-from-nothing/229219#229219
      # https://unix.stackexchange.com/questions/9099/reading-a-filesystem-from-a-whole-disk-image/229218#229218
      set -e
      img="$1"
      dev="$(sudo losetup --show -f -P "$img")"
      echo "$dev" | sed -E 's/.*[^[:digit:]]([[:digit:]]+$)/\1/g'
      for part in "${dev}p"*; do
        if [ "$part" = "${dev}p*" ]; then
          # Single partition image.
          part="${dev}"
        fi
        dst="/mnt/$(basename "$part")"
        echo "$dst" 1>&2
        sudo mkdir -p "$dst"
        sudo mount "$part" "$dst"
      done
    )
    loop-unmount-partitions() (
      set -e
      for loop_id in "$@"; do
        dev="/dev/loop${loop_id}"
        for part in "${dev}p"*; do
          if [ "$part" = "${dev}p*" ]; then
            part="${dev}"
          fi
          dst="/mnt/$(basename "$part")"
          sudo umount "$dst"
        done
        sudo losetup -d "$dev"
      done
    )

  ## Docker

    # The typical usage will look as follows.
    #
    # Create a new container:
    #
    #     dkc
    #
    # Start it if not already started, and do stuff in it:
    #
    #     dke
    #
    # Do it again:
    #
    #     dke
    #
    # Delete the created container and lose all data from it.
    #
    #     dkREMOVE
    #
    # To create and use another container, just add
    # the container name in front of all invocations:
    #
    #     dkc ble
    #     dke ble
    #     dkREMOVE ble

    # Most important commands.
    dk() ( docker "$@" )
    dkc() (
      target_dir=/host
      container="${1:-ub}"
      shift
      image="${1:-ubuntu:18.04}"
      shift
      cmd="${1:-/bin/bash}"
      shift
      dk create -it --name "$container" -w "${target_dir}/$(pwd)" -v "/:${target_dir}" "$image" "$cmd" "$@"
    )
    dke() (
      # Run command in an existing container.
      # Start it if not already started.
      # By default, run /bin/bash and connect to it.
      container="${1:-ub}"
      shift
      cmd="${1:-/bin/bash}"
      shift
      dks "$container"
      dk exec -it "$container" "$cmd" "$@"
      dkS "$container"
    )
    dkREMOVE() (
      container="${1:-ub}"
      shift
      dk rm "$container" "$@"
    )
    dks() (
      # Start a container on the background.
      # It will now appear in docker ps.
      # You can then connect to it with docker exec.
      container="${1:-ub}"
      shift
      dk start "$container" "$@"
    )
    dkS() (
      # Stop a container.
      container="${1:-ub}"
      shift
      dk stop "$container" "$@"
    )
    dkp() (
      # List running containers.
      dk ps "$@"
    )
    dkpa() (
      # List all containers, including ones that are not running.
      dkp -a "$@"
    )

    # Other commands.
    dkb() ( docker build "$@" )
    dkbt() ( dk build -t "$1" . )
    alias dkh='docker help'
    dkrit() { dkr -it "$1" /bin/bash; }
    dkrp() { dkr -d -p 127.0.0.1:8000:80 "$1"; }
    dkrnp() { dkr -d --name "$1" -p 127.0.0.1:8000:80 "$2"; }
    dkru() ( dkr --name ub -it ubuntu:18.04 bash )
    dkrm() ( docker rm "$@" )
    dkrmu() ( docker rm ub )
    alias dkrma='docker rm $(docker ps -aq --no-trunc)'
    dksu() ( dks ub )

  ## du

    alias duh='du -h'
    dush() (
      cd "${1:-.}"
      du -hsx .[^.]* * 2>/dev/null | sort -h
    )
    # dush to File
    dushf() (
      dush | tee ".dush-$(timestamp)~"
    )
    # Cat latest dushf.
    dushfl() ( cat "$(ls -a | grep -E '^.dush-' | sort | tail -n1)"; )

  ## echo

    alias e='echo'
    # echo Exit status
    alias ece='echo "$?"'
    alias ecp='echo "$PATH"'
    alias ecpt='echo "$PATH" | tr : "\n"'

  ## extract

    extract () {
      # Decompress anything. https://xkcd.com/1168/
      # TODO: add a decompress to stdout mode. Ones I know:
      # unzip -p >f
      case $1 in
        *.7z)        7z x "$1";;
        *.Z)         uncompress "$1";;
        *.a)         ar vx "$1";;
        *.cpio)      cpio -i <"$1";;
        *.deb)       dpkg-deb -R "$1" .;;
        *.jar|*.zip) unzip "$1";;
        *.rar)       rar x "$1";;
        *.tar)       tar xvf "$1";;
        *.tar.bz2)   tar xvjf "$1";;
        *.bz2)       bunzip2 "$1";;
        *.tar.gz)    tar xvzf "$1";;
        *.gz)        gunzip --keep "$1";;
        *.tbz2)      tar xvjf "$1";;
        *.tgz)       tar xvzf "$1";;
        *.tar.xz)    unxz "$1"; extract "${1%.*}";;
        *.xz)        unxz "$1";;
        *)           echo "error: unknown extension: $1";;
      esac
    }
    alias ex='extract'

  ## find

    f() ( find "${2-.}" -iname "*$1*" )
    f-depth() ( find . -maxdepth "$2" -iname "*$1*" )
    f2() ( f-depth "$1" 2 )
    f3() ( f-depth "$1" 3 )
    f4() ( f-depth "$1" 4 )
    f-size() (
      # Find the largest files in a directory.
      # https://stackoverflow.com/questions/12522269/bash-how-to-find-the-largest-file-in-a-directory-and-its-subdirectories
      find . -type f | xargs -I'{}' du -h '{}' | sort -hk1
    )

  ## ffmpeg

    # fftrim in.ogv out.ogv 00:10 01:20
    fftrim() ( ffmpeg -i "$1" -ss "$3" -to "$4" -c copy "$2"; )
    # ffcat in1.ogv in2.ogv out.ogv
    ffcat() ( ffmpeg -i concat:"$1|$2" -c copy "$3"; )

  ## Firefox

      # Unsafe settings, for quick testing. Don't access any important page with it.
      fir-test() ( noh firefox -no-remote "$@" -P 'test'; )

  ## gcc

    gcc-pedantic() (
      # GCC with as many checks as I can make it.
      cmd="gcc -ggdb3 -O0 -std=c99 -Wall -Wextra -pedantic $@"
      echo "$cmd"
      eval "$cmd"
    )
    asm-get-bytes() (
      # Assemble and disassemble some arm code to see what the bytes are.
      # https://stackoverflow.com/questions/8482059/how-to-compile-an-assembly-file-to-a-raw-binary-like-dos-com-format-with-gnu/32237064#32237064
      set -e
      pref="$1"
      shift
      name=/tmp/asarm
      in="${name}.S"
      o="${name}.o"
      out="${name}.out"
      raw="${name}.raw"
      printf ".section .text\n.global _start\n_start:\n${*}\n" > "$in"
      "${pref}as" -o "$o" "$in"
      "${pref}ld" -o "$out" "$o"
      "${pref}objcopy" -O binary "$out" "$raw"
      hd "$raw"
    )
    asm-get-bytes-arm() (
      asm-get-bytes arm-linux-gnueabihf- "$@"
    )
    asm-get-bytes-aarch64() (
      asm-get-bytes aarch64-linux-gnu- "$@"
    )

    gcc-pedantic() (
      # GCC with as many checks as I can make it.
      cmd="gcc -ggdb3 -O0 -std=c99 -Wall -Wextra -pedantic $@"
      echo "$cmd"
      eval "$cmd"
    )

    # GCC from String.
    #
    # Better than crepl.
    #
    # Usage:
    #
    #   gccs <main> <c-version> <before-main>
    #
    # Examples:
    #
    #   gccs 'printf('%d', 1 + 1)'
    #   gccs 'printf('%d', f(1))' '99' 'int f(int i) { return i + 1; }'
    #
    # Expected output: `2`
    gccs() { echo "$3 int main(int argc, char** argv){$1; return 0;}" | gcc -std="c${2:-1x}"   -Wall -Wextra -pedantic -xc   -; }
    gpps() { echo "$3 int main(int argc, char** argv){$1; return 0;}" | g++ -std="c++${2:-0x}" -Wall -Wextra -pedantic -xc++ -; }

    alias gcc5="$HOME/git/gcc/install-o0/bin/gcc"

    # Variables instead of aliases so that I can debug them with `gdb "$PROG"`:

      mygdb="$HOME/git/binutils-gdb/install/bin/gdb"
      mygcc_path="$HOME/git/gcc/install/bin"
      mygcc="$mygcc_path/gcc"
      mycc1="$HOME/git/gcc/install/libexec/gcc/x86_64-unknown-linux-gnu/5.1.0/cc1"

    gccver() (
      # https://askubuntu.com/questions/26498/choose-gcc-and-g-version
      # E.g.: gccver 6
      v="$1"
      sudo update-alternatives --remove-all gcc
      sudo update-alternatives --remove-all g++
      sudo update-alternatives --install /usr/bin/gcc gcc "/usr/bin/gcc-$v" 10
      sudo update-alternatives --install /usr/bin/g++ g++ "/usr/bin/g++-$v" 10
    )

    # Build GCC from source.
    gcc-build() (
      # sudo apt-get build-dep gcc
      # sudo apt-get install gnat-4.8
      # git clone git://gcc.gnu.org/git/gcc.git
      # cd gcc
      # git checkout gcc-5_1_0-release
      ./contrib/download_prerequisites
      mkdir build
      cd build
      ../configure --enable-languages=c,c++ --prefix="$(pwd)/install"
      tmkjb
    )

  ## gdb

    gdbcbt() (
      # Run program, show failure backtrace.
      ulimc
      rm -f core
      "$@"
      gdb --batch -ex 'bt' "$1" 'core'
    )
    gdbr() ( gdb -ex 'run' -q --args "$@" )
    gdbrb() ( gdb -ex 'run' -ex 'shell cirosantilli-beep' -q --args "$@" )
    gdbs() ( gdb -ex 'start' -q --args "$@" )
    gdbi() ( gdb -ex 'starti' -q --args "$@" )
    gdbS() ( gdb -ex "break _start" -ex "run" -q --args "$@" )
    gdbx() ( gdb --batch -x "$@" )
    gdbser() (
      # https://stackoverflow.com/questions/75255/how-do-you-start-running-the-program-over-again-in-gdb-with-target-remote/44161527#44161527
      # https://electronics.stackexchange.com/questions/28480/restart-execution-from-the-start-without-having-to-reload
      # Expects the following remote command:
      #     gdbserver --multi :1234
      arch="arm-linux-gnueabihf"
      while getopts a:r: OPT; do
        case "$OPT" in
          a)
            arch="$OPTARG"
            ;;
        esac
      done
      shift $(($OPTIND - 1))
      remote="$1"
      shift
      myexec="$1"
      shift
      "${arch}-gdb" \
        -ex "target extended-remote ${remote}:1234" \
        --args "$myexec" "$@" \
      ;
        #-ex "set remote exec-file $myexec" \
    )
    gdbdis() (
      # https://stackoverflow.com/questions/22769246/how-to-disassemble-one-single-function-using-objdump/31138400#31138400
      gdb -batch -ex "disassemble/rs ${2:-main}" "$1"
    )
    gdbdis-arm() (
      gdb-multiarch -batch -ex "disassemble/rs ${2:-main}" "$1"
    )

  ## GNU changelogs from Git

    # Helper.
    gnu-changelog() (
      {
        printf "$(date '+%Y-%m-%d')  Ciro Santilli  <ciro.santilli@gmail.com>\n\n"
        git diff --name-only $1 HEAD | sed 's/^/\t* /; s/$/ (): ./'
      } | tee /dev/tty | xclip -selection clipboard
    )

    # After Commit, Compare HEAD and HEAD~.
    gnuc() (
      gnu-changelog HEAD~
    )

    # Before commit. Diff. Compare working tree and HEAD.
    gnud() (
      gnu-changelog
    )

  ## Git

    # Fails for aliases that autocomplete like `g co branch<tab>`,
    # still does not expand.
    #alias i='git'
    gacm() ( git commit -am "${1:-bak}" )
    alias gad='git add -A'
    alias gada='git add -A .'
    alias gadcm='git add -A . && git commit'
    alias gadcman='git add . && gcman'
    alias gadcmanpsf='git add . && gcmanpsf'
    alias gadcmm='git add -A . && git commit -m'
    alias gadcmt='git add -A . && git commit -m publish'
    alias gadcmtps='git add -A . && git commit -m publish && git push'
    alias gadcmt='git add -A . && git commit -m tmp'
    alias gadcp='git add -A . && git commit && git push'
    gadcmp() { git add . && git commit -m "${1:-bak}" && git push; }
    alias gadu='git add -u :/'
    alias gaducman='git add -u && gcman'
    alias gadrbc='git add -A . && git rebase --continue'
    alias garcp='git add --ignore-errors README.md index.html index.md && commit --amend --no-edit && push -f'
    alias gbi='git bisect'
    alias gbib='git bisect start && git bisect bad'
    alias gbig='git bisect good'
    alias gbil='git bisect log'
    alias gbir='git bisect run'
    alias gbire='git bisect reset'
    alias gbl='git blame'
    alias gbr='git branch'
    gbrc() ( git branch -a --contains "$@" )
    gbrtac() (
      # Find all branches or tags that contain a given commit.
      git --no-pager branch -a --contains "$@"
      git --no-pager tag --contains "$@"
    )
    gbrsc() ( gforsc refs/heads refs/remotes )
    gbrscm() (
      # Me.
      gbrsc | grep "$(git config user.email)"
    )
    gbrg () { git branch | grep "$1"; }
    gbrag () { git branch -a | grep "$1"; }
    gbrdd() { git branch -d "$1"; git push --delete origin "$1"; }
    alias gbra='git branch -a'
    # BRanch Graph
    alias gbrm='git branch -m'
    gbruo() { git branch -u "origin/$1"; }
    alias gbrv='git branch -vv'
    alias gcl='git clone --recursive'
    gcla() ( git clone "git@gitlab.com:cirosantilli/$1" )
    gclc() { gcl "$1" && cd "$(basename "${1%.git}")"; }
    gclu() ( git clone "git@github.com:cirosantilli/$1" )
    gclx() { gclc "$(x)"; }
    gclxg() { cd "${HOME}/git" && gclx "$(x)"; }
    alias gclb='git clone --bare'
    alias gcf='git cat-file'
    alias gcfp='git cat-file -p'
    alias gcft='git cat-file -t'
    git-create-test-commit() (
      d="$(date)"
      touch "$d"
      git add "$d"
      git commit -m "$d"
    )
    git-hide-time() (
      # https://stackoverflow.com/questions/454734/how-can-one-change-the-timestamp-of-an-old-commit-in-git
      # Set the time of all commits in inclusive range to midnight. Keep date.
      first_commit="$1"
      last_commit="${2:-HEAD}"
      git filter-branch --env-filter '
d="$(echo "$GIT_COMMITTER_DATE" | sed "s/T.*//")T00:00:00+0000)"
export GIT_COMMITTER_DATE="$d"
export GIT_AUTHOR_DATE="$d"
' --force "${first_commit}~..${last_commit}"
    )
    gcm() (
      git commit "$@"
    )
    gcmm() ( gcm -m "$@" )
    gcma() ( gcm --amend "$@" )
    gcman() ( gcma --no-edit "$@" )
    alias gcmanpsf='git commit --amend --no-edit && git push -f'
    alias gce='git clean'
    # Clean files that are not gitignored. Keeps your built object files, to save a lengthy rebuild.
    gcedf() ( git clean -df "${1:-:/}"; )
    gcexdf() (
      # Clean any file not tracked, including gitignored. Restores repo to pristine state.
      git clean -xdf :/
      git submodule foreach --recursive git clean -xdf :/
    )
    gcmp() (
      gacm "$1"
      git push
    )
    gco() (
      git checkout "$@"
      git submodule update --recursive
    )
    alias gcob='gco -b'
    gcobm() { git checkout -b "$1" master; }
    alias gcod='gco --conflict=diff3'
    alias gcoH='gco HEAD~'
    # Last tag.
    alias gcol='gco "$(git describe --tags --abbrev=0)"'
    alias gcom='gco master'
    # Slash
    alias gcos='gco -'
    # Slash Dot
    alias gcosd='gco -- .'
    alias gcoo='git checkout --ours'
    alias gcoT='git checkout --theirs'
    alias gcot='gco trunk'
    alias gcou='gco up'
    alias gcn='git config'
    alias gcng='git config --global'
    alias gcngh='git config user.email "ciro.santilli@gmail.com"'
    # Git config anti-commie.
    alias gcnac='git config user.name "Ciro Santilli 六四事件 法轮功"'
    gcp() ( git cherry-pick "$@" )
    gcpa() ( gcp --abort "$@" )
    alias gd='git diff'
    alias gdf='git diff'
    gdfm() (
      # https://stackoverflow.com/questions/1220309/git-difftool-open-all-diff-files-immediately-not-in-serial/2746292#2746292
      git difftool --dir-diff --tool=meld "${1:-HEAD~}" "${2:-HEAD}"
    )
    alias gdfth='git diff trunk...HEAD'
    alias gdfmh='git diff master...HEAD'
    alias gdfc='git diff --cached'
    alias gdfh='git diff HEAD'
    alias gdfhh='git diff HEAD~ HEAD'
    alias gdfhhs='git diff --stat HEAD~ HEAD'
    alias gdfst='git diff --stat'
    alias gdfx='git diff | y'
    gdf12() { git diff ":1:./$1" ":2:./$1"; }
    gdf13() { git diff ":1:./$1" ":3:./$1"; }
    gdf123() {
      git --no-pager diff ":1:./$1" ":2:./$1";
      python -c 'print "\n" + (80 * "=") + "\n"';
      git --no-pager diff ":1:./$1" ":3:./$1";
    }
    alias gfe='git fetch --tags'
    alias gfea='git fetch --all --tags'
    gferh() { git fetch "$@" && git reset --hard FETCH_HEAD; }
    alias gfeomm='git fetch origin master:master'
    alias gfeumm='git fetch up master:master'
    gfeommcob() { git fetch origin master:master && git checkout -b "$1" master; }
    gfp() ( git format-patch "$@" )
    gfph() ( gfp "HEAD~${1:-1}" )
    alias gfpx='git format-patch --stdout HEAD~ | xclip -selection clipboard'
    gforsc() (
      # For Each Ref Sort Creator.
      # http://stackoverflow.com/a/5188364/895245
      # creatordate works better with unanotated tags:
      # https://stackoverflow.com/questions/6269927/how-can-i-list-all-tags-in-my-git-repository-by-the-date-they-were-created/34919313#34919313
      git for-each-ref --sort=creatordate --format="%(creatordate:iso) %(refname) %(committeremail) %(subject)" "$@"
    )
    alias gg='git grep --color'
    alias ggi='git grep --color -i'
    alias gka='gitk --all'
    alias gin='git init'
    # Init Add Commit
    alias ginac='git init && git add . && git commit -m "init"'
    git-restore-file() {
      # Restore deleted file to its latest version.
      # http://stackoverflow.com/questions/953481/restore-a-deleted-file-in-a-git-repo
      git checkout $(git rev-list -n 1 HEAD -- "$1")^ -- "$1"
    }
    gls() ( git ls-files "$@" )
    gls-binary()(
      # https://stackoverflow.com/questions/30689384/find-all-binary-files-in-git-head/32267369#32267369
      grep -Fvxf <(git grep --cached -Il '') <(git grep --cached -al '')
    )
    glsf()(
      # Git list only regular files: exclude submodules, symlinks, empty files and text files.
      # https://stackoverflow.com/questions/40165650/how-to-list-all-files-tracked-by-git-excluding-submodules
      git grep --cached -Il ''
    )
    glsd()(
      # List all directories in a git repository:
      # https://stackoverflow.com/questions/20247389/how-can-i-make-git-list-only-the-tracked-directories-in-a-folder/54162211#54162211
      git ls-tree -rt HEAD:./ | awk '{if ($2 == "tree") print $4;}'
    )
    glsfg()( glsf | g "$@" )
    glsg() ( gls | g "$@" )
    glsgi() ( glsg -i "$@" )
    alias glsr='git ls-remote'
    alias glo='git log --decorate --pretty=fuller'
    glog() ( git log --abbrev-commit --decorate --graph --pretty=oneline "$@" )
    gloG() ( git log --grep "$@" )
    alias gloga='git log --abbrev-commit --decorate --graph --pretty=oneline --all'
    alias glogas='git log --abbrev-commit --decorate --graph --pretty=oneline --all --simplify-by-decoration'
    alias glogs='git log --abbrev-commit --decorate --graph --pretty=oneline --simplify-by-decoration'
    gloG() ( glo --grep "$@" )
    alias glom='git log --author="$(git config user.name)"'
    alias glop='glo -p'
    glops() (
      # Search for commit that modifies a line matching pattern.
      glo -p -S "$@"
    )
    glopsr() (
      glops "$@" --reverse
    )
    alias glos='glo --stat'
    #alias glopf='git log --pretty=oneline --decorate'
    alias glopf='git log --all --pretty=format:"%C(yellow)%h|%Cred%ad|%Cblue%an|%Cgreen%d %Creset%s" --date=iso | column -ts"|" | less -r'
    gloS() (
      # Find where that feature entered the code base.
      # https://stackoverflow.com/questions/5816134/finding-a-git-commit-that-introduced-a-string-in-any-branch/31621921#31621921
      git log -p --reverse -S "$1"
    )
    # Get last SHA commit into clipboard.
    glox() (
      git log -1 --format="%H" $1 | tr -d '\n' | tee >(cat 1>&2) | y
    )
    # Also get committer date.
    alias gloxd='git log -1 --format="%H %cd" | y'
    git-is-ancestor() (
      if git merge-base --is-ancestor "$1" "$2"; then
          echo 'ancestor'
      elif git merge-base --is-ancestor "$2" "$1"; then
          echo 'descendant'
      else
          echo 'unrelated'
      fi
    )
    alias giia='git-is-ancestor'
    git-tab-to-space() (
      d="$(mktemp -d)"
      # https://stackoverflow.com/questions/11094383/how-can-i-convert-tabs-to-spaces-in-every-file-of-a-directory/52136507#52136507
      git grep --cached -Il '' | grep -E "${1:-.}" | \
        xargs -I'{}' bash -c '\
        f="${1}/f" \
        && expand -t 4 "$0" > "$f" && \
        chmod --reference="$0" "$f" && \
        mv "$f" "$0"' \
        '{}' "$d" \
      ;
      rmdir "$d"
    )
    alias gmb='git merge-base'
    alias gmbm='git merge-base HEAD master'
    alias gme='git merge'
    alias gmea='git merge --abort'
    alias gmem='git merge master'
    alias gmt='git mergetool'
    alias gmv='git mv'
    alias gnr='git name-rev HEAD'
    alias gppp='git push prod prod'
    alias gps='git push --follow-tags'
    gpsa() ( git push "git@gitlab.com:cirosantilli/$1" )
    gpsu() ( git push "git@github.com:cirosantilli/$1" )
    alias gpsf='git push -f'
    # Wobble
    alias gpsfw='git push -f origin HEAD~:master && git push -f'
    alias gpsr='git push --recurse-submodules='
    gpl() ( git pull "$@" && gsuu )
    alias gplr='git pull --rebase'
    alias gplum='git pull up master'
    alias gplrum='git pull --rebase up master'
    alias gplo='git pull origin'
    alias gplom='git pull origin master'
    grb() ( git rebase --committer-date-is-author-date )
    alias grba='git rebase --abort'
    alias grbc='git rebase --continue'
    grbi() ( git rebase -i "$@" )
    grbih() ( git rebase -i "HEAD~${1:-1}" )
    git-amend-old() (
      # Stash, apply to past commit, and rebase the current branch on to of the result.
      # For Gerrit. https://stackoverflow.com/questions/1186535/how-to-modify-a-specified-commit/53597426#53597426
      current_branch="$(git rev-parse --abbrev-ref HEAD)"
      apply_to="$1"
      git stash
      git checkout "$apply_to"
      git stash apply
      git add -u
      git commit --amend --no-edit
      new_sha="$(git log --format="%H" -n 1)"
      git checkout "$current_branch"
      git rebase --onto "$new_sha" "$apply_to"
    )
    alias grbm='git rebase master'
    grbo() (
      # Rebase current branch onto another ref.
      # Useful to rebase a feature branch of a feature branch
      # after master gets updated and the feature branch rebased.
      ref="$(git rev-parse --abbrev-ref HEAD)"
      git rebase --onto "${1:-master}" "${2:-HEAD~}" "$ref"
    )
    alias grbt='git rebase trunk'
    # Rebase trunk Updated.
    alias grbtu='git checkout trunk && git pull && git checkout - && git rebase trunk && git submodule update'
    alias grs='git reset'
    # http://stackoverflow.com/questions/7275508/is-there-a-way-to-squash-a-number-of-commits-non-interactively
    # http://stackoverflow.com/questions/1549146/find-common-ancestor-of-two-branches
    alias grssm='git reset --soft "$(git merge-base master HEAD)"'
    alias grsst='git reset --soft "$(git merge-base trunk HEAD)"'
    alias grsh='git reset --hard'
    alias grsH='git reset HEAD~'
    alias grshH='git reset --hard HEAD~'
    alias grl='git reflog --date iso'
    alias grm='git rm'
    alias grt='git remote'
    alias grta='git remote add'
    alias grtao='git remote add origin'
    alias grtau='git remote add up'
    alias grtv='git remote -v'
    alias grtr='git remote rename'
    alias grtro='git remote rename origin'
    grtrou() ( git remote rename origin up && git remote add origin "$1" && git branch --set-upstream-to 'origin/master'; )
    grtrhs() (
      # HTTP to SSH
      old_origin="$(git remote -v | awk '/^origin\t/' | head -n1 | awk '{ print $2; }')"
      new_origin="git@$(echo "$old_origin" | sed -E 's|^https://([^/]+)/|\1:|' | sed -E 's|/$||' ).git"
      git remote set-url origin "$new_origin"
    )
    alias grts='git remote set-url'
    alias grtso='git remote set-url origin'
    alias gsa='git stash'
    alias gsaa='git stash apply'
    gsh() ( git show "$@" )
    alias gst='git status'
    alias gsu='git submodule'
    alias gsua='git submodule add'
    alias gsuf='git submodule foreach'
    alias gsufp='git submodule foreach git pull'
    gsuu() ( git submodule update --init --recursive "$@" )
    alias gta='git tag'
    gtac() ( git tag --contains "$@" )
    # Git TAg Date
    alias gtad='git for-each-ref --sort=taggerdate --format "%(refname) %(taggerdate)" refs/tags'
    gtasc() ( gforsc refs/tags )
    alias gtag='gta | g'
    alias gtas='git tag | sort -V'
    alias gtr='git ls-tree HEAD'
    gwtl() ( git worktree list )
    gwtp() ( git worktree prune )

    alias vgig='vim .gitignore'
    alias lngp='latex-new-github-project.sh cirosantilli'

    # GitHub

      alias ghb='git browse-remote'
      alias ghpb='git push && git browse-remote'
      ghmail() ( curl "https://api.github.com/users/$1/events/public" | grep email )
      alias gpsbr='gps && git browse-remote'
      alias gcmanpsfbr='gcmanpsf && git browse-remote'
      # Pull Request.
      ghpr() { git fetch up refs/pull/$1/head; git checkout -b new-branch FETCH_HEAD; }

      ## Hub

        alias huco='hub checkout'

      ## lovechina

        gh-lovechina() (
          git config user.email 'cirosantilli-lovechina@yandex.com'

          # https://stackoverflow.com/questions/15227130/using-a-socks-proxy-with-git-for-the-http-transport
          git config http.proxy 'socks5://127.0.0.1:9050'

          # https://superuser.com/questions/232373/how-to-tell-git-which-private-key-to-use/912281#912281
          #ssh-keygen "$HOME/.ssh/id_rsa_lovechina"
          git config core.sshCommand 'ssh -i ~/.ssh/id_rsa_lovechina -F /dev/null'
        )

      ## 2

        gh-2() (
          git config user.email 'cirosantilli@outlook.com'
          # https://superuser.com/questions/232373/how-to-tell-git-which-private-key-to-use/912281#912281
          git config core.sshCommand 'ssh -i ~/.ssh/id_rsa_2 -F /dev/null'
        )

    ## Gerrit

      alias gpsd='git push origin HEAD:refs/drafts/master'
      alias gpsdt='git push origin HEAD:refs/drafts/trunk'


    ## GitLab

      # Start developping GitLab.
      dev-gitlab-startup() {
        guake -e 'cd ~/gitlab-development-kit/ && bundle exec foreman start'
        guake -n 'server' -e 'cd ~/gitlab && bundle exec foreman start'
        guake -n 'server' -e 'cd ~/gitlab'
        guake -n 'server' -e "cd \"$RAILS_DIR\""
        guake -n 'server' -e 'cd ~/test'
      }

      # Rename Origin from githUb to gitlAb.
      grtroua() {
        old_origin="$(git remote -v | awk '/^origin\t/' | head -n1 | awk '{ print $2; }')"
        new_origin="$(echo "$old_origin" | sed -E 's/^git@github/git@gitlab/')"
        git remote set-url origin "$new_origin"
        git remote add gh "$old_origin" &>/dev/null || :
        git remote add gl "$new_origin" &>/dev/null || :
      }

      grtroau() {
        old_origin="$(git remote -v | awk '/^origin\t/' | head -n1 | awk '{ print $2; }')"
        new_origin="$(echo "$old_origin" | sed -E 's/^git@gitlab/git@github/')"
        git remote set-url origin "$new_origin"
        git remote add gl "$old_origin" &>/dev/null || :
        git remote add gh "$new_origin" &>/dev/null || :
      }

  ## Graphics

    # https://stackoverflow.com/questions/17196117/disable-vertical-sync-for-glxgears
    alias glxgears-novsyc='__GL_SYNC_TO_VBLANK=0 vblank_mode=0 glxgears'

  ## grep

    g() ( grep -E --color=auto "$@"; )
    gi() ( g -i "$@" )
    gr() ( g -R "$@" )
    gri() ( gi -R "$@" )
    grib() (
      # Ignore binary files.
      gri --binary-files without-match "$@"
    )
    gv() ( g -v "$@" )

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

  ## hexdump

    # Convert binary file to space separated hex.
    #
    # Usage:
    #
    #     rm -f f.bin
    #     for i in `seq 32`; do
    #       printf '\x12\x34\x56\x78' >> f.bin
    #     done
    #     odd f.bin
    #
    # Output:
    #
    #     12 34 56 78
    #
    # repeated a bunch of times in a single long line.
    #
    # Portability: POSIX 7.
    #
    # Bibliography:
    # https://stackoverflow.com/questions/2614764/how-to-create-a-hex-dump-of-file-containing-only-the-hex-characters-without-spac/2614831#2614831
    od-raw() (
      od -A n -t x1 -v "$@" | tr -d '\n' | cut -c 2-
    )

    # od with hex address + values
    #
    # Usage:
    #
    #     dd if=/dev/random of=f.bin count=64 bs=1
    #     od-hex f.bin
    #
    # Sample output:
    #
    #     000000 76 ac 12 2e 45 22 0f 3a 73 b4 cd 31 26 31 8b 03
    #     000010 be 6b c6 85 84 01 ed 42 2d dd ed 5f 6d 97 18 79
    #     000020 ea 6d d5 7f 6e ef b5 7d 18 56 86 c1 80 ff ee e9
    #     000030 af 9e 9f 6f 67 86 b7 56 b3 09 9e a8 69 09 0f 3e
    #     000040
    od-hex() (
      od -A x -t x1 "$@"
    )

  ## hg

    alias hgg='hg grep'
    alias hggi='hg grep -i'

  ## homeshick

    alias hs='homeshick'
    alias hscd='homeshick cd dotfiles'
    alias hsh='homeshick help'
    alias hsp='homeshick pull'
    alias hsu='homeshick push'
    alias hst='homeshick track dotfiles'

  ## Java

    ja() { java "${1%.*}" "${*:2}"; }
    alias jac='javac'
    jae() { java -ea "${1%.*}" "${*:2}"; }
    alias jaj='java -jar'
    alias jartf='jar -tf'
    alias jav='java -version'
    jap() { javap -c -constants -private -verbose "${1%.*}.class"; }

  ## jekyll

    alias bej='bundle exec jekyll'
    alias bejb='bundle exec jekyll build -It'
    alias bejs='open http://localhost:4000 && bundle exec jekyll serve -Itw'

  ## Last Command

    # Last Command to clipboard.
    alias fcx='fc -ln -1 | sed "s/\t //" | y'

    # https://unix.stackexchange.com/questions/24739/how-to-execute-consecutive-commands-from-history/429552#429552
    fcn() (
      from="${1:-2}"
      to="${2:-1}"
      if [ "$from" -ne "$to" ]; then
        for i in `seq "$from" -1 "$(($to + 1))"`; do
          printf "$(fc -ln -${i} -${i}) && "
        done
      fi
      printf "$(fc -ln -${to} -${to})"
    )
    fcnx() ( fcn | x )

  ## less

    s() (
      # Desired behaviour:
      # - never wrap lines
      # - right key panes
      # - show colors as colors
      # https://unix.stackexchange.com/questions/117878/show-colors-and-disable-line-wrap
      less -FRSX "$@"
    )

  ## ls

    l() ( ls "$@"; )
    ls() ( command ls -A -1 --color=auto --group-directories-first "$@"; )
    lswc() ( ls -1 "${1:-.}" | wc -l )
    lsf() (
      # List files.
      # https://stackoverflow.com/questions/10574794/how-to-list-only-files-in-bash/46135507#46135507
      ls -p "$@" | grep -v /
    )
    lsg() ( ls "${2:-.}" | g "$1" )
    lsgi() ( ls "${2:-.}" | gi "$1" )
    ll() ( ls -hl --time-style="+%Y-%m-%d_%H:%M:%S" "$@"; )
    lll() ( ll --color | s -R; )
    lla() ( ll -A "$@"; )
    # Sort by size.
    lls() ( lla -Sr "$@"; )
    lsv() ( ls | sort -V )
    alias llS='lla -S'

    ## Latest File modified operations

      # Last File Ls -l. Sort by olest ctime first. So newest shows first on terminal.
      lfl() ( command ls --color=auto -Achlrt "${1-.}"; )
      lfll() ( ll "$(lfg "$1")"; )
      lflcd() { cd "$(lfg "$1")"; }
      # Get absolute path to last modified path in given directory.
      lfg() (
        dir="${1:-.}"
        grep="${2:-}"
        echo "$(cd "$dir" && pwd)/$(command ls -ct "${dir:-.}" | grep "$grep" | head -n1)";
      )
      lfcd() { cd "$(lfg "$1")"; }
      # lfm dst [src-dir=.]
      # Move latest modified file in src-dir to dst.
      lfm() (
        src="$(lfg "${1:-.}")"
        dst="${2:-.}"
        echo "$src"
        mv "$src" "$dst"
      )
      # Cp
      lfc() (
        src="$(lfg "${1:-.}")"
        dst="${2:-.}"
        echo "$src"
        cp "$src" "$dst"
      )
      # Open.
      lfo() (
        src="$(lfg "$@")"
        echo "$src"
        o "$src"
      )
      # Open latest download.
      lfod() ( lfo "$DOWNLOAD_DIR" "$@"; )
      # Move Latest Download to current directory.
      lfmd() (
        file="$(lfg "$DOWNLOAD_DIR")"
        if echo "$file" | grep -Eq '\.(part|chrdownload|crdownload)$'; then
          echo 'Download not finished'
          exit 1
        fi
        lfm "$DOWNLOAD_DIR" .
      )
      # Move Latest Download to a newly created temporary directory and cd into it.
      # Great when you are going to extract stuff and work on it.
      lfmdd() {
        dst="${CIROSANTILLI_TMP_DIR}/down/$(basename "$(lfg "$DOWNLOAD_DIR")")-$(timestamp)"
        mkdir -p "$dst"
        cd "$dst"
        lfmd
      }

  ## make

    alias mk='make'
    alias mkc='make clean'
    alias mkd='make debug'
    alias mkdc='make distclean'
    alias mkde='make deps'
    alias mkh='make help'
    alias mkhl='make help | less'
    # It is better to `make` first without the sudo so that the generated build
    # will not be owned, or else it could only be cleaned with by sudo.
    alias mki='make install'
    alias smki='sudo make install'
    alias mkir='make && sudo make install && make install-run'
    mkj() ( make -j"$(npro)" "$@")
    # Stop background watch.
    alias mkk='make kill'
    # List targets.
    alias mkl="make -qp | awk -F':' '/^[a-zA-Z0-9][^\$''#\/\t=]*:([^=]|\$)/ {split(\$1,A,/ /);for(i in A)print A[i]}' | sort"
                                                    # ^^ to prevent a vim syntax bug: https://code.google.com/p/vim/issues/detail?id=364&
    alias mksx='make SHELL="sh -x"'
    alias mkq='make qemu'
    alias mkr='make run'
    mkrr() { make run RUN="${1%.*}"; }
    alias mkt='make test'
    alias mku='sudo make uninstall'
    alias mkv='make view'
    alias mkw='make watch'
    tb() { time "$@"; b; }
    alias tmkb='time make; b'
    # Time the build, use many processors, alert me when done.
    tmkjb() ( time make -j"$(npro)"; b )
    # Like above, but also do a local `make install`.
    alias tmkjbi='time make -j"$(npro)"; make install; b'
    alias tmkcb='time make check; b'
    alias tmkcjb='time make -j"$(npro)" check;b'
    alias tf='tail -f'
    alias tn='tail -n+1'

    # From Git root:

      alias gmk='git !exec make'
      alias gmkc='git !exec make clean'
      alias gmkd='git !exec make dist'
      alias gmkr='git !exec make run'
      alias gmkt='git !exec make test'

  ## Mass regex operations

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
    # - will transform symlinks into files: https://unix.stackexchange.com/questions/9318/is-there-a-way-to-make-perl-i-not-clobber-symlinks
    # - will add trailing newlines to files that end without them
    #
    mrr() {
      if [ $# -gt 1 ]; then
        if [ "$2" = 'D' ]; then
          xargs perl -pi -e "s/$1"
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
    grepb() { perl -ne "print if m/$1(?!.*\/.)/i" | grep --color -Ei "$1|\$"; }

    # Find files recursively filtering by regex.
    #
    # Basename only, prune hidden.
    fin() { find . -path '*/.*' -prune -o ! -name '.' -print | sed "s|^\./||" | grepb "$1"; }
    # Also Hidden.
    finh() { find . ! -path . | sed "s|^\./||" | grepb "$1"; }
    # full Path.
    finp() { find . ! -path . | sed "s|^\./||" | perl -ne "print if m/$1/"; }
    fine() ( find . -executable -type f -iname "*${1:-*}*" )

    # Mass rename refactoring.
    alias mvr='move_regex.py'

  ## mount

    alias mnt='mount'
    alias mntg='mount | gi'
    alias umnt='sudo umount'

  ## mysql

    alias myr='mysql -u root -p'

  # Before using this you must run:
    #mysql -u root -h localhost -p -e "
    #  CREATE USER 'a'@'localhost' IDENTIFIED BY 'a';
    #  CREATE DATABASE test;
    #  GRANT ALL ON a.* TO 'a'@'localhost';
    #"
  # Mnemonic: MYsql Test
  alias myt='mysql -u a -h localhost -pa a'

  ## music

    alias mbra="nohup vlc --recursive expand \"$MUSIC_DIR/brazillian\" >/dev/null &"
    alias mcla="nohup vlc --recursive expand \"$MUSIC_DIR/classic\" >/dev/null &"
    alias mctm="nohup vlc --recursive expand \"$CHINESE_MUSIC_DIR\" >/dev/null &"
    alias mitm="nohup vlc --recursive expand \"$INDIAN_MUSIC_DIR\" >/dev/null &"
    alias mjfr="nohup vlc --recursive expand \"$JAZZ_MUSIC_DIR\" >/dev/null &"
    alias mroc="nohup vlc --recursive expand \"$MUSIC_DIR/rock\" >/dev/null &"

  ## Maven

    alias maa='mvn assembly:single'
    alias mac='mvn clean'
    alias maca='mvn clean assembly:single'
    alias maca='mvn clean install -DskipTests assembly:single'
    alias maci='mvn clean install -DskipTests'
    alias macj='mvn clean install -DskipTests && mvn exec:java'
    alias mact='mvn clean test'
    alias mad='mvn javadoc:javadoc'
    # Doc View
    alias madv='mvn javadoc:javadoc && xdg-open target/site/apidocs/index.html'
    alias maej='mvn exec:java'
    alias mai='mvn install'
    alias mao='mvn compile'
    alias mas='mvn surefire-report:report-only && xdg-open target/site/surefire-report.html'
    alias map='mvn package'
    alias mat='mvn test'
    matt() { mvn test "-Dtest=$1"; }

  ## PATH operations

    # Prepend to a colon : separated path. Usage: `pre PATH /some/path`
    pre() { eval "export $1=$2:\$$1"; }
    prel() { pre 'LIBRARY_PATH' "$1"; pre 'LD_LIBRARY_PATH' "$1"; }
    prep() { pre 'PATH' "$1"; }
    #prepop() { eval "$1=$(printf "$1" | sed -E 's/^[^:]*://')"; }
    prepop() { eval "$1=\${$1#*:}"; }

  ## npm

    npmi() ( npm install "$@" )
    npmis() ( npm install "$@" )
    npms() ( npm start "$@" )

  ## power management

    alias pmhi='sudo ps-hibernate'
    alias pmsh='sudo shutdown'
    alias pmsu='sudo ps-suspend'
    alias pmre='sudo reboot'

  ## python

    alias py='python'
    alias pyv='python --version'
    alias py3='python3'
    alias pyi='ipython'
    alias pyi3='ipython3'
    alias pyti='touch __init__.py'
    alias pyserve='python -m SimpleHTTPServer'
    alias pyjson='python -m json.tool'
    alias pydoc='python -m doctest'
    # http://stackoverflow.com/questions/24906126/how-to-unpack-pkl-file
    pyp() (
      python -c 'import pickle,sys;d=pickle.load(open(sys.argv[1],"rb"));print(d)' "$1"
    )
    alias jupn='jupyter notebook'

    ## pip

      # http://stackoverflow.com/questions/402359/how-do-you-uninstall-a-python-package-that-was-installed-using-distutils/43650802#43650802
      python-setup-uninstall() (
        sudo rm -f files.txt
        sudo python setup.py install --record files.txt && \
        xargs rm -rf < files.txt
        sudo rm -f files.txt
      )
      # https://stackoverflow.com/questions/49836676/error-after-upgrading-pip-cannot-import-name-main/51846054#51846054
      # https://stackoverflow.com/questions/43675074/python3-6-importerror-cannot-import-name-main-linux-rhel6/49994490#49994490
      # https://github.com/pypa/pip/issues/5447
      pi() ( python -m pip "$@" )
      pii() ( pi install --user "$@" )
      pi3() ( python3 -m pip "$@" )
      pi3i() ( pi3 install --user "$@" )
      piu() ( pi uninstall --user "$@" )
      pise() ( pi search "$@" )
      pif() ( pi freeze | grep -E "${1:-^}")
      pi3f() ( pi3 freeze | grep -E "${1:-^}")
      pifr() (
        pif "$@" >> requirements.txt
        sort -fu -o requirements.txt requirements.txt
      )
      piir() ( pii -r requirements.txt )

    ## virtualenv

      vira() { . .venv/bin/activate;  }
      vird() { deactivate; }
      vire() ( echo "$VIRTUAL_ENV" )
      virp2() { virtualenv -p python2 .venv && vira;  }
      virp() { virtualenv -p python3 .venv && vira;  }

    ## django

      # Django Manage Run Server.
      alias dmn='python manage.py'
      alias dmsu='python manage.py createsuperuser --username a --email a@a.com'
      alias dmmi='python manage.py migrate'
      alias dmmm='python manage.py makemigrations'
      alias dmsp='python manage.py startproject && python manage.py migrate'
      alias dmrs='python manage.py runserver'
      # Db Shell.
      alias dmds='python manage.py dbshell'
      # Sync DB.
      alias dmsd='python manage.py syncdb'
      alias dmte='python manage.py test'
      # Collect Static.
      alias dmcs='echo "yes" | python manage.py collectstatic'

      ## South

        alias dmscts='python manage.py convert_to_south'
        alias dmssi='python manage.py schemamigration --initial'
        alias dmssa='python manage.py schemamigration --auto'

  ## qemu

    qemucon() (
      ./configure --enable-debug --enable-trace-backends=simple --target-list=x86_64-softmmu,arm-softmmu,aarch64-softmmu
      tmkjb
    )
    alias qemu='qemu-system-x86_64'
    alias qemu32='qemu-system-i386'
    qemumk() (
      ./configure --enable-debug --enable-trace-backends=simple --target-list=x86_64-softmmu,arm-softmmu,aarch64-softmmu && tmkjb
    )
    # Debug.
    qemud() {
      qemu-system-x86_64 -hda "$1" -S -s &
      gdb -ex 'target remote localhost:1234' -ex 'break *0x7c00' -ex 'continue'
    }
    qemud32() {
      qemu-system-i386 -hda "$1" -S -s &
      gdb -ex 'target remote localhost:1234' -ex 'break *0x7c00' -ex 'continue'
    }
    qemupi() (
      qemu-system-arm \
        -kernel "$2" \
        -cpu arm1176 \
        -m 256 \
        -M versatilepb \
        -no-reboot \
        -serial stdio \
        -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
        -hda "$1"
    )

  ## imagemagick

    # Get value of pixel at given location.
    impx() (
      convert "$1" -crop 1x1+${2:-1}+${3:-1} rgba:- | od -An -tx1
    )

  ## linux kernel

    lkg() (
      # Grep the Linux kernel.
      # Ignore the huge arch and drivers.
      # http://stackoverflow.com/questions/10423143/how-to-exclude-certain-directories-files-from-git-grep-search
      # TODO ignore all archs except x86.
      git grep -i "$1" -- './*' ':!arch/**' ':!drivers/**'
    )
    lkga() (
      # Ignore drivers.
      git grep -i "$1" -- './*' ':!drivers/**'
    )
    # Ignore the huge arch and drivers.
    lkcon() ( "${LKMC_DIR}/linux/scripts/extract-ikconfig" "$@" )
    alias lkmkA='CROSS_COMPILE=aarch64-linux-gnu- time make ARCH=arm64 -j`nproc`'
    alias mkold='make oldconfig'
    alias mkdef='make defconfig'
    alias mkmen='make menuconfig'
    dtbs() ( dtc -I dtb -O dts -o - "$1"; )
    dtsb() ( dtc -I dts -O dtb -o - "$1"; )

  ## rake

    alias rk='rake'
    alias rkc='rake clean'

  ## rails

    alias rdcm='rake db:drop db:migrate'
    alias be='bundle exec'
    alias bei='bundle exec spinach'
    alias bec='bundle exec rspec'
    alias befs='bundle exec foreman start'
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

  ## raspberry pi

    # Exit with: Ctrl + A then backslash '\'.
    piip() ( cat /var/lib/misc/dnsmasq.leases | cut -d ' ' -f 3; )
    pissh() ( sshpass -p raspberry ssh "pi@$(piip)"; )
    pivin() (
      vinagre "$(piip)"
    )

  ## screencast

    # SILENCE YOUR MESSAGING APPS NOW!!!
    rec() (
      sleep 2
      #spd-say rec
      recordmydesktop --stop-shortcut "Control+Mod1+z"
      b
    )
    screencast() {
      export PS1="$(printf "\033[1;31m%$(tput cols)s\033[0m" | tr ' ' '-')"'\n$ '
      clear
    }

  ## Services

    sso() ( sudo service "$1" stop; )
    ssr() ( sudo service "$1" restart; )
    sss() ( sudo service "$1" start; )
    sst() ( sudo service "$1" status; )
    ssta() ( sudo service --status-all; )
    alias ssra='sudo service apache2 restart'
    alias ssrn='sudo service network-manager restart'
    alias ssrl='sudo service lightdm restart'

    # Edit /etc/exports and then run this.
    # http://www.askubuntu.com/questions/452826/wireless-networking-not-working-after-resume-in-ubuntu-14-04
    alias ssrf='sudo service nfs-kernel-server restart'

  ## svn

    # http://stackoverflow.com/questions/239340/automatically-remove-subversion-unversioned-files/239358#239358
    svn-clean() ( svn status | grep ^\? | cut -c9- | xargs -d \\n rm -r )
    svnd() ( svn diff )
    # Diff current and last revision.
    svndhh() ( svn diff -r BASE:PREV )
    # http://stackoverflow.com/questions/1491514/exclude-svn-directories-from-grep
    svng() ( gri -I --exclude-dir '.svn' "$@" )
    svnl() ( svn log | s )
    # http://stackoverflow.com/questions/6204572/is-there-a-subversion-command-to-reset-the-working-copy/6204618#6204618
    svn-reset() ( svn revert --recursive . )
    svnst() ( svn status "$@" )
    # http://stackoverflow.com/questions/17658065/how-to-list-svn-tags-and-its-revisions-from-command-line
    svnta() ( svn ls -v ^/tags; )
    # Git pull.
    svnup() ( svn update "$@" )

  ## tmux

    tm() ( tmux "$@" )
    tma() (
      cirosantilli-tmux "$@"
      # https://superuser.com/questions/878890/attach-a-tmux-session-to-a-remote-machine/912400#912400
      #tmux attach-session "$@"
    )
    tml() ( tmux list-sessions "$@" )
    tms() (
      tmux split-window -h "bash --rcfile <(echo '. ~/.bashrc;$*')"
    )
    tmsu() (
      # tms unique
      # Run command on a split pane.
      # If the split already exists, kill it and start a new pane.
      if [ "$(tmux list-panes | wc -l | cut -d' ' -f1)" -ne 1 ]; then
        tmux kill-pane -t 1
      fi
      tms "$@"
    )

  ## Ubuntu

    dconf-load() (
      dconf load / < "$DOTFILES_DCONF"
    )
    dconf-watch() (
      dconf watch /
    )
    kernel-config() ( cat "/boot/config-$(uname -r)" )

  ## vagrant

    alias vde='vagrant destroy'
    alias vdef='vagrant destroy -f'
    alias vdu='vagrant destroy -f && vagrant up'
    alias vdus='vagrant destroy -f && vagrant up && vagrant ssh'
    alias vha='vagrant halt'
    alias vpr='vagrant provision'
    alias vss='vagrant ssh'
    alias vup='vagrant up'
    alias vups='vagrant up && vagrant ssh'
    alias vus='vagrant up --no-provision && vagrant ssh'

  ## vim

    v() ( gvim-remote "$@"; )
    vg() ( v '.gitignore'; )
    vr() ( v 'README.md'; )
    vw() ( v "$(which "$1")"; )

  ## which

    catw() { cat "$(which "$1")"; }
    filw() { file "$(which "$1")"; }

  ## x clipboard

    x() ( xsel -b "$@" )
    y() ( xsel -bi "$@" )
    alias ya='xsel -ba'
    alias exx='expand | y'
    # Use xclip instead of xsel while I have this bug:
    # http://askubuntu.com/questions/652254/xsel-output-contains-trash-at-the-end-if-a-long-input-is-piped-into-it-to-set-th
    alias xex='x | expand | y'
    # Add 4 spaces to every line and save to clipboard.
    # For markdown, so also expand.
    alias x4='sed -e "s/^/    /" | sed -e "s/[[:space:]]*$//" | expand | tee /dev/tty | y'
    alias xsh='x | bash -xv'
    xssh() ( y < "$HOME/.ssh/id_rsa${1}.pub"; )
    alias xb='x | bash'
    alias xl='x | less'
    # Join lines on clipboard, no separator.
    xpx() ( x | paste -sd '' - | x; )

    ## Clipboard path operations

      # Absolute path.
      xab() ( printf "$(pwd)/$1" | y; )
      xmv() ( mv "$(x)" "${1:-.}"; )
      xcp() ( cp -r "$(x)" "${1:-.}"; )
      xpw() ( pwd | y; )

  ## xdg
  alias o='xdg-open'
  alias mime='xdg-mime query filetype'
  alias vmime='~/.local/share/applications/mimeapps.list'

  ## xbacklight

    xback() (
      # https://askubuntu.com/questions/149054/how-to-change-lcd-brightness-from-command-line-or-via-script/976829#976829
      done=false;
      echo "less: h, more: l, quit: q"
      while ! $done; do
        read -rsn1 key
        if [ "$key" = h ]; then
          xbacklight -dec 10
        elif [ "$key" = l ]; then
          xbacklight -inc 10
        elif [ "$key" = q ]; then
          done=true
        fi
        printf "\r$(xbacklight -get) "
      done
    )

## Sources

  # Here be dragons.

  # Enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f '/etc/bash_completion' ] && ! shopt -oq 'posix'; then
    . '/etc/bash_completion'
  fi

  ## homeshick
  #git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
  f="$HOME/.homesick/repos/homeshick/homeshick.sh"
  if [ -e "$f" ]; then
    . "$f"
  fi

  ## Google Cloud gsutil
  d="$HOME/google-cloud-sdk"
  if [ -d "$d" ]; then
    # The next line updates PATH for the Google Cloud SDK.
    . "$d/path.bash.inc"
    # The next line enables shell command completion for gcloud.
    . "$d/completion.bash.inc"
  fi

  ## GVM
  f="$HOME/.gvm/scripts/gvm"
  if [ -f "$f" ]; then
    . "$f"
    gvm use go1.11 2>&1 >/dev/null
  fi

  ## NVM
  # https://askubuntu.com/questions/594656/how-to-install-the-latest-versions-of-nodejs-and-npm/971612#971612
  #[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  f="$HOME/.nvm/nvm.sh"
  if [ -r "$f" ]; then
    . "$f" &>'/dev/null'
    nvm use --lts &>'/dev/null'
  fi

  ## RVM
  f="$HOME/.rvm/scripts/rvm"
  [ -f "$f" ] && . "$f"

  # Travis gem
  f="$HOME/.travis/travis.sh"
  [ -f "$f" ] && . "$f"

  # Torch
  f=/mnt/hd/git/torch/install/bin/torch-activate
  [ -f "$f" ] && . "$f"

## Untracked local dotfiles. Mus come last.
if [ -r "$HOME/.bashrc_local" ]; then
  . "$HOME/.bashrc_local"
fi
