#
#  Home menu
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "main.s"
.set noreorder



.text

# Entry point of the application.
main:

    lui $vga, 8

    li $tmp, (kClockFrequency / kFramePerSecond)
    sw $tmp, kTimerPeriodAddress($zero)  # Set timer period

    li $tmp, 200
    sw $tmp, kTimerThresoldAddress($zero)  # Set timer thresold

    li $x, (4 * kStartPosX)  # Start positions
    li $y, (4 * kStartPosY)

    li $dx, kImageSpeed  # Default speed
    li $dy, kImageSpeed

    move $lastvgapos, $vga  # No last image: clear (0, 0)
    addi $vgapos, $vga, (320 * 4)

    li $endimgpos, (4 * kImageWidth * kImageHeight / kImagePixelsPerWord)
    li $endwidth, (4 * (kScreenWidth - kImageWidth))
    li $endheight, (4 * (kScreenHeight - kImageHeight))

    # Fall through 'cleanup'



# First, cleaan the whole creen
cleanup:

    move $tmp, $vga
    li $tmp2, (4 * kScreenWidth * kScreenHeight)
    add $tmp2, $tmp2, $vga

cleanup_loop:  # Loop: clean the screen pixel by pixel

    sw $zero, 0($tmp)

    addi $tmp, $tmp, 4
    bne $tmp, $tmp2, cleanup_loop

end_cleanup_loop:

    # Fall through 'main_loop'



# Main application loop
main_loop:

wait_for_timer:  # Loop: wait for the next frame

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, wait_for_timer

end_wait_for_timer:

    .include "update.s"
    .include "render.s"
