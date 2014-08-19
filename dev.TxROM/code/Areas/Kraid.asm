; METROID source code
; (C) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, 
;      GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Can be reassembled using Ophis.
;Kraid hideout (memory page 4)

.require "../Defines.asm"
.require "../GameEngineDeclarations.asm"

.org $8000
.include "../AreaCommon.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

;Samus end tile patterns.
L8D60:  .byte $00, $00, $00, $00, $01, $01, $03, $03, $00, $00, $00, $00, $00, $00, $00, $00
L8D70:  .byte $00, $00, $3C, $FF, $FF, $BD, $5A, $24, $00, $00, $00, $20, $00, $42, $E7, $FF
L8D80:  .byte $00, $00, $00, $00, $00, $01, $01, $03, $00, $00, $00, $00, $00, $00, $0C, $1C
L8D90:  .byte $00, $00, $00, $3C, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $40, $80, $00
L8DA0:  .byte $00, $00, $00, $00, $00, $80, $A0, $F0, $00, $00, $00, $00, $00, $00, $20, $30
L8DB0:  .byte $1D, $39, $38, $70, $F0, $F0, $F0, $E0, $1D, $39, $18, $60, $F0, $F0, $F0, $E0
L8DC0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L8DD0:  .byte $80, $80, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $00, $00, $00, $00
L8DE0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DF0:  .byte $E7, $E7, $C3, $C3, $42, $C3, $E7, $E7, $E7, $E7, $C3, $00, $42, $C3, $E7, $E7
L8E00:  .byte $0E, $0D, $07, $0E, $1C, $19, $1B, $1A, $0E, $0D, $07, $0E, $1C, $18, $18, $18
L8E10:  .byte $7C, $6D, $39, $10, $38, $FF, $FF, $7C, $00, $11, $01, $00, $00, $00, $00, $82
L8E20:  .byte $88, $0C, $8C, $DC, $5C, $0C, $88, $98, $80, $00, $80, $C0, $40, $00, $00, $00
L8E30:  .byte $00, $00, $01, $03, $03, $07, $07, $0E, $00, $00, $01, $03, $03, $07, $07, $0E
L8E40:  .byte $1C, $7E, $FF, $E7, $99, $3D, $7C, $56, $1C, $7E, $FF, $E7, $81, $01, $00, $00
L8E50:  .byte $00, $00, $00, $00, $80, $80, $80, $80, $00, $00, $00, $00, $80, $80, $80, $80
L8E60:  .byte $03, $03, $03, $0F, $1F, $1F, $1F, $07, $00, $00, $00, $0F, $1F, $1F, $1F, $0E
L8E70:  .byte $00, $81, $C3, $66, $A5, $DB, $FF, $FF, $7E, $3C, $18, $00, $C3, $A7, $44, $88
L8E80:  .byte $03, $03, $02, $0F, $1F, $1F, $1F, $07, $1C, $0C, $00, $0F, $1F, $1F, $1F, $0F
L8E90:  .byte $FF, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $3C, $FF, $FF, $FF, $FF, $FF, $FF
L8EA0:  .byte $D8, $D8, $78, $F0, $F0, $E0, $C0, $80, $18, $18, $38, $F0, $F0, $E0, $C0, $80
L8EB0:  .byte $70, $F9, $F9, $D1, $71, $01, $00, $00, $40, $01, $01, $01, $01, $01, $00, $00
L8EC0:  .byte $FF, $FF, $E7, $E7, $E7, $E7, $E7, $E7, $FF, $FF, $E7, $E7, $E7, $E7, $E7, $E7
L8ED0:  .byte $00, $80, $80, $80, $80, $80, $00, $00, $00, $80, $80, $80, $80, $80, $00, $00
L8EE0:  .byte $01, $01, $01, $03, $03, $01, $01, $00, $01, $01, $00, $00, $00, $02, $00, $00
L8EF0:  .byte $E7, $E7, $E7, $E7, $E7, $C3, $C3, $00, $E7, $E7, $E7, $C3, $C3, $24, $00, $00
L8F00:  .byte $0A, $0A, $02, $06, $06, $06, $0C, $0C, $09, $09, $00, $00, $00, $00, $00, $00
L8F10:  .byte $38, $00, $10, $38, $7C, $7C, $38, $81, $C7, $EF, $C6, $00, $00, $00, $C6, $3C
L8F20:  .byte $D8, $F8, $70, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F30:  .byte $0E, $0D, $07, $0E, $1C, $18, $18, $18, $0E, $0D, $07, $0E, $1C, $19, $1B, $1A
L8F40:  .byte $7C, $6D, $39, $10, $38, $7C, $7C, $38, $00, $11, $01, $00, $82, $83, $83, $C6
L8F50:  .byte $88, $0C, $8C, $DC, $5C, $0C, $00, $00, $80, $00, $80, $C0, $40, $00, $80, $98
L8F60:  .byte $0D, $1D, $1C, $39, $78, $08, $00, $10, $0C, $1C, $05, $31, $78, $78, $B8, $B8
L8F70:  .byte $FF, $FF, $E7, $66, $99, $FF, $FF, $FF, $10, $00, $18, $99, $FF, $FF, $FF, $FF
L8F80:  .byte $B0, $B8, $38, $9C, $1E, $1E, $1E, $3F, $30, $38, $B0, $8C, $1E, $1E, $1C, $00
L8F90:  .byte $00, $00, $00, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FA0:  .byte $00, $00, $00, $00, $00, $00, $04, $00, $00, $40, $00, $00, $00, $00, $00, $00
L8FB0:  .byte $00, $00, $00, $00, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FC0:  .byte $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $40, $00, $00, $00
L8FD0:  .byte $00, $00, $00, $00, $81, $DB, $FF, $FF, $00, $00, $00, $00, $C3, $A7, $44, $88
L8FE0:  .byte $00, $00, $00, $F0, $F8, $F8, $F8, $E0, $00, $00, $00, $F0, $F8, $F8, $F8, $70
L8FF0:  .byte $80, $00, $80, $C0, $40, $00, $00, $00, $80, $00, $80, $C0, $40, $00, $80, $80
L9000:  .byte $80, $00, $80, $C0, $40, $00, $01, $00, $80, $00, $80, $C0, $40, $00, $80, $C2
L9010:  .byte $00, $00, $00, $00, $40, $F8, $F8, $70, $00, $00, $00, $00, $00, $00, $00, $00
L9020:  .byte $80, $00, $80, $C0, $40, $00, $80, $80, $80, $00, $80, $C0, $40, $00, $00, $00
L9030:  .byte $08, $08, $00, $00, $00, $00, $00, $00, $0B, $0B, $02, $06, $06, $06, $0C, $0C
L9040:  .byte $10, $00, $00, $00, $00, $00, $00, $81, $EF, $EF, $D6, $38, $7C, $7C, $FE, $3C
L9050:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $D8, $78, $70, $30, $00, $00, $00, $00
L9060:  .byte $10, $00, $01, $01, $01, $01, $01, $01, $B8, $B8, $B9, $89, $89, $71, $01, $01
L9070:  .byte $FF, $FF, $E7, $E7, $C3, $C3, $C3, $C3, $FF, $FF, $E7, $E7, $C3, $C3, $C3, $C3
L9080:  .byte $1E, $0F, $9F, $9F, $96, $86, $8C, $80, $00, $00, $80, $80, $80, $80, $80, $80
L9090:  .byte $C0, $80, $00, $80, $00, $00, $00, $00, $40, $00, $80, $80, $00, $00, $00, $00
L90A0:  .byte $0E, $1F, $1F, $1B, $9F, $8F, $C7, $CE, $00, $00, $00, $00, $00, $00, $00, $02
L90B0:  .byte $00, $00, $00, $0F, $1F, $1F, $1F, $07, $00, $00, $00, $0F, $1F, $1F, $1F, $0E
L90C0:  .byte $00, $00, $01, $03, $03, $07, $07, $0F, $00, $00, $01, $03, $03, $07, $07, $0F
L90D0:  .byte $1C, $7E, $FF, $FF, $FF, $FF, $FF, $FF, $1C, $7E, $FF, $FF, $E7, $C3, $83, $A9
L90E0:  .byte $00, $00, $00, $00, $80, $80, $C0, $C0, $00, $00, $00, $00, $80, $80, $C0, $C0
L90F0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $80, $C0, $C0, $C0, $C0, $60, $70
L9100:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $E7, $7E, $18, $00, $00, $00, $00, $00
L9110:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $78, $38, $38, $30, $78, $78, $F8, $C0
L9120:  .byte $80, $80, $80, $C0, $C0, $60, $60, $30, $00, $00, $00, $00, $00, $00, $00, $00
L9130:  .byte $09, $0D, $0D, $09, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9140:  .byte $C3, $C3, $E7, $E7, $E7, $E7, $E7, $63, $18, $18, $00, $00, $00, $00, $00, $00
L9150:  .byte $00, $80, $80, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9160:  .byte $01, $01, $01, $03, $03, $03, $07, $07, $01, $00, $01, $03, $03, $03, $07, $07
L9170:  .byte $81, $81, $81, $00, $81, $81, $81, $81, $81, $81, $00, $00, $81, $81, $81, $81
L9180:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9190:  .byte $00, $00, $80, $80, $80, $80, $80, $80, $00, $00, $80, $80, $80, $80, $80, $80
L91A0:  .byte $CF, $C7, $F7, $EF, $EF, $FF, $FE, $DE, $07, $07, $77, $EF, $EF, $FF, $FA, $5C
L91B0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $03
L91C0:  .byte $0F, $0F, $00, $00, $00, $00, $00, $00, $0F, $0F, $00, $00, $00, $00, $00, $00
L91D0:  .byte $FF, $EF, $FF, $7C, $38, $00, $00, $00, $83, $93, $C7, $6C, $00, $00, $00, $00
L91E0:  .byte $C0, $C0, $00, $00, $00, $00, $00, $00, $C0, $C0, $00, $00, $00, $00, $00, $00
L91F0:  .byte $81, $81, $00, $81, $00, $81, $00, $00, $00, $00, $00, $00, $81, $00, $00, $00
L9200:  .byte $80, $00, $80, $C0, $40, $00, $81, $C3, $80, $00, $80, $C0, $40, $00, $00, $00
L9210:  .byte $00, $00, $00, $00, $40, $F8, $F8, $70, $00, $00, $00, $00, $00, $00, $00, $00
L9220:  .byte $10, $B0, $B0, $90, $90, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9230:  .byte $E7, $7E, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9240:  .byte $63, $31, $31, $39, $39, $39, $18, $00, $00, $00, $00, $00, $00, $00, $00, $60
L9250:  .byte $00, $80, $80, $C0, $C0, $C0, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $30
L9260:  .byte $07, $07, $0F, $08, $07, $0F, $07, $00, $03, $00, $00, $07, $08, $00, $00, $00
L9270:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $F0, $F0, $70, $78, $38, $78, $7C, $1E

.advance $9360, $00

;Misc. tile patterns.
L9360:  .byte $FF, $FF, $C0, $C0, $CF, $CB, $CC, $CC, $00, $00, $1F, $3F, $3F, $38, $3B, $3B
L9370:  .byte $FC, $FC, $0C, $0C, $CC, $4C, $CC, $CC, $00, $04, $EC, $FC, $FC, $3C, $BC, $BC
L9380:  .byte $CB, $CF, $C0, $C0, $FF, $FF, $00, $00, $3B, $30, $3F, $1F, $7F, $FF, $00, $00
L9390:  .byte $4C, $CC, $0C, $0C, $FC, $FC, $00, $00, $3C, $3C, $FC, $EC, $FC, $FC, $00, $00
L93A0:  .byte $FE, $02, $02, $02, $FE, $00, $00, $7F, $00, $FE, $0E, $FE, $FE, $00, $00, $00
L93B0:  .byte $7F, $40, $40, $40, $7F, $00, $00, $FE, $00, $3F, $30, $3F, $7F, $00, $00, $00
L93C0:  .byte $40, $40, $40, $7F, $00, $00, $00, $FF, $3F, $30, $3F, $7F, $00, $00, $FF, $FF
L93D0:  .byte $02, $02, $02, $FE, $00, $00, $00, $FF, $FE, $0E, $FE, $FE, $00, $00, $FF, $FF
L93E0:  .byte $FF, $FF, $C0, $D0, $C0, $C0, $C0, $C0, $00, $00, $3F, $27, $3F, $3F, $3F, $3F
L93F0:  .byte $FC, $FC, $0C, $4C, $0C, $0C, $0C, $0C, $00, $04, $FC, $9C, $FC, $FC, $FC, $FC
L9400:  .byte $C0, $C0, $D0, $C0, $FF, $FF, $00, $00, $3F, $3F, $27, $3F, $3F, $7F, $00, $00
L9410:  .byte $0C, $0C, $4C, $0C, $FC, $FC, $00, $00, $FC, $FC, $9C, $FC, $FC, $FC, $00, $00
L9420:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $20, $48, $30, $5A, $FC, $76, $BE, $2C
L9430:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $7E, $75, $1C, $AA, $54, $30, $44, $10
L9440:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $04, $12, $0C, $5A, $3F, $6E, $7D, $34
L9450:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $7E, $AE, $38, $55, $2A, $0C, $22, $08
L9460:  .byte $45, $D7, $FF, $FF, $FD, $FF, $BF, $FB, $00, $00, $00, $00, $02, $00, $40, $04
L9470:  .byte $FF, $BB, $FF, $FF, $EF, $FF, $7F, $FD, $00, $44, $00, $00, $10, $00, $80, $02
L9480:  .byte $7E, $42, $C2, $1E, $02, $06, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9490:  .byte $00, $00, $00, $00, $04, $12, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94A0:  .byte $44, $FE, $44, $44, $04, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94B0:  .byte $06, $0C, $38, $F0, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94C0:  .byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94D0:  .byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94E0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94F0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9500:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9510:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9520:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9530:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9540:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9550:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

L9560:  .word Palette00                 ;($A155)
L9562:  .word Palette01                 ;($A179)
L9564:  .word Palette02                 ;($A185)
L9566:  .word Palette03                 ;($A17F)
L9668:  .word Palette04                 ;($A18B)
L966A:  .word Palette05                 ;($A191)
L956C:  .word Palette05                 ;($A191)
L956E:  .word Palette05                 ;($A191)
L9570:  .word Palette05                 ;($A191)
L9572:  .word Palette05                 ;($A191)
L9574:  .word Palette05                 ;($A191)
L9576:  .word Palette05                 ;($A191)
L9578:  .word Palette05                 ;($A191)
L957A:  .word Palette05                 ;($A191)
L957C:  .word Palette05                 ;($A191)
L957E:  .word Palette05                 ;($A191)
L9580:  .word Palette05                 ;($A191)
L9582:  .word Palette05                 ;($A191)
L9584:  .word Palette05                 ;($A191)
L9586:  .word Palette05                 ;($A191)
L9588:  .word Palette06                 ;($A198)
L958A:  .word Palette07                 ;($A19F)
L958C:  .word Palette08                 ;($A1A6)
L958E:  .word Palette09                 ;($A1AD)
L9590:  .word Palette0A                 ;($A1B5)
L9592:  .word Palette0B                 ;($A1BD)
L9594:  .word Palette0C                 ;($A1C5)
L9596:  .word Palette0D                 ;($A1CD)

AreaPointers:
L9598:  .word SpecItmsTbl               ;($A26D)Beginning of special items table.
L959A:  .word RmPtrTbl                  ;($A1D5)Beginning of room pointer table.
L959C:  .word StrctPtrTbl               ;($A21F)Beginning of structure pointer table.
L959E:  .word MacroDefs                 ;($AC32)Beginning of macro definitions.
L95A0:  .word EnemyFramePtrTbl1         ;($9CF7)Address table into enemy animation data. Two-->
L95A2:  .word EnemyFramePtrTbl2         ;($9DF7)tables needed to accommodate all entries.
L95A4:  .word EnemyPlacePtrTbl          ;($9E25)Pointers to enemy frame placement data.
L95A6:  .word EnemyAnimIndexTbl         ;($9C86)Index to values in addr tables for enemy animations.

L95A8:  .byte $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60
L95B8:  .byte $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA

AreaRoutine:
L95C3:  JMP $9C49                       ;Area specific routine.

TwosCompliment_:
L95C6:  EOR #$FF                        ;
L95C8:  CLC                             ;The following routine returns the twos-->
L95C9:  ADC #$01                        ;compliment of the value stored in A.
L95CB:  RTS                             ;

L95CC:  .byte $1D                       ;Kraid's room.

L95CD:  .byte $10                       ;Kraid's hideout music init flag.

L95CE:  .byte $00                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $02                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:  .byte $07                       ;Samus start x coord on world map.
L95D8:  .byte $14                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $06, $00, $03, $43, $00, $00, $00, $00, $00, $00, $64

L95E5:  LDA EnDataIndex,X
L95E8:  JSR CommonJump_ChooseRoutine

L95EB:  .word $991C
L95ED:  .word $9937
L95EF:  .word $95CB
L95F1:  .word $993C
L95F3:  .word $9949
L95F5:  .word $999B
L95F7:  .word $95CB
L95F9:  .word $9A44
L95FB:  .word $9AB4
L95FD:  .word $9AE4
L95FF:  .word $9B2C
L9601:  .word $95CB
L9603:  .word $95CB
L9605:  .word $95CB
L9607:  .word $95CB
L9609:  .word $95CB

L960B:  .byte $27, $27, $29, $29, $2D, $2B, $31, $2F, $33, $33, $41, $41, $48, $48, $50, $4E

L961B:  .byte $6D, $6F, $00, $00, $00, $00, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L962B:  .byte $08, $08, $00, $FF, $02, $02, $00, $01, $60, $FF, $FF, $00, $00, $00, $00, $00

L963B:  .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $54, $52

L964B:  .byte $67, $6A, $56, $58, $5D, $62, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L965B:  .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $4B, $48

L966B:  .byte $67, $6A, $56, $58, $5A, $5F, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00

L968B:  .byte $89, $89, $09, $00, $86, $04, $89, $80, $83, $00, $00, $00, $82, $00, $00, $00

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $40, $00, $00, $00

L96AB:  .byte $00, $00, $06, $00, $83, $00, $84, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96BB:  .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

L96CB:  .byte $00, $03, $00, $06, $08, $0C, $00, $0A, $0E, $11, $13, $00, $00, $00, $00, $00


L96DB:  .word $97E9, $97EC, $97EF, $97EF, $97EF, $97EF, $97EF, $97EF
L96EB:  .word $97EF, $97EF, $97EF, $97EF, $97EF, $97F2, $97F5, $9809
L96FB:  .word $981D, $981D, $981D, $981D, $981D, $981D, $981D, $981D
L970B:  .word $981D, $9824, $982B, $9832, $9839, $983C, $983F, $9856
L971B:  .word $986D, $9884, $989B, $98B2

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $7F, $70, $70, $90, $90, $00, $00, $7F
L9733:  .byte $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $F6, $F6, $FC, $0A, $04, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00
L9763:  .byte $00, $00, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02
L9773:  .byte $00, $00, $00, $00, $00, $00, $00, $00

L977B:  .byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00

L978B:  .byte $00, $00, $5F, $62, $64, $64, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

L97A7:  .word $98C9, $98D8, $98E7, $98F6, $9C4A, $9C4F, $9C54, $9C59
L97B7:  .word $9C5E, $9C63, $9C68, $9C6D, $9C72, $9C77, $9C7C, $9C81
L97C7:  .word $9C86, $9C86, $9C86, $9C86, $9C86

L97D1:  .byte $01, $01, $02, $01, $03, $04, $00, $06, $00, $07, $00, $09, $00, $00, $01, $0C
L97E1:  .byte $0D, $00, $0E, $03, $0F, $10, $11, $0F

L97E9:  .byte $20, $22, $FE

L97EC:  .byte $20, $2A, $FE

L97EF:  .byte $01, $01, $FF

L97F2:  .byte $01, $09, $FF

L97F5:  .byte $04, $22, $01, $42, $01, $22, $01, $42, $01, $62, $01, $42, $04, $62, $FC, $01
L9805:  .byte $00, $64, $00, $FB

L9809:  .byte $04, $2A, $01, $4A, $01, $2A, $01, $4A, $01, $6A, $01, $4A, $04, $6A, $FC, $01
L9819:  .byte $00, $64, $00, $FB

L981D:  .byte $14, $11, $0A, $00, $14, $19, $FE

L9824:  .byte $14, $19, $0A, $00, $14, $11, $FE

L982B:  .byte $32, $11, $0A, $00, $32, $19, $FE

L9832:  .byte $32, $19, $0A, $00, $32, $11, $FE

L9839:  .byte $50, $04, $FF

L983C:  .byte $50, $0C, $FF

L983F:  .byte $02, $F3, $04, $E3, $04, $D3, $05, $B3, $03, $93, $04, $03, $05, $13, $03, $33
L984F:  .byte $05, $53, $04, $63, $50, $73, $FF

L9856:  .byte $02, $FB, $04, $EB, $04, $DB, $05, $BB, $03, $9B, $04, $0B, $05, $1B, $03, $3B
L9866:  .byte $05, $5B, $04, $6B, $50, $7B, $FF

L986D:  .byte $02, $F4, $04, $E4, $04, $D4, $05, $B4, $03, $94, $04, $04, $05, $14, $03, $34
L987D:  .byte $05, $54, $04, $64, $50, $74, $FF

L9884:  .byte $02, $FC, $04, $EC, $04, $DC, $05, $BC, $03, $9C, $04, $0C, $05, $1C, $03, $3C
L9894:  .byte $05, $5C, $04, $6C, $50, $7C, $FF

L989B:  .byte $02, $F2, $04, $E2, $04, $D2, $05, $B2, $03, $92, $04, $02, $05, $12, $03, $32
L98AB:  .byte $05, $52, $04, $62, $50, $72, $FF

L98B2:  .byte $02, $FA, $04, $EA, $04, $DA, $05, $BA, $03, $9A, $04, $0A, $05, $1A ,$03, $3A
L98C2:  .byte $05, $5A, $04, $6A, $50, $7A, $FF

L98C9:  .byte $04, $B3, $05, $A3, $06, $93, $07, $03, $06, $13, $05, $23, $50, $33, $FF

L98D8:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L98E7:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L98F6:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

L9905:  LDA $81
L9907:  CMP #$01
L9909:  BEQ $9914
L990B:  CMP #$03
L990D:  BEQ $9919
L990F:  LDA $00
L9911:  JMP CommonJump_UnknownUpdateAnim0
L9914:  LDA $01
L9916:  JMP CommonJump_UnknownUpdateAnim1
L9919:  JMP CommonJump_Unknown06
L991C:  LDA #$09
L991E:  STA $85
L9920:  STA $86
L9922:  LDA $6AF4,X
L9925:  CMP #$03
L9927:  BEQ $992C
L9929:  JSR CommonJump_Unknown1B
L992C:  LDA #$06
L992E:  STA $00
L9930:  LDA #$08
L9932:  STA $01
L9934:  JMP $9905
L9937:  LDA #$0F
L9939:  JMP $991E
L993C:  LDA $6AF4,X
L993F:  CMP #$03
L9941:  BEQ $9946
L9943:  JSR CommonJump_Unknown1E
L9946:  JMP $992C
L9949:  LDA $81
L994B:  CMP #$01
L994D:  BEQ $9993
L994F:  CMP #$03
L9951:  BEQ $9998
L9953:  LDA $0406,X
L9956:  CMP #$0F
L9958:  BCC $998E
L995A:  CMP #$11
L995C:  BCS $9965
L995E:  LDA #$3A
L9960:  STA $6B01,X
L9963:  BNE $998E
L9965:  DEC $6B01,X
L9968:  BNE $998E
L996A:  LDA #$00
L996C:  STA $6AF4,X
L996F:  LDY #$0C
L9971:  LDA #$0A
L9973:  STA $00A0,Y
L9976:  LDA $0400,X
L9979:  STA $00A1,Y
L997C:  LDA $0401,X
L997F:  STA $00A2,Y
L9982:  LDA $6AFB,X
L9985:  STA $00A3,Y
L9988:  DEY
L9989:  DEY
L998A:  DEY
L998B:  DEY
L998C:  BPL $9971
L998E:  LDA #$02
L9990:  JMP CommonJump_UnknownUpdateAnim0
L9993:  LDA #$08
L9995:  JMP CommonJump_UnknownUpdateAnim1
L9998:  JMP CommonJump_Unknown06
L999B:  JSR CommonJump_Unknown09
L999E:  AND #$03
L99A0:  BEQ $99D6
L99A2:  LDA $81
L99A4:  CMP #$01
L99A6:  BEQ $9993
L99A8:  CMP #$03
L99AA:  BEQ $9998
L99AC:  LDA $6AF4,X
L99AF:  CMP #$03
L99B1:  BEQ $99D6
L99B3:  LDA $040A,X
L99B6:  AND #$03
L99B8:  CMP #$01
L99BA:  BNE $99CD
L99BC:  LDY $0400,X
L99BF:  CPY #$E4
L99C1:  BNE $99CD
L99C3:  JSR $9A0C
L99C6:  LDA #$03
L99C8:  STA $040A,X
L99CB:  BNE $99D3
L99CD:  JSR $9A31
L99D0:  JSR $99F7
L99D3:  JSR $9A15
L99D6:  LDA #$03
L99D8:  JSR CommonJump_UpdateEnemyAnim
L99DB:  JMP CommonJump_Unknown06
L99DE:  LDA EnData05,X
L99E1:  LSR 
L99E2:  LDA $040A,X
L99E5:  AND #$03
L99E7:  ROL 
L99E8:  TAY 
L99E9:  LDA $99EF,Y
L99EC:  JMP CommonJump_ResetAnimIndex

L99EF:  .byte $35, $35, $3E, $38, $3B, $3B, $38, $3E

L99F7:  LDX $4B
L99F9:  BCS $9A14
L99FB:  LDA $00
L99FD:  BNE $9A0C
L99FF:  LDY $040A,X
L9A02:  DEY 
L9A03:  TYA 
L9A04:  AND #$03
L9A06:  STA $040A,X
L9A09:  JMP $99DE
L9A0C:  LDA EnData05,X
L9A0F:  EOR #$01
L9A11:  STA EnData05,X
L9A14:  RTS

L9A15:  JSR $9A29
L9A18:  JSR $9A31
L9A1B:  LDX $4B
L9A1D:  BCC $9A28
L9A1F:  JSR $9A29
L9A22:  STA $040A,X
L9A25:  JSR $99DE
L9A28:  RTS

L9A29:  LDY $040A,X
L9A2C:  INY 
L9A2D:  TYA 
L9A2E:  AND #$03
L9A30:  RTS

L9A31:  LDY EnData05,X
L9A34:  STY $00
L9A36:  LSR $00
L9A38:  ROL 
L9A39:  ASL 
L9A3A:  TAY 
L9A3B:  LDA $8049,Y
L9A3E:  PHA 
L9A3F:  LDA $8048,Y
L9A42:  PHA 
L9A43:  RTS

L9A44:  LDA $6AF4,X
L9A47:  CMP #$02
L9A49:  BNE $9A83
L9A4B:  LDA $0403,X
L9A4E:  BNE $9A83
L9A50:  LDA $6AFE,X
L9A53:  BNE $9A67
L9A55:  LDA $030D
L9A58:  SEC 
L9A59:  SBC $0400,X
L9A5C:  CMP #$40
L9A5E:  BCS $9A83
L9A60:  LDA #$7F
L9A62:  STA $6AFE,X
L9A65:  BNE $9A83
L9A67:  LDA $0402,X
L9A6A:  BMI $9A83
L9A6C:  LDA #$00
L9A6E:  STA $0402,X
L9A71:  STA $0406,X
L9A74:  STA $6AFE,X
L9A77:  LDA EnData05,X
L9A7A:  AND #$01
L9A7C:  TAY 
L9A7D:  LDA $9AB2,Y
L9A80:  STA $0403,X
L9A83:  LDA EnData05,X
L9A86:  ASL 
L9A87:  BMI $9AA7
L9A89:  LDA $6AF4,X
L9A8C:  CMP #$02
L9A8E:  BNE $9AA7
L9A90:  JSR CommonJump_Unknown36
L9A93:  PHA 
L9A94:  JSR CommonJump_Unknown39
L9A97:  STA $05
L9A99:  PLA 
L9A9A:  STA $04
L9A9C:  JSR $9BBC
L9A9F:  JSR CommonJump_Unknown27
L9AA2:  BCC $9AAC
L9AA4:  JSR $9BAA
L9AA7:  LDA #$03
L9AA9:  JMP CommonJump_UnknownUpdateAnim1
L9AAC:  LDA #$00
L9AAE:  STA $6AF4,X
L9AB1:  RTS

L9AB2:  PHP 
L9AB3:  SED 
L9AB4:  LDA $6AF4,X
L9AB7:  CMP #$03
L9AB9:  BCC $9AD4
L9ABB:  BEQ $9AC1
L9ABD:  CMP #$05
L9ABF:  BNE $9ADD
L9AC1:  LDA #$00
L9AC3:  STA $6B04
L9AC6:  STA $6B14
L9AC9:  STA $6B24
L9ACC:  STA $6B34
L9ACF:  STA $6B44
L9AD2:  BEQ $9ADD
L9AD4:  JSR $9B2F
L9AD7:  JSR $9BE0
L9ADA:  JSR $9C19
L9ADD:  LDA #$0A
L9ADF:  STA $00
L9AE1:  JMP $9930
L9AE4:  LDA EnData05,X
L9AE7:  AND #$02
L9AE9:  BEQ $9AF2
L9AEB:  LDA $6AF4,X
L9AEE:  CMP #$03
L9AF0:  BNE $9AF9
L9AF2:  LDA #$00
L9AF4:  STA $6AF4,X
L9AF7:  BEQ $9B24
L9AF9:  LDA EnData05,X
L9AFC:  ASL 
L9AFD:  BMI $9B24
L9AFF:  LDA $6AF4,X
L9B02:  CMP #$02
L9B04:  BNE $9B24
L9B06:  JSR CommonJump_Unknown2D
L9B09:  LDX $4B
L9B0B:  LDA $00
L9B0D:  STA $0402,X
L9B10:  JSR CommonJump_Unknown30
L9B13:  LDX $4B
L9B15:  LDA $00
L9B17:  STA $0403,X
L9B1A:  JSR CommonJump_EnemyBGCollision
L9B1D:  BCS $9B24
L9B1F:  LDA #$03
L9B21:  STA $6AF4,X
L9B24:  LDA #$01
L9B26:  JSR CommonJump_UpdateEnemyAnim
L9B29:  JMP CommonJump_Unknown06
L9B2C:  JMP $9AE4
L9B2F:  LDX #$50
L9B31:  JSR $9B3C
L9B34:  TXA 
L9B35:  SEC 
L9B36:  SBC #$10
L9B38:  TAX 
L9B39:  BNE $9B31
L9B3B:  RTS

L9B3C:  LDY $6AF4,X
L9B3F:  BEQ $9B67
L9B41:  LDA EnDataIndex,X
L9B44:  CMP #$0A
L9B46:  BEQ $9B4C
L9B48:  CMP #$09
L9B4A:  BNE $9BBB
L9B4C:  LDA EnData05,X
L9B4F:  AND #$02
L9B51:  BEQ $9B67
L9B53:  DEY 
L9B54:  BEQ $9B72
L9B56:  CPY #$02
L9B58:  BEQ $9B67
L9B5A:  CPY #$03
L9B5C:  BNE $9BBB
L9B5E:  LDA $040C,X
L9B61:  CMP #$01
L9B63:  BNE $9BBB
L9B65:  BEQ $9B72
L9B67:  LDA #$00
L9B69:  STA $6AF4,X
L9B6C:  STA $040F,X
L9B6F:  JSR CommonJump_Unknown2A
L9B72:  LDA EnData05
L9B75:  STA EnData05,X
L9B78:  LSR 
L9B79:  PHP 
L9B7A:  TXA 
L9B7B:  LSR 
L9B7C:  LSR 
L9B7D:  LSR 
L9B7E:  LSR 
L9B7F:  TAY 
L9B80:  LDA $9BCB,Y
L9B83:  STA $04
L9B85:  LDA $9BDA,Y
L9B88:  STA EnDataIndex,X
L9B8B:  TYA 
L9B8C:  PLP 
L9B8D:  ROL 
L9B8E:  TAY 
L9B8F:  LDA $9BCF,Y
L9B92:  STA $05
L9B94:  TXA 
L9B95:  PHA 
L9B96:  LDX #$00
L9B98:  JSR $9BBC
L9B9B:  PLA 
L9B9C:  TAX 
L9B9D:  JSR CommonJump_Unknown27
L9BA0:  BCC $9BBB
L9BA2:  LDA $6AF4,X
L9BA5:  BNE $9BAA
L9BA7:  INC $6AF4,X
L9BAA:  LDA $08
L9BAC:  STA $0400,X
L9BAF:  LDA $09
L9BB1:  STA $0401,X
L9BB4:  LDA $0B
L9BB6:  AND #$01
L9BB8:  STA $6AFB,X
L9BBB:  RTS

L9BBC:  LDA $0400,X
L9BBF:  STA $08
L9BC1:  LDA $0401,X
L9BC4:  STA $09
L9BC6:  LDA $6AFB,X
L9BC9:  STA $0B
L9BCB:  RTS

L9BCC:  .byte $F5, $FD, $05, $F6, $FE, $0A, $F6, $0C, $F4, $0E, $F2, $F8, $08, $F4, $0C, $09
L9BDC:  .byte $09, $09, $0A, $0A

L9BE0:  LDY $7E
L9BE2:  BNE $9BE6
L9BE4:  LDY #$80
L9BE6:  LDA $2D
L9BE8:  AND #$02
L9BEA:  BNE $9C18
L9BEC:  DEY 
L9BED:  STY $7E
L9BEF:  TYA 
L9BF0:  ASL 
L9BF1:  BMI $9C18
L9BF3:  AND #$0F
L9BF5:  CMP #$0A
L9BF7:  BNE $9C18
L9BF9:  LDA #$01
L9BFB:  LDX #$10
L9BFD:  CMP $6AF4,X
L9C00:  BEQ $9C13
L9C02:  LDX #$20
L9C04:  CMP $6AF4,X
L9C07:  BEQ $9C13
L9C09:  LDX #$30
L9C0B:  CMP $6AF4,X
L9C0E:  BEQ $9C13
L9C10:  INC $7E
L9C12:  RTS

L9C13:  LDA #$08
L9C15:  STA $0409,X
L9C18:  RTS

L9C19:  LDY $7F
L9C1B:  BNE $9C1F
L9C1D:  LDY #$60
L9C1F:  LDA $2D
L9C21:  AND #$02
L9C23:  BNE $9C48
L9C25:  DEY 
L9C26:  STY $7F
L9C28:  TYA 
L9C29:  ASL 
L9C2A:  BMI $9C48
L9C2C:  AND #$0F
L9C2E:  BNE $9C48
L9C30:  LDA #$01
L9C32:  LDX #$40
L9C34:  CMP $6AF4,X
L9C37:  BEQ $9C43
L9C39:  LDX #$50
L9C3B:  CMP $6AF4,X
L9C3E:  BEQ $9C43
L9C40:  INC $7F
L9C42:  RTS

L9C43:  LDA #$08
L9C45:  STA $0409,X
L9C48:  RTS 

L9C49:  .byte $60

L9C4A:  .byte $22, $FF, $FF, $FF, $FF

L9C4F:  .byte $22, $80, $81, $82, $83

L9C54:  .byte $22, $84, $85, $86, $87

L9C59:  .byte $22, $88, $89, $8A, $8B

L9C5E:  .byte $22, $8C, $8D, $8E, $8F

L9C63:  .byte $22, $94, $95, $96, $97

L9C68:  .byte $22, $9C, $9D, $9D, $9C

L9C6D:  .byte $22, $9E, $9F, $9F, $9E

L9C72:  .byte $22, $90, $91, $92, $93

L9C77:  .byte $22, $70, $71, $72, $73

L9C7C:  .byte $22, $74, $75, $76, $77

L9C81:  .byte $22, $78, $79, $7A, $7B

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9C86:  .byte $00, $01, $FF

L9C89:  .byte $02, $FF

L9C8B:  .byte $19, $1A, $FF

L9C8E:  .byte $1A, $1B, $FF

L9C91:  .byte $1C, $1D, $FF

L9C94:  .byte $1D, $1E, $FF

L9C97:  .byte $22, $23, $24, $FF

L9C9B:  .byte $1F, $20, $21, $FF

L9C9F:  .byte $22, $FF

L9CA1:  .byte $1F, $FF

L9CA3:  .byte $23, $04, $FF

L9CA6:  .byte $20, $03, $FF

L9CA9:  .byte $27, $28, $29, $FF

L9CAD:  .byte $37, $FF

L9CAF:  .byte $38, $FF

L9CB1:  .byte $39, $FF

L9CB3:  .byte $3A, $FF

L9CB5:  .byte $3B, $FF

L9CB7:  .byte $3C, $FF

L9CB9:  .byte $3D, $FF

L9CBB:  .byte $58, $59, $FF

L9CBE:  .byte $5A, $5B, $FF

L9CC1:  .byte $5C, $5D, $FF

L9CC4:  .byte $5E, $5F, $FF

L9CC7:  .byte $60, $FF

L9CC9:  .byte $61, $F7, $62, $F7, $FF

L9CCE:  .byte $66, $67, $FF

L9CD1:  .byte $69, $6A, $FF

L9CD4:  .byte $68, $FF

L9CD6:  .byte $6B, $FF

L9CD8:  .byte $66, $FF

L9CDA:  .byte $69, $FF

L9CDC:  .byte $6C, $FF

L9CDE:  .byte $6D, $FF

L9CE0:  .byte $6F, $70, $71, $6E, $FF

L9CE5:  .byte $73, $74, $75, $72, $FF

L9CEA:  .byte $8F, $90, $FF

L9CED:  .byte $91, $92, $FF

L9CF0:  .byte $93, $94, $FF

L9CF3:  .byte $95, $FF

L9CF5:  .byte $96, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9CF7:  .word $9ED9, $9EDE, $9EE3, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8
L9D07:  .word $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8
L9D17:  .word $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8 
L9D27:  .word $9EE8, $9EE8, $9EF6, $9F04, $9F10, $9F1E, $9F2C, $9F38 
L9D37:  .word $9F41, $9F4B, $9F55, $9F5E, $9F68, $9F72, $9F72, $9F72
L9D47:  .word $9F80, $9F87, $9F90, $9F90, $9F90, $9F90, $9F90, $9F90
L9D57:  .word $9F90, $9F90, $9F90, $9F90, $9F90, $9F90, $9F90, $9F90
L9D67:  .word $9FA4, $9FB8, $9FC3, $9FCE, $9FD7, $9FE0, $9FEB, $9FEB
L9D77:  .word $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB
L9D87:  .word $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB
L9D97:  .word $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB
L9DA7:  .word $9FEB, $9FF3, $9FFB, $A003, $A00B, $A013, $A01B, $A023
L9DB7:  .word $A02B, $A033, $A041, $A05B, $A05B, $A05B, $A05B, $A063
L9BC7:  .word $A06B, $A073, $A07B, $A083, $A08B, $A093, $A09B, $A0A3
L9BD7:  .word $A0AB, $A0B3, $A0BB, $A0C3, $A0CB, $A0D3, $A0DB, $A0DB
L9BE7:  .word $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB

EnemyFramePtrTbl2:
L9DF7:  .word $A0DB, $A0E3, $A0E8, $A0E8, $A0E8, $A0E8, $A0E8, $A0E8
L9E07:  .word $A0E8, $A0E8, $A0ED, $A0ED, $A0ED, $A0ED, $A0ED, $A0ED
L9E17:  .word $A0F7, $A101, $A111, $A121, $A131, $A141, $A14B

EnemyPlacePtrTbl:
L9E25:  .word $9E45, $9E47, $9E5F, $9E77, $9E77, $9E77, $9E87, $9E93
L9E35:  .word $9E9B, $9EA7, $9EA7, $9EC7, $9ED5, $9ED5, $9ED5, $9ED5

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9E45:  .byte $FC, $FC

L9E47:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9E57:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9E5F:  .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
L9E6F:  .byte $00, $04, $08, $F4, $08, $FC, $08, $04

L9E77:  .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9E87:  .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

L9E93:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

L9E9B:  .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

L9EA7:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9EB7:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9EC7:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9ED5:  .byte $FC, $F8, $FC, $00

;Enemy frame drawing data.

L9ED9:  .byte $00, $02, $02, $14, $FF

L9EDE:  .byte $00, $02, $02, $24, $FF

L9EE3:  .byte $00, $00, $00, $04, $FF

L9EE8:  .byte $25, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $62, $E2, $F2, $FF

L9EF6:  .byte $25, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $62, $E4, $F2, $FF

L9F04:  .byte $26, $08, $0A, $F4, $F2, $E3, $F3, $FD, $62, $F4, $F2, $FF

L9F10:  .byte $A5, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $E2, $E2, $F2, $FF

L9F1E:  .byte $A5, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $E2, $E4, $F2, $FF

L9F2C:  .byte $A6, $08, $0A, $F4, $F2, $E3, $F3, $FD, $E2, $F4, $F2, $FF

L9F38:  .byte $27, $06, $08, $FC, $04, $00, $C0, $C1, $FF

L9F41:  .byte $27, $06, $08, $E0, $E1, $FD, $A2, $E0, $E1, $FF

L9F4B:  .byte $27, $06, $08, $F0, $F1, $FD, $A2, $F0, $F1, $FF

L9F55:  .byte $67, $06, $08, $FC, $04, $00, $C0, $C1, $FF

L9F5E:  .byte $67, $06, $08, $E0, $E1, $FD, $E2, $E0, $E1, $FF

L9F68:  .byte $67, $06, $08, $F0, $F1, $FD, $E2, $F0, $F1, $FF

L9F72:  .byte $28, $0C, $08, $CE, $FC, $00, $FC, $DE, $EE, $DF, $FD, $62, $EE, $FF

L9F80:  .byte $28, $0C, $08, $CE, $CF, $EF, $FF

L9F87:  .byte $28, $0C, $08, $CE, $FD, $62, $CF, $EF, $FF

L9F90:  .byte $21, $00, $00, $FC, $08, $FC, $E2, $FC, $00, $08, $E2, $FC, $00, $F8, $F2, $FC
L9FA0:  .byte $00, $08, $F2, $FF

L9FA4:  .byte $21, $00, $00, $FC, $00, $FC, $F2, $FC, $00, $08, $F2, $FC, $00, $F8, $E2, $FC
L9FB4:  .byte $00, $08, $E2, $FF

L9FB8:  .byte $21, $00, $00, $FC, $04, $00, $F1, $F0, $F1, $F0, $FF

L9FC3:  .byte $21, $00, $00, $FC, $04, $00, $F0, $F1, $F0, $F1, $FF

L9FCE:  .byte $21, $00, $00, $FC, $08, $00, $D1, $D0, $FF

L9FD7:  .byte $21, $00, $00, $FC, $08, $00, $D0, $D1, $FF

L9FE0:  .byte $21, $00, $00, $FC, $08, $00, $DE, $DF, $EE, $EE, $FF

L9FEB:  .byte $27, $08, $08, $CC, $CD, $DC, $DD, $FF

L9FF3:  .byte $67, $08, $08, $CC, $CD, $DC, $DD, $FF

L9FFB:  .byte $27, $08, $08, $CA, $CB, $DA, $DB, $FF

LA003:  .byte $A7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA00B:  .byte $A7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA013:  .byte $E7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA01B:  .byte $67, $08, $08, $CA, $CB, $DA, $DB, $FF

LA023:  .byte $E7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA02B:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA033:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA041:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA051:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA05B:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA063:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA06B:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA073:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA07B:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA083:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA08B:  .byte $20, $02, $04, $FC, $FF

LA090:  .byte $00, $F8, $FF

LA093:  .byte $60, $02, $04, $FC, $FF

LA098:  .byte $00, $F8, $FF

LA09B:  .byte $20, $02, $02, $FC, $FE, $00, $D9, $FF

LA0A3:  .byte $E0, $02, $02, $FC, $00, $02, $D8, $FF

LA0AB:  .byte $E0, $02, $02, $FC, $02, $00, $D9, $FF

LA0B3:  .byte $20, $02, $02, $FC, $00, $FE, $D8, $FF

LA0BB:  .byte $60, $02, $02, $FC, $FE, $00, $D9, $FF

LA0C3:  .byte $A0, $02, $02, $FC, $00, $FE, $D8, $FF

LA0CB:  .byte $A0, $02, $02, $FC, $02, $00, $D9, $FF

LA0D3:  .byte $60, $02, $02, $FC, $00, $02, $D8, $FF

LA0DB:  .byte $06, $08, $04, $FE, $FE, $14, $24, $FF

LA0E3:  .byte $00, $04, $04, $8A, $FF

LA0E8:  .byte $00, $04, $04, $8A, $FF

LA0ED:  .byte $3F, $04, $08, $FD, $03, $EC, $FD, $43, $EC, $FF

LA0F7:  .byte $3F, $04, $08, $FD, $03, $ED, $FD, $43, $ED, $FF

LA101:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA111:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA121:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA131:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA141:  .byte $21, $00, $00, $C5, $C7, $D5, $D7, $E5, $E7, $FF

LA14B:  .byte $21, $00, $00, $C7, $C5, $D7, $D5, $E7, $E5, $FF

;----------------------------------------[ Palette data ]--------------------------------------------

Palette00:
LA155:  .byte $3F                       ;Upper byte of PPU palette adress.
LA156:  .byte $00                       ;Lower byte of PPU palette adress.
LA157:  .byte $20                       ;Palette data length.
;The following values are written to the background palette:
LA158:  .byte $0F, $20, $10, $00, $0F, $28, $19, $1A, $0F, $28, $16, $04, $0F, $23, $11, $02
;The following values are written to the sprite palette:
LA168:  .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $1B, $36, $0F, $17, $22, $31

LA178:  .byte $00                       ;End Palette00 info.

Palette01:
LA179:  .byte $3F                       ;Upper byte of PPU palette adress.
LA17A:  .byte $12                       ;Lower byte of PPU palette adress.
LA17B:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA17C:  .byte $19, $27

LA17E:  .byte $00                       ;End Palette01 info.

Palette03:
LA17F:  .byte $3F                       ;Upper byte of PPU palette adress.
LA180:  .byte $12                       ;Lower byte of PPU palette adress.
LA181:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA182:  .byte $2C, $27

LA184:  .byte $00                       ;End Palette03 info.

Palette02:
LA185:  .byte $3F                       ;Upper byte of PPU palette adress.
LA186:  .byte $12                       ;Lower byte of PPU palette adress.
LA187:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA188:  .byte $19, $35

LA18A:  .byte $00                       ;End Palette02 info.

Palette04:
LA18B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA18C:  .byte $12                       ;Lower byte of PPU palette adress.
LA18D:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA18E:  .byte $2C, $24

LA190:  .byte $00                       ;End Palette04 info.

Palette05:
LA191:  .byte $3F                       ;Upper byte of PPU palette adress.
LA192:  .byte $11                       ;Lower byte of PPU palette adress.
LA193:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA194:  .byte $04, $09, $07

LA196:  .byte $00                       ;End Palette05 info.

Palette06:
La198:  .byte $3F                       ;Upper byte of PPU palette adress.
LA199:  .byte $11                       ;Lower byte of PPU palette adress.
LA19A:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA19B:  .byte $05, $09, $17

LA19E:  .byte $00                       ;End Palette06 info.

Palette07:
LA19F:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1A0:  .byte $11                       ;Lower byte of PPU palette adress.
LA1A1:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1A2:  .byte $06, $0A, $26

LA1A5:  .byte $00                       ;End Palette07 info.

Palette08:
LA1A6:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1A7:  .byte $11                       ;Lower byte of PPU palette adress.
LA1A8:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1A9:  .byte $16, $19, $27

LA1AC:  .byte $00                       ;End Palette08 info.

Palette09:
LA1AD:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1AE:  .byte $00                       ;Lower byte of PPU palette adress.
LA1AF:  .byte $04                       ;Palette data length.
;The following values are written to the background palette:
LA1B0:  .byte $0F, $30, $30, $21

LA1B4:  .byte $00                       ;End Palette09 info.

Palette0A:
LA1B5:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1B6:  .byte $10                       ;Lower byte of PPU palette adress.
LA1B7:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA1B8:  .byte $0F, $15, $34, $17

LA1BC:  .byte $00                       ;End Palette0A info.

Palette0B:
LA1BD:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1BE:  .byte $10                       ;Lower byte of PPU palette adress.
LA1BF:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA1C0:  .byte $0F, $15, $34, $19

LA1C4:  .byte $00                       ;End Palette0B info.

Palette0C:
LA1C5:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1C6:  .byte $10                       ;Lower byte of PPU palette adress.
LA1C7:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA1C8:  .byte $0F, $15, $34, $28

LA1CC:  .byte $00                       ;End Palette0C info.

Palette0D:
LA1CD:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1CE:  .byte $10                       ;Lower byte of PPU palette adress.
LA1CF:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA1D0:  .byte $0F, $15, $34, $29

LA1D4:  .byte $00                       ;End Palette0D info.


;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
LA1D5:  .word $A2B7, $A2C5, $A2CD, $A308, $A345, $A388, $A3B8, $A401
LA1E5:  .word $A442, $A47E, $A4AD, $A4E2, $A514, $A558, $A590, $A5BF
LA1F5:  .word $A5E8, $A647, $A647, $A683, $A6B5, $A6D9, $A713, $A745
LA205:  .word $A780, $A7B2, $A7F6, $A83F, $A8A3, $A8C7, $A923, $A94F
LA215:  .word $A972, $A990, $A9BE, $A9FE, $AA33

StrctPtrTbl:
LA21F:  .word $AA6B, $AA7E, $AA97, $AAB0, $AAB7, $AABE, $AAC2, $AAD2
LA22F:  .word $AAE2, $AAE7, $AAEC, $AAEF, $AAF2, $AAFD, $AB03, $AB08
LA23F:  .word $AB11, $AB26, $AB29, $AB3C, $AB51, $AB55, $AB68, $AB75
LA24F:  .word $AB88, $AB9B, $ABB0, $ABBA, $ABBD, $ABC4, $ABE0, $ABE9
LA25F:  .word $ABFE, $AC01, $AC0A, $AC0F, $AC14, $AC1E, $AC27

;-----------------------------------[ Special items table ]-----------------------------------------

;The way the bytes work int the special items table is as follows:
;Long entry(one with a data word in it):
;Byte 0=Y coordinate of room on the world map.
;Word 0=Address of next entry in the table that has a different Y coordinate.--> 
;       $FFFF=No more items with different Y coordinates.
;Byte 1=X coordinate of room in the world map.
;Byte 2=byte offset-1 of next special item in the table that has the same-->
;       Y coordinate(short entry). $FF=No more items with different X-->
;       coordinates until next long entry.
;Byte 3=Item type. See list below for special item types.
;Bytes 4 to end of entry(ends with #$00)=Data bytes for special item(s).-->
;       It is possible to have multiple special items in one room.
;Short entry(one without a data word in it):
;Byte 0=X coordinate of room in the world map(Y coordinate is the same-->
;       as the last long item entry in the table).
;Byte 1=byte offset-1 of next special item in the table that has the same-->
;       Y coordinate(short entry). $FF=No more items with different X-->
;       coordinates until next long entry.
;Byte 2=Item type. See list below for special item types.
;Bytes 3 to end of entry(ends with #$00)=Data bytes for special item(s).-->
;       It is possible to have multiple special items in one room.
;
;Special item types:
;#$01=Squeept.
;#$02=Power up.
;#$03=Mellows, Memus or Melias.
;#$04=Elevator.
;#$05=Mother brain room cannon.
;#$06=Mother brain.
;#$07=Zeebetite.
;#$08=Rinka.
;#$09=Door.
;#$0A=Palette change room.

SpecItmsTbl:

;Elevator from Brinstar.
LA26D:  .byte $12
LA26E:  .word $A275
LA270:  .byte $07, $FF, $04, $81, $00

;Elevator to Brinstar.
LA275:  .byte $14
LA276:  .word $A27D
LA278:  .byte $07, $FF, $04, $82, $00

;Missiles.
LA27D:  .byte $15
LA27E:  .word $A28C
LA27F:  .byte $04, $06, $02, $09, $47, $00

;Missiles.
LA286:  .byte $09, $FF, $02, $09, $47, $00

;Energy tank.
LA28C:  .byte $16
LA28D:  .word $A295
LA28F:  .byte $0A, $FF, $02, $08, $66, $00

;Missiles.
LA295:  .byte $19
LA296:  .word $A29E
LA298:  .byte $0A, $FF, $02, $09, $47, $00

;Missiles.
LA29E:  .byte $1B
LA29F:  .word $A2A7
LA2A1:  .byte $05, $FF, $02, $09, $47, $00

;Memus.
LA2A7:  .byte $1C
LA2A8:  .word $A2AE
LA2A9:  .byte $07, $FF, $03, $00

;Energy tank.
LA2AE:  .byte $1D
LA2AF:  .word $FFFF
LA2B1:  .byte $08, $FF, $02, $08, $BE, $00

;-----------------------------------------[ Room definitions ]---------------------------------------

;The first byte of the room definitions is attribute table data and is used to set the base color of
;the room. The object data is grouped into 3 byte segments and represents a structure in the room.
;The first byte of the structure data has the format yyyyxxxx and contains the y, x location of the
;structure in the room(measured in tiles). The second byte is an index into the StrctPtrTbl and
;identifies which structure to use.  The third byte is an attribute table byte and determines the
;color of the structure.  Most of the time, this byte will have the same value as the attribute byte
;for the base color of the room. Having a room base color byte reduces the calculations required to
;find the proper color for each structure as the structure attribute byte is skipped if it is the same
;as the room attribute byte. #$FD marks the end of the room objects portion of the room definition.
;Using the byte #$FE can be used as an empty place holder in the room data.  For example, if you
;wanted to remove a structure from a room, simply replace the three bytes associated with the structure
;with #$FE. The next portion of the room definition describes the enemies and doors in the room. The
;number of data bytes and their functions vary depending on what type of item is being loaded.

;Room #$00
LA2B7:  .byte $02                       ;Attribute table data.
;Room object data:
LA2B8:  .byte $40, $01, $03, $48, $01, $03, $50, $04, $02, $5F, $04, $02, $FF

;Room #$01
LA2C5:  .byte $02                       ;Attribute table data.
;Room object data:
LA2C6:  .byte $07, $02, $02, $87, $02, $02, $FF

;Room #$02
LA2CD:  .byte $00                       ;Attribute table data.
;Room object data:
LA2CE:  .byte $00, $10, $00, $04, $10, $00, $08, $10, $00, $0C, $10, $00, $40, $06, $00, $42
LA2DE:  .byte $08, $01, $4E, $06, $00, $6D, $09, $01, $75, $0C, $00, $7A, $0C, $00, $90, $06
LA2EE:  .byte $00, $92, $0C, $00, $96, $0D, $00, $9D, $0C, $00, $9E, $06, $00, $E0, $06, $00
LA2FE:  .byte $E1, $0D, $00, $EB, $0D, $00, $EE, $06, $00, $FF

;Room #$03
LA308:  .byte $00                       ;Attribute table data.
;Room object data:
LA309:  .byte $00, $06, $00, $0A, $0D, $00, $0E, $06, $00, $22, $08, $01, $2D, $09, $01, $45
LA319:  .byte $0D, $00, $50, $03, $02, $5F, $03, $02, $80, $10, $00, $8A, $06, $00, $8C, $10
LA329:  .byte $00, $A4, $08, $01, $C0, $10, $00, $C9, $0D, $00, $CC, $10, $00, $DB, $09, $01
LA339:  .byte $E1, $10, $00, $FD
;Room enemy/door data:
LA33D:  .byte $02, $A0, $02, $B1, $31, $85, $37, $FF

;Room #$04
LA345:  .byte $00                       ;Attribute table data.
;Room object data:
LA346:  .byte $00, $06, $00, $07, $06, $00, $0B, $10, $00, $0E, $06, $00, $22, $08, $01, $2A
LA356:  .byte $09, $01, $35, $0D, $00, $50, $03, $02, $57, $06, $00, $5F, $03, $02, $80, $0D
LA366:  .byte $00, $8C, $0D, $00, $8E, $06, $00, $90, $06, $00, $92, $08, $01, $BE, $06, $00
LA376:  .byte $CD, $09, $01, $D0, $06, $00, $FD
;Room enemy/door data:
LA37D:  .byte $02, $A0, $02, $B1, $41, $85, $25, $21, $83, $C8, $FF

;Room #$05
LA388:  .byte $00                       ;Attribute table data.
;Room object data:
LA389:  .byte $00, $10, $00, $0C, $10, $00, $14, $08, $01, $40, $10, $00, $4C, $10, $00, $6B
LA399:  .byte $09, $01, $7C, $10, $00, $80, $10, $00, $94, $08, $01, $BC, $10, $00, $C0, $10
LA3A9:  .byte $00, $DB, $09, $01, $FD
;Room enemy/door data:
LA3AE:  .byte $51, $83, $57, $01, $03, $95, $11, $03, $CA, $FF

;Room #$06
LA3B8:  .byte $00                       ;Attribute table data.
;Room object data:
LA3B9:  .byte $00, $06, $00, $0E, $06, $00, $12, $08, $01, $17, $0E, $00, $1A, $0D, $00, $27
LA3C9:  .byte $0C, $00, $31, $0E, $00, $36, $11, $00, $39, $07, $00, $50, $03, $02, $59, $0E
LA3D9:  .byte $00, $5F, $03, $02, $80, $10, $00, $84, $10, $00, $88, $10, $00, $8C, $10, $00
LA3E9:  .byte $C0, $10, $00, $C4, $10, $00, $C8, $10, $00, $CC, $10, $00, $FD
;Room enemy/door data:
LA3F6:  .byte $02, $A1, $02, $B1, $01, $85, $2A, $51, $85, $26, $FF

;Room #$07
LA401:  .byte $00                       ;Attribute table data.
;Room object data:
LA402:  .byte $00, $10, $00, $0A, $10, $00, $0E, $07, $00, $24, $08, $01, $27, $0E, $00, $40
LA412:  .byte $07, $00, $5F, $03, $02, $62, $10, $00, $8B, $0E, $00, $8E, $07, $00, $90, $07
LA422:  .byte $00, $9D, $09, $01, $B0, $07, $00, $B2, $10, $00, $B6, $0D, $00, $CE, $07, $00
LA432:  .byte $D6, $08, $01, $FD
;Room enemy/door data:
LA436:  .byte $02, $A1, $01, $85, $17, $21, $85, $A8, $31, $03, $87, $FF

;Room #$08
LA442:  .byte $00                       ;Attribute table data.
;Room object data:
LA443:  .byte $00, $10, $00, $03, $10, $00, $0A, $10, $00, $0C, $10, $00, $29, $09, $01, $35
LA453:  .byte $0E, $00, $40, $10, $00, $44, $08, $01, $4C, $10, $00, $79, $0E, $00, $80, $10
LA463:  .byte $00, $8C, $10, $00, $AB, $09, $01, $B0, $10, $00, $B4, $0D, $00, $CC, $10, $00
LA473:  .byte $D4, $08, $01, $FD
;Room enemy/door data:
LA477:  .byte $11, $85, $6A, $41, $85, $A6, $FF

;Room #$09
LA47E:  .byte $00                       ;Attribute table data.
;Room object data:
LA47F:  .byte $00, $07, $00, $0D, $09, $01, $0E, $07, $00, $42, $08, $01, $50, $07, $00, $5F
LA48F:  .byte $03, $02, $8B, $0E, $00, $8E, $07, $00, $9D, $09, $01, $A0, $07, $00, $A6, $0E
LA49F:  .byte $00, $DE, $07, $00, $FD
;Room enemy/door data:
LA4A4:  .byte $02, $A1, $21, $85, $97, $31, $03, $83, $FF

;Room #$0A
LA4AD:  .byte $00                       ;Attribute table data.
;Room object data:
LA4AE:  .byte $00, $07, $00, $0E, $07, $00, $12, $08, $01, $50, $07, $00, $5F, $03, $02, $72
LA4BE:  .byte $08, $01, $87, $0E, $00, $8B, $0E, $00, $8E, $07, $00, $A0, $10, $00, $AD, $09
LA4CE:  .byte $01, $CC, $10, $00, $D4, $00, $02, $E0, $10, $00, $FD
;Room enemy/door data:
LA4D9:  .byte $02, $A1, $01, $85, $78, $11, $03, $28, $FF

;Room #$0B
LA4E2:  .byte $00                       ;Attribute table data.
;Room object data:
LA4E3:  .byte $00, $10, $00, $04, $10, $00, $08, $10, $00, $0C, $10, $00, $40, $10, $00, $44
LA4F3:  .byte $10, $00, $48, $10, $00, $4C, $10, $00, $80, $10, $00, $84, $10, $00, $88, $10
LA503:  .byte $00, $8C, $10, $00, $B0, $10, $00, $B4, $10, $00, $B8, $10, $00, $BC, $10, $00
LA513:  .byte $FF

;Room #$0C
LA514:  .byte $00                       ;Attribute table data.
;Room object data:
LA515:  .byte $00, $07, $00, $0A, $11, $00, $0E, $07, $00, $25, $11, $00, $32, $08, $01, $49
LA525:  .byte $11, $00, $50, $03, $02, $5D, $09, $01, $5E, $07, $00, $80, $07, $00, $82, $11
LA535:  .byte $00, $86, $11, $00, $9C, $11, $00, $AE, $07, $00, $BD, $09, $01, $C2, $08, $01
LA545:  .byte $C8, $11, $00, $D0, $07, $00, $D4, $11, $00, $FD
;Room enemy/door data:
LA54F:  .byte $02, $B1, $51, $85, $39, $41, $05, $C4, $FF

;Room #$0D
LA558:  .byte $00                       ;Attribute table data.
;Room object data:
LA559:  .byte $00, $07, $00, $0A, $0F, $02, $0E, $07, $00, $1D, $09, $01, $4A, $0F, $02, $50
LA569:  .byte $03, $02, $5E, $07, $00, $80, $07, $00, $86, $0F, $02, $8A, $0F, $02, $8C, $11
LA579:  .byte $00, $9D, $09, $01, $A2, $11, $00, $AE, $07, $00, $C2, $08, $01, $CA, $0F, $02
LA589:  .byte $D0, $07, $00, $FD
;Room enemy/door data:
LA58D:  .byte $02, $B1, $FF

;Room #$0E
LA590:  .byte $00                       ;Attribute table data.
;Room object data:
LA591:  .byte $00, $07, $00, $0A, $0F, $02, $0E, $07, $00, $2D, $09, $01, $32, $08, $01, $4A
LA5A1:  .byte $0F, $02, $50, $07, $00, $5E, $07, $00, $78, $11, $00, $8A, $0F, $02, $92, $08
LA5B1:  .byte $01, $A0, $07, $00, $AE, $07, $00, $BD, $09, $01, $CA, $0F, $02, $FF

;Room #$0F
LA5BF:  .byte $01                       ;Attribute table data.
;Room object data:
LA5C0:  .byte $00, $1D, $01, $08, $1D, $01, $1E, $1F, $01, $5F, $03, $02, $8C, $1F, $01, $9B
LA5D0:  .byte $09, $01, $C9, $1D, $01, $D0, $1F, $01, $D4, $00, $02, $FD
;Room enemy/door data:
LA5DC:  .byte $02, $A1, $41, $84, $31, $57, $87, $D5, $07, $87, $D8, $FF

;Room #$10
LA5E8:  .byte $00                       ;Attribute table data.
;Room object data:
LA5E9:  .byte $00, $12, $00, $08, $12, $00, $57, $0C, $00, $75, $0C, $00, $79, $0C, $00, $93
LA5F9:  .byte $0C, $00, $9B, $0C, $00, $B1, $0C, $00, $BD, $0C, $00, $CF, $0C, $00, $D0, $00
LA609:  .byte $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA60E:  .byte $41, $81, $2D, $27, $07, $D4, $17, $87, $DA, $FF

;Room #$11 (not used).
LA618:  .byte $00                       ;Attribute table data.
;Room object data:
LA619:  .byte $00, $07, $00, $02, $08, $01, $0E, $07, $00, $2D, $09, $01, $32, $0E, $00, $50
LA629:  .byte $03, $02, $5F, $03, $02, $80, $10, $00, $84, $10, $00, $88, $10, $00, $8C, $10
LA639:  .byte $00, $C0, $10, $00, $C4, $10, $00, $C8, $10, $00, $CC, $10, $00, $FF

;Room #$12
LA647:  .byte $00                       ;Attribute table data.
;Room object data:
LA648:  .byte $00, $12, $00, $08, $12, $00, $24, $11, $00, $37, $0C, $00, $45, $0C, $00, $48
LA658:  .byte $0E, $00, $57, $0C, $00, $63, $0C, $00, $65, $0C, $00, $9B, $0E, $00, $A2, $11
LA668:  .byte $00, $C0, $13, $03, $C5, $0E, $00, $C9, $0C, $00, $CC, $13, $03, $D4, $00, $02
LA678:  .byte $FD
;Room enemy/door data:
LA679:  .byte $21, $85, $39, $31, $85, $8C, $41, $85, $B6, $FF

;Room #$13
LA683:  .byte $03                       ;Attribute table data.
;Room object data:
LA684:  .byte $00, $15, $03, $08, $15, $03, $10, $16, $03, $50, $03, $02, $68, $14, $03, $80
LA694:  .byte $16, $03, $93, $14, $03, $AB, $14, $03, $BF, $14, $03, $C0, $16, $03, $D2, $00
LA6A4:  .byte $02, $DA, $00, $02, $FD
;Room enemy/door data:
LA6A9:  .byte $02, $B0, $21, $81, $27, $41, $85, $84, $37, $87, $DD, $FF

;Room #$14
LA6B5:  .byte $03                       ;Attribute table data.
;Room object data:
LA6B6:  .byte $00, $15, $03, $08, $15, $03, $8A, $14, $03, $A4, $14, $03, $AF, $14, $03, $D0
LA6C6:  .byte $00, $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA6CC:  .byte $37, $87, $D1, $47, $87, $D7, $57, $87, $DC, $01, $85, $95, $FF

;Room #$15
LA6D9:  .byte $01                       ;Attribute table data.
;Room object data:
LA6DA:  .byte $00, $1D, $01, $08, $1D, $01, $20, $1D, $01, $28, $1D, $01, $50, $03, $02, $5F
LA6EA:  .byte $03, $02, $80, $1D, $01, $87, $20, $01, $88, $1D, $01, $97, $21, $01, $B0, $1D
LA6FA:  .byte $01, $B7, $21, $01, $B8, $1D, $01, $C0, $1D, $01, $C7, $21, $01, $C8, $1D, $01
LA70A:  .byte $FD
;Room enemy/door data:
LA70B:  .byte $02, $A1, $02, $B1, $01, $80, $68, $FF

;Room #$16
LA713:  .byte $03                       ;Attribute table data.
;Room object data:
LA714:  .byte $00, $15, $03, $08, $15, $03, $1E, $16, $03, $5F, $03, $02, $61, $14, $03, $85
LA724:  .byte $14, $03, $8C, $15, $03, $8E, $16, $03, $BA, $14, $03, $CE, $16, $03, $D0, $00
LA734:  .byte $02, $D6, $00, $02, $FD
;Room enemy/door data:
LA739:  .byte $02, $A1, $07, $87, $D3, $17, $07, $D8, $21, $81, $27, $FF

;Room #$17
LA745:  .byte $01                       ;Attribute table data.
;Room object data:
LA746:  .byte $00, $17, $03, $08, $17, $03, $10, $19, $03, $24, $18, $03, $36, $0C, $00, $3B
LA756:  .byte $0C, $00, $50, $03, $02, $80, $19, $03, $AE, $0C, $00, $C0, $19, $03, $D4, $18
LA766:  .byte $03, $D8, $00, $02, $D9, $18, $03, $DB, $05, $02, $DF, $00, $02, $FD, $02, $B1
LA776:  .byte $41, $80, $C5, $57, $87, $DC, $31, $04, $48, $FF

;Room #$18
LA780:  .byte $01                       ;Attribute table data.
;Room object data:
LA781:  .byte $00, $17, $03, $08, $17, $03, $1C, $19, $03, $20, $19, $03, $5F, $03, $02, $8C
LA791:  .byte $19, $03, $CC, $19, $03, $D0, $18, $03, $D3, $00, $02, $D4, $18, $03, $D5, $05
LA7A1:  .byte $02, $FD
;Room enemy/door data:
LA7A3:  .byte $02, $A1, $37, $87, $D6, $21, $84, $62, $11, $84, $25, $01, $84, $29, $FF

;Room #$19
LA7B2:  .byte $03                       ;Attribute table data.
;Room object data:
LA7B3:  .byte $00, $19, $03, $04, $19, $03, $08, $19, $03, $0C, $19, $03, $40, $19, $03, $44
LA7C3:  .byte $19, $03, $48, $19, $03, $4C, $19, $03, $70, $19, $03, $74, $19, $03, $78, $19
LA7D3:  .byte $03, $7C, $19, $03, $90, $1A, $03, $94, $1A, $03, $98, $1A, $03, $9C, $1A, $03
LA7E3:  .byte $B0, $1A, $03, $B8, $1A, $03, $C0, $19, $03, $C4, $19, $03, $C8, $19, $03, $CC
LA7F3:  .byte $19, $03, $FF

;Room #$1A
LA7F6:  .byte $03                       ;Attribute table data.
;Room object data:
LA7F7:  .byte $00, $13, $03, $04, $13, $03, $08, $13, $03, $0C, $13, $03, $10, $13, $03, $14
LA807:  .byte $13, $03, $18, $13, $03, $1C, $13, $03, $50, $03, $02, $5F, $03, $02, $80, $13
LA817:  .byte $03, $81, $1B, $03, $84, $13, $03, $88, $13, $03, $8C, $13, $03, $91, $1C, $03
LA827:  .byte $C0, $13, $03, $C1, $1C, $03, $C4, $13, $03, $C8, $13, $03, $CC, $13, $03, $FD
;Room enemy/door data:
LA837:  .byte $02, $A0, $02, $B1, $31, $81, $68, $FF

;Room #$1B
LA83F:  .byte $00                       ;Attribute table data.
;Room object data:
LA840:  .byte $00, $1F, $01, $04, $1D, $01, $07, $21, $01, $0C, $1F, $01, $10, $0C, $00, $14
LA850:  .byte $1F, $01, $17, $21, $01, $18, $1F, $01, $1F, $0C, $00, $25, $0B, $02, $2A, $0B
LA860:  .byte $02, $41, $22, $00, $4C, $23, $00, $50, $03, $02, $54, $22, $00, $59, $23, $00
LA870:  .byte $5F, $03, $02, $80, $07, $00, $82, $14, $03, $84, $14, $03, $86, $14, $03, $88
LA880:  .byte $14, $03, $8A, $14, $03, $8C, $14, $03, $8E, $07, $00, $92, $16, $03, $9C, $16
LA890:  .byte $03, $D0, $12, $00, $D4, $00, $02, $DC, $12, $00, $FD
;Room enemy/door data:
LA89B:  .byte $02, $A1, $02, $B0, $27, $07, $D9, $FF

;Room #$1C
LA8A3:  .byte $03                       ;Attribute table data.
;Room object data:
LA8A4:  .byte $00, $17, $03, $08, $17, $03, $B0, $18, $03, $B6, $05, $02, $B8, $18, $03, $D0
LA8B4:  .byte $18, $03, $D8, $18, $03, $FD
;Room enemy/door data:
LA8BA:  .byte $37, $87, $B7, $01, $80, $45, $11, $00, $3B, $21, $81, $9A, $FF

;Room #$1D
LA8C7:  .byte $01                       ;Attribute table data.
;Room object data:
LA8C8:  .byte $00, $15, $03, $08, $15, $03, $10, $24, $03, $13, $0B, $02, $18, $24, $03, $1C
LA8D8:  .byte $0B, $02, $1F, $25, $03, $20, $25, $03, $22, $22, $00, $2B, $23, $00, $5F, $03
LA8E8:  .byte $02, $60, $25, $03, $8E, $25, $03, $8F, $13, $03, $A0, $25, $03, $A2, $11, $00
LA8F8:  .byte $AC, $11, $00, $B3, $12, $00, $BB, $0C, $00, $BE, $1B, $03, $C3, $24, $03, $CE
LA908:  .byte $12, $00, $D1, $00, $02, $D3, $24, $03, $DC, $00, $02, $DE, $12, $00, $E0, $25
LA918:  .byte $03, $E3, $15, $03, $FD
;Room enemy/door data:
LA91D:  .byte $02, $A0, $01, $48, $95, $FF

;Room #$1E
LA923:  .byte $01                       ;Attribute table data.
;Room object data:
LA924:  .byte $00, $1E, $01, $02, $1D, $01, $08, $1D, $01, $1F, $1F, $01, $40, $1E, $01, $5F
LA934:  .byte $03, $02, $77, $0C, $00, $80, $1E, $01, $87, $1E, $01, $8D, $1F, $01, $C0, $1D
LA944:  .byte $01, $C8, $1D, $01, $FD
;Room enemy/door data:
LA949:  .byte $02, $A1, $11, $81, $35, $FF

;Room #$1F
LA94F:  .byte $01                       ;Attribute table data.
;Room object data:
LA950:  .byte $00, $1D, $01, $08, $1D, $01, $10, $1E, $01, $50, $03, $02, $80, $1F, $01, $C0
LA960:  .byte $1D, $01, $C8, $1D, $01, $CC, $05, $02, $FD
;Room enemy/door data:
LA969:  .byte $02, $B1, $01, $88, $AB, $17, $07, $CD, $FF

;Room #$20
LA972:  .byte $01                       ;Attribute table data.
;Room object data:
LA973:  .byte $00, $1D, $01, $08, $1D, $01, $78, $0C, $00, $88, $21, $01, $C0, $1D, $01, $C8
LA983:  .byte $1D, $01, $CD, $05, $02, $FD
;Room enemy/door data:
LA989:  .byte $27, $87, $CE, $41, $80, $BC, $FF

;Room #$21
LA990:  .byte $01                       ;Attribute table data.
;Room object data:
LA991:  .byte $00, $1D, $01, $08, $1D, $01, $20, $1D, $01, $28, $1D, $01, $50, $03, $02, $5F
LA9A1:  .byte $03, $02, $80, $1D, $01, $88, $1D, $01, $B0, $1D, $01, $B8, $1D, $01, $C0, $1D
LA9B1:  .byte $01, $C8, $1D, $01, $FD
;Room enemy/door data:
LA9B6:  .byte $02, $A1, $02, $B1, $21, $81, $68, $FF

;Room #$22
LA9BE:  .byte $03                       ;Attribute table data.
;Room object data:
LA9BF:  .byte $00, $13, $03, $04, $13, $03, $08, $13, $03, $0C, $13, $03, $10, $13, $03, $14
LA9CF:  .byte $13, $03, $18, $13, $03, $1C, $13, $03, $50, $03, $02, $5F, $03, $02, $80, $13
LA9DF:  .byte $03, $84, $13, $03, $88, $13, $03, $8C, $13, $03, $C0, $13, $03, $C4, $13, $03
LA9EF:  .byte $C8, $13, $03, $CC, $13, $03, $FD
;Room enemy/door data:
LA9F6:  .byte $02, $A1, $02, $B1, $41, $81, $68, $FF

;Room #$23
LA9FE:  .byte $00                       ;Attribute table data.
;Room object data:
LA9FF:  .byte $00, $10, $00, $0E, $06, $00, $16, $0D, $00, $2D, $09, $01, $34, $08, $01, $40
LAA0F:  .byte $10, $00, $4B, $0E, $00, $5F, $03, $02, $80, $10, $00, $84, $10, $00, $88, $10
LAA1F:  .byte $00, $8C, $10, $00, $C0, $10, $00, $CC, $10, $00, $D4, $00, $02, $FD
;Room enemy/door data:
LAA2D:  .byte $02, $A1, $01, $03, $38, $FF

;Room #$24
LAA33:  .byte $00                       ;Attribute table data.
;Room object data:
LAA34:  .byte $00, $07, $00, $0E, $07, $00, $19, $11, $00, $1D, $09, $01, $32, $08, $01, $4C
LAA44:  .byte $11, $00, $50, $03, $02, $5E, $07, $00, $80, $10, $00, $84, $10, $00, $88, $10
LAA54:  .byte $00, $8C, $10, $00, $C0, $10, $00, $CC, $10, $00, $FD
;Room enemy/door data:
LAA5F:  .byte $02, $B1, $41, $80, $75, $51, $00, $7A, $01, $83, $45, $FF

;---------------------------------------[ Structure definitions ]------------------------------------

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LAA6B:  .byte $08, $01, $01, $01, $01, $01, $01, $01, $01, $08, $00, $00, $00, $00, $00, $00
LAA7B:  .byte $00, $00, $FF

;Structure #$01
LAA7E:  .byte $08, $02, $02, $02, $02, $02, $02, $02, $02, $01, $1C, $01, $1C, $01, $1C, $08
LAA8E:  .byte $02, $02, $02, $02, $02, $02, $02, $02, $FF

;Structure #$02
LAA97:  .byte $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02
LAAA7:  .byte $04, $05, $02, $04, $05, $02, $04, $05, $FF

;Structure #$03
LAAB0:  .byte $01, $06, $01, $06, $01, $06, $FF

;Structure #$04
LAAB7:  .byte $01, $07, $01, $07, $01, $07, $FF

;Structure #$05
LAABE:  .byte $02, $14, $15, $FF

;Structure #$06
LAAC2:  .byte $02, $17, $17, $02, $17, $1B, $02, $17, $1B, $02, $1B, $17, $02, $17, $17, $FF

;Structure #$07
LAAD2:  .byte $02, $1A, $17, $02, $17, $17, $02, $1B, $1A, $02, $17, $17, $02, $1A, $1B, $FF

;Structure #$08
LAAE2:  .byte $01, $18, $01, $18, $FF

;Structure #$09
LAAE7:  .byte $01, $19, $01, $19, $FF

;Structure #$0A
LAAEC:  .byte $01, $09, $FF

;Structure #$0B
LAAEF:  .byte $01, $0A, $FF

;Structure #$0C
LAAF2:  .byte $01, $1E, $01, $1A, $01, $1A, $01, $1A, $01, $1E, $FF

;Structure #$0D
LAAFD:  .byte $04, $17, $17, $17, $17, $FF

;Structure #$0E
LAB03:  .byte $03, $17, $1D, $17, $FF

;Structure #$0F
LAB08:  .byte $01, $0B, $01, $0B, $01, $0B, $01, $0B, $FF

;Structure #$10
LAB11:  .byte $04, $17, $17, $1B, $17, $04, $1B, $17, $17, $17, $04, $1B, $17, $1B, $1B, $04
LAB21:  .byte $17, $1B, $17, $17, $FF

;Structure #$11
LAB26:  .byte $01, $17, $FF

;Structure #$12
LAB29:  .byte $08, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $08, $1E, $1E, $1E, $1E, $1E, $1E
LAB39:  .byte $1E, $1E, $FF

;Structure #$13
LAB3C:  .byte $04, $0F, $0F, $0F, $0F, $04, $0F, $0F, $0F, $0F, $04, $0F, $0F, $0F, $0F, $04
LAB4C:  .byte $0F, $0F, $0F, $0F, $FF

;Structure #$14
LAB51:  .byte $02, $12, $12, $FF

;Structure #$15
LAB55:  .byte $08, $10, $10, $10, $10, $10, $10, $10, $10, $08, $10, $10, $10, $10, $10, $10
LAB65:  .byte $10, $10, $FF

;Structure #$16
LAB68:  .byte $02, $10, $10, $02, $10, $10, $02, $10, $10, $02, $10, $10, $FF

;Structure #$17
LAB75:  .byte $08, $13, $0E, $13, $0E, $0E, $13, $0E, $0E, $08, $0E, $0E, $13, $13, $0E, $0E
LAB85:  .byte $13, $13, $FF

;Structure #$18
LAB88:  .byte $08, $11, $11, $11, $11, $11, $11, $11, $11, $08, $11, $11, $11, $11, $11, $11
LAB98:  .byte $11, $11, $FF

;Structure #$19
LAB9B:  .byte $04, $11, $11, $11, $11, $04, $11, $11, $11, $11, $04, $11, $11, $11, $11, $04
LABAB:  .byte $11, $11, $11, $11, $FF

;Structure #$1A
LABB0:  .byte $08, $20, $22, $22, $22, $22, $22, $22, $22, $FF

;Structure #$1B
LABBA:  .byte $01, $1F, $FF

;Structure #$1C
LABBD:  .byte $01, $21, $01, $21, $01, $21, $FF

;Structure #$1D
LABC4:  .byte $08, $23, $23, $23, $23, $23, $23, $23, $23, $08, $23, $24, $24, $24, $24, $24
LABD4:  .byte $24, $23, $08, $23, $23, $23, $23, $23, $23, $23, $23, $FF

;Structure #$1E
LABE0:  .byte $01, $23, $01, $23, $01, $23, $01, $23, $FF

;Structure #$1F
LABE9:  .byte $04, $23, $23, $23, $23, $04, $23, $24, $24, $23, $04, $23, $24, $24, $23, $04
LABF9:  .byte $23, $23, $23, $23, $FF

;Structure #$20
LABFE:  .byte $01, $25, $FF

;Structure #$21
LAC01:  .byte $01, $26, $01, $26, $01, $26, $01, $26, $FF

;Structure #$22
LAC0A:  .byte $03, $27, $27, $27, $FF

;Structure #$23
LAC0F:  .byte $03, $28, $28, $28, $FF

;Structure #$24
LAC14:  .byte $08, $13, $13, $13, $13, $13, $13, $13, $13, $FF

;Structure #$25
LAC1E:  .byte $01, $13, $01, $13, $01, $13, $01, $13, $FF

;Structure #$26
LAC27:  .byte $04, $0C, $0C, $0C, $0C, $04, $0D, $0D, $0D, $0D, $FF


;----------------------------------------[ Macro definitions ]---------------------------------------

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

MacroDefs:

LAC32:  .byte $F1, $F1, $F1, $F1
LAC36:  .byte $FF, $FF, $F0, $F0
LAC3A:  .byte $64, $64, $64, $64
LAC3E:  .byte $FF, $FF, $64, $64
LAC42:  .byte $A4, $FF, $A4, $FF
LAC46:  .byte $FF, $A5, $FF, $A5
LAC4A:  .byte $A0, $A0, $A0, $A0
LAC4E:  .byte $A1, $A1, $A1, $A1
LAC52:  .byte $4F, $4F, $4F, $4F
LAC56:  .byte $84, $85, $86, $87
LAC5A:  .byte $88, $89, $8A, $8B
LAC5E:  .byte $80, $81, $82, $83
LAC62:  .byte $FF, $FF, $BA, $BA
LAC66:  .byte $BB, $BB, $BB, $BB
LAC6A:  .byte $10, $11, $12, $13
LAC6E:  .byte $04, $05, $06, $07
LAC72:  .byte $14, $15, $16, $17
LAC76:  .byte $1C, $1D, $1E, $1F
LAC7A:  .byte $09, $09, $09, $09
LAC7E:  .byte $0C, $0D, $0E, $0F
LAC82:  .byte $FF, $FF, $59, $5A
LAC86:  .byte $FF, $FF, $5A, $5B
LAC8A:  .byte $51, $52, $53, $54
LAC8E:  .byte $55, $56, $57, $58
LAC92:  .byte $EC, $FF, $ED, $FF
LAC96:  .byte $FF, $EE, $FF, $EF
LAC9A:  .byte $45, $46, $45, $46
LAC9E:  .byte $4B, $4C, $4D, $50
LACA2:  .byte $FF, $FF, $FF, $FF
LACA6:  .byte $47, $48, $47, $48
LACAA:  .byte $08, $08, $08, $08
LACAE:  .byte $70, $71, $72, $73
LACB2:  .byte $74, $75, $76, $77
LACB6:  .byte $E0, $E1, $E2, $E3
LACBA:  .byte $E4, $E5, $E6, $E7
LACBE:  .byte $20, $21, $22, $23
LACC2:  .byte $25, $25, $24, $24
LACC6:  .byte $78, $79, $7A, $7B
LACCA:  .byte $E8, $E9, $EA, $EB
LACCE:  .byte $26, $27, $28, $29
LACD2:  .byte $2A, $2B, $2C, $2D

;Not used.
LACD6:  .byte $0D, $1E, $07, $21, $1D, $0D, $0D, $0D, $1E, $21, $07, $21, $21, $15, $14, $15
LACE6:  .byte $21, $21, $07, $0D, $21, $16, $10, $16, $21, $0D, $07, $1F, $0D, $20, $10, $1F
LACF6:  .byte $0D, $20, $FF, $08, $22, $22, $0D, $22, $22, $1E, $1C, $1D, $08, $1C, $1C, $21
LAD06:  .byte $1C, $1C, $21, $1C, $21, $08, $1C, $1C, $0C, $1C, $1C, $1F, $0D, $20, $07, $1C
LAD16:  .byte $1C, $21, $1C, $1C, $1C, $14, $04, $1C, $14, $0D, $14, $03, $1C, $1C, $15, $FF
LAD26:  .byte $02, $01, $01, $02, $00, $00, $FF, $01, $16, $01, $21, $01, $21, $01, $0C, $01
LAD36:  .byte $21, $01, $0D, $01, $21, $FF, $01, $0C, $FF, $07, $22, $22, $22, $22, $22, $22
LAD46:  .byte $22, $FF, $05, $0B, $1D, $22, $0D, $22, $04, $11, $21, $11, $21, $04, $11, $21
LAD56:  .byte $11, $0D, $03, $11, $21, $11, $03, $23, $23, $23, $FF, $03, $19, $1B, $1A, $FF
LAD66:  .byte $01, $34, $01, $34, $FF, $08, $1D, $22, $17, $0D, $1E, $0D, $17, $0D, $08, $0D
LAD76:  .byte $22, $17, $20, $21, $14, $0D, $11, $08, $21, $1D, $22, $17, $20, $10, $10, $21
LAD86:  .byte $08, $21, $1F, $17, $0D, $22, $0D, $1E, $11, $08, $0D, $14, $10, $1F, $22, $22
LAD96:  .byte $20, $11, $FF, $08, $17, $17, $0D, $17, $17, $0D, $17, $17, $08, $0D, $17, $17
LADA6:  .byte $17, $17, $17, $17, $0D, $FF, $08, $18, $1D, $17, $1E, $1D, $17, $17, $1E, $08
LADB6:  .byte $18, $21, $1C, $21, $21, $1C, $1C, $21, $08, $0D, $20, $1C, $1F, $20, $1C, $1C
LADC6:  .byte $1F, $FF, $04, $0D, $0D, $0D, $0D, $04, $18, $18, $18, $18, $04, $18, $18, $18
LADD6:  .byte $18, $04, $18, $18, $18, $18, $FF, $07, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $07
LADE6:  .byte $0D, $17, $17, $17, $17, $17, $0D, $07, $18, $0A, $10, $0A, $0A, $10, $18, $07
LADF6:  .byte $0D, $17, $17, $17, $17, $17, $0D, $FF, $01, $0A, $01, $0A, $01, $0A, $01, $0A
LAE06:  .byte $01, $0A, $01, $0A, $01, $0A, $01, $0A, $FF, $01, $0D, $01, $18, $01, $18, $01
LAE16:  .byte $18, $01, $18, $FF, $02, $19, $1A, $FF, $01, $0D, $FF, $04, $14, $1C, $1C, $14
LAE26:  .byte $04, $0A, $0A, $0A, $0A, $FF, $08, $0D, $22, $22, $22, $22, $22, $22, $0D, $FF
LAE36:  .byte $08, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $08, $0E, $10, $0E, $0E, $10, $10
LAE46:  .byte $0E, $10, $FF, $A7, $A7, $A7, $A7, $FF, $FF, $A6, $A6, $A2, $A2, $FF, $FF, $FF
LAE56:  .byte $FF, $A3, $A3, $A4, $FF, $A4, $FF, $FF, $A5, $FF, $A5, $FF, $79, $FF, $7E, $4F
LAE66:  .byte $4F, $4F, $4F, $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $04, $05, $06, $07, $10
LAE76:  .byte $11, $12, $13, $00, $01, $02, $03, $08, $08, $08, $08, $18, $19, $1A, $1B, $1C
LAE86:  .byte $1D, $1E, $1F, $0C, $0D, $0E, $0F, $09, $09, $09, $09, $7A, $7B, $7F, $5A, $2A
LAE96:  .byte $2C, $FF, $FF, $14, $15, $16, $17, $20, $21, $22, $23, $24, $25, $20, $21, $28
LAEA6:  .byte $28, $29, $29, $26, $27, $26, $27, $2A, $2B, $FF, $FF, $2B, $2C, $FF, $FF, $2B
LAEB6:  .byte $2B, $FF, $FF, $FF, $FF, $FF, $FF, $31, $32, $33, $34, $35, $36, $37, $38, $3D
LAEC6:  .byte $3E, $3F, $40, $41, $42, $43, $44, $39, $3A, $39, $3A, $3B, $3B, $3C, $3C, $0B
LAED6:  .byte $0B, $2D, $2E, $2F, $30, $0B, $0B, $50, $51, $52, $53, $54, $55, $54, $55, $56
LAEE6:  .byte $57, $58, $59, $FF, $FF, $FF, $5E, $5B, $5C, $5F, $60, $FF, $FF, $61, $FF, $5D
LAEF6:  .byte $62, $67, $68, $63, $64, $69, $6A, $65, $66, $6B, $6C, $6D, $6E, $73, $74, $6F
LAF06:  .byte $70, $75, $76, $71, $72, $77, $78, $45, $46, $47, $48, $FF, $98, $FF, $98, $49
LAF16:  .byte $4A, $4B, $4C, $90, $91, $90, $91, $7C, $7D, $4D, $FF, $1C, $1D, $1E, $17, $18
LAF26:  .byte $19, $1A, $1F, $20, $21, $22, $60, $61, $62, $63, $0E, $0F, $FF, $FF, $0C, $0D
LAF36:  .byte $0D, $0D, $10, $0D, $FF, $10, $10, $FF, $FF, $FF, $FF, $FF, $FF, $30, $FF, $33
LAF46:  .byte $FF, $36, $FF, $39, $FF, $3D, $FF, $FF, $31, $32, $34, $35, $37, $38, $3A, $3B
LAF56:  .byte $3E, $3F, $3C, $41, $40, $42, $84, $85, $86, $87, $80, $81, $82, $83, $88, $89
LAF66:  .byte $8A, $8B, $45, $46, $45, $46, $47, $48, $48, $47, $5C, $5D, $5E, $5F, $B8, $B8
LAF76:  .byte $B9, $B9, $74, $75, $75, $74, $C1, $13, $13, $13, $36, $BE, $BC, $BD, $BF, $14
LAF86:  .byte $15, $14, $C0, $14, $C0, $16, $FF, $C1, $FF, $FF, $C2, $14, $FF, $FF, $30, $13
LAF96:  .byte $BC, $BD, $13, $14, $15, $16, $D7, $D7, $D7, $D7, $76, $76, $76, $76, $FF, $FF
LAFA6:  .byte $BA, $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03, $04, $05, $06, $07, $FF, $FF
LAFB6:  .byte $08, $09, $FF, $FF, $09, $0A, $55, $56, $57, $58, $90, $91, $92, $93, $4B, $4C
LAFC6:  .byte $4D, $50, $51, $52, $53, $54, $70, $71, $72, $73, $8C, $8D, $8E, $8F, $11, $12
LAFD6:  .byte $FF, $11, $11, $12, $12, $11, $11, $12, $12, $FF, $C3, $C4, $C5, $C6, $30, $00
LAFE6:  .byte $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93, $20, $20
LAFF6:  .byte $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0

.advance $B000, $00
.include "../music/KraidMusic.asm"

.advance $B200, $00
.include "../SoundEngine.asm"

.advance $C000, $00