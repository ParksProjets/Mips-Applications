#
#  Hit test between the ball and the paddles.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update/hit-paddles.s"


# Hit test between the ball and a paddle.
# Arguments: $paddley, $bally, $scoreptr
# Used: $tmp
hittest_paddle:

    sub $tmp, $paddley, $bally
    addi $tmp, ((-kBallHeight + 1) * 4)
    bgtz $tmp, ball_scored  # not(paddley <= bally) -> player/cpu scored.

    addi $tmp, ((kPaddleHeight + kBallHeight - 2) * 4)
    bgez $tmp, hit_paddle  # (bally <= paddley + h) -> ball hits paddle.


ball_scored: # The ball hits a wall: player/CPU scores!

    j increment_score  # Increment score and restart.


hit_paddle: # The ball hits the paddle.

    sub $ballvelx, $zero, $ballvelx  # ballvelx = -ballvelx
    add $ballx, $ballvelx  # Apply new x velocity.


end_hittest_paddle:

    jr $ra  # Function return.
