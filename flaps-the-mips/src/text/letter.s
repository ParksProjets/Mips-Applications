#
#  Draw a letter on the screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "text/letter.s"


# Configuration
.set kLetterBits, 2
.set kLetterMask, ((1 << kLetterBits) - 1)


# Draw a letter on the screen.
# Arguments: *$vgapos, $letteraddr
# Used: $letterend, $letterline, $letterindex, $pixel
draw_letter:

    addi $letterend, $letteraddr, (kFontLetterHeight * 4)


draw_letter_loop: # Loop: draw the letter line by line

    lw $letterline, ($letteraddr)


draw_letter_line: # Loop: draw the line pixel by pixel

    andi $letterindex, $letterline, kLetterMask
    sll $letterindex, 2

    lw $pixel, (fColorPalette - 4)($letterindex)  # Get the color from the palette
    sw $pixel, ($vgapos)

    srl $letterline, 2
    addi $vgapos, 4

    bne $letterline, $zero, draw_letter_line  # Draw the next pixel


    addi $letteraddr, 4
    addi $vgapos, ((kSceneWidth - kFontLetterWidth) * 4)

    bne $letteraddr, $letterend, draw_letter_loop  # Draw the next line

    jr $ra  # Function return
