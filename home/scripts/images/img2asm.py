#!/usr/bin/python3
"""

Convert all the images into an ASM file.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import argparse
import configparser
from PIL import Image

from color16 import rgb24to16


def convert_sprite(name, config, out):
    "Convert a single sprite."

    assert "file" in config, "Please provide 'file' for section %s" % name
    assert "prefix" in config, "Please provide 'prefix' for section %s" % name

    prefix = config["prefix"]

    image = Image.open(config["file"])
    assert image.width % 2 == 0, "Image width for '%s' must be a multiple of 2" % name

    out.write(".set %sWidth, %d\n" % (prefix, image.width))
    out.write(".set %sHeight, %d\n" % (prefix, image.height))

    pixels = []
    for y in range(image.height):
        for x in range(0, image.width, 2):
            px = rgb24to16(*image.getpixel((x, y))) & 0xFFFF
            px |= rgb24to16(*image.getpixel((x + 1, y))) << 16
            pixels.append("0x%08X" % px)

    out.write("\n%sData: .word %s\n" % (prefix, ", ".join(pixels)))



def img2asm(config, outname):
    "Convert all the images into an ASM file."

    out = open(outname, "w")
    out.write("# Converted using img2asm.py\n\n")

    out.write(".data\n")

    for name in config.sections():
        out.write("\n")
        convert_sprite(name, config[name], out)

    out.close()



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="img2asm",
        description="Convert an image into an ASM file.")

    parser.add_argument("config", default="images.ini", nargs="?",
        help="configuration file (default=images.ini)")

    args = parser.parse_args()

    config = configparser.ConfigParser()
    config.read(args.config)

    img2asm(config, "../../src/gfx/images-data.s")


if __name__ == "__main__":
    main()
