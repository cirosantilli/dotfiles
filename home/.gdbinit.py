import re
from subprocess import call

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
    """Break on child only if it was called from parent.
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

class ContinueI(gdb.Command):
    """Continue until instruction with given opcode.

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

class ContinueLastSource(gdb.Command):
    """Initial rr attempt. Fails because rr itself has source and we step into that.
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

class ContinueUntil(gdb.Command):
    """Continue until a specific breakpoint is hit
https://stackoverflow.com/questions/12081660/gdb-run-until-specific-breakpoint/12082728#12082728
"""
    def __init__ (self):
        super().__init__ ('cu', gdb.COMMAND_BREAKPOINTS)
    def invoke(self, argument, from_tty):
        argv = gdb.string_to_argv(argument)
        bp_num = int(argv[0])
        all_breakpoints = gdb.breakpoints() or []
        next(bp for bp in all_breakpoints if bp.number == bp_num)
        breakpoints = [
            b for b in all_breakpoints
            if (
                b.is_valid()
                and b.enabled
                and b.number != bp_num
                and b.visible == gdb.BP_BREAKPOINT
            )
        ]
        for b in breakpoints:
            b.enabled = False
        gdb.execute('continue')
        for b in breakpoints:
            b.enabled = True
ContinueUntil()

class ContinueUntilSource(gdb.Command):
    def __init__(self):
        super().__init__(
            'cus',
            gdb.COMMAND_BREAKPOINTS,
            gdb.COMPLETE_NONE,
            False
        )
    def invoke(self, argument, from_tty):
        argv = gdb.string_to_argv(argument)
        if argv:
            gdb.write('Does not take any arguments.\n')
        else:
            done = False
            thread = gdb.inferiors()[0].threads()[0]
            while True:
                message = gdb.execute('si', to_string=True)
                if not thread.is_valid():
                    break
                try:
                    path = gdb.selected_frame().find_sal().symtab.fullname()
                except:
                    pass
                else:
                    if os.path.exists(path):
                        break
ContinueUntilSource()

class Curpath(gdb.Command):
	"""Open current file in vim at a the current line.
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

class NextInstructionAddress(gdb.Command):
    """Run until Next Instruction address.

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

class Pdb(gdb.Command):
 def __init__(self):
         super().__init__('pdb', gdb.COMMAND_OBSCURE)
 def invoke(self, argument, from_tty):
     import pdb
     pdb.set_trace()
Pdb()

class TraceAsm(gdb.Command):
    """https://stackoverflow.com/questions/8841373/displaying-each-assembly-instruction-executed-in-gdb/46661931#46661931
"""
    def __init__(self):
        super().__init__(
            'trace-asm',
            gdb.COMMAND_BREAKPOINTS,
            gdb.COMPLETE_NONE,
            False
        )
    def invoke(self, argument, from_tty):
        argv = gdb.string_to_argv(argument)
        if argv:
            gdb.write('Does not take any arguments.\n')
        else:
            done = False
            thread = gdb.inferiors()[0].threads()[0]
            last_path = None
            last_line = None
            with open('trace.tmp', 'w') as f:
                while thread.is_valid():
                    frame = gdb.selected_frame()
                    sal = frame.find_sal()
                    symtab = sal.symtab
                    if symtab:
                        path = symtab.fullname()
                        line = sal.line
                    else:
                        path = None
                        line = None
                    if path != last_path:
                        f.write("path {}{}".format(path, os.linesep))
                        last_path = path
                    if line != last_line:
                        f.write("line {}{}".format(line, os.linesep))
                        last_line = line
                    pc = frame.pc()
                    f.write("{} {} {}".format(hex(pc), frame.architecture().disassemble(pc)[0]['asm'], os.linesep))
                    gdb.execute('si', to_string=True)
TraceAsm()

class Vim(gdb.Command):
    """Open current file in vim at a the current line.
http://stackoverflow.com/questions/43557405/how-to-open-the-current-file-at-the-current-line-in-a-text-editor-from-gbd/43557406#43557406
"""
    def __init__(self):
        super().__init__('vim', gdb.COMMAND_FILES)
    def invoke(self, argument, from_tty):
        sal = gdb.selected_frame().find_sal()
        call(['vim', sal.symtab.fullname(), '+{}'.format(sal.line), '+normal! zz'])
Vim()
