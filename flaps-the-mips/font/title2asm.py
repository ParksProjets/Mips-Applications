#!/usr/bin/python3
"""

Convert the title image into an ASM file.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import argparse
from PIL import Image


# Colors in the palette
PALETTE = [
    (0, 0, 0), # Border color
    (255, 255, 255), # Main color
    (34, 177, 76) # Background color
]


def get_palette_index(color):
    "Get the color index from the palette."

    assert color in PALETTE, "Color %s not in the palette" % (color,)
    return PALETTE.index(color) + 1



def get_pixel_word(image, x, y):
    "Get a word containing some pixels"

    word = 0
    stop = min(x + 16, image.width)

    for i in range(stop, x, -1):
        word <<= 2
        word |= get_palette_index(image.getpixel((i - 1, y)))

    return word



def convert_image_line(image, y):
    "Convert an image line into data."

    words = []

    for x in range(0, image.width, 16):
        words.append(get_pixel_word(image, x, y))

    return words



def convert_image(image, out):
    "Convert an image into ASM code."

    out.write(".set iTitleWidth, %d\n" % image.width)
    out.write(".set iTitleHeight, %d\n" % image.height)

    words = []
    for y in range(image.height):
        words += convert_image_line(image, y)

    out.write(".set iTitleNumWords, %d\n\n" % len(words))

    data = ["0x%08X" % w for w in words]
    out.write("iTitleData: .word %s\n" % ", ".join(data))



def title2asm(inname, outname):
    "Convert the title image into an ASM file."

    image = Image.open(inname)

    out = open(outname, "w")
    out.write("# Converted using title2asm.py\n\n")
    out.write(".data\n\n")

    convert_image(image, out)
    out.close()



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="title2asm",
        description="Convert the title image into an ASM file.")

    parser.add_argument("input", default="title.png", nargs="?",
        help="input image text (default=title.png)")

    args = parser.parse_args()
    title2asm(args.input, "../src/text/title-data.s")


if __name__ == "__main__":
    main()
