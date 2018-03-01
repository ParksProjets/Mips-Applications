#!/usr/bin/python3
"""

Fix an OBJ file to be linking properly.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import os.path as path
import argparse
import re
import configparser
import subprocess


# GNU tools
GCC_PREFIX = "/opt/mips-toolchain/bin/mips-sde-elf-"
OBJCOPY = "%sobjcopy" % GCC_PREFIX


def read_ini(filename):
    "Read an INI file."

    config = configparser.ConfigParser()
    with open(filename) as file:
        config.read_string("[DEFAULT]\n%s" % file.read())

    return config["DEFAULT"]



def copy_obj(inname, outname, redefs, globsymb):
    "Copy an object file and modify some parameters."

    redef = [m for o, n in redefs for m in ("--redefine-sym", "%s=%s" % (o, n))]

    globse = ["--globalize-symbol=%s" % s for s in globsymb]
    keep = ["--keep-global-symbol=%s" % s for s in globsymb]

    subprocess.call([OBJCOPY, *redef, *globse, *keep, inname, outname])
    assert path.isfile(outname), "The object file has not been generated"



def objapp2obj(appsf, inf, outf, name):
    "Fix an OBJ file to be linking properly."

    cname = path.join(appsf, "%s.ini" % name)
    assert path.isfile(cname), "File '%s.ini' doesn't exist" % name
    config = read_ini(cname)

    assert "entry-symbol" in config, "Please provide 'entry-symbol' in %s.ini" % name
    main = config.get("entry-symbol")

    outname = "%s.o" % name
    fname = config.get("obj-name", outname)
    entname = re.sub("[ -]", "_", name)

    globsymb = config.get("global-symbols", [])
    globsymb.insert(0, "__%s_main" % entname)

    redefs = [(main, "__%s_main" % entname)]

    copy_obj(path.join(inf, fname), path.join(outf, outname), redefs, globsymb)



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="objapp2obj",
        description="Fix an OBJ file to be linking properly.")

    parser.add_argument("name", help="input folder, from root")

    parser.add_argument("-a", default="apps", metavar="folder",
        help="folder containing the apps, from root (default=apps)")

    parser.add_argument("-i", default="compiled", metavar="folder",
        help="input folder, from root (default=compiled)")

    parser.add_argument("-o", default="obj", metavar="folder",
        help="output folder, from root (default=obj)")

    args = parser.parse_args()
    here = path.dirname(__file__)

    inputfolder = path.abspath(path.join(here, '../..', args.i))
    outfolder = path.abspath(path.join(here, '../..', args.o))
    appsfolder = path.abspath(path.join(here, '../..', args.a))
    objapp2obj(appsfolder, inputfolder, outfolder, args.name)


if __name__ == "__main__":
    main()
