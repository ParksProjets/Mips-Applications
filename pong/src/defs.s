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


# Color set
.set kBackgroundColor, 0x02E0
.set kTextColor, 0xADB5



# Register aliases
.set $vga, $16
.set $savedra, $30

.set $cpuskip, $17
.set $paddley, $13


# Update specific aliases
.set $btns, $11

.set $ballx, $4
.set $bally, $5
.set $ballvelx, $6
.set $ballvely, $7


# Render specific aliases
.set $x, $4
.set $y, $5
.set $width, $6
.set $height, $7
.set $color, $8

.set $vgapos, $11
.set $vgaend, $12


.set $tmp, $24
.set $tmp2, $25
