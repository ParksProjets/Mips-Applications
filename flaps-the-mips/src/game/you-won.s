#
#  When the player won the game (score = 100)
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "you-won.s"


# When someone won (score = 100)
you_won:

    li $vgaendpos, (kVgaAddress + (kSceneWidth * kScreenHeight * 4))
    li $endaddr, (kNumberOfColors * 4)

    li $tmp, (kClockFrequency / 5)
    sw $tmp, kTimerPeriodAddress($zero)

you_won_start:

    li $addr, 0

you_won_loop:

    lw $tmp, kTimerReadAddress($zero)
    bne $tmp, $zero, you_won_loop

    move $vgapos, $vga
    lw $pixel, dSomeColor($addr)

you_won_loop2:

    sw $pixel, 0($vgapos)
    sw $pixel, 4($vgapos)
    sw $pixel, 8($vgapos)
    sw $pixel, 12($vgapos)

    addi $vgapos, 16
    bne $vgapos, $vgaendpos, you_won_loop2

    addi $addr, 4
    bne $addr, $endaddr, you_won_loop
    j you_won_start
