#!/usr/bin/python3
"""

Convert a text into ASM code.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

from collections import OrderedDict
from math import ceil, floor

from charset import CHAR_SET, INDEX_LENGTH


# Character directory from the charset
CHAR_DIR = OrderedDict(CHAR_SET)
CHAR_INDEXES = list(CHAR_DIR.keys())


def convert_text(text):
    "Convert a text into an array of 32bit words."

    assert len(text) <= 255, "Can't convert a text with more than 255 characters"

    cpw = floor(32 / INDEX_LENGTH)
    num_words = ceil((len(text) + 1) / cpw)

    offset = ceil(8 / INDEX_LENGTH)
    array = [0] * num_words

    for i, char in enumerate(text, offset - 1):
        assert char in CHAR_DIR, "Character '%s' not in charset" % char

        index = CHAR_INDEXES.index(char)
        array[(i + 1) // cpw] |= index << (((i + 1) % cpw) * INDEX_LENGTH)

    array[0] = (array[0] >> offset) | num_words
    return array



def convert_multiline(text):
    "Convert a mutiline text into an array of arrays of 32bit words."

    # TODO



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="text2asm",
        description="Convert a text into ASM code.")

   # TODO


if __name__ == "__main__":
    main()
