#
#  Update the bird position.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update/bird.s"


# Update the bird.
update_bird:

# Manage the user input
user_input:

    lw $btns, kSwitchesAddress($zero)
    srl $btns, 16  # Get buttons value

    lw $inputcounter, dBirdInputcounter($zero)

    beq $inputcounter, $zero, user_buttons  # Delay between jumps
    addi $inputcounter, -1
    j after_user_input

user_buttons:

    lw $btndown, dBirdBtndown($zero)
    bne $btndown, $zero, after_user_buttons

    beq $btns, $zero, after_user_buttons

    beq $gamestarted, $zero, after_user_buttons  # If the game has not started
    bne $gameended, $zero, after_user_buttons  # If the game has ended

jump_bird:

    li $inputcounter, kBirdAllowJump
    addi $birdvel, (-kBirdJumpHeight)

after_user_buttons:

    sw $btns, dBirdBtndown($zero)

after_user_input:

    sw $inputcounter, dBirdInputcounter($zero)
    




# Update the bird velocity
update_bird_velocity:

    beq $gamestarted, $zero, after_update_bird  # The game has not started

    addi $tmp, $birdvel, (-kBirdMaxVelocity)
    bgez $tmp, update_bird_position

    addi $birdvel, kBirdGravity



# Update the bird position
update_bird_position:

    add $birdy, $birdvel


after_update_bird:
