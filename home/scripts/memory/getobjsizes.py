#!/usr/bin/python3
"""

Get the size of the sections in an OBJ file.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import os, os.path as path
import argparse
import subprocess
import re


# GNU tools
GCC_PREFIX = "/opt/mips-toolchain/bin/mips-sde-elf-"
OD = "%sobjdump" % GCC_PREFIX

# Sections to get
SECTIONS = [".data", ".text", ".bss", ".sdata", ".sbss", ".zdata", ".rodata"]

# Regex pattern
PATTERN = "^ *[0-9]+ +([a-z0-9.]+) +([0-9a-f]+)"


def get_sections_size(name):
    "Get the size of the sections in an OBJ file."

    here = path.dirname(__file__)
    obj = path.abspath(path.join(here, "../../obj", "%s.o" % name))
    assert path.isfile(obj), "Object file '%s.o' doesn't exist" % name

    filters = [m for s in SECTIONS for m in ("--section", s)]
    proc = subprocess.Popen([OD, "-h", *filters, obj], stdout=subprocess.PIPE)

    content = proc.stdout.read().decode("ascii")
    sections = {}
    
    for match in re.finditer(PATTERN, content, re.I | re.M):
        name = match.group(1)
        size = int(match.group(2), 16)

        if size > 0: # Ignore empty sections
            sections[name] = size

    return sections



def get_sections_size_prefixed(name):
    "Get the size of the sections in an OBJ file (prefixed)."

    prefix = "obj/%s.o (%%s)" % name
    return {prefix % n: s for n, s in get_sections_size(name).items()}



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="getobjsizes",
        description="Get the size of the sections in an OBJ file.")

    parser.add_argument("name", help="filename of object file")

    parser.add_argument("-p", action="store_true",
        help="use the prefixed section names")

    args = parser.parse_args()

    if args.p:
        sections = get_sections_size_prefixed(args.name)
    else:
        sections = get_sections_size(args.name)

    for name, size in sections.items():
        print("%s -> %d bytes" % (name, size))


if __name__ == "__main__":
    main()

