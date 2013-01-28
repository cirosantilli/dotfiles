used to backup/publish certain files from home dir

target programs:

- duplicity : cant select individual files

- vim : would add (master) to every command line under my home!

if you backup both this folder and your home folder,
you will likely get too copies on the backup

usage:

then ``./home-sym-here`` to hardlink files under ``file-list`` newline separated list to ``./files``

then ``./here-sym-home`` to hardlink files under ``./files`` back to home
