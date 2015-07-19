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

# Aliases and commands

    define bm
        break main
    end

    define bs
        break _start
    end

    define dpaf
        display/16i $pc
    end

    alias di = disassemble
