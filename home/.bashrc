## alias

## functions

  # Misc aliases and functions.

  alias a='cat'
  alias ack='ack-grep --smart-case'
  b() ( cirosantilli-beep "$@" )
  alias bashx='x | bash'
  bsu() ( bsub -P "$1" -R "select[rhe6 && mem>4000] rusage[mem=4000] order[cpu]" -Ip -XF -W 720:00 -app FG xterm -e screen; )
  cdg() { cd "$(git rev-parse --show-toplevel)/${1:-}"; }
  alias cdG='cd "$MY_GIT_DIR"'
  # Start bash in a clean test environment.
  alias clean='env -i bash --norc'
  alias chmx='chmod +x'
  # Allow all users to access under a given directory.
  chmR() (
    d="${1:-.}"
    sudo find "$d" -type d | sudo xargs chmod +755
    find "$d" -type f | sudo xargs chmod +644
    find . -type f -perm /u=x,g=x,o=x | sudo xargs chmod +111
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
  alias dconfl='dconf load / <~/.config/dconf/user.conf'
  alias dconfw='dconf watch /'
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
  alias dfhs='df -h | sort -hrk2'
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
  eclipse() ( noh "$HOME/bin/eclipse/eclipse" )
  alias eip='curl ipecho.net/plain'
  alias enmp='ecryptfs-mount-private'
  alias enup='ecryptfs-umount-private'
  alias envg='env | grep -E'
  f() { find "${2-.}" -iname "*$1*"; }
  f2() { find . -maxdepth 2 -iname "*$1*"; }
  f3() { find . -maxdepth 3 -iname "*$1*"; }
  filw() { file "$(which "$1")"; }
  alias gaz='GAZEBO_PLUGIN_PATH="${GAZEBO_PLUGIN_PATH}:build" gazebo'
  alias gnup='gnuplot -p'
  alias fgb='fg;b'
  alias fmmmr='find-music-make-m3u .'
  alias golly='env UBUNTU_MENUPROXY=0 golly'
  h() ( "$1" --help | less; )
  hex() ( printf "%x\n" "$@" )
  j() ( jobs "$@"; )
  L() ( locate -r "$1"; )
  lob() ( locate -br "$1"; )
  alias lns='ln -s'
  # Remove a symlink, and move the file linked to to the symlink location.
  # Usage: cmd symlink-location
  lns-undo() {
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
  # od hex address + values, good for grepping.
  odd() (
    od -An -t x1 "$1" | tr -d "\n"
  )
  # od hex address + values
  alias ods='od -Ax -tx1'
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
  rlw() { readlink -f "$(which "$1")"; }
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
  alias S='unalias -a && . ~/.bashrc'
  s() ( less "$@"; )
  les() ( s -S "$@"; )
  lesr() ( s -SR "$@"; )
  alias se='sed -r'
  # Screen TTY.
  alias sha2='sha256sum'
  alias sql='sqlite3'
  alias stra='sudo strace -f -s999 -v'
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
  alias tm='tmux'
  # https://superuser.com/questions/878890/attach-a-tmux-session-to-a-remote-machine/912400#912400
  alias tma='tmux attach-session'
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
  # http://stackoverflow.com/questions/1969958/how-to-change-tor-exit-node-programmatically/
  alias tornewip='sudo killall -HUP tor'
  torbrowser() ( cd ~/bin/tor-browser_en-US && ./start-tor-browser.desktop; )
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
  z() { zip -r "${1%/}.zip" "$1"; }

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

  ## Provision machines

    alias provision-min-ssh='wget -O- https://raw.githubusercontent.com/cirosantilli/linux/master/ubuntu/install-min-ssh.sh | bash'
    alias provision-min='wget -O- https://raw.githubusercontent.com/cirosantilli/linux/master/ubuntu/install-ssh.sh | bash'

## android

  alias adbc='adb connect'
  alias adbd='adb devices -l'
  alias adbD='adb disconnect'
  alias adbi='adb install'
  alias adbks='sudo "$(which adb)" kill-server && sudo "$(which adb)" start-server'
  alias adbl="adb logcat"
  alias adble="adb logcat -v time '*:E'"
  alias adbls="adb logcat -v time -s"
  alias adblsc="adb logcat -v time -s com.cirosantilli"
  alias adbs='adb shell'
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
  alias grad='./gradlew assembleDebug'
  alias gradi='./gradlew assembleDebug'
  alias gradi='./gradlew assembleDebug && ./gradlew installDebug'
  alias gracdi='./gradlew clean && ./gradlew assembleDebug && ./gradlew installDebug'

## aptitude

  alias acse='apt-cache search'
  alias acde='apt-cache depends'
  alias acsh='apt-cache show'
  alias acshs='apt-cache showsrc'
  alias afls='apt-file list'
  alias afse='apt-file search'
  # Binary
  afseb() { apt-file search "$(which "$1")"; }
  alias sabd='apt-get build-dep'
  alias agso='apt-get source'
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

## Bash options

  # Bash set or shopt options.

  set -o vi

  # Check the window size after each command and,
  # if necessary, update the values of LINES and COLUMNS.

  shopt -s checkwinsize

## Binutils

  alias obd='objdump -Cdr'
  alias obD='objdump -CDr'
  alias obimg='objdump -D -b binary -mi386 -Maddr16,data16'
  alias obS='objdump -CSr'
  alias rea='readelf -aW'
  alias red='readelf -dW'
  alias reh='readelf -h'
  alias reS='readelf -SW'
  alias res='readelf -sW'

## buildroot

  brm() {
    unset LD_LIBRARY_PATH
    time make BR2_JLEVEL="$(npro)"
    b
  }
  brq() {
    img="${1:-output}"
    qemu-system-x86_64 \
      -M pc \
      -append root=/dev/vda \
      -drive file="${img}/images/rootfs.ext2,if=virtio,format=raw" \
      -enable-kvm \
      -kernel "${img}/images/bzImage" \
      -m 512 \
      -net nic,model=virtio \
      -net user,hostfwd=tcp::2222-:22
  }
  brqa() (
    qemu-system-arm \
      -M versatilepb \
      -append "root=/dev/sda console=ttyAMA0,115200" \
      -drive file=output/images/rootfs.ext2,if=scsi,format=raw \
      -dtb output/images/versatile-pb.dtb \
      -kernel output/images/zImage \
      -net nic,model=rtl8139 \
      -net user \
      -serial stdio
  )

## Browsers

  ## Firefox

      # Unsafe settings, for quick testing. Don't access any important page with it.
      fir-test() ( noh firefox -no-remote "$@" -P 'test'; )

  ## Chromium

  chr() ( noh chromium-browser "$@"; )
  chrt() ( chr --temp-profile "$@"; )
  # Unsafe settings, for quick testing. Don't access any important page with it.
  chr-test() ( chr --allow-file-access-from-files; )

## CodeCollab

  ccah() ( ccollab addchangelist "$1" HEAD; )
  # Update change to reflect last commit.
  # Get ID from commit Message line of form "CC: 1234".
  ccamh() ( ccollab addchangelist "$(git log -n1 --pretty=format:'%B' | grep -E '^CC: ' | cut -d' ' -f2)" HEAD; )
  # Create new.
  ccanh() ( ccollab addchangelist new HEAD; )
  ccasn() ( ccollab addsvndiffs new; )

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

## ctags

    # ctags default command:
    # - R: Recursive
    # - --extra=f: also generate tags for filenames, that point to the first line:
    # Consider:
    alias ctagsr='ctags -R --extra=f'
    alias cscopr='cscope -Rb'
    alias ctasc='cdg && ctagsr && cscopr && cd -'

## dirs

  ## bookmarks

    # These will open krusader where I want.

    # Better with "single instance mode on", or new windows will be opened.

    alias krpr='krusader "$PROGRAM_DIR"'
      alias kras='krusader "$ASSEMBLER_DIR"'
      alias krba='krusader "$BASH_DIR"'
      alias krcp='krusader "$CPP_DIR"'
      alias krli='krusader "$LINUX_DIR"'
      alias krpy='krusader "$PYTHON_DIR"'
      alias krpydp='krusader "$PYTHON_DIST_PKG_DIR"'
      alias krror='krusader "$RAILS_DIR'
    alias krtst='krusader "$TEST_DIR"'
    alias krmsc='krusader "$MUSIC_DIR"'
      alias krctm='krusader "$CHINESE_MUSIC_DIR"'
      alias kritm='krusader "$INDIAN_MUSIC_DIR"'
    alias krgm='krusader "$GAME_DIR"'
    alias krusd='krusader "/usr/share/doc/"'

  ## ls

    l() ( ls "$@"; )
    ls() ( command ls -A -1 --color=auto --group-directories-first "$@"; )
    lswc() ( ls -1 "${1:-.}" | wc -l; )
    lsg() ( ls "${2:-.}" | g "$1"; )
    lsgi() ( ls "${2:-.}" | gi "$1"; )
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
        dst="${TMP_DIR}/down/$(basename "$(lfg "$DOWNLOAD_DIR")")-$(timestamp)"
        mkdir -p "$dst"
        cd "$dst"
        lfmd
      }

## Docker

  alias sdo='sudo docker'
  alias sdob='sudo docker build'
  sdobt() { sudo docker build -t "$1" .; }
  alias sdoh='sudo docker help'
  alias sdoi='sudo docker images'
  alias sdop='sudo docker ps'
  alias sdor='sudo docker run'
  sdorit() { sudo docker run -it "$1" /bin/bash; }
  sdorp() { sudo docker run -d -p 127.0.0.1:8000:80 "$1"; }
  sdornp() { sudo docker run -d --name "$1" -p 127.0.0.1:8000:80 "$2"; }
  alias sdorma='sudo docker rm $(sudo docker ps -aq --no-trunc)'
  alias sdos='sudo docker stop'

## du

  alias duh='du -h'
  dush() (
    cd "${1:-.}"
    du -sh .[^.]* * 2>/dev/null | sort -h
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

  # Decompress anything. https://xkcd.com/1168/

    # stdout
    # unzip -p >f
    extract () {
      case $1 in
        *.7z)        7z x "$1";;
        *.Z)         uncompress "$1";;
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

## ffmpeg

  # fftrim in.ogv out.ogv 00:10 01:20
  fftrim() ( ffmpeg -i "$1" -ss "$3" -to "$4" -c copy "$2"; )
  # ffcat in1.ogv in2.ogv out.ogv
  ffcat() ( ffmpeg -i concat:"$1|$2" -c copy "$3"; )

## gcc

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
    v="$1"
    sudo update-alternatives --remove-all gcc
    sudo update-alternatives --remove-all g++
    sudo update-alternatives --install /usr/bin/gcc gcc "/usr/bin/gcc-$v" 10
    sudo update-alternatives --install /usr/bin/g++ g++ "/usr/bin/g++-$v" 10
  )

## gdb

  alias gdbS='gdb -ex "break _start" -ex "run" -q --args'
  gdbs() ( gdb -ex 'start' -q --args "$@" )
  gdbr() ( gdb -ex 'run' -q --args "$@" )
  gdbrb() ( gdb -ex 'run' -ex 'shell cirosantilli-beep' -q --args "$@" )
  alias gdbr='gdb -ex "run" -q --args'
  alias gdbx='gdb --batch -x'
  # Run program, show failure backtrace.
  gdbcbt() (
    ulimc
    rm -f core
    "$@"
    gdb --batch -ex 'bt' "$1" 'core'
  )

## GNU changelogs from Git

    # Helper.
    gnu-changelog() {
      {
        printf "$(date '+%Y-%m-%d')  Ciro Santilli  <ciro.santilli@gmail.com>\n\n"
        git diff --name-only $1 HEAD | sed 's/^/\t* /; s/$/ (): ./'
      } | tee /dev/tty | xclip -selection clipboard
    }

    # After Commit, Compare HEAD and HEAD~.
    gnuc() {
      gnu-changelog HEAD~
    }

    # Before commit. Diff. Compare working tree and HEAD.
    gnud() {
      gnu-changelog
    }

## Git

  export GIT_EDITOR="vim"

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
  alias gbl='git blame'
  alias gbr='git branch'
  # Sort Comitter. Latest changed branch first. http://stackoverflow.com/a/5188364/895245
  gbrsc() ( git for-each-ref --sort=committerdate --format="%(committerdate:iso) %(refname) %(committeremail)" )
	# Me.
  gbrscm() ( gbrsc | grep "$(git config user.email)" )
  gbrg () { git branch | grep "$1"; }
  gbrag () { git branch -a | grep "$1"; }
  gbrdd() { git branch -d "$1"; git push --delete origin "$1"; }
  alias gbra='git branch -a'
  # BRanch Graph
  alias gbrm='git branch -m'
  gbruo() { git branch -u "origin/$1"; }
  alias gbrv='git branch -vv'
  alias gcl='git clone --recursive'
  gclc() { gcl "$1" && cd "$(basename "${1%.git}")"; }
  alias gclx='gclc "$(x)"'
  alias gclb='git clone --bare'
  alias gcf='git cat-file'
  alias gcfp='git cat-file -p'
  alias gcft='git cat-file -t'
  alias gcm='git commit'
  alias gcmm='git commit -m'
  alias gcmbak='git commit -m bak'
  alias gcmtmp='git commit -m tmp'
  alias gcma='git commit --amend'
  alias gcman='git commit --amend --no-edit'
  alias gcmanpsf='git commit --amend --no-edit && git push -f'
  alias gce='git clean'
  # Clean files that are not gitignored. Keeps your built object files, to save a lengthy rebuild.
  gcedf() ( git clean -df "${1:-:/}"; )
  # Clean any file not tracked, including gitignored. Restores repo to pristine state.
  gcexdf() { git clean -xdf "${1:-:/}"; }
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
  alias gcp='git cherry-pick'
  alias gd='git diff'
  alias gdf='git diff'
  alias gdfth='git diff trunk...HEAD'
  alias gdfmh='git diff master...HEAD'
  alias gdfc='git diff --cached'
  alias gdfh='git diff HEAD'
  alias gdfhh='git diff HEAD~ HEAD'
  alias gdfhhs='git diff --stat HEAD~ HEAD'
  alias gdfst='git diff --stat'
  alias gfe='git fetch'
  gferh() { git fetch "$@" && git reset --hard FETCH_HEAD; }
  alias gfeomm='git fetch origin master:master'
  alias gfeumm='git fetch up master:master'
  gfeommcob() { git fetch origin master:master && git checkout -b "$1" master; }
  alias gfp='git format-patch'
  alias gfpx='git format-patch --stdout HEAD~ | xclip -selection clipboard'
  alias gdfx='git diff | y'
  gdf12() { git diff ":1:./$1" ":2:./$1"; }
  gdf13() { git diff ":1:./$1" ":3:./$1"; }
  gdf123() {
    git --no-pager diff ":1:./$1" ":2:./$1";
    python -c 'print "\n" + (80 * "=") + "\n"';
    git --no-pager diff ":1:./$1" ":3:./$1";
  }
  alias gg='git grep --color'
  alias ggi='git grep --color -i'
  alias gka='gitk --all'
  alias gin='git init'
  # Init Add Commit
  alias ginac='git init && git add . && git commit -m "init"'
  # Restore deleted file to its latest version.
  # http://stackoverflow.com/questions/953481/restore-a-deleted-file-in-a-git-repo
  git-restore-file() { git checkout $(git rev-list -n 1 HEAD -- "$1")^ -- "$1"; }
  alias gls='git ls-files'
  alias glso='git ls-files --other'
  alias glsg='git ls-files | g'
  alias glsgi='git ls-files | gi'
  alias glsr='git ls-remote'
  alias glo='git log --decorate --pretty=fuller'
  alias glog='git log --abbrev-commit --decorate --graph --pretty=oneline'
  alias gloga='git log --abbrev-commit --decorate --graph --pretty=oneline --all'
  alias glogas='git log --abbrev-commit --decorate --graph --pretty=oneline --all --simplify-by-decoration'
  alias glogs='git log --abbrev-commit --decorate --graph --pretty=oneline --simplify-by-decoration'
  # My comimits.
  alias glom='git log --author="$(git config user.name)"'
  alias glop='glo -p'
  alias glos='glo --stat'
  #alias glopf='git log --pretty=oneline --decorate'
  alias glopf='git log --all --pretty=format:"%C(yellow)%h|%Cred%ad|%Cblue%an|%Cgreen%d %Creset%s" --date=iso | column -ts"|" | less -r'
  # Find where that feature entered the code base.
  gloS() ( git log -p --reverse -S "$1"; )
  # Get last SHA commit into clipboard.
  glox() (
    git log -1 --format="%H" $1 | tee >(cat 1>&2) | y
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
  alias gmb='git merge-base'
  alias gme='git merge'
  alias gmea='git merge --abort'
  alias gmem='git merge master'
  alias gmt='git mergetool'
  alias gmv='git mv'
  alias gnr='git name-rev HEAD'
  alias gppp='git push prod prod'
  alias gps='git push'
  alias gpsf='git push -f'
  # Wobble
  alias gpsfw='git push -f origin HEAD~:master && git push -f'
  alias gpsr='git push --recurse-submodules='
  alias gpsum='git push -u mine'
  alias gpsu='git push -u'
  alias gpsuom='git push -u origin master'
  alias gpl='git pull && gsuu'
  alias gplr='git pull --rebase'
  alias gplum='git pull up master'
  alias gplrum='git pull --rebase up master'
  alias gplo='git pull origin'
  alias gplom='git pull origin master'
  alias grb='git rebase'
  alias grba='git rebase --abort'
  alias grbc='git rebase --continue'
  alias grbi='git rebase -i'
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
  alias grl='git reflog'
  alias grm='git rm'
  alias grt='git remote'
  alias grta='git remote add'
  alias grtao='git remote add origin'
  alias grtau='git remote add up'
  alias grtv='git remote -v'
  alias grtr='git remote rename'
  alias grtro='git remote rename origin'
  grtrou() { git remote rename origin up && git remote add origin "$1" && git branch --set-upstream 'origin';}
  alias grts='git remote set-url'
  alias grtso='git remote set-url origin'
  alias gsa='git stash'
  alias gsaa='git stash apply'
  alias gsh='git show'
  gshm() { git show "master:./$1"; }
  gshmo() { git show "master:./$1" > "old_$1"; }
  alias gst='git status'
  alias gsu='git submodule'
  alias gsua='git submodule add'
  alias gsuf='git submodule foreach'
  alias gsufp='git submodule foreach git pull'
  alias gsuu='git submodule update --init --recursive'
  alias gta='git tag'
  alias gtac='git tag --contains'
  # Git TAg Date
  alias gtad='git for-each-ref --sort=taggerdate --format "%(refname) %(taggerdate)" refs/tags'
  alias gtag='gta | g'
  alias gtas='git tag | sort -V'
  alias gtr='git ls-tree HEAD'

  alias vgig='vim .gitignore'
  alias lngp='latex-new-github-project.sh cirosantilli'

  # GitHub

    alias ghb='git browse-remote'
    alias ghpb='git push && git browse-remote'
    ghmail() { curl "https://api.github.com/users/$1/events/public" | grep email; }
    alias gpsbr='gps && git browse-remote'
    alias gcmanpsfbr='gcmanpsf && git browse-remote'
    # Pull Request.
    ghpr() { git fetch up refs/pull/$1/head; git checkout -b new-branch FETCH_HEAD; }

  ## Hub

    alias huco='hub checkout'

  ## Gerrit

    alias gpsd='git push origin HEAD:refs/drafts/master'
    alias gpsdt='git push origin HEAD:refs/drafts/trunk'

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

## grep

  g() ( grep -E --color=auto "$@"; )
  gi() ( g -i "$@"; )
  gr() ( g -R "$@"; )
  gri() ( gi -R "$@"; )
  gv() ( g -v "$@"; )

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

## hg

  alias hgg='hg grep'
  alias hggi='hg grep -i'

## homeshick

  #git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
  f="$HOME/.homesick/repos/homeshick/homeshick.sh"
  if [ -e "$f" ]; then
    . "$f"
  fi

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
  alias mkj='make -j"$(npro)"'
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
  alias tmkjb='time make -j"$(npro)"; b'
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

  # cmake

    cmk() {
      mdc 'build'
      cmake "$@" ..
      cmake --build . -- -j"$(npro)" VERBOSE=1
    }
    cmkb() { time cmk; b; }
    cmkd() { cmk -DCMAKE_BUILD_TYPE=Debug; }
    cmks() { cmk -DBUILD_SHARED_LIBS=ON; }
    # Test.
    cmkt() { cmk && ctest -V .; }

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
  # - will transform symlinks into files
  # - will add trailing newlines to files that end without them
  #
  mrr() {
    if [ $# -gt 1 ]; then
      if [ "$2" = 'D' ]; then
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
  grepb() { perl -ne "print if m/$1(?!.*\/.)/i" | grep --color -Ei "$1|\$"; }

  # Find files recursively filtering by regex.
  #
  # Basename only, prune hidden.
  fin() { find . -path '*/.*' -prune -o ! -name '.' -print | sed "s|^\./||" | grepb "$1"; }
  # Also Hidden.
  finh() { find . ! -path . | sed "s|^\./||" | grepb "$1"; }
  # full Path.
  finp() { find . ! -path . | sed "s|^\./||" | perl -ne "print if m/$1/"; }

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

  alias mctm="nohup vlc \"$CHINESE_MUSIC_DIR\" >/dev/null &"
  alias mitm="nohup vlc \"$INDIAN_MUSIC_DIR\" >/dev/null &"
  alias mjfr="nohup vlc \"$JAZZ_MUSIC_DIR\" >/dev/null &"
  alias mroc="nohup vlc \"$MUSIC_DIR/rock\" >/dev/null &"

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

  alias npmi='npm install'
  alias npmis='npm install --save'
  alias npmisd='npm install --save-dev'

## power management

  alias pmhi='sudo ps-hibernate'
  alias pmsh='sudo shutdown'
  alias pmsu='sudo ps-suspend'
  alias pmre='sudo reboot'

## python

  export PYTHONSTARTUP="$HOME/.pythonrc.py"

  alias py='python'
  alias pyv='python --version'
  alias py3='python3'
  alias pyi='ipython'
  alias pyti='touch __init__.py'
  alias pyserve='python -m SimpleHTTPServer'
  alias pyjson='python -m json.tool'
  alias pydoc='python -m doctest'
  # http://stackoverflow.com/questions/24906126/how-to-unpack-pkl-file
  pyp() (
    python -c 'import pickle,sys;d=pickle.load(open(sys.argv[1],"rb"));print(d)' "$1"
  )

  ## pip

    # http://stackoverflow.com/questions/402359/how-do-you-uninstall-a-python-package-that-was-installed-using-distutils/43650802#43650802
    python-setup-uninstall() (
      sudo rm -f files.txt
      sudo python setup.py install --record files.txt && \
      xargs rm -rf < files.txt
      sudo rm -f files.txt
    )
    alias spii='sudo pip install'
    alias spiu='sudo pip uninstall'
    alias pise='pip search'
    alias pifr='pip freeze'
    alias pift='pip freeze >requirements.txt'
    alias piin='pip install'
    alias piir='pip install -r requirements.txt'
    alias pii='pip pillow.txt'

  ## virtualenv

    alias vira='. .venv/bin/activate'
    alias vird='deactivate'
    alias vire='echo $VIRTUAL_ENV'
    alias virp='virtualenv -p python3.5 .venv && . .venv/bin/activate && pip install -r requirements.txt'

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

  alias qemu='qemu-system-x86_64'
  alias qemu32='qemu-system-i386'
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

  # Ignore the huge arch and drivers.
  # http://stackoverflow.com/questions/10423143/how-to-exclude-certain-directories-files-from-git-grep-search
  lkg() { git grep -i "$1" -- './*' ':!arch/**' ':!drivers/**';  }
  # Ignore drivers.
  lkga() { git grep -i "$1" -- './*' ':!drivers/**'; }
  # TODO ignore all archs except x86.
  #export KBUILD_OUTPUT='../build'

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

## Development boards

	sshr() ( ssh-root "${1}" 'root' )
  scrs() ( sudo screen "/dev/ttyS${1:-0}" "${2:-115200}"; )
  scrsr() ( sudo "$(which screen-tty-root)" "$@"; )
  scrusb() ( sudo screen "/dev/ttyUSB${1:-0}" "${2:-115200}"; )

  losl() ( sudo losetup -l )
  los() (
    img="$1"
    dev="$(sudo losetup --show -f -P "$img")"
    echo "$dev"
    for part in "$dev"?*; do
      dst="/mnt/$(basename "$part")"
      echo "$dst"
      sudo mkdir -p "$dst"
      sudo mount "$part" "$dst"
    done
  )
  losd() (
    dev="/dev/loop$1"
    for part in "$dev"?*; do
      dst="/mnt/$(basename "$part")"
      sudo umount "$dst"
    done
    sudo losetup -d "$dev"
  )

## raspberry pi

  # Exit with: Ctrl + A then backslash '\'.
  piip() ( cat /var/lib/misc/dnsmasq.leases | cut -d ' ' -f 3; )
  pissh() (
    ip="$(piip)"
    #ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$ip"
    user="${1:-pi}"
  )
  piss() ( sshpass -p raspberry ssh "pi@${1}"; )
  pivin() (
    vinagre "$(piip)"
  )
  PATH="$PATH:$HOME/git/raspberrypi-tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin"

## screencast

  # SILENCE YOUR MESSAGING APPS NOW!!!
  rec() (
    sleep 2
    #spd-say rec
    recordmydesktop --stop-shortcut "Control+Mod1+z"
    b
  )
  screencast() {
    export PS1="$(printf "\033[1;31m%$(tput cols)s\033[0m" | tr ' ' '-')"'\n'
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

## Ubuntu

  ubcon() ( cat "/boot/config-$(uname -r)" )

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
  # osx vim
  if [ -x '/Applications/MacVim.app/Contents/MacOS/Vim' ]; then
    PATH="/Applications/MacVim.app/Contents/MacOS/:${PATH}"
  fi

## x clipboard

  alias x='xsel -b'
  y() ( xsel -bi )
  alias ya='xsel -ba'
  alias exx='expand | y'
  # Use xclip instead of xsel while I have this bug:
  # http://askubuntu.com/questions/652254/xsel-output-contains-trash-at-the-end-if-a-long-input-is-piped-into-it-to-set-th
  alias xex='x | expand | y'
  # Add 4 spaces to every line and save to clipboard.
  # For markdown, so also expand.
  alias x4='sed -e "s/^/    /" | sed -e "s/[[:space:]]*$//" | expand | tee /dev/tty | y'
  # Last Command to clipboard.
  alias xlc='fc -ln -1 | sed "s/\t //" | y'
  alias xsh='x | bash -xv'
  xssh() ( y < "$HOME/.ssh/id_rsa${1}.pub"; )
  alias xb='x | bash'
  alias xl='x | less'
  # Join lines on clipboard, no separator.
  xpx() ( x | paste -sd '' - | x; )

  # Clipboard path operations.

    # Absolute path.
    xab() ( printf "$(pwd)/$1" | y; )
    xmv() ( mv "$(x)" "${1:-.}"; )
    xcp() ( cp -r "$(x)" "${1:-.}"; )
    xpw() ( pwd | y; )

## xdg

  alias o='xdg-open'
  alias mime='xdg-mime query filetype'
  alias vmime='~/.local/share/applications/mimeapps.list'

## SFL

  sflx() { echo 'ciro.santilli@savoirfairelinux.com' | y; }

  # Git. Must be run on each Git repo we will push for.
  sflg() {
    git config --local user.email 'ciro.santilli@savoirfairelinux.com'

    # git push creates patches.
    git config --local remote.origin.push HEAD:refs/for/master

    # Automatically add the dreaded Change-Id.
    gitdir=$(git rev-parse --git-dir); scp -p -P 29420 cirosantilli@gerrit-ring.savoirfairelinux.com:hooks/commit-msg ${gitdir}/hooks/

    # `git push draft` creates drafts.
    # TODO: git remote add draft X
    git config --local push.draft.url HEAD:refs/drafts/master
    # `git fetch` fetchs *all* patches locally.
    git config --local --add 'remote.origin.fetch +refs/changes/*:refs/remotes/origin/changes/*'
    # TODO: git remote add origin X

    # Push to sandbox branch.
    #gpss() { git push origin "HEAD:sandbox/$USER/$(git rev-parse --abbrev-ref HEAD)"; }
  }

  RING_DIR="$HOME/git/ring"
  alias ring-rr='"$RING_DIR/ubuntu-15.10-run.sh"'
  alias ring-psgr='ps aux | grep ring'

## Settings

  # OSX
  export CLICOLOR=1

  ## PS1
  export PS1="\
\[\033[01;31m\]\w\n\
\[\033[01;34m\]\$(timestamp)\
\[\033[01;32m\]@\
\[\033[01;34m\]\u\
\[\033[01;32m\]@\
\[\033[01;34m\]\h\
\[\033[00m\]\$ "

  # Free up Cq and Cs, and stop Cs from freezing terminal.
  # http://unix.stackexchange.com/questions/12107/how-to-unfreeze-after-accidentally-pressing-ctrl-s-in-a-terminal
  # http://unix.stackexchange.com/questions/137842/what-is-the-point-of-ctrl-s
  stty -ixon


## Source lines and path modifications

  # Should come at the end.

  # Enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f '/etc/bash_completion' ] && ! shopt -oq 'posix'; then
      . '/etc/bash_completion'
  fi

  ## Google

    if [ -d "$HOME/google-cloud-sdk" ]; then
      # The next line updates PATH for the Google Cloud SDK.
      . "$HOME/google-cloud-sdk/path.bash.inc"
      # The next line enables bash completion for gcloud.
      . "$HOME/google-cloud-sdk/completion.bash.inc"
    fi

    ### Google Cloud gsutil

    if [ -d "$HOME/google-cloud-sdk" ]; then
      # The next line updates PATH for the Google Cloud SDK.
      . "$HOME/google-cloud-sdk/path.bash.inc"
      # The next line enables shell command completion for gcloud.
      . "$HOME/google-cloud-sdk/completion.bash.inc"
    fi

  ## Heroku Toolbelt
  export PATH="/usr/local/heroku/bin:$PATH"

  ## node

    ## NVM
    if [ -r "$HOME/.nvm/nvm.sh" ]; then
      . "$HOME/.nvm/nvm.sh" &>'/dev/null'
      nvm use '6.10.1' &>'/dev/null'
    fi

    # Use local executables at correct version.
    export PATH="./node_modules/.bin:$PATH"

  ## RVM
  if [ -r "$HOME/.rvm/scripts/rvm" ]; then
    # Load RVM into a shell session *as a function*
    . "$HOME/.rvm/scripts/rvm"
    PATH="$PATH:$HOME/.rvm/bin"
  fi

  # Go version manager.
  [ -s "$HOME/.gvm/scripts/gvm" ] && . "$HOME/.gvm/scripts/gvm"

  # https://github.com/cirosantilli/runlinux
  PATH="$PATH:$PROGRAM_DIR/runlinux"

# Added by travis gem.
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

# AMD SDK.
export AMDAPPSDKROOT="$HOME/AMDAPPSDK-3.0"
#export OPENCL_VENDOR_PATH="$HOME/AMDAPPSDK-3.0/etc/OpenCL/vendors/"

# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Not tracked in dotfiles repo. PUT THIS LAST.
if [ -r "$HOME/.bashrc_local" ]; then
  . "$HOME/.bashrc_local"
fi
