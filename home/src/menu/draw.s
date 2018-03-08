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



# Draw the bottom images
draw_bottom_images:

    li $y, (220 * 4)
    li $x, (20 * 4)

    li $width, (iBottomImgWidth * 4)
    li $i, (kBottomApps * 4)

draw_bottom_img_i:

    lw $imgstart, (iBottomImages - 4)($i)
    addi $imgend, $imgstart, (iBottomImgWidth * iBottomImgHeight * 2)

    jal draw_image
    addi $x, (kBottomBtnSpace * 4)

    addi $i, -4
    bne $i, $zero, draw_bottom_img_i  # Draw the next image



# Draw the bottom texts
draw_bottom_texts:

    li $y, (223 * 4)
    li $x, ((20 + iBottomImgWidth + 4) * 4)

    li $i, (kBottomApps * 4)

draw_bottom_text_i:

    lw $text, (tBottomTexts - 4)($i)

    jal print_text
    addi $x, (kBottomBtnSpace * 4)

    addi $i, -4
    bne $i, $zero, draw_bottom_text_i  # Draw the next text
