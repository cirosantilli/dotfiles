import re
from subprocess import call

class ContinueI(gdb.Command):
    """
Continue until instruction with given opcode.

Usage: ci OPCODE

Examples:

    ci callq
    ci mov

See also: http://stackoverflow.com/questions/14031930/break-on-instruction-with-specific-opcode-in-gdb
"""
    def __init__(self):
        super().__init__(
            'ci',
            gdb.COMMAND_BREAKPOINTS,
            gdb.COMPLETE_NONE,
            False
        )
    def invoke(self, opcode, from_tty):
        if opcode == '':
            gdb.write('Argument missing.\n')
        else:
            thread = gdb.inferiors()[0].threads()[0]
            while thread.is_valid():
                message = gdb.execute('si', to_string=True)
                frame = gdb.selected_frame()
                arch = frame.architecture()
                pc = gdb.selected_frame().pc()
                asm = arch.disassemble(pc)[0]['asm']
                if asm.startswith(opcode + ' '):
                    gdb.write(message)
                    gdb.write(asm + '\n')
                    break
ContinueI()


class NextInstructionAddress(gdb.Command):
    """
Run until Next Instruction address.

Usage: nia

Put a temporary breakpoint at the address of the next instruction, and continue.

Useful to step over int interrupts.

See also:
http://stackoverflow.com/questions/24491516/how-to-step-over-interrupt-calls-when-debugging-a-bootloader-bios-with-gdb-and-q
"""
    def __init__(self):
        super().__init__(
            'nia',
            gdb.COMMAND_BREAKPOINTS,
            gdb.COMPLETE_NONE,
            False
        )
    def invoke(self, argument, from_tty):
        frame = gdb.selected_frame()
        arch = frame.architecture()
        pc = gdb.selected_frame().pc()
        length = arch.disassemble(pc)[0]['length']
        print(hex(pc))
        print(hex(length))
        gdb.Breakpoint('*' + str(pc + length), temporary = True)
        gdb.execute('continue')
NextInstructionAddress()

class BreakStackBreakpoint(gdb.Breakpoint):
    def __init__(self, parent, child):
        super().__init__(child)
        self.parent_re = re.compile(parent)
    def stop(self):
        older = gdb.selected_frame().older()
        while older:
            if self.parent_re.match(older.name()):
                return True
            older = older.older()
        return False

class BreakStack(gdb.Command):
    """
Break on child only if it was called from parent.
break-stack PARENT CHILD
http://stackoverflow.com/a/20209911/895245
"""
    def __init__(self):
        super().__init__(
            'break-stack',
            gdb.COMMAND_BREAKPOINTS,
            gdb.COMPLETE_NONE,
            False
        )
    def invoke(self, argument, from_tty):
        BreakStackBreakpoint(*gdb.string_to_argv(argument))
BreakStack()

class Vim(gdb.Command):
    """
Open current file in vim at a the current line.
http://stackoverflow.com/questions/43557405/how-to-open-the-current-file-at-the-current-line-in-a-text-editor-from-gbd/43557406#43557406
"""
    def __init__(self):
        super().__init__('vim', gdb.COMMAND_FILES)
    def invoke(self, argument, from_tty):
        sal = gdb.selected_frame().find_sal()
        call(['vim', sal.symtab.fullname(), '+{}'.format(sal.line), '+normal! zz'])
Vim()

class ContinueLastSource(gdb.Command):
    """
Initial rr attempt. Fails because rr itself has source and we step into that.
https://stackoverflow.com/questions/10978496/how-to-use-gdb-to-catch-exit-of-a-program
https://stackoverflow.com/questions/6376869/gdb-how-to-find-out-from-where-program-exited
"""
    def __init__(self):
        super().__init__(
            'cls',
            gdb.COMMAND_BREAKPOINTS,
            gdb.COMPLETE_NONE,
            False
        )
    def invoke(self, opcode, from_tty):
        while True:
            symtab = gdb.selected_frame().find_sal().symtab
            if symtab and os.path.exists(symtab.fullname()):
                break
            gdb.execute('rsi', to_string=True)
ContinueLastSource()

class Curpath(gdb.Command):
	"""
Open current file in vim at a the current line.
https://stackoverflow.com/questions/4858023/how-can-i-view-full-path-of-a-file-in-gdb/46253475#46253475
"""
	def __init__(self):
		super().__init__('curpath', gdb.COMMAND_FILES)
	def invoke(self, argument, from_tty):
		gdb.write(gdb.selected_frame().find_sal().symtab.fullname() + os.linesep)
Curpath()

class Ipdb(gdb.Command):
 def __init__(self):
         super().__init__('ipdb', gdb.COMMAND_OBSCURE)
 def invoke(self, argument, from_tty):
     import ipdb
     ipdb.set_trace()
Ipdb()

class Pdb(gdb.Command):
 def __init__(self):
         super().__init__('pdb', gdb.COMMAND_OBSCURE)
 def invoke(self, argument, from_tty):
     import pdb
     pdb.set_trace()
Pdb()
