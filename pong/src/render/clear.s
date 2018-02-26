#
#  Clear objects from the screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render/clear.s"


# Clear the ball.
clear_ball:

    li $color, kBackgroundColor
    jal draw_ball
