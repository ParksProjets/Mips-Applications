#
#  Show a blue-screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT


.set kBlueBackgroundColor, 0x0015
.set kGrayBackgroundColor, 0xB574


# Do a blue screen and halt the system
.global blue_screen
blue_screen:

.global lock_system
lock_system:


# Clear the screen in blue
blue_screen_clear:

    li $pixel, (kBlueBackgroundColor)

    move $tmp, $vga
    li $tmp2, (4 * kScreenWidth * kScreenHeight)
    add $tmp2, $tmp2, $vga

blue_screen_clear_loop:  # Loop: clean the screen pixel by pixel

    sw $pixel, ($tmp)

    addi $tmp, $tmp, 4
    bne $tmp, $tmp2, blue_screen_clear_loop


    # li $y, (50 * 4)
    # li $x, (20 * 4)
    # li $color, (kGrayBackgroundColor)

    # li $width, (50 * 4)
    # li $width, 12
    # jal draw_rectangle  # Draw 'Windows' rectangle


    li $y, (50 * 4)
    li $x, (20 * 4)

    la $text, (tBlueScreenData)
    jal print_multiline_text  # Print error message


    # li $y, (50 * 4)
    # li $x, (20 * 4)

    # la $text, (tWindowData)
    # jal print_multiline_text  # Print error message


    j .  # Now halt
