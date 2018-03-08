#
#  Draw an image on the screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "text/image.s"


# Draw an image on the screen
# Arguments: *$spriteaddr, $spritetail, $vgapos, $width, $tmp
# Notes: $width is 4 bytes aligned
draw_image:

draw_whole_image:  # Loop: draw the whole image line by line

    add $spriteend, $spriteaddr, $tmp

draw_image_line:  # Loop: draw a whole line

    lw $pixel, ($spriteaddr)

draw_pixel_word: # Loop: draw all pixels in a word

    andi $pixel2, $pixel, 0b11  # Get the color from the palette
    sll $pixel2, 2
    lw $pixel2, (fColorPalette)($pixel2)

    sw $pixel2, ($vgapos)  # Color the pixel on the screen
    addi $vgapos, 4

    srl $pixel, 2
    bne $pixel, $zero, draw_pixel_word  # Draw the next pixel

end_draw_pixel_word:

    addi $spriteaddr, 4
    bne $spriteaddr, $spriteend, draw_image_line  # Draw pixels on the next word

end_draw_image_line:

    addi $vgapos, $vgapos, (kSceneWidth * 4)
    sub $vgapos, $width

    bne $spriteaddr, $spritetail, draw_whole_image  # Draw the next line

    jr $ra  # Function return
