#!/usr/bin/python3
"""

Convert a 24 bits RGB color into a 16 bits color.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import argparse
import re


def rgb24to16(r, g, b):
    "Convert a 24 bits RGB color to 16 bits."

    r16 = r * 249 + 1014
    g16 = (g * 253 + 505) >> 5
    b16 = (b * 249 + 1014) >> 11

    return (r16 & 0xF800) | (g16 & 0x7E0) | (b16 & 0x1F)



def color16(color):
    "Convert a 24 bits RGB color into a 16 bits color."

    if color.startswith('#') or color.startswith('x'):
        colors = [int(color[i+1:i+3], 16) for i in (0, 2 ,4)]
    elif re.match("\\( *[0-9]+ *, *[0-9]+ *, *[0-9]+ *\\)$", color):
        colors = eval(color)
    else:
        raise ValueError("Invalid color format: %s" % color)

    word = rgb24to16(*colors)
    print("16 bits color: 0x%0X" % word)



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="color16",
        description="Convert a 24 bits RGB color into a 16 bits color.")

    parser.add_argument("color", help="the RGB color (in HTML a tuple format)")

    args = parser.parse_args()
    color16(args.color)


if __name__ == "__main__":
    main()
