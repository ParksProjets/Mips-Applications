#
#  Debug module.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.set kDebugLedAddress, 0x4000
.set kDebugBtnAddress, 0x4004
.set kDebuggerAddress, 0x5000


# Set a value of the leds from a register
.macro ledreg reg
    sw \reg, kDebugLedAddress($zero)
.endm


# Set a value of the leds from an absolute expr
.macro ledimm val=0b1111
    .set noat
    li $at, \val
    ledreg $at
    .set at
.endm


# Pause the program
.macro pause
    j .
.endm


# Wait for a button
.macro waitbtn
    .set noat
    lw $at, kDebugBtnAddress($zero)
    bne $at, $zero, (. - 4)  # Don't use a label to avoid multiple definition
    lw $at, kDebugBtnAddress($zero)
    beq $at, $zero, (. - 4)  # Idem
    .set at
.endm


# Print a register on the debug peripheral
.macro printreg reg, port=0
    sw \reg, (kDebuggerAddress + \port*4)($zero)
.endm


# Print an absolute expr on the debug peripheral
.macro printimm val, port=0
    .set noat
    li $at, \val
    printreg $at, \port
    .set at
.endm


# Print a new line
.macro println
    sw $zero, (kDebuggerAddress + 30*4)($zero)
.endm
