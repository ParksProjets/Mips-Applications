#
#  Show a blue-screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "apps/blue-screen.s"


# Configuration
.set kBlueBackgroundColor, 0x0015
.set kGrayBackgroundColor, 0xB574


# Do a blue screen and halt the system
.global blue_screen
blue_screen:

.global lock_system
lock_system:


    # Clear the screen in blue
    li $color, (kBlueBackgroundColor)
    jal clear_screen

    printimm 45

    # li $y, (50 * 4)
    # li $x, (20 * 4)
    # li $color, (kGrayBackgroundColor)

    # li $width, (50 * 4)
    # li $width, 12
    # jal draw_rectangle  # Draw 'Windows' rectangle


    li $color, 0xFFFF  # FIX ME

    li $y, (50 * 4)
    li $x, (20 * 4)

    la $text, (tBlueScreenData)
    jal print_multiline_text  # Print error message


    # li $y, (50 * 4)
    # li $x, (20 * 4)

    # la $text, (tWindowData)
    # jal print_multiline_text  # Print error message


    j .  # Now halt
