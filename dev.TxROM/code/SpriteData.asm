;---------------------------------[ Object animation data tables ]----------------------------------

;The following tables are indices into the FramePtrTable that correspond to various animations. The
;FramePtrTable represents individual frames and the entries in ObjectAnimIndexTbl are the groups of
;frames responsible for animaton Samus, her weapons and other objects.

ObjectAnimIndexTbl:

;Samus run animation.
L8572:  .byte $03, $04, $05, $FF

;Samus front animation.
L8576:  .byte $07, $FF

;Samus jump out of ball animation.
L8578:  .byte $17

;Samus Stand animation.
L8579:  .byte $08, $FF

;Samus stand and fire animation.
L857B:  .byte $22, $FF

;Samus stand and jump animation.
L857D:  .byte $04

;Samus Jump animation.
L857E:  .byte $10, $FF

;Samus summersault animation.
L8580:  .byte $17, $18, $19, $1A, $FF

;Samus run and jump animation.
L8585:  .byte $03, $17, $FF

;Samus roll animation.
L8588:  .byte $1E, $1D, $1C, $1B, $FF

;Bullet animation.
L858D:  .byte $28, $FF

;Bullet hit animation.
L858F:  .byte $2A, $F7, $FF

;Samus jump and fire animation.
L8592:  .byte $12, $FF

;Samus run and fire animation.
L8594:  .byte $0C, $0D, $0E, $FF

;Samus point up and shoot animation.
L8598:  .byte $30 

;Samus point up animation.
L8599:  .byte $2B, $FF

;Door open animation.
L859B:  .byte $31, $31, $33, $F7, $FF

;Door close animation.
L85A0:  .byte $33, $33, $31, $FF

;Samus explode animation.
L85A4: .byte $35, $FF

;Samus jump and point up animation.
L85A6: .byte $39, $38, $FF

;Samus run and point up animation.
L85A9:  .byte $40, $41, $42, $FF

;Samus run, point up and shoot animation 1.
L85AD:  .byte $46, $FF

;Samus run, point up and shoot animation 2.
L85AF:  .byte $47, $FF

;Samus run, point up and shoot animation 3.
L85B1:  .byte $48, $FF

;Samus on elevator animation 1.
L85B3:  .byte $07, $F7, $F7, $07, $F7, $F7, $F7, $07, $F7, $F7, $F7, $F7, $07, $F7, $FF

;Samus on elevator animation 2.
L85C2:  .byte $23, $F7, $F7, $23, $F7, $F7, $F7, $23, $F7, $F7, $F7, $F7, $23, $F7, $FF

;Samus on elevator animation 3.
L85D1:  .byte $07, $F7, $F7, $F7, $F7, $07, $F7, $F7, $F7, $07, $F7, $F7, $07, $F7, $FF

;Samus on elevator animation 4.
L85E0:  .byte $23, $F7, $F7, $F7, $F7, $23, $F7, $F7, $F7, $23, $F7, $F7, $23, $F7, $FF

;Wave beam animation.
L85EF:  .byte $4B, $FF

;Bomb tick animation.
L85F1:  .byte $4E, $4F, $FF

;Bomb explode animation.
L85F4:  .byte $3C, $4A, $49, $4A, $4D, $4A, $4D, $F7, $FF

;Missile left animation.
L85FD:  .byte $26, $FF

;Missile right animation.
L85FF:  .byte $25, $FF

;Missile up animation.
L8601:  .byte $27, $FF

;Missile explode animation.
L8603:  .byte $67, $67, $67, $68, $68, $69, $F7, $FF

;----------------------------[ Sprite drawing pointer tables ]--------------------------------------
;The above animation pointers provide an index into the following table
;for the animation sequences.

FramePtrTable:
L860B:  .word L87CB, L87CB, L87CB, L87CB, L87DD, L87F0, L8802, L8802
L861B:  .word L8818, L882C, L882C, L882C, L882C, L883E, L8851, L8863
L862B:  .word L8863, L8874, L8874, L8885, L8885, L8885, L8885, L8885
L863B:  .word L888F, L8899, L88A3, L88AD, L88B8, L88C3, L88CE, L88D9
L864B:  .word L88D9, L88D9, L88D9, L88EE, L88F8, L88F8, L88FE, L8904
L865B:  .word L890A, L890F, L890F, L8914, L8928, L8928, L8928, L8928
L866B:  .word L8928, L893C, L8948, L8948, L8954, L8954, L8961, L8961
L867B:  .word L8961, L8974, L8987, L8987, L8987, L8995, L8995, L8995
L868B:  .word L8995, L89A9, L89BE, L89D2, L89D2, L89D2, L89D2, L89E6
L869B:  .word L89FB, L8A0F, L8A1D, L8A21, L8A26, L8A26, L8A3C, L8A41
L86AB:  .word L8A46, L8A4E, L8A56, L8A5E, L8A66, L8A6E, L8A76, L8A7E
L86BB:  .word L8A86, L8A8E, L8A9C, L8AA1, L8AA6, L8AAE, L8ABA, L8AC4
L86CB:  .word L8AC4, L8AC4, L8AC4, L8AC4, L8AC4, L8AC4, L8AD8, L8AE9
L86DB:  .word L8AF3, L8B03

;The following table provides pointers to data used for the placement of the sprites that make up
;Samus and other non-enemy objects.

PlacePtrTable:
L86DF:  .word L8701, L871F, L872B, L8737, L8747, L8751, L86FD, L875D
L86EF:  .word L8775, L878D, L8791, L8799, L87A5, L8749, L87B1

;------------------------------[ Sprite placement data tables ]-------------------------------------

;Sprite placement data. The placement data is grouped into two byte segments. The first byte is the
;y placement byte and the second is the x placement byte.  If the MSB is set in the byte, the byte
;is in twos compliment format so when it is added to the object position, the end result is to
;decrease the x or y position of the sprite.  The Samus explode table is a special case with special
;data bytes. The format of those data bytes is listed just above the Samus explode data. Each data
;table has a graphical representation above it to show how the sprites are laid out with respect to
;the object position, which is represented by a * in the table. The numbers in the lower right corner
;of the boxes indicates which segment of the data table represents which box in the graphic. Each box
;is filled with an 8x8 sprite.

;Samus pointing up frames. Added to the main Samus animation table below.
;          +--------+ <----0
;          +--------+ <----1
;          |        |
;          |        |
;          |        |
;          +--------+
;          +--------+
;
;
;
;
;
;
;
;
;               *
;              +--0--+   +--1--+
L86FD:  .byte $E8, $FC, $EA, $FC

;Several Samus frames.
;      +-------+ <---------------D
;      +-------+ <---------------E
;      |       |
;      |   +---+----+--------+
;      |   |   |    |        |
;      +-------+    |        |
;      +-------+    |        |
;          |       0|       1|
; +----+-+-+----+-+-+--------+
; |    | | |    | | |        |
; |    | | |    | | |        |
; |    | | |    | | |        |
; |    | |2|   B|C|3|       4|
; +----+-+-+----+-+-*--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       5|       6|       7|
;          +--------+--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       8|       9|       A|
;          +--------+--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
L8701:  .byte $F0, $F8, $F0, $00, $F8, $F0, $F8, $F8, $F8, $00, $00, $F8, $00, $00, $00, $08
;              +--8--+   +--9--+   +--A--+   +--B--+   +--C--+   +--D--+   +--E--+
L8711:  .byte $08, $F8, $08, $00, $08, $08, $F8, $F4, $F8, $F6, $EC, $F4, $EE, $F4

;Samus summersault and roll frames.
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       0|       1|
;          +--------+--------+
;          |        |        |
;          +--------+--------+
;          |        *        |
;          |       2|       3|
;          +--------+--------+
;          |       4|       5|
;          +--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
L871F:  .byte $F3, $F8, $F3, $00, $FB, $F8, $FB, $00, $03, $F8, $03, $00 

;Samus summersault frame.
;          +--------+--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       0|       1|       2|
;          +--------+-*------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       3|       4|       5|
;          +--------+--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
L872B:  .byte $F8, $F6, $F8, $FE, $F8, $06, $00, $F6, $00, $FE, $00, $06

;Elevator frame.
;          +--------+--------+--------+--------+--------+--------+--------+--------+
;          |        |        |        |        |        |        |        |        |
;          |        |        |        |        |        |        |        |        |
;          |        |        *        |        |        |        |        |        |
;          |       0|       1|       2|       3|       4|       5|       6|       7|
;          +--------+--------+--------+--------+--------+--------+--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
L8737:  .byte $FC, $F0, $FC, $F8, $FC, $00, $FC, $08, $FC, $10, $FC, $18, $FC, $20, $FC, $28

;Several projectile frames.
;          +--------+
;          |        |
;          |        |
;          |    *   |
;          |       0|
;          +--------+
;              +--0--+
L8747:  .byte $FC, $FC

;Power-up items and bomb explode frames.
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       0|       1|
;          +--------*--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       2|       3|
;          +--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+
L8749:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

;Door frames.
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       0|
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       1|
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       2|
;          *--------+
;          |        |
;          |        |
;          |        |
;          |       3|
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       4|
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       5|
;          +--------+
;              +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
L8751:  .byte $E8, $00, $F0, $00, $F8, $00, $00, $00, $08, $00, $10, $00 

;Samus explode. Special case. The bytes that are #L8X indicate displacement data will be loaded
;from a table for the y direction and from a counter for the x direction.  The initial displacement
;bytes start at L8769.  If the LSB is clear in the bytes where the upper nibble is #L8, those
;data bytes will be used to decrease the x position of the sprite each frame. If the LSB is set,
;the data bytes will increase the x position of the sprite each frame.
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       0|       1|
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        *        |
;          |       2|       3|
;          +--------+--------+
;          |        |        |
;          |        |        |
;          |        |        |
;          |       4|       5|
;          +--------+--------+
;                                                                          +--0--+   +--1--+
L875D:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
;              +--2--+   +--3--+   +--4--+   +--5--+
L876D:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

;Bomb explode frame.
;          +--------+--------+--------+--------+
;          |        |        |        |        |
;          |        |        |        |        |
;          |        |        |        |        |
;          |       3|       4|       0|       1|
;          +--------+--------+--------+--------+
;          |        |                 |        |
;          |        |                 |        |
;          |        |                 |        |
;          |       5|                 |       2|
;          +--------+        *        +--------+
;          |        |                 |        |
;          |        |                 |        |
;          |        |                 |        |
;          |       6|                 |       9|
;          +--------+--------+--------+--------+
;          |        |        |        |        |
;          |        |        |        |        |
;          |        |        |        |        |
;          |       7|       8|       A|       B|
;          +--------+--------+--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
L8775:  .byte $F0, $00, $F0, $08, $F8, $08, $F0, $F0, $F0, $F8, $F8, $F0, $00, $F0, $08, $F0
;              +--8--+   +--9--+   +--A--+   +--B--+
L8785:  .byte $08, $F8, $00, $08, $08, $00, $08, $08

;Missile up frame.
;          +--------+
;          |        |
;          |        |
;          |        |
;          |       0|
;          +----*---+
;          |        |
;          |        |
;          |        |
;          |       1|
;          +--------+
;              +--0--+   +--1--+
L878D:  .byte $F8, $FC, $00, $FC

;Missile left/right and missile explode frames.
;          +--------+--------+        +--------+--------+
;          |        |        |        |        |        |
;          |        |        |        |        |        |
;          |        *        |        |        |        |
;          |       0|       1|        |       2|       3|
;          +--------+--------+        +--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+
L8791:  .byte $FC, $F8, $FC, $00, $FC, $10, $FC, $18

;Missile explode frame.
;                   +--------+--------+
;                   |        |        |
;                   |        |        |
;                   |        |        |
;                   |       1|       2|
;          +--------+--------+--------+--------+
;          |        |                 |        |
;          |        |                 |        |
;          |        |        *        |        |
;          |       0|                 |       3|
;          +--------+--------+--------+--------+
;                   |        |        |
;                   |        |        |
;                   |        |        |
;                   |       4|       5|
;                   +--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
L8799:  .byte $FC, $F0, $F4, $F8, $F4, $00, $FC, $08, $04, $F8, $04, $00

;Missile explode frame.
;                    +--------+                 +--------+
;                    |        |                 |        |
;                    |        |                 |        |
;                    |        |                 |        |
;                    |       1|                 |       2|
;                    +--------+                 +--------+
;
;
;
;
;          +--------+                                     +--------+
;          |        |                                     |        |
;          |        |                                     |        |
;          |        |                  *                  |        |
;          |       0|                                     |       3|
;          +--------+                                     +--------+
;
;
;
;
;                    +--------+                 +--------+
;                    |        |                 |        |
;                    |        |                 |        |
;                    |        |                 |        |
;                    |       4|                 |       5|
;                    +--------+                 +--------+
;              +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+
L87A5:  .byte $FC, $E8, $EC, $F0, $EC, $08, $FC, $10, $0C, $F0, $0C, $08

;Statue frames.
;          +--------+--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       4|       5|       6|
;          +--------+--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       7|       8|       9|
;          +--------+--------+--------+
;          |        |        |        |
;          |        |        |        |
;          |        |        |        |
;          |       A|       B|       C|
;          +--------+--------*--------+
;                   |        |        |
;                   |        |        |
;                   |        |        |
;                   |       0|       1|
;                   +--------+--------+
;                   |        |        |
;                   |        |        |
;                   |        |        |
;                   |       2|       3|
;                   +--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
L87B1:  .byte $00, $F8, $00, $00, $08, $F8, $08, $00, $E8, $F0, $E8, $F8, $E8, $00, $F0, $F0
;              +--8--+   +--9--+   +--A--+   +--B--+   +--C--+
L87C1:  .byte $F0, $F8, $F0, $00, $F8, $F0, $F8, $F8, $F8, $00

;-------------------------------[ Sprite frame data tables ]---------------------------------------

;Frame drawing data. The format for the frame drawing data is as follows:
;There are 4 control bytes associated with the frame data and they are #$FC, #$FD, #$FE and #$FF.
;
;#$FC displaces the location of the object in the x and y direction.  The first byte following #$FC
;is the y displacement of the object and the second byte is the x displacement. any further bytes
;are pattern table index bytes until the next control byte is reached.
;
;#$FD tells the program to change the sprite control byte.  The next byte after #$FD is the new
;control byte.  Only the 4 upper bits are used. Any further bytes are pattern table index bytes
;until the next control byte is reached.
;
;#$FE causes the next placement position to be skipped.  Any further bytes are pattern table index
;bytes until the next control byte is reached.
;
;#$FF ends the frame drawing data segment. 
;
;The first 3 bytes are unique.  The first byte contains two parts: AAAABBBB. The upper 4 bits
;are sprite control data which control mirroring and color bits.  The lower 4 bits are multiplied
;by 2 and used as an index into the PlacePtrTable to find the proper placement data for the
;current frame.  The second byte is saved as the object's y radius and the third byte is saved
;as the object's x radius.

;Samus run.
L87CB:  .byte $40, $0F, $04, $00, $01, $FD, $20, $FE, $41, $40, $FD, $60, $20, $21, $FE, $FE
L87DB:  .byte $31, $FF

;Samus run.
L87DD:  .byte $40, $0F, $04, $02, $03, $FD, $20, $FE, $43, $42, $FD, $60, $22, $23, $FE, $32
L87ED:  .byte $33, $34, $FF

;Samus run.
L87F0:  .byte $40, $0F, $04, $05, $06, $FD, $20, $FE, $45, $44, $FD, $60, $25, $26, $27, $35
L8800:  .byte $36, $FF

;Samus facing forward.
L8802:  .byte $00, $0F, $04, $09, $FD, $60, $09, $FD, $20, $FE, $19, $1A, $FD, $20, $29, $2A
L8812:  .byte $FE, $39, $FD, $60, $39, $FF

;Samus stand.
L8818:  .byte $40, $0F, $04, $FD, $20, $0E, $0D, $FE, $1E, $1D, $2E, $2D, $FE, $FD, $60, $3B
L8828:  .byte $3C, $FE, $17, $FF

;Samus run and fire.
L882C:  .byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $20, $21, $FE, $FE
L883C:  .byte $31, $FF

;Samus run and fire.
L883E:  .byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $22, $23, $FE, $32
L884E:  .byte $33, $34, $FF

;Samus run and fire.
L8851:  .byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $25, $26, $27, $35
L8861:  .byte $36, $FF

;Samus stand and jump.
L8863:  .byte $40, $0F, $04, $00, $01, $FD, $20, $FE, $41, $40, $FD, $60, $22, $07, $08, $32
L8873:  .byte $FF

;Samus jump and fire.
L8874:  .byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $22, $07, $08, $32
L8884:  .byte $FF

;Samus summersault.
L8885:  .byte $41, $0F, $04, $52, $53, $62, $63, $72, $73, $FF

;Samus summersault.
L888F:  .byte $42, $0F, $04, $54, $55, $56, $64, $65, $66, $FF

;Samus summersault.
L8899:  .byte $81, $0F, $04, $52, $53, $62, $63, $72, $73, $FF

;Samus summersault.
L88A3:  .byte $82, $0F, $04, $54, $55, $56, $64, $65, $66, $FF

;Samus roll.
L88AD:  .byte $01, $08, $04, $FC, $03, $00, $50, $51, $60, $61, $FF

;Samus roll.
L88B8:  .byte $81, $08, $04, $FC, $FD, $00, $50, $51, $60, $61, $FF

;Samus roll.
L88C3:  .byte $C1, $08, $04, $FC, $FD, $00, $50, $51, $60, $61, $FF

;Samus roll.
L88CE:  .byte $41, $08, $04, $FC, $03, $00, $50, $51, $60, $61, $FF

;Samus stand and fire.
L88D9:  .byte $40, $0F, $04, $FD, $20, $0E, $0D, $FE, $1E, $1D, $2E, $2D, $FE, $FD, $60, $3B
L88E9:  .byte $3C, $FE, $FE, $17, $FF

;Elevator.
L88EE:  .byte $03, $04, $10, $28, $38, $38, $FD, $60, $28, $FF

;Missile right.
L88F8:  .byte $4A, $04, $08, $5E, $5F, $FF

;Missile left.
L88FE:  .byte $0A, $04, $08, $5E, $5F, $FF

;Missile up.
L8904:  .byte $09, $08, $04, $14, $24, $FF

;Bullet fire.
L890A:  .byte $04, $02, $02, $30, $FF

;Bullet hit.
L890F:  .byte $04, $00, $00, $04, $FF

;Samus stand and point up.
L8914:  .byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $2E, $2D, $FE, $FD
L8924:  .byte $60, $3B, $3C, $FF

;Samus from ball to pointing up.
L8928:  .byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $2E, $2D, $FE, $FD
L8938:  .byte $60, $3B, $3C, $FF

;Door closed.
L893C:  .byte $35, $18, $08, $0F, $1F, $2F, $FD, $A3, $2F, $1F, $0F, $FF

;Door open/close.
L8948:  .byte $35, $18, $04, $6A, $6B, $6C, $FD, $A3, $6C, $6B, $6A, $FF

;Samus explode.
L8954:  .byte $07, $00, $00, $FC, $FC, $00, $0B, $0C, $1B, $1C, $2B, $2C, $FF

;Samus jump and point up.
L8961:  .byte $46, $0F, $04, $69, $FD, $20, $FE, $7A, $79, $FE, $78, $77, $FD, $60, $22, $07
L8971:  .byte $08, $32, $FF

;Samus jump and point up.
L8974:  .byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $22, $07
L8984:  .byte $08, $32, $FF

;Bomb explode.
L8987:  .byte $0D, $0C, $0C, $74, $FD, $60, $74, $FD, $A0, $74, $FD, $E0, $74, $FF

;Samus run and point up.
L8995:  .byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $20, $21
L89A5:  .byte $FE, $FE, $31, $FF

;Samus run and point up.
L89A9:  .byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $22, $23
L89B9:  .byte $FE, $32, $33, $34, $FF

;Samus run and point up.
L89BE:  .byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $25, $26
L89CE:  .byte $27, $35, $36, $FF

;Samus run and point up.
L89D2:  .byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $20, $21
L89E2:  .byte $FE, $FE, $31, $FF

;Samus point up, run and fire.
L89E6:  .byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $22, $23
L89F6:  .byte $FE, $32, $33, $34, $FF

;Samus point up, run and fire.
L89FB:  .byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $25, $26
L8A0B:  .byte $27, $35, $36, $FF

;Bomb explode.
L8A0F:  .byte $0D, $0C, $0C, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

;Bomb explode.
L8A1D:  .byte $00, $00, $00, $FF

;Wave beam.
L8A21:  .byte $04, $04, $04, $4C, $FF

;Bomb explode.
L8A26:  .byte $08, $10, $10, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD, $E0, $4E, $3E, $3D
L8A36:  .byte $FD, $A0, $4E, $3D, $3E, $FF

;Bomb tick.
L8A3C:  .byte $04, $04, $04, $70, $FF

;Bomb tick.
L8A41:  .byte $04, $04, $04, $71, $FF

;Bomb item.
L8A46:  .byte $0D, $03, $03, $86, $87, $96, $97, $FF

;High jump item.
L8A4E:  .byte $0D, $03, $03, $7B, $7C, $8B, $8C, $FF

;Long beam item.
L8A56:  .byte $0D, $03, $03, $88, $67, $98, $99, $FF

;Screw attack item.
L8A5E:  .byte $0D, $03, $03, $80, $81, $90, $91, $FF

;Maru Mari item.
L8A66:  .byte $0D, $03, $03, $7D, $7E, $8D, $8E, $FF

;Varia item.
L8A6E:  .byte $0D, $03, $03, $82, $83, $92, $93, $FF

;Wave beam item.
L8A76:  .byte $0D, $03, $03, $88, $89, $98, $99, $FF

;Ice beam item.
L8A7E:  .byte $0D, $03, $03, $88, $68, $98, $99, $FF

;Energy tank item.
L8A86:  .byte $0D, $03, $03, $84, $85, $94, $95, $FF

;Missile item.
L8A8E:  .byte $0D, $03, $03, $3F, $FD, $40, $3F, $FD, $00, $4F, $FD, $40, $4F, $FF

;Skree burrow.
L8A9C:  .byte $34, $04, $04, $F2, $FF

;Not used.
L8AA1:  .byte $04, $00, $00, $5A, $FF
L8AA6:  .byte $13, $00, $00, $B0, $B1, $B2, $B3, $FF
L8AAE:  .byte $13, $00, $00, $B4, $B5, $B6, $B7, $B8, $B6, $B9, $B3, $FF
L8ABA:  .byte $13, $00, $00, $B3, $BA, $BA, $FE, $80, $80, $FF

;Kraid statue.
L8AC4:  .byte $1E, $00, $08, $FA, $FB, $FA, $FB, $FC, $00, $04, $C5, $C6, $C7, $D5, $D6, $D7
L8AD4:  .byte $E5, $E6, $E7, $FF

;Ridley statue.
L8AD8:  .byte $1E, $00, $08, $FA, $FB, $FA, $FB, $FE, $C8, $C9, $EB, $D8, $D9, $EA, $E8, $E9
L8AE8:  .byte $FF

;Missile explode.
L8AE9:  .byte $0A, $04, $08, $FD, $00, $57, $FD, $40, $57, $FF

;Missile explode.
L8AF3:  .byte $0B, $04, $0C, $FD, $00, $57, $18, $FD, $40, $18, $57, $FD, $C0, $18, $18, $FF

;Missile explode.
L8B03:  .byte $0C, $04, $10, $FD, $00, $57, $18, $FD, $40, $18, $57, $FD, $C0, $18, $18, $FF