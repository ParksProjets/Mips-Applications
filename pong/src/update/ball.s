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

    add $ballx, $ballvelx
    add $bally, $ballvely




# Test if the ball hits the floor or the celling.
hittest_vertical_borders:

    li $tmp, kGameAreaHeight
    beq $ballx, $tmp, limit_ball_vertical  # Limit: floor

    bne $ballx, $zero, end_hittest_vertical_borders  # Limit: celling

limit_ball_vertical:

    sub $bally, $zero, $bally  # bally = -bally

end_hittest_vertical_borders:




# Test if the ball hits the left paddle.
hittest_left_paddle:

    lw $paddley, dPaddleLY($zero)

    bgtz $ballx, end_hittest_left_paddle  # The ball doesn't hit the left paddle

    sub $tmp, $paddley, $bally
    bgtz $tmp, ball_scored_left  # not(paddley <= bally) -> player scored

    addi $tmp, 5 # TODO: use constant height
    bgez $tmp, hit_left_paddle  # paddley <= bally -> ball hits paddle


ball_scored_left: # The ball hits the left wall: the right player score!

    # TODO: add point
    j main


hit_left_paddle: # The ball hist the paddle

    sub $ballvelx, $zero, $ballvelx  # ballvelx = -ballvelx


end_hittest_left_paddle:




# Test if the ball hits the left paddle.
hittest_right_paddle:

    lw $paddley, dPaddleRY($zero)

    bgtz $ballx, end_hittest_right_paddle  # The ball doesn't hit the left paddle

    sub $tmp, $paddley, $bally
    bgtz $tmp, ball_scored_right  # not(paddley <= bally) -> player scored

    addi $tmp, 5 # TODO: use constant height
    bgez $tmp, hit_right_paddle  # paddley <= bally -> ball hits paddle


ball_scored_right: # The ball hits the right wall: the left player score!

    # TODO: add point
    j main


hit_right_paddle: # The ball hist the paddle

    sub $ballvelx, $zero, $ballvelx  # ballvelx = -ballvelx


end_hittest_right_paddle:


    sw $ballx, dBallX($zero)
    sw $bally, dBallY($zero)

    sw $ballvelx, dBallVelocityX($zero)
    sw $ballvely, dBallVelocityY($zero)
