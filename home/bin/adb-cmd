#!/usr/bin/env expect
# https://stackoverflow.com/questions/9383309/how-to-run-an-adb-shell-command-and-remain-in-the-shell/48565814#48565814
# https://stackoverflow.com/questions/27368962/entering-adb-shell-within-a-specific-directory-on-the-connected-device-using-onl/47021383#47021383
spawn adb shell
expect "#"
send [ concat [ join $argv " " ] ]
send "\r"
interact
