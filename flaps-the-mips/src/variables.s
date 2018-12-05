#
#  Memory data
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.section .zdata


# Scene/screen size
.set kSceneWidth, 320
.set kSceneHeight, 188
.set kScreenHeight, 240

# Hardware information
.set kClockFrequency, 50000000

# Peripheral addresses
.set kTimerReadAddress, 0x4010
.set kTimerPeriodAddress, 0x4010
.set kTimerThresoldAddress, 0x4014
.set kSwitchesAddress, 0x4004
.set kVgaAddress, 0x80000



# Colors
.set kBackgroundColor, 0x7E19
.set kBottomColor, 0xDEB2


# Bird velocities
.set kBirdMaxVelocity, 12
.set kBirdGravity, 1
.set kBirdJumpHeight, 17

# Number of frames between jumps
.set kBirdAllowJump, 2



# Bird information
dBirdInputcounter: .word 0x0
dBirdBtndown: .word 0x0

dBirdState: .word 0x1
dBirdSprites: .word sBird2Data, sBird1Data, sBird0Data


# Ground position
dGroundPos: .word 0x0

# Score
dScore: .word 0x0


# Pipes
# A pipe is an array of (x, y) coordonates.
.set kNumberOfPipes, 3
dPipes: .space kNumberOfPipes * 8


# What is this? :)
.set kNumberOfColors, 5
dSomeColor: .word 0xDFE, 0xFC0, 0xF800, 0xA01F, 0xFFE0
