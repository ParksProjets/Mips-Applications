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
    /* RAM0 memory data (8180B used (100%)) */
    . = 0x0;
    .text : {
        obj/startup.o (.text)
        obj/mips-invader.o (.text)
        obj/home.o (.data)
        obj/flaps-the-mips.o (.zdata)
        obj/home.o (.zdata)
        obj/pong.o (.zdata)
        obj/screen-saver.o (.zdata)
    } > RAM0

    /* RAM1 memory data (13376B used (41%)) */
    . = 0x20000;
    .data : {
        obj/flaps-the-mips.o (.text)
        obj/home.o (.text)
        obj/screen-saver.o (.text)
        obj/pong.o (.text)
        obj/flaps-the-mips.o (.data)
        obj/screen-saver.o (.data)
        obj/mips-invader.o (.data)
        _gp = .;
    } > RAM1
}
