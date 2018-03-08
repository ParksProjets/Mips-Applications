#
#  Draw the score.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "text/score.s"


# Draw the score
draw_score:

    move $savedra, $ra

    li $scoredec, -4    


clalculate_score_base10: # Calculate the score in base 10

    addi $scoredec, 4
    addi $score, -40

    bgez $score, clalculate_score_base10


render_score: # Render the score on the screen

    li $vgapos, (kVgaAddress + (kSceneWidth * kScorePosY + kScorePosX) * 4)
    lw $letteraddr, fLetters($scoredec)

    jal draw_letter

    addi $vgapos, ((-kSceneWidth * kFontLetterHeight + kFontLetterWidth + 2) * 4)
    lw $letteraddr, (fLetters + 40)($score)

    jal draw_letter

    jr $savedra  # Function return
