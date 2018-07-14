#
#  8 bit random number generator.
#
#  I use this algorithm:
#     https://github.com/edrosten/8bit_rng/blob/master/rng-4261412736.c
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update/rand.s"


.section .zdata

# The state of the RNG is stored on only one word.
# Values (1B each): x | y | z | a
rngvalues: .word 0x12345678



.text

# Generate a 8 bits random number.
# Used: $rngvals, $rngx, $rnga, $rngt
# Out: $rngout
rand:

    lw $rngvals, rngvalues($zero)

    srl $rngt, $rngvals, 24  # t = x
    sll $rngx, $rngt, 4  # x << 4
    xor $rngt, $rngt, $rngx  # t ^= (x << 4)

    andi $rnga, $rngvals, 0xFF  # get a (z after)
    sll $rngvals, $rngvals, 8  # x = y, y = z, z = a

    xor $rngout, $rnga, $rngt  # out = z ^ t

    srl $rnga, $rnga, 1  # z >> 1
    xor $rngout, $rngout, $rnga  # out ^= (z >> 1)

    sll $rngt, $rngt, 1  # t << 1
    xor $rngout, $rngout, $rngt  # out ^= (t << 1)
    andi $rngout, $rngout, 0xFF  # out &= 0xFF (only 8 bits result)

    or $rngvals, $rngvals, $rngout  # Store 'a' back to $rngvals
    sw $rngvals, rngvalues($zero)

    jr $ra  # Function return
