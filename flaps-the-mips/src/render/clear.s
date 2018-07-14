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

    # Calculate the screen position of the bird.
    andi $tmp, $birdy, (~0b11 & 0xFFFF)
    sll $vgapos, $tmp, 8    # Calculate vgapos = 320 * birdy + birdx
    sll $tmp, $tmp, 6       #   320 = 2^8 + 2^6
    addu $tmp, $tmp, $birdx
    addu $tmp, $tmp, $vga
    addu $vgapos, $vgapos, $tmp

    # Draw a rectangle over the bird.
    li $width, (sBird0Width * 4)  # Bird width (4 bytes aligned).
    li $height, (sBird0Height)  # Bird height.
    li $color, (kBackgroundColor)  # Color of the background (blue).

    jal draw_rectangle
