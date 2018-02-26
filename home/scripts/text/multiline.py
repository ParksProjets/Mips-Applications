#!/usr/bin/python3
"""

Align a text.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

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
    width, current = (0, [])

    for word in text.split():
        width += word_width(word, maxwidth)
        if width > maxwidth:
            lines.append(" ".join(current))
            width, current = (0, [])
        current.append(word)

    lines.append(" ".join(current))
    return lines



def left_align_text(text, maxwidth):
    "Left align a text."

    lines = cut_text_lines(text)
    return (lines, [0] * len(lines))



def center_align_text(text, maxwidth):
    "Center align a text."

    # TODO
    lines = cut_text_lines(text)
    return (lines, [0] * len(lines))



def right_align_text(text, maxwidth):
    "Right align a text."

    # TODO
    lines = cut_text_lines(text)
    return (lines, [0] * len(lines))

