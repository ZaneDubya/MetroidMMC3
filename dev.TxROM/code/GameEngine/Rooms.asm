;---------------------------------------[ Get room number ]-------------------------------------------

;Gets room number at current map position. Sets carry flag if room # at map position is FF.
;If valid room number, the room number is stored in $5A.

GetRoomNum:
LE720:  lda ScrollDir                   ;
LE722:  lsr                             ;Branch if scrolling vertical.
LE723:  beq +                           ;

LE725:  rol                             ;Restore value of a
LE726:  adc #$FF                        ;A=#$01 if scrolling left, A=#$02 if scrolling right.
LE728:  pha                             ;Save A.
LE729:  jsr OnNameTable0                ;Y=1 if name table=0, Y=0 if name table=3.
LE72C:  pla                             ;Restore A.
LE72D:  and $006C,y                     ;
LE730:  sec                             ;
LE731:  bne +++++                       ;Can't load room, a door is in the way. This has the-->
                                        ;effect of stopping the scrolling until Samus walks-->
                                        ;through the door(horizontal scrolling only).

LE733:* lda MapPosY                     ;Map pos y.
LE735:  jsr Amul16                      ;Multiply by 16.
LE738:  sta $00                         ;Store multiplied value in $00.
LE73A:  lda #$00                        ;
LE73C:  rol                             ;Save carry, if any.
LE73D:  rol $00                         ;Multiply value in $00 by 2.
LE73F:  rol                             ;Save carry, if any.
LE740:  sta $01                         ;
LE742:  lda $00                         ;
LE744:  adc MapPosX                     ;Add map pos X to A.
LE746:  sta $00                         ;Store result.
LE748:  lda $01                         ;
LE74A:  adc #$70                        ;Add #$7000 to result.
LE74C:  sta $01                         ;$0000 = (MapY*32)+MapX+#$7000.
LE74E:  ldy #$00                        ;
LE750:  lda ($00),y                     ;Load room number.
LE752:  cmp #$FF                        ;Is it unused?-->
LE754:  beq ++++                        ;If so, branch to exit with carry flag set.

LE756:  sta RoomNumber                  ;Store room number.

LE758:* cmp $95D0,y                     ;Is it a special room?-->
LE75B:  beq +                           ;If so, branch to set flag to play item room music.
LE75D:  iny                             ;
LE75E:  cpy #$07                        ;
LE760:  bne -                           ;Loop until all special room numbers are checked.

LE762:  lda ItemRoomMusicStatus         ;Load item room music status.
LE764:  beq ++                          ;Branch if not in special room.
LE766:  lda #$80                        ;Ptop playing item room music after next music start.
LE768:  bne ++                          ;Branch always.

LE76A:* lda #$01                        ;Start item room music on next music start.
LE76C:* sta ItemRoomMusicStatus         ;
LE76E:  clc                             ;Clear carry flag. was able to get room number.
LE76F:* rts                             ;

;------------------------------------------[ Select room RAM ]---------------------------------------

SelectRoomRAM:
LEA05:  jsr GetNameTable                ;Find name table to draw room on.
LEA08:  asl                             ;
LEA09:  asl                             ;
LEA0A:  ora #$60                        ;A=#$64 for name table 3, A=#$60 for name table 0.
LEA0C:  sta CartRAMPtr+1                ;
LEA0E:  lda #$00                        ;
LEA10:  sta CartRAMPtr                  ;Save two byte pointer to start of proper room RAM.
LEA12:  rts                             ;

;------------------------------------[ write attribute table data ]----------------------------------

AttribTableWrite:
LEA13:* lda RoomNumber                  ;
LEA15:  and #$0F                        ;Determine what row of PPU attribute table data, if any,-->
LEA17:  inc RoomNumber                  ;to load from RoomRAM into PPU.
LEA19:  jsr ChooseRoutine               ;

;The following table is used by the code above to determine when to write to the PPU attribute table.

LEA1c:  .word ExitSub                   ;Rts.
LEA1E:  .word WritePPUAttribTbl         ;Write first row of PPU attrib data.
LEA20:  .word ExitSub                   ;Rts.
LEA22:  .word WritePPUAttribTbl         ;Write second row of PPU attrib data.
LEA24:  .word RoomFinished              ;Finished writing attribute table data.

;-----------------------------------[ Finished writing room data ]-----------------------------------

RoomFinished:
LEA26:  lda #$FF                        ;No more tasks to perform on current room.-->
LEA28:  sta RoomNumber                  ;Set RoomNumber to #$FF.
LEA2A:* rts                             ;

;------------------------------------------[ Setup room ]--------------------------------------------

SetupRoom:
LEA2B:  lda RoomNumber                  ;Room number.
LEA2D:  cmp #$FF                        ;
LEA2F:  beq -                           ;Branch to exit if room is undefined.
LEA31:  cmp #$FE                        ;
LEA33:  beq +                           ;Branch if empty place holder byte found in room data.
LEA35:  cmp #$F0                        ;
LEA37:  bcs --                          ;Branch if time to write PPU attribute table data.
LEA39:  jsr UpdateRoomSpriteInfo        ;Update which sprite belongs on which name table.

LEA3C:  jsr ScanForItems                ;Set up any special items.
LEA3F:  lda RoomNumber                  ;Room number to load.
LEA41:  asl                             ;*2(for loading address of room pointer).
LEA42:  tay                             ;
LEA43:  lda (RoomPtrTable),y            ;Low byte of 16-bit room pointer.-->
LEA45:  sta RoomPtr                     ;Base copied from $959A to $3B.
LEA47:  iny                             ;
LEA48:  lda (RoomPtrTable),y            ;High byte of 16-bit room pointer.-->
LEA4A:  sta RoomPtr+1                   ;Base copied from $959B to $3C.
LEA4C:  ldy #$00                        ;
LEA4E:  lda (RoomPtr),y                 ;First byte of room data.
LEA50:  sta RoomPal                     ;store initial palette # to fill attrib table with.
LEA52:  lda #$01                        ;
LEA54:  jsr AddToRoomPtr                ;Increment room data pointer.
LEA57:  jsr SelectRoomRAM               ;Determine where to draw room in RAM, $6000 or $6400.
LEA5A:  jsr InitTables                  ;clear Name Table & do initial Attrib table setup.
LEA5D:* jmp DrawRoom                    ;Load room contents into room RAM.

;---------------------------------------[ Draw room object ]-----------------------------------------

DrawObject:
LEA60:  sta $0E                         ;Store object position byte(%yyyyxxxx).
LEA62:  lda CartRAMPtr                  ;
LEA64:  sta CartRAMWorkPtr              ;Set the working pointer equal to the room pointer-->
LEA66:  lda CartRAMPtr+1                ;(start at beginning of the room).
LEA68:  sta CartRAMWorkPtr+1            ;
LEA6A:  lda $0E                         ;Reload object position byte.
LEA6C:  jsr Adiv16                      ;/16. Lower nibble contains object y position.-->
LEA6F:  tax                             ;Transfer it to X, prepare for loop.
LEA70:  beq +++                         ;Skip y position calculation loop as y position=0 and-->
                                        ;does not need to be calculated.
LEA72:* lda CartRAMWorkPtr              ;LoW byte of pointer working in room RAM.
LEA74:  clc                             ;
LEA75:  adc #$40                        ;Advance two rows in room RAM(one y unit).
LEA77:  sta CartRAMWorkPtr              ;
LEA79:  bcc +                           ;If carry occurred, increment high byte of pointer-->
LEA7B:  inc CartRAMWorkPtr+1            ;in room RAM.
LEA7D:* dex                             ;
LEA7E:  bne --                          ;Repeat until at desired y position(X=0).

LEA80:* lda $0E                         ;Reload object position byte.
LEA82:  and #$0F                        ;Remove y position upper nibble.
LEA84:  asl                             ;Each x unit is 2 tiles.
LEA85:  adc CartRAMWorkPtr              ;
LEA87:  sta CartRAMWorkPtr              ;Add x position to room RAM work pointer.
LEA89:  bcc +                           ;If carry occurred, increment high byte of room RAM work-->
LEA8B:  inc CartRAMWorkPtr+1            ;pointer, else branch to draw object.

;CartRAMWorkPtr now points to the object's starting location (upper left corner)
;on the room RAM which will eventually be loaded into a name table.

LEA8D:* iny                             ;Move to the next byte of room data which is-->
LEA8E:  lda (RoomPtr),y                 ;the index into the structure pointer table.
LEA90:  tax                             ;Transfer structure pointer index into X.
LEA91:  iny                             ;Move to the next byte of room data which is-->
LEA92:  lda (RoomPtr),y                 ;the attrib table info for the structure.
LEA94:  sta ObjectPal                   ;Save attribute table info.
LEA96:  txa                             ;Restore structure pointer to A.
LEA97:  asl                             ;*2. Structure pointers are two bytes in size.
LEA98:  tay                             ;
LEA99:  lda (StructPtrTable),y          ;Low byte of 16-bit structure ptr.
LEA9B:  sta StructPtr                   ;
LEA9D:  iny                             ;
LEA9E:  lda (StructPtrTable),y          ;High byte of 16-bit structure ptr.
LEAA0:  sta StructPtr+1                 ;
LEAA2:  jsr DrawStruct                  ;Draw one structure.
LEAA5:  lda #$03                        ;Move to next set of structure data.
LEAA7:  jsr AddToRoomPtr                ;Add A to room data pointer.

;-------------------------------------------[ Draw room ]--------------------------------------------

;The following function draws a room in the room RAM which is eventually loaded into a name table.

DrawRoom:
LEAAA:  ldy #$00                        ;Zero index.
LEAAC:  lda (RoomPtr),y                 ;Load byte of room data.-->
LEAAE:  cmp #$FF                        ;Is it #$FF(end-of-room)?-->
LEAB0:  beq EndOfRoom                   ;If so, branch to exit.
LEAB2:  cmp #$FE                        ;Place holder for empty room objects(not used).
LEAB4:  beq +                           ;
LEAB6:  cmp #$FD                        ;is A=#$FD(end-of-objects)?-->
LEAB8:  bne DrawObject                  ;If not, branch to draw room object.-->
LEABA:  beq EndOfObjs                   ;Else branch to set up enemies/doors.
LEABC:* sta RoomNumber                  ;Store #$FE if room object is empty.
LEABE:  lda #$01                        ;Prepare to increment RoomPtr.

;-------------------------------------[ Add A to room pointer ]--------------------------------------

AddToRoomPtr:
LEAC0:  clc                             ;Prepare to add index in A to room pointer.
LEAC1:  adc RoomPtr                     ;
LEAC3:  sta RoomPtr                     ;
LEAC5:  bcc +                           ;Did carry occur? If not branch to exit.
LEAC7:  inc RoomPtr+1                   ;Increment high byte of room pointer if carry occured.
LEAC9:* rts                             ;

;----------------------------------------------------------------------------------------------------

EndOfObjs:
LEACA:  lda RoomPtr                     ;
LEACC:  sta $00                         ;Store room pointer in $0000.
LEACE:  lda RoomPtr+1                   ;
LEAD0:  sta $01                         ;
LEAD2:  lda #$01                        ;Prepare to increment to enemy/door data.

EnemyLoop:
LEAD4:  jsr AddToPtr00                  ;Add A to pointer at $0000.
LEAD7:  ldy #$00                        ;
LEAD9:  lda ($00),y                     ;Get first byte of enemy/door data.
LEADB:  cmp #$FF                        ;End of enemy/door data?-->
LEADD:  beq EndOfRoom                   ;If so, branch to finish room setup.
LEADF:  and #$0F                        ;Discard upper four bits of data.
LEAE1:  jsr ChooseRoutine               ;Jump to proper enemy/door handling routine.

;Pointer table to code.

LEAE4:  .word ExitSub                   ;Rts.
LEAE6:  .word LoadEnemy                 ;Room enemies.
LEAE8:  .word LoadDoor                  ;Room doors.
LEAEA:  .word ExitSub                   ;Rts.
LEAEC:  .word LoadElevator              ;Elevator.
LEAEE:  .word ExitSub                   ;Rts.
LEAF0:  .word LoadStatues               ;Kraid & Ridley statues.
LEAF2:  .word ZebHole                   ;Regenerating enemies(such as Zeb).

EndOfRoom:
LEAF4:  ldx #$F0                        ;Prepare for PPU attribute table write.
        stx RoomNumber                  ;
        lda ScrollDir                   ;
        sta TempScrollDir               ;Make temp copy of ScrollDir.
        and #$02                        ;Check if scrolling left or right.
        bne +                           ;
        jmp LE57C
*       jmp LE70C

LoadEnemy:
LEB06:  jsr GetEnemyData                ;Get enemy data from room data.
LEB09:  jmp EnemyLoop                   ;Do next room object.

GetEnemyData:
LEB0C:  lda ($00),y                     ;Get 1st byte again.
        and #$F0                        ;Get object slot that enemy will occupy.
        tax                             ;
        jsr IsSlotTaken                 ;Check if object slot is already in use.
        bne ++                          ;Exit if object slot taken.
        iny                             ;
        lda ($00),y                     ;Get enemy type.
        jsr GetEnemyType                ;Load data about enemy.
        ldy #$02                        ;
        lda ($00),y                     ;Get enemy initial position(%yyyyxxxx).
        jsr LEB4D
        pha
*       pla
*       lda #$03                        ;Number of bytes to add to ptr to find next room item.
        rts                             ;

GetEnemyType:
LEB28:  pha                             ;Store enemy type.
        and #$C0                        ;If MSB is set, the "tough" version of the enemy  
        sta EnSpecialAttribs,x          ;is to be loaded(more hit points, except rippers).
        asl                             ;
        bpl ++                          ;If bit 6 is set, the enemy is either Kraid or Ridley.
        lda InArea                      ;Load current area Samus is in(to check if Kraid or-->
        and #$06                        ;Ridley is alive or dead).
        lsr                             ;Use InArea to find status of Kraid/Ridley statue.
        tay                             ;
        lda MaxMissiles,y               ;Load status of Kraid/Ridley statue.
        beq +                           ;Branch if Kraid or Ridley needs to be loaded.
        pla                             ;
        pla                             ;Mini boss is dead so pull enemy info and last address off-->
        jmp --                          ;stack so next enemy/door item can be loaded.

*       lda #$01                        ;Samus is in Kraid or Ridley's room and the-->
        sta KraidRidleyPresent          ;mini boss is alive and needs to be loaded.

*       pla                             ;Restore enemy type data.
        and #$3F                        ;Keep 6 lower bits to use as index for enemy data tables.
        sta EnDataIndex,x               ;Store index byte.
        rts                             ;

LEB4D:  tay                             ;Save enemy position data in Y.
        and #$F0                        ;Extract Enemy y position.
        ora #$08                        ;Add 8 pixels to y position so enemy is always on screen. 
        sta EnYRoomPos,x                ;Store enemy y position.
        tya                             ;Restore enemy position data.
        jsr Amul16                      ;*16 to extract enemy x position.
        ora #$0C                        ;Add 12 pixels to x position so enemy is always on screen.
        sta EnXRoomPos,x                ;Store enemy x position.
        lda #$01                        ;
        sta EnStatus,x                  ;Indicate object slot is taken.
        lda #$00
        sta $0404,x
        jsr GetNameTable                ;Get name table to place enemy on.
        sta EnNameTable,x               ;Store name table.
UnknownEB6E:
        ldy EnDataIndex,x               ;Load A with index to enemy data.
        asl EnData05,x                     ;*2
        jsr LFB7B
        jmp UnknownF85A

IsSlotTaken:
LEB7A:  lda EnStatus,x
        beq +
        lda EnData05,x
        and #$02
*       rts

;------------------------------------------[ Get name table ]----------------------------------------

;The following routine is small but is called by several other routines so it is important and
;requires some explaining to understand its function.  First of all, as Samus moves from one room
;to the next, she is also moving from one name table to the next.  Samus does not move from one
;name table to the next as one might think. Samus moves diagonally through the name tables. To
;understand this concept, one must first know how the name tables are arranged.  They are arranged
;like so:
;
; +-----+-----+                                                  +-----+-----+
; |     |     | The following is an incorrect example of how     |     |     |
; |  2  |  3  | Samus goes from one name table to the next-----> |  2  |  3  |
; |     |     |                                                  |     |     |
; +-----+-----+                                                  +-----+-----+
; |     |     |                                                  |     |     |
; |  0  |  1  |                           INCORRECT!------>  |  0<-|->1  |
; |     |     |                                                  |     |     |
; +-----+-----+                                                  +-----+-----+
;
;The following are examples of how the name tables are properly traversed while walking through rooms:
;
;          +-----+-----+                                 +-----+-----+
;          |     |     |                                 |     |     |
;          |  2  | ->3 |                                 |  2  |  3<-|-+
;          |     |/    |                                 |     |     | |
;          +-----+-----+     <--------CORRECT!-------->      +-----+-----+ |
;          |    /|     |                                 |     |     | |
;          | 0<- |  1  |                                   +-|->0  |  1  | |
;          |     |     |                                   | |     |     | |
;          +-----+-----+                                   | +-----+-----+ |
;                                                          +---------------+
;
;The same diagonal traversal of the name tables illustrated above applies to vetricle traversal as
;well. Since Samus can only travel between 2 name tables and not 4, the name table placement for
;objects is simplified.  The following code determines which name table to use next:

GetNameTable:
LEB85:  lda PPUCNT0ZP                   ;
LEB87:  eor ScrollDir                   ;Store #$01 if object should be loaded onto name table 3-->
LEB89:  and #$01                        ;store #$00 if it should be loaded onto name table 0.
LEB8B:  rts                             ;

;----------------------------------------------------------------------------------------------------

; LoadDoor
; ========

        LoadDoor:
        jsr LEB92
*       jmp EnemyLoop    ; do next room object

LEB92:  iny
        lda ($00),y     ; door info byte
        pha
        jsr Amul16      ; CF = door side (0=right, 1=left)
        php
        lda MapPosX
        clc
        adc MapPosY
        plp
        rol
        and #$03
        tay
        ldx LEC00,y
        pla      ; retrieve door info
        and #$03
        sta $0307,x     ; door palette
        tya
        pha
        lda $0307,x
        cmp #$01
        beq ++
        cmp #$03
        beq ++
        lda #$0A
        sta $09
        ldy MapPosX
        txa
        jsr Amul16       ; * 16
        bcc +
        dey
*       tya
        jsr LEE41
        jsr LEE4A
        bcs ++
*       lda #$01
        sta ObjAction,x
*       pla
        and #$01        ; A = door side (0=right, 1=left)
        tay
        jsr GetNameTable                ;
        sta ObjectHi,x
        lda DoorXs,y    ; get door's X coordinate
        sta ObjectX,x
        lda #$68        ; door Y coord is always #$68
        sta ObjectY,x
        lda LEBFE,y
        tay
        jsr GetNameTable                ;
        eor #$01
        tax
        tya
        ora DoorOnNameTable3,x
        sta DoorOnNameTable3,x
        lda #$02
        rts

DoorXs:
        .byte $F0        ; X coord of RIGHT door
        .byte $10        ; X coord of LEFT door
LEBFE:  .byte $02
        .byte $01
LEC00:  .byte $80
        .byte $B0
        .byte $A0
        .byte $90

; LoadElevator
; ============

        LoadElevator:
        jsr LEC09
        bne ----           ; branch always

LEC09:  lda ElevatorStatus
        bne +      ; exit if elevator already present
        iny
        lda ($00),y
        sta $032F
        ldy #$83
        sty $032D       ; elevator Y coord
        lda #$80
        sta $032E       ; elevator X coord
        jsr GetNameTable                ;
        sta $032C       ; high Y coord
        lda #$23
        sta $0323       ; elevator frame
        inc ElevatorStatus              ;1
*       lda #$02
        rts

; LoadStatues
; ===========

        LoadStatues:
        jsr GetNameTable                ;
        sta $036C
        lda #$40
        ldx RidleyStatueStatus
        bpl +      ; branch if Ridley statue not hit
        lda #$30
*       sta $0370
        lda #$60
        ldx KraidStatueStatus
        bpl +      ; branch if Kraid statue not hit
        lda #$50
*       sta $036F
        sty $54
        lda #$01
        sta $0360
*       jmp EnemyLoop   ; do next room object

ZebHole:
LEC57:  ldx #$20
*       txa
        sec
        sbc #$08
        bmi +
        tax
        ldy $0728,x
        iny
        bne -
        ldy #$00
        lda ($00),y
        and #$F0
        sta $0729,x
        iny
        lda ($00),y
        sta $0728,x
        iny
        lda ($00),y
        tay
        and #$F0
        ora #$08
        sta $072A,x
        tya
        jsr Amul16       ; * 16
        ora #$00
        sta $072B,x
        jsr GetNameTable                ;
        sta $072C,x
*       lda #$03
        bne ---

OnNameTable0:
LEC93:  lda PPUCNT0ZP                   ;
        eor #$01                        ;If currently on name table 0,-->
        and #$01                        ;return #$01. Else return #$00.
        tay                             ;
        rts                             ;

UpdateRoomSpriteInfo:
LEC9B:  ldx ScrollDir
        dex
        ldy #$00
        jsr UpdateDoorData              ;Update name table 0 door data.
        iny
        jsr UpdateDoorData              ;Update name table 3 door data.
        ldx #$50
        jsr GetNameTable                ;
        tay
*       tya
        eor EnNameTable,x
        lsr
        bcs +
        lda EnData05,x
        and #$02
        bne +
        sta EnStatus,x
*       jsr Xminus16
        bpl --
        ldx #$18
*       tya
        eor $B3,x
        lsr
        bcs +
        lda #$00
        sta $B0,x
*       txa
        sec
        sbc #$08
        tax
        bpl --
        jsr LED65
        jsr LED5B
        jsr GetNameTable                ;(EB85)
        asl
        asl
        tay
        ldx #$C0
*       tya
        eor TileWRAMHi,x
        and #$04
        bne +
        sta $0500,x
*       jsr Xminus16
        cmp #$F0
        bne --
        tya
        lsr
        lsr
        tay
        ldx #$D0
        jsr LED7A
        ldx #$E0
        jsr LED7A
        ldx #$F0
        jsr LED7A
        tya
        sec
        sbc $032C
        bne +
        sta ElevatorStatus
*       ldx #$1E
*       lda $0704,x
        bne +
        lda #$FF
        sta $0700,x
*       txa
        sec
        sbc #$06
        tax
        bpl --
        cpy $036C
        bne +
        lda #$00
        sta $0360
*       ldx #$18
*       tya
        cmp $072C,x
        bne +
        lda #$FF
        sta $0728,x
*       txa
        sec
        sbc #$08
        tax
        bpl --
        ldx #$00
        jsr LED8C
        ldx #$08
        jsr LED8C
        jmp $95AE

UpdateDoorData:
LED51:  txa                             ;
LED52:  eor #$03                        ;
LED54:  and $006C,y                     ;Moves door info from one name table to the next-->
LED57:* sta $006C,y                     ;when the room is transferred across name tables.
LED5A:  rts                             ;

LED5B:  jsr GetNameTable                ;
        eor #$01
        tay
        lda #$00
        beq -
LED65:  ldx #$B0
*       lda ObjAction,x
        beq +
        lda ObjectOnScreen,x
        bne +
        sta ObjAction,x
*       jsr Xminus16
        bmi --
        rts

LED7A:  lda ObjAction,x
        cmp #$05
        bcc +
        tya
        eor ObjectHi,x
        lsr
        bcs +
        sta ObjAction,x
*       rts

LED8C:  tya
        cmp PowerUpNameTable,x
        bne Exit11
        lda #$FF
        sta PowerUpType,x
Exit11: rts

;---------------------------------------[ Setup special items ]--------------------------------------

;The following routines look for special items on the game map and jump to
;the appropriate routine to handle those items.

ScanForItems:
LED98:  lda SpecItmsTable               ;Low byte of ptr to 1st item data.
LED9B:  sta $00                         ;
LED9D:  lda SpecItmsTable+1             ;High byte of ptr to 1st item data.

ScanOneItem:
LEDA0:  sta $01                         ;
LEDA2:  ldy #$00                        ;Index starts at #$00.
LEDA4:  lda ($00),y                     ;Load map Ypos of item.-->
LEDA6:  cmp MapPosY                     ;Does it equal Samus' Ypos on map?-->
LEDA8:  beq +                           ;If yes, check Xpos too.

LEDAA:  bcs Exit11                      ;Exit if item Y pos >  Samus Y Pos.
LEDAC:  iny                             ;
LEDAD:  lda ($00),y                     ;Low byte of ptr to next item data.
LEDAF:  tax                             ;
LEDB0:  iny                             ;
LEDB1:  and ($00),y                     ;AND with hi byte of item ptr.
LEDB3:  cmp #$FF                        ;if result is FFh, then this was the last item-->
LEDB5:  beq Exit11                      ;(item ptr = FFFF). Branch to exit.

LEDB7:  lda ($00),y                     ;High byte of ptr to next item data.
LEDB9:  stx $00                         ;Write low byte for next item.
LEDBB:  jmp ScanOneItem                 ;Process next item.

LEDBE:* lda #$03                        ;Get ready to look at byte containing X pos.
LEDC0:  jsr AddToPtr00                  ;Add 3 to pointer at $0000.

ScanItemX:
LEDC3:  ldy #$00                        ;
LEDC5:  lda ($00),y                     ;Load map Xpos of object.-->
LEDC7:  cmp MapPosX                     ;Does it equal Samus' Xpos on map?-->
LEDC9:  beq +                           ;If so, then load object.
LEDCB:  bcs Exit11                      ;Exit if item pos X > Samus Pos X.

LEDCD:  iny                             ;
LEDCE:  jsr AnotherItem                 ;Check for another item on same Y pos.
LEDD1:  jmp ScanItemX                   ;Try next X coord.

LEDD4:* lda #$02                        ;Move ahead two bytes to find item data.

ChooseHandlerRoutine:
LEDD6:  jsr AddToPtr00                  ;Add A to pointer at $0000.
LEDD9:  ldy #$00                        ;
LEDDB:  lda ($00),y                     ;Object type
LEDDD:  and #$0F                        ;Object handling routine index stored in 4 LSBs.
LEDDF:  jsr ChooseRoutine               ;Load proper handling routine from table below.

;Handler routines jumped to by above code.

LEDE2:  .word ExitSub                   ;rts.
LEDE4:  .word SqueeptHandler            ;Some squeepts.
LEDE6:  .word PowerUpHandler            ;power-ups.
LEDE8:  .word SpecEnemyHandler          ;Special enemies(Mellows, Melias and Memus).
LEDEA:  .word ElevatorHandler           ;Elevators.
LEDEC:  .word CannonHandler             ;Mother brain room cannons.
LEDEE:  .word MotherBrainHandler        ;Mother brain.
LEDF0:  .word ZeebetiteHandler          ;Zeebetites.
LEDF2:  .word RinkaHandler              ;Rinkas.
LEDF4:  .word DoorHandler               ;Some doors.
LEDF6:  .word PaletteHandler            ;Background palette change.

;---------------------------------------[ Squeept handler ]------------------------------------------

SqueeptHandler:
LEDF8:  jsr GetEnemyData                ;Load Squeept data.
LEDFB:* jmp ChooseHandlerRoutine        ;Exit handler routines.

;--------------------------------------[ Power-up Handler ]------------------------------------------

PowerUpHandler:
LEDFE:  iny                             ;Prepare to store item type.
LEDFF:  ldx #$00                        ;
LEE01:  lda #$FF                        ;
LEE03:  cmp PowerUpType                 ;Is first power-up item slot available?-->
LEE06:  beq +                           ;if yes, branch to load item.

LEE08:  ldx #$08                        ;Prepare to check second power-up item slot.
LEE0A:  cmp PowerUpBType                ;Is second power-up item slot available?-->                     
LEE0D:  bne ++                          ;If not, branch to exit.
LEE0F:* lda ($00),y                     ;Power-up item type.
LEE11:  jsr PrepareItemID               ;Get unique item ID.
LEE14:  jsr CheckForItem                ;Check if Samus already has item.
LEE17:  bcs +                           ;Samus already has item. do not load it.

LEE19:  ldy #$02                        ;Prepare to load item coordinates.
LEE1B:  lda $09                         ;
LEE1D:  sta PowerUpType,x               ;Store power-up type in available item slot.
LEE20:  lda ($00),y                     ;Load x and y screen positions of item.
LEE22:  tay                             ;Save position data for later processing.
LEE23:  and #$F0                        ;Extract Y coordinate.
LEE25:  ora #$08                        ;+ 8 to find  Y coordinate center.
LEE27:  sta PowerUpYCoord,x             ;Store center Y coord
LEE2A:  tya                             ;Reload position data.
LEE2B:  jsr Amul16                      ;*16. Move lower 4 bits to upper 4 bits.
LEE2E:  ora #$08                        ;+ 8 to find X coordinate center.
LEE30:  sta PowerUpXCoord,x             ;Store center X coord
LEE33:  jsr GetNameTable                ;Get name table to place item on.
LEE36:  sta PowerUpNameTable,x          ;Store name table Item is located on.

LEE39:* lda #$03                        ;Get next data byte(Always #$00).
LEE3B:  bne ---                         ;Branch always to exit handler routines.
        
PrepareItemID:
LEE3D:  sta $09                         ;Store item type.
LEE3E:  lda MapPosX                     ;

LEE41:  sta $07                         ;Store item X coordinate.
LEE42:  lda MapPosY                     ;
LEE45:  sta $06                         ;Store item Y coordinate.
LEE47:  jmp CreateItemID                ;Get unique item ID.

CheckForItem:
LEE4A:  ldy NumberOfUniqueItems         ;
LEE4D:  beq +++                         ;Samus has no unique items. Load item and exit.
LEE4F:* lda $07                         ;
LEE51:  cmp NumberOfUniqueItems,y       ;Look for lower byte of unique item.
LEE54:  bne +                           ;
LEE56:  lda $06                         ;Look for upper byte of unique item.
LEE58:  cmp DataSlot,y                  ;
LEE5B:  beq +++                         ;Samus already has item. Branch to exit.
LEE5D:* dey                             ;
LEE5E:  dey                             ;
LEE5F:  bne --                          ;Loop until all Samus' unique items are checked.
LEE61:* clc                             ;Samus does not have the item. It will be placed on screen.
LEE62:* rts                             ;

;-----------------------------------------------------------------------------------------------------

SpecEnemyHandler:
LEE63:  ldx #$18
        lda RandomNumber1
        adc FrameCount
        sta $8A
*       jsr LEE86
        txa
        sec
        sbc #$08
        tax
        bpl -
        lda $95E4
        sta $6BE9
        sta $6BEA
        lda #$01
        sta $6BE4
*       jmp ChooseHandlerRoutine        ;Exit handler routines.

LEE86:  lda $B0,x
        bne +
        txa
        adc $8A
        and #$7F
        sta $B1,x
        adc RandomNumber2
        sta $B2,x
        jsr GetNameTable                ;
        sta $B3,x
        lda #$01
        sta $B0,x
        rol $8A
*       rts

ElevatorHandler:
LEEA1:  jsr LEC09
        bne --                          ;Branch always.

CannonHandler:
LEEA6:  jsr $95B1
        lda #$02
*       jmp ChooseHandlerRoutine        ;Exit handler routines.

MotherBrainHandler:
LEEAE:  jsr $95B4
        lda #$38
        sta $07
        lda #$00
        sta $06
        jsr LEE4A
        bcc LEEC6
        lda #$08
        sta MotherBrainStatus
        lda #$00
        sta MotherBrainHits
LEEC6:  lda #$01
        bne -

ZeebetiteHandler:
LEECA:  jsr $95B7
        txa
        lsr
        adc #$3C
        sta $07
        lda #$00
        sta $06
        jsr LEE4A
        bcc +
        lda #$81
        sta $0758,x
        lda #$01
        sta $075D,x
        lda #$07
        sta $075B,x
*       jmp LEEC6

RinkaHandler:
LEEEE:  jsr $95BA
        jmp LEEC6

DoorHandler:
LEEF4:  jsr LEB92
        jmp ChooseHandlerRoutine        ;Exit handler routines.

PaletteHandler:
LEEFA:  lda ScrollDir
        sta $91
        bne LEEC6

AnotherItem:
LEF00:  lda ($00),y                     ;Is there another item with same Y pos?-->
        cmp #$FF                        ;If so, A is amount to add to ptr. to find X pos.
        bne AddToPtr00                  ;
        pla                             ;
        pla                             ;No more items to check. Pull last subroutine-->
        rts                             ;off stack and exit.

AddToPtr00:
LEF09:  clc                             ;
        adc $00                         ;
        sta $00                         ;A is added to the 16 bit address stored in $0000.
        bcc +                           ;
        inc $01                         ;
*       rts                             ;

;----------------------------------[ Draw structure routines ]----------------------------------------

;Draws one row of the structure.
;A = number of 2x2 tile macros to draw horizontally.

DrawStructRow:
LEF13:  and #$0F                        ;Row length(in macros). Range #$00 thru #$0F.
LEF15:  bne +                           ;
LEF17:  lda #$10                        ;#$00 in row length=16.
LEF19:* sta $0E                         ;Store horizontal macro count.
LEF1B:  lda (StructPtr),y               ;Get length byte again.
LEF1D:  jsr Adiv16                      ;/16. Upper nibble contains x coord offset(if any).
LEF20:  asl                             ;*2, because a macro is 2 tiles wide.
LEF21:  adc CartRAMWorkPtr              ;Add x coord offset to CartRAMWorkPtr and save in $00.
LEF23:  sta $00                         ;
LEF25:  lda #$00                        ;
LEF27:  adc CartRAMWorkPtr+1            ;Save high byte of work pointer in $01.
LEF29:  sta $01                         ;$0000 = work pointer.

DrawMacro:
LEF2B:  lda $01                         ;High byte of current location in room RAM.
LEF2D:  cmp #$63                        ;Check high byte of room RAM address for both room RAMs-->
LEF2F:  beq +                           ;to see if the attribute table data for the room RAM has-->
LEF31:  cmp #$67                        ;been reached.  If so, branch to check lower byte as well.
LEF33:  bcc ++                          ;If not at end of room RAM, branch to draw macro.
LEF35:  beq +                           ;
LEF37:  rts                             ;Return if have gone past room RAM(should never happen).

LEF38:* lda $00                         ;Low byte of current nametable address.
LEF3A:  cmp #$A0                        ;Reached attrib table?-->
LEF3C:  bcc +                           ;If not, branch to draw the macro.
LEF3E:  rts                             ;Can't draw any more of the structure, exit.

LEF3F:* inc $10                         ;Increase struct data index.
LEF41:  ldy $10                         ;Load struct data index into Y.
LEF43:  lda (StructPtr),y               ;Get macro number.
LEF45:  asl                             ;
LEF46:  asl                             ;A=macro number * 4. Each macro is 4 bytes long.
LEF47:  sta $11                         ;Store macro index.
LEF49:  ldx #$03                        ;Prepare to copy four tile numbers.
LEF4B:* ldy $11                         ;Macro index loaded into Y.
LEF4D:  lda (MacroPtr),y                ;Get tile number.
LEF4F:  inc $11                         ;Increase macro index
LEF51:  ldy TilePosTable,x              ;get tile position in macro.
LEF54:  sta ($00),y                     ;Write tile number to room RAM.
LEF56:  dex                             ;Done four tiles yet?-->
LEF57:  bpl -                           ;If not, loop to do another.
LEF59:  jsr UpdateAttrib                ;Update attribute table if necessary
LEF5C:  ldy #$02                        ;Macro width(in tiles).
LEF5E:  jsr AddYToPtr00                 ;Add 2 to pointer to move to next macro.
LEF61:  lda $00                         ;Low byte of current room RAM work pointer.
LEF63:  and #$1F                        ;Still room left in current row?-->
LEF65:  bne +                           ;If yes, branch to do another macro.

;End structure row early to prevent it from wrapping on to the next row..
LEF67:  lda $10                         ;Struct index.
LEF69:  clc                             ;
LEF6A:  adc $0E                         ;Add number of macros remaining in current row.
LEF6C:  sec                             ;
LEF6D:  sbc #$01                        ;-1 from macros remaining in current row.
LEF6F:  jmp AdvanceRow                  ;Move to next row of structure.

LEF72:* dec $0E                         ;Have all macros been drawn on this row?-->
LEF74:  bne DrawMacro                   ;If not, branch to draw another macro.
LEF76:  lda $10                         ;Load struct index.

AdvanceRow:
LEF78:  sec                             ;Since carry bit is set,-->
LEF79:  adc StructPtr                   ;addition will be one more than expected.
LEF7B:  sta StructPtr                   ;Update the struct pointer.
LEF7D:  bcc +                           ;
LEF7F:  inc StructPtr+1                 ;Update high byte of struct pointer if carry occured.
LEF81:* lda #$40                        ;
LEF83:  clc                             ;
LEF84:  adc CartRAMWorkPtr              ;Advance to next macro row in room RAM(two tile rows).
LEF86:  sta CartRAMWorkPtr              ;
LEF88:  bcc DrawStruct                  ;Begin drawing next structure row.
LEF8A:  inc CartRAMWorkPtr+1            ;Increment high byte of pointer if necessary.

DrawStruct:
LEF8C:  ldy #$00                        ;Reset struct index.
LEF8E:  sty $10                         ;
LEF90:  lda (StructPtr),y               ;Load data byte.
LEF92:  cmp #$FF                        ;End-of-struct?-->
LEF94:  beq +                           ;If so, branch to exit.
LEF96:  jmp DrawStructRow               ;Draw a row of macros.
LEF99:* rts                             ;

;The following table is used to draw macros in room RAM. Each macro is 2 x 2 tiles.
;The following table contains the offsets required to place the tiles in each macro.

TilePosTable:
LEF9A:  .byte $21                       ;Lower right tile.
LEF9B:  .byte $20                       ;Lower left tile.
LEF9C:  .byte $01                       ;Upper right tile.
LEF9D:  .byte $00                       ;Upper left tile.

;---------------------------------[ Update attribute table bits ]------------------------------------

;The following routine updates attribute bits for one 2x2 tile section on the screen.

UpdateAttrib:
LEF9E:  lda ObjectPal                   ;Load attribute data of structure.
LEFA0:  cmp RoomPal                     ;Is it the same as the room's default attribute data?-->
LEFA2:  beq +++++                       ;If so, no need to modify the attribute table, exit.

;Figure out cart RAM address of the byte containing the relevant bits.

LEFA4:  lda $00                         ;
LEFA6:  sta $02                         ;
LEFA8:  lda $01                         ;
LEFAA:  lsr                             ;
LEFAB:  ror $02                         ;
LEFAD:  lsr                             ;
LEFAE:  ror $02                         ;
LEFB0:  lda $02                         ;The following section of code calculates the-->
LEFB2:  and #$07                        ;proper attribute byte that corresponds to the-->
LEFB4:  sta $03                         ;macro that has just been placed in the room RAM.
LEFB6:  lda $02                         ;
LEFB8:  lsr                             ;
LEFB9:  lsr                             ;
LEFBA:  and #$38                        ;
LEFBC:  ora $03                         ;
LEFBE:  ora #$C0                        ;
LEFC0:  sta $02                         ;
LEFC2:  lda #$63                        ;
LEFC4:  sta $03                         ;$0002 contains pointer to attribute byte.

LEFC6:  ldx #$00                        ;
LEFC8:  bit $00                         ;
LEFCA:  bvc +                           ;
LEFCC:  ldx #$02                        ;The following section of code figures out which-->
LEFCE:* lda $00                         ;pair of bits to modify in the attribute table byte-->
LEFD0:  and #$02                        ;for the macro that has just been placed in the-->
LEFD2:  beq +                           ;room RAM.
LEFD4:  inx                             ;

;X now contains which macro attribute table bits to modify:
;+---+---+
;| 0 | 1 |
;+---+---+
;| 2 | 3 |
;+---+---+
;Where each box represents a macro(2x2 tiles).

;The following code clears the old attribute table bits and sets the new ones.
LEFD5:* lda $01                         ;Load high byte of work pointer in room RAM.
LEFD7:  and #$04                        ;
LEFD9:  ora $03                         ;Choose proper attribute table associated with the-->
LEFDB:  sta $03                         ;current room RAM.
LEFDD:  lda AttribMaskTable,x           ;Choose appropriate attribute table bit mask from table below.
LEFE0:  ldy #$00                        ;
LEFE2:  and ($02),y                     ;clear the old attribute table bits.
LEFE4:  sta ($02),y                     ;
LEFE6:  lda ObjectPal                   ;Load new attribute table data(#$00 thru #$03).
LEFE8:* dex                             ;
LEFE9:  bmi +                           ;
LEFEB:  asl                             ;
LEFEC:  asl                             ;Attribute table bits shifted one step left
LEFED:  bcc -                           ;Loop until attribute table bits are in the proper location.
LEFEF:* ora ($02),y                     ;
LEFF1:  sta ($02),y                     ;Set attribute table bits.
LEFF3:* rts                             ;

AttribMaskTable:
LEFF4:  .byte %11111100                 ;Upper left macro.
LEFF5:  .byte %11110011                 ;Upper right macro.
LEFF6:  .byte %11001111                 ;Lower left macro.
LEFF7:  .byte %00111111                 ;Lower right macro.

;------------------------[ Initialize room RAM and associated attribute table ]-----------------------

InitTables:
LEFF8:  lda CartRAMPtr+1                ;#$60 or #$64.
LEFFA:  tay                             ;
LEFFB:  tax                             ;Save value to create counter later.
LEFFC:  iny                             ;
LEFFD:  iny                             ;High byte of address to fill to ($63 or $67).
LEFFE:  iny                             ;
LEFFF:  lda #$FF                        ;Value to fill room RAM with.
LF001:  jsr FillRoomRAM                 ;Fill entire RAM for designated room with #$FF.

LF004:  ldx $01                         ;#$5F or #$63 depening on which room RAM was initialized.
LF006:  jsr Xplus4                      ;X = X + 4.
LF009:  stx $01                         ;Set high byte for attribute table write(#$63 or #$67).
LF00B:  ldx RoomPal                     ;Index into table below (Lowest 2 bits).
LF00D:  lda ATDataTable,x               ;Load attribute table data from table below.
LF010:  ldy #$C0                        ;Low byte of start of all attribute tables.
LF012:* sta ($00),y                     ;Fill attribute table.
LF014:  iny                             ;
LF015:  bne -                           ;Loop until entire attribute table is filled.
LF017:  rts                             ;

ATDataTable:       
LF018:  .byte %00000000                 ;
LF019:  .byte %01010101                 ;Data to fill attribute tables with.
LF01A:  .byte %10101010                 ;
LF01B:  .byte %11111111                 ;

FillRoomRAM:
LF01C:  pha                             ;Temporarily store A.
LF01D:  txa                             ;
LF01E:  sty $01                         ;Calculate value to store in X to use as upper byte-->
LF020:  clc                             ;counter for initilaizing room RAM(X=#$FC).-->
LF021:  sbc $01                         ;Since carry bit is cleared, result is one less than expected.
LF023:  tax                             ;
LF024:  pla                             ;Restore value to fill room RAM with(#$FF).
LF025:  ldy #$00                        ;Lower address byte to start at.
LF027:  sty $00                         ;
LF029:* sta ($00),y                     ;
LF02B:  dey                             ;
LF02C:  bne -                           ;
LF02E:  dec $01                         ;Loop until all the room RAM is filled with #$FF(black).
LF030:  inx                             ;
LF031:  bne -                           ;
LF033:  rts                             ;
