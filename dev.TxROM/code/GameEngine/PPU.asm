;-------------------------------------[ Clear name tables ]------------------------------------------

ClearNameTables:
LC158:  jsr ClearNameTable0             ;Always clear name table 0 first.
LC15B:  lda GameMode                    ;
LC15D:  beq +                           ;Branch if mode = Play.
LC15F:  lda TitleRoutine                ;
LC161:  cmp #$1D                        ;If running the end game routine, clear-->
LC163:  beq ++                          ;name table 2, else clear name table 1.
LC165:* lda #$02                        ;Name table to clear + 1 (name table 1).
LC167:  bne +++                         ;Branch always.
LC169:* lda #$03                        ;Name table to clear + 1 (name table 2).
LC16B:  bne ++                          ;Branch always.

ClearNameTable0:
LC16D:* lda #$01                        ;Name table to clear + 1 (name table 0).
LC16F:* sta $01                         ;Stores name table to clear.
LC171:  lda #$FF                        ;
LC173:  sta $00                         ;Value to fill with.

ClearNameTable:
LC175:  ldx PPUStatus                   ;Reset PPU address latch.
LC178:  lda PPUCNT0ZP                   ;
LC17A:  and #$FB                        ;PPU increment = 1.
LC17C:  sta PPUCNT0ZP                   ;
LC17E:  sta PPUControl0                 ;Store control bits in PPU.
LC181:  ldx $01                         ;
LC183:  dex                             ;Name table = X - 1.
LC184:  lda HiPPUTable,x                ;get high PPU address.  pointer table at HiPPUTable.
LC187:  sta PPUAddress                  ;
LC18A:  lda #$00                        ;Set PPU start address (High byte first).
LC18C:  sta PPUAddress                  ;
LC18F:  ldx #$04                        ;Prepare to loop 4 times.
LC191:  ldy #$00                        ;Inner loop value.
LC193:  lda $00                         ;Fill-value.
LC195:* sta PPUIOReg                    ;
LC198:  dey                             ;
LC199:  bne -                           ;Loops until the desired name table is cleared.-->
LC19B:  dex                             ;It also clears the associated attribute table.
LC19C:  bne -                           ;
LC19E:  rts                             ;

;The following table is used by the above routine for finding
;the high byte of the proper name table to clear.

HiPPUTable:
LC19F:  .byte $20                       ;Name table 0.
LC1A0:  .byte $24                       ;Name table 1.
LC1A1:  .byte $28                       ;Name table 2.
LC1A2:  .byte $2C                       ;Name table 3.

;--------------------------------------[ Write to scroll registers ]---------------------------------

WriteScroll:
LC29A:  lda PPUStatus                   ;Reset scroll register flip/flop
LC29D:  lda ScrollX                     ;
LC29F:  sta PPUScroll                   ;
LC2A2:  lda ScrollY                     ;X and Y scroll offsets are loaded serially.
LC2A4:  sta PPUScroll                   ;
LC2A7:  rts                             ;

;-------------------------------------[ PPU writing routines ]---------------------------------------

;Checks if any data is waiting to be written to the PPU.
;RLE data is one tile that repeats several times in a row.  RLE-Repeat Last Entry

CheckPPUWrite:
LC2CA:  lda PPUDataPending              ;
LC2CC:  beq +                           ;If zero no PPU data to write, branch to exit.
LC2CE:  lda #$A1                        ;                       
LC2D0:  sta $00                         ;Sets up PPU writer to start at address $07A1.
LC2D2:  lda #$07                        ;
LC2D4:  sta $01                         ;$0000 = ptr to PPU data string ($07A1).
LC2D6:  jsr ProcessPPUString            ;write it to PPU.
LC2D9:  lda #$00                        ;
LC2DB:  sta PPUStrIndex                 ;PPU data string has been written so the data-->
LC2DE:  sta PPUDataString               ;stored for the write is now erased.
LC2E1:  sta PPUDataPending              ;
LC2E3:* rts                             ;

PPUWrite:
LC2E4:  sta PPUAddress                  ;Set high PPU address.
LC2E7:  iny                             ;
LC2E8:  lda ($00),y                     ;
LC2EA:  sta PPUAddress                  ;Set low PPU address.
LC2ED:  iny                             ;
LC2EE:  lda ($00),y                     ;Get data byte containing rep length & RLE status.
LC2F0:  asl                             ;Carry Flag = PPU address increment (0 = 1, 1 = 32).
LC2F1:  jsr SetPPUInc                   ;Update PPUCtrl0 according to Carry Flag.
LC2F4:  asl                             ;Carry Flag = bit 6 of byte at ($00),y (1 = RLE).
LC2F5:  lda ($00),y                     ;Get data byte again.
LC2F7:  and #$3F                        ;Keep lower 6 bits as loop counter.
LC2F9:  tax                             ;
LC2FA:  bcc PPUWriteLoop                ;If Carry Flag not set, the data is not RLE.
LC2FC:  iny                             ;Data is RLE, advance to data byte.

PPUWriteLoop:
LC2FD:  bcs +                           ;
LC2FF:  iny                             ;Only inc Y if data is not RLE.
LC300:* lda ($00),y                     ;Get data byte.
LC302:  sta PPUIOReg                    ;Write to PPU.
LC305:  dex                             ;Decrease loop counter.
LC306:  bne PPUWriteLoop                ;Keep going until X=0.
LC308:  iny                             ;
LC309:  jsr AddYToPtr00                 ;Point to next data chunk.

;Write data string at ($00) to PPU.

ProcessPPUString:
LC30C:  ldx PPUStatus                   ;Reset PPU address flip/flop.
LC30F:  ldy #$00                        ;
LC311:  lda ($00),y                     ;
LC313:  bne PPUWrite                    ;If A is non-zero, PPU data string follows,-->
LC315:  jmp WriteScroll                 ;Otherwise we're done.

;In: CF = desired PPU address increment (0 = 1, 1 = 32).
;Out: PPU control #0 ($2000) updated accordingly.

SetPPUInc:
LC318:  pha                             ;Preserve A.
LC319:  lda PPUCNT0ZP                   ;
LC31B:  ora #$04                        ;
LC31D:  bcs +                           ;PPU increment = 32 only if Carry Flag set,-->
LC31F:  and #$FB                        ;else PPU increment = 1.
LC321:* sta PPUControl0                 ;
LC323:  sta PPUCNT0ZP                   ;
LC326:  pla                             ;Restore A.
LC327:  rts                             ;

;Erase blasted tile on nametable.  Each screen is 16 tiles across and 15 tiles down.
EraseTile:
LC328:  ldy #$01                        ;
LC32A:  sty PPUDataPending              ;data pending = YES.
LC32C:  dey                             ;
LC32D:  lda ($02),y                     ;
LC32F:  and #$0F                        ;
LC331:  sta $05                         ;# of tiles horizontally.
LC333:  lda ($02),y                     ;
LC335:  jsr Adiv16                      ;/ 16.
LC338:  sta $04                         ;# of tiles vertically.
LC33A:  ldx PPUStrIndex                 ;
LC33D:* lda $01                         ;
LC33F:  jsr WritePPUByte                ;write PPU high address to $07A1,PPUStrIndex.
LC342:  lda $00                         ;
LC344:  jsr WritePPUByte                ;write PPU low address to $07A1,PPUStrIndex.
LC347:  lda $05                         ;data length.
LC349:  sta $06                         ;
LC34B:  jsr WritePPUByte                ;write PPU string length to $07A1,PPUStrIndex.
LC34E:* iny                             ;
LC34F:  lda ($02),y                     ;Get new tile to replace old tile.
LC351:  jsr WritePPUByte                ;Write it to $07A1,PPUStrIndex, inc x.
LC354:  dec $06                         ;
LC356:  bne -                           ;Branch if more horizontal tiles to replace.
LC358:  stx PPUStrIndex                 ;
LC35B:  sty $06                         ;
LC35D:  ldy #$20                        ;
LC35F:  jsr AddYToPtr00                 ;Move to next name table line.
LC362:  ldy $06                         ;Store index to find next tile info.
LC364:  dec $04                         ;
LC366:  bne --                          ;Branch if more lines need to be changed on name table.
LC368:  jsr EndPPUString                ;Finish writing PPU string and exit.

WritePPUByte:
LC36B:  sta PPUDataString,x             ;Store data byte at end of PPUDataString.

NextPPUByte:
LC36E:  inx                             ;PPUDataString has increased in size by 1 byte.
LC36F:  cpx #$4F                        ;PPU byte writer can only write a maximum of #$4F bytes
LC371:  bcc +                           ;If PPU string not full, branch to get more data.
LC373:  ldx PPUStrIndex                 ;

EndPPUString:
LC376:  lda #$00                        ;If PPU string is already full, or all PPU bytes loaded,-->
LC378:  sta PPUDataString,x             ;add #$00 as last byte to the PPU byte string.
LC37B:  pla                             ;
LC37C:  pla                             ;Remove last return address from stack and jump out of-->
LC37D:* rts                             ;PPU writing routines.

;The following routine is only used by the intro routine to load the sprite 
;palette data for the twinkling stars. The following memory addresses are used:
;$00-$01 Destination address for PPU write, $02-$03 Source address for PPU data,
;$04 Temp storage for PPU data byte, $05 PPU data string counter byte,
;$06 Temp storage for index byte.

PrepPPUPaletteString:
LC37E:  ldy #$01                        ;
LC380:  sty PPUDataPending              ;Indicate data waiting to be written to PPU.
LC382:  dey                             ;
LC383:  beq ++++                        ;Branch always

LC385:* sta $04                         ;$04 now contains next data byte to be put into the PPU string.
LC387:  lda $01                         ;High byte of staring address to write PPU data 
LC389:  jsr WritePPUByte                ;Put data byte into PPUDataString.
LC38c:  lda $00                         ;Low byte of starting address to write PPU data.
LC38E:  jsr WritePPUByte                ;Put data byte into PPUDataString.
LC391:  lda $04                         ;A now contains next data byte to be put into the PPU string.
LC393:  jsr SeparateControlBits         ;Break control byte into two bytes.

LC396:  bit $04                         ;Check to see if RLE bit is set in control byte.-->
LC398:  bvc WritePaletteStringByte      ;If not set, branch to load byte. Else increment index-->
LC39A:  iny                             ;to find repeating data byte.

WritePaletteStringByte:
LC39B:  bit $04                         ;Check if RLE bit is set (again). if set, load same-->
LC39D:  bvs +                           ;byte over and over again until counter = #$00.
LC39F:  iny                             ;Non-repeating data byte. Increment for next byte.
LC3A0:* lda ($02),y                     ;
LC3A2:  jsr WritePPUByte                ;Put data byte into PPUDataString.
LC3A5:  sty $06                         ;Temporarily store data index.
LC3A7:  ldy #$01                        ;PPU address increment = 1.
LC3A9:  bit $04                         ;If MSB set in control bit, it looks like this routine might-->
LC3AB:  bpl +                           ;have been used for a software control verticle mirror, but
                                        ;the starting address has already been written to the PPU-->
                                        ;string so this section has no effect whether the MSB is set-->
                                        ;or not. The PPU is always incremented by 1.
LC3AD:  ldy #$20                        ;PPU address increment = 32.
LC3AF:* jsr AddYToPtr00                 ;Set next PPU write address.(Does nothing, already set).
LC3B2:  ldy $06                         ;Restore data index to Y.
LC3B4:  dec $05                         ;Decrement counter byte.
LC3B6:  bne WritePaletteStringByte      ;If more bytes to write, branch to write another byte.
LC3B8:  stx PPUStrIndex                 ;Store total length, in bytes, of PPUDataString.
LC3BB:  iny                             ;Move to next data byte(should be #$00).

LC3BC:* ldx PPUStrIndex                 ;X now contains current length of PPU data string.
LC3BF:  lda ($02),y                     ;
LC3C1:  bne ----                        ;Is PPU string done loading (#$00)? If so exit,-->
LC3C3:  jsr EndPPUString                ;else branch to process PPU byte.

SeparateControlBits:
LC3C6:  sta $04                         ;Store current byte 
LC3C8:  and #$BF                        ;
LC3CA:  sta PPUDataString,x             ;Remove RLE bit and save control bit in PPUDataString.
LC3CD:  and #$3F                        ;
LC3CF:  sta $05                         ;Extract counter bits and save them for use above.
LC3D1:  jmp NextPPUByte                 ;

;---------------------------[ NMI and PPU control routines ]--------------------------------

; Wait for the NMI to end.

WaitNMIPass:    
LC42C:  jsr ClearNMIStat                ;Indicate currently in NMI.
LC42F:* lda NMIStatus                   ;
LC431:  beq -                           ;Wait for NMI to end.
LC433:  rts                             ;

ClearNMIStat:
LC434:  lda #$00                        ;Clear NMI byte to indicate the game is-->
LC436:  sta NMIStatus                   ;currently running NMI routines.
LC438:  rts                             ;

ScreenOff:
LC439:  lda PPUCNT1ZP                   ;
LC43B:  and #$E7                        ; BG & SPR visibility = off

WriteAndWait:
LC43D:* sta PPUCNT1ZP                   ;Update value to be loaded into PPU control register.

WaitNMIPass_:
LC43F:  jsr ClearNMIStat                ;Indicate currently in NMI.
LC442:* lda NMIStatus                   ;
LC444:  beq -                           ;Wait for NMI to end before continuing.
LC446:  rts                             ;

ScreenOn:
LC447:  lda PPUCNT1ZP                   ;
LC449:  ora #$1E                        ;BG & SPR visibility = on
LC44B:  bne --                          ;Branch always

;Update the actual PPU control registers.

WritePPUCtrl:
LC44D:  lda PPUCNT0ZP                   ;
LC44F:  sta PPUControl0                 ;
LC452:  lda PPUCNT1ZP                   ;Update PPU control registers.
LC454:  sta PPUControl1                 ;
LC457:  lda MirrorCntrl                 ;
LC459:  jsr PrepPPUMirror               ;Setup vertical or horizontal mirroring.

ExitSub:
LC45C:  rts                             ;Exit subroutines.

;Turn off both screen and NMI.

ScreenNmiOff:
LC45D:  lda PPUCNT1ZP                   ;
LC45F:  and #$E7                        ;BG & SPR visibility = off
LC461:  jsr WriteAndWait                ;Wait for end of NMI.
LC464:  lda PPUCNT0ZP                   ;Prepare to turn off NMI in PPU.
LC466:  and #$7F                        ;NMI = off
LC468:  sta PPUCNT0ZP                   ;
LC46A:  sta PPUControl0                 ;Actually load PPU register with NMI off value.
LC46D:  rts                             ;

;The following routine does not appear to be used.

LC46E:  lda PPUCNT0ZP                   ;Enable VBlank.
LC470:  ora #$80                        ;
LC472:  sta PPUCNT0ZP                   ;Write PPU control register 0 and PPU status byte.
LC474:  sta PPUControl0                 ;
LC477:  lda PPUCNT1ZP                   ;Turn sprites and screen on.
LC479:  ora #$1E                        ;
LC47B:  bne --                          ;Branch always.

VBOffAndHorzWrite: 
LC47D:  lda PPUCNT0ZP                   ;
LC47F:  and #$7B                        ;Horizontal write, disable VBlank. 
LC481:* sta PPUControl0                 ;Save new values in the PPU control register-->
LC484:  sta PPUCNT0ZP                   ;and PPU status byte.
LC486:  rts                             ;

NmiOn:
LC487:* lda PPUStatus                   ;
LC48A:  and #$80                        ;Wait for end of VBlank.
LC48C:  bne -                           ;
LC48E:  lda PPUCNT0ZP                   ;
LC490:  ora #$80                        ;Enable VBlank interrupts.
LC492:  bne --                          ;Branch always.

;-----------------------------------[ PPU mirroring routines ]---------------------------------------

PrepVertMirror:
LC4B2:  nop                             ;
LC4B3:  nop                             ;Prepare to set PPU for vertical mirroring (again).
LC4B4:  lda #$47                        ;

SetPPUMirror:
LC4B6:  lsr                             ;
LC4B7:  lsr                             ;Move bit 3 to bit 0 position.
LC4B8:  lsr                             ;
LC4B9:  and #$01                        ;Remove all other bits.
    sta MMC3Mirroring
    
LC4D8:  rts                             ;

PrepPPUMirror:
LC4D9:  lda MirrorCntrl                 ;Load MirrorCntrl into A.
LC4DB:  jmp SetPPUMirror                ;Set mirroring through MMC1 chip.

;---------------------------------[Write PPU attribute table data ]----------------------------------

WritePPUAttribTbl:
LE5E2:  ldx #$C0                        ;Low byte of First row of attribute table.
LE5E4:  lda RoomNumber                  ;
LE5E6:  cmp #$F2                        ;Is this the second pass through the routine?-->
LE5E8:  beq +                           ;If so, branch.
LE5EA:  ldx #$E0                        ;Low byte of second row of attribute table.
LE5EC:* stx $00                         ;$0000=RoomRAM atrrib table starting address.
LE5EE:  stx $02                         ;$0002=PPU attrib table starting address.
LE5F0:  jsr GetNameAddrs                ;Get name table addr and corresponding RoomRAM addr.
LE5F3:  ora #$03                        ;#$23 for attrib table 0, #$2F for attrib table 3.
LE5F5:  sta $03                         ;Store results.
LE5F7:  txa                             ;move high byte of RoomRAM to A.
LE5F8:  ora #$03                        ;#$63 for RoomRAMA, #$67 for RoomRAMB(Attrib tables).
LE5FA:  sta $01                         ;Store results.
LE5FC:  lda #$01                        ;
LE5FE:  sta PPUDataPending              ;Data pending = YES.
LE600:  ldx PPUStrIndex                 ;Load current index into PPU strng to append data.
LE603:  lda $03                         ;Store high byte of starting address(attrib table).
LE605:  jsr WritePPUByte                ;Put data byte into PPUDataString.
LE608:  lda $02                         ;Store low byte of starting address(attrib table).
LE60A:  jsr WritePPUByte                ;Put data byte into PPUDataString.
LE60D:  lda #$20                        ;Length of data to write(1 row of attrib data).
LE60F:  sta $04                         ;
LE611:  jsr WritePPUByte                ;Write control byte. Horizontal write.
LE614:  ldy #$00                        ;Reset index into data string.
LE616:* lda ($00),y                     ;Get data byte.
LE618:  jsr WritePPUByte                ;Put data byte into PPUDataString.
LE61B:  iny                             ;Increment to next attrib data byte.
LE61C:  dec $04                         ;
LE61E:  bne -                           ;Loop until all attrib data loaded into PPU.
LE620:  stx PPUStrIndex                 ;Store updated PPU string index.
LE623:  jsr EndPPUString                ;Append end marker(#$00) and exit writing routines.