#
#  Draw the menu.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "menu/draw.s"


# Draw the menu.
draw_menu:

    li $i, kNumberOfApps

draw_app_i: # Draw the i-th app

    # TODO: set 'print_text' arguments
    jal print_text

    addi $i, -1
    bne $i, $zero, draw_app_i  # Draw the next app
