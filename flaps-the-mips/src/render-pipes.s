#
#  Render the pipes.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render-pipes.s"


render_pipe_i:  # Render the i-th pipe

    addi $tmp, $pipex, (-kSceneWith * 4)  # Don't render a pipe that is not on the screen
    bgez $tmp, render_pipe_i_end

    la $spritestart, sPipeBodyData  # TODO: move before loop

    la $spriteend, (sPipeBodyData + sPipeBodyWidth*2)  # Default sprite width: full sprite
    li $width, (sPipeBodyWidth * 4)

    addi $tmp2, $tmp, (sPipeBodyWidth * 4)
    blez $tmp2, draw_pipe_i_top  # If the pipe is on the right: crop the sprite

    sub $width, $width, $tmp2
    srl $tmp2, 1
    sub $spriteend, $spriteend, $tmp2



draw_pipe_i_top: # Draw the top part of the pipe

    add $vgapos, $vga, $pipex
    addi $i, $pipey, -10*4

draw_pipe_i_top_loop: # Loop: repeat the sprite

    jal draw_sprite_line_safe

    addi $vgapos, (4 * kSceneWith)  # Draw next line
    sub $vgapos, $vgapos, $width
    addi $i, -4
    bne $i, $zero, draw_pipe_i_top_loop

    # TODO: save $vgapos
    move $savedvgapos, $vgapos



draw_pipe_i_bottom: # Draw the bottom part of the pipe

    li $tmp, (kSceneWith * 57 * 4)  # TODO: move before loop
    add $vgapos, $vgapos, $tmp

    addi $i, $pipey, -((kSceneHeight - 48) * 4)

draw_pipe_i_bottom_loop: # Loop: repeat the sprite

    jal draw_sprite_line_safe

    addi $vgapos, (4 * kSceneWith)  # Draw next line
    sub $vgapos, $vgapos, $width
    addi $i, 4
    bne $i, $zero, draw_pipe_i_bottom_loop





render_pipe_ends: # Render the end parts of the pipes

    move $vgapos, $savedvgapos

    la $spritestart, sPipeEndData  # Load the 'pipe-end' sprite
    la $spriteend, (sPipeEndData + sPipeEndWidth*2)

    addi $tmp, $width, (-sPipeEndWidth * 4)
    beq $tmp, $zero, draw_pipe_i_topend  # If the pipe is on the right: crop the sprite

    sra $tmp, 1
    add $spriteend, $spriteend, $tmp



draw_pipe_i_topend: # Draw the end part of the top pipe

    la $i, (sPipeEndData + (sPipeEndHeight * sPipeEndWidth * 2))  # TODO: rename $i

draw_pipe_i_topend_loop: # Loop: TODO

    move $spriteaddr, $spritestart
    jal draw_sprite_line

    addi $vgapos, (4 * kSceneWith)  # Draw next line
    sub $vgapos, $vgapos, $width

    addi $spriteend, $spriteend, (sPipeEndWidth * 2)
    addi $spritestart, $spritestart, (sPipeEndWidth * 2)

    bne $spritestart, $i, draw_pipe_i_topend_loop



draw_pipe_i_bottomend: # Draw the end part of the top pipe



    

draw_pipe_i_bottomend_loop: # Loop: TODO

    move $spriteaddr, $spritestart
    jal draw_sprite_line

    addi $vgapos, (-4 * kSceneWith)  # Draw next line
    sub $vgapos, $vgapos, $width

    addi $spriteend, $spriteend, (sPipeEndWidth * 2)
    addi $spritestart, $spritestart, (sPipeEndWidth * 2)

    bne $spritestart, $i, draw_pipe_i_bottomend_loop



render_pipe_i_end:

