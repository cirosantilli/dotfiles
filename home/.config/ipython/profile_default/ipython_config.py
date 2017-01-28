# Not sourced at startup, but allows you to do meta-ish things with ipython.
c = get_config()
c.TerminalInteractiveShell.confirm_exit = False
# http://stackoverflow.com/questions/31363407/tab-completion-in-ipython-for-list-elements
c.IPCompleter.greedy = True
