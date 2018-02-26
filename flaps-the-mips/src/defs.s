#
#  Definitions.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT


# Non-local registers
.set $birdx, $16
.set $birdy, $17
.set $vga, $18


# General local registers
.set $addr, $8
.set $endaddr, $9
.set $i, $21


# Update special aliases
.set $pipex, $12
.set $pipey, $13
.set $pipeendy, $6


# Render special aliases
.set $vgapos, $14
.set $vgaendpos, $7
.set $spritestart, $23
.set $pixel, $22
.set $vgalineend, $25
.set $width, $20

.set $spriteaddr, $25
.set $savedvgapos, $19


# Function: 'calculate_vgaendpos'
.set $y, $4
.set $spriteend, $5
.set $spriteendcopy, $24


# Other
.set $tmp, $24
.set $tmp2, $25



# Redefine 'lih' because we don't need to do a 'lui'
.macro lih reg, addr
    addiu \reg, $zero, \addr
.endm
