# https://github.com/hut/ranger/blob/master/ranger/config/commands.py

import os.path
import subprocess

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
        self.fm.notify(subprocess.check_output(['file', path]))

class cd_git(Command):
    """:cd_git

    cd to the root of the current git repository.
    """
    def execute(self):
        cmd = ['git', 'rev-parse', '--show-toplevel']
        process = subprocess.Popen(
            cmd,
            shell  = False,
            stdin  = subprocess.PIPE,
            stdout = subprocess.PIPE,
            stderr = subprocess.PIPE,
            universal_newlines = True
        )
        stdout, stderr = process.communicate()
        exit_status = process.wait()
        if exit_status == 0:
            self.fm.cd(stdout[:-1])
        else:
            self.fm.notify('  '.join(cmd) + ' failed', bad=True)
