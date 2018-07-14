#
#  Starts the game.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "game/start.s"


# Starts the game.
start_game:

    bne $gamestarted, $zero, after_start_game  # The game has already started.


    lw $btns, kSwitchesAddress($zero)  # Read switch values.
    srl $btns, 16  # Get buttons value.

    beq $btns, $zero, after_start_game  # No buttons pressed: don't start the game.


    # If button was pressed before the app was lanched, the game must not start.
    # This code prevents unwanted starts.
    lw $btndown, dBirdBtndown($zero)
    beq $btndown, $zero, starts_the_game

    sw $btns, dBirdBtndown($zero)
    j after_start_game


starts_the_game: # Starts the game now!

    li $gamestarted, 1  # This flag indicates that the game has been started.

    jal clear_title  # Clear "FlapsTheMips" title.
    jal draw_score  # Draw the current score.


after_start_game:
