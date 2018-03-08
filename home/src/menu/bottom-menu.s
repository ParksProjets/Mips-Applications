#
#  The bottom menu.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.section .zdata


# Number of apps in the bottom menu
.set kBottomApps, 3

# Size of the images
.set iBottomImgWidth, 12
.set iBottomImgHeight, 12

# Space between the buttons
.set kBottomBtnSpace, 96


# List of images (reverse order)
iBottomImages: .word iAboutData, iPowerData, iLockData

# List of texts (reverse order)
tBottomTexts: .word tAboutBtnData, tPowerData, tLockData
