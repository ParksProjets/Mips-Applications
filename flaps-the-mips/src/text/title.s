#
#  Draw the title.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "text/title.s"


# Configuration
.set kTitlePosX, ((kSceneWidth / 2) - (iTitleWidth / 2))
.set kTitlePosY, 30


# Draw the title
draw_title:

    la $spriteaddr, iTitleData
    addi $spritetail, $spriteaddr, (iTitleNumWords * 4)

    li $width, (iTitleWidth * 4)
    li $tmp, (((iTitleWidth / 16) + 1) * 4)

    li $vgapos, (kVgaAddress + (kSceneWidth * kTitlePosY + kTitlePosX) * 4)
    j draw_image



# Clear the title
clear_title:

    li $color, (kBackgroundColor)
    li $vgapos, (kVgaAddress + (320 * kTitlePosY + kTitlePosX) * 4)
    
    li $width, (iTitleWidth * 4)
    li $height, (iTitleHeight)

    j draw_rectangle
