#!/usr/bin/python3
"""

Dump the screen saver image to an ASM .s file.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import argparse
from math import log2, floor
from PIL import Image


def rgb24to16(r, g, b):
    "Convert a 24 bits RGB color to 16 bits."

    r16 = r * 249 + 1014
    g16 = (g * 253 + 505) >> 5
    b16 = (b * 249 + 1014) >> 11

    return (r16 & 0xF800) | (g16 & 0x7E0) | (b16 & 0x1F)



def save_palette(out, palette, size):
    "Save the image palette."

    data = []
    for i in range(0, 3 * size, 3):
        color = rgb24to16(*palette[i:i+3])
        data.append("0x%04X" % color)

    out.write("\n.section .zdata\n\n")
    out.write("palette: .word %s\n" % ", ".join(data))



def get_pixel_word(image, x, y, align, size):
    "Save a word containing some pixels"

    pixel = 0
    ppw = floor(32 / align)

    for i in range(ppw-1, -1, -1):
        pixel <<= align
        px = image.getpixel((x + i, y)) + 1
        assert 1 <= px < size, "Pixel index out of range"
        pixel |= px

    return pixel



def convert(out, imgname, colors):
    "Convert the image."

    image = Image.open(imgname)

    align = floor(log2(colors))
    ppw = floor(32 / align) # Pixels per word
    assert image.width % ppw == 0, "Image width must be a multiple of %s" % ppw

    converted = image.convert("P", palette=Image.ADAPTIVE, colors=colors-1)

    out.write(".set kImageWidth, %d\n" % image.width)
    out.write(".set kImageHeight, %d\n" % image.height)
    out.write(".set kImageAlign, %d\n" % align)
    out.write(".set kImagePixelsPerWord, %d\n\n" % ppw)
    out.write(".data\n\n")

    pixels = []
    for y in range(image.height):
        for x in range(0, image.width, ppw):
            pixels.append("0x%08X" % get_pixel_word(converted, x, y, align, colors))

    out.write("\nimage: .word %s\n" % ", ".join(pixels))
    save_palette(out, converted.getpalette(), colors - 1)



def img2asm(imgname, outname, colors):
    "Dump the screen saver image to an ASM .s file."

    out = open(outname, "w")
    out.write("# Convertd using img2asm.py\n")
    out.write("# Input image: %s\n\n" % imgname)

    convert(out, imgname, colors)
    out.close()



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="img2asm",
        description="Convert an image into an ASM file.")

    parser.add_argument("image", help="image file to convert")

    parser.add_argument("-p", type=int, default=64,
        help="number of colors in the palette (default=64)")

    args = parser.parse_args()
    img2asm(args.image, "../src/image.s", args.p)


if __name__ == "__main__":
    main()
