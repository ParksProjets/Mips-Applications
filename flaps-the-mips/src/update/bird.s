#
#  Update the bird position.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "update/bird.s"


# Update the bird.
update_bird:

user_input: # Manage the user input

    lw $btns, kSwitchesAddress($zero)
    srl $btns, 16  # Get buttons value

    lw $inputcounter, dBirdInputcounter($zero)

    beq $inputcounter, $zero, user_buttons  # Delay between jumps
    addi $inputcounter, -1
    j after_user_input

user_buttons:

    lw $btndown, dBirdBtndown($zero)
    bne $btndown, $zero, after_user_buttons

jump_bird:

    li $inputcounter, 5  # TODO: make a constant

after_user_buttons:

    sw $btns, dBirdBtndown($zero)
    addi $birdvel, -5*4

after_user_input:



update_bird_position: # Update the bird position

    addi $birdvel, 2
    add $birdy, $birdvel
