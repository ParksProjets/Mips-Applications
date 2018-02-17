#
#  Memory data
#

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


# Colors
.set kBackgroundColor, 0x7E19


# Pipes
# A pipe is an array of (x, y) coordonates.
.set kNumberOfPipes, 3
pipes: .space kNumberOfPipes * 8
