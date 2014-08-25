; METROID Disassembly (c) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
; Disassembled by Kent Hansen. Commented by Nick Mikstas.
; This version is organized and ported to use the MMC3.
; Tourian (Rom Bank 3)

.require "../Defines.asm"
.require "../GameEngineDeclarations.asm"

.org $8000
.include "../AreaCommon.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

;Kraid hideout enemy tile patterns.
L8D60:  .byte $03, $0F, $05, $32, $D1, $48, $12, $24, $01, $02, $02, $11, $48, $20, $00, $00
L8D70:  .byte $E0, $F0, $EC, $DE, $92, $8D, $A0, $3C, $C0, $00, $0C, $02, $01, $0C, $02, $00
L8D80:  .byte $00, $80, $58, $38, $70, $23, $83, $CD, $00, $00, $18, $3C, $7C, $38, $30, $00
L8D90:  .byte $0E, $59, $B0, $60, $C0, $00, $00, $80, $0E, $59, $B7, $6C, $DE, $2F, $56, $28
L8DA0:  .byte $00, $00, $00, $00, $00, $38, $48, $90, $00, $00, $00, $00, $00, $38, $7C, $FA
L8DB0:  .byte $00, $01, $00, $03, $0C, $08, $10, $03, $00, $00, $00, $03, $0F, $0C, $58, $3F
L8DC0:  .byte $48, $28, $AF, $3D, $78, $CD, $B6, $6F, $00, $07, $1C, $70, $4A, $01, $32, $00
L8DD0:  .byte $00, $00, $B0, $E8, $74, $BC, $18, $18, $00, $50, $B0, $20, $00, $88, $88, $20
L8DE0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DF0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E00:  .byte $00, $07, $0F, $0A, $00, $02, $00, $38, $00, $07, $0F, $1A, $18, $1F, $0F, $3B
L8E10:  .byte $24, $18, $95, $95, $39, $31, $29, $24, $24, $1C, $9C, $D8, $F4, $EC, $B4, $38
L8E20:  .byte $38, $7C, $D4, $C4, $78, $00, $00, $00, $38, $7C, $D6, $C6, $FE, $7C, $38, $00
L8E30:  .byte $00, $00, $38, $7C, $D6, $44, $38, $00, $00, $00, $38, $7C, $D6, $C6, $FE, $7C
L8E40:  .byte $81, $A5, $E7, $24, $00, $24, $18, $24, $81, $A5, $E7, $66, $66, $C3, $66, $18
L8E50:  .byte $00, $24, $1B, $1F, $3B, $44, $5B, $3F, $BD, $9B, $E4, $C0, $C4, $98, $83, $C7
L8E60:  .byte $00, $20, $60, $D1, $D4, $60, $20, $00, $02, $17, $1F, $1F, $1F, $1F, $17, $02
L8E70:  .byte $00, $00, $00, $00, $60, $00, $00, $00, $80, $D0, $F4, $FE, $FE, $F4, $D0, $80
L8E80:  .byte $76, $02, $02, $04, $38, $00, $00, $00, $00, $50, $00, $28, $00, $01, $02, $00
L8E90:  .byte $C4, $CE, $7F, $7B, $79, $02, $02, $00, $10, $00, $80, $00, $00, $50, $A4, $00
L8EA0:  .byte $60, $A0, $C2, $E7, $71, $46, $98, $20, $6E, $3C, $18, $08, $00, $50, $D0, $04
L8EB0:  .byte $04, $30, $48, $00, $80, $11, $30, $21, $07, $32, $78, $7E, $F0, $C1, $5C, $3C
L8EC0:  .byte $61, $32, $1E, $81, $F8, $FF, $FF, $F9, $00, $02, $00, $00, $D0, $00, $00, $08
L8ED0:  .byte $FC, $FC, $7E, $36, $BE, $0C, $E0, $F8, $44, $2C, $12, $00, $20, $00, $20, $10
L8EE0:  .byte $00, $80, $C2, $E7, $7F, $7F, $3E, $0C, $00, $00, $80, $C1, $43, $77, $3E, $0C
L8EF0:  .byte $0E, $3C, $78, $70, $F0, $F8, $7C, $38, $0C, $38, $60, $60, $C0, $E0, $70, $38
L8F00:  .byte $7C, $7C, $38, $10, $00, $00, $00, $00, $7C, $FE, $FE, $D6, $46, $3C, $00, $00
L8F10:  .byte $28, $30, $E8, $E4, $14, $30, $28, $44, $34, $2C, $F4, $38, $1C, $3C, $2C, $44
L8F20:  .byte $8C, $6C, $2F, $35, $4A, $91, $00, $3E, $88, $68, $2F, $7B, $75, $CE, $00, $00
L8F30:  .byte $00, $17, $FC, $5E, $A2, $53, $00, $00, $38, $07, $E4, $BE, $5E, $E7, $00, $00
L8F40:  .byte $00, $02, $0D, $17, $2D, $62, $6D, $2E, $83, $C5, $F2, $E0, $C2, $81, $8C, $CE
L8F50:  .byte $00, $40, $B0, $E8, $B4, $46, $B6, $74, $C1, $A3, $4F, $07, $43, $81, $31, $73
L8F60:  .byte $00, $00, $00, $00, $00, $20, $73, $DF, $00, $00, $02, $17, $1F, $14, $11, $18
L8F70:  .byte $00, $00, $00, $00, $00, $00, $12, $C0, $00, $00, $80, $D0, $F4, $FE, $70, $00
L8F80:  .byte $00, $00, $00, $00, $18, $3C, $3A, $17, $00, $00, $00, $00, $00, $10, $02, $07
L8F90:  .byte $00, $00, $08, $00, $00, $81, $81, $DB, $00, $00, $24, $76, $6E, $76, $24, $00
L8FA0:  .byte $00, $00, $00, $18, $3D, $3B, $10, $00, $00, $00, $00, $00, $11, $03, $00, $00
L8FB0:  .byte $40, $82, $05, $23, $40, $03, $1E, $10, $78, $F0, $C0, $50, $30, $68, $3C, $5E
L8FC0:  .byte $E3, $F0, $7E, $09, $05, $E8, $31, $9E, $20, $10, $02, $00, $06, $0C, $01, $00
L8FD0:  .byte $F0, $E8, $1C, $9E, $42, $9A, $3C, $7E, $00, $00, $00, $02, $42, $C2, $80, $00
L8FE0:  .byte $01, $03, $0D, $09, $13, $07, $03, $00, $38, $10, $10, $36, $24, $40, $00, $00
L8FF0:  .byte $F8, $EE, $9F, $7F, $9F, $E0, $80, $00, $00, $0E, $00, $70, $10, $00, $00, $00
L9000:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9010:  .byte $00, $00, $80, $80, $0C, $0E, $13, $10, $C0, $20, $90, $90, $3C, $E2, $D1, $90
L9020:  .byte $F0, $38, $11, $01, $00, $00, $08, $08, $F3, $0C, $09, $09, $0C, $07, $0B, $09
L9030:  .byte $00, $00, $01, $01, $30, $70, $C8, $08, $03, $04, $09, $09, $3C, $47, $8B, $09
L9040:  .byte $26, $31, $10, $1C, $18, $0C, $00, $00, $C6, $C0, $60, $60, $20, $30, $18, $08
L9050:  .byte $5E, $2C, $20, $3C, $24, $18, $00, $00, $87, $C3, $42, $42, $42, $66, $24, $24
L9060:  .byte $00, $00, $00, $00, $0B, $27, $73, $DF, $02, $17, $1F, $34, $0B, $07, $11, $18
L9070:  .byte $00, $00, $00, $00, $00, $8C, $F2, $E0, $80, $D0, $F4, $FE, $60, $80, $30, $00
L9080:  .byte $18, $18, $98, $98, $64, $18, $7E, $E6, $18, $18, $18, $00, $00, $00, $00, $E6
L9090:  .byte $BD, $DB, $18, $24, $3C, $66, $66, $24, $00, $00, $00, $42, $00, $00, $42, $24
L90A0:  .byte $03, $1A, $3C, $38, $10, $08, $18, $18, $03, $02, $10, $00, $00, $08, $18, $18
L90B0:  .byte $20, $01, $03, $07, $01, $03, $07, $02, $38, $10, $B0, $60, $7C, $28, $00, $00
L90C0:  .byte $EF, $F7, $C5, $90, $FC, $FF, $3E, $E3, $00, $00, $00, $20, $0C, $03, $00, $E0
L90D0:  .byte $FC, $F8, $F2, $C0, $01, $60, $90, $D0, $00, $00, $02, $0E, $01, $60, $F0, $10
L90E0:  .byte $00, $00, $00, $F8, $00, $F8, $00, $00, $00, $00, $00, $F8, $07, $00, $00, $00
L90F0:  .byte $7C, $F8, $10, $84, $3E, $7F, $19, $00, $60, $F0, $10, $00, $02, $07, $01, $00
L9100:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9110:  .byte $0F, $1C, $88, $80, $00, $00, $10, $10, $CF, $30, $90, $90, $30, $E0, $D0, $90
L9120:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9130:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9140:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9150:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;Ridley hideout enemy tile patterns.
L9160:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9170:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9180:  .byte $00, $00, $08, $31, $7A, $DA, $19, $FD, $00, $00, $00, $21, $5A, $DA, $99, $FD
L9190:  .byte $8C, $9C, $BC, $78, $E0, $D8, $A2, $48, $8C, $98, $B0, $60, $C0, $9E, $3D, $77
L91A0:  .byte $00, $00, $00, $40, $E0, $E0, $F0, $78, $00, $00, $00, $40, $E0, $C0, $40, $60
L91B0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L91C0:  .byte $18, $0C, $04, $02, $01, $0E, $18, $2C, $06, $02, $03, $01, $00, $00, $07, $13
L91D0:  .byte $19, $00, $40, $18, $0C, $96, $56, $00, $DE, $6E, $DE, $C6, $E3, $61, $25, $B9
L91E0:  .byte $00, $00, $00, $03, $2E, $2E, $12, $33, $3C, $7F, $FF, $FC, $D1, $50, $69, $0E
L91F0:  .byte $00, $00, $00, $80, $40, $70, $7C, $35, $00, $00, $C0, $60, $B0, $68, $73, $B2
L9200:  .byte $00, $05, $0C, $5F, $34, $19, $33, $BE, $00, $05, $0C, $5F, $34, $19, $31, $B6
L9210:  .byte $40, $20, $B4, $48, $DA, $66, $63, $03, $40, $20, $B4, $48, $9A, $66, $4B, $11
L9220:  .byte $00, $09, $02, $1A, $3D, $6F, $55, $2A, $00, $09, $02, $1A, $3D, $6F, $55, $2E
L9230:  .byte $40, $40, $20, $E8, $A4, $9C, $D6, $CA, $40, $40, $20, $E8, $A4, $1C, $96, $CA
L9240:  .byte $80, $C1, $63, $78, $3E, $3E, $1E, $0E, $80, $40, $20, $18, $04, $00, $00, $00
L9250:  .byte $5A, $DB, $DB, $FF, $7E, $18, $81, $81, $50, $00, $00, $00, $00, $00, $00, $24
L9260:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9270:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9280:  .byte $F2, $64, $0F, $DA, $8D, $5B, $10, $10, $FB, $70, $01, $C0, $8D, $58, $10, $10
L9290:  .byte $90, $40, $20, $80, $B0, $70, $5C, $60, $EF, $3E, $18, $80, $00, $10, $5C, $60
L92A0:  .byte $B8, $38, $30, $80, $80, $60, $20, $18, $A0, $A4, $66, $C6, $3E, $0C, $20, $18
L92B0:  .byte $30, $27, $2D, $38, $2A, $5E, $70, $40, $10, $00, $01, $00, $12, $20, $00, $00
L92C0:  .byte $0A, $40, $40, $51, $78, $C4, $C2, $90, $31, $3D, $3B, $2C, $06, $3B, $3D, $6F
L92D0:  .byte $00, $08, $10, $80, $42, $00, $2E, $5A, $F9, $B1, $40, $60, $3E, $0E, $82, $92
L92E0:  .byte $00, $00, $00, $00, $00, $0C, $0E, $0C, $00, $00, $00, $0C, $1E, $13, $15, $16
L92F0:  .byte $00, $01, $01, $00, $00, $08, $04, $12, $00, $00, $00, $06, $0F, $07, $03, $09
L9300:  .byte $5D, $23, $54, $2B, $24, $1E, $0F, $04, $5D, $23, $55, $2B, $20, $1C, $0F, $04
L9310:  .byte $01, $A7, $06, $0B, $4A, $D6, $2C, $F0, $59, $F1, $52, $FB, $6A, $D6, $2C, $F0
L9320:  .byte $EC, $F5, $7C, $99, $42, $60, $38, $0F, $CE, $D5, $70, $9D, $47, $68, $38, $0F
L9330:  .byte $AF, $73, $36, $26, $0C, $1C, $78, $C0, $AF, $73, $76, $A6, $4C, $1C, $78, $C0
L9340:  .byte $69, $2C, $0E, $77, $D4, $B4, $E2, $00, $03, $01, $00, $70, $F0, $F0, $E0, $00
L9350:  .byte $69, $2C, $0E, $37, $14, $04, $02, $00, $03, $01, $00, $30, $10, $00, $00, $00
L9360:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9370:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9380:  .byte $00, $00, $00, $00, $10, $20, $00, $00, $00, $00, $18, $3C, $3C, $FE, $7D, $FF
L9390:  .byte $81, $42, $24, $24, $3C, $7E, $C3, $A5, $00, $00, $00, $00, $00, $00, $00, $24
L93A0:  .byte $00, $00, $00, $00, $10, $20, $00, $00, $00, $00, $18, $3C, $3F, $FF, $7C, $FE
L93B0:  .byte $00, $00, $80, $00, $00, $08, $04, $82, $00, $00, $00, $86, $8F, $87, $83, $41
L93C0:  .byte $D1, $E4, $88, $00, $00, $30, $88, $70, $2E, $18, $73, $FF, $7F, $8F, $47, $8F
L93D0:  .byte $80, $00, $00, $20, $00, $10, $30, $70, $00, $00, $C0, $C0, $F0, $E0, $C0, $80
L93E0:  .byte $0C, $0C, $0C, $18, $18, $10, $10, $00, $30, $34, $3C, $28, $38, $30, $30, $20
L93F0:  .byte $01, $05, $1D, $20, $01, $00, $00, $00, $3C, $38, $20, $40, $40, $40, $40, $80
L9400:  .byte $00, $03, $1C, $90, $80, $80, $40, $20, $FF, $FC, $E0, $60, $78, $7C, $3C, $1E
L9410:  .byte $20, $C0, $00, $00, $00, $00, $00, $00, $C0, $00, $00, $00, $00, $00, $00, $00
L9420:  .byte $38, $4C, $86, $36, $7E, $7E, $6C, $38, $00, $08, $04, $14, $3C, $38, $00, $00
L9430:  .byte $9E, $7F, $3F, $07, $4E, $3D, $03, $0A, $F0, $68, $30, $3C, $5A, $3F, $07, $0B
L9440:  .byte $12, $04, $2F, $2F, $3F, $3F, $5F, $2F, $13, $0F, $3D, $3E, $34, $78, $70, $68
L9450:  .byte $00, $80, $60, $F0, $E8, $F8, $F0, $FC, $C0, $70, $98, $0C, $14, $06, $0E, $02
L9460:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9470:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9480:  .byte $00, $18, $20, $00, $00, $00, $00, $00, $64, $C0, $1C, $78, $3C, $12, $22, $20
L9490:  .byte $E7, $5A, $3C, $5A, $81, $81, $42, $00, $66, $42, $00, $00, $00, $00, $00, $00
L94A0:  .byte $00, $00, $00, $00, $10, $20, $00, $00, $01, $03, $1B, $3E, $3C, $FE, $7C, $FE
L94B0:  .byte $41, $21, $10, $04, $00, $00, $00, $00, $20, $1C, $0E, $03, $00, $00, $00, $00
L94C0:  .byte $00, $00, $00, $00, $00, $01, $3E, $00, $FF, $FC, $F8, $73, $7F, $7E, $00, $00
L94D0:  .byte $00, $00, $00, $00, $08, $97, $59, $08, $E0, $00, $00, $EC, $F6, $73, $39, $08
L94E0:  .byte $00, $00, $01, $07, $0F, $0D, $1B, $10, $00, $01, $06, $09, $15, $1F, $2B, $30
L94F0:  .byte $00, $40, $E0, $D8, $D8, $BC, $3E, $0C, $60, $B0, $D8, $E4, $F6, $FB, $39, $0A
L9500:  .byte $30, $26, $08, $18, $33, $06, $00, $00, $0E, $19, $13, $1B, $32, $06, $00, $00
L9510:  .byte $04, $02, $31, $5B, $7B, $7E, $3E, $18, $00, $00, $00, $1A, $3A, $1C, $00, $00
L9520:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9530:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9540:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9550:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
L9560:  .word Palette00                 ;($A718)
L9562:  .word Palette01                 ;($A73C)
L9564:  .word Palette02                 ;($A748)
L9566:  .word Palette03                 ;($A742)
L9568:  .word Palette04                 ;($A74E)
L956A:  .word Palette05                 ;($A754)
L956C:  .word Palette05                 ;($A754)
L956E:  .word Palette06                 ;($A759)
L9570:  .word Palette07                 ;($A75E)
L9572:  .word Palette08                 ;($A773)
L9574:  .word Palette09                 ;($A788)
L9576:  .word Palette0A                 ;($A78D)
L9578:  .word Palette0A                 ;($A78D)
L957A:  .word Palette0A                 ;($A78D)
L957C:  .word Palette0A                 ;($A78D)
L957E:  .word Palette0A                 ;($A78D)
L9580:  .word Palette0A                 ;($A78D)
L9582:  .word Palette0A                 ;($A78D)
L9584:  .word Palette0A                 ;($A78D)
L9586:  .word Palette0A                 ;($A78D)
L9588:  .word Palette0B                 ;($A794)
L958A:  .word Palette0C                 ;($A79B)
L958C:  .word Palette0D                 ;($A7A2)
L958E:  .word Palette0E                 ;($A7A9)
L9590:  .word Palette0F                 ;($A7B1)
L9592:  .word Palette10                 ;($A7B9)
L9594:  .word Palette11                 ;($A7C1)
L9596:  .word Palette12                 ;($A7C9)

AreaPointers:
L9598:  .word SpecItmsTbl               ;($A83B)Beginning of special items table.
L959A:  .word RmPtrTbl                  ;($A7D1)Beginning of room pointer table.
L959C:  .word StrctPtrTbl               ;($A7FB)Beginning of structure pointer table.
L959E:  .word MacroDefs                 ;($AE49)Beginning of macro definitions.
L95A0:  .word EnemyFramePtrTbl1         ;($A42C)Address table into enemy animation data. Two-->
L95A2:  .word EnemyFramePtrTbl2         ;($A52C)tables needed to accommodate all entries.
L95A4:  .word EnemyPlacePtrTbl          ;($A540)Pointers to enemy frame placement data.
L95A6:  .word EnemyAnimIndexTbl         ;($A406)Index to values in addr tables for enemy animations.

L95A8:  JMP $A320 
L95AB:  JMP $A315
L95AE:  JMP $9C6F
L95B1:  JMP $9CE6
L95B4:  JMP $9D21
L95B7:  JMP $9D3D
L95BA:  JMP $9D6C
L95BD:  JMP $A0C6
L95C0:  JMP $A142

AreaRoutine:
L95C3:  JMP $9B25                       ;Area specific routine.

TwosCompliment_:
L95C6:  EOR #$FF                        ;
L95C8:  CLC                             ;The following routine returns the twos-->
L95C9:  ADC #$01                        ;compliment of the value stored in A.
L95CB:  RTS                             ;

L95CC:  .byte $FF                       ;Not used.

L95CD:  .byte $40                       ;Tourian music init flag.

L95CE:  .byte $00                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $03                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:  .byte $03                       ;Samus start x coord on world map.
L95D8:  .byte $04                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $06, $00, $03, $21, $00, $00, $00, $00, $00, $10, $00

L95E5:  LDA EnDataIndex,X
L95E8:  JSR CommonJump_ChooseRoutine

L95EB:  .word $97F9
L95ED:  .word $97F9
L95EF:  .word $9A27
L95F1:  .word $97DC
L95F3:  .word $9A2C
L95F5:  .word $97DC
L95F7:  .word $97DC
L95F9:  .word $97DC
L95FB:  .word $97DC
L95FD:  .word $97DC
L95FF:  .word $97DC
L9601:  .word $97DC
L9603:  .word $97DC
L9605:  .word $97DC
L9607:  .word $97DC
L9609:  .word $97DC


L960B:  .byte $08, $08, $08, $08, $16, $16, $18, $18, $1F, $1F, $00, $00, $00, $00, $00, $00

L961B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L962B:  .byte $FF, $FF, $01, $FF, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L963B:  .byte $05, $05, $05, $05, $16, $16, $18, $18, $1B, $1B, $00, $00, $00, $00, $00, $00

L964B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L965B:  .byte $05, $05, $05, $05, $16, $16, $18, $18, $1D, $1D, $00, $00, $00, $00, $00, $00

L966B:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $00, $02, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L968B:  .byte $FE, $FE, $00, $00, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L969B:  .byte $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96AB:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96BB:  .byte $01, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96CB:  .byte $00, $02, $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96DB:  .word $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5
L96EB:  .word $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5
L96FB:  .word $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5
L970B:  .word $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5, $97D5
L971B:  .word $97D5, $97D5, $97D5, $97D5

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $18, $30, $00, $C0, $D0, $00, $00, $7F
L9733:  .byte $80, $58, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00, $18, $30, $00, $00
L9743:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $00, $00, $00, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00
L9763:  .byte $00, $00, $00, $00, $00, $00, $00, $02, $02, $00, $00, $00, $02, $02, $02, $02
L9773:  .byte $00, $00, $00, $00, $00, $00, $00, $00

L977B:  .byte $50, $50, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

L978B:  .byte $00, $00, $26, $26, $26, $26, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

L97A7:  .word $97D5, $97D5, $97D8, $97DB, $A32B, $A330, $A337, $A348
L97B7:  .word $A359, $A36A, $A37B, $A388, $A391, $A3A2, $A3B3, $A3C4
L97C7:  .word $A3D5, $A3DE, $A3E7, $A3F0, $A3F9

L97D1:  .byte $00, $00, $00, $01

L97D5:  .byte $50, $22, $FF

L97D8:  .byte $50, $30, $FF

L97DB:  .byte $FF

L97DC:  LDA #$00
L97DE:  STA $6AF4,X
L97E1:  RTS

L97E2:  LDA $81
L97E4:  CMP #$01
L97E6:  BEQ $97F1
L97E8:  CMP #$03
L97EA:  BEQ $97F6
L97EC:  LDA $00
L97EE:  JMP CommonJump_UnknownUpdateAnim0
L97F1:  LDA $01
L97F3:  JMP CommonJump_UnknownUpdateAnim1
L97F6:  JMP CommonJump_Unknown06
L97F9:  LDY $010B
L97FC:  INY 
L97FD:  BEQ $9804
L97FF:  LDA #$00
L9801:  STA $6AF4,X
L9804:  LDA #$0F
L9806:  STA $00
L9808:  STA $01
L980A:  LDA EnData05,X
L980D:  ASL 
L980E:  BMI $97E2
L9810:  LDA $6AF4,X
L9813:  CMP #$03
L9815:  BEQ $97E2
L9817:  JSR $99B7
L981A:  LDA $77F8,Y
L981D:  BEQ $9822
L981F:  JMP $9899
L9822:  LDY $0408,X
L9825:  LDA $77F6,Y
L9828:  PHA 
L9829:  LDA $0402,X
L982C:  BPL $983B
L982E:  PLA 
L982F:  JSR $95C6
L9832:  PHA 
L9833:  LDA #$00
L9835:  CMP $0406,X
L9838:  SBC $0402,X
L983B:  CMP $77F6,Y
L983E:  PLA 
L983F:  BCC $9849
L9841:  STA $0402,X
L9844:  LDA #$00
L9846:  STA $0406,X
L9849:  LDA $77F6,Y
L984C:  PHA 
L984D:  LDA $0403,X
L9850:  BPL $985F
L9852:  PLA 
L9853:  JSR $95C6
L9856:  PHA 
L9857:  LDA #$00
L9859:  CMP $0407,X
L985C:  SBC $0403,X
L985F:  CMP $77F6,Y
L9862:  PLA 
L9863:  BCC $986D
L9865:  STA $0403,X
L9868:  LDA #$00
L986A:  STA $0407,X
L986D:  LDA EnData05,X
L9870:  PHA 
L9871:  JSR $9A06
L9874:  STA $6AFF,X
L9877:  PLA 
L9878:  LSR 
L9879:  LSR 
L987A:  JSR $9A06
L987D:  STA $6AFE,X
L9880:  LDA $6AF4,X
L9883:  CMP #$04
L9885:  BNE $9894
L9887:  LDY $040B,X
L988A:  INY 
L988B:  BNE $9899
L988D:  LDA #$05
L988F:  STA $040B,X
L9892:  BNE $9899
L9894:  LDA #$FF
L9896:  STA $040B,X
L9899:  LDA $81
L989B:  CMP #$06
L989D:  BNE $98A9
L989F:  CMP $6AF4,X
L98A2:  BEQ $98A9
L98A4:  LDA #$04
L98A6:  STA $6AF4,X
L98A9:  LDA $0404,X
L98AC:  AND #$20
L98AE:  BEQ $990F
L98B0:  JSR $99B7
L98B3:  LDA $77F8,Y
L98B6:  BEQ $98EF
L98B8:  LDA $040E,X
L98BB:  CMP #$07
L98BD:  BEQ $98C3
L98BF:  CMP #$0A
L98C1:  BNE $9932
L98C3:  LDA $2D
L98C5:  AND #$02
L98C7:  BNE $9932
L98C9:  LDA $77F8,Y
L98CC:  CLC 
L98CD:  ADC #$10
L98CF:  STA $77F8,Y
L98D2:  AND #$70
L98D4:  CMP #$50
L98D6:  BNE $9932
L98D8:  LDA #$02
L98DA:  ORA $040F,X
L98DD:  STA $040C,X
L98E0:  LDA #$06
L98E2:  STA $6AF4,X
L98E5:  LDA #$20
L98E7:  STA $040F,X
L98EA:  LDA #$01
L98EC:  STA $040D,X
L98EF:  LDA #$00
L98F1:  STA $0404,X
L98F4:  STA $77F8,Y
L98F7:  STA $0406,X
L98FA:  STA $0407,X
L98FD:  LDA $6AFE,X
L9900:  JSR $9A10
L9903:  STA $0402,X
L9906:  LDA $6AFF,X
L9909:  JSR $9A10
L990C:  STA $0403,X
L990F:  JSR $99B7
L9912:  LDA $77F8,Y
L9915:  BNE $9932
L9917:  LDA $0404,X
L991A:  AND #$04
L991C:  BEQ $9964
L991E:  LDA $0403,X
L9921:  AND #$80
L9923:  ORA #$01
L9925:  TAY 
L9926:  JSR $99C3
L9929:  JSR $99BD
L992C:  TYA 
L992D:  STA $77F8,X
L9930:  TXA 
L9931:  TAY 
L9932:  TYA 
L9933:  TAX 
L9934:  LDA $77F8,X
L9937:  PHP 
L9938:  AND #$0F
L993A:  CMP #$0C
L993C:  BEQ $9941
L993E:  INC $77F8,X
L9941:  TAY 
L9942:  LDA $99D7,Y
L9945:  STA $04
L9947:  STY $05
L9949:  LDA #$0C
L994B:  SEC 
L994C:  SBC $05
L994E:  LDX $4B
L9950:  PLP 
L9951:  BMI $9956
L9953:  JSR $95C6
L9956:  STA $05
L9958:  JSR $99E4
L995B:  JSR CommonJump_Unknown27
L995E:  JSR $99F4
L9961:  JMP $9967
L9964:  JSR $99AE
L9967:  LDA $6AF4,X
L996A:  CMP #$03
L996C:  BNE $9971
L996E:  JSR $99AE
L9971:  LDY #$00
L9973:  LDA $77F8
L9976:  ORA $77F9
L9979:  ORA $77FA
L997C:  ORA $77FB
L997F:  ORA $77FC
L9982:  ORA $77FD
L9985:  AND #$0C
L9987:  CMP #$0C
L9989:  BNE $999E
L998B:  LDA $0106
L998E:  ORA $0107
L9991:  BEQ $999E
L9993:  STY $6F
L9995:  LDY #$04
L9997:  STY $6E
L9999:  JSR CommonJump_SubtractHealth
L999C:  LDY #$01
L999E:  STY $92
L99A0:  LDA $6B
L99A2:  BMI $99AB
L99A4:  LDA EnDataIndex,X
L99A7:  ORA #$A2
L99A9:  STA $6B
L99AB:  JMP $97E2
L99AE:  JSR $99B7
L99B1:  LDA #$00
L99B3:  STA $77F8,Y
L99B6:  RTS

L99B7:  TXA 
L99B8:  JSR $9B1B
L99BB:  TAY 
L99BC:  RTS 
L99BD:  TXA 
L99BE:  JSR $9B1B
L99C1:  TAX 
L99C2:  RTS

L99C3:  LDA #$00
L99C5:  STA $0402,X
L99C8:  STA $0403,X
L99CB:  STA $0407,X
L99CE:  STA $0406,X
L99D1:  STA $6AFF,X
L99D4:  STA $6AFE,X
L99D7:  RTS

L99D8:  .byte $00, $FC, $F9, $F7, $F6, $F6, $F5, $F5, $F5, $F6, $F6, $F8
 
L99E4:  LDA $030E
L99E7:  STA $09
L99E9:  LDA $030D
L99EC:  STA $08
L99EE:  LDA $030C
L99F1:  STA $0B
L99F3:  RTS

L99F4:  LDA $09
L99F6:  STA $0401,X
L99F9:  LDA $08
L99FB:  STA $0400,X
L99FE:  LDA $0B
L9A00:  AND #$01
L9A02:  STA $6AFB,X
L9A05:  RTS

L9A06:  LSR 
L9A07:  LDA $0408,X
L9A0A:  ROL 
L9A0B:  TAY 
L9A0C:  LDA $77F2,Y
L9A0F:  RTS

L9A10:  ASL 
L9A11:  ROL 
L9A12:  AND #$01
L9A14:  TAY 
L9A15:  LDA $77F0,Y
L9A18:  RTS

L9A19:  .byte $F8, $08, $30, $D0, $60, $A0, $02, $04, $00, $00, $00, $00, $00, $00

L9A27:  LDA #$01
L9A29:  JMP CommonJump_UnknownUpdateAnim1
L9A2C:  LDY $6AF4,X
L9A2F:  CPY #$02
L9A31:  BNE $9AB0
L9A33:  DEY 
L9A34:  CPY $81
L9A36:  BNE $9AB0
L9A38:  LDA #$00
L9A3A:  JSR $99D1
L9A3D:  STA $6AFC,X
L9A40:  STA $6AFD,X
L9A43:  LDA $030E
L9A46:  SEC 
L9A47:  SBC $0401,X
L9A4A:  STA $01
L9A4C:  LDA EnData05,X
L9A4F:  PHA 
L9A50:  LSR 
L9A51:  PHA 
L9A52:  BCC $9A5A
L9A54:  LDA #$00
L9A56:  SBC $01
L9A58:  STA $01
L9A5A:  LDA $030D
L9A5D:  SEC 
L9A5E:  SBC $0400,X
L9A61:  STA $00
L9A63:  PLA 
L9A64:  LSR 
L9A65:  LSR 
L9A66:  BCC $9A6E
L9A68:  LDA #$00
L9A6A:  SBC $00
L9A6C:  STA $00
L9A6E:  LDA $00
L9A70:  ORA $01
L9A72:  LDY #$03
L9A74:  ASL 
L9A75:  BCS $9A7A
L9A77:  DEY 
L9A78:  BNE $9A74
L9A7A:  DEY 
L9A7B:  BMI $9A83
L9A7D:  LSR $00
L9A7F:  LSR $01
L9A81:  BPL $9A7A
L9A83:  JSR $9AF9
L9A86:  PLA 
L9A87:  LSR 
L9A88:  PHA 
L9A89:  BCC $9A9B
L9A8B:  LDA #$00
L9A8D:  SBC $0407,X
L9A90:  STA $0407,X
L9A93:  LDA #$00
L9A95:  SBC $0403,X
L9A98:  STA $0403,X
L9A9B:  PLA 
L9A9C:  LSR 
L9A9D:  LSR 
L9A9E:  BCC $9AB0
L9AA0:  LDA #$00
L9AA2:  SBC $0406,X
L9AA5:  STA $0406,X
L9AA8:  LDA #$00
L9AAA:  SBC $0402,X
L9AAD:  STA $0402,X
L9AB0:  LDA EnData05,X
L9AB3:  ASL 
L9AB4:  BMI $9AF4
L9AB6:  LDA $0406,X
L9AB9:  CLC 
L9ABA:  ADC $6AFC,X
L9ABD:  STA $6AFC,X
L9AC0:  LDA $0402,X
L9AC3:  ADC #$00
L9AC5:  STA $04
L9AC7:  LDA $0407,X
L9ACA:  CLC 
L9ACB:  ADC $6AFD,X
L9ACE:  STA $6AFD,X
L9AD1:  LDA $0403,X
L9AD4:  ADC #$00
L9AD6:  STA $05
L9AD8:  LDA $0400,X
L9ADB:  STA $08
L9ADD:  LDA $0401,X
L9AE0:  STA $09
L9AE2:  LDA $6AFB,X
L9AE5:  STA $0B
L9AE7:  JSR CommonJump_Unknown27
L9AEA:  BCS $9AF1
L9AEC:  LDA #$00
L9AEE:  STA $6AF4,X
L9AF1:  JSR $99F4
L9AF4:  LDA #$08
L9AF6:  JMP CommonJump_UnknownUpdateAnim1
L9AF9:  LDA $00
L9AFB:  PHA 
L9AFC:  JSR $9B1B
L9AFF:  STA $0402,X
L9B02:  PLA 
L9B03:  JSR $9B20
L9B06:  STA $0406,X
L9B09:  LDA $01
L9B0B:  PHA 
L9B0C:  JSR $9B1B
L9B0F:  STA $0403,X
L9B12:  PLA 
L9B13:  JSR $9B20
L9B16:  STA $0407,X
L9B19:  RTS

L9B1A:  LSR 
L9B1B:  LSR 
L9B1C:  LSR 
L9B1D:  LSR 
L9B1E:  LSR 
L9B1F:  RTS

L9B20:  ASL 
L9B21:  ASL 
L9B22:  ASL 
L9B23:  ASL 
L9B24:  RTS

L9B25:  JSR $9B37
L9B28:  JSR $9DD4
L9B2B:  JSR $A1E7
L9B2E:  JSR $A238
L9B31:  JSR $A28B
L9B34:  JMP $A15E
L9B37:  LDX #$78
L9B39:  JSR $9B44
L9B3C:  LDA $97
L9B3E:  SEC 
L9B3F:  SBC #$08
L9B41:  TAX 
L9B42:  BNE $9B39
L9B44:  STX $97
L9B46:  LDY $6BF4,X
L9B49:  BNE $9B4C
L9B4B:  RTS

L9B4C:  JSR $9C4D
L9B4F:  TYA 
L9B50:  BNE $9B4B
L9B52:  LDY $010B
L9B55:  INY 
L9B56:  BNE $9B65
L9B58:  LDA $6BF8,X
L9B5B:  CMP #$05
L9B5D:  BEQ $9B4B
L9B5F:  JSR $9B70
L9B62:  JMP $9C2B
L9B65:  LDA $2D
L9B67:  AND #$02
L9B69:  BNE $9B4B
L9B6B:  LDA #$19
L9B6D:  JMP $9C31
L9B70:  LDY $6BF8,X
L9B73:  LDA $6BFA,X
L9B76:  BNE $9B81
L9B78:  LDA $9D8F,Y
L9B7B:  STA $6BFA,X
L9B7E:  INC $6BFB,X
L9B81:  DEC $6BFA,X
L9B84:  LDA $9D94,Y
L9B87:  CLC 
L9B88:  ADC $6BFB,X
L9B8B:  TAY 
L9B8C:  LDA $9D99,Y
L9B8F:  BPL $9BAB
L9B91:  CMP #$FF
L9B93:  BNE $9B9F
L9B95:  LDY $6BF8,X
L9B98:  LDA #$00
L9B9A:  STA $6BFB,X
L9B9D:  BEQ $9B84
L9B9F:  INC $6BFB,X
L9BA2:  JSR $9BAF
L9BA5:  LDY $6BF8,X
L9BA8:  JMP $9B84
L9BAB:  STA $6BF9,X
L9BAE:  RTS

L9BAF:  PHA 
L9BB0:  LDA MotherBrainStatus
L9BB2:  CMP #$04
L9BB4:  BCS $9BC6
L9BB6:  LDY #$60
L9BB8:  LDA $6AF4,Y
L9BBB:  BEQ $9BC8
L9BBD:  TYA 
L9BBE:  CLC 
L9BBF:  ADC #$10
L9BC1:  TAY 
L9BC2:  CMP #$A0
L9BC4:  BNE $9BB8
L9BC6:  PLA 
L9BC7:  RTS

L9BC8:  STY $4B
L9BCA:  LDA $6BF5,X
L9BCD:  STA $0400,Y
L9BD0:  LDA $6BF6,X
L9BD3:  STA $0401,Y
L9BD6:  LDA $6BF7,X
L9BD9:  STA $6AFB,Y
L9BDC:  LDA #$02
L9BDE:  STA $6AF4,Y
L9BE1:  LDA #$00
L9BE3:  STA $0409,Y
L9BE6:  STA $6AF8,Y
L9BE9:  STA $0408,Y
L9BEC:  PLA 
L9BED:  JSR $95C6
L9BF0:  TAX 
L9BF1:  STA $040A,Y
L9BF4:  ORA #$02
L9BF6:  STA EnData05,Y
L9BF9:  LDA $9C26,X
L9BFC:  STA $6AF9,Y
L9BFF:  STA $6AFA,Y
L9C02:  LDA $9DCC,X
L9C05:  STA $05
L9C07:  LDA $9DCF,X
L9C0A:  STA $04
L9C0C:  LDX $97
L9C0E:  LDA $6BF5,X
L9C11:  STA $08
L9C13:  LDA $6BF6,X
L9C16:  STA $09
L9C18:  LDA $6BF7,X
L9C1B:  STA $0B
L9C1D:  TYA 
L9C1E:  TAX 
L9C1F:  JSR CommonJump_Unknown27
L9C22:  JSR $99F4
L9C25:  LDX $97
L9C27:  RTS

L9C28:  .byte $0C, $0A, $0E

L9c2B:  LDY $6BF9,X
L9C2E:  LDA $9DC6,Y
L9C31:  STA $6BD7
L9C34:  LDA $6BF5,X
L9C37:  STA $04E0
L9C3A:  LDA $6BF6,X
L9C3D:  STA $04E1
L9C40:  LDA $6BF7,X
L9C43:  STA $6BDB
L9C46:  LDA #$E0
L9C48:  STA $4B
L9C4A:  JMP CommonJump_Unknown3C
L9C4D:  LDY #$00
L9C4F:  LDA $6BF6,X
L9C52:  CMP $FD
L9C54:  LDA $49
L9C56:  AND #$02
L9C58:  BNE $9C5F
L9C5A:  LDA $6BF5,X
L9C5D:  CMP $FC
L9C5F:  LDA $6BF7,X
L9C62:  EOR $FF
L9C64:  AND #$01
L9C66:  BEQ $9C6B
L9C68:  BCS $9C6D
L9C6A:  SEC 
L9C6B:  BCS $9C6E
L9C6D:  INY 
L9C6E:  RTS

L9C6F:  STY $02
L9C71:  LDY #$00
L9C73:  LDA $6BF7,Y
L9C76:  EOR $02
L9C78:  LSR 
L9C79:  BCS $9C80
L9C7B:  LDA #$00
L9C7D:  STA $6BF4,Y
L9C80:  TYA 
L9C81:  CLC 
L9C82:  ADC #$08
L9C84:  TAY 
L9C85:  BPL $9C73
L9C87:  LDX #$00
L9C89:  LDA $0758,X
L9C8C:  BEQ $9C99
L9C8E:  JSR $9D64
L9C91:  EOR $075A,X
L9C94:  BNE $9C99
L9C96:  STA $0758,X
L9C99:  TXA 
L9C9A:  CLC 
L9C9B:  ADC #$08
L9C9D:  TAX 
L9C9E:  CMP #$28
L9CA0:  BNE $9C89
L9CA2:  LDX #$00
L9CA4:  JSR $9CD6
L9CA7:  LDX #$03
L9CA9:  JSR $9CD6
L9CAC:  LDA MotherBrainStatus
L9CAE:  BEQ $9CC3
L9CB0:  CMP #$07
L9CB2:  BEQ $9CC3
L9CB4:  CMP #$0A
L9CB6:  BEQ $9CC3
L9CB8:  LDA $9D
L9CBA:  EOR $02
L9CBC:  LSR 
L9CBD:  BCS $9CC3
L9CBF:  LDA #$00
L9CC1:  STA MotherBrainStatus
L9CC3:  LDA $010D
L9CC6:  BEQ $9CD5
L9CC8:  LDA $010C
L9CCB:  EOR $02
L9CCD:  LSR 
L9CCE:  BCS $9CD5
L9CD0:  LDA #$00
L9CD2:  STA $010D
L9CD5:  RTS

L9CD6:  LDA $8B,X
L9CD8:  BMI $9CE5
L9CDA:  LDA $8C,X
L9CDC:  EOR $02
L9CDE:  LSR 
L9CDF:  BCS $9CE5
L9CE1:  LDA #$FF
L9CE3:  STA $8B,X
L9CE5:  RTS

L9CE6:  LDX #$00
L9CE8:  LDA $6BF4,X
L9CEB:  BEQ $9CF6
L9CED:  TXA 
L9CEE:  CLC 
L9CEF:  ADC #$08
L9CF1:  TAX 
L9CF2:  BPL $9CE8
L9CF4:  BMI $9D20
L9CF6:  LDA ($00),Y
L9CF8:  JSR $9B1B
L9CFB:  STA $6BF8,X
L9CFE:  LDA #$01
L9D00:  STA $6BF4,X
L9D03:  STA $6BFB,X
L9D06:  INY 
L9D07:  LDA ($00),Y
L9D09:  PHA 
L9D0A:  AND #$F0
L9D0C:  ORA #$07
L9D0E:  STA $6BF5,X
L9D11:  PLA 
L9D12:  JSR $9B20
L9D15:  ORA #$07
L9D17:  STA $6BF6,X
L9D1A:  JSR $9D88
L9D1D:  STA $6BF7,X
L9D20:  RTS
 
L9D21:  LDA #$01
L9D23:  STA MotherBrainStatus
L9D25:  JSR $9D88
L9D28:  STA $9D
L9D2A:  EOR #$01
L9D2C:  TAX 
L9D2D:  LDA $9D3C
L9D30:  ORA $6C,X
L9D32:  STA $6C,X
L9D34:  LDA #$20
L9D36:  STA $9A
L9D38:  STA $9B
L9D3A:  RTS 

L9D3B:  .byte $02, $01 

L9D3D:  LDA ($00),Y
L9D3F:  AND #$F0
L9D41:  LSR
L9D42:  TAX 
L9D43:  ASL 
L9D44:  AND #$10
L9D46:  EOR #$10
L9D48:  ORA #$84
L9D4A:  STA $0759,X
L9D4D:  JSR $9D64
L9D50:  STA $075A,X
L9D53:  LDA #$01
L9D55:  STA $0758,X
L9D58:  LDA #$00
L9D5A:  STA $075B,X
L9D5D:  STA $075C,X
L9D60:  STA $075D,X
L9D63:  RTS

L9D64:  JSR $9D88
L9D67:  ASL 
L9D68:  ASL 
L9D69:  ORA #$61
L9D6B:  RTS

L9D6C:  LDX #$03
L9D6E:  JSR $9D75
L9D71:  BMI $9D87
L9D73:  LDX #$00
L9D75:  LDA $8B,X
L9D77:  BPL $9D87
L9D79:  LDA ($00),Y
L9D7B:  JSR $9B1B
L9D7E:  STA $8B,X
L9D80:  JSR $9D88
L9D83:  STA $8C,X
L9D85:  LDA #$FF
L9D87:  RTS

L9D88:  LDA $FF
L9D8A:  EOR $49
L9D8C:  AND #$01
L9D8E:  RTS

L9D8F:  .byte $28, $28, $28, $28, $28, $00, $0B, $16, $21, $27, $00, $01, $02, $FD, $03, $04
L9D9F:  .byte $FD, $03, $02, $01, $FF, $00, $07, $06, $FE, $05, $04, $FE, $05, $06, $07, $FF
L9DAF:  .byte $02, $03, $FC, $04, $05, $06, $05, $FC, $04, $03, $FF, $02, $03, $FC, $04, $03
L9DBF:  .byte $FF, $06, $05, $FC, $04, $05, $FF, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $09

L9DCF:  .byte $F7, $00, $09, $09, $0B, $A5, $98, $F0, $19, $20, $24, $80, $CB, $95, $22, $9E
L9DDF:  .byte $36, $9E, $52, $9E, $86, $9E, $02, $9F, $49, $9F, $C0, $9F, $02, $9F, $DA, $9F
L9DEF:  .byte $CB, $95, $60

L9DF2:  LDA $030C
L9DF5:  EOR $9D
L9DF7:  BNE $9DF1
L9DF9:  LDA $030E
L9DFC:  SEC 
L9DFD:  SBC #$48
L9DFF:  CMP #$2F
L9E01:  BCS $9DF1
L9E03:  LDA $030D
L9E06:  SEC 
L9E07:  SBC #$80
L9E09:  BPL $9E0E
L9E0B:  JSR $95C6
L9E0E:  CMP #$20
L9E10:  BCS $9DF1
L9E12:  LDA #$00
L9E14:  STA $6E
L9E16:  LDA #$02
L9E18:  STA $6F
L9E1A:  LDA #$38
L9E1C:  STA $030A
L9E1F:  JMP CommonJump_SubtractHealth
L9E22:  JSR $9DF2
L9E25:  JSR $9FED
L9E28:  JSR $A01B
L9E2B:  JSR $A02E
L9E2E:  JSR $A041
L9E31:  LDA #$00
L9E33:  STA $9E
L9E35:  RTS

L9E36:  JSR $9E43
L9E39:  LDA $9E41,Y
L9E3C:  STA $1C
L9E3E:  JMP $9E31

L9E41:  .byte $08, $07

L9E43:  DEC $9F
L9E45:  BNE $9E4B
L9E47:  LDA #$01
L9E49:  STA MotherBrainStatus
L9E4B:  LDA $9F
L9E4D:  AND #$02
L9E4F:  LSR 
L9E50:  TAY 
L9E51:  RTS

L9E52:  JSR $9E43
L9E55:  LDA $9E41,Y
L9E58:  STA $1C
L9E5A:  TYA 
L9E5B:  ASL 
L9E5C:  ASL 
L9E5D:  STA $FC
L9E5F:  LDY MotherBrainStatus
L9E61:  DEY 
L9E62:  BNE $9E83
L9E64:  STY MotherBrainHits
L9E66:  TYA 
L9E67:  TAX 
L9E68:  TYA 
L9E69:  STA $6AF4,X
L9E6C:  JSR $9EF9
L9E6F:  CPX #$C0
L9E71:  BNE $9E68
L9E73:  LDA #$04
L9E75:  STA MotherBrainStatus
L9E77:  LDA #$28
L9E79:  STA $9F
L9E7B:  LDA $0680
L9E7E:  ORA #$01
L9E80:  STA $0680
L9E83:  JMP $9E2E
L9E86:  LDA #$10
L9E88:  ORA $0680
L9E8B:  STA $0680
L9E8E:  JSR $A072
L9E91:  INC $9A
L9E93:  JSR $9E43
L9E96:  LDX #$00
L9E98:  LDA $6AF4,X
L9E9B:  CMP #$05
L9E9D:  BNE $9EA4
L9E9F:  LDA #$00
L9EA1:  STA $6AF4,X
L9EA4:  JSR $9EF9
L9EA7:  CMP #$40
L9EA9:  BNE $9E98
L9EAB:  LDA $07A0
L9EAE:  BNE $9EB5
L9EB0:  LDA $9F00,Y
L9EB3:  STA $1C
L9EB5:  LDY MotherBrainStatus
L9EB7:  DEY 
L9EB8:  BNE $9ED5
L9EBA:  STY $9A
L9EBC:  LDA #$04
L9EBE:  STA MotherBrainStatus
L9EC0:  LDA #$1C
L9EC2:  STA $9F
L9EC4:  LDY MotherBrainHits
L9EC6:  INC MotherBrainHits
L9EC8:  CPY #$04
L9ECA:  BEQ $9ED3
L9ECC:  LDX #$00
L9ECE:  BCC $9ED5
L9ED0:  JMP $9ED6
L9ED3:  LSR $9F
L9ED5:  RTS

L9ED6:  LDA $0685
L9ED9:  ORA #$04
L9EDB:  STA $0685
L9EDE:  LDA #$05
L9EE0:  STA MotherBrainStatus
L9EE2:  LDA #$80
L9EE4:  STA MotherBrainHits
L9EE6:  RTS

L9EE7:  PHA 
L9EE8:  AND #$F0
L9EEA:  ORA #$07
L9EEC:  STA $0400,X
L9EEF:  PLA 
L9EF0:  JSR $9B20
L9EF3:  ORA #$07
L9EF5:  STA $0401,X
L9EF8:  RTS

L9EF9:  TXA 
L9EFA:  CLC 
L9EFB:  ADC #$10
L9EFD:  TAX 
L9EFE:  RTS

L9EFF:  .byte $60

L9F00:  ORA #$0A
L9F02:  LDA MotherBrainHits
L9F04:  BMI $9F33
L9F06:  CMP #$08
L9F08:  BEQ $9F36
L9F0A:  TAY 
L9F0B:  LDA $9F41,Y
L9F0E:  STA $0503
L9F11:  LDA $9F39,Y
L9F14:  CLC 
L9F15:  ADC #$42
L9F17:  STA $0508
L9F1A:  PHP 
L9F1B:  LDA $9D
L9F1D:  ASL 
L9F1E:  ASL 
L9F1F:  PLP 
L9F20:  ADC #$61
L9F22:  STA $0509
L9F25:  LDA #$00
L9F27:  STA $4B
L9F29:  LDA $07A0
L9F2C:  BNE $9F38
L9F2E:  JSR CommonJump_DrawTileBlast
L9F31:  BCS $9F38
L9F33:  INC MotherBrainHits
L9F35:  RTS

L9F36:  INC MotherBrainStatus
L9F38:  RTS

L9F39:  .byte $00, $40, $08, $48, $80, $C0, $88, $C8, $08, $02, $09, $03, $0A, $04, $0B

L9F48:  ORA $20
L9F4A:  ADC #$9F
L9F4C:  BCS $9F64
L9F4E:  LDA #$00
L9F50:  STA MotherBrainStatus
L9F52:  LDA #$99
L9F54:  STA $010A
L9F57:  STA $010B
L9F5A:  LDA #$01
L9F5C:  STA $010D
L9F5F:  LDA $9D
L9F61:  STA $010C
L9F64:  RTS 

L9F65:  .byte $80, $B0, $A0, $90

L9F69:  LDA $50 
L9F6B:  CLC
L9F6C:  ADC $4F
L9F6E:  SEC 
L9F6F:  ROL 
L9F70:  AND #$03
L9F72:  TAY 
L9F73:  LDX $9F65,Y
L9F76:  LDA #$01
L9F78:  STA $030F,X
L9F7B:  LDA #$01
L9F7D:  STA $0307,X
L9F80:  LDA #$03
L9F82:  STA $0300,X
L9F85:  LDA $9D
L9F87:  STA $030C,X
L9F8A:  LDA #$10
L9F8C:  STA $030E,X
L9F8F:  LDA #$68
L9F91:  STA $030D,X
L9F94:  LDA #$55
L9F96:  STA $0305,X
L9F99:  STA $0306,X
L9F9C:  LDA #$00
L9F9E:  STA $0304,X
L9FA1:  LDA #$F7
L9FA3:  STA $0303,X
L9FA6:  LDA #$10
L9FA8:  STA $0503
L9FAB:  LDA #$40
L9FAD:  STA $0508
L9FB0:  LDA $9D
L9FB2:  ASL 
L9FB3:  ASL 
L9FB4:  ORA #$61
L9FB6:  STA $0509
L9FB9:  LDA #$00
L9FBB:  STA $4B
L9FBD:  JMP CommonJump_DrawTileBlast
L9FC0:  LDA #$10
L9FC2:  ORA $0680
L9FC5:  STA $0680
L9FC8:  LDA $2C
L9FCA:  BNE $9FD9
L9FCC:  LDA #$08
L9FCE:  STA $0300
L9FD1:  LDA #$0A
L9FD3:  STA MotherBrainStatus
L9FD5:  LDA #$01
L9FD7:  STA $1C
L9FD9:  RTS

L9FDA:  JSR $9F69
L9FDD:  BCS $9FEC
L9FDF:  LDA $9D
L9FE1:  STA $010C
L9FE4:  LDY #$01
L9FE6:  STY $010D
L9FE9:  DEY 
L9FEA:  STY MotherBrainStatus
L9FEC:  RTS

L9FED:  LDA $9E
L9FEF:  BEQ $A01A
L9FF1:  LDA $0684
L9FF4:  ORA #$02
L9FF6:  STA $0684
L9FF9:  INC MotherBrainHits
L9FFB:  LDA MotherBrainHits
L9FFD:  CMP #$20
L9FFF:  LDY #$02
LA001:  LDA #$10
LA003:  BCC $A016
LA005:  LDX #$00
LA007:  LDA #$00
LA009:  STA $0500,X
LA00C:  JSR $9EF9
LA00F:  CMP #$D0
LA011:  BNE $A007
LA013:  INY 
LA014:  LDA #$80
LA016:  STY MotherBrainStatus
LA018:  STA $9F
LA01A:  RTS

LA01B:  DEC $9A
LA01D:  BNE $A02D
LA01F:  LDA $2E
LA021:  AND #$03
LA023:  STA $9C
LA025:  LDA #$20
LA027:  SEC 
LA028:  SBC MotherBrainHits
LA02A:  LSR 
LA02B:  STA $9A
LA02D:  RTS

LA02E:  DEC $9B
LA030:  LDA $9B
LA032:  ASL 
LA033:  BNE $A040
LA035:  LDA #$20
LA037:  SEC 
LA038:  SBC MotherBrainHits
LA03A:  ORA #$80
LA03C:  EOR $9B
LA03E:  STA $9B
LA040:  RTS

LA041:  LDA #$E0
LA043:  STA $4B
LA045:  LDA $9D
LA047:  STA $6BDB
LA04A:  LDA #$70
LA04C:  STA $04E0
LA04F:  LDA #$48
LA051:  STA $04E1
LA054:  LDY $9C
LA056:  LDA $A06D,Y
LA059:  STA $6BD7
LA05C:  JSR CommonJump_Unknown3C
LA05F:  LDA $9B
LA061:  BMI $A06C
LA063:  LDA $A071
LA066:  STA $6BD7
LA069:  JSR CommonJump_Unknown3C
LA06C:  RTS

LA06D:  .byte $13, $14, $15, $16, $17

LA072:  LDY MotherBrainHits
LA074:  BEQ $A086
LA076:  LDA $A0C0,Y
LA079:  CLC 
LA07A:  ADC $9A
LA07C:  TAY 
LA07D:  LDA $A0A3,Y
LA080:  CMP #$FF
LA082:  BNE $A087
LA084:  DEC $9A
LA086:  RTS

LA087:  ADC #$44
LA089:  STA $0508
LA08C:  PHP 
LA08D:  LDA $9D
LA08F:  ASL 
LA090:  ASL 
LA091:  ORA #$61
LA093:  PLP 
LA094:  ADC #$00
LA096:  STA $0509
LA099:  LDA #$00
LA09B:  STA $0503
LA09E:  STA $4B
LA0A0:  JMP CommonJump_DrawTileBlast

LA0A3:  .byte $00, $02, $04, $06, $08, $40, $80, $C0, $48, $88, $C8, $FF, $42, $81, $C1, $27
LA0B3:  .byte $FF, $82, $43, $25, $47, $FF, $C2, $C4, $C6, $FF, $84, $45, $86, $FF, $00, $0C
LA0C3:  .byte $11, $16, $1A

LA0C6:  LDA $71
LA0C8:  BEQ $A13E
LA0CA:  LDX $4B
LA0CC:  LDA $0300,X
LA0CF:  CMP #$0B
LA0D1:  BNE $A13E
LA0D3:  CPY #$98
LA0D5:  BNE $A103
LA0D7:  LDX #$00
LA0D9:  LDA $0500,X
LA0DC:  BEQ $A0E7
LA0DE:  JSR $9EF9
LA0E1:  CMP #$D0
LA0E3:  BNE $A0D9
LA0E5:  BEQ $A13E
LA0E7:  LDA #$8C
LA0E9:  STA $0508,X
LA0EC:  LDA $05
LA0EE:  STA $0509,X
LA0F1:  LDA #$01
LA0F3:  STA $0503,X
LA0F6:  LDA $4B
LA0F8:  PHA 
LA0F9:  STX $4B
LA0FB:  JSR CommonJump_DrawTileBlast
LA0FE:  PLA 
LA0FF:  STA $4B
LA101:  BNE $A13E
LA103:  LDA $04
LA105:  LSR 
LA106:  BCC $A10A
LA108:  DEC $04
LA10A:  LDY #$00
LA10C:  LDA ($04),Y
LA10E:  LSR 
LA10F:  BCS $A13E
LA111:  CMP #$48
LA113:  BCC $A13E
LA115:  CMP #$4C
LA117:  BCS $A13E
LA119:  LDA $0758,Y
LA11C:  BEQ $A12E
LA11E:  LDA $04
LA120:  AND #$9E
LA122:  CMP $0759,Y
LA125:  BNE $A12E
LA127:  LDA $05
LA129:  CMP $075A,Y
LA12C:  BEQ $A139
LA12E:  TYA 
LA12F:  CLC 
LA130:  ADC #$08
LA132:  TAY 
LA133:  CMP #$28
LA135:  BNE $A119
LA137:  BEQ $A13E
LA139:  LDA #$01
LA13B:  STA $075D,Y
LA13E:  PLA 
LA13F:  PLA 
LA140:  CLC 
LA141:  RTS

LA142:  TAY 
LA143:  LDA $71
LA145:  BEQ $A15C
LA147:  LDX $4B
LA149:  LDA $0300,X
LA14C:  CMP #$0B
LA14E:  BNE $A15C
LA150:  CPY #$5E
LA152:  BCC $A15C
LA154:  CPY #$72
LA156:  BCS $A15C
LA158:  LDA #$01
LA15A:  STA $9E
LA15C:  TYA 
LA15D:  RTS

LA15E:  LDY $010B
LA161:  INY 
LA162:  BNE $A1DA
LA164:  LDY #$03
LA166:  JSR $A16B
LA169:  LDY #$00
LA16B:  STY $4B
LA16D:  LDA $008B,Y
LA170:  BMI $A15D
LA172:  LDA $008C,Y
LA175:  EOR $2D
LA177:  LSR 
LA178:  BCC $A15D
LA17A:  LDA MotherBrainStatus
LA17C:  CMP #$04
LA17E:  BCS $A15D
LA180:  LDA $2D
LA182:  AND #$06
LA184:  BNE $A15D
LA186:  LDX #$20
LA188:  LDA $6AF4,X
LA18B:  BEQ $A19C
LA18D:  LDA EnData05,X
LA190:  AND #$02
LA192:  BEQ $A19C
LA194:  TXA 
LA195:  SEC 
LA196:  SBC #$10
LA198:  TAX 
LA199:  BPL $A188
LA19B:  RTS

LA19C:  LDA #$01
LA19E:  STA $6AF4,X
LA1A1:  LDA #$04
LA1A3:  STA EnDataIndex,X
LA1A6:  LDA #$00
LA1A8:  STA $040F,X
LA1AB:  STA $0404,X
LA1AE:  JSR CommonJump_Unknown2A
LA1B1:  LDA #$F7
LA1B3:  STA $6AF7,X
LA1B6:  LDY $4B
LA1B8:  LDA $008C,Y
LA1BB:  STA $6AFB,X
LA1BE:  LDA $008D,Y
LA1C1:  ASL 
LA1C2:  ORA $008B,Y
LA1C5:  TAY 
LA1C6:  LDA $A1DB,Y
LA1C9:  JSR $9EE7
LA1CC:  LDX $4B
LA1CE:  INC $8D,X
LA1D0:  LDA $8D,X
LA1D2:  CMP #$06
LA1D4:  BNE $A1DA
LA1D6:  LDA #$00
LA1D8:  STA $8D,X
LA1DA:  RTS

LA1DB:  .byte $22, $2A, $2A, $BA, $B2, $2A, $C4, $2A, $C8, $BA, $BA, $BA

LA1E7:  LDY $010B
LA1EA:  INY 
LA1EB:  BEQ $A237
LA1ED:  LDA $010A
LA1F0:  STA $03
LA1F2:  LDA #$01
LA1F4:  SEC 
LA1F5:  JSR CommonJump_Base10Subtract
LA1F8:  STA $010A
LA1FB:  LDA $010B
LA1FE:  STA $03
LA200:  LDA #$00
LA202:  JSR CommonJump_Base10Subtract
LA205:  STA $010B
LA208:  LDA $2D
LA20A:  AND #$1F
LA20C:  BNE $A216
LA20E:  LDA $0681
LA211:  ORA #$08
LA213:  STA $0681
LA216:  LDA $010A
LA219:  ORA $010B
LA21C:  BNE $A237
LA21E:  DEC $010B
LA221:  STA MotherBrainHits
LA223:  LDA #$07
LA225:  STA MotherBrainStatus
LA227:  LDA $0680
LA22A:  ORA #$01
LA22C:  STA $0680
LA22F:  LDA #$0C
LA231:  STA $2C
LA233:  LDA #$0B
LA235:  STA $1C
LA237:  RTS

LA238:  LDA $010D
LA23B:  BEQ $A28A
LA23D:  LDA $010C
LA240:  STA $6BDB
LA243:  LDA #$84
LA245:  STA $04E0
LA248:  LDA #$64
LA24A:  STA $04E1
LA24D:  LDA #$1A
LA24F:  STA $6BD7
LA252:  LDA #$E0
LA254:  STA $4B
LA256:  LDA $5B
LA258:  PHA 
LA259:  JSR CommonJump_Unknown3C
LA25C:  PLA 
LA25D:  CMP $5B
LA25F:  BEQ $A28A
LA261:  TAX 
LA262:  LDA $010B
LA265:  LSR 
LA266:  LSR 
LA267:  LSR 
LA268:  SEC 
LA269:  ROR 
LA26A:  AND #$0F
LA26C:  ORA #$A0
LA26E:  STA $0201,X
LA271:  LDA $010B
LA274:  AND #$0F
LA276:  ORA #$A0
LA278:  STA $0205,X
LA27B:  LDA $010A
LA27E:  LSR 
LA27F:  LSR 
LA280:  LSR 
LA281:  SEC 
LA282:  ROR 
LA283:  AND #$0F
LA285:  ORA #$A0
LA287:  STA $0209,X
LA28A:  RTS

LA28B:  LDA #$10
LA28D:  STA $4B
LA28F:  LDX #$20
LA291:  JSR $A29B
LA294:  TXA 
LA295:  SEC 
LA296:  SBC #$08
LA298:  TAX 
LA299:  BNE $A291
LA29B:  LDA $0758,X
LA29E:  AND #$0F
LA2A0:  CMP #$01
LA2A2:  BNE $A28A
LA2A4:  LDA $075D,X
LA2A7:  BEQ $A2F2
LA2A9:  INC $075B,X
LA2AC:  LDA $075B,X
LA2AF:  LSR 
LA2B0:  BCS $A2F2
LA2B2:  TAY 
LA2B3:  SBC #$03
LA2B5:  BNE $A2BA
LA2B7:  INC $0758,X
LA2BA:  LDA $A310,Y
LA2BD:  STA $0513
LA2C0:  LDA $0759,X
LA2C3:  STA $0518
LA2C6:  LDA $075A,X
LA2C9:  STA $0519
LA2CC:  LDA $07A0
LA2CF:  BNE $A2DA
LA2D1:  TXA 
LA2D2:  PHA 
LA2D3:  JSR CommonJump_DrawTileBlast
LA2D6:  PLA 
LA2D7:  TAX 
LA2D8:  BCC $A2EB
LA2DA:  LDA $0758,X
LA2DD:  AND #$80
LA2DF:  ORA #$01
LA2E1:  STA $0758,X
LA2E4:  STA $075D,X
LA2E7:  DEC $075B,X
LA2EA:  RTS

LA2EB:  LDA #$40
LA2ED:  STA $075C,X
LA2F0:  BNE $A30A
LA2F2:  LDY $075B,X
LA2F5:  BEQ $A30A
LA2F7:  DEC $075C,X
LA2FA:  BNE $A30A
LA2FC:  LDA #$40
LA2FE:  STA $075C,X
LA301:  DEY 
LA302:  TYA 
LA303:  STA $075B,X
LA306:  LSR 
LA307:  TAY 
LA308:  BCC $A2BA
LA30A:  LDA #$00
LA30C:  STA $075D,X
LA30F:  RTS

LA310:  .byte $0C, $0D, $0E, $0F, $07

LA315:  LDY #$05
LA317:  JSR $99B1
LA31A:  DEY 
LA31B:  BPL $A317
LA31D:  STA $92
LA31F:  RTS

LA320:  TXA 
LA321:  JSR $9B1B
LA324:  TAY 
LA325:  JSR $99B1
LA328:  STA $92
LA32A:  RTS

LA32B:  .byte $22, $FF, $FF, $FF, $FF

LA330:  .byte $32, $FF, $FF, $FF, $FF, $FF, $FF

LA337:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E0, $DE, $ED, $FF, $E8
LA347:  .byte $EE 

LA348:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $ED, $FF, $DF, $DA, $EC, $ED, $F4
LA358:  .byte $FF

LA359:  .byte $28, $FF, $FF, $FF, $FF, $ED, $E2, $E6, $DE, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA369:  .byte $FF

LA36A:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA37A:  .byte $FF

LA37B:  .byte $62, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

LA388:  .byte $42, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

LA391:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $ED, $E2, $E6, $DE, $FF
LA3A1:  .byte $DB

LA3A2:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $E8, $E6, $DB, $FF, $EC, $DE, $ED
LA3B2:  .byte $FF

LA3B3:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA3C3:  .byte $FF

LA3C4:  .byte $28, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA3D4:  .byte $FF

LA3D5:  .byte $42, $90, $91, $90, $91, $90, $91, $90, $91

LA3DE:  .byte $42, $92, $93, $92, $93, $92, $93, $92, $93

LA3E7:  .byte $42, $94, $95, $94, $95, $94, $95, $94, $95

LA3F0:  .byte $42, $96, $97, $96, $97, $96, $97, $96, $97

LA3F9:  .byte $62, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
LA406:  .byte $00, $01, $FF

LA409:  .byte $02, $FF

LA40B:  .byte $03, $04, $FF

LA40E:  .byte $05, $FF

LA410:  .byte $0E, $FF

LA412:  .byte $0F, $FF

LA414:  .byte $10, $FF

LA416:  .byte $11, $11, $12, $12, $F7, $FF

LA41C:  .byte $18, $FF

LA41E:  .byte $19, $F7, $FF

LA421:  .byte $1B, $1C, $1D, $FF

LA425:  .byte $1E, $FF

LA427:  .byte $61, $F7, $62, $F7, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
LA42C:  .word $A5C8, $A5CD, $A5D2, $A5D7, $A5E4, $A5F1, $A5FB, $A600
LA43C:  .word $A606, $A60D, $A613, $A618, $A61E, $A625, $A62B, $A630
LA44C:  .word $A635, $A63A, $A641, $A651, $A65F, $A66B, $A678, $A687
LA45C:  .word $A691, $A69C, $A6A3, $A6AC, $A6BC, $A6CC, $A6DC, $A6E0
LA46C:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA47C:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA48C:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA49C:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA4AC:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA4BC:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA4CC:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA4DC:  .word $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0, $A6E0
LA4EC:  .word $A6E0, $A6E0, $A6EE, $A708, $A708, $A708, $A708, $A708
LA4FC:  .word $A708, $A708, $A708, $A708, $A708, $A708, $A708, $A708
LA50C:  .word $A708, $A708, $A708, $A708, $A708, $A708, $A708, $A708
LA51C:  .word $A708, $A708, $A708, $A708, $A708, $A708, $A708, $A708

EnemyFramePtrTbl2:
LA52C:  .word $A708, $A70E, $A713, $A713, $A713, $A713, $A713, $A713
LA53C:  .word $A713, $A713

EnemyPlacePtrTbl:
LA540:  .word $A560, $A562, $A57A, $A58C, $A592, $A59E, $A5A4, $A5A4
LA550:  .word $A5A4, $A5A4, $A5A4, $A5C4, $A5C4, $A5C8, $A5C8, $A5C8

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

LA560:  .byte $FC, $FC

LA562:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
LA572:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

LA57A:  .byte $F4, $F4, $F4, $FC, $F4, $04, $FC, $F4, $FC, $FC, $FC, $04, $04, $F4, $04, $FC
LA58A:  .byte $04, $04

LA58C:  .byte $F1, $FC, $F3, $F3, $FC, $F1

LA592:  .byte $F4, $F8, $F4, $00, $FC, $F8, $FC, $00, $04, $F8, $04, $00

LA59E:  .byte $FC, $F4, $FC, $FC, $FC, $04

LA5A4:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
LA5B4:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

LA5C4:  .byte $F8, $FC, $00, $FC

;Enemy frame drawing data.

LA5C8:  .byte $00, $02, $02, $14, $FF

LA5CD:  .byte $00, $02, $02, $24, $FF

LA5D2:  .byte $00, $00, $00, $04, $FF

LA5D7:  .byte $32, $0C, $0C, $C0, $C1, $C2, $D0, $D1, $D2, $E0, $E1, $E2, $FF

LA5E4:  .byte $32, $0C, $0C, $C3, $C4, $C5, $D3, $D4, $D5, $E3, $E4, $E5, $FF

LA5F1:  .byte $31, $00, $00, $C0, $C2, $D0, $D2, $E0, $E2, $FF

LA5FB:  .byte $23, $07, $07, $EA, $FF

LA600:  .byte $23, $07, $07, $FE, $EB, $FF

LA606:  .byte $23, $07, $07, $FE, $FE, $EC, $FF

LA60D:  .byte $A3, $07, $07, $FE, $EB, $FF

LA613:  .byte $A3, $07, $07, $EA, $FF

LA618:  .byte $E3, $07, $07, $FE, $EB, $FF

LA61E:  .byte $63, $07, $07, $FE, $FE, $EC, $FF

LA625:  .byte $63, $07, $07, $FE, $EB, $FF

LA62B:  .byte $30, $04, $04, $F1, $FF

LA630:  .byte $70, $04, $04, $F1, $FF

LA635:  .byte $30, $04, $04, $F2, $FF

LA63A:  .byte $30, $00, $00, $FD, $03, $F3, $FF

LA641:  .byte $0A, $00, $00, $FD, $00, $F4, $FD, $40, $F4, $FD, $80, $F4, $FD, $C0, $F4, $FF

LA651:  .byte $24, $08, $14, $FD, $02, $FC, $04, $F0, $D8, $D9, $E8, $E9, $F8, $FF

LA65F:  .byte $24, $14, $0C, $FD, $02, $FC, $F4, $F8, $DA, $FE, $C9, $FF

LA66B:  .byte $24, $20, $04, $FD, $02, $FC, $EC, $00, $CB, $CC, $DB, $DC, $FF

LA678:  .byte $24, $18, $14, $FD, $02, $FC, $F4, $10, $DD, $CE, $FE, $DE, $FE, $DD, $FF

LA687:  .byte $24, $08, $0C, $FD, $02, $FC, $0C, $10, $CD, $FF

LA691:  .byte $21, $00, $00, $FE, $F5, $F5, $F5, $F5, $F5, $F5, $FF

LA69C:  .byte $30, $00, $00, $FD, $03, $ED, $FF

LA6A3:  .byte $05, $04, $08, $FD, $00, $00, $00, $00, $FF

LA6AC:  .byte $3A, $08, $08, $FD, $03, $EF, $FD, $43, $EF, $FD, $83, $EF, $FD, $C3, $EF, $FF

LA6BC:  .byte $3A, $08, $08, $FD, $03, $DF, $FD, $43, $DF, $FD, $83, $DF, $FD, $C3, $DF, $FF

LA6CC:  .byte $2A, $08, $08, $FD, $03, $CF, $FD, $43, $CF, $FD, $83, $CF, $FD, $C3, $CF, $FF

LA6DC:  .byte $01, $00, $00, $FF

LA6E0:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA6EE:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA6FE:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA708:  .byte $0C, $08, $04, $14, $24, $FF

LA70E:  .byte $00, $04, $04, $8A, $FF

LA713:  .byte $00, $04, $04, $8A, $FF

;-----------------------------------------[ Palette data ]-------------------------------------------

Palette00:
LA718:  .byte $3F                       ;Upper byte of PPU palette adress.
LA719:  .byte $00                       ;Lower byte of PPU palette adress.
LA71A:  .byte $20                       ;Palette data length.
;The following values are written to the background palette:
LA71B:  .byte $0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $16, $20, $00, $0F, $20, $10, $00
;The following values are written to the sprite palette:
LA72B:  .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $16, $30, $0F, $16, $2A, $37

LA73B:  .byte $00                       ;End Palette00 info.

Palette01:
LA73C:  .byte $3F                       ;Upper byte of PPU palette adress.
LA73D:  .byte $12                       ;Lower byte of PPU palette adress.
LA73E:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA73F:  .byte $19, $27

LA741:  .byte $00                       ;End Palette01 info.

Palette03:
LA742:  .byte $3F                       ;Upper byte of PPU palette adress.
LA743:  .byte $12                       ;Lower byte of PPU palette adress.
LA744:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA745:  .byte $2C, $27

LA747:  .byte $00                       ;End Palette03 info.

Palette02:
LA748:  .byte $3F                       ;Upper byte of PPU palette adress.
LA749:  .byte $12                       ;Lower byte of PPU palette adress.
LA74A:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA74B:  .byte $19, $35

LA74D:  .byte $00                       ;End Palette02 info.

Palette04:
LA74E:  .byte $3F                       ;Upper byte of PPU palette adress.
LA74F:  .byte $12                       ;Lower byte of PPU palette adress.
LA750:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA751:  .byte $2C, $24

LA753:  .byte $00                       ;End Palette04 info.

Palette05:
LA754:  .byte $3F                       ;Upper byte of PPU palette adress.
LA755:  .byte $0A                       ;Lower byte of PPU palette adress.
LA756:  .byte $01                       ;Palette data length.
;The following values are written to the background palette:
LA757:  .byte $27

LA758:  .byte $00                       ;End Palette05 info.

Palette06:
LA759:  .byte $3F                       ;Upper byte of PPU palette adress.
LA75A:  .byte $0A                       ;Lower byte of PPU palette adress.
LA75B:  .byte $01                       ;Palette data length.
;The following values are written to the background palette:
LA75C:  .byte $20

LA75D:  .byte $00                       ;End Palette06 info.

Palette07:
LA75E:  .byte $3F                       ;Upper byte of PPU palette adress.
LA75F:  .byte $00                       ;Lower byte of PPU palette adress.
LA760:  .byte $11                       ;Palette data length.
;The following values are written to the background palette:
LA761:  .byte $0F, $20, $16, $00, $0F, $20, $11, $00, $0F, $20, $16, $00, $0F, $20, $10, $00
LA771:  .byte $0F

LA772:  .byte $00                       ;End Palette07 info.

Palette08:
LA773:  .byte $3F                       ;Upper byte of PPU palette adress.
LA774:  .byte $00                       ;Lower byte of PPU palette adress.
LA775:  .byte $11                       ;Palette data length.
;The following values are written to the background palette:
LA776:  .byte $20, $02, $16, $00, $20, $02, $11, $00, $20, $02, $16, $00, $20, $02, $10, $00
LA786:  .byte $20

LA787:  .byte $00                       ;End Palette08 info.

Palette09:
LA788:  .byte $3F                       ;Upper byte of PPU palette adress.
LA789:  .byte $00                       ;Lower byte of PPU palette adress.
LA78A:  .byte $60                       ;Lower byte of PPU palette adress.
LA78B:  .byte $20                       ;Repeat bit set. Fill sprite and background palette with #$20.

LA78C:  .byte $00                       ;End Palette09 info.

Palette0A:
LA78D:  .byte $3F                       ;Upper byte of PPU palette adress.
LA78E:  .byte $11                       ;Lower byte of PPU palette adress.
LA78F:  .byte $03
;The following values are written to the sprite palette:
LA790:  .byte $04, $09, $07

LA793:  .byte $00                       ;End Palette0A info.

Palette0B:
LA794:  .byte $3F                       ;Upper byte of PPU palette adress.
LA795:  .byte $11                       ;Lower byte of PPU palette adress.
LA796:  .byte $03                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA797:  .byte $05, $09, $17

LA79A:  .byte $00                       ;End Palette0B info.

Palette0C:
LA79B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA79C:  .byte $11                       ;Lower byte of PPU palette adress.
LA79D:  .byte $03                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA79E:  .byte $06, $0A, $26

LA7A1:  .byte $00                       ;End Palette0C info.

Palette0D:
LA7A2:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7A3:  .byte $11                       ;Lower byte of PPU palette adress.
LA7A4:  .byte $03                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA7A5:  .byte $16, $19, $27

LA7A8:  .byte $00                       ;End Palette0D info.

Palette0E:
LA7A9:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7AA:  .byte $00                       ;Lower byte of PPU palette adress.
LA7AB:  .byte $04                       ;Lower byte of PPU palette adress.
;The following values are written to the background palette:
LA7AC:  .byte $0F, $30, $30, $21

LA7B0:  .byte $00                       ;End Palette0E info.

Palette0F:
LA7B1:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7B2:  .byte $10                       ;Lower byte of PPU palette adress.
LA7B3:  .byte $04                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA7B4:  .byte $0F, $15, $34, $17

LA7B8:  .byte $00                       ;End Palette0F info.

Palette10:
LA7B9:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7BA:  .byte $10                       ;Lower byte of PPU palette adress.
LA7BB:  .byte $04                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA7BC:  .byte $0F, $15, $34, $19

LA7C0:  .byte $00                       ;End Palette10 info.

Palette11:
LA7C1:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7C2:  .byte $10                       ;Lower byte of PPU palette adress.
LA7C3:  .byte $04                       ;Lower byte of PPU palette adress.
;The following values are written to the sprite palette:
LA7C4:  .byte $0F, $15, $34, $28

LA7C8:  .byte $00                       ;End Palette11 info.

Palette12:
LA7C9:  .byte $3F                       ;Upper byte of PPU palette adress.
LA7CA:  .byte $10                       ;Lower byte of PPU palette adress.
LA7CB:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA7CC:  .byte $0F, $15, $34, $29

LA7D0:  .byte $00                       ;End Palette12 info.

;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
LA7D1:  .word $A8AF, $A8BD, $A8C5, $A8FA, $A929, $A95E, $A975, $A990
LA7E1:  .word $A9AB, $A9CF, $A9F2, $AA33, $AA75, $AAAE, $AAE3, $AB12
LA7F1:  .word $AB4A, $AB7C, $ABA5, $ABCE, $ABEF

StrctPtrTbl:
LA7FB:  .word $AC16, $AC29, $AC50, $AC69, $AC70, $AC77, $AC7A, $AC8B
LA80B:  .word $ACA4, $ACB5, $ACC6, $ACD0, $ACF9, $AD26, $AD2D, $AD3C
LA81B:  .word $AD3F, $AD48, $AD61, $AD66, $AD6B, $AD99, $ADAC, $ADC8
LA82B:  .word $ADDD, $ADFE, $AE0F, $AE1A, $AE1E, $AE21, $AE2C, $AE36

;------------------------------------[ Special items table ]-----------------------------------------

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

;Elevator to end.
LA83B:  .byte $03
LA83C:  .word $A843
LA83E:  .byte $01, $FF, $04, $8F, $00 

;Elevator to Brinstar.
LA843:  .byte $04
LA844:  .word $A84B
LA846:  .byte $03, $FF, $04, $83, $00

;10 missile door.
LA84B:  .byte $07
LA84C:  .word $A85B
LA84E:  .byte $03, $05, $09, $A2, $00

;Rinkas
LA853:  .byte $04, $04, $08, $00

;Rinkas
LA857:  .byte $09, $FF, $08, $00

;Rinkas
LA85B:  .byte $08
LA85C:  .word $A862
LA85E:  .byte $0A, $FF, $18, $00

;Rinkas
LA862:  .byte $09
LA863:  .word $A869
LA865:  .byte $0A, $FF, $08, $00

;Rinkas
LA869:  .byte $0A
LA86A:  .word $A870
LA86C:  .byte $0A, $FF, $18, $00

;Door at bottom of escape shaft.
LA870:  .byte $0B
LA871:  .word $FFFF
LA873:  .byte $01, $05, $09, $A3, $00

;Mother brain, Zeebetite, 3 cannons and Rinkas.
LA878:  .byte $02, $0C, $06, $47, $18, $05, $49, $15, $4B, $25, $3E, $00

;2 Zeebetites, 6 cannons and Rinkas.
LA884:  .byte $03, $12, $37, $27, $08, $05, $41, $15, $43, $25, $36, $05, $49, $15, $4B, $35
LA894:  .byte $3E, $00

;Right door, 2 Zeebetites, 6 cannons and Rinkas.
LA896:  .byte $04, $14, $09, $A3, $17, $07, $08, $05, $41, $15, $43, $25, $36, $05, $49, $15
LA8A6:  .byte $4B, $35, $3E, $00

;Left door.
LA8AA:  .byte $05, $FF, $09, $B3, $00 

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
LA8AF:  .byte $02                       ;Attribute table data.
;Room object data:
LA8B0:  .byte $40, $01, $03, $48, $01, $03, $50, $03, $02, $5F, $03, $02, $FF

;Room #$01
LA8BD:  .byte $02                       ;Attribute table data.
;Room object data:
LA8BE:  .byte $07, $02, $02, $87, $02, $02, $FF

;Room #$02
LA8C5:  .byte $03                       ;Attribute table data.
;Room object data:
LA8C6:  .byte $00, $0C, $03, $08, $0C, $03, $0F, $09, $03, $5F, $04, $02, $62, $13, $02, $6A
LA8D6:  .byte $13, $02, $82, $0E, $02, $85, $12, $01, $8A, $0E, $02, $8D, $12, $01, $8F, $09
LA8E6:  .byte $03, $C4, $0F, $03, $C8, $0F, $03, $D3, $10, $03, $DB, $0A, $03, $E0, $0A, $03
LA8F6:  .byte $E8, $0A, $03, $FF

;Room #$03
LA8FA:  .byte $00                       ;Attribute table data.
;Room object data:
LA8FB:  .byte $00, $0C, $03, $08, $0C, $03, $62, $13, $02, $6A, $13, $02, $82, $0E, $02, $85
LA90B:  .byte $12, $01, $8A, $0E, $02, $8D, $12, $01, $C4, $0F, $03, $C8, $0F, $03, $D0, $0D
LA91B:  .byte $02, $D3, $10, $03, $DB, $0A, $03, $E2, $0A, $03, $EA, $0A, $03, $FF

;Room #$04
LA929:  .byte $03                       ;Attribute table data.
;Room object data:
LA92A:  .byte $00, $09, $03, $01, $0A, $03, $03, $11, $03, $08, $0C, $03, $0E, $1C, $03, $52
LA93A:  .byte $07, $01, $53, $08, $02, $6A, $13, $02, $80, $09, $03, $8A, $0E, $02, $8D, $12
LA94A:  .byte $01, $91, $0B, $03, $CB, $1C, $03, $CC, $1C, $03, $D8, $0D, $02, $DB, $00, $02
LA95A:  .byte $E0, $0A, $03, $FF

;Room #$05
LA95E:  .byte $03                       ;Attribute table data.
;Room object data:
LA95F:  .byte $00, $14, $03, $08, $14, $03, $50, $04, $02, $80, $14, $03, $88, $14, $03, $D0
LA96F:  .byte $14, $03, $D8, $14, $03, $FF

;Room #$06
LA975:  .byte $03                       ;Attribute table data.
;Room object data:
LA976:  .byte $00, $14, $03, $08, $14, $03, $95, $14, $03, $D0, $14, $03, $D8, $14, $03, $FD
;Room enemy/door data:
LA986:  .byte $01, $01, $45, $11, $00, $89, $21, $01, $B3, $FF

;Room #$07
LA990:  .byte $03                       ;Attribute table data.
;Room object data:
LA991:  .byte $00, $16, $03, $08, $16, $03, $30, $15, $03, $38, $15, $03, $D0, $15, $03, $D8
LA9A1:  .byte $15, $03, $FD
;Room enemy/door data:
LA9A4:  .byte $31, $01, $69, $41, $00, $B5, $FF

;Room #$08
LA9AB:  .byte $01                       ;Attribute table data.
;Room object data:
LA9AC:  .byte $00, $16, $03, $08, $16, $03, $30, $15, $03, $38, $15, $03, $D0, $17, $03, $D4
LA9BC:  .byte $00, $02, $D7, $17, $03, $DC, $17, $03, $FD
;Room enemy/door data:
LA9C5:  .byte $01, $01, $45, $11, $00, $89, $21, $01, $D4, $FF

;Room #$09
LA9CF:  .byte $01                       ;Attribute table data.
;Room object data:
LA9D0:  .byte $00, $16, $03, $08, $16, $03, $30, $15, $03, $38, $15, $03, $5F, $03, $02, $8C
LA9E0:  .byte $17, $03, $B8, $17, $03, $CC, $17, $03, $D0, $00, $02, $D2, $17, $03, $FD
;Room enemy/door data:
LA9EF:  .byte $02, $A0, $FF

;Room #$0A
LA9F2:  .byte $03                       ;Attribute table data.
;Room object data:
LA9F3:  .byte $00, $19, $03, $01, $1A, $03, $04, $1B, $01, $09, $12, $01, $0E, $1A, $03, $0F
LAA03:  .byte $19, $03, $34, $12, $01, $4B, $1B, $01, $50, $03, $02, $5E, $1A, $03, $80, $19
LAA13:  .byte $03, $81, $1A, $03, $82, $1B, $01, $88, $18, $03, $8F, $19, $03, $B1, $18, $03
LAA23:  .byte $B8, $18, $03, $FD
;Room enemy/door data:
LAA27:  .byte $02, $B0, $31, $01, $A5, $41, $00, $48, $51, $01, $6A, $FF

;Room #$0B
LAA33:  .byte $03                       ;Attribute table data.
;Room object data:
LAA34:  .byte $00, $19, $03, $01, $1A, $03, $09, $12, $01, $0E, $1A, $03, $0F, $19, $03, $23
LAA44:  .byte $12, $01, $4B, $12, $01, $51, $1A, $03, $5E, $1A, $03, $66, $1B, $01, $80, $19
LAA54:  .byte $03, $82, $12, $01, $8F, $19, $03, $98, $12, $01, $A1, $1A, $03, $AE, $1A, $03
LAA64:  .byte $CB, $1B, $01, $D5, $12, $01, $FD
;Room enemy/door data:
LAA6B:  .byte $01, $01, $45, $11, $00, $89, $21, $01, $D4, $FF

;Room #$0C
LAA75:  .byte $03                       ;Attribute table data.
;Room object data:
LAA76:  .byte $00, $19, $03, $01, $1A, $03, $02, $1E, $03, $0E, $1A, $03, $0F, $19, $03, $36
LAA86:  .byte $1E, $03, $3E, $1C, $03, $51, $1A, $03, $5E, $1A, $03, $71, $1C, $03, $72, $1E
LAA96:  .byte $03, $80, $19, $03, $8F, $19, $03, $A1, $1A, $03, $A6, $1E, $03, $AE, $1A, $03
LAAA6:  .byte $FD
;Room enemy/door data:
LAAA7:  .byte $01, $01, $45, $51, $00, $CB, $FF

;Room #$0D
LAAAE:  .byte $03                       ;Attribute table data.
;Room object data:
LAAAF:  .byte $00, $19, $03, $01, $18, $03, $08, $18, $03, $0F, $19, $03, $11, $18, $03, $18
LAABF:  .byte $18, $03, $50, $03, $02, $5E, $1A, $03, $80, $19, $03, $81, $1A, $03, $82, $1E
LAACF:  .byte $03, $8F, $19, $03, $AE, $1A, $03, $B6, $1E, $03, $BE, $1C, $03, $D1, $1A, $03
LAADF:  .byte $FD
;Room enemy/door data:
LAAE0:  .byte $02, $B0, $FF

;Room #$0E
LAAE3:  .byte $03                       ;Attribute table data.
;Room object data:
LAAE4:  .byte $00, $19, $03, $01, $18, $03, $08, $18, $03, $0F, $19, $03, $41, $1A, $03, $4E
LAAF4:  .byte $1A, $03, $80, $19, $03, $86, $1D, $03, $8F, $19, $03, $91, $1A, $03, $9E, $1A
LAB04:  .byte $03, $BB, $1B, $01, $C3, $1B, $01, $E1, $1A, $03, $EE, $1A, $03, $FF

;Room #$0F
LAB12:  .byte $03                       ;Attribute table data.
;Room object data:
LAB13:  .byte $00, $19, $03, $01, $1A, $03, $0E, $1A, $03, $0F, $19, $03, $12, $12, $01, $28
LAB23:  .byte $12, $01, $4C, $1B, $01, $51, $1A, $03, $55, $1B, $01, $5F, $03, $02, $80, $19
LAB33:  .byte $03, $83, $1B, $01, $8B, $12, $01, $8E, $1A, $03, $8F, $19, $03, $A1, $1A, $03
LAB43:  .byte $B1, $18, $03, $B8, $18, $03, $FF

;Room #$10
LAB4A:  .byte $03                       ;Attribute table data.
;Room object data:
LAB4B:  .byte $00, $19, $03, $01, $1A, $03, $0E, $1A, $03, $0F, $19, $03, $1A, $05, $01, $4D
LAB5B:  .byte $05, $01, $51, $1A, $03, $5E, $1A, $03, $80, $19, $03, $8A, $05, $01, $8F, $19
LAB6B:  .byte $03, $95, $05, $01, $A1, $1A, $03, $AE, $1A, $03, $CA, $05, $01, $E7, $05, $01
LAB7B:  .byte $FF

;Room #$11
LAB7C:  .byte $03                       ;Attribute table data.
;Room object data:
LAB7D:  .byte $00, $19, $03, $01, $1F, $01, $09, $1F, $01, $11, $1E, $03, $19, $1E, $03, $50
LAB8D:  .byte $03, $02, $80, $19, $03, $81, $1F, $01, $A1, $1E, $03, $B8, $1A, $03, $D1, $1F
LAB9D:  .byte $01, $D9, $1F, $01, $FD
;Room enemy/door data:
LABA2:  .byte $02, $B2, $FF

;Room #$12
LABA5:  .byte $01                       ;Attribute table data.
;Room object data:
LABA6:  .byte $00, $1F, $01, $08, $1F, $01, $0F, $19, $03, $10, $1E, $03, $17, $1E, $03, $5F
LABB6:  .byte $03, $02, $87, $1F, $01, $8F, $19, $03, $A7, $1A, $03, $C5, $1F, $01, $D0, $1F
LABC6:  .byte $01, $D7, $1F, $01, $FD
;Room enemy/door data:
LABCB:  .byte $02, $A0, $FF

;Room #$13
LABCE:  .byte $00                       ;Attribute table data.
;Room object data:
LABCF:  .byte $00, $1F, $01, $08, $1F, $01, $10, $1E, $03, $18, $1E, $03, $D0, $00, $02, $D3
LABDF:  .byte $1F, $01, $D8, $00, $02, $DC, $1F, $01, $FD
;Room enemy/door data:
LABE8:  .byte $01, $01, $45, $11, $00, $89, $FF

;Room #$14
LABEF:  .byte $00                       ;Attribute table data.
;Room object data:
LABF0:  .byte $00, $1F, $01, $08, $1F, $01, $10, $1E, $03, $18, $1E, $03, $94, $06, $03, $98
LAC00:  .byte $06, $03, $9C, $06, $03, $D0, $1F, $01, $D3, $00, $02, $DB, $00, $02, $FD
;Room enemy/door data:
LAC0F:  .byte $21, $00, $47, $31, $01, $6A, $FF

;---------------------------------------[ Structure definitions ]------------------------------------

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LAC16:  .byte $08, $01, $01, $01, $01, $01, $01, $01, $01, $08, $00, $00, $00, $00, $00, $00
LAC26:  .byte $00, $00, $FF

;Structure #$01
LAC29:  .byte $08, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $08, $02, $02, $02, $02, $02, $02
LAC39:  .byte $02, $02, $01, $1C, $08, $03, $03, $03, $03, $03, $03, $03, $03, $08, $0A, $0A
LAC49:  .byte $0A, $0A, $0A, $0A, $0A, $0A, $FF

;Structure #$02
LAC50:  .byte $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02
LAC60:  .byte $04, $05, $02, $04, $05, $02, $04, $05, $FF

;Structure #$03
LAC69:  .byte $01, $08, $01, $08, $01, $08, $FF

;Structure #$04
LAC70:  .byte $01, $09, $01, $09, $01, $09, $FF

;Structure #$05
LAC77:  .byte $01, $13, $FF

;Structure #$06
LAC7A:  .byte $03, $1D, $17, $1E, $03, $21, $1C, $21, $03, $21, $1C, $21, $03, $1F, $17, $20
LAC8A:  .byte $FF

;Structure #$07
LAC8B:  .byte $05, $25, $1C, $1C, $1C, $31, $05, $26, $1C, $1C, $1C, $32, $05, $26, $1C, $1C
LAC9B:  .byte $1C, $32, $05, $27, $1C, $1C, $1C, $33, $FF

;Structure #$08
LACA4:  .byte $03, $28, $29, $2A, $03, $2B, $2C, $2D, $03, $2E, $2F, $30, $03, $06, $12, $35
LACB4:  .byte $FF

;Structure #$09
LACB5:  .byte $01, $0B, $01, $0B, $01, $0B, $01, $0B, $01, $0B, $01, $0B, $01, $0B, $01, $0B
LACC5:  .byte $FF

;Structure #$0A
LACC6:  .byte $08, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $FF

;Structure #$0B
LACD0:  .byte $07, $1D, $0D, $16, $16, $16, $0D, $1E, $07, $21, $1D, $0D, $0D, $0D, $1E, $21
LACE0:  .byte $07, $21, $21, $15, $14, $15, $21, $21, $07, $0D, $21, $16, $10, $16, $21, $0D
LACF0:  .byte $07, $1F, $0D, $20, $10, $1F, $0D, $20, $FF

;Structure #$0C
LACF9:  .byte $08, $22, $22, $0D, $22, $22, $1E, $1C, $1D, $08, $1C, $1C, $21, $1C, $1C, $21
LAD09:  .byte $1C, $21, $08, $1C, $1C, $0C, $1C, $1C, $1F, $0D, $20, $07, $1C, $1C, $21, $1C
LAD19:  .byte $1C, $1C, $14, $04, $1C, $14, $0D, $14, $03, $1C, $1C, $15, $FF

;Structure #$0D
LAD26:  .byte $02, $01, $01, $02, $00, $00, $FF

;Structure #$0E
LAD2D:  .byte $01, $16, $01, $21, $01, $21, $01, $0C, $01, $21, $01, $0D, $01, $21, $FF

;Structure #$0F
LAD3C:  .byte $01, $0C, $FF

;Structure #$10
LAD3F:  .byte $07, $22, $22, $22, $22, $22, $22, $22, $FF

;Structure #$11
LAD48:  .byte $05, $0B, $1D, $22, $0D, $22, $04, $11, $21, $11, $21, $04, $11, $21, $11, $0D
LAD58:  .byte $03, $11, $21, $11, $03, $23, $23, $23, $FF

;Structure #$12
LAD61:  .byte $03, $19, $1B, $1A, $FF

;Structure #$13
LAD66:  .byte $01, $34, $01, $34, $FF

;Structure #$14
LAD6B:  .byte $08, $1D, $22, $17, $0D, $1E, $0D, $17, $0D, $08, $0D, $22, $17, $20, $21, $14
LAD7B:  .byte $0D, $11, $08, $21, $1D, $22, $17, $20, $10, $10, $21, $08, $21, $1F, $17, $0D
LAD8B:  .byte $22, $0D, $1E, $11, $08, $0D, $14, $10, $1F, $22, $22, $20, $11, $FF

;Structure #$15
LAD99:  .byte $08, $17, $17, $0D, $17, $17, $0D, $17, $17, $08, $0D, $17, $17, $17, $17, $17
LADA9:  .byte $17, $0D, $FF

;Structure #$16
LADAC:  .byte $08, $18, $1D, $17, $1E, $1D, $17, $17, $1E, $08, $18, $21, $1C, $21, $21, $1C
LADBC:  .byte $1C, $21, $08, $0D, $20, $1C, $1F, $20, $1C, $1C, $1F, $FF

;Structure #$17
LADC8:  .byte $04, $0D, $0D, $0D, $0D, $04, $18, $18, $18, $18, $04, $18, $18, $18, $18, $04
LADD8:  .byte $18, $18, $18, $18, $FF

;Structure #$18
LADDD:  .byte $07, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $07, $0D, $17, $17, $17, $17, $17, $0D
LADED:  .byte $07, $18, $0A, $10, $0A, $0A, $10, $18, $07, $0D, $17, $17, $17, $17, $17, $0D
LADFD:  .byte $FF

;Structure #$19
LADFE:  .byte $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01, $0A, $01, $0A
LAE0E:  .byte $FF

;Structure #$1A
LAE0F:  .byte $01, $0D, $01, $18, $01, $18, $01, $18, $01, $18, $FF

;Structure #$1B
LAE1A:  .byte $02, $19, $1A, $FF

;Structure #$1C
LAE1E:  .byte $01, $0D, $FF

;Structure #$1D
LAE21:  .byte $04, $14, $1C, $1C, $14, $04, $0A, $0A, $0A, $0A, $FF

;Structure #$1E
LAE2C:  .byte $08, $0D, $22, $22, $22, $22, $22, $22, $0D, $FF

;Structure #$1F
LAE36:  .byte $08, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $08, $0E, $10, $0E, $0E, $10, $10
LAE46:  .byte $0E, $10, $FF

;----------------------------------------[ Macro definitions ]---------------------------------------

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

MacroDefs:

LAE49:  .byte $A7, $A7, $A7, $A7
LAE4D:  .byte $FF, $FF, $A6, $A6
LAE51:  .byte $A2, $A2, $FF, $FF
LAE55:  .byte $FF, $FF, $A3, $A3
LAE59:  .byte $A4, $FF, $A4, $FF
LAE5D:  .byte $FF, $A5, $FF, $A5
LAE61:  .byte $FF, $79, $FF, $7E
LAE65:  .byte $4F, $4F, $4F, $4F
LAE69:  .byte $A0, $A0, $A0, $A0
LAE6D:  .byte $A1, $A1, $A1, $A1
LAE71:  .byte $04, $05, $06, $07
LAE75:  .byte $10, $11, $12, $13
LAE79:  .byte $00, $01, $02, $03
LAE7D:  .byte $08, $08, $08, $08
LAE81:  .byte $18, $19, $1A, $1B
LAE85:  .byte $1C, $1D, $1E, $1F
LAE89:  .byte $0C, $0D, $0E, $0F
LAE8D:  .byte $09, $09, $09, $09
LAE91:  .byte $7A, $7B, $7F, $5A
LAE95:  .byte $2A, $2C, $FF, $FF
LAE99:  .byte $14, $15, $16, $17
LAE9D:  .byte $20, $21, $22, $23
LAEA1:  .byte $24, $25, $20, $21
LAEA5:  .byte $28, $28, $29, $29
LAEA9:  .byte $26, $27, $26, $27
LAEAD:  .byte $2A, $2B, $FF, $FF
LAEB1:  .byte $2B, $2C, $FF, $FF
LAEB5:  .byte $2B, $2B, $FF, $FF
LAEB9:  .byte $FF, $FF, $FF, $FF
LAEBD:  .byte $31, $32, $33, $34
LAEC1:  .byte $35, $36, $37, $38
LAEC5:  .byte $3D, $3E, $3F, $40
LAEC9:  .byte $41, $42, $43, $44
LAECD:  .byte $39, $3A, $39, $3A
LAED1:  .byte $3B, $3B, $3C, $3C
LAED5:  .byte $0B, $0B, $2D, $2E
LAED9:  .byte $2F, $30, $0B, $0B
LAEDD:  .byte $50, $51, $52, $53
LAEE1:  .byte $54, $55, $54, $55
LAEE5:  .byte $56, $57, $58, $59
LAEE9:  .byte $FF, $FF, $FF, $5E
LAEED:  .byte $5B, $5C, $5F, $60
LAEF1:  .byte $FF, $FF, $61, $FF
LAEF5:  .byte $5D, $62, $67, $68
LAEF9:  .byte $63, $64, $69, $6A
LAEFD:  .byte $65, $66, $6B, $6C
LAF01:  .byte $6D, $6E, $73, $74
LAF05:  .byte $6F, $70, $75, $76
LAF09:  .byte $71, $72, $77, $78
LAF0D:  .byte $45, $46, $47, $48
LAF11:  .byte $FF, $98, $FF, $98
LAF15:  .byte $49, $4A, $4B, $4C
LAF19:  .byte $90, $91, $90, $91
LAF1D:  .byte $7C, $7D, $4D, $FF

.advance $B000, $00
.include "../music/TourianMusic.asm"

.advance $B200, $00
.include "../SoundEngine.asm"

.advance $C000, $00