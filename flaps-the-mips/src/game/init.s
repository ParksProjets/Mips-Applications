#
#  Initialize the game.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "game/init.s"


# Initialize the game.
init_game:

    li $gameended, 0
    li $gamestarted, 0


init_bird:

    li $birdx, (160 * 4)
    li $birdy, (100 * 4)


init_pipes: # The first 3 pipes are not random.

    li $tmp, (320 + 114)*4
    sw $tmp, (dPipes + 0)($zero)  # First pipe x
    li $tmp, 60*4
    sw $tmp, (dPipes + 4)($zero)  # First pipe y

    li $tmp, (320 + 230)*4
    sw $tmp, (dPipes + 8)($zero)  # First pipe x
    li $tmp, 105*4
    sw $tmp, (dPipes + 12)($zero)  # First pipe y

    li $tmp, (320 + 344)*4
    sw $tmp, (dPipes + 16)($zero)  # First pipe x
    li $tmp, 35*4
    sw $tmp, (dPipes + 20)($zero)  # First pipe y



# Clean the screen
cleanup:

    li $vgapos, (kVgaAddress + (kSceneWith * kScreenHeight * 4))
    li $vgaendpos, (kVgaAddress + (kSceneWith * kSceneHeight * 4))

    li $pixel, (kBottomColor)

cleanup_loop:  # Loop: clean the screen pixel by pixel

    sw $pixel, -4($vgapos)

    addi $vgapos, -4
    bne $vgapos, $vgaendpos, cleanup_loop

    beq $vgapos, $vga, end_cleanup_loop  # Draw the second color

    li $vgaendpos, (kVgaAddress + (kSceneWith * kScreenHeight * 4))
    move $vgaendpos, $vga

    li $pixel, (kBackgroundColor)
    j cleanup_loop

end_cleanup_loop:
