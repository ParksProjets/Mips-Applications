#
#  Manage the menu.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

.file "menu/menu.s"


# Config
.set kMoveCursorUp, 0b001
.set kMoveCursorDown, 0b010
.set kRunAppBtn, 0b100


# Update the menu
update_menu:

    lw $btns, kSwitchesAddress($zero)
    srl $btns, 16

    lw $tmp, lastbtns($zero)
    sw $btns, lastbtns($zero)

    beq $tmp, $btns, main_loop  # No changes on btns state


    lw $cursorpos, cursorpos($zero)

    li $tmp, kMoveCursorUp
    beq $btns, $tmp, move_cursor_up  # Move the cursor up

    li $tmp, kMoveCursorDown
    beq $btns, $tmp, move_cursor_down  # Move the cursor down

    li $tmp, kRunAppBtn
    beq $btns, $tmp, run_app  # Start an application

    j main_loop  # Else: jump to main loop



# Move the cursor up
move_cursor_up:

    beq $cursorpos, $zero, main_loop

    addi $cursorpos, -1
    j render_cursor



# Move the cursor down
move_cursor_down:

    li $tmp, (kNumberOfApps - 1)
    beq $cursorpos, $tmp, main_loop

    addi $cursorpos, 1
    j render_cursor



# Run an application
run_app:

    sll $cursorpos, 2  # cursorpos *= 2
    lw $tmp, kAppEntries($cursorpos)

    jalr $tmp
    j .  # Pause the program



# Render the xursor
render_cursor:

    lw $tmp, cursorpos($zero)

    li $color, 0xFFFF
    li $width, (4 * 4)
    li $x, (22 * 4)

    sll $y, $tmp, 7  # y = cursorpos * 32 * 4
    addi $y, ((20 + 2) * 4)

    li $height, 4
    jal draw_rectangle

    li $color, 0xF800
    sll $y, $cursorpos, 7  # y = cursorpos * 32 * 4
    addi $y, ((20 + 2) * 4)

    li $height, 4
    jal draw_rectangle

    sw $cursorpos, cursorpos($zero)
    j main_loop
