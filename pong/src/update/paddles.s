#
#  Update the paddles.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update/paddles.s"


# Update the left paddle (player).
update_left_paddle:

    lw $btns, kSwitchesAddress($zero)
    srl $btns, 16

    lw $paddley, dPaddleLY($zero)

    li $tmp, kPlayerMoveUp
    bne $btns, $tmp, end_left_paddle_moveup  # If the player doesn't move up

left_paddle_moveup: # Move the left paddle up

    blez $paddley, end_left_paddle_moveup  # If the paddle is at the top
    addi $paddley, -kPaddleSpeed

end_left_paddle_moveup:

    li $tmp, kPlayerMoveDown
    bne $btns, $tmp, end_left_paddle_movedown  # If the player doesn't move down

left_paddle_movedown: # Move the left paddle down

    addi $tmp, $paddley, (-4 * kPaddleMaxY)
    bgez $tmp, end_left_paddle_movedown  # If the paddle is at the bottom
    addi $paddley, kPaddleSpeed

end_left_paddle_movedown:

    sw $paddley, dPaddleLY($zero)





# Update the left paddle (computer).
update_right_paddle:

    lw $ballx, dBallX($zero)
    lw $bally, dBallY($zero)

    lw $paddley, dPaddleRY($zero)

    # addi $tmp, $ballx, (-3 * kGameAreaWidth)  # 3/4 of game area width
    # bgez $tmp, cpu_quick_reaction

    j cpu_quick_reaction



# Normal CPU reaction.
cpu_normal_reaction:

    addi $cpuskip, -1
    bgtz $cpuskip, limit_right_paddle


    
    j limit_right_paddle



# Quick CPU reaction.
cpu_quick_reaction:

    sub $tmp2, $bally, $paddley

    addi $tmp, $tmp2, (kPaddleHeight / 2)
    bgtz $tmp, cpu_quick_move_bottom

    addi $paddley, (-kPaddleSpeed / 2)
    j limit_right_paddle

cpu_quick_move_bottom:

    addi $paddley, (kPaddleSpeed / 2)



# Limit right paddle between 0 and height.
limit_right_paddle:

limit_right_paddle_top:

    bgez $paddley, limit_right_paddle_bottom  # If paddley < 0.
    li $paddley, 0

limit_right_paddle_bottom:

    addi $tmp, $paddley, (-kPaddleMaxY * 4)
    blez $tmp, end_update_right_paddle  # If paddley > height.
    li $paddley, (kPaddleMaxY * 4)


end_update_right_paddle:

    sw $paddley, dPaddleRY($zero)
