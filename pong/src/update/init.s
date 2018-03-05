#
#  Initalize the game.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update/init.s"


# Initalize the game.
init_game:


init_ball: # Initalize the ball

    li $ballx, 4 * (kPaddleWidth + kFixedMiddle)
    sw $ballx, dBallX($zero)

    li $bally, (2 * (kGameAreaHeight - kBallHeight))
    sw $ballx, dBallY($zero)

    li $ballvelx, (-kBallVelX)
    sw $ballvelx, dBallVelocityX($zero)

    li $ballvely, 8
    sw $ballvely, dBallVelocityY($zero)



init_paddles: # Initalize the paddles

    li $paddley, (2 * kGameAreaHeight)

    sw $ballx, dPaddleLY($zero)
    sw $ballx, dPaddleRY($zero)
