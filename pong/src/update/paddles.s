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

    addi $tmp, $paddley, (-4 * kGameAreaHeight)
    bgez $tmp, end_left_paddle_movedown  # If the paddle is at the bottom
    addi $paddley, kPaddleSpeed

end_left_paddle_movedown:

    sw $paddley, dPaddleLY($zero)




# Update the left paddle (computer).
update_right_paddle:


#     li $tmp, TODO
#     bge $bally, $tmp, cpu_quick_reaction


# cpu_normal_reaction: # Normal CPU reaction

#     j move_right_paddle


# cpu_quick_reaction: # Quick CPU reaction



# move_right_paddle:

#     li $tmp, kPlayerMoveDown
#     bne $btns, $tmp, end_right_paddle_moveup  # If the player doesn't move up

# right_paddle_moveup: # Move the right paddle up

#     bgez $paddley, end_right_paddle_moveup  # If the paddle is at the top
#     addi $paddley, kPaddleSpeed

# end_right_paddle_moveup:


#     li $tmp, kPlayerMoveDown
#     bne $btns, $tmp, end_right_paddle_movedown  # If the player doesn't move down

# right_paddle_movedown: # Move the right paddle down

#     bgez $paddley, end_right_paddle_movedown  # If the paddle is at the bottom
#     addi $paddley, -kPaddleSpeed

# end_right_paddle_movedown:


