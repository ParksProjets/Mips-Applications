#
#  Function for rendering the game.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render/gfx-module.s"


# Draw a sprite on the screen.
# Arguments: *$spriteaddr, $spritetail, $vgapos, $width
# Used: $tmp
draw_sprite_fixed:

    move $savedra, $ra
    srl $tmp, $width, 1

draw_sprite_fixed_loop:

    add $spriteend, $spriteaddr, $tmp
    jal draw_sprite_line

    addi $vgapos, $vgapos, (kSceneWith * 4)
    sub $vgapos, $width

    bne $spriteaddr, $spritetail, draw_sprite_fixed_loop
    j $savedra  # Function return




# Draw a line of a sprite.
# Arguments: $spritestart, $spriteend, *$vgapos
# Used: $pixel, $spriteaddr
draw_sprite_line_safe:

    move $spriteaddr, $spritestart

# Same but *$spriteaddr as argument.
draw_sprite_line:

draw_sprite_line_loop: # Loop: TODO

    lw $pixel, ($spriteaddr)  # Load two pixels

    beq $pixel, $zero, draw_sl_transparent1
    sw $pixel, ($vgapos)  # Draw p+0 (on LSB)

draw_sl_transparent1:

    srl $pixel, $pixel, 16  # Get second color in MSB

    beq $pixel, $zero, draw_sl_transparent2
    sw $pixel, 4($vgapos)  # Draw p+1

draw_sl_transparent2:

    addi $vgapos, $vgapos, 8
    addi $spriteaddr, $spriteaddr, 4
    bne $spriteaddr, $spriteend, draw_sprite_line_loop

    jr $ra  # Function return
