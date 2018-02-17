#
#  Update the pipes.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update-pipes.s"


# Update the pipes.
update_pipes:

    la $addr, pipes
    la $endaddr, (pipes + 8 * kNumberOfPipes)


update_pipe_i: # Loop: update the i-th pipe

    lw $pipex, 0($addr)  # Load x pos
    lw $pipey, 4($addr)  # Load y pos

    addi $pipex, $pipex, -2*4  # Update x pos -> x -= 3*4



# test_bird_collision: # Test if the bird collidse the pipe

#     # The bird collides the pipe if
#     # x + 17 >= pipex && x <= pipex + 24 && (y < pipey || y + 12 > pipey + 45)

#     sub $xcmp, $pipex, $x

#     addi $xcmpsh, $xcmp, -17*4
#     bgtz $xcmpsh, bird_not_collide  # not (pipex - x - 7 <= 0)

#     addi $xcmpsh, $xcmp, 24*4
#     bltz $xcmpsh, bird_not_collide  # not (pipex - x + 24 >= 0)

#     sub $ycmp, $pipey, $y
#     blez $ycmp, bird_not_collide  # not (pipey - y > 0)

#     addi $ycmp, $ycmp, (45-12)*4
#     bgez $ycmp, bird_not_collide  # not (pipey - y + 45-12 < 0)

#     # End of the game

#     ledimm 0b1111  # TODO
#     pause

# bird_not_collide: # If the bird doesn't collide the pipe



rand_pipe: # Replace the pipe

    # addi $tmp, $pipex, 24*4
    addi $tmp, $pipex, 0
    bgtz $tmp, after_rand_pipe

    li $pipex, (320 + 24)*4  # Reset pos -> x = 320*4

    # TODO: random y and save it

after_rand_pipe:



# update_score: # Update the score

#     li $tmp, 74*4
#     bne $x, $tmp, after_update_score # Update the score
#     # TODO: score++

# after_update_score:


    # Render the current pipe
    .include "render-pipes.s"
    .file "update-pipes.s"


    sw $pipex, 0($addr)  # Save new pipe position

    addi $addr, $addr, 8  # $addr += 8
    bne $addr, $endaddr, update_pipe_i


    # TODO
    j main_loop
