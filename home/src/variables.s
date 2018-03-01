#
#  Memory data
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.section .zdata


.set kBackgroundColor, 0xFFFF


# Cursor position
cursorpos: .word 0x00

# Last buttons state
lastbtns: .word 0x00
