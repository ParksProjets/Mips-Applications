#
#  Update the score.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "game/score.s"


# Configuration
.set kScorePosX, 147
.set kScorePosY, 210


# Increment the score
increment_score:

    lw $score, dScore($zero)  # Load the current score

    addi $tmp, $score, (99 * -4)  # Maximum score (cheaters, don't change this value please).
    beq $tmp, $zero, you_won  # If the player has a score > 100

    addi $score, 4  # Increment the score
    sw $score, dScore($zero)  # Save the new score

    jal draw_score  # Update the score display
