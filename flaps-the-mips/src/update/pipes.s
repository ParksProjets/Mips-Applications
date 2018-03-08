#
#  Update the pipes.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update/pipes.s"


# Update the pipes.
update_pipes:

    beq $gamestarted, $zero, after_update_pipes  # If the game not started

    la $addr, (dPipes)
    la $endaddr, (dPipes + 8 * kNumberOfPipes)


update_pipe_i: # Loop: update the i-th pipe

    lw $pipex, 0($addr)  # Load x pos
    lw $pipey, 4($addr)  # Load y pos

    bne $gameended, $zero, test_bird_collision  # If the game has ended
    addi $pipex, $pipex, (-2 * 4)  # Update x pos -> x -= 2




# Test if the bird collides the pipe
test_bird_collision:

    # The bird collides the pipe if
    #   birdx + 17 >= pipex && birdx <= pipex + 24   and
    #   birdy < pipey || birdy + 12 > pipey + 45

    sub $xcmp, $pipex, $birdx  # xcmp = pipex - birdx

    addi $xcmpsh, $xcmp, (-17 * 4)
    bgtz $xcmpsh, bird_not_collide  # not (pipex - birdx - 17 <= 0)

    addi $xcmpsh, $xcmp, (24 * 4)
    bltz $xcmpsh, bird_not_collide  # not (pipex - birdx + 24 >= 0)

    sub $ycmp, $pipey, $birdy  # ycmp = pipey - birdy
    bgtz $ycmp, bird_collides  # (pipey - birdy > 0)

    addi $ycmp, $ycmp, ((45 - 12) * 4)
    bgez $ycmp, bird_not_collide  # not (pipey - y + 45-12 < 0)


bird_collides: # The end of the game is close...

    li $gameended, 1


bird_not_collide: # If the bird doesn't collide the pipe




# Replace the pipe if it's on the left
rand_pipe:

    addi $tmp, $pipex, (sPipeBodyWidth * 4)
    bgtz $tmp, after_rand_pipe

    li $pipex, ((320 + 6) * 4)  # Reset x position

    # TODO: random y and save it

after_rand_pipe:




# Update the score
update_score: 

    li $tmp, (150 * 4)
    bne $pipex, $tmp, after_update_score # Update the score

    .include "game/score.s"
    .file "update-pipes.s"

after_update_score:




# Now the render pipe
end_update_pipe_i:

    sw $pipex, ($addr)  # Save new pipe position

    # Render the current pipe
    .include "render/pipes.s"
    .file "update-pipes.s"

    addi $addr, $addr, 8  # $addr += 8
    bne $addr, $endaddr, update_pipe_i

after_update_pipes:
