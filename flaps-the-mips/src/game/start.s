#
#  Starts the game.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "game/start.s"


# Starts the game.
start_game:

    bne $gamestarted, $zero, after_start_game  # The game has already started


    lw $btns, kSwitchesAddress($zero)
    srl $btns, 16  # Get buttons value

    beq $btns, $zero, after_start_game


    lw $btndown, dBirdBtndown($zero)
    beq $btndown, $zero, starts_the_game  # Prevent unwanted starts

    sw $btns, dBirdBtndown($zero)
    j after_start_game


starts_the_game: # Starts the game now!

    li $gamestarted, 1


after_start_game:
