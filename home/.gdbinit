## Settings.

    # http://stackoverflow.com/questions/8528979/how-to-determine-if-an-object-is-an-instance-of-certain-derived-c-class-from-a
    set print object on

    # http://stackoverflow.com/questions/3176800/how-can-i-make-gdb-save-the-command-history
    set history save
    set history filename ~/.gdb_history

    set listsize 40

    set pagination off

    # http://stackoverflow.com/questions/10937289/how-can-i-disable-new-thread-thread-exited-messages-in-gdb
    set print thread-events off

    # Make prompt line red and bold.
    set prompt \033[1;31m(gdb) \033[m

    # Don't confirm to quit.
    # http://stackoverflow.com/questions/4355978/get-rid-of-quit-anyway-question-just-kill-the-process-and-quit
    define hook-quit
        set confirm off
    end

    # Happens after "continue", "next", "step" and company.
    define hook-stop
        shell clear
        list
        printf "\n"
        backtrace
    end

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

    # TODO.
    # http://stackoverflow.com/questions/5336403/is-there-any-way-to-set-a-breakpoint-in-gdb-that-is-conditional-on-the-call-stac
    # http://stackoverflow.com/questions/41397560/how-to-pass-cli-arguments-to-a-commands-inside-a-define-in-gdb
    #define break-stack
    #    break $arg0
    #    commands
    #        tbreak $arg1
    #        continue
    #    end
    #end
    #document break-stack
    #Break on child only if it was called from parent.
    #break-stack PARENT CHILD
    #end

    # Disassemble a few instructions around the current one.
    # Not trivial to put current instruction exactly in the middle
    # because of variable instruction sizes.
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
