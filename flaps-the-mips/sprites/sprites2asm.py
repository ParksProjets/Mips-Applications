#!/usr/bin/python3
"""

Convert all the sprites into an ASM file.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import os.path as path
import argparse
import configparser
from PIL import Image


def rgb24to16(r, g, b):
    "Convert a 24 bits RGB color to 16 bits."

    r16 = r * 249 + 1014
    g16 = (g * 253 + 505) >> 5
    b16 = (b * 249 + 1014) >> 11

    return (r16 & 0xF800) | (g16 & 0x7E0) | (b16 & 0x1F)



def convert_sprite(name, config, out):
    "Convert a single sprite."

    assert "file" in config, "Please provide 'file' for section %s" % name
    assert "prefix" in config, "Please provide 'prefix' for section %s" % name

    prefix = config["prefix"]

    here = path.dirname(__file__)
    image = Image.open(path.join(here, config["file"]))

    out.write(".set %sWidth, %d\n" % (prefix, image.width))
    out.write(".set %sHeight, %d\n" % (prefix, image.height))

    pixels = []
    for y in range(image.height):
        for x in range(0, image.width, 2):
            px = rgb24to16(*image.getpixel((x, y))) & 0xFFFF
            px |= rgb24to16(*image.getpixel((x + 1, y))) << 16
            pixels.append("0x%08X" % px)

    out.write("\n%sData: .word %s\n" % (prefix, ", ".join(pixels)))



def sprites2asm(config, outname):
    "Convert all the sprites into an ASM file."

    out = open(outname, "w")
    out.write("# Convertd using sprites2asm.py\n\n")

    out.write(".data\n")

    for name in config.sections():
        out.write("\n")
        convert_sprite(name, config[name], out)

    out.close()



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="sprites2asm",
        description="Convert an image into an ASM file.")

    parser.add_argument("config", default="sprites.ini", nargs="?",
        help="configuration file (default=sprites.ini)")

    args = parser.parse_args()
    here = path.dirname(__file__)

    config = configparser.ConfigParser()
    config.read(path.join(here, args.config))

    sprites2asm(config, path.join(here, "../src/render/sprites-data.s"))


if __name__ == "__main__":
    main()
