#!/usr/bin/python3
"""

Convert all the apps into object files.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

import os.path as path
import argparse
import configparser
import re

from objapp2obj import objapp2obj
from gas2obj import gas2obj


def read_ini(filename):
    "Read an INI file."

    config = configparser.ConfigParser()
    with open(filename) as file:
        config.read_string("[DEFAULT]\n%s" % file.read())

    return config["DEFAULT"]



def app2obj(appsf, inf, outf, name):
    "Convert a single app into an object file."

    cname = path.join(appsf, "%s.ini" % name)
    assert path.isfile(cname), "File '%s.ini' doesn't exist" % name
    config = read_ini(cname)

    assert "type" in config, "Please provide 'type' in %s.ini" % name
    ctype = config["type"]

    assert ctype in ("gas", "object"), "Type '%s' not valid in in %s.ini" % (ctype, name)
    if ctype == "gas":
        gas2obj(config.get("directory", name), name)

    objapp2obj(appsf, inf, outf, name)



def apps2obj(appsf, inf, outf):
    "Convert all the apps into object files."

    conff = path.join(appsf, "#all-apps.ini")
    assert path.isfile(conff), "File #all-apps.ini is missing"
    config = read_ini(conff)

    apps = re.findall("^\s*-\s*(.*)$", config.get("apps").strip(), re.M)

    for name in apps:
        app2obj(appsf, inf, outf, name)



def main():
    "Entry point of the application."

    parser = argparse.ArgumentParser(prog="apps2obj",
        description="Convert all the apps into object files.")

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
    apps2obj(appsfolder, inputfolder, outfolder)


if __name__ == "__main__":
    main()
