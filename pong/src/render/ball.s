#
#  Render the ball.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render/ball.s"


# Render the ball.
render_ball:

    li $color, kBallColor
    jal draw_ball
