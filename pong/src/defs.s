#
#  Definitions.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT


# Register aliases.
.set $vga, $16
.set $savedra, $30

.set $cpuskip, $17
.set $paddley, $13


# Update specific aliases
.set $btns, $11
.set $scoreptr, $11

.set $ballx, $4
.set $bally, $5
.set $ballvelx, $6
.set $ballvely, $7

.set $score, $4
.set $scoredec, $20


# Render specific aliases.
.set $x, $4
.set $y, $5
.set $width, $6
.set $height, $7
.set $color, $8

.set $vgapos, $11
.set $vgaend, $12


# Text specific aliases.
.set $letteraddr, $5
.set $letterend, $6
.set $letterline, $7
.set $letterindex, $8
.set $pixel, $9
.set $one, $25


# Temporary register aliases.
.set $tmp, $24
.set $tmp2, $25
