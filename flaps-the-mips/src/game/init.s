#
#  Initialize the game.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "game/init.s"


# Initialize the game.
init_game:

    li $tmp, 50
    sw $tmp, dPipes($zero)


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
