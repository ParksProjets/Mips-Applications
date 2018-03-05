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
    li $color, (kMenuTextColor)

    li $x, (30 * 4)
    li $y, (20 * 4)

draw_app_i: # Draw the i-th app

    lw $text, (kAppTexts - 4)($i)
    jal print_text

    addi $y, (32 * 4)

    addi $i, -4
    bne $i, $zero, draw_app_i  # Draw the next app

    # Fall through 'draw_bottom_btns'



# Draw the bottom buttons
draw_bottom_btns:

    li $y, (220 * 4)

    la $imgstart, iLockData
    addi $imgend, $imgstart, (iLockWidth * iLockHeight * 2)
    li $width, (iLockWidth * 4)

    li $x, (20 * 4)
    jal draw_image

    la $imgstart, iPowerData
    addi $imgend, $imgstart, (iPowerWidth * iPowerHeight * 2)
    li $width, (iPowerWidth * 4)

    li $x, ((128 + 20) * 4)    
    jal draw_image


    li $y, (223 * 4)

    la $text, tLockData
    li $x, ((20 + iLockWidth + 4) * 4)
    jal print_text

    la $text, tPowerData
    li $x, ((128 + 20 + iPowerWidth + 4) * 4)
    jal print_text
