; METROID Disassembly (c) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
; Disassembled by Kent Hansen. Commented by Nick Mikstas.
; This version is organized and ported to use the MMC3.
; Ridley hideout (Rom Bank 5)

.require "../Defines.asm"
.require "../GameEngineDeclarations.asm"

.org ROMBank_Switchable
.include "../AreaCommon.asm"
.advance $8D60,$EA

;------------------------------------------[ Graphics data ]-----------------------------------------

;Misc. tile patterns.
L8D60:  .byte $73, $FD, $3B, $A0, $C0, $E0, $60, $80, $00, $00, $00, $1F, $10, $17, $14, $14
L8D70:  .byte $E8, $9C, $7C, $1C, $44, $58, $5C, $5C, $00, $04, $0C, $FC, $24, $B8, $BC, $BC
L8D80:  .byte $E0, $E7, $A0, $2F, $73, $7C, $00, $00, $17, $10, $1F, $0F, $33, $7C, $00, $00
L8D90:  .byte $58, $D4, $14, $DC, $EC, $D8, $00, $00, $B8, $34, $F4, $DC, $EC, $D8, $00, $00
L8DA0:  .byte $41, $41, $77, $14, $14, $14, $14, $14, $1D, $01, $7F, $0C, $0C, $0C, $0C, $0C
L8DB0:  .byte $14, $14, $14, $14, $14, $7F, $41, $41, $0C, $0C, $0C, $0C, $0C, $01, $01, $1D
L8DC0:  .byte $7F, $7F, $7F, $3E, $3E, $3E, $3C, $1C, $03, $03, $07, $06, $06, $06, $04, $04
L8DD0:  .byte $7E, $7E, $7E, $7C, $7C, $3C, $38, $38, $06, $06, $0E, $0C, $0C, $0C, $08, $08
L8DE0:  .byte $1C, $1C, $1C, $08, $08, $08, $08, $08, $04, $04, $04, $00, $00, $00, $00, $00
L8DF0:  .byte $38, $10, $10, $10, $00, $00, $00, $00, $08, $00, $00, $00, $00, $00, $00, $00
L8E00:  .byte $7E, $7E, $7E, $3E, $3E, $3C, $1C, $1C, $60, $60, $70, $30, $30, $30, $10, $10
L8E10:  .byte $FE, $FE, $FE, $7C, $7C, $7C, $3C, $38, $C0, $C0, $E0, $60, $60, $60, $20, $20
L8E20:  .byte $1C, $08, $08, $08, $00, $00, $00, $00, $10, $00, $00, $00, $00, $00, $00, $00
L8E30:  .byte $38, $38, $38, $10, $10, $10, $10, $10, $20, $20, $20, $00, $00, $00, $00, $00
L8E40:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E50:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E60:  .byte $00, $01, $03, $00, $0F, $03, $1F, $21, $00, $01, $01, $00, $01, $03, $07, $01
L8E70:  .byte $7F, $FF, $F0, $D7, $8F, $DC, $98, $F8, $7F, $9F, $70, $D0, $83, $C4, $88, $E8
L8E80:  .byte $80, $F0, $78, $BC, $FC, $7E, $6E, $4C, $80, $F0, $78, $3C, $BC, $7E, $6E, $4C
L8E90:  .byte $3C, $3C, $3A, $7B, $77, $6F, $69, $3C, $3C, $2C, $2A, $5B, $51, $47, $61, $1C
L8EA0:  .byte $D1, $89, $07, $C6, $20, $1C, $87, $00, $C1, $81, $07, $C6, $00, $00, $80, $00
L8EB0:  .byte $F6, $02, $08, $1C, $1E, $1E, $07, $07, $F6, $22, $60, $C0, $98, $9C, $44, $26
L8EC0:  .byte $70, $70, $0C, $32, $20, $1C, $10, $06, $30, $30, $0C, $12, $20, $0C, $10, $02
L8ED0:  .byte $1C, $7E, $78, $F3, $F1, $E1, $C2, $73, $1C, $66, $58, $B3, $B1, $A1, $C2, $73
L8EE0:  .byte $03, $03, $03, $01, $B1, $18, $0C, $CC, $12, $12, $22, $00, $90, $08, $04, $44
L8EF0:  .byte $00, $07, $00, $03, $00, $01, $03, $0F, $00, $03, $00, $01, $00, $00, $01, $03
L8F00:  .byte $01, $48, $46, $30, $1E, $C0, $81, $67, $01, $48, $46, $30, $1E, $C0, $80, $61
L8F10:  .byte $E6, $F0, $31, $0B, $83, $00, $EF, $C9, $A2, $C0, $30, $08, $81, $00, $20, $C1
L8F20:  .byte $02, $03, $77, $89, $BE, $2C, $00, $80, $00, $01, $77, $81, $8E, $0C, $00, $00
L8F30:  .byte $0F, $02, $1F, $02, $0F, $1B, $11, $F0, $07, $02, $0F, $02, $07, $0B, $11, $D0
L8F40:  .byte $1F, $3C, $70, $61, $07, $5E, $19, $7E, $07, $1C, $30, $20, $01, $46, $19, $7E
L8F50:  .byte $26, $7E, $58, $D2, $23, $C1, $00, $00, $20, $22, $10, $52, $23, $C1, $00, $00
L8F60:  .byte $00, $40, $70, $18, $C8, $ED, $F7, $3D, $00, $00, $40, $10, $00, $C9, $E1, $3D
L8F70:  .byte $18, $70, $F0, $80, $00, $00, $00, $00, $10, $10, $F0, $80, $00, $00, $00, $00
L8F80:  .byte $00, $00, $00, $70, $FC, $DE, $02, $E2, $00, $00, $00, $00, $70, $1E, $02, $C0
L8F90:  .byte $45, $D7, $FF, $FF, $FD, $FF, $BF, $FB, $00, $00, $00, $00, $02, $00, $40, $04
L8FA0:  .byte $FF, $BB, $FF, $FF, $EF, $FF, $7F, $FD, $00, $44, $00, $00, $10, $00, $80, $02
L8FB0:  .byte $12, $12, $12, $12, $12, $12, $12, $12, $1D, $1D, $1D, $1D, $1D, $1D, $1D, $1D
L8FC0:  .byte $58, $58, $58, $58, $58, $58, $58, $58, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8
L8FD0:  .byte $00, $00, $7F, $80, $80, $FF, $7F, $00, $00, $7F, $80, $7F, $FF, $FF, $7F, $00
L8FE0:  .byte $00, $00, $FC, $01, $03, $FF, $FE, $00, $00, $FE, $03, $FF, $FF, $FF, $FE, $00
L8FF0:  .byte $00, $00, $00, $00, $00, $FF, $00, $00, $FF, $FF, $FF, $FF, $FF, $00, $FF, $FF
L9000:  .byte $FF, $00, $FF, $FF, $FF, $FF, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00
L9010:  .byte $00, $00, $10, $00, $09, $10, $0A, $25, $00, $00, $10, $00, $09, $10, $0A, $25
L9020:  .byte $00, $00, $00, $90, $68, $90, $F4, $BA, $00, $00, $00, $90, $68, $90, $74, $AA
L9030:  .byte $0A, $07, $2B, $15, $02, $21, $04, $00, $0A, $07, $2B, $15, $02, $21, $04, $00
L9040:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9050:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9060:  .byte $FC, $B4, $6A, $C8, $22, $28, $00, $00, $FC, $B4, $6A, $C8, $22, $28, $00, $00
L9070:  .byte $22, $76, $FF, $FF, $FF, $7F, $FF, $7E, $00, $76, $F7, $7F, $DB, $7F, $FF, $5E
L9080:  .byte $90, $60, $E0, $D0, $F0, $AC, $D0, $F8, $90, $40, $E0, $D0, $F0, $AC, $D0, $F8
L9090:  .byte $FF, $EE, $BD, $7B, $3E, $50, $00, $00, $FF, $EE, $BD, $7B, $3E, $50, $00, $00
L90A0:  .byte $E4, $40, $A8, $40, $40, $00, $00, $00, $E4, $40, $A8, $40, $40, $00, $00, $00
L90B0:  .byte $3F, $C0, $80, $80, $00, $00, $FF, $80, $00, $3F, $7F, $7F, $00, $00, $00, $7F
L90C0:  .byte $FC, $00, $00, $00, $00, $1C, $90, $20, $00, $FC, $FC, $FC, $00, $00, $0C, $9C
L90D0:  .byte $80, $80, $00, $F0, $80, $80, $00, $00, $7F, $7F, $00, $00, $7F, $7F, $00, $00
L90E0:  .byte $20, $20, $00, $3C, $40, $40, $00, $00, $9C, $1C, $00, $00, $BC, $BC, $00, $00
L90F0:  .byte $10, $10, $10, $00, $08, $08, $08, $08, $6F, $6F, $6F, $00, $17, $17, $17, $17
L9100:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $00, $FF, $FF, $FF, $FF
L9110:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $E6, $E6, $E6, $00, $C8, $C8, $C8, $C8
L9120:  .byte $7E, $FF, $C0, $C0, $C0, $CF, $C0, $4F, $00, $00, $3F, $2F, $3F, $30, $38, $30
L9130:  .byte $7E, $FF, $03, $03, $03, $F3, $03, $F2, $00, $01, $FF, $F7, $FF, $FF, $0F, $FE
L9140:  .byte $40, $CF, $C0, $C0, $C0, $C0, $FF, $7E, $38, $30, $38, $3F, $2F, $3F, $7F, $7E
L9150:  .byte $02, $F3, $03, $03, $03, $03, $FF, $7E, $0E, $FF, $0F, $FF, $F7, $FF, $FF, $7E
L9160:  .byte $73, $F9, $FF, $7F, $3F, $BF, $FF, $FF, $00, $79, $40, $5F, $10, $17, $54, $55
L9170:  .byte $CC, $DC, $FC, $F4, $F0, $D4, $D4, $54, $00, $DC, $04, $F4, $10, $D4, $54, $54
L9180:  .byte $FC, $FF, $B0, $7F, $C0, $F7, $00, $00, $54, $57, $10, $5F, $40, $77, $00, $00
L9190:  .byte $50, $D4, $14, $F4, $04, $CC, $00, $00, $50, $94, $14, $E4, $04, $C8, $00, $00
L91A0:  .byte $FE, $82, $92, $AA, $92, $82, $FE, $00, $00, $7E, $46, $5E, $56, $7E, $FE, $00

;Game over, Japaneese font tile patterns.
L91B0:  .byte $C0, $04, $C4, $04, $04, $0C, $F8, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91C0:  .byte $00, $00, $00, $00, $04, $12, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91D0:  .byte $40, $7E, $48, $88, $08, $18, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91E0:  .byte $E0, $02, $02, $02, $06, $0C, $F8, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91F0:  .byte $18, $0C, $86, $82, $82, $82, $82, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9200:  .byte $7E, $42, $C2, $02, $06, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9210:  .byte $7E, $42, $C2, $1E, $02, $06, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9220:  .byte $44, $FE, $44, $44, $04, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9230:  .byte $40, $40, $40, $78, $44, $40, $40, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9240:  .byte $10, $FE, $82, $82, $06, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9250:  .byte $0C, $78, $08, $FE, $08, $18, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9260:  .byte $7C, $00, $00, $00, $00, $00, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9270:  .byte $00, $00, $50, $54, $04, $0C, $38, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9280:  .byte $00, $00, $00, $38, $08, $08, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9290:  .byte $A2, $A2, $A2, $02, $06, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92A0:  .byte $40, $FE, $42, $46, $44, $60, $3E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92B0:  .byte $7E, $02, $02, $7E, $02, $02, $7E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92C0:  .byte $00, $00, $00, $00, $00, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92D0:  .byte $3E, $60, $C0, $CE, $C6, $66, $3E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92E0:  .byte $38, $6C, $C6, $C6, $FE, $C6, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L92F0:  .byte $C6, $EE, $FE, $FE, $D6, $C6, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9300:  .byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9310:  .byte $7C, $C6, $C6, $C6, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9320:  .byte $C6, $C6, $C6, $EE, $7C, $38, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9330:  .byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9340:  .byte $7E, $18, $18, $18, $18, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9350:  .byte $7E, $18, $18, $18, $18, $18, $7E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9360:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9370:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9380:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9390:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93A0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93B0:  .byte $45, $D7, $FF, $BB, $FF, $EF, $7F, $DD, $00, $00, $00, $44, $02, $50, $88, $22
L93C0:  .byte $FF, $77, $DD, $F7, $BE, $EF, $BB, $6E, $24, $88, $22, $48, $45, $10, $46, $B1
L93D0:  .byte $7E, $42, $C2, $1E, $02, $06, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93E0:  .byte $00, $00, $00, $00, $04, $12, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00
L93F0:  .byte $44, $FE, $44, $44, $04, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9400:  .byte $06, $0C, $38, $F0, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9410:  .byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9420:  .byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9430:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9440:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9450:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9460:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9470:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9480:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9490:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L94A0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

.advance $9560, $00

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
L9560:  .word Palette00                 ;
L9562:  .word Palette01                 ;
L9564:  .word Palette02                 ;
L9566:  .word Palette03                 ;
L9568:  .word Palette04                 ;
L956A:  .word Palette05                 ;
L956C:  .word Palette06                 ;
L956E:  .word Palette06                 ;
L9570:  .word Palette06                 ;
L9572:  .word Palette06                 ;
L9574:  .word Palette06                 ;
L9576:  .word Palette06                 ;
L9578:  .word Palette06                 ;
L957A:  .word Palette06                 ;
L957C:  .word Palette06                 ;
L957E:  .word Palette06                 ;
L9580:  .word Palette06                 ;
L9582:  .word Palette06                 ;
L9584:  .word Palette06                 ;
L9586:  .word Palette06                 ;
L9588:  .word Palette07                 ;
L958A:  .word Palette08                 ;
L958C:  .word Palette09                 ;
L958E:  .word Palette0A                 ;
L9590:  .word Palette0B                 ;
L9592:  .word Palette0C                 ;
L9594:  .word Palette0D                 ;
L9596:  .word Palette0E                 ;

AreaPointers:
L9598:  .word SpecItmsTbl               ;Beginning of special items table.
L959A:  .word RmPtrTbl                  ;Beginning of room pointer table.
L959C:  .word StrctPtrTbl               ;Beginning of structure pointer table.
L959E:  .word MacroDefs                 ;Beginning of macro definitions.
L95A0:  .word EnemyFramePtrTbl1         ;Address table into enemy animation data. Two-->
L95A2:  .word EnemyFramePtrTbl2         ;tables needed to accommodate all entries.
L95A4:  .word EnemyPlacePtrTbl          ;Pointers to enemy frame placement data.
L95A6:  .word EnemyAnimIndexTbl         ;Index to values in addr tables for enemy animations.

L95A8:  .byte $60, $EA, $EA, $60, $EA, $EA  ; rts nop nop rts nop nop
L95AE:  .byte $60, $EA, $EA, $60, $EA, $EA  ; rts nop nop rts nop nop
L95B4:  .byte $60, $EA, $EA, $60, $EA, $EA  ; rts nop nop rts nop nop
L95BA:  .byte $60, $EA, $EA, $60, $EA, $EA  ; rts nop nop rts nop nop
L95C0:  .byte $60, $EA, $EA                 ; rts nop nop

AreaRoutine:
L95C3:  JMP $9B48                       ;Area specific routine.

TwosCompliment_:
L95C6:  EOR #$FF                        ;
L95C8:  CLC                             ;The following routine returns the twos-->
L95C9:  ADC #$01                        ;compliment of the value stored in A.
L95CB:  RTS                             ;

L95CC:  .byte $12                       ;Ridley's room.

L95CD:  .byte $80                       ;Ridley hideout music init flag.

L95CE:  .byte $40                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $02                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:  .byte $19                       ;Samus start x coord on world map.
L95D8:  .byte $18                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $06, $00, $03, $58, $44, $4A, $48, $4A, $4A, $36, $25

L95E5:  LDA EnDataIndex,X
L95E8:  JSR CommonJump_ChooseRoutine

L95EB:  .word $98D7
L95ED:  .word $990C
L95EF:  .word $9847
L95F1:  .word $9862
L95F3:  .word $982A
L95F5:  .word $982A
L95F7:  .word $9967
L95F9:  .word $9867
L95FB:  .word $982A
L95FD:  .word $9A13
L95FF:  .word $9A4A
L9601:  .word $982A
L9603:  .word $9B03
L9605:  .word $982A
L9607:  .word $9B16
L9609:  .word $982A

L960B:  .byte $23, $23, $23, $23, $3A, $3A, $3C, $3C, $00, $00, $00, $00, $56, $56, $65, $63

L961B:  .byte $00, $00, $11, $11, $13, $18, $28, $28, $32, $32, $34, $34, $00, $00, $00, $00

L962B:  .byte $08, $08, $08, $08, $01, $01, $02, $01, $01, $8C, $FF, $FF, $08, $06, $FF, $00

L963B:  .byte $1D, $1D, $1D, $1D, $3E, $3E, $44, $44, $00, $00, $00, $00, $4A, $4A, $69, $67

L964B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $2D, $28, $34, $34, $00, $00, $00, $00

L965B:  .byte $20, $20, $20, $20, $3E, $3E, $44, $44, $00, $00, $00, $00, $4A, $4A, $60, $5D

L966B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $2D, $28, $34, $34, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00

L968B:  .byte $89, $89, $89, $89, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

L96AB:  .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $86, $00, $00

L96BB:  .byte $10, $01, $03, $03, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

L96CB:  .byte $18, $1A, $00, $03, $00, $00, $08, $08, $00, $0A, $0C, $0F, $14, $16, $18, $00

L96DB:  .word $97ED, $97ED, $97ED, $97ED, $97ED, $97F0, $97F3, $97F3
L96EB:  .word $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3
L96FB:  .word $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3
L970B:  .word $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3, $97F3
L971B:  .word $97F3, $97F3, $97F3, $97F3

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $7F, $7F, $81, $81
L9733:  .byte $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $00, $00, $C8, $00, $00, $00, $00, $00, $08, $20, $00, $00, $00, $00
L9753:  .byte $0C, $0C, $02, $01, $F6, $FC, $0A, $04, $01, $FC, $06, $FE, $FE, $FA, $F9, $F9
L9763:  .byte $FD, $00, $00, $00, $00, $02, $01, $01, $02, $02, $02, $02, $06, $00, $01, $01
L9773:  .byte $01, $00, $00, $00, $03, $00, $00, $00

L977B:  .byte $4C, $4C, $64, $6C, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

L978B:  .byte $00, $00, $00, $00, $34, $34, $44, $4A, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $08, $F8, $00, $00, $00, $00, $08, $F8, $00, $00, $00, $F8

L97A7:  .word $97FD, $97FD, $980C, $981B, $9B49, $9B4E, $9B53, $9B58
L97B7:  .word $9B5D, $9B62, $9B67, $9B6C, $9B71, $9B76, $9B7B, $9B80
L97C7:  .word $9B85, $9B85, $9B85, $9B85, $9B85

L97D1:  .byte $01, $04, $05, $01, $06, $07, $00, $02, $00, $09, $00, $0D, $01, $0E, $0F, $03
L97E1:  .byte $00, $01, $02, $03, $00, $10, $00, $11, $00, $00, $00, $01

L97ED:  .byte $01, $03, $FF

L97F0:  .byte $01, $0B, $FF

L97F3:  .byte $14, $90, $0A, $00, $FD, $30, $00, $14, $10, $FA

L97FD:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L980C:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L981B:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

L982A:  LDA #$00
L982C:  STA $6AF4,X
L982F:  RTS

L9830:  LDA $81
L9832:  CMP #$01
L9834:  BEQ $983F
L9836:  CMP #$03
L9838:  BEQ $9844
L983A:  LDA $00
L983C:  JMP CommonJump_UnknownUpdateAnim0
L983F:  LDA $01
L9841:  JMP CommonJump_UnknownUpdateAnim1
L9844:  JMP CommonJump_Unknown06
L9847:  LDA #$42
L9849:  STA $85
L984B:  STA $86
L984D:  LDA $6AF4,X
L9850:  CMP #$03
L9852:  BEQ $9857
L9854:  JSR CommonJump_Unknown1B
L9857:  LDA #$06
L9859:  STA $00
L985B:  LDA #$08
L985D:  STA $01
L985F:  JMP $9830
L9862:  LDA #$48
L9864:  JMP $9849
L9867:  LDA $6AF4,X
L986A:  CMP #$02
L986C:  BNE $98A6
L986E:  LDA $0403,X
L9871:  BNE $98A6
L9873:  LDA $6AFE,X
L9876:  BNE $988A
L9878:  LDA $030D
L987B:  SEC 
L987C:  SBC $0400,X
L987F:  CMP #$40
L9881:  BCS $98A6
L9883:  LDA #$7F
L9885:  STA $6AFE,X
L9888:  BNE $98A6
L988A:  LDA $0402,X
L988D:  BMI $98A6
L988F:  LDA #$00
L9891:  STA $0402,X
L9894:  STA $0406,X
L9897:  STA $6AFE,X
L989A:  LDA EnData05,X
L989D:  AND #$01
L989F:  TAY 
L98A0:  LDA $98D5,Y
L98A3:  STA $0403,X
L98A6:  LDA EnData05,X
L98A9:  ASL 
L98AA:  BMI $98CA
L98AC:  LDA $6AF4,X
L98AF:  CMP #$02
L98B1:  BNE $98CA
L98B3:  JSR CommonJump_Unknown36
L98B6:  PHA 
L98B7:  JSR CommonJump_Unknown39
L98BA:  STA $05
L98BC:  PLA 
L98BD:  STA $04
L98BF:  JSR $9AE1
L98C2:  JSR CommonJump_Unknown27
L98C5:  BCC $98CF
L98C7:  JSR $9AF1
L98CA:  LDA #$03
L98CC:  JMP CommonJump_UnknownUpdateAnim1
L98CF:  LDA #$00
L98D1:  STA $6AF4,X
L98D4:  RTS

L98D5:  PHP 
L98D6:  SED 
L98D7:  LDA #$03
L98D9:  STA $00
L98DB:  LDA #$08
L98DD:  STA $01
L98DF:  LDA $6AF4,X
L98E2:  CMP #$01
L98E4:  BNE $98F2
L98E6:  LDA EnData05,X
L98E9:  AND #$10
L98EB:  BEQ $98F2
L98ED:  LDA #$01
L98EF:  JSR $9958
L98F2:  JSR $98F8
L98F5:  JMP $9830
L98F8:  LDA $6AF4,X
L98FB:  CMP #$02
L98FD:  BNE $990B
L98FF:  LDA #$20
L9901:  LDY $0402,X
L9904:  BPL $9908
L9906:  LDA #$1D
L9908:  STA $6AF9,X
L990B:  RTS

L990C:  LDA $81
L990E:  CMP #$01
L9910:  BEQ $9922
L9912:  CMP #$03
L9914:  BEQ $9955
L9916:  LDA $6AF4,X
L9919:  CMP #$01
L991B:  BNE $9927
L991D:  LDA #$00
L991F:  JSR $9958
L9922:  LDA #$08
L9924:  JMP CommonJump_UnknownUpdateAnim1
L9927:  LDA #$80
L9929:  STA $6AFE,X
L992C:  LDA $0402,X
L992F:  BMI $994D
L9931:  LDA EnData05,X
L9934:  AND #$10
L9936:  BEQ $994D
L9938:  LDA $0400,X
L993B:  SEC 
L993C:  SBC $030D
L993F:  BPL $9944
L9941:  JSR $95C6
L9944:  CMP #$10
L9946:  BCS $994D
L9948:  LDA #$00
L994A:  STA $6AFE,X
L994D:  JSR $98F8
L9950:  LDA #$03
L9952:  JMP CommonJump_UnknownUpdateAnim0
L9955:  JMP CommonJump_Unknown06
L9958:  STA EnDataIndex,X
L995B:  LDA $040B,X
L995E:  PHA 
L995F:  JSR CommonJump_Unknown2A
L9962:  PLA 
L9963:  STA $040B,X
L9966:  RTS

L9967:  JSR CommonJump_Unknown09
L996A:  AND #$03
L996C:  BEQ $99A2
L996E:  LDA $81
L9970:  CMP #$01
L9972:  BEQ $99AA
L9974:  CMP #$03
L9976:  BEQ $99A7
L9978:  LDA $6AF4,X
L997B:  CMP #$03
L997D:  BEQ $99A2
L997F:  LDA $040A,X
L9982:  AND #$03
L9984:  CMP #$01
L9986:  BNE $9999
L9988:  LDY $0400,X
L998B:  CPY #$EB
L998D:  BNE $9999
L998F:  JSR $99DB
L9992:  LDA #$03
L9994:  STA $040A,X
L9997:  BNE $999F
L9999:  JSR $9A00
L999C:  JSR $99C6
L999F:  JSR $99E4
L99A2:  LDA #$03
L99A4:  JSR CommonJump_UpdateEnemyAnim
L99A7:  JMP CommonJump_Unknown06
L99AA:  JMP CommonJump_UnknownUpdateAnim1
L99AD:  LDA EnData05,X
L99B0:  LSR 
L99B1:  LDA $040A,X
L99B4:  AND #$03
L99B6:  ROL 
L99B7:  TAY 
L99B8:  LDA $99BE,Y
L99BB:  JMP CommonJump_ResetAnimIndex

L99BE:  .byte $4A, $4A, $53, $4D, $50, $50, $4D, $53

L99C6:  LDX $4B
L99C8:  BCS $99E3
L99CA:  LDA $00
L99CC:  BNE $99DB
L99CE:  LDY $040A,X
L99D1:  DEY 
L99D2:  TYA 
L99D3:  AND #$03
L99D5:  STA $040A,X
L99D8:  JMP $99AD
L99DB:  LDA EnData05,X
L99DE:  EOR #$01
L99E0:  STA EnData05,X
L99E3:  RTS

L99E4:  JSR $99F8
L99E7:  JSR $9A00
L99EA:  LDX $4B
L99EC:  BCC $99F7
L99EE:  JSR $99F8
L99F1:  STA $040A,X
L99F4:  JSR $99AD
L99F7:  RTS

L99F8:  LDY $040A,X
L99FB:  INY 
L99FC:  TYA 
L99FD:  AND #$03
L99FF:  RTS

L9A00:  LDY EnData05,X
L9A03:  STY $00
L9A05:  LSR $00
L9A07:  ROL 
L9A08:  ASL 
L9A09:  TAY 
L9A0A:  LDA CommonRoutines+1,Y
L9A0D:  PHA 
L9A0E:  LDA CommonRoutines,Y
L9A11:  PHA 
L9A12:  RTS

L9A13:  LDA $6AF4,X
L9A16:  CMP #$03
L9A18:  BCC $9A33
L9A1A:  BEQ $9A20
L9A1C:  CMP #$05
L9A1E:  BNE $9A41
L9A20:  LDA #$00
L9A22:  STA $6B04
L9A25:  STA $6B14
L9A28:  STA $6B24
L9A2B:  STA $6B34
L9A2E:  STA $6B44
L9A31:  BEQ $9A41
L9A33:  LDA #$0B
L9A35:  STA $85
L9A37:  LDA #$0E
L9A39:  STA $86
L9A3B:  JSR CommonJump_Unknown1B
L9A3E:  JSR $9A79
L9A41:  LDA #$03
L9A43:  STA $00
L9A45:  STA $01
L9A47:  JMP $9830
L9A4A:  LDA EnData05,X
L9A4D:  PHA 
L9A4E:  LDA #$02
L9A50:  STA $00
L9A52:  STA $01
L9A54:  JSR $9830
L9A57:  PLA 
L9A58:  LDX $4B
L9A5A:  EOR EnData05,X
L9A5D:  LSR 
L9A5E:  BCS $9A73
L9A60:  LDA EnData05,X
L9A63:  LSR 
L9A64:  BCS $9A78
L9A66:  LDA $0401,X
L9A69:  SEC 
L9A6A:  SBC $030E
L9A6D:  BCC $9A78
L9A6F:  CMP #$20
L9A71:  BCC $9A78
L9A73:  LDA #$00
L9A75:  STA $6AF4,X
L9A78:  RTS

L9A79:  LDY $80
L9A7B:  BNE $9A7F
L9A7D:  LDY #$60
L9A7F:  LDA $2D
L9A81:  AND #$02
L9A83:  BNE $9AA9
L9A85:  DEY 
L9A86:  STY $80
L9A88:  TYA 
L9A89:  ASL 
L9A8A:  BMI $9AA9
L9A8C:  AND #$0F
L9A8E:  CMP #$0A
L9A90:  BNE $9AA9
L9A92:  LDX #$50
L9A94:  LDA $6AF4,X
L9A97:  BEQ $9AAA
L9A99:  LDA EnData05,X
L9A9C:  AND #$02
L9A9E:  BEQ $9AAA
L9AA0:  TXA 
L9AA1:  SEC 
L9AA2:  SBC #$10
L9AA4:  TAX 
L9AA5:  BNE $9A94
L9AA7:  INC $7E
L9AA9:  RTS

L9AAA:  TXA 
L9AAB:  TAY 
L9AAC:  LDX #$00
L9AAE:  JSR $9AE1
L9AB1:  TYA 
L9AB2:  TAX 
L9AB3:  LDA EnData05
L9AB6:  STA EnData05,X
L9AB9:  AND #$01
L9ABB:  TAY 
L9ABC:  LDA $9ADF,Y
L9ABF:  STA $05
L9AC1:  LDA #$F8
L9AC3:  STA $04
L9AC5:  JSR CommonJump_Unknown27
L9AC8:  BCC $9AA9
L9ACA:  LDA #$00
L9ACC:  STA $040F,X
L9ACF:  LDA #$0A
L9AD1:  STA EnDataIndex,X
L9AD4:  LDA #$01
L9AD6:  STA $6AF4,X
L9AD9:  JSR $9AF1
L9ADC:  JMP CommonJump_Unknown2A
L9ADF:  PHP 
L9AE0:  SED 
L9AE1:  LDA $0400,X
L9AE4:  STA $08
L9AE6:  LDA $0401,X
L9AE9:  STA $09
L9AEB:  LDA $6AFB,X
L9AEE:  STA $0B
L9AF0:  RTS

L9AF1:  LDA $0B
L9AF3:  AND #$01
L9AF5:  STA $6AFB,X
L9AF8:  LDA $08
L9AFA:  STA $0400,X
L9AFD:  LDA $09
L9AFF:  STA $0401,X
L9B02:  RTS

L9B03:  LDA $6AF4,X
L9B06:  CMP #$02
L9B08:  BNE $9B0D
L9B0A:  JSR CommonJump_Unknown1E
L9B0D:  LDA #$02
L9B0F:  STA $00
L9B11:  STA $01
L9B13:  JMP $9830
L9B16:  LDA #$00
L9B18:  STA $6AF5,X
L9B1B:  STA $6AF6,X
L9B1E:  LDA #$10
L9B20:  STA EnData05,X
L9B23:  TXA 
L9B24:  LSR 
L9B25:  LSR 
L9B26:  LSR 
L9B27:  LSR 
L9B28:  ADC $2D
L9B2A:  AND #$07
L9B2C:  BNE $9B48
L9B2E:  LSR EnData05,X
L9B31:  LDA #$03
L9B33:  STA $87
L9B35:  LDA $2E
L9B37:  LSR 
L9B38:  ROL EnData05,X
L9B3B:  AND #$03
L9B3D:  BEQ $9B48
L9B3F:  STA $88
L9B41:  LDA #$02
L9B43:  STA $85
L9B45:  JMP CommonJump_Unknown21
L9B48:  RTS

L9B49:  .byte $22, $FF, $FF, $FF, $FF

L9B4E:  .byte $22, $80, $81, $82, $83

L9B53:  .byte $22, $84, $85, $86, $87

L9B58:  .byte $22, $88, $89, $8A, $8B

L9B5D:  .byte $22, $8C, $8D, $8E, $8F

L9B62:  .byte $22, $94, $95, $96, $97

L9B67:  .byte $22, $9C, $9D, $9D, $9C

L9B6C:  .byte $22, $9E, $9F, $9F, $9E

L9B71:  .byte $22, $90, $91, $92, $93

L9B76:  .byte $22, $70, $71, $72, $73

L9B7B:  .byte $22, $74, $75, $76, $77

L9B80:  .byte $22, $78, $79, $7A, $7B

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9B85:  .byte $00, $01, $FF

L9B88:  .byte $02, $FF

L9B8A:  .byte $03, $04, $FF

L9B8D:  .byte $07, $08, $FF

L9B90:  .byte $05, $06, $FF

L9B93:  .byte $09, $0A, $FF

L9B96:  .byte $0B, $FF

L9B98:  .byte $0C, $0D, $0E, $0F, $FF

L9B9D:  .byte $10, $11, $12, $13, $FF

L9BA2:  .byte $17, $18, $FF

L9BA5:  .byte $19, $1A, $FF

L9BA8:  .byte $1B, $FF

L9BAA:  .byte $21, $22, $FF

L9BAD:  .byte $27, $28, $29, $2A, $FF

L9BB2:  .byte $2B, $2C, $2D, $2E, $FF

L9BB7:  .byte $2F, $FF

L9BB9:  .byte $42, $FF

L9BBB:  .byte $43, $44, $F7, $FF

L9BBF:  .byte $37, $FF, $38, $FF

L9BC3:  .byte $30, $31, $FF

L9BC6:  .byte $31, $32, $FF

L9BC9:  .byte $33, $34, $FF

L9BCC:  .byte $34, $35, $FF

L9BCF:  .byte $58, $59, $FF

L9BD2:  .byte $5A, $5B, $FF

L9BD5:  .byte $5C, $5D, $FF

L9BD8:  .byte $5E, $5F, $FF

L9BDB:  .byte $60, $FF

L9BDD:  .byte $61, $F7, $62, $F7, $FF

L9BE2:  .byte $66, $67, $FF

L9BE5:  .byte $69, $6A, $FF

L9BE8:  .byte $68, $FF

L9BEA:  .byte $6B, $FF

L9BEC:  .byte $66, $FF

L9BEE:  .byte $69, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9BF0:  .word $9DD8, $9DDD, $9DE2, $9DE7, $9DFA, $9E0E, $9E24, $9E3A
L9C00:  .word $9E4D, $9E61, $9E77, $9E8D, $9E97, $9E9C, $9EA1, $9EA6
L9C10:  .word $9EAB, $9EB0, $9EB5, $9EBA, $9EBF, $9EBF, $9EBF, $9EBF
L9C20:  .word $9ECE, $9EDD, $9EEE, $9EFF, $9F07, $9F07, $9F07, $9F07
L9C30:  .word $9F07, $9F07, $9F0F, $9F17, $9F17, $9F17, $9F17, $9F17
L9C40:  .word $9F23, $9F31, $9F3F, $9F4D, $9F59, $9F67, $9F75, $9F83
L9C50:  .word $9F8E, $9F9C, $9FAA, $9FB6, $9FC4, $9FD2, $9FDE, $9FDE
L9C60:  .word $9FF2, $A006, $A006, $A006, $A006, $A006, $A006, $A006
L9C70:  .word $A006, $A006, $A006, $A00B, $A013, $A01B, $A01B, $A01B
L9C80:  .word $A01B, $A01B, $A01B, $A01B, $A01B, $A01B, $A01B, $A01B
L9C90:  .word $A01B, $A01B, $A01B, $A01B, $A01B, $A01B, $A01B, $A01B
L9CA0:  .word $A01B, $A027, $A033, $A03F, $A04B, $A057, $A063, $A06F
L9CB0:  .word $A07B, $A083, $A091, $A0AB, $A0AB, $A0AB, $A0AB, $A0B3
L9CC0:  .word $A0BB, $A0C3, $A0CB, $A0D3, $A0DB, $A0DB, $A0DB, $A0DB
L9CD0:  .word $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB
L9CE0:  .word $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB

EnemyFramePtrTbl2:
L9CF0:  .word $A0DB, $A0E1, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9D00:  .word $A0E6, $A0E6

EnemyPlacePtrTbl:
L9D04:  .word $9D22, $9D24, $9D3C, $9D60, $9D72, $9D64, $9D6E, $9D76
L9D14:  .word $9D82, $9D8A, $9D8A, $9DAA, $9DB8, $9DBC, $9DCC

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9D22:  .byte $FC, $FC

L9D24:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9D34:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9D3C:  .byte $EC, $F8, $EC, $00, $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $E8, $04, $F0
L9D4C:  .byte $04, $F8, $04, $00, $0C, $F0, $0C, $F8, $0C, $00, $F4, $F4, $F4, $EC, $FC, $F4
L9D5C:  .byte $12, $E8, $14, $F8

L9D60:  .byte $F4, $F4, $F4, $04

L9D64:  .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

L9D6E:  .byte $FC, $F8, $FC, $00

L9D72:  .byte $F0, $F8, $F0, $00

L9D76:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

L9D82:  .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

L9D8A:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9D9A:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9DAA:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9DB8:  .byte $F8, $FC, $00, $FC

L9DBC:  .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9DCC:  .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

;Enemy frame drawing data.

L9DD8:  .byte $00, $02, $02, $14, $FF

L9DDD:  .byte $00, $02, $02, $24, $FF

L9DE2:  .byte $00, $00, $00, $04, $FF

L9DE7:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9DF7:  .byte $F9, $F8, $FF

L9DFA:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9D0A:  .byte $D8, $FE, $E8, $FF

L9E0E:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E1E:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9E24:  .byte $22, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E34:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9E3A:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E4A:  .byte $F9, $F8, $FF

L9E4D:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E5D:  .byte $D8, $FE, $E8, $FF

L9E61:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E71:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9E77:  .byte $62, $13, $14, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E87:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9E8D:  .byte $21, $00, $00, $C6, $C7, $D6, $D7, $E6, $E7, $FF

L9E97:  .byte $30, $07, $07, $EC, $FF

L9E9C:  .byte $30, $07, $07, $FB, $FF

L9EA1:  .byte $F0, $07, $07, $EC, $FF

L9EA6:  .byte $F0, $07, $07, $FB, $FF

L9EAB:  .byte $70, $07, $07, $EC, $FF

L9EB0:  .byte $70, $07, $07, $FB, $FF

L9EB5:  .byte $B0, $07, $07, $EC, $FF

L9EBA:  .byte $B0, $07, $07, $FB, $FF

L9EBF:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DF, $FD, $62, $DF, $FF

L9ECE:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DE, $FD, $62, $DE, $FF

L9EDD:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DF, $FD, $E2, $DF
L9EED:  .byte $FF

L9EEE:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DE, $FD, $E2, $DE
L9EFE:  .byte $FF

L9EFF:  .byte $21, $00, $00, $CE, $CE, $DF, $DF, $FF

L9F07:  .byte $29, $04, $08, $E6, $FD, $62, $E6, $FF

L9F0F:  .byte $29, $04, $08, $E5, $FD, $62, $E5, $FF, $27, $08, $08, $EE, $EF

L9F17:  .byte $FD, $E2, $EF, $FD, $A2, $EF, $FF

L9F23:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $ED, $FD, $A2, $EF, $FF

L9F31:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $FD, $E2, $EF, $EE, $FF

L9F3F:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $E2, $ED, $EF, $FD, $A2, $EF, $FF

L9F4D:  .byte $67, $08, $08, $EE, $EF, $FD, $A2, $EF, $FD, $E2, $EF, $FF

L9F59:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $ED, $FD, $E2, $EF, $FF

L9F67:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $FD, $A2, $EF, $EE, $FF

L9F75:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $A2, $ED, $EF, $FD, $E2, $EF, $FF

L9F83:  .byte $21, $00, $00, $FC, $04, $00, $EE, $EF, $EF, $EF, $FF

L9F8E:  .byte $2D, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $62, $E2, $F2, $FF

L9F9C:  .byte $2D, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $62, $E4, $F2, $FF

L9FAA:  .byte $2E, $08, $0A, $F4, $F2, $E3, $F3, $FD, $62, $F4, $F2, $FF

L9FB6:  .byte $AD, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $E2, $E2, $F2, $FF

L9FC4:  .byte $AD, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $E2, $E4, $F2, $FF

L9FD2:  .byte $AE, $08, $0A, $F4, $F2, $E3, $F3, $FD, $E2, $F4, $F2, $FF

L9FDE:  .byte $21, $00, $00, $FC, $08, $FC, $E2, $FC, $00, $08, $E2, $FC, $00, $F8, $F2, $FC
L9FEE:  .byte $00, $08, $F2, $FF

L9FF2:  .byte $21, $00, $00, $FC, $00, $FC, $F2, $FC, $00, $08, $F2, $FC, $00, $F8, $E2, $FC
LA002:  .byte $00, $08, $E2, $FF

LA006:  .byte $20, $04, $04, $C0, $FF

LA00B:  .byte $20, $00, $00, $FC, $F8, $00, $D0, $FF

LA013:  .byte $23, $00, $00, $D1, $FD, $62, $D1, $FF

LA01B:  .byte $27, $08, $08, $CC, $FD, $62, $CC, $FD, $22, $DC, $DD, $FF

LA027:  .byte $67, $08, $08, $FD, $22, $CD, $FD, $62, $CD, $DC, $DD, $FF

LA033:  .byte $27, $08, $08, $FD, $A2, $DA, $FD, $22, $CB, $DA, $DB, $FF

LA03F:  .byte $A7, $08, $08, $CA, $CB, $FD, $22, $CA, $FD, $A2, $DB, $FF

LA04B:  .byte $A7, $08, $08, $CC, $FD, $E2, $CC, $FD, $A2, $DC, $DD, $FF

LA057:  .byte $E7, $08, $08, $FD, $A2, $CD, $FD, $E2, $CD, $DC, $DD, $FF

LA063:  .byte $67, $08, $08, $FD, $E2, $DA, $FD, $62, $CB, $DA, $DB, $FF

LA06F:  .byte $E7, $08, $08, $CA, $CB, $FD, $62, $CA, $FD, $E2, $DB, $FF

LA07B:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA083:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA091:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA0A1:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA0AB:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA0B3:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0BB:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0C3:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA0CB:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0D3:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA0DB:  .byte $0C, $08, $04, $14, $24, $FF

A0E1:   .byte $00, $04, $04, $8A, $FF

A0E6:   .byte $00, $04, $04, $8A, $FF


;------------------------------------------[ Palette data ]------------------------------------------

Palette00:
LA0EB:  .byte $3F                       ;Upper byte of PPU palette adress.
LA0EC:  .byte $00                       ;Lower byte of PPU palette adress.
LA0ED:  .byte $20                       ;Palette data length.
;The following values are written to the background palette:
LA0EE:  .byte $0F, $20, $10, $00, $0F, $21, $14, $13, $0F, $28, $1B, $02, $0F, $15, $16, $04
;The following values are written to the sprite palette:
LA0FE:  .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $14, $13, $29, $0F, $13, $15, $27

LA10E:  .byte $00                       ;End Palette00 info.

Palette01:
LA10F:  .byte $3F                       ;Upper byte of PPU palette adress.
LA110:  .byte $12                       ;Lower byte of PPU palette adress.
LA111:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA112:  .byte $19, $27

LA114:  .byte $00                       ;End Palette01 info.

Palette03:
LA115:  .byte $3F                       ;Upper byte of PPU palette adress.
LA116:  .byte $12                       ;Lower byte of PPU palette adress.
LA117:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA118:  .byte $2C, $27

LA11A:  .byte $00                       ;End Palette03 info.

Palette02:
LA11B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA11C:  .byte $12                       ;Lower byte of PPU palette adress.
LA11D:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA11E:  .byte $19, $35

LA120:  .byte $00                       ;End Palette02 info.

Palette04:
LA121:  .byte $3F                       ;Upper byte of PPU palette adress.
LA122:  .byte $12                       ;Lower byte of PPU palette adress.
LA123:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA124:  .byte $2C, $24

LA126:  .byte $00                       ;End Palette04 info.

Palette05:
LA127:  .byte $3F                       ;Upper byte of PPU palette adress.
LA128:  .byte $00                       ;Lower byte of PPU palette adress.
LA129:  .byte $10                       ;Palette data length.
;The following values are written to the background palette:
LA12A:  .byte $0F, $20, $16, $04, $0F, $21, $14, $13, $0F, $27, $16, $02, $0F, $15, $16, $04

LA13A:  .byte $00                       ;End Palette05 info.

Palette06:
LA13B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA13C:  .byte $11                       ;Lower byte of PPU palette adress.
LA13D:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA13E:  .byte $04, $09, $07

LA141:  .byte $00                       ;End Palette06 info.

Palette07:
LA142:  .byte $3F                       ;Upper byte of PPU palette adress.
LA143:  .byte $11                       ;Lower byte of PPU palette adress.
LA144:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA145:  .byte $05, $09, $17

LA148:  .byte $00                       ;End Palette07 info.

Palette08:
LA149:  .byte $3F                       ;Upper byte of PPU palette adress.
LA14A:  .byte $11                       ;Lower byte of PPU palette adress.
LA14B:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA14C:  .byte $06, $0A, $26

LA14F:  .byte $00                       ;End Palette08 info.

Palette09:
LA150:  .byte $3F                       ;Upper byte of PPU palette adress.
LA151:  .byte $11                       ;Lower byte of PPU palette adress.
LA152:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA153:  .byte $16, $19, $27

LA156:  .byte $00                       ;End Palette09 info.

Palette0A:
LA157:  .byte $3F                       ;Upper byte of PPU palette adress.
LA158:  .byte $00                       ;Lower byte of PPU palette adress.
LA159:  .byte $04                       ;Palette data length.
;The following values are written to the background palette:
LA15A:  .byte $0F, $30, $30, $21

LA15E:  .byte $00                       ;End Palette0A info.

Palette0B:
LA15F:  .byte $3F                       ;Upper byte of PPU palette adress.
LA160:  .byte $10                       ;Lower byte of PPU palette adress.
LA161:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA162:  .byte $0F, $15, $34, $17

LA166:  .byte $00                       ;End Palette0B info.

Palette0C:
LA167:  .byte $3F                       ;Upper byte of PPU palette adress.
LA168:  .byte $10                       ;Lower byte of PPU palette adress.
LA169:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA16A:  .byte $0F, $15, $34, $19

LA16E:  .byte $00                       ;End Palette0C info.

Palette0D:
LA16F:  .byte $3F                       ;Upper byte of PPU palette adress.
LA170:  .byte $10                       ;Lower byte of PPU palette adress.
LA171:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA172:  .byte $0F, $15, $34, $28

LA176:  .byte $00                       ;End Palette0D info.

Palette0E:
LA177:  .byte $3F                       ;Upper byte of PPU palette adress.
LA178:  .byte $10                       ;Lower byte of PPU palette adress.
LA179:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA17A:  .byte $0F, $15, $34, $29

LA17E:  .byte $00                       ;End Palette0E info.

;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
LA17F:  .word $A23F, $A23F, $A247, $A273, $A29E, $A2B2, $A2E4, $A30F
LA18F:  .word $A34D, $A383, $A3B8, $A3F9, $A429, $A455, $A48C, $A4C3
LA19F:  .word $A4F6, $A525, $A555, $A5A1, $A5E5, $A618, $A653, $A67C
LA1AF:  .word $A6A9, $A6D6, $A6FF, $A72C, $A76B, $A79D, $A7CF, $A7FC
LA1BF:  .word $A826, $A849, $A867, $A88D, $A8BF, $A8EC, $A92A, $A95D
LA1CF:  .word $A97B, $A9A5

StrctPtrTbl:
LA1D3:  .word $A9BF, $A9D2, $A9D9, $A9E0, $A9F9, $A9FD, $AA02, $AA07
LA1E3:  .word $AA17, $AA2C, $AA32, $AA3D, $AA57, $AA64, $AA6D, $AA78
LA1F3:  .word $AA83, $AA86, $AA8C, $AA96, $AAAB, $AAC7, $AAD2, $AAD9
LA203:  .word $AAEE, $AB0A, $AB11, $AB1A, $AB1D

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

;Missiles.
LA20D:  .byte $18
LA20E:  .word $A21B
LA210:  .byte $12, $06, $02, $09, $6D, $00

;Elevator to Norfair.
LA216:  .byte $19, $FF, $04, $84, $00

;Energy tank.
LA21B:  .byte $19
LA21C:  .word $A224
LA21E:  .byte $11, $FF, $02, $08, $74, $0

;Missiles.
LA224:  .byte $1B
LA225:  .word $A22D
LA227:  .byte $18, $FF, $02, $09, $6D, $00

;Energy tank.
LA22D:  .byte $1D
LA22E:  .word $A236
LA230:  .byte $0F, $FF, $02, $08, $66, $00

;Missiles.
LA236:  .byte $1E
LA237:  .word $FFFF
LA239:  .byte $14, $FF, $02, $09, $6D, $00

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
LA23F:  .byte $02                       ;Attribute table data.
;Room object data:
LA240:  .byte $07, $03, $02, $87, $03, $02, $FF

;Room #$01
LA247:  .byte $03                       ;Attribute table data.
;Room object data:
LA248:  .byte $00, $07, $03, $01, $08, $03, $06, $09, $03, $0B, $08, $03, $0E, $07, $03, $50
LA258:  .byte $07, $03, $5E, $07, $03, $93, $0A, $00, $96, $09, $03, $9C, $0A, $00, $A0, $07
LA268:  .byte $03, $AE, $07, $03, $E2, $08, $03, $EA, $08, $03, $FF

;Room #$02
LA273:  .byte $03                       ;Attribute table data.
;Room object data:
LA274:  .byte $00, $07, $03, $0E, $07, $03, $46, $08, $03, $50, $01, $02, $5F, $01, $02, $80
LA284:  .byte $08, $03, $84, $09, $03, $88, $09, $03, $8C, $08, $03, $B0, $08, $03, $BC, $08
LA294:  .byte $03, $D4, $00, $03, $FD
;Room enemy/door data:
LA299:  .byte $02, $A1, $02, $B1, $FF

;Room #$03
LA29E:  .byte $03                       ;Attribute table data.
;Room object data:
LA29F:  .byte $00, $07, $03, $0E, $07, $03, $50, $07, $03, $5E, $07, $03, $A0, $07, $03, $AE
LA2AF:  .byte $07, $03, $FF

;Room #$04
LA2B2:  .byte $03                       ;Attribute table data.
;Room object data:
LA2B3:  .byte $00, $08, $03, $04, $08, $03, $08, $08, $03, $0C, $08, $03, $40, $08, $03, $44
LA2C3:  .byte $08, $03, $48, $08, $03, $4C, $08, $03, $70, $08, $03, $74, $08, $03, $78, $08
LA2D3:  .byte $03, $7C, $08, $03, $B0, $08, $03, $B4, $08, $03, $B8, $08, $03, $BC, $08, $03
LA2E3:  .byte $FF

;Room #$05
LA2E4:  .byte $03                       ;Attribute table data.
;Room object data:
LA2E5:  .byte $00, $07, $03, $05, $08, $03, $0E, $07, $03, $50, $01, $02, $5F, $01, $02, $68
LA2F5:  .byte $08, $03, $80, $07, $03, $82, $09, $03, $8C, $09, $03, $8E, $07, $03, $AE, $07
LA305:  .byte $03, $B0, $07, $03, $FD
;Room enemy/door data:
LA30A:  .byte $02, $A1, $02, $B1, $FF

;Room #$06
LA30F:  .byte $03                       ;Attribute table data.
;Room object data:
LA310:  .byte $00, $07, $03, $0E, $07, $03, $26, $04, $03, $35, $09, $03, $50, $01, $02, $5E
LA320:  .byte $07, $03, $80, $07, $03, $82, $09, $03, $89, $09, $03, $AE, $07, $03, $B2, $05
LA330:  .byte $01, $C4, $09, $03, $D0, $07, $03, $DC, $04, $03, $EB, $09, $03, $FD
;Room enemy/door data:
LA33E:  .byte $02, $B1, $07, $87, $27, $17, $87, $DD, $21, $86, $B5, $31, $86, $7B, $FF

;Room #$07
LA34D:  .byte $03                       ;Attribute table data.
;Room object data:
LA34E:  .byte $00, $07, $03, $0E, $07, $03, $22, $05, $01, $26, $09, $03, $50, $07, $03, $5E
LA35E:  .byte $07, $03, $62, $09, $03, $79, $09, $03, $95, $04, $03, $A0, $07, $03, $A4, $09
LA36E:  .byte $03, $AE, $07, $03, $E8, $09, $03, $FD
;Room enemy/door data:
LA376:  .byte $51, $06, $17, $01, $86, $6B, $11, $86, $DA, $27, $87, $96, $FF

;Room #$08
LA383:  .byte $03                       ;Attribute table data.
;Room object data:
LA384:  .byte $00, $07, $03, $0E, $07, $03, $26, $09, $03, $2D, $06, $01, $50, $01, $02, $5C
LA394:  .byte $09, $03, $5E, $07, $03, $80, $08, $03, $84, $08, $03, $88, $08, $03, $8C, $08
LA3A4:  .byte $03, $C0, $08, $03, $CC, $08, $03, $D4, $00, $03, $FD
;Room enemy/door data:
LA3AF:  .byte $02, $B1, $31, $86, $18, $41, $86, $78, $FF

;Room #$09
LA3B8:  .byte $00                       ;Attribute table data.
;Room object data:
LA3B9:  .byte $00, $07, $03, $07, $19, $00, $0E, $07, $03, $45, $19, $00, $4C, $19, $00, $50
LA3C9:  .byte $07, $03, $5F, $01, $02, $72, $19, $00, $8C, $09, $03, $8E, $07, $03, $A0, $07
LA3D9:  .byte $03, $AB, $19, $00, $B4, $19, $00, $BE, $07, $03, $E8, $19, $00, $FD
;Room enemy/door data:
LA3E7:  .byte $02, $A1, $01, $06, $34, $11, $86, $3C, $21, $06, $9B, $31, $86, $A4, $51, $86
LA3F7:  .byte $D8, $FF

;Room #$0A
LA3F9:  .byte $03                       ;Attribute table data.
;Room object data:
LA3FA:  .byte $00, $07, $03, $0E, $07, $03, $16, $19, $00, $50, $07, $03, $53, $19, $00, $5E
LA40A:  .byte $07, $03, $86, $19, $00, $A0, $07, $03, $AE, $07, $03, $B9, $19, $00, $BD, $06
LA41A:  .byte $01, $FD
;Room enemy/door data:
LA41C:  .byte $41, $86, $06, $01, $06, $43, $11, $86, $76, $21, $86, $A9, $FF

;Room #$0B
LA429:  .byte $03                       ;Attribute table data.
;Room object data:
LA42A:  .byte $00, $07, $03, $0E, $07, $03, $50, $07, $03, $5F, $01, $02, $80, $08, $03, $84
LA43A:  .byte $08, $03, $88, $09, $03, $8C, $08, $03, $C0, $08, $03, $CC, $08, $03, $D4, $00
LA44A:  .byte $03, $FD
;Room enemy/door data:
LA44C:  .byte $02, $A1, $31, $82, $74, $41, $82, $79, $FF

;Room #$0C
LA455:  .byte $00                       ;Attribute table data.
;Room object data:
LA456:  .byte $00, $0B, $00, $04, $0B, $00, $08, $0B, $00, $0C, $0B, $00, $50, $01, $02, $5F
LA466:  .byte $01, $02, $80, $0B, $00, $82, $0B, $00, $86, $0C, $00, $88, $0B, $00, $8C, $0B
LA476:  .byte $00, $C0, $0B, $00, $C2, $0B, $00, $C6, $0C, $00, $D8, $0B, $00, $DC, $0B, $00
LA486:  .byte $FD
;Room enemy/door data:
LA487:  .byte $02, $A0, $02, $B1, $FF

;Room #$0D
LA48C:  .byte $00                       ;Attribute table data.
;Room object data:
LA48D:  .byte $00, $0B, $00, $04, $0B, $00, $08, $0B, $00, $0C, $0B, $00, $0E, $0D, $00, $1E
LA49D:  .byte $0D, $00, $50, $01, $02, $5F, $01, $02, $80, $0B, $00, $84, $0B, $00, $88, $0B
LA4AD:  .byte $00, $8C, $0B, $00, $C0, $0B, $00, $C4, $0B, $00, $C8, $0B, $00, $CC, $0B, $00
LA4BD:  .byte $FD
;Room enemy/door data:
LA4BE:  .byte $02, $A1, $02, $B1, $FF

;Room #$0E
LA4C3:  .byte $00                       ;Attribute table data.
;Room object data:
LA4C4:  .byte $00, $0E, $00, $04, $0E, $00, $08, $0E, $00, $0C, $0E, $00, $7D, $0A, $00, $B0
LA4D4:  .byte $0B, $00, $B4, $0B, $00, $B8, $0C, $00, $B9, $0B, $00, $BE, $0B, $00, $BF, $0C
LA4E4:  .byte $00, $D0, $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA4EC:  .byte $51, $80, $27, $01, $02, $A4, $11, $02, $AA, $FF

;Room #$0F
LA4F6:  .byte $00                       ;Attribute table data.
;Room object data:
LA4F7:  .byte $00, $0E, $00, $04, $0E, $00, $08, $0E, $00, $0B, $0E, $00, $0F, $0A, $00, $5F
LA507:  .byte $02, $02, $8C, $08, $03, $CC, $08, $03, $D0, $0F, $03, $D4, $00, $03, $D8, $0F
LA517:  .byte $03, $FD
;Room enemy/door data:
LA519:  .byte $02, $A2, $51, $80, $27, $21, $80, $29, $11, $80, $2B, $FF

;Room #$10
LA525:  .byte $03                       ;Attribute table data.
;Room object data:
LA526:  .byte $00, $08, $03, $04, $08, $03, $08, $0E, $00, $0C, $0E, $00, $40, $08, $03, $42
LA536:  .byte $0B, $00, $70, $08, $03, $72, $0B, $00, $76, $0A, $00, $B0, $08, $03, $B4, $08
LA546:  .byte $03, $D8, $0F, $03, $DC, $0F, $03, $FD
;Room enemy/door data:
LA54E:  .byte $31, $80, $2E, $41, $80, $2B, $FF

;Room #$11
LA555:  .byte $03                       ;Attribute table data.
;Room object data:
LA556:  .byte $00, $07, $03, $02, $11, $03, $06, $11, $03, $0A, $11, $03, $0E, $07, $03, $13
LA566:  .byte $10, $03, $14, $12, $03, $1C, $10, $03, $22, $0A, $00, $50, $02, $02, $5F, $02
LA576:  .byte $02, $80, $07, $03, $84, $11, $03, $8F, $07, $03, $92, $19, $00, $95, $11, $03
LA586:  .byte $99, $11, $03, $AE, $19, $00, $C0, $07, $03, $D2, $00, $03, $D7, $00, $03, $DF
LA596:  .byte $07, $03, $FD
;Room enemy/door data:
LA599:  .byte $02, $A1, $02, $B2, $01, $49, $66, $FF

;Room #$12
LA5A1:  .byte $01                       ;Attribute table data.
;Room object data:
LA5A2:  .byte $00, $07, $03, $01, $0E, $00, $05, $0E, $00, $09, $0E, $00, $0D, $0E, $00, $22
LA5B2:  .byte $11, $03, $26, $11, $03, $50, $02, $02, $80, $07, $03, $81, $11, $03, $8B, $0A
LA5C2:  .byte $00, $A7, $0A, $00, $B0, $07, $03, $BF, $0A, $00, $D2, $00, $03, $DA, $00, $03
LA5D2:  .byte $FD
;Room enemy/door data:
LA5D3:  .byte $02, $B1, $11, $86, $97, $21, $06, $7B, $31, $86, $AF, $41, $80, $35, $51, $83
LA5E3:  .byte $3E, $FF

;Room #$13
LA5E5:  .byte $01                       ;Attribute table data.
;Room object data:
LA5E6:  .byte $00, $0E, $00, $04, $0E, $00, $08, $0E, $00, $0C, $0E, $00, $86, $0A, $00, $8A
LA5F6:  .byte $0A, $00, $A2, $0A, $00, $A3, $0A, $00, $BE, $0A, $00, $D0, $00, $03, $D8, $00
LA606:  .byte $03, $FD
;Room enemy/door data:
LA608:  .byte $01, $86, $92, $11, $86, $76, $21, $86, $7A, $31, $06, $AE, $41, $80, $27, $FF

;Room #$14
LA618:  .byte $01                       ;Attribute table data.
;Room object data:
LA619:  .byte $00, $0E, $00, $04, $0E, $00, $08, $0E, $00, $0C, $0B, $00, $5F, $01, $02, $85
LA629:  .byte $0A, $00, $86, $0A, $00, $8C, $11, $03, $9E, $07, $03, $A2, $0A, $00, $B9, $0A
LA639:  .byte $00, $CE, $07, $03, $D0, $00, $03, $D6, $00, $03, $FD
;Room enemy/door data:
LA644:  .byte $02, $A1, $51, $86, $92, $01, $86, $75, $21, $80, $23, $31, $80, $28, $FF

;Room #$15
LA653:  .byte $01                       ;Attribute table data.
;Room object data:
LA654:  .byte $00, $14, $01, $08, $14, $01, $10, $13, $01, $50, $01, $02, $80, $13, $01, $94
LA664:  .byte $05, $01, $C0, $14, $01, $CA, $14, $01, $D8, $00, $03, $FD
;Room enemy/door data:
LA670:  .byte $02, $B1, $41, $80, $37, $51, $80, $3C, $01, $80, $3E, $FF

;Room #$16
LA67C:  .byte $01                       ;Attribute table data.
;Room object data:
LA67D:  .byte $00, $14, $01, $08, $14, $01, $30, $14, $01, $38, $14, $01, $90, $14, $01, $92
La68D:  .byte $04, $03, $94, $04, $03, $98, $14, $01, $9B, $04, $03, $C0, $14, $01, $C8, $14
LA69D:  .byte $01, $FD
;Room enemy/door data:
LA69F:  .byte $17, $87, $93, $27, $07, $95, $37, $87, $9C, $FF

;Room #$17
LA6A9:  .byte $01                       ;Attribute table data.
;Room object data:
LA6AA:  .byte $00, $14, $01, $08, $14, $01, $30, $14, $01, $38, $14, $01, $52, $13, $01, $5A
LA6BA:  .byte $13, $01, $61, $06, $01, $C0, $14, $01, $C3, $04, $03, $C8, $14, $01, $CB, $04
LA6CA:  .byte $03, $FD
;Room enemy/door data:
LA6CC:  .byte $47, $87, $C4, $57, $87, $CC, $01, $80, $67, $FF

;Room #$18
LA6D6:  .byte $01                       ;Attribute table data.
;Room object data:
LA6D7:  .byte $00, $14, $01, $08, $14, $01, $1C, $13, $01, $5F, $01, $02, $8C, $13, $01, $C0
LA6E7:  .byte $14, $01, $CA, $14, $01, $D0, $00, $03, $D5, $00, $03, $FD
;Room enemy/door data:
LA6F3:  .byte $02, $A1, $11, $80, $33, $21, $00, $35, $31, $80, $37, $FF

;Room #$19
LA6FF:  .byte $00                       ;Attribute table data.
;Room object data:
LA700:  .byte $00, $14, $01, $08, $14, $01, $30, $14, $01, $38, $14, $01, $D0, $00, $03, $D2
LA710:  .byte $13, $01, $D7, $13, $01, $D8, $04, $03, $DB, $00, $03, $DC, $13, $01, $FD
;Room enemy/door data:
LA71E:  .byte $41, $00, $64, $51, $80, $68, $01, $00, $6C, $17, $87, $D9, $FF

;Room #$1A
LA72C:  .byte $01                       ;Attribute table data.
;Room object data:
LA72D:  .byte $00, $14, $01, $08, $14, $01, $30, $13, $01, $34, $13, $01, $38, $13, $01, $3C
LA73D:  .byte $13, $01, $40, $16, $01, $41, $15, $01, $44, $15, $01, $48, $15, $01, $4C, $15
LA74D:  .byte $01, $4F, $16, $01, $90, $14, $01, $92, $04, $03, $98, $14, $01, $9B, $04, $03
LA75D:  .byte $C0, $14, $01, $C8, $14, $01, $FD
;Room enemy/door data:
LA764:  .byte $27, $87, $93, $37, $87, $9C, $FF

;Room #$1B
LA76B:  .byte $02                       ;Attribute table data.
;Room object data:
LA76C:  .byte $00, $18, $02, $08, $18, $02, $20, $18, $02, $28, $0A, $00, $50, $01, $02, $5F
LA77C:  .byte $19, $00, $80, $17, $02, $8C, $19, $00, $C0, $18, $02, $CA, $18, $02, $D8, $00
LA78C:  .byte $03, $FD
;Room enemy/door data:
LA78E:  .byte $02, $B1, $01, $8C, $39, $11, $0C, $3D, $21, $8C, $6B, $31, $0C, $66, $FF

;Room #$1C
LA79D:  .byte $02                       ;Attribute table data.
;Room object data:
LA79E:  .byte $00, $18, $02, $08, $18, $02, $28, $18, $02, $5F, $01, $02, $70, $19, $00, $8C
LA7AE:  .byte $17, $02, $94, $19, $00, $B8, $17, $02, $BC, $17, $02, $C0, $18, $02, $D0, $00
LA7BE:  .byte $03, $FD
;Room enemy/door data:
LA7C0:  .byte $02, $A1, $01, $8C, $33, $11, $0C, $36, $41, $8C, $92, $51, $0C, $A6, $FF

;Room #$1D
LA7CF:  .byte $00                       ;Attribute table data.
;Room object data:
LA7D0:  .byte $00, $18, $02, $08, $18, $02, $30, $0A, $00, $49, $19, $00, $55, $0A, $00, $5D
LA7E0:  .byte $0A, $00, $A0, $18, $02, $A8, $18, $02, $D0, $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA7F1:  .byte $21, $8C, $38, $31, $0C, $97, $41, $8C, $99, $51, $0C, $9B, $FF

;Room #$1E
LA7FC:  .byte $02                       ;Attribute table data.
;Room object data:
LA7FD:  .byte $00, $17, $02, $04, $17, $02, $08, $17, $02, $0C, $17, $02, $70, $17, $02, $74
LA80D:  .byte $17, $02, $78, $17, $02, $7C, $17, $02, $D0, $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA81C:  .byte $01, $8C, $42, $11, $0C, $45, $21, $8C, $48, $FF

;Room #$1F
LA826:  .byte $00                       ;Attribute table data.
;Room object data:
LA827:  .byte $00, $0B, $00, $04, $18, $02, $0C, $0B, $00, $50, $01, $02, $80, $0B, $00, $C0
LA837:  .byte $18, $02, $C8, $18, $02, $FD
;Room enemy/door data:
LA83D:  .byte $02, $B1, $21, $82, $5B, $31, $03, $85, $41, $83, $88, $FF

;Room #$20
LA849:  .byte $02                       ;Attribute table data.
;Room object data:
LA84A:  .byte $20, $18, $02, $28, $18, $02, $A0, $18, $02, $A8, $18, $02, $D0, $00, $03, $D8
LA85A:  .byte $00, $03, $FD
;Room enemy/door data:
LA85D:  .byte $01, $82, $98, $11, $02, $9E, $41, $83, $53, $FF

;Room #$21
LA867:  .byte $00                       ;Attribute table data.
;Room object data:
LA868:  .byte $00, $0B, $00, $04, $18, $02, $0C, $0B, $00, $5F, $01, $02, $8C, $0B, $00, $C0
LA878:  .byte $18, $02, $C8, $18, $02, $FD
;Room enemy/door data:
LA87E:  .byte $02, $A1, $11, $02, $57, $31, $83, $85, $41, $83, $88, $51, $03, $8A, $FF

;Room #$22
LA88D:  .byte $00                       ;Attribute table data.
;Room object data:
LA88E:  .byte $00, $07, $03, $02, $12, $03, $0A, $12, $03, $50, $01, $02, $80, $07, $03, $82
LA89E:  .byte $0B, $00, $8F, $0B, $00, $B0, $07, $03, $B9, $0B, $00, $D2, $00, $03, $DA, $00
LA8AE:  .byte $03, $FD
;Room enemy/door data:
LA8B0:  .byte $02, $B1, $01, $80, $18, $11, $80, $1E, $21, $86, $AB, $31, $86, $7F, $FF

;Room #$23
LA8BF:  .byte $01                       ;Attribute table data.
;Room object data:
LA8C0:  .byte $00, $12, $03, $08, $12, $03, $92, $04, $03, $94, $04, $03, $99, $0B, $00, $A2
LA8D0:  .byte $0B, $00, $BF, $0B, $00, $D0, $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA8DC:  .byte $07, $87, $93, $11, $00, $1A, $21, $80, $1F, $47, $87, $95, $51, $86, $8B, $FF

;Room #$24
LA8EC:  .byte $02                       ;Attribute table data.
;Room object data:
LA8ED:  .byte $00, $0B, $00, $04, $0E, $00, $08, $0E, $00, $0C, $0E, $00, $37, $0A, $00, $50
LA8FD:  .byte $01, $02, $77, $0A, $00, $80, $17, $02, $8D, $1A, $01, $C0, $18, $02, $C4, $1B
LA90D:  .byte $02, $C8, $18, $02, $D4, $1C, $02, $D8, $1C, $02, $DC, $1C, $02, $FD
;Room enemy/door data:
LA91B:  .byte $02, $B0, $01, $82, $27, $11, $82, $2B, $21, $83, $B5, $31, $83, $BA, $FF

;Room #$25
LA92A:  .byte $02                       ;Attribute table data.
;Room object data:
LA92B:  .byte $00, $0E, $00, $04, $0E, $00, $08, $0E, $00, $0C, $0E, $00, $87, $1A, $01, $C0
LA93B:  .byte $18, $02, $C8, $18, $02, $CF, $1B, $02, $D0, $1C, $02, $D4, $1C, $02, $D8, $1C
LA94B:  .byte $02, $DC, $1C, $02, $FD
;Room enemy/door data:
LA950:  .byte $21, $82, $26, $31, $02, $2B, $41, $83, $B3, $51, $03, $BC, $FF

;Room #$26
LA95D:  .byte $01                       ;Attribute table data.
;Room object data:
LA95E:  .byte $00, $14, $01, $08, $14, $01, $B2, $04, $03, $C0, $14, $01, $C9, $14, $01, $D0
LA96E:  .byte $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA974:  .byte $07, $87, $B3, $11, $03, $29, $FF

;Room #$27
LA97B:  .byte $01                       ;Attribute table data.
;Room object data:
LA97C:  .byte $00, $14, $01, $08, $14, $01, $10, $0A, $00, $60, $0A, $00, $B0, $0A, $00, $B5
LA98C:  .byte $04, $03, $C1, $14, $01, $CA, $14, $01, $D1, $00, $03, $D8, $00, $03, $FD
;Room enemy/door data:
LA99B:  .byte $27, $87, $B6, $11, $82, $B7, $11, $80, $27, $FF

;Room #$28
LA9A5:  .byte $00                       ;Attribute table data.
;Room object data:
LA9A6:  .byte $00, $0B, $00, $0C, $0B, $00, $50, $01, $02, $5C, $0B, $00, $80, $0B, $00, $AF
LA9B6:  .byte $0B, $00, $D0, $0B, $00, $FD
;Room enemy/door data:
LA9BC:  .byte $02, $B1, $FF

;---------------------------------------[ Structure definitions ]------------------------------------

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LA9BF:  .byte $08, $00, $00, $00, $00, $00, $00, $00, $00, $08, $01, $01, $01, $01, $01, $01
LA9CF:  .byte $01, $01, $FF

;Structure #$01
LA9D2:  .byte $01, $12, $01, $12, $01, $12, $FF

;Structure #$02
LA9D9:  .byte $01, $13, $01, $13, $01, $13, $FF

;Structure #$03
LA9E0:  .byte $02, $02, $03, $02, $02, $03, $02, $02, $03, $02, $02, $03, $02, $02, $03
LA9F0:  .byte $02, $02, $03, $02, $02, $03, $02, $02, $03, $FF

;Structure #$04
LA9F9:  .byte $02, $06, $07, $FF

;Structure #$05
LA9FD:  .byte $01, $0A, $01, $0A, $FF

;Structure #$06
LAA02:  .byte $01, $0B, $01, $0B, $FF

;Structure #$07
LAA07:  .byte $02, $08, $08, $02, $08, $05, $02, $09, $08, $02, $08, $08, $02, $05, $08, $FF

;Structure #$08
LAA17:  .byte $04, $08, $08, $08, $08, $04, $08, $09, $09, $08, $04, $08, $09, $09, $08, $04
LAA27:  .byte $08, $08, $08, $08, $FF

;Structure #$09
LAA2C:  .byte $04, $08, $09, $09, $08, $FF

;Structure #$0A
LAA32:  .byte $01, $14, $01, $05, $01, $05, $01, $05, $01, $14, $FF

;Structure #$0B
LAA3D:  .byte $04, $15, $15, $15, $15, $04, $15, $15, $15, $15, $04, $15, $15, $15, $15, $04
LAA4D:  .byte $15, $15, $15, $15, $04, $15, $15, $15, $15, $FF

;Structure #$0C
LAA57:  .byte $02, $16, $16, $02, $16, $16, $02, $16, $16, $02, $16, $16, $FF

;Structure #$0D
LAA64:  .byte $01, $17, $01, $17, $01, $17, $01, $17, $FF

;Structure #$0E
LAA6D:  .byte $04, $11, $11, $11, $11, $04, $11, $11, $11, $11, $FF

;Structure #$0F
LAA78:  .byte $04, $18, $18, $18, $18, $04, $19, $19, $19, $19, $FF

;Structure #$10
LAA83:  .byte $01, $1B, $FF

;Structure #$11
LAA86:  .byte $04, $1A, $1A, $1A, $1A, $FF

;Structure #$12
LAA8C:  .byte $08, $0F, $0F, $0F, $0F, $10, $10, $10, $10, $FF

;Structure #$13
LAA96:  .byte $04, $0D, $0D, $0D, $0D, $04, $0D, $0E, $0E, $0D, $04, $0D, $0E, $0E, $0D, $04
LAAA6:  .byte $0D, $0D, $0D, $0D, $FF

;Structure #$14
LAAAB:  .byte $08, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $08, $0D, $0E, $0E, $0E, $0E, $0E
LAABB:  .byte $0E, $0D, $08, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $FF

;Structure #$15
LAAC7:  .byte $04, $1C, $1C, $1C, $1C, $04, $1C, $1C, $1C, $1C, $FF

;Structure #$16
LAAD2:  .byte $01, $1D, $01, $1D, $01, $1D, $FF

;Structure #$17
LAAD9:  .byte $04, $1E, $1E, $1E, $1E, $04, $1E, $05, $05, $1E, $04, $1E, $05, $05, $1E, $04
LAAE9:  .byte $1E, $1E, $1E, $1E, $FF

;Structure #$18
LAAEE:  .byte $08, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $08, $1E, $09, $09, $09, $09, $09
LAAFE:  .byte $09, $1E, $08, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $FF

;Structure #$19
LAB0A:  .byte $01, $14, $01, $05, $01, $14, $FF

;Structure #$1A
LAB11:  .byte $01, $04, $01, $04, $01, $04, $01, $04, $FF

;Structure #$1B
LAB1A:  .byte $01, $1F, $FF

;Structure #$1C
LAB1D:  .byte $04, $20, $20, $20, $20, $FF


;----------------------------------------[ Macro definitions ]---------------------------------------

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

MacroDefs:

LAB23:  .byte $FF, $FF, $F0, $F0
LAB27:  .byte $F1, $F1, $F1, $F1
LAB2B:  .byte $A4, $FF, $A4, $FF
LAB2F:  .byte $FF, $A5, $FF, $A5
LAB33:  .byte $80, $81, $82, $83
LAB37:  .byte $45, $46, $45, $46
LAB3B:  .byte $FF, $FF, $59, $5A
LAB3F:  .byte $FF, $FF, $5A, $5B
LAB43:  .byte $60, $61, $62, $63
LAB47:  .byte $0C, $0D, $0E, $0F
LAB4B:  .byte $EC, $FF, $ED, $FF
LAB4F:  .byte $FF, $EE, $FF, $EF
LAB53:  .byte $1C, $1D, $1E, $1F
LAB57:  .byte $20, $21, $22, $23
LAB5B:  .byte $25, $25, $24, $24
LAB5F:  .byte $26, $27, $28, $29
LAB63:  .byte $2A, $2B, $2C, $2D
LAB67:  .byte $18, $19, $1A, $1B
LAB6B:  .byte $A0, $A0, $A0, $A0
LAB6F:  .byte $A1, $A1, $A1, $A1
LAB73:  .byte $10, $11, $12, $13
LAB77:  .byte $04, $05, $06, $07
LAB7B:  .byte $E0, $E1, $E2, $E3
LAB7F:  .byte $70, $71, $72, $73
LAB83:  .byte $FF, $FF, $43, $43
LAB87:  .byte $44, $44, $44, $44
LAB8B:  .byte $14, $15, $16, $17
LAB8F:  .byte $88, $89, $8A, $8B
LAB93:  .byte $E8, $E9, $EA, $EB
LAB97:  .byte $78, $79, $7A, $7B
LAB9B:  .byte $55, $56, $57, $58
LAB9F:  .byte $90, $91, $92, $93
LABA3:  .byte $C7, $C8, $C9, $CA

;Not used.
LABA7:  .byte $11, $11, $11, $04, $11, $11, $11, $11, $FF, $08, $20, $22, $22, $22, $22, $22
LABB7:  .byte $22, $22, $FF, $01, $1F, $FF, $01, $21, $01, $21, $01, $21, $FF, $08, $23, $23
LABC7:  .byte $23, $23, $23, $23, $23, $23, $08, $23, $24, $24, $24, $24, $24, $24, $23, $08
LABD7:  .byte $23, $23, $23, $23, $23, $23, $23, $23, $FF, $01, $23, $01, $23, $01, $23, $01
LABE7:  .byte $23, $FF, $04, $23, $23, $23, $23, $04, $23, $24, $24, $23, $04, $23, $24, $24
LABF7:  .byte $23, $04, $23, $23, $23, $23, $FF, $01, $25, $FF, $01, $26, $01, $26, $01, $26
LAC07:  .byte $01, $26, $FF, $03, $27, $27, $27, $FF, $03, $28, $28, $28, $FF, $08, $13, $13
LAC17:  .byte $13, $13, $13, $13, $13, $13, $FF, $01, $13, $01, $13, $01, $13, $01, $13, $FF
LAC27:  .byte $04, $0C, $0C, $0C, $0C, $04, $0D, $0D, $0D, $0D, $FF, $F1, $F1, $F1, $F1, $FF
LAC37:  .byte $FF, $F0, $F0, $64, $64, $64, $64, $FF, $FF, $64, $64, $A4, $FF, $A4, $FF, $FF
LAC47:  .byte $A5, $FF, $A5, $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $4F, $4F, $4F, $4F, $84
LAC57:  .byte $85, $86, $87, $88, $89, $8A, $8B, $80, $81, $82, $83, $FF, $FF, $BA, $BA, $BB
LAC67:  .byte $BB, $BB, $BB, $10, $11, $12, $13, $04, $05, $06, $07, $14, $15, $16, $17, $1C
LAC77:  .byte $1D, $1E, $1F, $09, $09, $09, $09, $0C, $0D, $0E, $0F, $FF, $FF, $59, $5A, $FF
LAC87:  .byte $FF, $5A, $5B, $51, $52, $53, $54, $55, $56, $57, $58, $EC, $FF, $ED, $FF, $FF
LAC97:  .byte $EE, $FF, $EF, $45, $46, $45, $46, $4B, $4C, $4D, $50, $FF, $FF, $FF, $FF, $47
LACA7:  .byte $48, $47, $48, $08, $08, $08, $08, $70, $71, $72, $73, $74, $75, $76, $77, $E0
LACB7:  .byte $E1, $E2, $E3, $E4, $E5, $E6, $E7, $20, $21, $22, $23, $25, $25, $24, $24, $78
LACC7:  .byte $79, $7A, $7B, $E8, $E9, $EA, $EB, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $0D
LACD7:  .byte $1E, $07, $21, $1D, $0D, $0D, $0D, $1E, $21, $07, $21, $21, $15, $14, $15, $21
LACE7:  .byte $21, $07, $0D, $21, $16, $10, $16, $21, $0D, $07, $1F, $0D, $20, $10, $1F, $0D
LACF7:  .byte $20, $FF, $08, $22, $22, $0D, $22, $22, $1E, $1C, $1D, $08, $1C, $1C, $21, $1C
LAD07:  .byte $1C, $21, $1C, $21, $08, $1C, $1C, $0C, $1C, $1C, $1F, $0D, $20, $07, $1C, $1C
LAD17:  .byte $21, $1C, $1C, $1C, $14, $04, $1C, $14, $0D, $14, $03, $1C, $1C, $15, $FF, $02
LAD27:  .byte $01, $01, $02, $00, $00, $FF, $01, $16, $01, $21, $01, $21, $01, $0C, $01, $21
LAD37:  .byte $01, $0D, $01, $21, $FF, $01, $0C, $FF, $07, $22, $22, $22, $22, $22, $22, $22
LAD47:  .byte $FF, $05, $0B, $1D, $22, $0D, $22, $04, $11, $21, $11, $21, $04, $11, $21, $11
LAD57:  .byte $0D, $03, $11, $21, $11, $03, $23, $23, $23, $FF, $03, $19, $1B, $1A, $FF, $01
LAD67:  .byte $34, $01, $34, $FF, $08, $1D, $22, $17, $0D, $1E, $0D, $17, $0D, $08, $0D, $22
LAD77:  .byte $17, $20, $21, $14, $0D, $11, $08, $21, $1D, $22, $17, $20, $10, $10, $21, $08
LAD87:  .byte $21, $1F, $17, $0D, $22, $0D, $1E, $11, $08, $0D, $14, $10, $1F, $22, $22, $20
LAD97:  .byte $11, $FF, $08, $17, $17, $0D, $17, $17, $0D, $17, $17, $08, $0D, $17, $17, $17
LADA7:  .byte $17, $17, $17, $0D, $FF, $08, $18, $1D, $17, $1E, $1D, $17, $17, $1E, $08, $18
LADB7:  .byte $21, $1C, $21, $21, $1C, $1C, $21, $08, $0D, $20, $1C, $1F, $20, $1C, $1C, $1F
LADC7:  .byte $FF, $04, $0D, $0D, $0D, $0D, $04, $18, $18, $18, $18, $04, $18, $18, $18, $18
LADD7:  .byte $04, $18, $18, $18, $18, $FF, $07, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $07, $0D
LADE7:  .byte $17, $17, $17, $17, $17, $0D, $07, $18, $0A, $10, $0A, $0A, $10, $18, $07, $0D
LADF7:  .byte $17, $17, $17, $17, $17, $0D, $FF, $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01
LAE07:  .byte $0A, $01, $0A, $01, $0A, $01, $0A, $FF, $01, $0D, $01, $18, $01, $18, $01, $18
LAE17:  .byte $01, $18, $FF, $02, $19, $1A, $FF, $01, $0D, $FF, $04, $14, $1C, $1C, $14, $04
LAE27:  .byte $0A, $0A, $0A, $0A, $FF, $08, $0D, $22, $22, $22, $22, $22, $22, $0D, $FF, $08
LAE37:  .byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $08, $0E, $10, $0E, $0E, $10, $10, $0E
LAE47:  .byte $10, $FF, $A7, $A7, $A7, $A7, $FF, $FF, $A6, $A6, $A2, $A2, $FF, $FF, $FF, $FF
LAE57:  .byte $A3, $A3, $A4, $FF, $A4, $FF, $FF, $A5, $FF, $A5, $FF, $79, $FF, $7E, $4F, $4F
LAE67:  .byte $4F, $4F, $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $04, $05, $06, $07, $10, $11
LAE77:  .byte $12, $13, $00, $01, $02, $03, $08, $08, $08, $08, $18, $19, $1A, $1B, $1C, $1D
LAE87:  .byte $1E, $1F, $0C, $0D, $0E, $0F, $09, $09, $09, $09, $7A, $7B, $7F, $5A, $2A, $2C
LAE97:  .byte $FF, $FF, $14, $15, $16, $17, $20, $21, $22, $23, $24, $25, $20, $21, $28, $28
LAEA7:  .byte $29, $29, $26, $27, $26, $27, $2A, $2B, $FF, $FF, $2B, $2C, $FF, $FF, $2B, $2B
LAEB7:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $31, $32, $33, $34, $35, $36, $37, $38, $3D, $3E
LAEC7:  .byte $3F, $40, $41, $42, $43, $44, $39, $3A, $39, $3A, $3B, $3B, $3C, $3C, $0B, $0B
LAED7:  .byte $2D, $2E, $2F, $30, $0B, $0B, $50, $51, $52, $53, $54, $55, $54, $55, $56, $57
LAEE7:  .byte $58, $59, $FF, $FF, $FF, $5E, $5B, $5C, $5F, $60, $FF, $FF, $61, $FF, $5D, $62
LAEF7:  .byte $67, $68, $63, $64, $69, $6A, $65, $66, $6B, $6C, $6D, $6E, $73, $74, $6F, $70
LAF07:  .byte $75, $76, $71, $72, $77, $78, $45, $46, $47, $48, $FF, $98, $FF, $98, $49, $4A
LAF17:  .byte $4B, $4C, $90, $91, $90, $91, $7C, $7D, $4D, $FF, $1C, $1D, $1E, $17, $18, $19
LAF27:  .byte $1A, $1F, $20, $21, $22, $60, $61, $62, $63, $0E, $0F, $FF, $FF, $0C, $0D, $0D
LAF37:  .byte $0D, $10, $0D, $FF, $10, $10, $FF, $FF, $FF, $FF, $FF, $FF, $30, $FF, $33, $FF
LAF47:  .byte $36, $FF, $39, $FF, $3D, $FF, $FF, $31, $32, $34, $35, $37, $38, $3A, $3B, $3E
LAF57:  .byte $3F, $3C, $41, $40, $42, $84, $85, $86, $87, $80, $81, $82, $83, $88, $89, $8A
LAF67:  .byte $8B, $45, $46, $45, $46, $47, $48, $48, $47, $5C, $5D, $5E, $5F, $B8, $B8, $B9
LAF77:  .byte $B9, $74, $75, $75, $74, $C1, $13, $13, $13, $36, $BE, $BC, $BD, $BF, $14, $15
LAF87:  .byte $14, $C0, $14, $C0, $16, $FF, $C1, $FF, $FF, $C2, $14, $FF, $FF, $30, $13, $BC
LAF97:  .byte $BD, $13, $14, $15, $16, $D7, $D7, $D7, $D7, $76, $76, $76, $76, $FF, $FF, $BA
LAFA7:  .byte $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03, $04, $05, $06, $07, $FF, $FF, $08
LAFB7:  .byte $09, $FF, $FF, $09, $0A, $55, $56, $57, $58, $90, $91, $92, $93, $4B, $4C, $4D
LAFC7:  .byte $50, $51, $52, $53, $54, $70, $71, $72, $73, $8C, $8D, $8E, $8F, $11, $12, $FF
LAFD7:  .byte $11, $11, $12, $12, $11, $11, $12, $12, $FF, $C3, $C4, $C5, $C6, $30, $00, $BC
LAFE7:  .byte $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93, $20, $20, $20
LAFF7:  .byte $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0

.advance $B000, $00
.include "../music/RidleyMusic.asm"

.advance $B200, $00
.include "../SoundEngine.asm"

.advance $C000, $00
