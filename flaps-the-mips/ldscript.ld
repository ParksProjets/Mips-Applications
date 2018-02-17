MEMORY {
    mem : ORIGIN = 0, LENGTH = 8k
}

SECTIONS
{
    . = 0x000;
    .text : { *(.text) } > mem
    .data : { *(.data) } > mem
}
