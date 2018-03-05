#
#  Flappy Bird
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "main.s"
.set noreorder


# Memory and definitions.
.include "variables.s"
.include "defs.s"

# Generated data
.include "render/sprites-data.s"


# Application config
.set kFramePerSecond, 30


.include "debug.s"

.text


# For exporting this game
.global flaps_the_mips_main
flaps_the_mips_main:

# Entry point.
main:

    lui $vga, 8  # VGA memory

    li $tmp, (kClockFrequency / kFramePerSecond)
    sw $tmp, kTimerPeriodAddress($zero)  # Set timer period

    li $tmp, 200
    sw $tmp, kTimerThresoldAddress($zero)  # Set timer thresold


    .include "game/init.s"
    .file "main.s"

    # Fall through 'cleanup'



# Clean the screen
cleanup:

    move $tmp, $vga
    li $pixel, (kBackgroundColor)

    li $tmp2, (4 * 320 * 240)  # TODO: constants
    add $tmp2, $tmp2, $vga

cleanup_loop:  # Loop: clean the screen pixel by pixel

    sw $pixel, 0($tmp)

    addi $tmp, $tmp, 4
    bne $tmp, $tmp2, cleanup_loop

end_cleanup_loop:

    # Fall through 'main_loop'



# Main game loop
main_loop:

wait_for_timer:  # Loop: wait for the next frame

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, wait_for_timer

end_wait_for_timer:

    .include "update/pipes.s"

    .include "update/bird.s"
    .include "render/bird.s"

    j main_loop



# Libraries
.include "render/gfx-module.s"
