#
#  Draw an image on the screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "gfx/image.s"


# Draw an image on the screen.
# Arguments: $vgapos, *$imgstart, $width, $imgend
# Used: $vgaend
draw_image:

draw_image_loop: # Loop: draw the image line by line

    add $vgaend, $vgapos, $width

draw_image_line: # Loop: draw the line pixel by pixel

    lw $pixel, ($imgstart)  # Load two pixels
    sw $pixel, 0($vgapos)  # Draw p+0 (on LSB)

    srl $pixel, 16  # Get second color on MSB
    sw $pixel, 4($vgapos)  # Draw p+1

    addi $vgapos, 8
    addi $imgstart, 4
    bne $vgapos, $vgaend, draw_image_line  # Draw the next pixel

    addi $vgapos, (kScreenWidth * 4)
    bne $imgstart, $imgend, draw_image_loop  # Draw the next line

    jr $ra  # Function return
