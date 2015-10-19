set pagination off

# Make prompt line red and bold.
set prompt \033[1;31m(gdb) \033[m

# Don't confirm to quit.
# http://stackoverflow.com/questions/4355978/get-rid-of-quit-anyway-question-just-kill-the-process-and-quit
define hook-quit
    set confirm off
end

# http://stackoverflow.com/questions/3176800/how-can-i-make-gdb-save-the-command-history
set history save
set history filename ~/.gdb_history

## Aliases and commands

define 16
    set architecture i8086
end

define 32
    set architecture i386
end

define bm
    break main
end

define bs
    break _start
end

define dp16
    display/16i $pc
end

define xi
    x/32i $pc - 16
end

alias di = disassemble

# http://stackoverflow.com/questions/8235436/how-can-i-monitor-whats-being-put-into-the-standard-out-buffer-and-break-when-a
define stdout
    catch syscall write
    commands
        printf "rsi = %s\n", $rsi
        backtrace
    end
    # TODO automatically deduce arg0.
    # Stop if it contains arg1.
    condition $arg0 $rdi == 1 && strstr((char *)$rsi, "$arg1") != 0
end

source ~/.gdbinit.py
