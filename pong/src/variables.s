#
#  Memory data.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.section .zdata


# Screen size.
.set kScreenWidth, 320
.set kScreenHeight, 240


# Hardware information.
.set kClockFrequency, 50000000

# Peripheral addresses.
.set kTimerReadAddress, 0x4010
.set kTimerPeriodAddress, 0x4010
.set kTimerThresoldAddress, 0x4014
.set kSwitchesAddress, 0x4004
.set kVgaAddress, 0x80000


# Size of the game area.
.set kGameAreaWidth, 320
.set kGameAreaHeight, 200


# Color set.
.set kBackgroundColor, 0x02E0
.set kTextColor, 0xADB5

# Score configuration.
.set kScoreBasePos, (kVgaAddress + (kScreenWidth * (kGameAreaHeight + 4) * 4))
.set kScoreOffset, 10
.set kScoreMargin, 2


# Paddle information.
.set kPaddleSpeed, 16

.set kPaddleWidth, 6
.set kPaddleHeight, 20

.set kPlayerLColor, 0xBDE0
.set kPlayerRColor, 0x0010

# Ball information.
.set kBallWidth, 6
.set kBallHeight, 6

.set kBallVelX, 28
.set kBallColor, 0xADB5


# Position helpers.
.set kPaddleMaxY, (kGameAreaHeight - kPaddleHeight)
.set kNumberStepsX, ((kGameAreaWidth - 2*kPaddleWidth) / kBallVelX)
.set kFixedMiddle, ((kNumberStepsX / 2) * kBallVelX)

# Player control.
.set kPlayerMoveUp, 0b001
.set kPlayerMoveDown, 0b010



# Left/right paddle position.
dPaddleLY: .word 0x0
dPaddleRY: .word 0x0

# Ball position.
dBallX: .word 0x0
dBallY: .word 0x0

# Ball velocity.
dBallVelocityX: .word 0x0
dBallVelocityY: .word 0x0

# Player/CPU score (score, position)
dPlayerScore: .word 0x0, (kScoreBasePos + kScoreOffset * 4)
dCpuScore:    .word 0x0, (kScoreBasePos + (kScreenWidth - (2 * kFontLetterWidth) - kScoreMargin - kScoreOffset) * 4)


# Font color palette.
fColorPalette: .word kBackgroundColor, kTextColor
