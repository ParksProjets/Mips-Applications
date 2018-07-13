# Text of the home menu

## Generate the assembly file

You can (re)generate the assembly file with the following command:
```sh
python3 text2asm.py
```


## Format of the text

Here is the format (with a text of 11 characters).
 
Note that to facilitate understanding, the following words are written in little
endian with a 32bit word per line. 

```
-------------------------------------------------------------------
|        8        |     6     |     6     |     6     |     6     |
| NUMBER OF WORDS |  CHAR 1   |  CHAR 2   |  CHAR 3   |  CHAR 4   |
-------------------------------------------------------------------
|     6     |     6     |     6     |     6     |     6     |  2  |
|  CHAR 5   |  CHAR 6   |  CHAR 7   |  CHAR 8   |  CHAR 9   |     |
-------------------------------------------------------------------
|     6     |     6     |                   20                    |
|  CHAR 10  |  CHAR 11  |                                         |
-------------------------------------------------------------------
```

The first byte is the **number of words** used to store the text (3 in the example
above). The following bytes are the **index** of each character **in the charset**. 


For example with the text `Hello World`:

```gas
text: .word 0x332C1503, 0x24013633, 0x2B333936
```
