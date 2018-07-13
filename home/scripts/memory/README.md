# Memory manager

The script in this folder manage the memory layout of the final application.
It generate a linker script (by default `ldscript.ld`) with each section
stored in one of the memory.

The script tries to fill the first memories as much as possible. To do that, it
uses **lpsolve**, Linear Programming (**LP**) solver. Binaries of this program
are in `dll` folder.

You can change memory configuration in the file `memory.json`.
