/*
 * This file has been generated automatically by genld.py
 * Configuration file: memory.json
 */

MEMORY
{
    RAM0 : ORIGIN = 0x0, LENGTH = 0x2000
    RAM1 : ORIGIN = 0x20000, LENGTH = 0x8000
}

SECTIONS
{
    /* RAM0 memory data (7980B used (97%)) */
    . = 0x0;
    .text : {
        obj/startup.o (.text)
        obj/home.o (.text)
        obj/mips-invader.o (.text)
        obj/flaps-the-mips.o (.text)
        obj/pong.o (.zdata)
        obj/flaps-the-mips.o (.zdata)
        obj/home.o (.zdata)
    } > RAM0

    /* RAM1 memory data (6104B used (19%)) */
    . = 0x20000;
    .data : {
        obj/pong.o (.text)
        obj/mips-invader.o (.data)
        obj/flaps-the-mips.o (.data)
        obj/home.o (.data)
        _gp = .;
    } > RAM1
}
