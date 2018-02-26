#
#  Print a text on the screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "text.s"


# Print a text on the screen.
# Arguments: $text, $x, $y
# Used: $vgapos, $tmp, $char, $charline, $pixel, $color
print_text:

    sll $vgapos, $y, 8  # Calculate vgapos = 320 * y + x
    sll $tmp, $y, 6     #   320 = 2^8 + 2^6
    addu $tmp, $tmp, $x
    addu $tmp, $tmp, $vga
    addu $vgapos, $vgapos, $tmp

    li $one, 1  # Register equal to 1 for loop condition



print_char: # Loop: print all character of the text

    nop



print_char_loop: # Loop: draw the char word by word

    lw $char, text($zero)

print_char_word: # Loop: draw the char line by line

    andi $charline, $char, 0xFF

print_char_line: # Loop: draw the char pixel by pixel

    andi $pixel, $charline, 0x1
    beq $pixel, $zero, after_print_char_pixel

    sw $color, ($vgapos)

after_print_char_pixel:

    srl $charline, 1
    bne $charline, $one, print_char_line  # Print the next pixel

    srl $char, 8
    bne $char, $zero, print_char_word  # Print the next line

    bne $TODO, $zero, print_char_loop  # Print the word


    bne $TODO, $zero, print_char  # Print the next character

    jr $ra  # Function return
