#
#  Definitions.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT


# Non-local registers
.set $birdx, $16
.set $birdy, $17
.set $birdvel, $18

.set $vga, $19
.set $gameended, $26
.set $gamestarted, $27


# General local registers
.set $addr, $8
.set $endaddr, $9
.set $i, $21
.set $savedvgapos, $30
.set $savedra, $30


# Update special aliases
.set $pipex, $12
.set $pipey, $13
.set $pipeendy, $6

.set $btns, $6
.set $btndown, $12
.set $inputcounter, $13


# Render special aliases
.set $vgapos, $14
.set $vgaendpos, $7
.set $spritestart, $23
.set $pixel, $22
.set $pixel2, $9
.set $color, $22
.set $vgalineend, $25

.set $width, $20
.set $height, $25

.set $spriteaddr, $25
.set $savedvgapos, $30
.set $spritetail, $4


# Text rendering special aliases
.set $letteraddr, $25
.set $letterend, $4
.set $letterline, $23
.set $letterindex, $20


# Conditional aliases
.set $xcmp, $22
.set $ycmp, $23
.set $xcmpsh, $14


# Pipe related aliases
.set $spritex, $6
.set $newline, $20
.set $spriteend, $5
.set $spriteendcopy, $24
.set $spritestartcopy, $30


# Ground related aliases
.set $groundpos, $12
.set $grounddiff, $13


# Score related registers
.set $score, $6
.set $scoredec, $21


# Other
.set $tmp, $24
.set $tmp2, $25
.set $gamemustend, $8



# Redefine 'lih' because we don't need to do a 'lui'
.macro lih reg, addr
    addiu \reg, $zero, \addr
.endm
