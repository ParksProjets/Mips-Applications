#
#  Update the screen saver position.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update.s"

.set kSwitchMask, ((1 << 4) - 1)  # Mask for getting the switches


# Update the screen saver position.
update:

    lw $tmp, kSwitchesAddress($zero)  # If a switch is enabled: don't move
    andi $tmp, $tmp, kSwitchMask
    bne $tmp, $zero, end_update

    beq $x, $zero, update_dx  # Update dx if needed
    bne $x, $endwidth, after_update_dx

update_dx:

    sub $dx, $zero, $dx  # dx = -dx

after_update_dx:

    beq $y, $zero, update_dy  # Update dy if needed
    bne $y, $endheight, after_update_dy

update_dy:

    sub $dy, $zero, $dy  # dy = -dy

after_update_dy:

    add $x, $x, $dx  # Update x
    add $y, $y, $dy  # Update y

end_update:

    # Fall through 'draw'
