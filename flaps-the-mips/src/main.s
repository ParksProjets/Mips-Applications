#
#  Flappy Bird
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "main.s"

.set noreorder

.include "variables.s"
.include "defs.s"

# Include sprite data
.include "sprites-data.s"


# Application options
.set kFramePerSecond, 30


.include "debug.s"

.text

# Entry point.
main:

    lui $vga, 8  # VGA memory

    li $tmp, (kClockFrequency / kFramePerSecond)
    sw $tmp, kTimerPeriodAddress($zero)  # Set timer period

    li $tmp, 200
    sw $tmp, kTimerThresoldAddress($zero)  # Set timer thresold

    # Fall through 'init'



# Init the game
init:

    li $tmp, 50
    sw $tmp, pipes($zero)

init_pipes: # The first 3 pipes are not random.

    li $tmp, (320 + 114)*4
    sw $tmp, (pipes + 0)($zero)  # First pipe x
    li $tmp, 60*4
    sw $tmp, (pipes + 4)($zero)  # First pipe y

    li $tmp, (320 + 230)*4
    sw $tmp, (pipes + 8)($zero)  # First pipe x
    li $tmp, 105*4
    sw $tmp, (pipes + 12)($zero)  # First pipe y

    li $tmp, (320 + 344)*4
    sw $tmp, (pipes + 16)($zero)  # First pipe x
    li $tmp, 35*4
    sw $tmp, (pipes + 20)($zero)  # First pipe y

    # Fall through 'main_loop'



# Clean the screen
cleanup:

    move $tmp, $vga
    li $pixel, kBackgroundColor

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

    .include "update-pipes.s"
    .file "main.s"



# Libraries
.include "render-funcs.s"
