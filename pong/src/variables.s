#
#  Memory data
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.section .zdata


# Size of the game area
.set kGameAreaWidth, 320
.set kGameAreaHeight, 200


# Paddle information
.set kPaddleSpeed, 16

.set kPaddleWidth, 6
.set kPaddleHeight, 20

.set kPlayerLColor, 0xBDE0
.set kPlayerRColor, 0x0010


# Ball information
.set kBallWidth, 6
.set kBallHeight, 6

.set kBallVelX, 28
.set kBallColor, 0xADB5


# Position helpers
.set kPaddleMaxY, (kGameAreaHeight - kPaddleHeight)
.set kNumberStepsX, ((kGameAreaWidth - 2*kPaddleWidth) / kBallVelX)
.set kFixedMiddle, ((kNumberStepsX / 2) * kBallVelX)


# Player control
.set kPlayerMoveUp, 0b001
.set kPlayerMoveDown, 0b010



# Left paddle position
dPaddleLY: .word 0x0

# Right paddle position
dPaddleRY: .word 0x0


# Ball position
dBallX: .word 0x0
dBallY: .word 0x0

# Ball velocity
dBallVelocityX: .word 0x0
dBallVelocityY: .word 0x0
