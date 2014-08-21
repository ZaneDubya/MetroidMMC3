;----------------------------------[ Saved game routines (not used) ]--------------------------------

AccessSavedGame:
LCA35:  pha                             ;Save two copies of A. Why? Who knows. This code is-->
LCA36:  pha                             ;Never implemented. A contains data slot to work on.
LCA37:  jsr GetGameDataIndex            ;Get index to this save game Samus data info.
LCA3A:  lda EraseGame                   ;
LCA3D:  bpl +                           ;Is MSB set? If so, erase saved game data. Else branch.
LCA3F:  and #$01                        ;
LCA41:  sta EraseGame                   ;Clear MSB so saved game data is not erased again.
LCA44:  jsr EraseAllGameData            ;Erase selected saved game data.
LCA47:  lda #$01                        ;Indicate this saved game has been erased.-->
LCA49:  sta $7800,y                     ;Saved game 0=$780C, saved game 1=$781C, saved game 2=$782C. 
LCA4C:* lda MainRoutine                 ;
LCA4E:  cmp #$01                        ;If initializing the area at the start of the game, branch-->
LCA50:  beq +++                         ;to load Samus' saved game info.

SaveGameData:
LCA52:  lda InArea                      ;Save game based on current area Samus is in. Don't know why.
LCA54:  jsr SavedDataBaseAddr           ;Find index to unique item history for this saved game.
LCA57:  ldy #$3F                        ;Prepare to save unique item history which is 64 bytes in length.
LCA59:* lda NumberOfUniqueItems,y       ;
LCA5C:  sta ($00),y                     ;Save unique item history in appropriate saved game slot.
LCA5E:  dey                             ;
LCA5F:  bpl -                           ;Loop until unique item history transfer complete.
LCA61:  ldy SamusDataIndex              ;Prepare to save Samus' data.
LCA64:  ldx #$00                        ;
LCA66:* lda SamusStat00,x               ;
LCA69:  sta SamusData,y                 ;Save Samus' data in appropriate saved game slot.
LCA6C:  iny                             ;
LCA6D:  inx                             ;
LCA6E:  cpx #$10                        ;
LCA70:  bne -                           ;Loop until Samus' data transfer complete.

LoadGameData:
LCA72:* pla                             ;Restore A to find appropriate saved game to load.
LCA73:  jsr SavedDataBaseAddr           ;Find index to unique item history for this saved game.
LCA76:  ldy #$3F                        ;Prepare to load unique item history which is 64 bytes in length.
LCA78:* lda ($00),y                     ;
LCA7A:  sta NumberOfUniqueItems,y       ;Loop until unique item history is loaded.
LCA7D:  dey                             ;
LCA7E:  bpl -                           ;
LCA80:  bmi +                           ;Branch always.
LCA82:  pha                             ;
LCA83:* ldy SamusDataIndex              ;Prepare to load Samus' data.
LCA86:  ldx #$00                        ;
LCA88:* lda SamusData,y                 ;
LCA8B:  sta SamusStat00,x               ;Load Samus' data from appropriate saved game slot.
LCA8E:  iny                             ;
LCA8F:  inx                             ;
LCA90:  cpx #$10                        ;
LCA92:  bne -                           ;Loop until Samus' data transfer complete.
LCA94:  pla                             ;
LCA95:  rts                             ;

GetGameDataIndex:
LCA96:  lda DataSlot                    ;
LCA99:  asl                             ;A contains the save game slot to work on (0 1 or 2).-->
LCA9A:  asl                             ;This number is transferred to the upper four bits to-->
LCA9B:  asl                             ;find the offset for Samus' data for this particular-->
LCA9C:  asl                             ;saved game (#$00, #$10 or #$20).
LCA9D:  sta SamusDataIndex              ;
LCAA0:  rts                             ;

EraseAllGameData:
LCAA1:  lda #$00                        ;Always start at saved game 0. Erase all 3 saved games.
LCAA3:  jsr SavedDataBaseAddr           ;Find index to unique item history for this saved game.
LCAA6:  inc $03                         ;Prepare to erase saved game info at $6A00 and above.                                           
LCAA8:  ldy #$00                        ;Fill saved game data with #$00.
LCAAA:  tya                             ;
LCAAB:* sta ($00),y                     ;Erase unique item histories from $69B4 to $69FF. 
LCAAD:  cpy #$40                        ;
LCAAF:  bcs +                           ;IF 64 bytes alrady erased, no need to erase any more-->
LCAB1:  sta ($02),y                     ;in the $6A00 and above range.
LCAB3:* iny                             ;
LCAB4:  bne --                          ;Lop until all saved game data is erased.
LCAB6:  ldy SamusDataIndex              ;Load proper index to desired Samus data to erase.
LCAB9:  ldx #$00                        ;
LCABB:  txa                             ;
LCABC:* sta SamusData,y                 ;Erase Samus' data.
LCABF:  iny                             ;
LCAC0:  inx                             ;
LCAC1:  cpx #$0C                        ;
LCAC3:  bne -                           ;Loop until all data is erased.
LCAC5:  rts                             ;

;This routine finds the base address of the unique item history for the desired saved game (0, 1 or 2).
;The memory set aside for each unique item history is 64 bytes and occupies memory addresses $69B4 thru
;$6A73.

SavedDataBaseAddr:
LCAC6:  pha                             ;Save contents of A.
LCAC7:  lda DataSlot                    ;Load saved game data slot to load.
LCACA:  asl                             ;*2. Table values below are two bytes.
LCACB:  tax                             ;
LCACC:  lda SavedDataTable,x            ;
LCACF:  sta $00                         ;Load $0000 and $0002 with base addresses from-->
LCAD1:  sta $02                         ;table below($69B4).
LCAD3:  lda SavedDataTable+1,x          ;
LCAD6:  sta $01                         ;
LCAD8:  sta $03                         ;
LCADA:  pla                             ;Restore A.
LCADB:  and #$0F                        ;Discard upper four bits in A.
LCADD:  tax                             ;X used for counting loop.
LCADE:  beq +++                         ;Exit if at saved game 0.  No further calculations required.
LCAE0:* lda $00                         ;
LCAE2:  clc                             ;
LCAE3:  adc #$40                        ;
LCAE5:  sta $00                         ;Loop to add #$40 to base address of $69B4 in order to find-->
LCAE7:  bcc +                           ;the proper base address for this saved game data. (save-->
LCAE9:  inc $01                         ;slot 0 = $69B4, save slot 1 = $69F4, save slot 2 = $6A34).
LCAEB:* dex                             ;
LCAEC:  bne --                          ;
LCAEE:* rts                             ;

;Table used by above subroutine to find base address to load saved game data from. The slot 0
;starts at $69B4, slot 1 starts at $69F4 and slot 2 starts at $6A34.

SavedDataTable:
LCAEF:  .word ItmeHistory               ;($69B4)Base for save game slot 0.
LCAF1:  .word ItmeHistory               ;($69B4)Base for save game slot 1.
LCAF3:  .word ItmeHistory               ;($69B4)Base for save game slot 2.