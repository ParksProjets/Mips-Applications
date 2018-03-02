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
        obj/home.o (.zdata)
        obj/mips-invader.o (.data)
        obj/screen-saver.o (.text)
        obj/home.o (.text)
    } > RAM0

    /* RAM1 memory data */
    . = 0x20000;
    .data : {
        obj/pong.o (.text)
        obj/pong.o (.data)
        obj/screen-saver.o (.data)
        obj/mips-invader.o (.text)
        *(.rodata)
        __gp = .;
    } > RAM1
}
