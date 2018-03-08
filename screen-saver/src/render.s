#
#  Render the screen saver image.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render.s"

.set kPixelMask, ((1 << kImageAlign) - 1)  # Mask for getting a pixel


# Redraw the screen saver image
draw:

# Clear the horizontal part of the image
clear_image_horizontal:

    li $clearstep, (4 * kImageSpeed)
    move $vgapos2, $vgapos
    move $lastvgapos2, $lastvgapos

    bgtz $dx, clear_image_horizontal_rect

    addi $lastvgapos, $lastvgapos, (4 * (kImageWidth - kImageSpeed))
    addi $vgapos, $vgapos, (4 * (kImageWidth - kImageSpeed))
    j clear_image_horizontal_rect

clear_image_horizontal_rect:

    jal clear_rect



# Clear the vertical part of the image
clear_image_vertical:

    li $clearstep, (4 * kImageWidth)
    bltz $dy, clear_image_vertical_bottom

    move $lastvgapos, $lastvgapos2
    addi $vgapos, $lastvgapos, (4 * kScreenWidth * kImageSpeed)
    j clear_image_vertical_rect

clear_image_vertical_bottom:

    move $vgapos, $vgapos2
    addi $lastvgapos, $vgapos, (-4 * kScreenWidth * kImageSpeed)

clear_image_vertical_rect:

    jal clear_rect



# Draw the screen saver image at its new position
draw_image:

    li $imgpos, 0  # Clear $imgpos and $endlinepos
    li $endlinepos, 0

    sll $vgapos, $y, 8  # Calculate vgapos = 320 * y + x
    sll $tmp, $y, 6     #   320 = 2^8 + 2^6
    addu $tmp, $tmp, $x
    addu $tmp, $tmp, $vga
    addu $vgapos, $vgapos, $tmp

    move $lastvgapos, $vgapos  # Save $vgapos

draw_whole_image:  # Loop: draw the whole image line by line

    addi $endlinepos, $endlinepos, (kImageWidth / kImagePixelsPerWord * 4)

draw_image_line:  # Loop: draw a whole line

    lw $pixels, image($imgpos)  # Load the pixels from the word

draw_pixel_word:  # Loop: draw all pixels in a word

    andi $index, $pixels, kPixelMask  # Get the color from the palette
    sll $index, $index, 2
    lw $px, (palette - 4)($index)

    sw $px, 0($vgapos)  # Color the pixel on the screen
    addi $vgapos, $vgapos, 4

    srl $pixels, $pixels, kImageAlign   # Get the next pixel of the word
    bne $pixels, $zero, draw_pixel_word

end_draw_pixel_word:

    addi $imgpos, $imgpos, 4  # Next pixel of the image
    bne $imgpos, $endlinepos, draw_image_line  # Draw pixels on the next word

end_draw_image_line:

    addi $vgapos, $vgapos, 4*(kScreenWidth-kImageWidth)  # Draw the next line
    bne $imgpos, $endimgpos, draw_whole_image
