#!/usr/bin/python3
"""

Convert the image font into an ASM file.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import os.path as path
import argparse
from PIL import Image


# Colors in the palette
PALETTE = [
    (34, 177, 76), # Background color
    (0, 0, 0), # Border color
    (255, 255, 255) # Main color
]

# List of letters to convert
LETTERS = "0123456789"

# Letter size
LETTER_WIDTH = 12
LETTER_HEIGHT = 18

# Margin between letters
MARGIN = 2


def get_palette_index(color):
    "Get the color index from the palette."

    assert color in PALETTE, "Color %s not in the palette" % (color,)
    return PALETTE.index(color) + 1



def convert_image_line(image, xstart, y):
    "Convert an image line into data."

    word = 0
    for x in range(xstart + LETTER_WIDTH, xstart, -1):
        word <<= 2
        word |= get_palette_index(image.getpixel((x - 1, y)))

    return word



def convert_letter(image, name, xstart, out):
    "Convert a single letter into ASM code."

    words = []
    for y in range(LETTER_HEIGHT):
        words.append("0x%08X" % convert_image_line(image, xstart, y))

    out.write("fData%s: .word %s\n" % (name.upper(), ", ".join(words)))



def convert_image(image, out):
    "Convert an image into ASM code."

    out.write(".set kFontLetterWidth, %d\n" % LETTER_WIDTH)
    out.write(".set kFontLetterHeight, %d\n" % LETTER_HEIGHT)
    out.write(".set kNumLetters, %d\n\n" % len(LETTERS))

    out.write(".section .zdata\n\n")

    letters = ["fData%s" % n.upper() for n in LETTERS]
    out.write("fLetters: .word %s\n\n" % ", ".join(letters))

    out.write(".data\n\n")
    for i, name in enumerate(LETTERS):
        convert_letter(image, name, i * (LETTER_WIDTH + MARGIN), out)



def font2asm(inname, outname):
    "Convert the image font into an ASM file."

    image = Image.open(inname)

    out = open(outname, "w")
    out.write("# Converted using font2asm.py\n\n")

    convert_image(image, out)
    out.close()



def main():
    "Convert the image font into an ASM file."

    parser = argparse.ArgumentParser(prog="font2asm",
        description="Convert an image into an ASM file.")

    parser.add_argument("input", default="font.png", nargs="?",
        help="input image font (default=font.png)")

    here = path.dirname(__file__)
    args = parser.parse_args()

    out = path.join(here, "../src/text/font-data.s")
    font2asm(path.join(here, args.input), out)


if __name__ == "__main__":
    main()
