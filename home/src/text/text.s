#
#  Print a text on the screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "text.s"


# Config
.set kTextLengthBits, 8

# Masks
.set kTextLengthMask, ((1 << kTextLengthBits) - 1)
.set kTextLetterMask, ((1 << kFontIndexLength) - 1)
.set kMultilineContinuation, (1 << 7)


# Print a multiline text on the screen.
# Arguments: $text, $x, $y, $color
# Used: same as 'print_text', $hasnextline
print_multiline_text:

    move $savedra, $ra

print_multiline_text_line: # Loop: print the text line by line

    lw $hasnextline, ($text)
    andi $hasnextline, (kMultilineContinuation)

    jal print_text

    addi $y, (10 * 4)
    bne $hasnextline, $zero, print_multiline_text_line

    jr $savedra




# Print a text on the screen.
# Arguments: $text, $x, $y, $color
# Used: $vgapos, $tmp, $char, $charline, $index, $indexes, $pixel, $i2,
#       $vgasaved2, $one, $textlength
print_text:

    sll $vgapos, $y, 8  # Calculate vgapos = 320 * y + x
    sll $tmp, $y, 6     #   320 = 2^8 + 2^6
    addu $tmp, $tmp, $x
    addu $tmp, $tmp, $vga
    addu $vgapos, $vgapos, $tmp

    li $one, 1  # Register equal to 1 for loop condition

    lw $indexes, ($text)  # Load first word
    andi $textlength, $indexes, (kTextLengthMask & ~kMultilineContinuation)
    srl $indexes, (kTextLengthBits)

    j print_charindex_word


print_char: # Loop: print all character of the text

    lw $indexes, ($text)

print_charindex_word: # Loop: print all chars in the word

    andi $index, $indexes, (kTextLetterMask)
    sll $index, 3  # index *= 8
    srl $indexes, (kFontIndexLength)

    move $vgasaved2, $vgapos
    li $i2, 2


print_char_loop: # Loop: draw the char word by word

    lw $char, (font - 8)($index)

print_char_word: # Loop: draw the char line by line

    move $vgapos, $vgasaved2
    andi $charline, $char, 0xFF

print_char_line: # Loop: draw the char pixel by pixel

    andi $pixel, $charline, 0x1
    beq $pixel, $zero, after_print_char_pixel

    sw $color, ($vgapos)

after_print_char_pixel:

    addi $vgapos, 4
    srl $charline, 1
    bne $charline, $one, print_char_line  # Print the next pixel

    srl $char, 8
    addi $vgasaved2, $vgasaved2, (kScreenWidth * 4)
    bne $char, $zero, print_char_word  # Print the next line

    addi $i2, -1
    addi $index, 4
    bne $i2, $zero, print_char_loop  # Print the next word


    addi $vgapos, $vgapos, (-kScreenWidth * 4 * 7 + 4)
    bne $indexes, $zero, print_charindex_word  # Print the next character in the word

    addi $text, 4
    addi $textlength, -1
    bgtz $textlength, print_char  # Print the next character

    jr $ra  # Function return
