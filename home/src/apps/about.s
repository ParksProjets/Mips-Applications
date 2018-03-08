#
#  About information page.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "apps/about.s"


# Configuration
.set kAboutBackgroundColor, 0xFFD6
.set kAboutTextColor, 0x1995
.set kAboutTextColor2, 0x73AE


# About information page
.global about_page
about_page:

    # Clear the screen in blue
    li $color, (kAboutBackgroundColor)
    jal clear_screen


    # Main text
    li $color, (kAboutTextColor)

    li $y, (55 * 4)
    li $x, (30 * 4)

    la $text, (tAboutData)
    jal print_multiline_text


    # Quit button
    li $color, (kAboutTextColor2)

    li $y, (190 * 4)
    li $x, (165 * 4)

    la $text, (tAboutQuitData)
    jal print_text


about_page_wait1: # Wait for all buttons up

    lw $tmp, kDebugBtnAddress($zero)
    srl $tmp, 16
    bne $tmp, $zero, about_page_wait1

about_page_wait2: # Wait for a button down

    lw $tmp, kDebugBtnAddress($zero)
    srl $tmp, 16
    beq $tmp, $zero, about_page_wait2

    j home_menu
