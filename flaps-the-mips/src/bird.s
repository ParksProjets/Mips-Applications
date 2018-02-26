#
#  Update the bird position.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "bird.s"


# Update the bird.
update_bird:

user_input: # Manage the user input

    lw $btns, kSwitchesAddress($zero)
    andi $btns, $btns, kButtonsMask

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




# Render the bird.
render_bird:

    sll $vgapos, $y, 8     # Calculate vgapos = 320 * y + x
    sll $tmp, $y, 6        #   320 = 2^8 + 2^6
    addu $tmp, $tmp, $x
    addu $tmp, $tmp, $vga
    addu $vgapos, $vgapos, $tmp


    la $spritestart, sBirdData  # Load the 'bird' sprite

    jal draw_sprite_fixed
