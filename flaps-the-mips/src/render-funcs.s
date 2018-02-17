#
#  Function for rendering the game.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render-funcs.s"


# Calculate the position.
# Arguments: $x, $y
# Used: $tmp2
# Out: $vgapos
# calculate_vgapos:

#     # TODO: destruct $x and $y instead of using $tmp and $tmp2?

#     # TODO: bitand y for multiple of 4

#     sll $vgapos, $y, 8      # Calculate vgapos = 320 * y + x
#     sll $tmp2, $y, 6        #   320 = 2^8 + 2^6
#     addu $tmp2, $tmp2, $x
#     addu $tmp2, $tmp2, $vga
#     addu $vgapos, $vgapos, $tmp2

#     jr $ra  # Function return



# Draw a sprite on the screen.
# Arguments: $sprite_addr, *$vgapos, $width, *$height
# Used: $j
# draw_sprite_fixed:

#     mv $savedra, $ra

#     li $j, 0
#     add $width, $width, $x

# draw_sprite_fixed_loop:

#     jal draw_sprite_line
#     addi $vgapos, $vgapos, (kSceneWith * 4)

#     bne $TODO, $TODO, draw_sprite_fixed_loop
#     j $savedra  # Function return




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
