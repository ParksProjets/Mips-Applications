#
#  Update the bird position.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render/bird.s"


# Render the bird.
render_bird:

    # Calculate the screen position of the bird.
    andi $tmp, $birdy, (~0b11 & 0xFFFF)
    sll $vgapos, $tmp, 8    # Calculate vgapos = 320 * birdy + birdx
    sll $tmp, $tmp, 6       #   320 = 2^8 + 2^6
    addu $tmp, $tmp, $birdx
    addu $tmp, $tmp, $vga
    addu $vgapos, $vgapos, $tmp


    lw $tmp, dBirdState($zero)
    addi $tmp, -1

    bne $tmp, $zero, dont_reset_bird_state
    li $tmp, (8 * 3 - 1)

dont_reset_bird_state:

    sw $tmp, dBirdState($zero)

    srl $tmp, (3 - 2)
    lw $spriteaddr, dBirdSprites($tmp)  # Load the 'bird' sprite

    # la $spriteaddr, sBirdData  # Load the 'bird' sprite
    addi $spritetail, $spriteaddr, (sBird0Height * sBird0Width * 2)

    li $width, (sBird0Width * 4)

    jal draw_sprite_fixed
