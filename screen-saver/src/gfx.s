#
#  Graphics module.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "gfx.s"


# Clear a rectangle
# Arguments: $vgapos, $lastvgapos, $clearstep
# Used: $tmp, $tmp2
clear_rect:

clear_rect_loop:  # Loop: clear the image line by line

    add $tmp, $lastvgapos, $clearstep
    add $tmp2, $lastvgapos, (4 * kScreenWidth)

clear_rect_line:  # Loop: clear the image pixel by pixel

    sw $zero, 0($lastvgapos)

    addi $lastvgapos, $lastvgapos, 4
    bne $lastvgapos, $tmp, clear_rect_line  # Clear the next pixel

end_clear_rect_line:

    move $lastvgapos, $tmp2  # Clear the next line
    bne $lastvgapos, $vgapos, clear_rect_loop

end_clear_rect_loop:

    jr $ra
