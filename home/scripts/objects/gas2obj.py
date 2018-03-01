#!/usr/bin/python3
"""

Convert a GAS app into an OBJ file.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import os, os.path as path
import argparse
import subprocess


# GNU tools
GCC_PREFIX = "/opt/mips-toolchain/bin/mips-sde-elf-"
AS = "%sas" % GCC_PREFIX

# GAS flags
ASFLAGS = ["-G0", "-mips32", "-EB", "-mabi=32", "-non_shared", "--warn", "-Isrc/"]


def gas2obj(folder, name):
    "Convert a GAS app into an OBJ file."

    current = path.abspath(path.dirname(__file__))
    root = path.abspath(path.join(current, "../../.."))

    assert path.isdir(path.join(root, folder)), "Folder '%s' doesn't exist" % folder
    os.chdir(path.join(root, folder))

    os.makedirs(path.join(root, "home/compiled"), exist_ok=True)
    assert path.isfile("src/main.s"), "Source file 'src/main.s' doesn't exist"

    out = path.join(root, "home/compiled/%s.o" % name)
    devnull = open(os.devnull, 'w')

    subprocess.call([AS, *ASFLAGS, "-o", out, "src/main.s"], stdout=devnull, stderr=devnull)
    assert path.isfile(out), "The object file has not been generated"

    os.chdir(current)



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="gas2obj",
        description="Convert an ELF file into a binary file.")

    parser.add_argument("input", help="input folder, from root")

    parser.add_argument("-n", default=None, metavar="name",
        help="name of output object (default=auto)")

    args = parser.parse_args()
    here = path.dirname(__file__)

    if not args.n:
        args.n = args.input

    gas2obj(path.abspath(path.join(here, "../..",args.input)), args.n)


if __name__ == "__main__":
    main()
