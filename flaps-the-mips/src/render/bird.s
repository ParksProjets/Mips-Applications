#
#  Update the bird position.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render/bird.s"


# Render the bird.
render_bird:

    andi $tmp, $birdy, (~0b11 & 0xFFFF)
    sll $vgapos, $tmp, 8    # Calculate vgapos = 320 * birdy + birdx
    sll $tmp, $tmp, 6       #   320 = 2^8 + 2^6
    addu $tmp, $tmp, $birdx
    addu $tmp, $tmp, $vga
    addu $vgapos, $vgapos, $tmp

    la $spriteaddr, sBirdData  # Load the 'bird' sprite
    addi $spritetail, $spriteaddr, (sBirdHeight * sBirdWidth * 2)

    li $width, (sBirdWidth * 4)

    jal draw_sprite_fixed
