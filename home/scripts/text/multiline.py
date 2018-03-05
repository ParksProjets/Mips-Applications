#!/usr/bin/python3
"""

Align a text.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

from collections import OrderedDict

from charset import CHAR_SET


# Character directory from the charset
CHAR_DIR = OrderedDict(CHAR_SET)


def word_width(word, maxwidth=9999):
    "Calculate the width of a word."

    width = 0

    for char in word:
        assert char in CHAR_DIR, "Character '%s' not in charset" % char
        width += (CHAR_DIR[char] + 1)

    assert width <= maxwidth, "Word '%s' to large (max width of %d)" % (word, maxwidth)
    return width



def cut_text_lines(text, maxwidth):
    "Cut a text in several lines."

    lines = []
    textlines = text.split("\n")
    space = (CHAR_DIR[" "] + 1)

    for textline in textlines:
        width, current = (0, [])

        for word in textline.split():
            width += word_width(word, maxwidth)
            if width > maxwidth:
                lines.append(" ".join(current))
                width, current = (0, [])

            width += space
            current.append(word)

        lines.append(" ".join(current))

    return lines
