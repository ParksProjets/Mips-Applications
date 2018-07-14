# Flaps The Mips texts

This folder contains all texts used in **Flaps The Mips** (except the splash-screen,
see `text/splash.s` for further details).

The font image with numbers is in file `font.png`. The background of the image
must be in color `#22B14C` (even if in the game it's not this color). Else, the
image should only contain colors `#000000` and `#FFFFFF`.  
You can regenerate the assembly file with the following command:
```sh
python3 font2asm.py
```
