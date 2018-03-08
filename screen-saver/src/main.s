#
#  Screen Saver for MIPS
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "main.s"
.set noreorder


# Include converted image
.include "image.s"

# Defintions
.include "defs.s"


# Application options
.set kFramePerSecond, 30
.set kStartPosX, 60
.set kStartPosY, 40
.set kImageSpeed, 8



.text

# Safe entry point (set $savedra)
safe_main:

    li $savedra, 0

# Entry point of the application.
main:

    lui $vga, 8

    li $tmp, (kClockFrequency / kFramePerSecond)
    sw $tmp, kTimerPeriodAddress($zero)  # Set timer period

    li $tmp, 200
    sw $tmp, kTimerThresoldAddress($zero)  # Set timer thresold

    lw $lastbtn, kSwitchesAddress($zero)  # Load current btn state
    srl $tmp, 16

    li $x, (4 * kStartPosX)  # Start positions
    li $y, (4 * kStartPosY)

    li $dx, kImageSpeed  # Default speed
    li $dy, kImageSpeed

    move $lastvgapos, $vga  # No last image: clear (0, 0)
    addi $vgapos, $vga, (320 * 4)

    li $endimgpos, (4 * kImageWidth * kImageHeight / kImagePixelsPerWord)
    li $endwidth, (4 * (kScreenWidth - kImageWidth))
    li $endheight, (4 * (kScreenHeight - kImageHeight))



# First, cleaan the whole creen
cleanup:

    move $tmp, $vga
    li $tmp2, (4 * kScreenWidth * kScreenHeight)
    add $tmp2, $tmp2, $vga

cleanup_loop:  # Loop: clean the screen pixel by pixel

    sw $zero, 0($tmp)

    addi $tmp, $tmp, 4
    bne $tmp, $tmp2, cleanup_loop



# Main application loop
main_loop:

wait_for_timer:  # Loop: wait for the next frame

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, wait_for_timer

end_wait_for_timer:    

    .include "update.s"
    .include "render.s"

    move $tmp, $lastbtn

    lw $lastbtn, kSwitchesAddress($zero)  # Load current btn state
    srl $lastbtn, 16

    bne $tmp, $zero, main_loop  # Prevent unwanted stop
    beq $lastbtn, $zero, main_loop  # Stop when a button is pressed

    jr $savedra



# Libraries
.include "gfx.s"
