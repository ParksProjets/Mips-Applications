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


    lw $prevcurpos, cursorpos($zero)  # Load last cursor pos

    li $tmp, kMoveCursorUp
    beq $btns, $tmp, move_cursor_up  # Move the cursor up

    li $tmp, kMoveCursorDown
    beq $btns, $tmp, move_cursor_down  # Move the cursor down

    li $tmp, kRunAppBtn
    beq $btns, $tmp, run_app  # Start an application

    j main_loop  # Else: jump to main loop



# Move the cursor up
move_cursor_up:

    beq $prevcurpos, $zero, main_loop

    addi $cursorpos, $prevcurpos, -1
    j render_cursor_menu



# Move the cursor down
move_cursor_down:

    li $tmp, (kNumberOfApps + 2)
    beq $prevcurpos, $tmp, main_loop

    addi $cursorpos, $prevcurpos, 1
    j render_cursor_menu



# Run an application
run_app:

    sll $prevcurpos, 2  # prevcurpos *= 2
    lw $tmp, kAppEntries($prevcurpos)

    jalr $tmp
    j home_menu  # Restart the home menu





# Render the cursor in the menu
render_cursor_menu:

    li $color, 0xF800
    jal draw_cursor

    sw $cursorpos, cursorpos($zero)
    move $cursorpos, $prevcurpos

    li $color, 0xFFFF
    jal draw_cursor

    j main_loop



# Draw the cursor
draw_cursor:

    addi $botcurpos, $cursorpos, (-kNumberOfApps)    

calculate_cursor_pos:

    bgez $botcurpos, calculate_cursor_pos_bottom

    li $x, (22 * 4)
    sll $y, $cursorpos, 7  # y = cursorpos * 32 * 4
    addi $y, ((20 + 2) * 4)

    j render_cursor_fixed

calculate_cursor_pos_bottom:

    li $y, (224 * 4)
    sll $x, $botcurpos, 8  # x = cursorpos * 64 * 4
    sll $tmp, $botcurpos, 7  # tmp = cursorpos * 32 * 4
    add $x, $tmp
    addi $x, ((20 - 8) * 4)

render_cursor_fixed:

    li $width, (4 * 4)
    li $height, 4

    j draw_rectangle
