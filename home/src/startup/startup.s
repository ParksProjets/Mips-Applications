#
#  Startup script.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "startup.s"
.set noreorder


.text

.global startup
startup:

    la $gp, __gp
    la $sp, __gp

    j home_menu
