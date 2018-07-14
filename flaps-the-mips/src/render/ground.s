#
#  Render the ground.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render/ground.s"


# Render the ground.
render_ground:

    lw $groundpos, dGroundPos($zero)
    bne $gameended, $zero, after_render_ground  # If the game has ended.

    addi $groundpos, (-2 * 2)  # Texture is 2 byte aligned

    bgtz $groundpos, after_reset_ground_pos
    li $groundpos, (sGroundWidth * 2)


after_reset_ground_pos:

    addi $grounddiff, $groundpos, (-sGroundWidth * 2)

    li $vgapos, (kVgaAddress + (kSceneWidth * (kSceneHeight - 1) * 4))  # FIX ME
    la $spritestart, sGroundData

    addi $spritetail, $spritestart, (sGroundWidth * sGroundHeight * 2)


draw_ground_loop: # Loop: the ground line by line

    addi $spriteend, $spritestart, (sGroundWidth * 2)


draw_ground_left: # Draw the left part of the ground

    beq $groundpos, $zero, draw_ground_center

    sub $spriteaddr, $spritestart, $grounddiff
    jal draw_sprite_line

    addi $vgaendpos, $vgapos, (sGroundWidth * 31 * 4)

draw_ground_center: # Loop: draw the center part of the ground

    jal draw_sprite_line_safe
    bne $vgapos, $vgaendpos, draw_ground_center  # Draw the next 10 pixels

draw_ground_right: # Draw the left part of the ground

    beq $grounddiff, $zero, en_draw_ground_line

    sub $spriteend, $groundpos
    jal draw_sprite_line_safe


en_draw_ground_line:

    addi $spritestart, (sGroundWidth * 2)
    bne $spritestart, $spritetail, draw_ground_loop  # Draw the next line


after_render_ground:

    sw $groundpos, dGroundPos($zero)
