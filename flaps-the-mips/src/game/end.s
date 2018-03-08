#
#  Manage the end of the game.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "game/end.s"


# Stops the game now!
ends_the_game:


# First, wait for 0.5s
ends_game_timer:

    li $tmp2, (kFramePerSecond / 2)

ends_game_timer_wait:

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, ends_game_timer_wait

    addi $tmp2, -1
    bne $tmp2, $zero, ends_game_timer_wait


# Then, wait for a button or 3s
ends_game_btns:

    li $tmp2, (kFramePerSecond * 3)

ends_game_btns_wait:

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, ends_game_btns_wait

    lw $btns, kSwitchesAddress($zero)
    srl $btns, 16  # Get buttons value

    bne $btns, $zero, restart_game  # Restart the game if a button is pressed

    addi $tmp2, -1
    bne $tmp2, $zero, ends_game_btns_wait

    j restart_game  # Restart the game
