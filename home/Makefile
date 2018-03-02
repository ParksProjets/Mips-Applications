#
#  Build the home menu.
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
APPDIR := apps

MAKEAPPS := ./scripts/makeapps
STARTUP := $(SRCDIR)/startup/startup.s
STARTUP_OBJ := startup.o

OUT_NAME := home
MIPSimu := ../../MIPSimu/build

# Compile flags
ASFLAGS = -G0 -mips32 -EB -mabi=32 -non_shared --warn -Isrc/
LDFLAGS = -G0 -mips3 --static -T $(LD_SCRIPT)
ODFLAGS = -D --section=.text --section=.data -M no-aliases -M reg-names=numeric

.PHONY: run copy dump clean


# Link all apps into a single ELF file.
$(OBJDIR)/$(OUT_NAME).elf: $(OBJDIR)/home.o $(OBJDIR)/$(STARTUP_OBJ) $(LD_SCRIPT)
	$(LD) $(LDFLAGS) -o $@  $(OBJDIR)/*.o

# Create the LD script
$(LD_SCRIPT): $(OBJDIR)/$(STARTUP_OBJ) $(OBJDIR)/home.o $(APPDIR)/*.ini
	# $(MAKEAPPS)

# Create the ASM data
$(SRCDIR)/menu/apps-data.s: $(APPDIR)/*.ini
	# $(MAKEAPPS)


# Assemble Home Menu
$(OBJDIR)/home.o: $(SRCDIR)/main.s $(OBJDIR) $(SRCDIR)/menu/apps-data.s
	$(AS) $(ASFLAGS) -o $@ $<

# Assemble the startup
$(OBJDIR)/$(STARTUP_OBJ): $(STARTUP)
	$(AS) $(ASFLAGS) -o $@ $<


# Run the program on MIPSimu
run: copy
	$(MIPSimu)/mipsimu --r2 $(MIPSimu)/$(OUT_NAME).bin

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
	rm -f $(OBJDIR)/*.o $(OUT_NAME).elf $(LD_SCRIPT)
