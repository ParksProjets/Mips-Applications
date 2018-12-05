#
#  Draw a letter on the screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "text/letter.s"


# Configuration.
.set kLetterBits, 1
.set kLetterMask, ((1 << kLetterBits) - 1)


# Draw a letter on the screen.
# Arguments: *$vgapos, $letteraddr
# Used: $letterend, $letterline, $letterindex, $pixel, $one
draw_letter:

    addi $letterend, $letteraddr, (kFontLetterHeight * 4)  # Calculate end pointer.
    li $one, 1  # Load '1' for knowing where a line ends.


draw_letter_loop: # Loop: draw the letter line by line.

    lw $letterline, ($letteraddr)  # Load a pixel line (from the font).


draw_letter_line: # Loop: draw the line pixel by pixel.

    andi $letterindex, $letterline, kLetterMask  # Get pixel index in palette.
    sll $letterindex, 2  # Shift it because palette is 4 bytes aligned.

    lw $pixel, fColorPalette($letterindex)  # Get the color from the palette.
    sw $pixel, ($vgapos)  # Draw pixel.

    srl $letterline, kLetterBits  # Shift line for getting next pixel.
    addi $vgapos, 4  # Move pixel cursor.

    bne $letterline, $one, draw_letter_line  # Draw the next pixel (if exists).

    addi $letteraddr, 4  # Move to next pixel line.
    addi $vgapos, ((kScreenWidth - kFontLetterWidth) * 4)

    bne $letteraddr, $letterend, draw_letter_loop  # Draw the next line.
    jr $ra  # Function return.
