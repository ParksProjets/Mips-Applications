#
#  Show a blue-screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "apps/blue-screen.s"


# Configuration
.set kBlueBackgroundColor, 0x0015
.set kGrayBackgroundColor, 0xB574

.set kBlueScreenTextColor, 0xFFFF



# Do a blue screen and halt the system
.global blue_screen
blue_screen:

    # Clear the screen in blue
    li $color, (kBlueBackgroundColor)
    jal clear_screen


    # Draw 'Windows' rectangle
    li $y, (40 * 4)
    li $x, (135 * 4)
    li $color, (kGrayBackgroundColor)

    li $width, (49 * 4)
    li $height, 14
    jal draw_rectangle


    # Print the error message
    li $color, (kBlueScreenTextColor)

    li $y, (70 * 4)
    li $x, (20 * 4)

    la $text, (tBlueScreenData)
    jal print_multiline_text


    # Print 'Windows' in the gray rectangle
    li $color, (kBlueBackgroundColor)

    li $y, ((40 + 3) * 4)
    li $x, ((135 + 6) * 4)

    la $text, (tWindowData)
    jal print_multiline_text  


    j .  # Now halt forever
