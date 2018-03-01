#!/usr/bin/python3
"""

Main script for generating the apps in the home menu.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import sys
import os.path as path
import argparse

# Push 'objects' folder for loading 'app2obj'
folder = path.join(path.dirname(__file__), '../objects')
sys.path.append(path.abspath(folder))

# Push 'memory' folder for loading 'genld'
folder = path.join(path.dirname(__file__), '../memory')
sys.path.append(path.abspath(folder))

from apps2asm import apps2asm
from apps2obj import apps2obj
from genld import genld


def genapps(appsfolder):
    "Main script for generating the apps in the home menu."

    here = path.dirname(__file__)

    outasm =  path.abspath(path.join(here, "../../src/menu/apps-data.s"))
    apps2asm(appsfolder, outasm)

    compiledf = path.abspath(path.join(here, "../../compiled"))
    objf = path.abspath(path.join(here, "../../obj"))
    apps2obj(appsfolder, compiledf, objf)

    memconfigf = path.abspath(path.join(here, "../memory/memory.json"))
    ldscriptf = path.abspath(path.join(here, "../../ldscript.ld"))
    genld(memconfigf, ldscriptf, appsfolder)



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="genapps",
        description="Main script for generating the apps in the home menu.")

    parser.add_argument("folder", default="apps", nargs="?",
        help="folder containing the apps, from root (default=apps)")

    args = parser.parse_args()
    here = path.dirname(__file__)

    genapps(path.abspath(path.join(here, "../../", args.folder)))


if __name__ == "__main__":
    main()
