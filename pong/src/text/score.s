#
#  Draw the score.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "text/score.s"


# Draw the score the score for player/CPU.
# Arguments: *$vgapos, $score
# Used: $tmp, $savedra, $letteraddr, $letterend, $letterline, $letterindex, $pixel, $one
draw_score:

    move $savedra, $ra

    li $scoredec, -4    

calculate_score_base10:  # Calculate the score in base 10.

    addi $scoredec, 4
    addi $score, -40
    bgez $score, calculate_score_base10


render_score: # Render the score on the screen.

    lw $letteraddr, fLetters($scoredec)  # Draw the first number.
    jal draw_letter

    li $tmp, (-kScreenWidth * kFontLetterHeight + kFontLetterWidth + kScoreMargin)  # Calculate pos of next number in screen.
    sll $tmp, 2
    add $vgapos, $tmp

    lw $letteraddr, (fLetters + 40)($score) # Draw the second number.
    jal draw_letter

    jr $savedra  # Function return.
