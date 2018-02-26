#
#  Pong.
#    https://github.com/dbader/potatoes/blob/master/src/apps/pong.c
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "main.s"
.set noreorder


# Variables and definitions
.include "defs.s"
.include "variables.s"


# Application options
.set kFramePerSecond, 30

.include "debug.s"

.text

# Entry point of the application.
main:

    lui $vga, 8

    li $tmp, (kClockFrequency / kFramePerSecond)
    sw $tmp, kTimerPeriodAddress($zero)  # Set timer period

    li $tmp, 200
    sw $tmp, kTimerThresoldAddress($zero)  # Set timer thresold

    .include "update/init.s"
    .file "main.s"

    # Fall through 'cleanup'



# First, clean the whole screen
cleanup:

    li $color, kBackgroundColor

    move $vgapos, $vga
    li $vgaend, (4 * kScreenWidth * kScreenHeight)
    add $vgaend, $vgaend, $vga

cleanup_loop:  # Loop: clean the screen pixel by pixel

    sw $color, ($vgapos)

    addi $vgapos, $vgapos, 4
    bne $vgapos, $vgaend, cleanup_loop

end_cleanup_loop:

    # Fall through 'main_loop'



# Main application loop
main_loop:

wait_for_timer:  # Loop: wait for the next frame

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, wait_for_timer

end_wait_for_timer:

    .include "render/clear.s"

    .include "update/paddles.s"
    .include "update/ball.s"

    .include "render/paddles.s"
    .include "render/ball.s"

    j wait_for_timer



# Libraries
.include "render/gfx.s"
