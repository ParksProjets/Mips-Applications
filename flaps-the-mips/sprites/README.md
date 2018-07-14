# Flaps The Mips sprites

This folder contains all sprites of **Flaps The Mips**. A sprite is a movable
object of the game, like the bird or pipes. Titles are not sprites.

All the sprites are entered in the file `sprites.ini` with their name and PNG
file.

You can regenerate the assembly file containing sprite information (file
`render/sprites-data.s`) with the following command:
```sh
python3 sprites2asm.py
```
