#
#  Initalize the game.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update/init.s"


# Initalize the game.
init_game:


init_ball: # Initalize the ball

    li $ballx, (2 * kScreenWidth)
    sw $ballx, dBallX($zero)

    li $bally, (2 * kGameAreaHeight)
    sw $ballx, dBallY($zero)

    li $ballvelx, 24
    sw $ballvelx, dBallVelocityX($zero)

    li $ballvely, 0
    sw $ballvely, dBallVelocityY($zero)



init_paddles: # Initalize the paddles

    li $paddley, (2 * kGameAreaHeight)

    sw $ballx, dPaddleLY($zero)
    sw $ballx, dPaddleRY($zero)
