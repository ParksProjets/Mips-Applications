# Generated by apps2asm.py

.section .zdata

.set kNumberOfApps, 4

kFlapsTheMipsTitle: .word 0x26311104, 0x1F013835, 0x18012A2D, 0x001E1B14
kPongTitle: .word 0x31340E04, 0x292A3734, 0x33341B01, 0x0000002C
kMipsInvaderTitle: .word 0x352E1804, 0x33140138, 0x2A29263B, 0x00000037
kScreenSaverTitle: .word 0x392A1804, 0x012A3739, 0x3501332A, 0x2A383A26

kAppTexts: .word kScreenSaverTitle, kMipsInvaderTitle, kPongTitle, kFlapsTheMipsTitle
kAppEntries: .word __flaps_the_mips_main, __pong_main, __mips_invader_main, __screen_saver_main, lock_system, blue_screen
