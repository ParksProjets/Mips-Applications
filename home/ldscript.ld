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
    /* RAM0 memory data */
    . = 0x0;
    .text : {
        obj/startup.o (.text)
        obj/pong.o (.zdata)
        obj/home.o (.zdata)
        obj/mips-invader.o (.text)
        obj/mips-invader.o (.data)
    } > RAM0

    /* RAM1 memory data */
    . = 0x20000;
    .data : {
        obj/screen-saver.o (.text)
        obj/home.o (.data)
        obj/home.o (.text)
        obj/screen-saver.o (.data)
        obj/pong.o (.text)
        _gp = .;
    } > RAM1
}
