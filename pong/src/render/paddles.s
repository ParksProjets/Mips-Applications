#
#  Render the paddles.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render/paddles.s"


# Render the paddles.
render_paddles:

render_left_paddle: # Render the left paddle

    lw $y, dPaddleLY($zero)
    li $x, 0
    li $color, kPlayerLColor

    jal draw_paddle

render_right_paddle: # Render the right paddle

    lw $y, dPaddleRY($zero)
    li $x, (4 * (kScreenWidth - kPaddleWidth))
    li $color, kPlayerRColor

    jal draw_paddle

end_render_paddles:

    # Fall throught "render_ball"
