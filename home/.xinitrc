#!/usr/bin/env bash

date > .xinitrc.test.tmp

#xmodmap ~/.Xmodmap

#xbacklight -set 60
setxkbmap -option caps:escape
