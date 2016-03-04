# https://github.com/hut/ranger/blob/master/ranger/config/commands.py

import os.path

from ranger.api.commands import *

class guake(Command):
    def execute(self):
        #self.fm.thisfile
        self.fm.notify(self.fm.thisdir)
        current_dir = str(self.fm.thisdir)
        self.fm.run(['guake', '-n', current_dir])
        self.fm.run(['guake', '-r', os.path.split(current_dir)[1]])
        self.fm.run(['guake', '--show'])
