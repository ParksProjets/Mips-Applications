#
#  Manage the end of the game (if the player loose).
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "game/end.s"


# Stops the game now!
ends_the_game:


# First, wait for 0.5s.
ends_game_timer:

    li $tmp2, (kFramesPerSecond / 2)  # 0.5s = half of number of fps.

ends_game_timer_wait:  # Decrement the timer on each frame.

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, ends_game_timer_wait  # Wait for a frame.

    addi $tmp2, -1  # Decrement the timer.
    bne $tmp2, $zero, ends_game_timer_wait  # If the timer is not 0: wait for next frame.


# Then, wait for a button or 3s.
ends_game_btns:

    li $tmp2, (kFramesPerSecond * 3)  # 3s = 3 * number of fps.

ends_game_btns_wait:

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, ends_game_btns_wait  # Wait for a frame.

    lw $btns, kSwitchesAddress($zero)  # Read switch values.
    srl $btns, 16  # Get buttons value.

    bne $btns, $zero, restart_game  # Restart the game if a button is pressed.

    addi $tmp2, -1  # Else decrement the timer.
    bne $tmp2, $zero, ends_game_btns_wait  # If the timer is not 0: wait for next frame.

    j restart_game  # Restart the game
