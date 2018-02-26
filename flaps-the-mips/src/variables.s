#
#  Memory data
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.data


# Scene size
.set kSceneWith, 320
.set kSceneHeight, 188

# Hardware information
.set kClockFrequency, 50000000

# Peripheral addresses
.set kTimerReadAddress, 0x4010
.set kTimerPeriodAddress, 0x4010
.set kTimerThresoldAddress, 0x4014
.set kSwitchesAddress, 0x4004


# Masks
.set kButtonsMask, 0xF

# Colors
.set kBackgroundColor, 0x7E19



# Bird information
dBirdInputcounter: .word 0x0
dBirdBtndown: .word 0x0


# Pipes
# A pipe is an array of (x, y) coordonates.
.set kNumberOfPipes, 3
dPipes: .space kNumberOfPipes * 8
