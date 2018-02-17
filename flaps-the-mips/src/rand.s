#
#  8 bit random number generator.
#
#  I use this algorithm:
#     https://github.com/edrosten/8bit_rng/blob/master/rng-4261412736.c
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "rand.s"


.data

# The state of the RNG is stored on only one word.
# Values (1B each): x | y | z | a
rngvalues: .word 0x00000001



.text

# Generate a 8 bits random number.
# Used: $rngvals, $rngx, $rnga, $rngt
# Out: $rngout
rand:

    lw $rngvals, rngvalues($zero)

    srl $rngt, $rngvals, 16  # t = x
    sll $rngx, $rngt, 4  # x << 4
    xor $rngt, $rngt, $rngx  # t ^= (x << 4)

    andi $rnga, $rngvals, 0xFF  # a = z
    sll $rngvals, $rngvals, 8  # x = y, y = z, z = a

    xor $rngout, $rnga, $rngt  # out = z ^ t

    srl $rnga, $rnga, 1  # z >> 1
    xor $rngout, $rngout, $rnga  # out ^= (z >> 1)

    sll $rngt, $rngt, 1  # t << 1
    xor $rngout, $rnga, $rngt  # out ^= (t << 1)

    or $rngvals, $rngvals, $rngout  # Store 'a' back to $rngvals
    sw $rngvals, rngvalues($zero)

    jal $ra  # ?
