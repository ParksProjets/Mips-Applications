#
#  Screen Saver for MIPS
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "main.s"
.set noreorder


# Include converted image
.include "image.s"


# Screen size
.set kScreenWidth, 320
.set kScreenHeight, 240

# Hardware information
.set kClockFrequency, 50000000

# Peripheral addresses
.set kTimerReadAddress, 0x4010
.set kTimerPeriodAddress, 0x4010
.set kTimerThresoldAddress, 0x4014
.set kSwitchesAddress, 0x4004


# Register aliases
.set $vga, $16
.set $x, $17
.set $y, $18
.set $dx, $19
.set $dy, $20

.set $endimgpos, $4
.set $endwidth, $5
.set $endheight, $6

.set $vgapos, $8
.set $lastvgapos, $9
.set $pixels, $10
.set $px, $11
.set $vgapos2, $11
.set $index, $12
.set $lastvgapos2, $12
.set $imgpos, $13
.set $clearstep, $13
.set $endlinepos, $14

.set $tmp, $24
.set $tmp2, $25


# Application options
.set kFramePerSecond, 30
.set kStartPosX, 60
.set kStartPosY, 40
.set kImageSpeed, 8



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
