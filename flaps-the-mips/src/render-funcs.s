#
#  Function for rendering the game.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render-funcs.s"


# Draw a sprite on the screen.
# Arguments: *$spritestart, *$vgapos, $width, *$height
# Used: $j
draw_sprite_fixed:

    mv $savedra, $ra

    li $j, 0
    add $width, $width, $x

draw_sprite_fixed_loop:

    jal draw_sprite_line
    addi $vgapos, $vgapos, (kSceneWith * 4)

    bne $TODO, $TODO, draw_sprite_fixed_loop
    j $savedra  # Function return




# Draw a line of a sprite.
# Arguments: $spritestart, $spriteend, *$vgapos
# Used: $pixel, $spriteaddr
draw_sprite_line_safe:

    move $spriteaddr, $spritestart

# Same but *$spriteaddr as argument.
draw_sprite_line:

draw_sprite_line_loop: # Loop: TODO

    lw $pixel, 0($spriteaddr)  # Load two pixels
    sw $pixel, 0($vgapos)  # Draw p+0 (on LSB)

    srl $pixel, $pixel, 16  # Get second color in MSB
    sw $pixel, 4($vgapos)  # Draw p+1

    addi $vgapos, $vgapos, 8
    addi $spriteaddr, $spriteaddr, 4
    bne $spriteaddr, $spriteend, draw_sprite_line_loop

    jr $ra  # Function return
