#!/usr/bin/python3
"""

Convert texts into ASM code.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

from collections import OrderedDict
import configparser
import argparse
import os.path as path
from math import ceil, floor

from charset import CHAR_SET, INDEX_LENGTH
from multiline import cut_text_lines


# Character directory from the charset
CHAR_DIR = OrderedDict(CHAR_SET)
CHAR_INDEXES = list(CHAR_DIR.keys())


def convert_text(text):
    "Convert a text into an array of 32bit words."

    assert len(text) <= 255, "Can't convert a text with more than 255 characters"
    assert "\n" not in text, "Please use 'convert_multiline' for a multiline text"

    cpw = floor(32 / INDEX_LENGTH)
    num_words = ceil((len(text) + 1) / cpw)

    offset = floor(8 / INDEX_LENGTH)
    extsh = 32 % INDEX_LENGTH
    array = [0] * num_words

    for i, char in enumerate(text, offset):
        assert char in CHAR_DIR, "Character '%s' not in charset" % char

        index = CHAR_INDEXES.index(char) + 1
        array[i // cpw] |= index << ((i % cpw) * INDEX_LENGTH)

    array[0] = (array[0] << extsh) | num_words
    return array



def convert_multiline(text, linewidth):
    "Convert a mutiline text into an array of arrays of 32bit words."

    lines = cut_text_lines(text, linewidth)
    datas = [convert_text(l or " ") for l in lines]

    for data in datas[:-1]:
        data[0] |= (1 << 7)

    return sum(datas, [])



def convert_section(name, config, out):
    "Convert a section into ASM code."

    assert "text" in config, "Please provide 'text' for section %s" % name
    assert "prefix" in config, "Please provide 'prefix' for section %s" % name

    text = config["text"].strip()

    if config.get("multiline", "false") == "true":
        data = convert_multiline(text, config.getint("linewidth", 320))
    else:
        data = convert_text(text)

    words = ", ".join("0x%08X" % w for w in data)
    out.write("%sData: .word %s\n" % (config["prefix"], words))



def text2asm(config, outname):
    "Convert texts into ASM code."
    
    out = open(outname, "w")
    out.write("# Converted using text2asm.py\n\n")

    out.write(".data\n\n")

    for name in config.sections():
        convert_section(name, config[name], out)

    out.close()



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="text2asm",
        description="Convert texts into ASM code.")

    parser.add_argument("config", default="texts.ini", nargs="?",
        help="configuration file (default=texts.ini)")

    args = parser.parse_args()
    here = path.dirname(__file__)

    config = configparser.ConfigParser()
    config.read(path.abspath(path.join(here, args.config)))

    outname = path.abspath(path.join(here, "../../src/text/text-data.s"))
    text2asm(config, outname)


if __name__ == "__main__":
    main()
