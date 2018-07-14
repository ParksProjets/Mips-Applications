#
#  Update the bird position.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update/bird.s"


# Update the bird.
update_bird:

    li $gamemustend, 0  # Ensure the game will not end now.
    


# Manage the user input
user_input:

    lw $btns, kSwitchesAddress($zero)  # Read switch values.
    srl $btns, 16  # Get buttons value.

    lw $inputcounter, dBirdInputcounter($zero)  # Input counter for delay between jumps.

    beq $inputcounter, $zero, user_buttons  # If input couter is 0: we can jump!
    addi $inputcounter, -1  # Else, decrement the counter and don't jump.
    j after_user_input

user_buttons:

    lw $btndown, dBirdBtndown($zero)  # Read last button state to prevent unwanted jumps.
    bne $btndown, $zero, after_user_buttons  # Between two jumps we must release the button.

    beq $btns, $zero, after_user_buttons  # No buttons pressed.

    beq $gamestarted, $zero, after_user_buttons  # If the game has not started.
    bne $gameended, $zero, after_user_buttons  # If the game has ended.

jump_bird:

    li $inputcounter, kBirdAllowJump  # Reset the jump counter.
    addi $birdvel, (-kBirdJumpHeight)  # Jump: increment y velocity.

after_user_buttons:

    sw $btns, dBirdBtndown($zero)  # Save button state.

after_user_input:

    sw $inputcounter, dBirdInputcounter($zero)  # Save input counter.
    


# Update the bird velocity
update_bird_velocity:

    beq $gamestarted, $zero, after_update_bird  # The game has not started.

    addi $tmp, $birdvel, (-kBirdMaxVelocity)
    bgez $tmp, update_bird_position  # Maximum allowed velocity (negative).

    addi $birdvel, kBirdGravity  # Apply gravity.



# Update the bird position
update_bird_position:

    add $birdy, $birdvel  # Apply bird velocity.

    bgez $birdy, update_bird_position_bottom  # The bird must not go to hight.
    li $birdy, 0
    li $birdvel, 0  # Reset y velocity.

update_bird_position_bottom:

    addi $tmp, $birdy, (-(kSceneHeight - sBird0Height - 1) * 4)  # Distance to the ground.
    bltz $tmp, after_update_bird

    sub $birdy, $tmp
    li $gamemustend, 1


after_update_bird:
