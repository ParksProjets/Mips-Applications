#
#  Defintions.
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


# Register aliases
.set $vga, $16
.set $savedra, $30
.set $lastbtn, $2

.set $x, $17
.set $y, $18
.set $dx, $19
.set $dy, $20


# Image rendering alisases
.set $endimgpos, $4
.set $endwidth, $5
.set $endheight, $6


# Graphics module alisases
.set $vgapos, $8
.set $lastvgapos, $9
.set $pixels, $10
.set $px, $11
.set $vgapos2, $11
.set $index, $12
.set $lastvgapos2, $12
.set $imgpos, $13
.set $clearstep, $13
.set $endlinepos, $14


# Other aliases
.set $tmp, $24
.set $tmp2, $25
