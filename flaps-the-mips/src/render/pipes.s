#
#  Render the pipes.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render/pipes.s"


# Render the i-th pipe
render_pipe_i:

    sra $spritex, $pipex, 1  # spritex = pipex / 2, beacause sprites are 2 bytes aligned

    addi $tmp, $pipex, (-kSceneWith * 4)  # Don't render a pipe that is not on the screen
    bgez $tmp, render_pipe_i_end

    add $vgapos, $vga, $pipex




# Draw the body parts of the pipe
draw_pipe_body:

    li $newline, ((kSceneWith - sPipeBodyWidth) * 4)

    la $spritestart, sPipeBodyData
    addi $spriteend, $spritestart, (sPipeBodyWidth * 2)


    bgez $spritex, draw_pipe_body_notleft

    move $vgapos, $vga
    sub $spritestart, $spritex
    sub $newline, $pipex

draw_pipe_body_notleft: # The pipe is not on the left

    addi $tmp, $spritex, (-(kSceneWith - sPipeBodyWidth) * 2)
    blez $tmp, draw_pipe_body_notright

    sub $spriteend, $tmp
    add $newline, $tmp
    add $newline, $tmp

draw_pipe_body_notright: # The pipe is not on the right



# Draw the top part of the pipe
draw_pipe_i_top:

    addi $i, $pipey, -10*4

draw_pipe_i_top_loop: # Loop: repeat the sprite

    jal draw_sprite_line_safe
    add $vgapos, $newline

    addi $i, -4
    bne $i, $zero, draw_pipe_i_top_loop  # Draw next line

    move $savedvgapos, $vgapos



# Draw the bottom part of the pipe
draw_pipe_i_bottom:

    li $tmp, (kSceneWith * 57 * 4)
    add $vgapos, $vgapos, $tmp

    addi $i, $pipey, -((kSceneHeight - 48) * 4)

draw_pipe_i_bottom_loop: # Loop: repeat the sprite

    jal draw_sprite_line_safe
    add $vgapos, $newline

    addi $i, 4
    bne $i, $zero, draw_pipe_i_bottom_loop  # Draw next line




# Render the end parts of the pipes
render_pipe_ends:

    move $vgapos, $savedvgapos

    addi $spritestart, (sPipeEndData - sPipeBodyData)  # Load the 'pipe-end' sprite
    addi $spriteend, (sPipeEndData - sPipeBodyData)



# Draw the end part of the top pipe
draw_pipe_i_topend:

    move $spritestartcopy, $spritestart
    move $spriteendcopy, $spriteend

    addi $spritetail, $spritestart, (sPipeEndHeight * sPipeEndWidth * 2)

draw_pipe_i_topend_loop: # Loop: draw all lines of the top

    jal draw_sprite_line_safe
    add $vgapos, $newline

    addi $spriteend, (sPipeEndWidth * 2)
    addi $spritestart, (sPipeEndWidth * 2)

    bne $spritestart, $spritetail, draw_pipe_i_topend_loop



# Draw the end part of the top pipe
draw_pipe_i_bottomend:

    move $spritestart, $spritestartcopy
    move $spriteend, $spriteendcopy

    addi $newline, (-2 * kSceneWith * 4)

    li $tmp, (kSceneWith * 44 * 4)
    add $vgapos, $vgapos, $tmp

draw_pipe_i_bottomend_loop: # Loop: draw all lines of the bottom

    jal draw_sprite_line_safe
    add $vgapos, $newline

    addi $spriteend, (sPipeEndWidth * 2)
    addi $spritestart, (sPipeEndWidth * 2)

    bne $spritestart, $spritetail, draw_pipe_i_bottomend_loop



# The pipe rendering is done!
render_pipe_i_end:
