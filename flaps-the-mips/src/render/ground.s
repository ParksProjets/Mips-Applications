#
#  Render the ground.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render/ground.s"


# Render the ground
render_ground:

    lw $posx, dGroundPos($zero)

    li $vgapos, (kVgaAddress + (kSceneWith * kSceneHeight * 4))
    la $spritestart, sGroundData

    addi $spritetail, $spritestart, (sGroundWidth * sGroundHeight * 4)


draw_ground_loop: # Loop: the ground line by line

draw_ground_left: # Draw the lefpart of the ground

    add $spriteaddr, $spritestart, $posx
    jal draw_sprite_line

    addi $vgaendpos, $vgapos, (sGroundWidth * 30 * 4)

draw_ground_center: # Loop: draw the center part of the ground

    jal draw_sprite_line_safe
    bne $vgapos, $vgaendpos, draw_ground_center
