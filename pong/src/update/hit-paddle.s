#
#  Hit test between the ball and the paddles.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update/hit-paddles.s"


# Hit test between the ball and a paddle.
# Arguments: $paddley, $bally
# Used: $tmp
hittest_paddle:

    sub $tmp, $paddley, $bally
    addi $tmp, ((-kBallHeight + 1) * 4)
    bgtz $tmp, ball_scored  # not(paddley <= bally) -> player scored

    addi $tmp, ((kPaddleHeight + kBallHeight - 2) * 4)
    bgez $tmp, hit_paddle  # (bally <= paddley + h) -> ball hits paddle


ball_scored: # The ball hits the left wall: the right player score!

    # TODO: add point
    j main


hit_paddle: # The ball hits the paddle

    sub $ballvelx, $zero, $ballvelx  # ballvelx = -ballvelx
    add $ballx, $ballvelx


end_hittest_paddle:

    jr $ra  # Function return
