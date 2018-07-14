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
.include "text/font-data.s"
.include "text/title-data.s"
.include "text/palette.s"


# Application config
.set kFramePerSecond, 30


.include "debug.s"

.text


# Entry point.
main:

    lui $vga, 8  # VGA memory

    li $tmp, (kClockFrequency / kFramePerSecond)
    sw $tmp, kTimerPeriodAddress($zero)  # Set timer period

    li $tmp, 10
    sw $tmp, kTimerThresoldAddress($zero)  # Set timer thresold

    .include "text/splash.s"

restart_game:

    .include "game/init.s"
    .file "main.s"



# Main game loop
main_loop:

wait_for_timer:  # Loop: wait for the next frame

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, wait_for_timer

end_wait_for_timer:

    jal rand  # Update the RNG: pipes will be more "random"

    .include "game/start.s"

    .include "render/ground.s"

    .include "render/clear.s"
    .include "update/pipes.s"

    .include "update/bird.s"
    .include "render/bird.s"

    beq $gamemustend, $zero, main_loop

    .include "game/end.s"



# Libraries
.include "render/gfx-module.s"
.include "update/rand.s"
.include "text/letter.s"
.include "text/image.s"
.include "text/score.s"
.include "text/title.s"
.include "game/you-won.s"
