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

See also: http://stackoverflow.com/questions/24491516/how-to-step-over-interrupt-calls-when-debugging-a-bootloader-bios-with-gdb-and-q
"""
    def __init__(self):
        super().__init__(
            'nia',
            gdb.COMMAND_BREAKPOINTS,
            gdb.COMPLETE_NONE,
            False
        )
    def invoke(self, arg, from_tty):
        frame = gdb.selected_frame()
        arch = frame.architecture()
        pc = gdb.selected_frame().pc()
        length = arch.disassemble(pc)[0]['length']
        print(hex(pc))
        print(hex(length))
        gdb.Breakpoint('*' + str(pc + length), temporary = True)
        gdb.execute('continue')
NextInstructionAddress()
