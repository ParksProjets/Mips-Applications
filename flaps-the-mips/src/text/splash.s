#
#  The first screen.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "text/splash.s"


# These data contain the text of the splash-screen.
# This project is open-source, so you are free to change the splash screen (as long as you
# follow the terms of the MIT license). But having your name at the beginning of the game
# must be earned, you will have to find out how to do it yourself.
.data

.set iSplashWidth, 185
.set iSplashHeight, 19
.set iSplashNumWords, 228

.set kSplashPosX, ((kSceneWidth / 2) - 95)
.set kSplashPosY, 100

iSplashData: .word 0xFFFFF55F, 0xFD5555FF, 0xFFFFFFFF, 0xFFFFFFFF, 0x55FFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFF55FF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x0003D57F, 0xFFFFDAA7, 0xFDA9A9FF, 0xFFFFFFFF, 0xFFFFFFFF, 0xAA7FFFFF, 0xFFFFFFFD, 0xFFFFFFFF, 0xFFFF69FF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x0003DA7F, 0xFFFF6AA9, 0xFDA9A9FF, 0xFFFFFFFF, 0xFFFFFFFF, 0xAA9FFFFF, 0xFFFFFFF6, 0xFFFFFFFF, 0xFFFF69FF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x0003DA7F, 0xFFFF6AA9, 0xFDA9A9FF, 0xFFFFFFFF, 0xFFFFFFFF, 0xAA9FFFFF, 0xFFFFFFF6, 0xFFFFFFFF, 0xFFFF69FF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x0003DA7F, 0xFFFF6AA9, 0xFDA9A955, 0xFFFFFFFF, 0xFFFFFFFF, 0xAA9FFFFF, 0xFFFFFFF6, 0xFFFFFFFF, 0xFFF5695F, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0x00015A57, 0x55556AA9, 0xFDA9A9A9, 0xF5555555, 0x57FF57F5, 0xAA9FFFF5, 0x57FF57F6, 0x57FF57FF, 0xFFF6AA95, 0x57FF555F, 0xF5FD55FD, 0xD5FD55FF, 0x0001AAA7, 0xA9A955A9, 0x7DA9A9A9, 0x76A6A6AA, 0xA9FDA9DA, 0x5A9FFFF6, 0xA9FDA9F5, 0xA9FDA9FD, 0xFFF6AA96, 0xA9FDAA9F, 0xDA7DAA7D, 0x6A7DAA7F, 0x0001AAA7, 0xA9A969A9, 0x9DA9A955, 0x96A6A6AA, 0xAA76AA6A, 0x9A9FFFF6, 0xAA76AA76, 0xAA76AA56, 0xFFF56956, 0xAA76AA9F, 0x6A9DAA9D, 0xAA9DAA9F, 0x00015A55, 0xA9A96AA9, 0xA5A9A9A9, 0xA6A6A6AA, 0x9A9AAA6A, 0xAA9FFFF6, 0xAA9AAA96, 0x9A9AAA9A, 0xFFFF69F6, 0x5A9AAA9F, 0xAAA5A6A5, 0xAAA5A6A5, 0x0003DA76, 0xA9A96AA9, 0xA5A9A9A9, 0xA6A6A6A6, 0xAA9AAA6A, 0xAA9FFFF6, 0xAA9A9A96, 0xAA9AAA9A, 0xFFFF69F6, 0x5A9A9A9F, 0x56A5AAA7, 0xAAA5AAA5, 0x0003DA76, 0xA9A96AA9, 0xA5A9A9A9, 0xA6A6A6A6, 0xAA9A9A66, 0xAA9FFFF6, 0x9A9A9A96, 0xAA9A9A9A, 0xFFFF69F6, 0xDA9A9A9F, 0xAAA5AAA7, 0xA6A5AAA5, 0x0003DA76, 0xAAA96AA9, 0xA5A9A9A9, 0xA6AAA6A6, 0x6A9A9AA6, 0xAA9FFFF5, 0x9A9A9A96, 0x6A9A9A9A, 0xFFFF69F5, 0xDA9A9A9F, 0xA9555AA7, 0xA6A556A5, 0x0003DA76, 0xAAA96AA9, 0xA5A9A9A9, 0xA6AAA6AA, 0xAA9A9AA6, 0xAA9FFFF6, 0x9A9AAA96, 0xAA9A9A9A, 0xFFFF69F6, 0xDA9AAA9F, 0xAAA5AAA7, 0xA6A5AAA5, 0x0003DA76, 0x6AA7DAA7, 0x9DA9A9A9, 0xA5AA96AA, 0xAA5A9AA6, 0xAA7FFFF6, 0x9A96AA7D, 0xAA5A9A9A, 0xFFFF69F6, 0xDA96AA9F, 0x6A9DAA9F, 0xA6A5AA9F, 0x0003DA76, 0xDA9FF69F, 0x7DA9A9A9, 0xA76A76AA, 0xA9DA9AA6, 0x69FFFFF6, 0x9A9DA9FF, 0xA9DA9A9A, 0xFFFF69F6, 0xDA9DAA9F, 0xDA7DAA7F, 0xA6A5AA7F, 0x0003DA76, 0xF57FFD7F, 0xFD555555, 0x57D5F555, 0x57D55555, 0xD7FFFFF5, 0x555F57FF, 0x57D55555, 0xFFFF55F5, 0xD55F5A9F, 0xF5FD55FF, 0x555555FF, 0x0003D575, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFDA9F, 0xFFFFFFFF, 0xFFFFFFFF, 0x0003FFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFDA9F, 0xFFFFFFFF, 0xFFFFFFFF, 0x0003FFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFD55F, 0xFFFFFFFF, 0xFFFFFFFF, 0x0003FFFF



.text

# Draw the splash-screen.
draw_splash:


# Clean the screen first.
splash_cleanup:

    li $color, (kBackgroundColor)
    li $vgapos, (kVgaAddress + (4 * kSceneWidth * kScreenHeight))

splash_cleanup_loop:  # Loop: clean the screen pixel by pixel

    sw $color, -4($vgapos)

    addi $vgapos, -4
    bne $vgapos, $vga, splash_cleanup_loop  # Draw the next pixel.



# Draw the splash text
draw_splash_text:

    la $spriteaddr, iSplashData  # Get splash-screen start and end addresses.
    addi $spritetail, $spriteaddr, (iSplashNumWords * 4)

    li $width, (iSplashWidth * 4)  # Width of the image (4 bytes aligned).
    li $tmp, (((iSplashWidth / 16) + 1) * 4)  # Width of a line (4 bytes aligned).

    li $vgapos, (kVgaAddress + (kSceneWidth * kSplashPosY + kSplashPosX) * 4)
    jal draw_image  # Draw the image.



# Wait for the timer
draw_splash_wait:

    li $i, (kFramesPerSecond * 2)  # Wait for 2s (2 * number of fps).

draw_splash_wait_loop:

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, draw_splash_wait_loop  # Wait for a frame.

    addi $i, -1  # Decrement the timer.
    bne $i, $zero, draw_splash_wait_loop  # If the timer is not 0: wait for next frame.
