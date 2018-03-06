#!/usr/bin/python3
"""

Sort the sections in several memories.

Copyright (C) 2018, Guillaume Gonnet
License MIT

"""

from collections import OrderedDict
import re

from lpsolve import LpEngine, LpVariable, LpConstraint


# Section order (revered)
SECTIONS_ORDER = ["bss", "rodata", "data", "sbss", "sdata", "text"]


def filter_symbol(symbol, sections):
    "Filter a symbol in the memory."

    if not symbol.startswith("section:"):
        return (0, [symbol])

    symbol = symbol[8:]
    if symbol.startswith("*"):
        symbol = "(%s)" % symbol[1:]

    size, secs = (0, [])

    for key in list(sections.keys()):
        if key.endswith(symbol):
            size += sections[key]
            del sections[key]
            secs.append(key)

    return (size, secs)



def refine_memory(sections, mem):
    "Refine a memory without special sections"

    spesec = []
    size = mem["length"]

    for array in (mem.get("begin", []), mem.get("end", [])):
        ret = [filter_symbol(symbol, sections) for symbol in array]
        spesec.append(sum((a[1] for a in ret), []))
        size -= sum(a[0] for a in ret)

    return size, spesec



def get_mem_sections(sections, memconf):
    "Get memory and section array."

    memories, spesec = [], []

    for mem in memconf:
        size, spe = refine_memory(sections, mem)
        spesec.append(spe)
        memories.append(size)

    return memories, spesec



def sort_sections(memsections):
    "Sort the sections inside each memory."

    pattern = ".*\(.([a-z][a-z0-9]*)\)$"
    T = lambda s: SECTIONS_ORDER.index(re.match(pattern, s, re.I).group(1))

    for mem in memsections:
        mem[0].sort(key=T, reverse=True)



def split_sections(sections, memories):
    "Split the sections in several memories."

    numsec = len(sections)
    nummem = len(memories)

    lp = LpEngine(numsec * nummem)

    # Create variables
    ordored = OrderedDict(sections)
    matrix = [[LpVariable(lp, "bin") for _ in ordored] for _ in memories]

    # Get section sizes
    sizes = list(ordored.values())


    # Create memory constaints: don't use more memory than available
    for vrow, mem in zip(matrix, memories):
        const = LpConstraint(sizes, vrow)
        lp.constraint(const <= mem)

    # Create section constaints: use each section exactly once
    for i in range(numsec):
        vcol = [matrix[j][i] for j in range(nummem)]
        const = LpConstraint([1] * nummem, vcol)
        lp.constraint(const == 1)

    # Set the objective function
    lp.objective(LpConstraint(sizes, matrix[0]))


    # Solve this LP model
    ret = lp.solve()
    if ret != 0 and ret != 1: return None


    # Get the values
    memsections = []
    keys = list(ordored.keys())

    for vrow in matrix:
        secs = [keys[i] for i, vsec in enumerate(vrow) if int(vsec.value)]
        memsections.append(secs)

    return memsections
