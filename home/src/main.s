#
#  Home menu
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "main.s"
.set noreorder


# Definitions and memory data.
.include "defs.s"
.include "variables.s"

# Data
.include "gfx/images-data.s"
.include "text/font-data.s"
.include "text/text-data.s"
.include "menu/apps-data.s"

.include "debug.s"


# Config
.set kFramePerSecond, 30


.text

# Entry point of the application.
.global home_menu
home_menu:

main:

    lui $vga, 8

    li $tmp, (kClockFrequency / kFramePerSecond)
    sw $tmp, kTimerPeriodAddress($zero)  # Set timer period

    li $tmp, 200
    sw $tmp, kTimerThresoldAddress($zero)  # Set timer thresold

    # Fall through 'cleanup'



# First, cleaan the whole screen
cleanup:

    li $pixel, (kBackgroundColor)

    move $tmp, $vga
    li $tmp2, (4 * kScreenWidth * kScreenHeight)
    add $tmp2, $tmp2, $vga

cleanup_loop:  # Loop: clean the screen pixel by pixel

    sw $pixel, ($tmp)

    addi $tmp, $tmp, 4
    bne $tmp, $tmp2, cleanup_loop

end_cleanup_loop:

    .include "menu/draw.s"

    li $cursorpos, 0
    li $prevcurpos, 1
    jal render_cursor_menu

    # Fall through 'main_loop'



# Main application loop
main_loop:

wait_for_timer:  # Loop: wait for the next frame

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, wait_for_timer

end_wait_for_timer:

    .include "menu/menu.s"



# Libraries
.include "gfx/gfx.s"
.include "gfx/image.s"
.include "gfx/blue-screen.s"
.include "text/text.s"
