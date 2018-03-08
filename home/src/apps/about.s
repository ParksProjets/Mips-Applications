#
#  About information page.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "apps/about.s"


# Configuration
.set kAboutBackgroundColor, 0xFFD6


# About information page
.global about_page
about_page:

    # Clear the screen in blue
    li $color, (kAboutBackgroundColor)
    jal clear_screen

    j .
