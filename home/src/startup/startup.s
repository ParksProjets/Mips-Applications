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

    la $sp, 0x027FF0
    la $gp, _gp

    j home_menu
