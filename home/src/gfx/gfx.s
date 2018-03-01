#
#  Graphics module.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "gfx.s"


# Draw a rectangle on the screen.
# Arguments: $color, $x, $y, $width, *$height
# Notes: $width is 4 bytes aligned but $height not.
draw_rectangle:

    sll $vgaend, $y, 8     # Calculate vgaend = 320 * y + x
    sll $tmp, $y, 6        #   320 = 2^8 + 2^6
    addu $tmp, $tmp, $x
    addu $tmp, $tmp, $vga
    addu $vgaend, $vgaend, $tmp

draw_rectangle_loop: # Loop: draw the rectange line by line

    add $vgapos, $vgaend, $width

draw_rectangle_line: # Loop: draw the line pixel by pixel

    sw $color, -1($vgapos)  # Draw the right pixel

    addi $vgapos, -4
    bne $vgapos, $vgaend, draw_rectangle_line  # Draw the next pixel

    addi $height, -1
    addi $vgaend, (4 * kScreenWidth)
    bne $height, $zero, draw_rectangle_loop  # Draw the next line

    jr $ra  # Function return
