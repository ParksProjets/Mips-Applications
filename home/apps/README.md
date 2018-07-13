# Applications

This folder contains the configuration files for each application to include in
the final build.

Note that several applications can have the symbol `main`. All symbols of each
application are localized (converted into local symbols), except the entry symbol
that is renamed.



## File `#all-apps.ini`

This file contains the list the applications to include in the final app.  
Application `lock` is the screen saver.



## Files `[app-name].ini`

The following fields are required:

- `title` – The title to display in the menu.
- `type` – The type of the application. It can be either `gas` or `object`.
- `entry-symbol` – The entry point of the application (can be a local symbol).


The type `gas` indicates that the application is written in ASM and must be
built with **GNU as**.  
When type is `gas`, you can specify this additional field:

- `directory` (optional) – Directory containing the ASM app (from root). By 
                           default it's `[app-name]`.


The type `object` indicates that the application is already compiled into a `.o`
file in the `compiled` folder.  
When type is `object`, you can specify this additional field:

- `obj-name` (optional) – Name of the object file. By default it's `[app-name].o`.
