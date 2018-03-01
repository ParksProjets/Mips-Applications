"""

Generate the LD script.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import io, os.path as path
import argparse
import configparser
import json
import re

from getobjsizes import get_sections_size_prefixed
from sortsections import sort_sections, get_mem_sections as refine_sections


def read_ini(filename):
    "Read an INI file."

    config = configparser.ConfigParser()
    with open(filename) as file:
        config.read_string("[DEFAULT]\n%s" % file.read())

    return config["DEFAULT"]



def read_config(filename):
    "Read the configuration file."

    with open(filename) as file:
        data = json.load(file)

    return data



def gen_MEMORY(out, memories):
    "Generate 'MEMORY' part of the LD script."

    out.write("MEMORY\n{\n")

    for mem in memories:
        out.write("    %s : ORIGIN = 0x%0X, LENGTH = 0x%0X\n" % (mem["name"],
            mem["origin"], mem["length"]))

    out.write("}\n")



def gen_SECTIONS(out, memories, sections):
    "Generate 'SECTIONS' part of the LD script."

    out.write("\nSECTIONS\n{\n")
    so = io.StringIO()

    for mem, secs in zip(memories, sections):
        so.write("\n    /* %s memory data */\n" % mem["name"])
        so.write("    . = 0x%0X;\n" % mem["origin"])
        so.write("    %s : {\n" % mem.get("sections", "%s.text" % mem["name"]))

        for symbol in secs:
            so.write("        %s\n" % symbol)

        so.write("    } > %s\n" % mem["name"])

    out.write(so.getvalue()[1:])
    out.write("}\n")



def get_sections(apps, memconf):
    "Gets the sections in each memories from the apps."

    sections = {}
    for name in apps:
        sections.update(get_sections_size_prefixed(name))

    for name in ("home", "startup"):
        sections.update(get_sections_size_prefixed(name))

    mems, spe = refine_sections(sections, memconf)

    memsecs = sort_sections(sections, mems)
    assert memsecs, "Not enought memory for storing all the apps"

    return [spe[i][0] + secs + spe[i][1] for i, secs in enumerate(memsecs)]



def genld(inname, outname, folder):
    "Generate the LD script."

    memconf = read_config(inname)
    appconf = read_ini(path.join(folder, "#all-apps.ini"))

    apps = re.findall("^\s*-\s*(.*)$", appconf.get("apps").strip(), re.M)
    sections = get_sections(apps, memconf)

    out = open(outname, "w")
    out.write("/*\n * This file has been generated automatically by genld.py\n")
    out.write(" * Configuration file: %s\n */\n\n" % path.basename(inname))

    gen_MEMORY(out, memconf)
    gen_SECTIONS(out, memconf, sections)

    out.close()



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="genld",
        description="Generate the LD script.")

    parser.add_argument("folder", default="apps", nargs="?",
        help="folder containing the apps, from root (default=apps)")

    parser.add_argument("-o", default="ldscript.ld", metavar="outname",
        help="output filename, in root folder (default=ldscript.ld)")

    parser.add_argument("-c", default="memory.json", metavar="config",
        help="configuration file (default=memory.json)")

    args = parser.parse_args()
    here = path.dirname(__file__)

    configf = path.abspath(path.join(here, args.c))
    outf = path.abspath(path.join(here, '../..', args.o))
    folder = path.abspath(path.join(here, '../..', args.folder))
    genld(configf, outf, folder)


if __name__ == "__main__":
    main()
