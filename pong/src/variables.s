#
#  Memory data
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.data


# Height of the game area
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

.set kBallColor, 0xADB5


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
