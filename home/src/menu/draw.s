#
#  Draw the menu.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "menu/draw.s"


# Config
.set kMenuTextColor, 0x0000


# Draw the menu.
draw_menu:

    li $i, (kNumberOfApps * 4)
    li $color, kMenuTextColor

    li $x, (30 * 4)
    li $y, (20 * 4)

draw_app_i: # Draw the i-th app

    lw $text, (kAppTexts - 4)($i)
    jal print_text

    addi $y, (32 * 4)

    addi $i, -4
    bne $i, $zero, draw_app_i  # Draw the next app
