;-------------------------------------[ Erase all sprites ]------------------------------------------

EraseAllSprites:
LC1A3:  ldy #$02                        ;
LC1A5:  sty $01                         ;Loads locations $00 and $01 with -->
LC1A7:  ldy #$00                        ;#$00 and #$02 respectively
LC1A9:  sty $00                         ;
LC1AB:  ldy #$00                        ;
LC1AD:  lda #$F0                        ;
LC1AF:* sta ($00),y                     ;Stores #$F0 in memory addresses $0200 thru $02FF.
LC1B1:  iny                             ; 
LC1B2:  bne -                           ;Loop while more sprite RAM to clear.
LC1B4:  lda GameMode                    ;
LC1B6:  beq Exit101                     ;Exit subroutine if GameMode=Play(#$00)
LC1B8:  jmp (Bank0_DecSpriteYCoord)     ;Find proper y coord of sprites.

Exit101:
LC1BB:  rts                             ;Return used by subroutines above and below.

;---------------------------------------[ Remove intro sprites ]-------------------------------------

;The following routine is used in the Intro to remove the sparkle sprites and the crosshairs
;sprites every frame.  It does this by loading the sprite values with #$F4 which moves the 
;sprite to the bottom right of the screen and uses a blank graphic for the sprite.

RemoveIntroSprites:
LC1BC:  ldy #$02                        ;Start at address $200.
LC1BE:  sty $01                         ;
LC1C0:  ldy #$00                        ;
LC1C2:  sty $00                         ;($00) = $0200 (sprite page)
LC1C4:  ldy #$5F                        ;Prepare to clear RAM $0200-$025F
LC1C6:  lda #$F4                        ;
LC1C8:* sta ($00),y                     ;
LC1CA:  dey                             ;Loop unitl $200 thru $25F is filled with #$F4.
LC1CB:  bpl -                           ;
LC1CD:  lda GameMode                    ;
LC1CF:  beq Exit101                     ; branch if mode = Play.
LC1D1:  jmp (Bank0_DecSpriteYCoord)     ;Find proper y coord of sprites.

;--------------------------------[ Check and prepare palette write ]---------------------------------

CheckPalWrite:
LC1E0:  lda GameMode                    ;
LC1E2:  beq +                           ;Is game being played? If so, branch to exit.
LC1E4:  lda TitleRoutine                ;
LC1E6:  cmp #$1D                        ;Is Game at ending sequence? If not, branch
LC1E8:  bcc +                           ;
LC1EA:  jmp (Bank0_EndGamePalWrite)     ;Write palette data for ending.
LC1ED:* ldy PalDataPending              ;
LC1EF:  bne ++                          ;Is palette data pending? If so, branch.
LC1F1:  lda GameMode                    ;
LC1F3:  beq +                           ;Is game being played? If so, branch to exit.
LC1F5:  lda TitleRoutine                ;
LC1F7:  cmp #$15                        ;Is intro playing? If not, branch.
LC1F9:  bcs +                           ;
LC1FB:  jmp (Bank0_StarPalSwitch)       ;Cycles palettes for intro stars twinkle. Will rts at the end.
LC1FE:* rts                             ;Exit when no palette data pending.

;Prepare to write palette data to PPU.

LC1FF:* dey                             ;Palette # = PalDataPending - 1.
LC200:  tya                             ;
LC201:  asl                             ;* 2, each pal data ptr is 2 bytes (16-bit).
LC202:  tay                             ;
LC203:  ldx $9560,y                     ;X = low byte of PPU data pointer.
LC206:  lda $9561,y                     ;
LC209:  tay                             ;Y = high byte of PPU data pointer.
LC20A:  lda #$00                        ;Clear A.
LC20C:  sta PalDataPending              ;Reset palette data pending byte.

PreparePPUProcess_:
LC20E:  stx $00                         ;Lower byte of pointer to PPU string.
LC210:  sty $01                         ;Upper byte of pointer to PPU string.
LC212:  jmp ProcessPPUString            ;Write data string to PPU.

;------------------------------------[ Object drawing routines ]-------------------------------------

;The following function effectively sets an object's temporary y radius to #$00 if the object
;is 4 tiles tall or less.  If it is taller, #$10 is subtracted from the temporary y radius.

ReduceYRadius:
LDE3D:  sec                             ;
LDE3E:  sbc #$10                        ;Subtract #$10 from object y radius.
LDE40:  bcs +                           ;If number is still a positive number, branch to store value.
LDE42:  lda #$00                        ;Number is negative.  Set Y radius to #$00.
LDE44:* sta $08                         ;Store result and return.
LDE46:  rts                             ;

AnimDrawObject:
LDE47:  jsr UpdateObjAnim               ;Update animation if needed.

DrawFrame:
LDE4A:  ldx PageIndex                   ;Get index to proper object to work with.
LDE4C:  lda AnimFrame,x                 ;
LDE4F:  cmp #$F7                        ;Is the frame valid?-->
LDE51:  bne ++                          ;Branch if yes.
LDE53:* jmp ClearObjectCntrl            ;Clear object control byte.
LDE56:* cmp #$07                        ;Is the animation of Samus facing forward?-->
LDE58:  bne +                           ;If not, branch.

LDE5A:  lda ObjectCntrl                 ;Ensure object mirroring bit is clear so Samus'-->
LDE5C:  and #$EF                        ;sprite appears properly when going up and down-->
LDE5E:  sta ObjectCntrl                 ;elevators.

LDE60:* lda ObjectY,x                   ;
LDE63:  sta $0A                         ;
LDE65:  lda ObjectX,x                   ;Copy object y and x room position and name table-->
LDE68:  sta $0B                         ;data into $0A, $0B and $06 respectively.
LDE6A:  lda ObjectHi,x                  ;
LDE6D:  sta $06                         ;
LDE6F:  lda AnimFrame,x                 ;Load A with index into FramePtrTable.
LDE72:  asl                             ;*2. Frame pointers are two bytes.
LDE73:  tax                             ;X is now the index into the FramePtrTable.
LDE74:  lda FramePtrTable,x             ;
LDE77:  sta $00                         ;
LDE79:  lda FramePtrTable+1,x           ;Entry from FramePtrTable is stored in $0000.
LDE7C:  sta $01                         ;
LDE7E:  jsr GetSpriteCntrlData          ;Get place pointer index and sprite control data.
LDE81:  lda PlacePtrTable,x             ;
LDE84:  sta $02                         ;
LDE86:  lda PlacePtrTable+1,x           ;Store pointer from PlacePtrTbl in $0002.
LDE89:  sta $03                         ;
LDE8B:  lda IsSamus                     ;Is Samus the object being drawn?-->
LDE8D:  beq +                           ;If not, branch.

;Special case for Samus exploding.
LDE8F:  cpx #$0E                        ;Is Samus exploding?-->
LDE91:  bne +                           ;If not, branch to skip this section of code.
LDE93:  ldx PageIndex                   ;X=0.
LDE95:  inc ObjectCounter               ;Incremented every frame during explode sequence.-->
LDE97:  lda ObjectCounter               ;Bottom two bits used for index into ExplodeRotationTbl.
LDE99:  pha                             ;Save value of A.
LDE9A:  and #$03                        ;Use 2 LSBs for index into ExplodeRotationTbl.
LDE9C:  tax                             ;
LDE9D:  lda $05                         ;Drop mirror control bits from sprite control byte.
LDE9F:  and #$3F                        ;
LDEA1:  ora ExplodeRotationTbl,x        ;Use mirror control bytes from table.
LDEA4:  sta $05                         ;Save modified sprite control byte.
LDEA6:  pla                             ;Restore A
LDEA7:  cmp #$19                        ;After 25 frames, Move on to second part of death--> 
LDEA9:  bne +                           ;handler, else branch to skip the rest of this code.
LDEAB:  ldx PageIndex                   ;X=0.
LDEAD:  lda #sa_Dead2                   ;
LDEAF:  sta ObjAction,x                 ;Move to next part of the death handler.
LDEB2:  lda #$28                        ;
LDEB4:  sta AnimDelay,x                 ;Set animation delay for 40 frames(.667 seconds).
LDEB7:  pla                             ;Pull last return address off of the stack.
LDEB8:  pla                             ;
LDEB9:  jmp ClearObjectCntrl            ;Clear object control byte.

LDEBC:* ldx PageIndex                   ;
LDEBE:  iny                             ;Increment to second frame data byte.
LDEBF:  lda ($00),y                     ;
LDEC1:  sta ObjRadY,x                   ;Get verticle radius in pixles of object.
LDEC3:  jsr ReduceYRadius               ;Reduce temp y radius by #$10.
LDEC6:  iny                             ;Increment to third frame data byte.
LDEC7:  lda ($00),y                     ;Get horizontal radius in pixels of object.
LDEC9:  sta ObjRadX,x                   ;
LDECB:  sta $09                         ;Temp storage for object x radius.
LDECD:  iny                             ;Set index to 4th byte of frame data.
LDECE:  sty $11                         ;Store current index into frame data.
LDED0:  jsr IsObjectVisible             ;Determine if object is within the screen boundaries.
LDED3:  txa                             ;
LDED4:  ldx PageIndex                   ;Get index to object.
LDED6:  sta ObjectOnScreen,x            ;Store visibility status of object.
LDEDB:  tax                             ;
LDEDC:  beq +                           ;Branch if object is not within the screen boundaries.
LDEDE:  ldx SpritePagePos               ;Load index into next unused sprite RAM segment.
LDEE0:  jmp DrawSpriteObject            ;Start drawing object.

LDEE3:* jmp ClearObjectCntrl            ;Clear object control byte then exit.

WriteSpriteRAM:
LDEE6:* ldy $0F                         ;Load index for placement data.
LDEE8:  jsr YDisplacement               ;Get displacement for y direction.
LDEEB:  adc $10                         ;Add initial Y position.
LDEED:  sta Sprite00RAM,x               ;Store sprite Y coord.
LDEF0:  dec Sprite00RAM,x               ;Because PPU uses Y + 1 as real Y coord.
LDEF3:  inc $0F                         ;Increment index to next byte of placement data.
LDEF5:  ldy $11                         ;Get index to frame data.
LDEF7:  lda ($00),y                     ;Tile value.
LDEF9:  sta Sprite00RAM+1,x             ;Store tile value in sprite RAM.
LDEFC:  lda ObjectCntrl                 ;
LDEFE:  asl                             ;Move horizontal mirror control byte to bit 6 and-->
LDEFF:  asl                             ;discard all other bits.
LDF00:  and #$40                        ;
LDF02:  eor $05                         ;Use it to override sprite horz mirror bit.
LDF04:  sta Sprite00RAM+2,x             ;Store sprite control byte in sprite RAM.
LDF07:  inc $11                         ;Increment to next byte of frame data.
LDF09:  ldy $0F                         ;Load index for placement data.
LDF0B:  jsr XDisplacement               ;Get displacement for x direction.
LDF0E:  adc $0E                         ;Add initial X pos
LDF10:  sta Sprite00RAM+3,x             ;Store sprite X coord
LDF13:  inc $0F                         ;Increment to next placement data byte.
LDF15:  inx                             ;
LDF16:  inx                             ;
LDF17:  inx                             ;Advance to next sprite.
LDF18:  inx                             ;

DrawSpriteObject:
LDF19:  ldy $11                         ;Get index into frame data.

GetNextFrameByte:
LDF1B:  lda ($00),y                     ;Get next frame data byte.
LDF1D:  cmp #$FC                        ;If byte < #$FC, byte is tile data. If >= #$FC, byte is--> 
LDF1F:  bcc WriteSpriteRAM              ;frame data control info. Branch to draw sprite.
LDF21:  beq OffsetObjectPosition        ;#$FC changes object's x and y position.
LDF23:  cmp #$FD                        ;
LDF25:  beq GetNewControlByte           ;#$FD sets new control byte information for the next sprites.
LDF27:  cmp #$FE                        ;#$FE skips next sprite placement x and y bytes.
LDF29:  beq SkipPlacementData           ;
LDF2B:  stx SpritePagePos               ;Keep track of current position in sprite RAM.

ClearObjectCntrl:
LDF2D:  lda #$00                        ;
LDF2F:  sta ObjectCntrl                 ;Clear object control byte.
LDF31:  rts                             ;

SkipPlacementData:
LDF32:* inc $0F                         ;Skip next y and x placement data bytes.
LDF34:  inc $0F                         ;
LDF36:  inc $11                         ;Increment to next data item in frame data.
LDF38:  jmp DrawSpriteObject            ;Draw next sprite.

GetNewControlByte:
LDF3B:* iny                             ;Increment index to next byte of frame data.
LDF3C:  asl ObjectCntrl                 ;If MSB of ObjectCntrl is not set, no overriding of-->
LDF3E:  bcc +                           ;flip bits needs to be performed.
LDF40:  jsr SpriteFlipBitsOveride       ;Use object flip bits as priority over sprite flip bits.
LDF43:  bne ++                          ;Branch always.
LDF45:* lsr ObjectCntrl                 ;Restore MSB of ObjectCntrl.
LDF47:  lda ($00),y                     ;
LDF49:  sta $05                         ;Save new sprite control byte.
LDF4B:* iny                             ;Increment past sprite control byte.
LDF4C:  sty $11                         ;Save index of frame data.
LDF4E:  jmp GetNextFrameByte            ;Load next frame data byte.

OffsetObjectPosition:
LDF51:* iny                             ;Increment index to next byte of frame data.
LDF52:  lda ($00),y                     ;This data byte is used to offset the object from-->
LDF54:  clc                             ;its current y positon.
LDF55:  adc $10                         ;
LDF57:  sta $10                         ;Add offset amount to object y screen position.
LDF59:  inc $11                         ;
LDF5B:  inc $11                         ;Increment past control byte and y offset byte.
LDF5D:  ldy $11                         ;
LDF5F:  lda ($00),y                     ;Load x offset data byte.
LDF61:  clc                             ;
LDF62:  adc $0E                         ;Add offset amount to object x screen position.
LDF64:  sta $0E                         ;
LDF66:  inc $11                         ;Increment past x offset byte.
LDF68:  jmp DrawSpriteObject            ;Draw next sprite.

;----------------------------------[ Sprite placement routines ]-------------------------------------

YDisplacement:
LDF6B:  lda ($02),y                     ;Load placement data byte.
LDF6D:  tay                             ;
LDF6E:  and #$F0                        ;Check to see if this is placement data for the object-->
LDF70:  cmp #$80                        ;exploding.  If so, branch.
LDF72:  beq ++                          ;
LDF74:  tya                             ;Restore placement data byte to A.
LDF75:* bit $04                         ;
LDF77:  bmi NegativeDisplacement        ;Branch if MSB in $04 is set(Flips object).
LDF79:  clc                             ;Clear carry before returning.
LDF7A:  rts                             ;

ExplodeYDisplace:
LDF7B:* tya                             ;Transfer placement byte back into A.
LDF7C:  and #$0E                        ;Discard bits 7,6,5,4 and 0.
LDF7E:  lsr                             ;/2.
LDF7F:  tay                             ;
LDF80:  lda ExplodeIndexTbl,y           ;Index into ExplodePlacementTbl.
LDF83:  ldy IsSamus                     ;
LDF85:  bne +                           ;Is Samus the object exploding? if so, branch.
LDF87:  ldy PageIndex                   ;Load index to proper enemy data.
LDF89:  adc EnCounter,y                 ;Increment every frame enemy is exploding. Initial=#$01.
LDF8C:  jmp ++                          ;Jump to load explode placement data.


;Special case for Samus exploding.
LDF8F:* adc ObjectCounter               ;Increments every frame Samus is exploding. Initial=#$01.
LDF91:* tay                             ;
LDF92:  lda ExplodeIndexTbl+2,y         ;Get data from ExplodePlacementTbl.
LDF95:  pha                             ;Save data on stack.
LDF96:  lda $0F                         ;Load placement data index.
LDF98:  clc                             ;
LDF99:  adc #$0C                        ;Move index forward by 12 bytes. to find y-->
LDF9B:  tay                             ;placement data.
LDF9C:  pla                             ;Restore A with ExplodePlacementTbl data.
LDF9D:  clc                             ;
LDF9E:  adc ($02),y                     ;Add table displacements with sprite placement data.
LDFA0:  jmp ----                        ;Branch to add y placement values to sprite coords.

XDisplacement:
LDFA3:  lda ($02),y                     ;Load placement data byte.
LDFA5:  tay                             ;
LDFA6:  and #$F0                        ;Check to see if this is placement data for the object-->
LDFA8:  cmp #$80                        ;exploding.  If so, branch.
LDFAA:  beq +++                         ;
LDFAC:  tya                             ;Restore placement data byte to A.
LDFAD:* bit $04                         ;
LDFAF:  bvc +                           ;Branch if bit 6 cleared, else data is negative displacement.

NegativeDisplacement:
LDFB1:  eor #$FF                        ;
LDFB3:  sec                             ;NOTE:Setting carry makes solution 1 higher than expected.
LDFB4:  adc #$F8                        ;If flip bit is set in $04, this function flips the-->
LDFB6:* clc                             ;object by using two compliment minus 8(Each sprite is-->
LDFB7:  rts                             ;8x8 pixels).

ExplodeXDisplace:
LDFB8:* ldy PageIndex                   ;Load index to proper enemy slot.
LDFBA:  lda EnCounter,y                 ;Load counter value.
LDFBD:  ldy IsSamus                     ;Is Samus the one exploding?-->
LDFBF:  beq +                           ;If not, branch.
LDFC1:  lda ObjectCounter               ;Load object counter if it is Samus who is exploding.
LDFC3:* asl                             ;*2. Move sprite in x direction 2 pixels every frame.
LDFC4:  pha                             ;Store value on stack.
LDFC5:  ldy $0F                         ;
LDFC7:  lda ($02),y                     ;Load placement data byte.
LDFC9:  lsr                             ;
LDFCA:  bcs +                           ;Check if LSB is set. If not, the byte stored on stack-->
LDFCC:  pla                             ;Will be twos complimented and used to move sprite in-->
LDFCD:  eor #$FF                        ;the negative x direction.
LDFCF:  adc #$01                        ;
LDFD1:  pha                             ;
LDFD2:* lda $0F                         ;Load placement data index.
LDFD4:  clc                             ;
LDFD5:  adc #$0C                        ;Move index forward by 12 bytes. to find x-->
LDFD7:  tay                             ;placement data.
LDFD8:  pla                             ;Restore A with x displacement data.
LDFD9:  clc                             ;
LDFDA:  adc ($02),y                     ;Add x displacement with sprite placement data.
LDFDC:  jmp -----                       ;Branch to add x placement values to sprite coords.