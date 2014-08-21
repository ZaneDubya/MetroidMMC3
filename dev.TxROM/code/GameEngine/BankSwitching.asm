;-----------------------------[ Switch bank and init bank routines ]---------------------------------
;This is how the bank switching works... Every frame, the routine below
;is executed. First, it checks the value of SwitchPending. If it is zero,
;the routine will simply exit. If it is non-zero, it means that a bank
;switch has been issued, and must be performed. SwitchPending then contains
;the bank to switch to, plus one.

CheckBankSwitch:
    ldy SwitchPending               ;
    beq +                           ;Exit if zero(no bank switch issued). else Y contains bank#+1.
    jsr PerformBankSwitch           ;Perform bank switch.
    jmp GoBankInit                  ;Initialize bank switch data.
*   rts

PerformBankSwitch:
    lda #$00                        ;Reset(so that the bank switch won't be performed-->
    sta SwitchPending               ;every succeeding frame too).
    dey                             ;Y now contains the bank to switch to.
    sty CurrentBank                 ;

BankSwitch:
    tya                             ;
    sta $00                         ;Bank to switch to is stored at location $00.
    lda SwitchUpperBits             ;Load upper two bits for Reg 3 (they should always be 0).
    and #$18                        ;Extract bits 3 and 4 and add them to the current-->
    ora $00                         ;bank to switch to.
    sta SwitchUpperBits             ;Store any new bits set in 3 or 4(there should be none).

;Loads the lower memory page with the bank specified in A.
MMCWriteReg3:
    asl
    tay
    lda #$06                    
    sta $8000
    sty $8001
    iny
    lda #$07
    sta $8000
    sty $8001
    lda $00                         ;Restore A with current bank number before exiting.
    rts                             ;

;Calls the proper routine according to the bank number in A.
GoBankInit:
    asl                             ;*2 For proper table offset below.
    tay                             ;
    lda BankInitTable,y             ;
    sta $0A                         ;Load appropriate subroutine address into $0A and $0B.
    lda BankInitTable+1,y   ;
    sta $0B                         ;
    jmp ($000A)                     ;Jump to appropriate initialization routine.

BankInitTable:
    .word InitBank0                 ;Initialize bank 0.
    .word InitBank1                 ;Initialize bank 1.
    .word InitBank2                 ;Initialize bank 2.
    .word InitBank3                 ;Initialize bank 3.
    .word InitBank4                 ;Initialize bank 4.
    .word InitBank5                 ;Initialize bank 5.
    .word ExitSub                   ;Rts
    .word ExitSub                   ;Rts
    .word ExitSub                   ;Rts

;Title screen memory page.

InitBank0:
LC531:  ldy #$00                        ;
LC533:  sty GamePaused                  ;Ensure game is not paused.
LC535:  iny                             ;Y=1.
LC536:  sty GameMode                    ;Game is at title routines.
LC538:  jsr ScreenNmiOff                ;Waits for NMI to end then turns it off.
LC53B:  jsr CopyMap                     ;Copy game map from ROM to cartridge RAM $7000-$73FF
LC53E:  jsr ClearNameTables             ;Erase name table data.

LC541:  ldy #$A0                        ;
LC543:* lda $98BF,y                     ;
LC546:  sta $6DFF,y                     ;Loads sprite info for stars into RAM $6E00 thru 6E9F.
LC549:  dey                             ;
LC54A:  bne -                           ;

LC54C:  jsr InitTitleGFX                ;Load title GFX.
LC54F:  jmp NmiOn                       ;Turn on VBlank interrupts.

;Brinstar memory page.

InitBank1:
LC552:  lda #$00                        ;
LC554:  sta GameMode                    ;GameMode = play.
LC556:  jsr ScreenNmiOff                ;Disable screen and Vblank.
LC559:  lda MainRoutine                 ;
LC55B:  cmp #$03                        ;Is game engine running? if so, branch.-->
LC55D:  beq +                           ;Else do some housekeeping first.
LC55F:  lda #$00                        ;
LC561:  sta MainRoutine                 ;Run InitArea routine next.
LC563:  sta InArea                      ;Start in Brinstar.
LC565:  sta GamePaused                  ;Make sure game is not paused.
LC567:  jsr ClearRAM_33_DF              ;Clear game engine memory addresses.
LC56A:  jsr ClearSamusStats             ;Clear Samus' stats memory addresses.
LC56D:* ldy #$00                        ;
LC56F:  jsr BankSwitch                   ;Load Brinstar memory page into lower 16Kb memory.
LC572:  jsr InitBrinstarGFX             ;Load Brinstar GFX.
LC575:  jmp NmiOn                       ;Turn on VBlank interrupts.

ClearSamusStats:
LC578:  ldy #$0F                        ;
LC57A:  lda #$00                        ;Clears Samus stats(Health, full tanks, game timer, etc.).
LC57C:* sta $0100,y                     ;Load $100 thru $10F with #$00.
LC57F:  dey                             ;
LC580:  bpl -                           ;Loop 16 times.
LC582:  rts                             ;

;Norfair memory page.

InitBank2:
LC583:  lda #$00                        ;GameMode = play.
LC585:  sta GameMode                    ;
LC587:  jsr ScreenNmiOff                ;Disable screen and Vblank.
LC58A:  jsr InitNorfairGFX              ;Load Norfair GFX.
LC58D:  jmp NmiOn                       ;Turn on VBlank interrupts.

;Tourian memory page.

InitBank3:
LC590:  lda #$00                        ;GameMode = play.
LC592:  sta GameMode                    ;
LC594:  jsr ScreenNmiOff                ;Disable screen and Vblank.
LC597:  ldy #$0D                        ;
LC599:* lda MetroidData,y               ;Load info from table below into-->
LC59C:  sta $77F0,y                     ;$77F0 thru $77FD.
LC59F:  dey                             ;
LC5A0:  bpl -                           ;
LC5A2:  jsr InitTourianGFX              ;Load Tourian GFX.
LC5A5:  jmp NmiOn                       ;Turn on VBlank interrupts.

;Table used by above subroutine and loads the initial data used to describe
;metroid's behavior in the Tourian section of the game.

MetroidData:
LC5A8:  .byte $F8, $08, $30, $D0, $60, $A0, $02, $04, $00, $00, $00, $00, $00, $00

;Kraid memory page.

InitBank4:
LC5B6:  lda #$00                        ;GameMode = play.
LC5B8:  sta GameMode                    ;
LC5BA:  jsr ScreenNmiOff                ;Disable screen and Vblank.
LC5BD:  jsr InitKraidGFX                ;Load Kraid GFX.
LC5C0:  jmp NmiOn                       ;Turn on VBlank interrupts.

;Ridley memory page.

InitBank5:
LC5C3:  lda #$00                        ;GameMode = play.
LC5C5:  sta GameMode                    ;
LC5C7:  jsr ScreenNmiOff                ;Disable screen and Vblank.
LC5CA:  jsr InitRidleyGFX               ;Loag Ridley GFX.
LC5CD:  jmp NmiOn                       ;Turn on VBlank interrupts.

InitEndGFX:
LC5D0:  lda #$01                        ;
LC5D2:  sta GameMode                    ;Game is at title/end game.
LC5D4:  jmp InitGFX6                    ;Load end game GFX.

InitTitleGFX:
LC5D7:  ldy #$15                        ;Entry 21 in GFXInfo table.
LC5D9:  jsr LoadGFX                     ;Load pattern table GFX.

LoadSamusGFX:
LC5DC:  ldy #$00                        ;Entry 0 in GFXInfo table.
LC5DE:  jsr LoadGFX                     ;Load pattern table GFX.
LC5E1:  lda JustInBailey                ;
LC5E4:  beq +                           ;Branch if wearing suit
LC5E6:  ldy #$1B                        ;Entry 27 in GFXInfo table.
LC5E8:  jsr LoadGFX                     ;Switch to girl gfx
LC5EB:* ldy #$14                        ;Entry 20 in GFXInfo table.
LC5ED:  jsr LoadGFX                     ;Load pattern table GFX.
LC5F0:  ldy #$17                        ;Entry 23 in GFXInfo table.
LC5F2:  jsr LoadGFX                     ;Load pattern table GFX.
LC5F5:  ldy #$18                        ;Entry 24 in GFXInfo table.
LC5F7:  jsr LoadGFX                     ;Load pattern table GFX.
LC5FA:  ldy #$19                        ;Entry 25 in GFXInfo table.
LC5FC:  jsr LoadGFX                     ;Load pattern table GFX.
LC5FF:  ldy #$16                        ;Entry 22 in GFXInfo table.
LC601:  jmp LoadGFX                     ;Load pattern table GFX.

InitBrinstarGFX:
LC604:  ldy #$03                        ;Entry 3 in GFXInfo table.
LC606:  jsr LoadGFX                     ;Load pattern table GFX.
Lc609:  ldy #$04                        ;Entry 4 in GFXInfo table.
LC60B:  jsr LoadGFX                     ;Load pattern table GFX.
LC60E:  ldy #$05                        ;Entry 5 in GFXInfo table.
LC610:  jsr LoadGFX                     ;Load pattern table GFX.
LC613:  ldy #$06                        ;Entry 6 in GFXInfo table.
LC615:  jsr LoadGFX                     ;Load pattern table GFX.
LC618:  ldy #$19                        ;Entry 25 in GFXInfo table.
LC61A:  jsr LoadGFX                     ;Load pattern table GFX.
LC61D:  ldy #$16                        ;Entry 22 in GFXInfo table.
LC61F:  jmp LoadGFX                     ;Load pattern table GFX.

InitNorfairGFX:
LC622:  ldy #$04                        ;Entry 4 in GFXInfo table.
LC624:  jsr LoadGFX                     ;Load pattern table GFX.
LC627:  ldy #$05                        ;Entry 5 in GFXInfo table.
LC629:  jsr LoadGFX                     ;Load pattern table GFX.
LC62C:  ldy #$07                        ;Entry 7 in GFXInfo table.
LC62E:  jsr LoadGFX                     ;Load pattern table GFX.
LC631:  ldy #$08                        ;Entry 8 in GFXInfo table.
LC633:  jsr LoadGFX                     ;Load pattern table GFX.
LC636:  ldy #$09                        ;Entry 9 in GFXInfo table.
LC638:  jsr LoadGFX                     ;Load pattern table GFX.
LC63B:  ldy #$19                        ;Entry 25 in GFXInfo table.
LC63D:  jsr LoadGFX                     ;Load pattern table GFX.
LC640:  ldy #$16                        ;Entry 22 in GFXInfo table.
LC642:  jmp LoadGFX                     ;Load pattern table GFX.

InitTourianGFX:
LC645:  ldy #$05                        ;Entry 5 in GFXInfo table.
LC647:  jsr LoadGFX                     ;Load pattern table GFX.
LC64A:  ldy #$0A                        ;Entry 10 in GFXInfo table.
LC64C:  jsr LoadGFX                     ;Load pattern table GFX.
LC64F:  ldy #$0B                        ;Entry 11 in GFXInfo table.
LC651:  jsr LoadGFX                     ;Load pattern table GFX.
LC654:  ldy #$0C                        ;Entry 12 in GFXInfo table.
LC656:  jsr LoadGFX                     ;Load pattern table GFX.
LC659:  ldy #$0D                        ;Entry 13 in GFXInfo table.
LC65B:  jsr LoadGFX                     ;Load pattern table GFX.
LC65E:  ldy #$0E                        ;Entry 14 in GFXInfo table.
LC660:  jsr LoadGFX                     ;Load pattern table GFX.
LC663:  ldy #$1A                        ;Entry 26 in GFXInfo table.
LC665:  jsr LoadGFX                     ;Load pattern table GFX.
LC668:  ldy #$1C                        ;Entry 28 in GFXInfo table.
LC66A:  jsr LoadGFX                     ;Load pattern table GFX.
LC66D:  ldy #$19                        ;Entry 25 in GFXInfo table.
LC66F:  jsr LoadGFX                     ;Load pattern table GFX.
LC672:  ldy #$16                        ;Entry 22 in GFXInfo table.
LC674:  jmp LoadGFX                     ;Load pattern table GFX.

InitKraidGFX:
LC677:  ldy #$04                        ;Entry 4 in GFXInfo table.
LC679:  jsr LoadGFX                     ;Load pattern table GFX.
LC67C:  ldy #$05                        ;Entry 5 in GFXInfo table.
LC67E:  jsr LoadGFX                     ;Load pattern table GFX.
LC681:  ldy #$0A                        ;Entry 10 in GFXInfo table.
LC683:  jsr LoadGFX                     ;Load pattern table GFX.
LC686:  ldy #$0F                        ;Entry 15 in GFXInfo table.
LC688:  jsr LoadGFX                     ;Load pattern table GFX.
LC68B:  ldy #$10                        ;Entry 16 in GFXInfo table.
LC68D:  jsr LoadGFX                     ;Load pattern table GFX.
LC690:  ldy #$11                        ;Entry 17 in GFXInfo table.
LC692:  jsr LoadGFX                     ;Load pattern table GFX.
LC695:  ldy #$19                        ;Entry 25 in GFXInfo table.
LC697:  jsr LoadGFX                     ;Load pattern table GFX.
LC69A:  ldy #$16                        ;Entry 22 in GFXInfo table.
LC69C:  jmp LoadGFX                     ;Load pattern table GFX.

InitRidleyGFX:
LC69F:  ldy #$04                        ;Entry 4 in GFXInfo table.
LC6A1:  jsr LoadGFX                     ;Load pattern table GFX.
LC6A4:  ldy #$05                        ;Entry 5 in GFXInfo table.
LC6A6:  jsr LoadGFX                     ;Load pattern table GFX.
LC6A9:  ldy #$0A                        ;Entry 10 in GFXInfo table.
LC6AB:  jsr LoadGFX                     ;Load pattern table GFX.
LC6AE:  ldy #$12                        ;Entry 18 in GFXInfo table.
LC6B0:  jsr LoadGFX                     ;Load pattern table GFX.
LC6B3:  ldy #$13                        ;Entry 19 in GFXInfo table.
LC6B5:  jsr LoadGFX                     ;Load pattern table GFX.
LC6B8:  ldy #$19                        ;Entry 25 in GFXInfo table.
LC6BA:  jsr LoadGFX                     ;Load pattern table GFX.
LC6BD:  ldy #$16                        ;Entry 22 in GFXInfo table.
LC6BF:  jmp LoadGFX                     ;Load pattern table GFX.

InitGFX6:
LC6C2:  ldy #$01                        ;Entry 1 in GFXInfo table.
LC6C4:  jsr LoadGFX                     ;Load pattern table GFX.
LC6C7:  ldy #$02                        ;Entry 2 in GFXInfo table.
LC6C9:  jsr LoadGFX                     ;Load pattern table GFX.
LC6CC:  ldy #$19                        ;Entry 25 in GFXInfo table.
LC6CE:  jsr LoadGFX                     ;Load pattern table GFX.
LC6D1:  ldy #$16                        ;Entry 22 in GFXInfo table.
LC6D3:  jmp LoadGFX                     ;Load pattern table GFX.

InitGFX7:
LC6D6:  ldy #$17                        ;Entry 23 in GFXInfo table.
LC6D8:  jsr LoadGFX                     ;Load pattern table GFX.
LC6DB:  ldy #$16                        ;Entry 22 in GFXInfo table.
LC6DD:  jmp LoadGFX                     ;Load pattern table GFX.

;The table below contains info for each tile data block in the ROM.
;Each entry is 7 bytes long. The format is as follows:
;byte 0: ROM bank where GFX data is located.
;byte 1-2: 16-bit ROM start address (src).
;byte 3-4: 16-bit PPU start address (dest).
;byte 5-6: data length (16-bit).

GFXInfo:
LC6E0:  .byte $06                       ;[SPR]Samus, items.             Entry 0.
LC6E1:  .word $8000, $0000, $09A0
LC6E7:  .byte $04                       ;[SPR]Samus in ending.          Entry 1.
LC6E8:  .word $8D60, $0000, $0520
LC6EE:  .byte $01                       ;[BGR]Partial font, "The End".  Entry 2.
LC6EF:  .word $8D60, $1000, $0400
LC6F5:  .byte $06                       ;[BGR]Brinstar rooms.           Entry 3.
LC6F6:  .word $9DA0, $1000, $0150
LC6FC:  .byte $05                       ;[BGR]Misc. objects.            Entry 4.
LC6FD:  .word $8D60, $1200, $0450
LC703:  .byte $06                       ;[BGR]More Brinstar rooms.      Entry 5.
LC704:  .word $9EF0, $1800, $0800
LC70A:  .byte $01                       ;[SPR]Brinstar enemies.         Entry 6.
LC70B:  .word $9160, $0C00, $0400
LC711:  .byte $06                       ;[BGR]Norfair rooms.            Entry 7.
LC712:  .word $A6F0, $1000, $0260
LC718:  .byte $06                       ;[BGR]More Norfair rooms.       Entry 8.
LC719:  .word $A950, $1700, $0070
LC71F:  .byte $02                       ;[SPR]Norfair enemies.          Entry 9.
LC720:  .word $8D60, $0C00, $0400
LC726:  .byte $06                       ;[BGR]Tourian rooms.            Entry 10.
LC727:  .word $A9C0, $1000, $02E0
LC72D:  .byte $06                       ;[BGR]More Tourian rooms.       Entry 11.
LC72E:  .word $ACA0, $1200, $0600
LC734:  .byte $06                       ;[BGR]Mother Brain room.        Entry 12.
LC735:  .word $B2A0, $1900, $0090
LC73B:  .byte $05                       ;[BGR]Misc. object.             Entry 13.
LC73C:  .word $91B0, $1D00, $0300
LC742:  .byte $02                       ;[SPR]Tourian enemies.          Entry 14.
LC743:  .word $9160, $0C00, $0400
LC749:  .byte $06                       ;[BGR]More Tourian rooms.       Entry 15.
LC74A:  .word $B330, $1700, $00C0
LC750:  .byte $04                       ;[BGR]Misc. object and fonts.   Entry 16.
LC751:  .word $9360, $1E00, $0200
LC757:  .byte $03                       ;[SPR]Miniboss I enemies.       Entry 17.
LC758:  .word $8D60, $0C00, $0400
LC75E:  .byte $06                       ;[BGR]More Tourian Rooms.       Entry 18.
LC75F:  .word $B3F0, $1700, $00C0
LC765:  .byte $03                       ;[SPR]Miniboss II enemies.      Entry 19.
LC766:  .word $9160, $0C00, $0400
LC76C:  .byte $06                       ;[SPR]Inrto/End sprites.        Entry 20.
LC76D:  .word $89A0, $0C00, $0100
LC773:  .byte $06                       ;[BGR]Title.                    Entry 21.
LC774:  .word $8BE0, $1400, $0500
LC77A:  .byte $06                       ;[BGR]Solid tiles.              Entry 22.
LC77B:  .word $9980, $1FC0, $0040
LC781:  .byte $06                       ;[BGR]Complete font.            Entry 23.
LC782:  .word $B4C0, $1000, $0400
LC788:  .byte $06                       ;[BGR]Complete font.            Entry 24.
LC789:  .word $B4C0, $0A00, $00A0
LC78F:  .byte $06                       ;[BGR]Solid tiles.              Entry 25.
LC790:  .word $9980, $0FC0, $0040
LC796:  .byte $06                       ;[BGR]Complete font.            Entry 26.
LC797:  .word $B4C0, $1D00, $02A0
LC79D:  .byte $06                       ;[SPR]Suitless Samus.           Entry 27.
LC79E:  .word $90E0, $0000, $07B0
LC7A4:  .byte $06                       ;[BGR]Exclaimation point.       Entry 28.
LC7A5:  .word $9890, $1F40, $0010

;--------------------------------[ Pattern table loading routines ]---------------------------------

;Y contains the GFX header to fetch from the table above, GFXInfo.

LoadGFX:
LC7AB:  lda #$FF                        ;
LC7AD:* clc                             ;Every time y decrements, the entry into the table-->
LC7AE:  adc #$07                        ;is increased by 7.  When y is less than 0, A points-->
LC7B0:  dey                             ;to the last byte of the entry in the table.
LC7B1:  bpl -                           ;
LC7B3:  tay                             ;Transfer offset into table to Y.

LC7B4:  ldx #$06                        ;
LC7B6:* lda GFXInfo,y                   ;
LC7B9:  sta $00,x                       ;Copy entries from GFXInfo to $00-$06.
LC7BB:  dey                             ;
LC7BC:  dex                             ;
LC7BD:  bpl -                           ;

LC7BF:  ldy $00                         ;ROM bank containing the GFX data.
LC7C1:  jsr BankSwitch                   ;Switch to that bank.
LC7C4:  lda PPUCNT0ZP                   ;
LC7C6:  and #$FB                        ;
LC7C8:  sta PPUCNT0ZP                   ;Set the PPU to increment by 1.
LC7CA:  sta PPUControl0                 ;
LC7CD:  jsr CopyGFXBlock                ;Copy graphics into pattern tables.
LC7D0:  ldy CurrentBank                 ;
LC7D2:  jmp BankSwitch                   ;Switch back to the "old" bank.

;Writes tile data from ROM to VRAM, according to the gfx header data
;contained in $00-$06.

CopyGFXBlock:
LC7D5:  lda $05                         ;
LC7D7:  bne GFXCopyLoop                 ;If $05 is #$00, decrement $06 before beginning.
LC7D9:  dec $06                         ;

GFXCopyLoop:
LC7DB:  lda $04                         ;
LC7DD:  sta PPUAddress                  ;Set PPU to proper address for GFX block write.
LC7E0:  lda $03                         ;
LC7E2:  sta PPUAddress                  ;
LC7E5:  ldy #$00                        ;Set offset for GFX data to 0.
LC7E7:* lda ($01),y                     ;
LC7E9:  sta PPUIOReg                    ;Copy GFX data byte from ROM to Pattern table.
LC7EC:  dec $05                         ;Decrement low byte of data length.
LC7EE:  bne +                           ;Branch if high byte does not need decrementing.
LC7F0:  lda $06                         ;
LC7F2:  beq ++                          ;If copying complete, branch to exit.
LC7F4:  dec $06                         ;Decrement when low byte has reached 0.
LC7F6:* iny                             ;Increment to next byte to copy.
LC7F7:  bne --                          ;
LC7F9:  inc $02                         ;After 256 bytes loaded, increment upper bits of-->
LC7FB:  inc $04                         ;Source and destination addresses.
LC7FD:  jmp GFXCopyLoop                 ;(&C7DB)Repeat copy routine.
LC800:* rts                             ;