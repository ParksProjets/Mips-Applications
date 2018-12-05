#
#  Update the ball.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "ball.s"


# Update the ball.
update_ball:

    lw $ballx, dBallX($zero)
    lw $bally, dBallY($zero)

    lw $ballvelx, dBallVelocityX($zero)
    lw $ballvely, dBallVelocityY($zero)

    add $ballx, $ballvelx  # Apply velocity on x position.
    add $bally, $ballvely  # Same for y.



# Test if the ball hits the floor or the celling.
hittest_vertical_borders:

    addi $tmp, $bally, (-kGameAreaHeight * 4)
    bgez $tmp, limit_ball_vertical  # Limit: floor.
    bgtz $bally, end_hittest_vertical_borders  # Limit: celling.

limit_ball_vertical: # Limit the ball vertically: invert y velocity.

    sub $ballvely, $zero, $ballvely  # ballvely = -ballvely
    add $bally, $ballvely  # Apply new velocity on y.

end_hittest_vertical_borders:



# Test if the ball hits the left paddle (player).
hittest_left_paddle:

    bgtz $ballx, end_hittest_left_paddle  # The ball isn't on the left: don't do a hittest.

    lw $paddley, dPaddleLY($zero)  # Load paddle position.
    la $scoreptr, dPlayerScore  # Load score information.
    jal hittest_paddle

end_hittest_left_paddle:



# Test if the ball hits the right paddle (CPU).
hittest_right_paddle:

    addi $tmp, $ballx, (-(kGameAreaWidth - kBallWidth) * 4)
    bltz $tmp, end_hittest_right_paddle  # The ball isn't on the right: don't do a hittest.

    lw $paddley, dPaddleRY($zero)  # Load paddle position.
    la $scoreptr, dCpuScore  # Load score information.
    jal hittest_paddle

end_hittest_right_paddle:



# Save the ball state for the next frame.
save_ball_state:

    sw $ballx, dBallX($zero)
    sw $bally, dBallY($zero)

    sw $ballvelx, dBallVelocityX($zero)
    sw $ballvely, dBallVelocityY($zero)
