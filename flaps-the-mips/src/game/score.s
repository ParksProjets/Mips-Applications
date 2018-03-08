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

    lw $score, dScore($zero)

    addi $tmp, $score, (-99 * 4)  # Maximum score
    beq $tmp, $zero, you_won

    addi $score, 4
    sw $score, dScore($zero)

    jal draw_score
