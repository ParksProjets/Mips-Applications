#
#  Update the score.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "game/score.s"


# Increment the score for player/CPU and restart.
increment_score:

    lw $score, ($scoreptr)  # Load score from pointer.
    addi $score, 4  # Increment score.
    sw $score, ($scoreptr)  # Store back the score.

    lw $vgapos, 4($scoreptr)  # Load score position in the screen.

    jal draw_score


restart_game: # Restart the game.

    li $vgaend, (4 * kScreenWidth * kGameAreaHeight)
    add $vgaend, $vga

    j cleanup
