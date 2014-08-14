; iNES header. This is included at the very beginning of the ROM file.
.byte $4e,$45,$53,$1a 		; NES/eof
.byte $08 					; # of 16kb PRG ROM
.byte $00 					; # of 8kb CHR ROM, 0 if CHR RAM
.byte $12					; flags6
							; 76543210
							; ||||||||
							; ||||+||+- 0xx0: vertical arrangement/horizontal mirroring (CIRAM A10 = PPU A11)
							; |||| ||   0xx1: horizontal arrangement/vertical mirroring (CIRAM A10 = PPU A10)
							; |||| ||   1xxx: four-screen VRAM
							; |||| |+-- 1: SRAM in CPU $6000-$7FFF, if present, is battery backed
							; |||| +--- 1: 512-byte trainer at $7000-$71FF (stored before PRG data)
							; ++++----- Lower nybble of mapper number
.byte $00 					; flags7
							; The PlayChoice-10 bit is not part of the official specification, and most
							; emulators simply ignore the extra 8KB of data. PlayChoice games are designed
							; to look good with the RGB PPU, which handles color emphasis differently from
							; a standard NES PPU.
							; 76543210
							; ||||||||
							; |||||||+- VS Unisystem
							; ||||||+-- PlayChoice-10 (8KB of Hint Screen data stored after CHR data)
							; ||||++--- If equal to 2, flags 8-15 are in NES 2.0 format
							; ++++----- Upper nybble of mapper umber
.byte $01 					; # 8kb PRG RAM, $00 infers 1 x 8kb for compatibility
.byte $00 					; flags9
							; Though in the official specification, very few emulators honor this bit
							; as virtually no ROM images in circulation make use of it.
							; 76543210
							; ||||||||
							; |||||||+- TV system (0: NTSC; 1: PAL)
							; +++++++-- Reserved, set to zero
.byte $00 					; flags10 (unofficial)
							; This byte is not part of the official specification, and relatively few
							; emulators honor it.
							; 76543210
							;   ||  ||
							;   ||  ++- TV system (0: NTSC; 2: PAL; 1/3: dual compatible)
							;   |+----- SRAM in CPU $6000-$7FFF is 0: present; 1: not present
							;   +------ 0: Board has no bus conflicts; 1: Board has bus conflicts
.byte $00,$00,$00,$00,$00 	; 11-15 are zero filled