#
#  Definitions.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT


# Screen size
.set kScreenWidth, 320
.set kScreenHeight, 240


# Hardware information
.set kClockFrequency, 50000000

# Peripheral addresses
.set kTimerReadAddress, 0x4010
.set kTimerPeriodAddress, 0x4010
.set kTimerThresoldAddress, 0x4014
.set kSwitchesAddress, 0x4004
.set kVgaAddress, 0x80000



# Common register aliases
.set $vga, $16
.set $one, $20
.set $savedra, $17

.set $pixel, $8
.set $vgapos, $9
.set $vgasaved, $10
.set $i, $11
.set $i2, $19

.set $tmp, $24
.set $tmp2, $25


# Text module aliases
.set $text, $2
.set $color, $3
.set $x, $4
.set $y, $5

.set $char, $12
.set $charline, $13
.set $textlength, $14
.set $index, $15
.set $indexes, $24
.set $vgasaved2, $25

.set $hasnextline, $11


# Graphics module aliases
.set $width, $12
.set $height, $13
.set $vgaend, $15
.set $imgstart, $19
.set $imgend, $10


# Menu module aliases
.set $btns, $2

.set $cursorpos, $14
.set $prevcurpos, $19
.set $botcurpos, $15
