# Text


## Format


Here is the format (with a text of 11 characters).
 
Note that for facilitate understanding, the following written in little endian,
with a 32bit word per line. 

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
text: .word 
```

