#
#  Build the screen saver.
#
#  Copyright (C) 2018, Guillaume Gonnet
#  License MIT

# GNU tools
GCC_PREFIX := /opt/mips-toolchain/bin/mips-sde-elf-
AS = $(GCC_PREFIX)as
LD = $(GCC_PREFIX)ld
OD = $(GCC_PREFIX)objdump

# Options
LD_SCRIPT := ldscript.ld
SRCDIR := src
OBJDIR := obj
OUT_NAME := screensaver
MIPSimu := ../MIPSimu/build

# Compile flags
ASFLAGS = -G0 -mips32 -EB -mabi=32 -non_shared --warn -Isrc/
LDFLAGS = -G0 -mips3 --static -T $(LD_SCRIPT)
ODFLAGS = -d --section=.text -M no-aliases -M reg-names=numeric

.PHONY: run copy dump clean


# Compile the whole program
$(OBJDIR)/$(OUT_NAME).elf: $(OBJDIR)/main.o $(OBJDIR)
	$(LD) $(LDFLAGS) -o $@ $<

# Assemble main file
$(OBJDIR)/main.o: $(SRCDIR)/main.s $(OBJDIR)
	$(AS) $(ASFLAGS) -o $@ $<


# Run the program on MIPSimu
run: copy
	$(MIPSimu)/mipsimu $<

# Create .bin file in MIPSimu build folder
copy: $(MIPSimu)/$(OUT_NAME).bin

# Create .bin file in MIPSimu build folder
$(MIPSimu)/$(OUT_NAME).bin: $(OBJDIR)/$(OUT_NAME).elf
	$(MIPSimu)/../elf2bin -o $@ $<


# Dump the program
dump: $(OBJDIR)/$(OUT_NAME).elf
	$(OD) $(ODFLAGS) $<


# Create object directory
$(OBJDIR):
	@mkdir $@

# Clean all generated files
clean:
	rm -f $(OBJDIR)/*.o $(OUT_NAME).elf
