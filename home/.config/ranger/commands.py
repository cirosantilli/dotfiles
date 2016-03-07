# https://github.com/hut/ranger/blob/master/ranger/config/commands.py

import os.path

from ranger.api.commands import *

class guake(Command):
    """:guake

    Open a new Guake tab on the current directory, and focus on it.
    """
    def execute(self):
        self.fm.notify('guake')
        current_dir = str(self.fm.thisdir)
        self.fm.run(['guake', '-n', current_dir])
        self.fm.run(['guake', '-r', os.path.split(current_dir)[1]])
        self.fm.run(['guake', '--show'])

class file(Command):
    """:file <filename>

    Run the POSIX `file` command on the given file, print the result to the prompt line.
    """
    def execute(self):
        if not self.arg(1):
            path = str(self.fm.thisfile)
        else:
            path= self.arg(1)
        # TODO. It does return a process. See Runner(). How to get stdout?
        process = self.fm.run(['file', path])
        stdout, stderr = process.communicate()
        self.fm.notify(stdout)

class cdg(Command):
    """:cdg

    cd to the root of the current git repository.
    """
    def execute(self):
        process = self.fm.run(['git', 'rev-parse', '--show-toplevel'])
        # TODO get stdout here.
        # stdout =
        self.fm.cd(stdout)

class vim_edit(Command):
    """:vim_edit <filename>

    Edit <filename> in Vim.
    """
    def execute(self):
        if not self.arg(1):
            path = 'README.md'
        else:
            path = self.arg(1)
        self.fm.run(['gvim', '--remote-tab-silent', path])
        self.fm.run(['wmctrl', '-a', '- gvim'])
