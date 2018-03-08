#
#  Clear the previous game frame.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "render/clear.s"


# Clear the previous game frame.
clear:



# Clear the bird.
clear_bird:

    andi $tmp, $birdy, (~0b11 & 0xFFFF)
    sll $vgapos, $tmp, 8    # Calculate vgapos = 320 * birdy + birdx
    sll $tmp, $tmp, 6       #   320 = 2^8 + 2^6
    addu $tmp, $tmp, $birdx
    addu $tmp, $tmp, $vga
    addu $vgapos, $vgapos, $tmp

    li $width, (sBird0Width * 4)
    li $height, (sBird0Height)
    li $color, (kBackgroundColor)

    jal draw_rectangle
