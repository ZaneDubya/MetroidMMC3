; METROID source code
; (C) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, 
;      GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Can be reassembled using Ophis.
;Game engine (memory page 7)

;-----------------------------------------------[ RESET ]--------------------------------------------

RESET:
    SEI                             ; Disables interrupt
    CLD                             ; Sets processor to binary mode
    LDX #$00                        ; 
    STX PPUControl0                 ; Clear PPU control registers
    STX PPUControl1                 ; 
*   LDA PPUStatus                   ; 
    BPL -                           ; Wait for VBlank
*   LDA PPUStatus                   ; 
    BPL -                           ; 
    lda #$06                    ; 
    sta $8000
    stx $8001
    inx
    lda #$07
    sta MMC3BankSelect
    stx MMC3BankData
    jmp Startup                 ; Do preliminary housekeeping.

;---------------------------------[ Startup ]-----------------------------------
Startup:
    lda #$00                            ; A = $00
    jsr MMCWriteReg3                    ;Swap to PRG bank #0 at $8000
    tax                                 ; X = $00
    dex                                 ; X = $FF
    txs                                 ; S points to end of stack page
;Clear RAM at $000-$7FF.
    ldy #$07                            ;High byte of start address.
    sty $01                             ;
    ldy #$00                            ;Low byte of start address.
    sty $00                             ;$0000 = #$0700
    tya                                 ;A = 0
*       sta ($00),y                     ;clear address
    iny                                 ;
    bne -                               ;Repeat for entire page.
    dec $01                             ;Decrement high byte of address.
    bmi +                               ;If $01 < 0, all pages are cleared.
    ldx $01                             ;
    cpx #$01                            ;Keep looping until ram is cleared.
    bne -                               ;

;Clear cartridge RAM at $6000-$7FFF.
*   ldy #$7F                        ;High byte of start address.
    sty $01                         ;
    ldy #$00                        ;Low byte of start address.
    sty $00                         ;$0000 points to $7F00
    tya                             ;A = 0
*   sta ($00),y                     ;
    iny                             ;Clears 256 bytes of memory before decrementing to next-->
    bne -                           ;256 bytes.
    dec $01                         ;
    ldx $01                         ;Is address < $6000?-->
    cpx #$60                        ;If not, do another page.
    bcs -                           ; 
    lda #$00                        ;Clear bits 3 and 4 of MMC1 register 3.
    sta SwitchUpperBits             ;
    ldy #$00                        ;
    sty ScrollX                     ;ScrollX = 0
    sty ScrollY                     ;ScrollY = 0
    sty PPUScroll                   ;Clear hardware scroll x
    sty PPUScroll                   ;Clear hardware scroll y
    iny                             ;Y = #$01
    sty GameMode                    ;Title screen mode
    jsr ClearNameTables             ;
    jsr EraseAllSprites             ;

    lda #%10010000                  ;NMI = enabled
                                        ;Sprite size = 8x8
                                        ;BG pattern table address = $1000
                                        ;SPR pattern table address = $0000
                                        ;PPU address increment = 1
                                        ;Name table address = $2000
    sta PPUControl0                 ;
    sta PPUCNT0ZP                   ;

    lda #%00000010                  ;Sprites visible = no
                                        ;Background visible = no
                                        ;Sprite clipping = yes
                                        ;Background clipping = no
                                        ;Display type = color
    sta PPUCNT1ZP                   ;

    lda #$47                        ;
    sta MirrorCntrl                 ;Prepare to set PPU to vertical mirroring.
    jsr PrepVertMirror              ;

    lda #$00                        ;
    sta DMCCntrl1                   ;PCM volume = 0 - disables DMC channel
    lda #$0F                        ;
    sta APUCommonCntrl0             ;Enable sound channel 0,1,2,3

    ldy #$00                        ;
    sty TitleRoutine                ;Set title routine and and main routine function-->
    sty MainRoutine                 ;pointers equal to 0.
    lda #$11                        ;
    sta RandomNumber1               ;Initialize RandomNumber1 to #$11
    lda #$FF                        ;
    sta RandomNumber2               ;Initialize RandomNumber2 to #$FF

    iny                             ;Y = 1
    sty SwitchPending               ;Prepare to switch page 0 into lower PRGROM.
    jsr CheckSwitch                 ;
    bne WaitNMIEnd                  ;Branch always
    
;--------------------------------[ WaitNMIEnd ]---------------------------------
; This routine will wait until NMIStatus is nonzero.

WaitNMIEnd:
    tay                             ;
    lda NMIStatus                   ;
    bne +                           ;If nonzero, NMI has ended. Else keep waiting.
    jmp WaitNMIEnd                  ;

*   jsr RandomNumbers               ;Update pseudo random numbers.
    jmp MainLoop                    ;Jump to top of subroutine. 
    
;-------------------------------------[ Non-Maskable Interrupt ]-------------------------------------
;The NMI is called 60 times a second by the VBlank signal from the PPU. When the
;NMI routine is called, the game should already be waiting for it in the main 
;loop routine in the WaitNMIEnd loop.  It is possible that the main loop routine
;will not be waiting as it is bogged down with excess calculations. This causes
;the game to slow down.

NMI:
    php                             ;Save processor status, A, X and Y on stack.
    pha                             ;Save A.
    txa                             ;
    pha                             ;Save X.
    tya                             ;
    pha                             ;Save Y.
    lda #$00                        ;
    sta SPRAddress                  ;Sprite RAM address = 0.
    lda #$02                        ;
    sta SPRDMAReg                   ;Transfer page 2 ($200-$2FF) to Sprite RAM.
    lda NMIStatus                   ;
    bne ++                          ;Skip if the frame couldn't finish in time.
    lda GameMode                    ;
    beq +                           ;Branch if mode=Play.
    jsr NMIScreenWrite              ;Write end message on screen(If appropriate).
*   jsr CheckPalWrite               ;Check if palette data pending.
    jsr CheckPPUWrite               ;check if data needs to be written to PPU.
    jsr WritePPUCtrl                ;Update $2000 & $2001.
    jsr WriteScroll                 ;Update h/v scroll reg.
    jsr ReadJoyPads                 ;Read both joypads.
*   jsr SoundEngine                 ;Update music and SFX.
    jsr UpdateAge                   ;Update Samus' age.
    ldy #$01                        ; NMI = finished.
    sty NMIStatus                   ;
    pla                             ;Restore Y.
    tay                             ;
    pla                             ;Restore X.
    tax                             ;
    pla                             ;restore A.
    plp                             ;Restore processor status flags.
    rti                             ;Return from NMI.