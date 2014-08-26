; METROID Disassembly (c) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
; Disassembled by Kent Hansen. Commented by Nick Mikstas.
; This version is organized and ported to use the MMC3.
; Norfair (Rom Bank 2)

.require "../Defines.asm"
.require "../GameEngineDeclarations.asm"

.org ROMBank_Switchable
.include "../AreaCommon.asm"
.advance $8D60,$EA

;------------------------------------------[ Graphics data ]-----------------------------------------

;Norfair enemy tile patterns.
L8D60:  .byte $38, $7C, $A6, $FA, $BE, $FA, $6C, $38, $30, $6C, $06, $FA, $BA, $D2, $0C, $38
L8D70:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D80:  .byte $03, $FF, $1F, $3F, $3F, $7F, $7F, $FF, $00, $00, $04, $08, $00, $00, $00, $00
L8D90:  .byte $C0, $F0, $FE, $FE, $FE, $FF, $BF, $2C, $00, $00, $0E, $1E, $1E, $1C, $38, $20
L8DA0:  .byte $C0, $F0, $F8, $FC, $FE, $FF, $9F, $0C, $00, $00, $00, $00, $00, $00, $00, $00
L8DB0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DC0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DD0:  .byte $00, $08, $10, $60, $80, $80, $00, $00, $04, $04, $06, $0E, $9C, $BC, $7C, $7C
L8DE0:  .byte $00, $0C, $02, $03, $1C, $29, $41, $08, $00, $00, $00, $00, $02, $05, $05, $04
L8DF0:  .byte $00, $08, $10, $60, $80, $80, $00, $00, $04, $04, $06, $0E, $9C, $B8, $70, $70
L8E00:  .byte $01, $2B, $0D, $27, $5B, $07, $5B, $2F, $01, $2B, $0D, $27, $5B, $07, $5B, $2F
L8E10:  .byte $00, $46, $69, $B8, $E4, $E8, $8C, $66, $00, $40, $60, $B8, $E4, $E0, $80, $06
L8E20:  .byte $00, $00, $00, $02, $51, $0B, $2D, $1F, $00, $00, $00, $02, $51, $0B, $2D, $1F
L8E30:  .byte $20, $48, $62, $AC, $F9, $EF, $FA, $FF, $20, $48, $62, $AC, $F9, $EF, $FA, $FF
L8E40:  .byte $1C, $78, $FE, $FF, $E5, $CC, $C8, $40, $00, $00, $40, $40, $00, $80, $C8, $40
L8E50:  .byte $3C, $7E, $FF, $3C, $DB, $E7, $5A, $3C, $00, $20, $00, $00, $C3, $E7, $42, $00
L8E60:  .byte $00, $00, $00, $08, $5A, $A3, $DB, $5A, $00, $00, $00, $10, $24, $6E, $68, $04
L8E70:  .byte $00, $00, $00, $00, $10, $28, $3E, $18, $00, $00, $00, $00, $08, $1C, $06, $08
L8E80:  .byte $03, $01, $20, $0C, $1E, $7F, $3F, $0E, $00, $00, $20, $00, $00, $00, $08, $00
L8E90:  .byte $08, $90, $F8, $E0, $60, $60, $60, $30, $00, $02, $02, $06, $0E, $0A, $03, $00
L8EA0:  .byte $28, $B8, $FC, $DE, $5E, $4E, $60, $30, $20, $3A, $1E, $1E, $1E, $0E, $03, $00
L8EB0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EC0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8ED0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FC, $F8, $F8, $F8, $B8, $7C, $DC, $3C
L8EE0:  .byte $18, $30, $24, $20, $22, $01, $00, $06, $06, $06, $03, $01, $01, $00, $00, $00
L8EF0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $E0, $F0, $F8, $F8, $B8, $7C, $DC, $3C
L8F00:  .byte $07, $0A, $01, $03, $04, $01, $00, $00, $07, $0A, $01, $03, $04, $01, $00, $00
L8F10:  .byte $66, $8C, $E8, $E6, $FA, $55, $64, $1A, $06, $80, $E0, $E6, $FA, $45, $40, $02
L8F20:  .byte $7E, $7D, $7D, $B0, $B6, $6B, $99, $24, $7E, $7C, $3C, $10, $30, $29, $99, $24
L8F30:  .byte $7A, $BE, $BC, $08, $6C, $D2, $82, $04, $7A, $3E, $3C, $08, $08, $90, $80, $00
L8F40:  .byte $3C, $F0, $98, $68, $90, $B0, $E0, $40, $00, $00, $00, $60, $F0, $F0, $E0, $40
L8F50:  .byte $3C, $F0, $98, $68, $00, $00, $00, $00, $00, $00, $00, $60, $00, $00, $00, $00
L8F60:  .byte $00, $00, $02, $0D, $06, $2A, $1B, $0F, $00, $00, $00, $00, $00, $03, $07, $1F
L8F70:  .byte $00, $00, $80, $20, $C0, $B0, $E8, $A0, $00, $00, $00, $00, $00, $C0, $C0, $90
L8F80:  .byte $00, $00, $28, $5B, $FB, $BF, $7F, $2E, $00, $00, $00, $14, $2B, $3D, $1A, $04
L8F90:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FA0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FB0:  .byte $09, $A7, $5F, $BF, $33, $ED, $76, $C9, $00, $00, $00, $00, $00, $6C, $46, $C0
L8FC0:  .byte $00, $00, $0A, $1F, $33, $6D, $46, $C1, $00, $00, $00, $00, $00, $6C, $46, $C0
L8FD0:  .byte $03, $5F, $3F, $B3, $FD, $7E, $DF, $37, $00, $50, $3A, $99, $74, $3E, $DC, $30
L8FE0:  .byte $10, $10, $00, $00, $40, $00, $00, $40, $0B, $0D, $2F, $36, $3C, $18, $78, $30
L8FF0:  .byte $40, $00, $00, $00, $00, $00, $00, $00, $34, $F8, $B8, $D0, $00, $00, $00, $00
L9000:  .byte $00, $01, $71, $13, $FF, $3C, $F3, $2F, $03, $0E, $0C, $00, $00, $00, $00, $00
L9010:  .byte $08, $07, $06, $0D, $1C, $1C, $0E, $06, $00, $00, $00, $00, $04, $00, $02, $00
L9020:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9030:  .byte $9E, $7F, $3F, $07, $4E, $3D, $03, $0A, $F0, $68, $30, $3C, $5A, $3F, $07, $0B
L9040:  .byte $12, $04, $2F, $2F, $3F, $3F, $5F, $2F, $13, $0F, $3D, $3E, $34, $78, $70, $68
L9050:  .byte $00, $80, $60, $F0, $E8, $F8, $F0, $FC, $C0, $70, $98, $0C, $14, $06, $0E, $02
L9060:  .byte $37, $3F, $4A, $B6, $7F, $25, $58, $00, $0F, $0F, $1E, $1D, $00, $00, $00, $00
L9070:  .byte $C8, $F0, $C0, $D0, $40, $00, $00, $00, $E0, $C0, $A0, $00, $80, $00, $00, $00
L9080:  .byte $00, $00, $14, $1A, $5F, $BD, $FE, $74, $00, $00, $00, $28, $54, $BC, $58, $20
L9090:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L90A0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L90B0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L90C0:  .byte $03, $0F, $17, $3B, $9D, $6A, $1F, $07, $00, $00, $12, $09, $54, $26, $0C, $00
L90D0:  .byte $E0, $F0, $E4, $CE, $D1, $C0, $A6, $30, $00, $00, $08, $10, $00, $0E, $1F, $41
L90E0:  .byte $00, $00, $40, $00, $00, $10, $00, $00, $10, $71, $32, $3A, $18, $0C, $0F, $03
L90F0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $C0, $20, $20, $20, $60, $C0, $80
L9100:  .byte $08, $27, $7C, $F3, $C7, $87, $05, $02, $04, $00, $00, $13, $42, $05, $05, $02
L9110:  .byte $08, $27, $7C, $F1, $C3, $81, $00, $00, $04, $00, $00, $11, $43, $01, $00, $00
L9120:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9130:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9140:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9150:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;Tourian enemy tile patterns.
L9160:  .byte $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $03, $06, $0D
L9170:  .byte $00, $00, $00, $00, $00, $00, $98, $64, $00, $00, $00, $7E, $C3, $00, $00, $00
L9180:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $80, $C0, $60, $30
L9190:  .byte $00, $00, $00, $00, $00, $02, $06, $0C, $00, $00, $03, $04, $08, $12, $16, $2C
L91A0:  .byte $00, $00, $00, $00, $80, $78, $04, $04, $00, $FF, $00, $00, $00, $00, $00, $00
L91B0:  .byte $00, $00, $00, $00, $00, $00, $10, $20, $00, $00, $C0, $20, $10, $08, $04, $04
L91C0:  .byte $00, $15, $0F, $05, $3F, $2F, $7E, $3D, $00, $00, $00, $00, $01, $07, $06, $0D
L91D0:  .byte $03, $07, $17, $13, $0F, $1F, $1D, $1F, $01, $04, $03, $03, $07, $06, $05, $1D
L91E0:  .byte $E0, $A0, $B0, $18, $0F, $00, $00, $00, $A0, $00, $80, $10, $02, $00, $00, $00
L91F0:  .byte $00, $00, $00, $00, $80, $00, $00, $00, $7F, $7F, $7F, $7F, $FF, $3F, $3F, $3F
L9200:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9210:  .byte $F0, $20, $40, $80, $80, $C0, $70, $10, $A0, $00, $00, $00, $87, $1F, $2E, $EF
L9220:  .byte $00, $00, $10, $30, $60, $60, $F0, $60, $00, $00, $10, $30, $E0, $68, $F4, $66
L9230:  .byte $00, $00, $0C, $06, $03, $00, $10, $30, $2C, $27, $3D, $56, $5B, $CC, $D7, $F0
L9240:  .byte $00, $00, $00, $03, $1E, $0C, $08, $00, $00, $00, $00, $03, $9E, $EC, $F8, $F0
L9250:  .byte $00, $00, $00, $07, $0F, $1F, $1E, $1C, $00, $00, $00, $00, $03, $04, $08, $08
L9260:  .byte $03, $02, $04, $0A, $09, $13, $03, $01, $1B, $1A, $30, $30, $60, $60, $60, $78
L9270:  .byte $18, $3C, $3C, $3C, $DB, $E7, $E7, $E7, $00, $00, $00, $18, $00, $00, $81, $00
L9280:  .byte $40, $80, $80, $40, $88, $D0, $C0, $80, $10, $18, $0C, $0C, $06, $06, $06, $1E
L9290:  .byte $08, $00, $00, $00, $0D, $33, $03, $01, $28, $40, $40, $40, $80, $81, $81, $F0
L92A0:  .byte $18, $3C, $3C, $3C, $DB, $E7, $E7, $E7, $00, $18, $3C, $18, $81, $C3, $E7, $C3
L92B0:  .byte $20, $20, $40, $4C, $90, $C0, $C0, $80, $02, $02, $02, $01, $01, $81, $81, $0F
L92C0:  .byte $3F, $5E, $5B, $3B, $37, $0B, $01, $00, $0F, $0E, $03, $09, $01, $00, $00, $00
L92D0:  .byte $1F, $0B, $0F, $1C, $06, $0F, $07, $02, $07, $03, $07, $00, $02, $01, $00, $00
L92E0:  .byte $00, $00, $E0, $70, $20, $00, $00, $00, $03, $07, $E7, $7F, $2F, $1F, $1F, $1F
L92F0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $F1, $FE, $FF, $FF, $FF, $FF, $FF, $FF
L9300:  .byte $80, $C0, $60, $70, $78, $38, $30, $00, $80, $C0, $60, $76, $7B, $3B, $77, $47
L9310:  .byte $18, $08, $08, $1C, $08, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9320:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $8F, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9330:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $F0, $FE, $FF, $FF, $FF, $FF
L9340:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $F8, $F8, $F4, $FC, $FE, $FE, $FA, $FE
L9350:  .byte $00, $00, $00, $01, $07, $0E, $0C, $18, $00, $00, $00, $00, $03, $04, $08, $08
L9360:  .byte $00, $30, $38, $38, $30, $10, $08, $00, $4E, $03, $00, $20, $20, $10, $08, $00
L9370:  .byte $C3, $00, $00, $00, $81, $C3, $C3, $66, $00, $C3, $FF, $3C, $99, $C3, $C3, $66
L9380:  .byte $00, $0C, $1C, $1C, $0C, $08, $10, $00, $72, $C0, $00, $04, $04, $08, $10, $00
L9390:  .byte $00, $30, $38, $38, $31, $11, $09, $00, $8C, $87, $41, $20, $21, $11, $09, $00
L93A0:  .byte $C3, $00, $00, $00, $00, $81, $00, $81, $00, $00, $C3, $7E, $3C, $99, $00, $81
L93B0:  .byte $00, $0C, $1C, $1C, $8C, $88, $90, $00, $31, $E1, $82, $04, $84, $88, $90, $00
L93C0:  .byte $4A, $BE, $7A, $34, $58, $3C, $3C, $14, $08, $1C, $38, $34, $18, $18, $18, $14
L93D0:  .byte $18, $18, $18, $10, $18, $18, $10, $10, $18, $18, $18, $10, $18, $18, $10, $10
L93E0:  .byte $00, $00, $03, $07, $01, $00, $00, $80, $1F, $1F, $1F, $1F, $1F, $1F, $0F, $8F
L93F0:  .byte $00, $C0, $E0, $E0, $C2, $03, $01, $41, $FF, $DF, $EF, $EF, $CD, $1C, $FE, $FE
L9400:  .byte $00, $10, $10, $18, $10, $10, $10, $00, $00, $08, $08, $18, $08, $08, $08, $00
L9410:  .byte $00, $00, $00, $10, $1C, $0C, $07, $02, $00, $00, $00, $08, $0C, $0A, $01, $02
L9420:  .byte $00, $00, $00, $3E, $08, $00, $00, $00, $00, $00, $00, $08, $3E, $00, $00, $00
L9430:  .byte $3C, $7E, $FF, $FF, $FF, $FF, $7E, $3C, $00, $20, $40, $00, $00, $00, $00, $00
L9440:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $DE, $FE, $FC, $FC, $FC, $F8, $F8, $F8
L9450:  .byte $00, $00, $00, $00, $01, $04, $00, $08, $00, $00, $00, $00, $01, $04, $00, $08
L9460:  .byte $00, $3D, $4A, $81, $4A, $3D, $00, $00, $00, $3D, $7A, $FF, $7A, $3D, $00, $00
L9470:  .byte $05, $18, $39, $66, $46, $4C, $78, $00, $05, $1A, $3D, $7E, $7E, $7C, $78, $00
L9480:  .byte $15, $0A, $11, $1B, $11, $11, $0A, $04, $15, $0E, $15, $1F, $1F, $1F, $0E, $04
L9490:  .byte $00, $00, $00, $18, $3C, $10, $0A, $00, $81, $4A, $28, $3C, $FD, $34, $4A, $89
L94A0:  .byte $00, $00, $30, $4A, $68, $1D, $20, $08, $00, $00, $30, $7A, $78, $15, $22, $08
L94B0:  .byte $00, $10, $00, $00, $0C, $12, $00, $00, $3C, $DF, $E6, $BD, $DF, $DF, $72, $1C
L94C0:  .byte $34, $18, $18, $30, $14, $00, $08, $00, $10, $18, $00, $10, $00, $00, $08, $00
L94D0:  .byte $18, $10, $10, $10, $00, $10, $00, $10, $18, $10, $10, $10, $00, $10, $00, $10
L94E0:  .byte $80, $80, $C0, $70, $59, $CF, $80, $80, $8F, $05, $43, $13, $41, $04, $80, $80
L94F0:  .byte $E1, $41, $41, $C2, $83, $03, $03, $04, $BD, $9C, $9E, $1E, $3D, $7C, $B8, $2C
L9500:  .byte $00, $42, $3C, $3C, $3C, $3C, $42, $00, $00, $00, $18, $24, $24, $18, $00, $00
L9510:  .byte $10, $52, $24, $03, $C0, $24, $4A, $08, $34, $5E, $E5, $43, $C2, $A7, $7A, $2C
L9520:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9530:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9540:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9550:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

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
L95C3:  JMP $9B9D                       ;Area specific routine.

TwosCompliment_:
L95C6:  EOR #$FF                        ;
L95C8:  CLC                             ;The following routine returns the twos-->
L95C9:  ADC #$01                        ;compliment of the value stored in A.
L95CB:  RTS                             ;

L95CC:  .byte $FF                       ;Not used.

L95CD:  .byte $08                       ;Norfair music init flag.

L95CE:  .byte $00                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $01                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $10, $05, $27, $04, $0F, $FF, $FF

L95D7:  .byte $16                       ;Samus start x coord on world map.
L95D8:  .byte $0D                       ;Samus start y coord on world map.
L95D9:  .byte $6E                       ;Samus start verticle screen position.

L95DA:  .byte $01, $00, $03, $77, $53, $57, $55, $59, $5B, $4F, $32

L95E5:  LDA EnDataIndex,X
L95E8:  JSR CommonJump_ChooseRoutine

L95EB:  .word $98D3
L95ED:  .word $9908
L95EF:  .word $98C0
L95F1:  .word $9833
L95F3:  .word $9833
L95F5:  .word $9833
L95F7:  .word $9996
L95F9:  .word $9850
L95FB:  .word $9833
L95FD:  .word $9833
L95FF:  .word $9833
L9601:  .word $9A64
L9603:  .word $9AD6
L9605:  .word $9AE9
L9607:  .word $9B64
L9609:  .word $9833

L960B:  .byte $28, $28, $28, $28, $30, $30, $00, $00, $00, $00, $00, $00, $75, $75, $84, $82

L961B:  .byte $00, $00, $11, $11, $13, $18, $35, $35, $41, $41, $4B, $4B, $00, $00, $00, $00

L962B:  .byte $08, $08, $FF, $01, $01, $01, $02, $01, $01, $20, $FF, $FF, $08, $06, $FF, $00

L963B:  .byte $22, $22, $22, $22, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $88, $86

L964B:  .byte $00, $00, $05, $08, $13, $18, $20, $20, $3C, $37, $43, $47, $00, $00, $00, $00

L965B:  .byte $25, $25, $25, $25, $2A, $2D, $00, $00, $00, $00, $00, $00, $69, $69, $7F, $7C

L966B:  .byte $00, $00, $05, $08, $13, $18, $1D, $1D, $3C, $37, $43, $47, $00, $00, $00, $00

L967B:  .byte $00, $00, $80, $82, $00, $00, $00, $00, $80, $00, $00, $00, $82, $00, $00, $00

L968B:  .byte $89, $89, $00, $42, $00, $00, $04, $80, $80, $81, $00, $00, $05, $89, $00, $00

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $28, $10, $00, $00, $00, $01, $00, $00

L96AB:  .byte $05, $05, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $8C, $00, $00

L96BB:  .byte $10, $01, $01, $01, $10, $10, $01, $08, $09, $10, $01, $10, $01, $20, $00, $00

L96CB:  .byte $12, $14, $00, $00, $00, $00, $02, $02, $00, $04, $06, $09, $0E, $10, $12, $00

L96DB:  .word $97E7, $97E7, $97E7, $97E7, $97E7, $97EA, $97ED, $97ED
L96EB:  .word $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED
L96FB:  .word $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED
L970B:  .word $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED, $97ED
L971B:  .word $97ED, $97ED, $97ED, $97ED

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $00, $00, $00, $00
L9733:  .byte $00, $00, $E0, $16, $15, $7F, $7F, $7F, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $38, $38, $C8, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $0C, $0C, $02, $01, $00, $00, $01, $01, $01, $FC, $06, $FE, $FE, $F8, $F9, $FB
L9763:  .byte $FD, $00, $00, $00, $00, $02, $01, $01, $00, $00, $FA, $FC, $06, $00, $01, $01
L9773:  .byte $01, $00, $01, $01, $03, $00, $00, $00

L977B:  .byte $4C, $4C, $01, $00, $00, $00, $00, $40, $00, $64, $44, $44, $40, $00, $00, $00

L978B:  .byte $00, $00, $00, $00, $4D, $4D, $53, $57, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $08, $F8, $00, $00, $00, $00, $08, $F8, $00, $00, $00, $F8 

L97A7:  .word $97F7, $9806, $9815, $9824, $9B9E, $9BA3, $9BA8, $9BAD
L97B7:  .word $9BB2, $9BB7, $9BBC, $9BC1, $9BC6, $9BCB, $9BD0, $9BD5
L97C7:  .word $9BDA, $9BDA, $9BDA, $9BDA, $9BDA

L97D1:  .byte $00, $02, $00, $09, $00, $0D, $01, $0E, $0F, $03, $00, $01, $02, $03, $00, $10
L97E1:  .byte $00, $11, $00, $00, $00, $01

L97E7:  .byte $01, $03, $FF

L97EA:  .byte $01, $0B, $FF

L97ED:  .byte $14, $90, $0A, $00, $FD, $30, $00, $14, $10, $FA

L97F7:  .byte $0A, $D3, $07, $B3, $07, $93, $07, $03, $07, $13, $07, $23, $50, $33, $FF

L9806:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L9815:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L9824:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

L9833:  LDA #$00
L9835:  STA $6AF4,X
L9838:  RTS

L9839:  LDA $81
L983B:  CMP #$01
L983D:  BEQ $9848
L983F:  CMP #$03
L9841:  BEQ $984D
L9843:  LDA $00
L9845:  JMP CommonJump_UnknownUpdateAnim0
L9848:  LDA $01
L984A:  JMP CommonJump_UnknownUpdateAnim1
L984D:  JMP CommonJump_Unknown06
L9850:  LDA $6AF4,X
L9853:  CMP #$02
L9855:  BNE $988F
L9857:  LDA $0403,X
L985A:  BNE $988F
L985C:  LDA $6AFE,X
L985F:  BNE $9873
L9861:  LDA $030D
L9864:  SEC 
L9865:  SBC $0400,X
L9868:  CMP #$40
L986A:  BCS $988F
L986C:  LDA #$7F
L986E:  STA $6AFE,X
L9871:  BNE $988F
L9873:  LDA $0402,X
L9876:  BMI $988F
L9878:  LDA #$00
L987A:  STA $0402,X
L987D:  STA $0406,X
L9880:  STA $6AFE,X
L9883:  LDA EnData05,X
L9886:  AND #$01
L9888:  TAY 
L9889:  LDA $98BE,Y
L988C:  STA $0403,X
L988F:  LDA EnData05,X
L9892:  ASL 
L9893:  BMI $98B3
L9895:  LDA $6AF4,X
L9898:  CMP #$02
L989A:  BNE $98B3
L989C:  JSR CommonJump_Unknown36
L989F:  PHA 
L98A0:  JSR CommonJump_Unknown39
L98A3:  STA $05
L98A5:  PLA 
L98A6:  STA $04
L98A8:  JSR $9A42
L98AB:  JSR CommonJump_Unknown27
L98AE:  BCC $98B8
L98B0:  JSR $9A52
L98B3:  LDA #$03
L98B5:  JMP CommonJump_UnknownUpdateAnim1
L98B8:  LDA #$00
L98BA:  STA $6AF4,X
L98BD:  RTS

L98BE:  PHP 
L98BF:  SED 
L98C0:  LDA $6AF4,X
L98C3:  CMP #$03
L98C5:  BEQ $98CA
L98C7:  JSR CommonJump_Unknown1E
L98CA:  LDA #$03
L98CC:  STA $00
L98CE:  STA $01
L98D0:  JMP $9839
L98D3:  LDA #$03
L98D5:  STA $00
L98D7:  LDA #$08
L98D9:  STA $01
L98DB:  LDA $6AF4,X
L98DE:  CMP #$01
L98E0:  BNE $98EE
L98E2:  LDA EnData05,X
L98E5:  AND #$10
L98E7:  BEQ $98EE
L98E9:  LDA #$01
L98EB:  JSR $9954
L98EE:  JSR $98F4
L98F1:  JMP $9839
L98F4:  LDA $6AF4,X
L98F7:  CMP #$02
L98F9:  BNE $9907
L98FB:  LDA #$25
L98FD:  LDY $0402,X
L9900:  BPL $9904
L9902:  LDA #$22
L9904:  STA $6AF9,X
L9907:  RTS

L9908:  LDA $81
L990A:  CMP #$01
L990C:  BEQ $991E
L990E:  CMP #$03
L9910:  BEQ $9951
L9912:  LDA $6AF4,X
L9915:  CMP #$01
L9917:  BNE $9923
L9919:  LDA #$00
L991B:  JSR $9954
L991E:  LDA #$08
L9920:  JMP CommonJump_UnknownUpdateAnim1
L9923:  LDA #$80
L9925:  STA $6AFE,X
L9928:  LDA $0402,X
L992B:  BMI $9949
L992D:  LDA EnData05,X
L9930:  AND #$10
L9932:  BEQ $9949
L9934:  LDA $0400,X
L9937:  SEC 
L9938:  SBC $030D
L993B:  BPL $9940
L993D:  JSR $95C6
L9940:  CMP #$10
L9942:  BCS $9949
L9944:  LDA #$00
L9946:  STA $6AFE,X
L9949:  JSR $98F4
L994C:  LDA #$03
L994E:  JMP CommonJump_UnknownUpdateAnim0
L9951:  JMP CommonJump_Unknown06
L9954:  STA EnDataIndex,X
L9957:  LDA $040B,X
L995A:  PHA 
L995B:  JSR CommonJump_Unknown2A
L995E:  PLA 
L995F:  STA $040B,X
L9962:  RTS

L9963:  JSR CommonJump_Unknown1B
L9966:  LDA #$06
L9968:  STA $00
L996A:  JMP $9839
L996D:  JSR CommonJump_Unknown1B
L9970:  LDA #$06
L9972:  STA $00
L9974:  JMP $9839
L9977:  JSR CommonJump_Unknown1B
L997A:  LDA #$06
L997C:  STA $00
L997E:  LDA $81
L9980:  CMP #$02
L9982:  BNE $9993
L9984:  CMP $6AF4,X
L9987:  BNE $9993
L9989:  JSR CommonJump_Unknown09
L998C:  AND #$03
L998E:  BNE $9993
L9990:  JMP $984D
L9993:  JMP $9839
L9996:  JSR CommonJump_Unknown09
L9999:  AND #$03
L999B:  BEQ $99D1
L999D:  LDA $81
L999F:  CMP #$01
L99A1:  BEQ $99D9
L99A3:  CMP #$03
L99A5:  BEQ $99D6
L99A7:  LDA $6AF4,X
L99AA:  CMP #$03
L99AC:  BEQ $99D1
L99AE:  LDA $040A,X
L99B1:  AND #$03
L99B3:  CMP #$01
L99B5:  BNE $99C8
L99B7:  LDY $0400,X
L99BA:  CPY #$EB
L99BC:  BNE $99C8
L99BE:  JSR $9A0A
L99C1:  LDA #$03
L99C3:  STA $040A,X
L99C6:  BNE $99CE
L99C8:  JSR $9A2F
L99CB:  JSR $99F5
L99CE:  JSR $9A13
L99D1:  LDA #$03
L99D3:  JSR CommonJump_UpdateEnemyAnim
L99D6:  JMP CommonJump_Unknown06
L99D9:  JMP CommonJump_UnknownUpdateAnim1
L99DC:  LDA EnData05,X
L99DF:  LSR 
L99E0:  LDA $040A,X
L99E3:  AND #$03
L99E5:  ROL 
L99E6:  TAY 
L99E7:  LDA $99ED,Y
L99EA:  JMP CommonJump_ResetAnimIndex

L99ED:  .byte $69, $69, $72, $6C, $6F, $6F, $6C, $72

L99F5:  LDX $4B
L99F7:  BCS $9A12
L99F9:  LDA $00
L99FB:  BNE $9A0A
L99FD:  LDY $040A,X
L9A00:  DEY 
L9A01:  TYA 
L9A02:  AND #$03
L9A04:  STA $040A,X
L9A07:  JMP $99DC
L9A0A:  LDA EnData05,X
L9A0D:  EOR #$01
L9A0F:  STA EnData05,X
L9A12:  RTS

L9A13:  JSR $9A27
L9A16:  JSR $9A2F
L9A19:  LDX $4B
L9A1B:  BCC $9A26
L9A1D:  JSR $9A27
L9A20:  STA $040A,X
L9A23:  JSR $99DC
L9A26:  RTS

L9A27:  LDY $040A,X
L9A2A:  INY 
L9A2B:  TYA 
L9A2C:  AND #$03
L9A2E:  RTS

L9A2F:  LDY EnData05,X
L9A32:  STY $00
L9A34:  LSR $00
L9A36:  ROL 
L9A37:  ASL 
L9A38:  TAY 
L9A39:  LDA CommonRoutines+1,Y
L9A3C:  PHA 
L9A3D:  LDA CommonRoutines,Y
L9A40:  PHA 
L9A41:  RTS

L9A42:  LDA $0400,X
L9A45:  STA $08
L9A47:  LDA $0401,X
L9A4A:  STA $09
L9A4C:  LDA $6AFB,X
L9A4F:  STA $0B
L9A51:  RTS

L9A52:  LDA $0B
L9A54:  AND #$01
L9A56:  STA $6AFB,X
L9A59:  LDA $08
L9A5B:  STA $0400,X
L9A5E:  LDA $09
L9A60:  STA $0401,X
L9A63:  RTS

L9A64:  LDA $81
L9A66:  CMP #$01
L9A68:  BNE $9A88
L9A6A:  LDA $6AF4,X
L9A6D:  CMP #$03
L9A6F:  BEQ $9ACA
L9A71:  CMP #$02
L9A73:  BNE $9A88
L9A75:  LDY $0408,X
L9A78:  LDA $9AD2,Y
L9A7B:  STA $0402,X
L9A7E:  LDA #$40
L9A80:  STA $6AFE,X
L9A83:  LDA #$00
L9A85:  STA $0406,X
L9A88:  LDA $6AF4,X
L9A8B:  CMP #$03
L9A8D:  BEQ $9ACA
L9A8F:  LDA $81
L9A91:  CMP #$01
L9A93:  BEQ $9ACA
L9A95:  CMP #$03
L9A97:  BEQ $9ACF
L9A99:  JSR CommonJump_Unknown36
L9A9C:  LDX $4B
L9A9E:  LDA #$00
L9AA0:  STA $05
L9AA2:  LDA #$1D
L9AA4:  LDY $00
L9AA6:  STY $04
L9AA8:  BMI $9AAC
L9AAA:  LDA #$20
L9AAC:  STA $6AF9,X
L9AAF:  JSR $9A42
L9AB2:  JSR CommonJump_Unknown27
L9AB5:  LDA #$E8
L9AB7:  BCC $9ABD
L9AB9:  CMP $08
L9ABB:  BCS $9AC7
L9ABD:  STA $08
L9ABF:  LDA EnData05,X
L9AC2:  ORA #$20
L9AC4:  STA EnData05,X
L9AC7:  JSR $9A52
L9ACA:  LDA #$02
L9ACC:  JMP CommonJump_UnknownUpdateAnim1
L9ACF:  JMP CommonJump_Unknown06
L9AD2:  INC $F8,X
L9AD4:  INC $FA,X
L9AD6:  LDA $6AF4,X
L9AD9:  CMP #$02
L9ADB:  BNE $9AE0
L9ADD:  JSR CommonJump_Unknown1E
L9AE0:  LDA #$02
L9AE2:  STA $00
L9AE4:  STA $01
L9AE6:  JMP $9839
L9AE9:  LDA $6AF4,X
L9AEC:  CMP #$01
L9AEE:  BNE $9AF5
L9AF0:  LDA #$E8
L9AF2:  STA $0400,X
L9AF5:  CMP #$02
L9AF7:  BNE $9B4F
L9AF9:  LDA $0406,X
L9AFC:  BEQ $9B4F
L9AFE:  LDA $6B01,X
L9B01:  BNE $9B4F
L9B03:  LDA $2D
L9B05:  AND #$1F
L9B07:  BNE $9B3C
L9B09:  LDA $2E
L9B0B:  AND #$03
L9B0D:  BEQ $9B59
L9B0F:  LDA #$02
L9B11:  STA $87
L9B13:  LDA #$00
L9B15:  STA $88
L9B17:  LDA #$43
L9B19:  STA $83
L9B1B:  LDA #$47
L9B1D:  STA $84
L9B1F:  LDA #$03
L9B21:  STA $85
L9B23:  JSR CommonJump_Unknown21
L9B26:  LDA $0680
L9B29:  ORA #$04
L9B2B:  STA $0680
L9B2E:  LDA EnData05,X
L9B31:  AND #$01
L9B33:  TAY 
L9B34:  LDA $0083,Y
L9B37:  JSR CommonJump_ResetAnimIndex
L9B3A:  BEQ $9B59
L9B3C:  CMP #$0F
L9B3E:  BCC $9B59
L9B40:  LDA EnData05,X
L9B43:  AND #$01
L9B45:  TAY 
L9B46:  LDA $9B62,Y
L9B49:  JSR CommonJump_ResetAnimIndex
L9B4C:  JMP $9B59
L9B4F:  LDA $6AF4,X
L9B52:  CMP #$03
L9B54:  BEQ $9B59
L9B56:  JSR CommonJump_Unknown1E
L9B59:  LDA #$01
L9B5B:  STA $00
L9B5D:  STA $01
L9B5F:  JMP $9839
L9B62:  EOR $49
L9B64:  LDA #$00
L9B66:  STA $6AF5,X
L9B69:  STA $6AF6,X
L9B6C:  LDA #$10
L9B6E:  STA EnData05,X
L9B71:  TXA 
L9B72:  ASL 
L9B73:  ASL 
L9B74:  STA $00
L9B76:  TXA 
L9B77:  LSR 
L9B78:  LSR 
L9B79:  LSR 
L9B7A:  LSR 
L9B7B:  ADC $2D
L9B7D:  ADC $00
L9B7F:  AND #$47
L9B81:  BNE $9B9D
L9B83:  LSR EnData05,X
L9B86:  LDA #$03
L9B88:  STA $87
L9B8A:  LDA $2E
L9B8C:  LSR 
L9B8D:  ROL EnData05,X
L9B90:  AND #$03
L9B92:  BEQ $9B9D
L9B94:  STA $88
L9B96:  LDA #$02
L9B98:  STA $85
L9B9A:  JMP CommonJump_Unknown21
L9B9D:  RTS

L9B9E:  .byte $22, $FF, $FF, $FF, $FF

L9BA3:  .byte $22, $80, $81, $82, $83

L9BA8:  .byte $22, $84, $85, $86, $87

L9BAD:  .byte $22, $88, $89, $8A, $8B

L9BB2:  .byte $22, $8C, $8D, $8E, $8F

L9BB7:  .byte $22, $94, $95, $96, $97

L9BBC:  .byte $22, $9C, $9D, $9D, $9C

L9BC1:  .byte $22, $9E, $9F, $9F, $9E

L9BC6:  .byte $22, $90, $91, $92, $93

L9BCB:  .byte $22, $70, $71, $72, $73

L9BD0:  .byte $22, $74, $75, $75, $74

L9BD5:  .byte $22, $76, $76, $76, $76

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9BDA:  .byte $00, $01, $FF

L9BDD:  .byte $02, $FF

L9BDF:  .byte $03, $04, $FF

L9BE2:  .byte $07, $08, $FF

L9BE5:  .byte $05, $06, $FF

L9BE8:  .byte $09, $0A, $FF

L9BEB:  .byte $0B, $FF

L9BED:  .byte $0C, $0D, $0E, $0F, $FF

L9BF2:  .byte $10, $11, $12, $13, $FF

L9BF7:  .byte $15, $14, $FF

L9BFA:  .byte $16, $FF

L9BFC:  .byte $17, $18, $FF

L9BFF:  .byte $19, $1A, $FF

L9C02:  .byte $1B, $FF

L9C04:  .byte $1C, $1D, $FF

L9C07:  .byte $1E, $1F, $FF

L9C0A:  .byte $20, $FF

L9C0C:  .byte $21, $22, $FF

L9C0F:  .byte $23, $FF

L9C11:  .byte $27, $28, $29, $2A, $FF

L9C16:  .byte $2B, $2C, $2D, $2E, $FF

L9C1B:  .byte $2F, $FF

L9C1D:  .byte $30, $FF

L9C1F:  .byte $31, $FF

L9C21:  .byte $32, $FF

L9C23:  .byte $33, $FF

L9C25:  .byte $34, $FF

L9C27:  .byte $42, $FF

L9C29:  .byte $43, $44, $F7, $FF

L9C2D:  .byte $3B, $FF

L9C2F:  .byte $3C, $FF

L9C31:  .byte $3D, $FF, $3E, $FF

L9C35:  .byte $3F, $3F, $3F, $3F, $3F, $41, $41, $41, $41, $40, $40, $40, $F7, $FF

L9C43:  .byte $58, $59, $FF

L9C46:  .byte $5A, $5B, $FF

L9C49:  .byte $5C, $5D, $FF

L9C4C:  .byte $5E, $5F, $FF

L9C4F:  .byte $60, $FF

L9C51:  .byte $61, $F7, $62, $F7, $FF

L9C56:  .byte $66, $67, $FF

L9C59:  .byte $69, $6A, $FF

L9C5C:  .byte $68, $FF

L9C5E:  .byte $6B, $FF

L9C60:  .byte $66, $FF

L9C62:  .byte $69, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9C64:  .word $9E0A, $9E0F, $9E14, $9E19, $9E2C, $9E40, $9E56, $9E6C
L9C74:  .word $9E7F, $9E93, $9EA9, $9EBF, $9EC9, $9ECE, $9ED3, $9ED8
L9C84:  .word $9EDD, $9EE2, $9EE7, $9EEC, $9EF1, $9EFF, $9F0D, $9F1B
L9C94:  .word $9F2A, $9F39, $9F4A, $9F5B, $9F63, $9F69, $9F6F, $9F75
L9CA4:  .word $9F7B, $9F81, $9F89, $9F91, $9F99, $9F99, $9F99, $9F99
L9CB4:  .word $9FA5, $9FB3, $9FC1, $9FCF, $9FDB, $9FE9, $9FF7, $A005
L9CC4:  .word $A010, $A01F, $A02E, $A03D, $A04C, $A059, $A059, $A059
L9CD4:  .word $A059, $A059, $A059, $A059, $A061, $A069, $A071, $A079
L9CE4:  .word $A081, $A089, $A093, $A098, $A0A0, $A0A8, $A0A8, $A0A8
L9CF4:  .word $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8
L9D04:  .word $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8, $A0A8
L9D14:  .word $A0A8, $A0B4, $A0C0, $A0CC, $A0D8, $A0E4, $A0F0, $A0FC
L9D24:  .word $A108, $A110, $A11E, $A138, $A138, $A138, $A138, $A140
L9D34:  .word $A148, $A150, $A158, $A160, $A168, $A168, $A168, $A168
L9D44:  .word $A168, $A168, $A168, $A168, $A168, $A168, $A168, $A168
L9D54:  .word $A168, $A168, $A168, $A168, $A168, $A168, $A168, $A168

EnemyFramePtrTbl2:
L9D64:  .word $A168, $A16E, $A173, $A173, $A173, $A173, $A173, $A173
L9D74:  .word $A173, $A173

EnemyPlacePtrTbl:
L9D78:  .word $9D94, $9D96, $9DAE, $9DAE, $9DC0, $9DB2, $9DBC, $9DC4
L9D88:  .word $9DD0, $9DD8, $9DD8, $9DF8, $9E06, $9E0A

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9D94:  .byte $FC, $FC

L9D96:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9DA6:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9DAE:  .byte $F4, $F4, $F4, $04

L9DB2:  .byte $F8, $F4, $F8, $FC, $F8, $04, $00, $F8, $00, $00

L9DBC:  .byte $FC, $F8, $FC, $00

L9DC0:  .byte $F0, $F8, $F0, $00

L9DC4:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $08, $F8, $08, $00

L9DD0:  .byte $F8, $E8, $F8, $10, $F8, $F0, $F8, $08

L9DD8:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9DE8:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9DF8:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9E06:  .byte $F8, $FC, $00, $FC

;Enemy frame drawing data.

L9E0A:  .byte $00, $02, $02, $14, $FF

L9E0F:  .byte $00, $02, $02, $24, $FF

L9E14:  .byte $00, $00, $00, $04, $FF

L9E19:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E29:  .byte $F9, $F8, $FF

L9E2C:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E3C:  .byte $D8, $FE, $E8, $FF

L9E40:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E50:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9E56:  .byte $22, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9E66:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9E6C:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E7C:  .byte $F9, $F8, $FF

L9E7F:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $D5, $E5, $E6, $E7, $F5, $F6, $F7
L9E8F:  .byte $D8, $FE, $E8, $FF

L9E93:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9EA3:  .byte $F9, $F8, $FE, $D5, $FA, $FF

L9EA9:  .byte $62, $13, $08, $C8, $C9, $C6, $C7, $D6, $D7, $FE, $D9, $E6, $E7, $E9, $EA, $EB
L9EB9:  .byte $D8, $FE, $E8, $D5, $FA, $FF

L9EBF:  .byte $21, $00, $00, $C6, $C7, $D6, $D7, $E6, $E7, $FF

L9EC9:  .byte $20, $04, $04, $EC, $FF

L9ECE:  .byte $20, $04, $04, $FB, $FF

L9ED3:  .byte $E0, $04, $04, $EC, $FF

L9ED8:  .byte $E0, $04, $04, $FB, $FF

L9EDD:  .byte $60, $04, $04, $EC, $FF

L9EE2:  .byte $60, $04, $04, $FB, $FF

L9EE7:  .byte $A0, $04, $04, $EC, $FF

L9EEC:  .byte $A0, $04, $04, $FB, $FF

L9EF1:  .byte $27, $08, $08, $EA, $FD, $62, $EA, $FD, $22, $FB, $FD, $62, $FB, $FF

L9EFF:  .byte $27, $08, $08, $EA, $FD, $62, $EA, $FD, $22, $FA, $FD, $62, $FA, $FF

L9F0D:  .byte $27, $08, $08, $EA, $FD, $62, $EA, $FD, $22, $EB, $FD, $62, $EB, $FF

L9F1B:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DF, $FD, $62, $DF, $FF

L9F2A:  .byte $25, $08, $08, $CE, $CF, $FD, $62, $CE, $FD, $22, $DE, $FD, $62, $DE, $FF

L9F39:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DF, $FD, $E2, $DF
L9F49:  .byte $FF

L9F4A:  .byte $A5, $08, $08, $FD, $22, $CE, $CF, $FD, $62, $CE, $FD, $A2, $DE, $FD, $E2, $DE
L9F5A:  .byte $FF

L9F5B:  .byte $21, $00, $00, $CE, $CE, $DF, $DF, $FF

L9F63:  .byte $39, $04, $08, $F6, $F7, $FF

L9F69:  .byte $39, $04, $08, $E7, $F7, $FF

L9F6F:  .byte $79, $04, $08, $F6, $F7, $FF

L9F75:  .byte $79, $04, $08, $E7, $F7, $FF

L9F7B:  .byte $31, $00, $00, $F6, $F7, $FF

L9F81:  .byte $29, $04, $08, $E6, $FD, $62, $E6, $FF

L9F89:  .byte $29, $04, $08, $E5, $FD, $62, $E5, $FF

L9F91:  .byte $21, $00, $00, $EA, $EA, $EB, $EB, $FF

L9F99:  .byte $27, $08, $08, $EE, $EF, $FD, $E2, $EF, $FD, $A2, $EF, $FF

L9FA5:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $ED, $FD, $A2, $EF, $FF

L9FB3:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $22, $EF, $FD, $E2, $EF, $EE, $FF

L9FC1:  .byte $27, $08, $08, $FD, $62, $EF, $FD, $E2, $ED, $EF, $FD, $A2, $EF, $FF

L9FCF:  .byte $67, $08, $08, $EE, $EF, $FD, $A2, $EF, $FD, $E2, $EF, $FF

L9FDB:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $ED, $FD, $E2, $EF, $FF

L9FE9:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $62, $EF, $FD, $A2, $EF, $EE, $FF

L9FF7:  .byte $67, $08, $08, $FD, $22, $EF, $FD, $A2, $ED, $EF, $FD, $E2, $EF, $FF

LA005:  .byte $21, $00, $00, $FC, $04, $00, $EE, $EF, $EF, $EF, $FF

LA010:  .byte $24, $08, $08, $FC, $08, $00, $C8, $C9, $D8, $D9, $E8, $E9, $F8, $F9, $FF

LA01F:  .byte $24, $08, $08, $FC, $08, $00, $C8, $C7, $D8, $D7, $E8, $E9, $F8, $F9, $FF

LA02E:  .byte $64, $08, $08, $FC, $08, $00, $C8, $C9, $D8, $D9, $E8, $E9, $F8, $F9, $FF

LA03D:  .byte $64, $08, $08, $FC, $08, $00, $C8, $C7, $D8, $D7, $E8, $E9, $F8, $F9, $FF

LA04C:  .byte $21, $00, $00, $FC, $FC, $00, $C8, $C9, $D8, $D9, $E8, $E9, $FF

LA059:  .byte $37, $04, $04, $E0, $E1, $F0, $F1, $FF

LA061:  .byte $B7, $04, $04, $E0, $E1, $F0, $F1, $FF

LA069:  .byte $77, $04, $04, $E0, $E1, $F0, $F1, $FF

LA071:  .byte $F7, $04, $04, $E0, $E1, $F0, $F1, $FF

LA079:  .byte $37, $00, $00, $E2, $FD, $63, $E2, $FF

LA081:  .byte $38, $00, $00, $E2, $FD, $62, $E2, $FF

LA089:  .byte $38, $00, $00, $FE, $FE, $E2, $FD, $62, $E2, $FF

LA093:  .byte $30, $04, $04, $C0, $FF

LA098:  .byte $30, $00, $00, $FC, $F8, $00, $D0, $FF

LA0A0:  .byte $33, $00, $00, $D1, $FD, $63, $D1, $FF

LA0A8:  .byte $27, $08, $08, $CC, $FD, $62, $CC, $FD, $22, $DC, $DD, $FF

LA0B4:  .byte $67, $08, $08, $FD, $22, $CD, $FD, $62, $CD, $DC, $DD, $FF

LA0C0:  .byte $27, $08, $08, $FD, $A2, $DA, $FD, $22, $CB, $DA, $DB, $FF

LA0CC:  .byte $A7, $08, $08, $CA, $CB, $FD, $22, $CA, $FD, $A2, $DB, $FF

LA0D8:  .byte $A7, $08, $08, $CC, $FD, $E2, $CC, $FD, $A2, $DC, $DD, $FF

LA0E4:  .byte $E7, $08, $08, $FD, $A2, $CD, $FD, $E2, $CD, $DC, $DD, $FF

LA0F0:  .byte $67, $08, $08, $FD, $E2, $DA, $FD, $62, $CB, $DA, $DB, $FF

LA0FC:  .byte $E7, $08, $08, $CA, $CB, $FD, $62, $CA, $FD, $E2, $DB, $FF

LA108:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA110:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA11E:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA12E:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA138:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA140:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA148:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA150:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA158:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA160:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA168:  .byte $0C, $08, $04, $14, $24, $FF

LA16E:  .byte $00, $04, $04, $8A, $FF

LA173:  .byte $00, $04, $04, $8A, $FF

;-----------------------------------------[ Palette data ]-------------------------------------------

Palette00:
LA178:  .byte $3F                       ;Upper byte of PPU palette adress.
LA179:  .byte $00                       ;Lower byte of PPU palette adress.
LA17A:  .byte $20                       ;Palette data length.
;The following values are written to the background palette:
LA17B:  .byte $0F, $20, $10, $00, $0F, $28, $16, $04, $0F, $16, $11, $04, $0F, $31, $13, $15
;The following values are written to the sprite palette:
LA18B:  .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $14, $23, $2C, $0F, $16, $24, $37

LA19B:  .byte $00                       ;End Palette00 info.

Palette01:
LA19C:  .byte $3F                       ;Upper byte of PPU palette adress.
LA19D:  .byte $12                       ;Lower byte of PPU palette adress.
LA19E:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA19F:  .byte $19, $27

LA1A0:  .byte $00                       ;End Palette01 info.

Palette03:
LA1A2:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1A3:  .byte $12                       ;Lower byte of PPU palette adress.
LA1A4:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA1A5:  .byte $2C, $27

LA1A7:  .byte $00                       ;End Palette02 info.

Palette02:
LA1A8:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1A9:  .byte $12                       ;Lower byte of PPU palette adress.
LA1AA:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA1AB:  .byte $19, $35

LA1AD:  .byte $00                       ;End Palette03 info.

Palette04:
LA1AE:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1AF:  .byte $12                       ;Lower byte of PPU palette adress.
LA1B0:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA1B1:  .byte $2C, $24

LA1B3:  .byte $00                       ;End Palette04 info.

Palette05:
LA1B4:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1B5:  .byte $00                       ;Lower byte of PPU palette adress.
LA1B6:  .byte $10                       ;Palette data length.
;The following values are written to the background palette:
LA1B7:  .byte $0F, $20, $10, $00, $0F, $28, $16, $04, $0F, $16, $11, $04, $0F, $35, $1B, $16
LAC17:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1C8:  .byte $14                       ;Lower byte of PPU palette adress.
LA1C9:  .byte $0C                       ;Palette data length.
;The following values are written to the sprite palette:
LA1CA:  .byte $0F, $12, $30, $21, $0F, $14, $23, $2C, $0F, $16, $24, $37

LA1D6:  .byte $00                       ;End Palette05 info.

Palette06:
LA1D7:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1D8:  .byte $11                       ;Lower byte of PPU palette adress.
LA1D9:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1DA:  .byte $04, $09, $07

LA1DD:  .byte $00                       ;End Palette06 info.

Palette07:
LA1DE:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1DF:  .byte $11                       ;Lower byte of PPU palette adress.
LA1E0:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1E1:  .byte $05, $09, $17

LA1E4:  .byte $00                       ;End Palette07 info.

Palette08:
LA1E5:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1E6:  .byte $11                       ;Lower byte of PPU palette adress.
LA1E7:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1E8:  .byte $06, $0A, $26

LA1EB:  .byte $00                       ;End Palette08 info.

Palette09:
LA1EC:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1ED:  .byte $11                       ;Lower byte of PPU palette adress.
LA1EE:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA1EF:  .byte $16, $19, $27

LA1F2:  .byte $00                       ;End Palette09 info.

Palette0A:
LA1F3:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1F4:  .byte $00                       ;Lower byte of PPU palette adress.
LA1F5:  .byte $04                       ;Palette data length.
;The following values are written to the background palette:
LA1F6:  .byte $0F, $30, $30, $21

LA1FA:  .byte $00                       ;End Palette0A info.

Palette0B:
LA1FB:  .byte $3F                       ;Upper byte of PPU palette adress.
LA1FC:  .byte $10                       ;Lower byte of PPU palette adress.
LA1FD:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA1FE:  .byte $0F, $15, $34, $17

LA202:  .byte $00                       ;End Palette0B info.

Palette0C:
LA203:  .byte $3F                       ;Upper byte of PPU palette adress.
LA204:  .byte $10                       ;Lower byte of PPU palette adress.
LA205:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA206:  .byte $0F, $15, $34, $19

LA20A:  .byte $00                       ;End Palette0C info.

Palette0D:
LA20B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA20C:  .byte $10                       ;Lower byte of PPU palette adress.
LA20D:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA20E:  .byte $0F, $15, $34, $28

LA212:  .byte $00                       ;End Palette0D info.

Palette0E:
LA213:  .byte $3F                       ;Upper byte of PPU palette adress.
LA214:  .byte $10                       ;Lower byte of PPU palette adress.
LA215:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA216:  .byte $0F, $15, $34, $29

LA21A:  .byte $00                       ;End Palette0E info.

;--------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
LA21B:  .word $A3AB, $A3BE, $A3C6, $A3F8, $A42F, $A473, $A4AB, $A4F5
LA22B:  .word $A527, $A55F, $A598, $A5D9, $A617, $A63E, $A678, $A6AA
LA23B:  .word $A6DF, $A70E, $A749, $A77E, $A7B3, $A7E6, $A82B, $A852
LA24B:  .word $A87F, $A8B2, $A8DC, $A909, $A947, $A979, $A9AB, $A9D5
LA25B:  .word $A9FF, $AA3D, $AA6F, $AAA7, $AAD4, $AB0D, $AB34, $AB70
LA26B:  .word $ABA5, $ABDA, $AC0D, $AC42, $AC72, $AC99

StrctPtrTbl:
LA277:  .word $ACB9, $ACCC, $ACE5, $ACFE, $AD05, $AD0C, $AD10, $AD16
LA287:  .word $AD26, $AD2B, $AD31, $AD39, $AD4E, $AD57, $AD61, $AD6c
LA297:  .word $AD78, $AD7B, $AD85, $AD88, $AD9C, $ADB1, $ADB7, $ADBD
LA2A7:  .word $ADC6, $ADCF, $ADE2, $ADF7, $AE0C, $AE1D, $AE23, $AE26
LA2B7:  .word $AE2F, $AE3A, $AE40, $AE55, $AE59, $AE64, $AE6D, $AE82
LA2C7:  .word $AE85, $AE8E, $AE91, $AE94, $AE9A, $AEA7, $AEB1, $AEC6
LA2D7:  .word $AED9

;---------------------------------[ Special items table ]-----------------------------------------

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
;
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
LA2D9:  .byte $0A
LA2DA:  .word $A2E8
LA2DC:  .byte $1B, $06, $02, $09, $34, $00

;Missiles.
LA2E2:  .byte $1C, $FF, $02, $09, $34, $00

;Elevator from Brinstar.
LA2E8:  .byte $0B
LA2E9:  .word $A302
LA2EB:  .byte $16, $05, $04, $81, $00

;Missiles.
LA2F0:  .byte $1A, $06, $02, $09, $34, $00

;Missiles.
LA2F6:  .byte $1B, $06, $02, $09, $34, $00

;Missiles.
LA2FC:  .byte $1C, $FF, $02, $09, $34, $00

;Ice beam.
LA302:  .byte $0C
LA303:  .word $A30B
LA305:  .byte $1A, $FF, $02, $07, $37, $00

;Elevator to Brinstar.
LA30B:  .byte $0D
LA30C:  .word $A313
LA30E:  .byte $16, $FF, $04, $81, $00

;Missiles.
LA313:  .byte $0E
LA314:  .word $A31C
LA316:  .byte $12, $FF, $02, $09, $34, $00

;Missiles and Melias.
LA31C:  .byte $0F
LA31D:  .word $A33B
LA31F:  .byte $11, $07, $02, $09, $34, $03, $00

;Missiles.
LA326:  .byte $13, $06, $02, $09, $34, $00

;Missiles.
LA32C:  .byte $14, $06, $02, $09, $34, $00

;Squeept.
LA332:  .byte $15, $FF, $41, $8B, $E9, $51, $02, $9B, $00

;Screw attack.
LA33B:  .byte $10
LA33C:  .word $A344
LA33E:  .byte $0F, $FF, $02, $03, $37, $00

;Palette change room.
LA344:  .byte $11
LA345:  .word $A36D
LA347:  .byte $16, $04, $0A, $00

;Squeept.
LA34B:  .byte $18, $09, $31, $0B, $E9, $41, $02, $9A, $00

;Squeept.
LA354:  .byte $19, $09, $21, $8B, $E9, $51, $02, $9A, $00

;High jump.
LA35D:  .byte $1B, $06, $02, $01, $37, $00

;Right door.
LA363:  .byte $1D, $05, $09, $A0, $00

;Left door.
LA368:  .byte $1E, $FF, $09, $B0, $00

;Energy tank.
LA36D:  .byte $13
LA36E:  .word $A376
LA370:  .byte $1A, $FF, $02, $08, $42, $00

;Right door.
LA376:  .byte $14
LA377:  .word $A389
LA379:  .byte $0D, $05, $09, $A0, $00

;Left door.
LA37E:  .byte $0E, $05, $09, $B0, $00

;Missiles.
LA383:  .byte $1C, $FF, $02, $09, $34, $00

;Wave beam.
LA389:  .byte $15
LA38A:  .word $A397
LA38C:  .byte $12, $06, $02, $06, $37, $00

;Right door(undefined room).
LA392:  .byte $17, $FF, $09, $A0, $00

;Missiles.
LA397:  .byte $16
LA398:  .word $FFFF
LA39A:  .byte $13, $06, $02, $09, $34, $00

;Missiles.
LA3A0:  .byte $14, $06, $02, $09, $34, $00

;Elevator to Ridley hideout.
LA3A6:  .byte $19, $FF, $04, $04, $00

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
LA3AB:  .byte $02                       ;Attribute table data.
;Room object data:
LA3AC:  .byte $40, $01, $02, $48, $01, $02, $50, $04, $02, $5F, $04, $02, $FD, $02, $A1, $02
LA3BC:  .byte $B1, $FF

;Room #$01
LA3BE:  .byte $02                       ;Attribute table data.
;Room object data:
LA3BF:  .byte $07, $02, $02, $87, $02, $02, $FF

;Room #$02
LA3C6:  .byte $03                       ;Attribute table data.
;Room object data:
LA3C7:  .byte $00, $0B, $03, $04, $06, $03, $08, $06, $03, $0C, $0B, $03, $40, $07, $03, $4E
LA3D7:  .byte $07, $03, $76, $08, $01, $79, $08, $01, $90, $07, $03, $96, $09, $00, $9E, $07
LA3E7:  .byte $03, $A4, $06, $03, $A8, $06, $03, $B7, $0A, $03, $E0, $06, $03, $EC, $06, $03
LA3F7:  .byte $FF

;Room #$03
LA3F8:  .byte $03                       ;Attribute table data.
;Room object data:
LA3F9:  .byte $00, $07, $03, $0E, $07, $03, $2B, $06, $03, $36, $06, $03, $50, $03, $02, $5F
LA409:  .byte $03, $02, $80, $0B, $03, $84, $0B, $03, $88, $0B, $03, $8C, $0B, $03, $8D, $17
LA419:  .byte $03, $C0, $0B, $03, $C4, $0B, $03, $C8, $0B, $03, $CC, $0B, $03, $CD, $17, $03
LA429:  .byte $FD
;Enemy/door data.
LA42A:  .byte $02, $A1, $02, $B1, $FF

;Room #$04
LA42F:  .byte $00                       ;Attribute table data.
;Room object data:
LA430:  .byte $00, $0D, $00, $08, $0D, $00, $10, $0C, $00, $14, $0C, $00, $1F, $1F, $00, $25
LA440:  .byte $0F, $02, $50, $0D, $00, $5F, $04, $02, $63, $0D, $00, $70, $0D, $00, $78, $12
LA450:  .byte $00, $80, $11, $00, $88, $12, $00, $89, $0D, $00, $90, $0E, $00, $94, $0D, $00
LA460:  .byte $9C, $0E, $00, $B0, $0C, $00, $BF, $0C, $00, $D1, $00, $02, $D7, $00, $02, $FD
;Enemy/door data.
LA470:  .byte $02, $A0, $FF

;Room #$05
LA473:  .byte $00                       ;Attribute table data.
;Room object data:
LA474:  .byte $00, $07, $03, $02, $06, $03, $06, $13, $02, $0A, $14, $02, $0E, $07, $03, $12
LA484:  .byte $0A, $03, $2B, $0C, $00, $47, $13, $02, $4B, $14, $02, $4E, $0C, $00, $4F, $14
LA494:  .byte $02, $50, $03, $02, $6B, $09, $00, $7A, $09, $00, $80, $0D, $00, $87, $02, $02
LA4A4:  .byte $89, $0D, $00, $FD, $02, $B1, $FF

;Room #$06
LA4AB:  .byte $03                       ;Attribute table data.
;Room object data:
LA4AC:  .byte $00, $0B, $03, $04, $0B, $03, $08, $0B, $03, $0C, $0B, $03, $30, $16, $03, $34
LA4BC:  .byte $16, $03, $38, $16, $03, $3C, $16, $03, $40, $0B, $03, $44, $0B, $03, $48, $0B
LA4CC:  .byte $03, $4C, $0B, $03, $80, $16, $03, $84, $16, $03, $88, $16, $03, $8C, $16, $03
LA4DC:  .byte $90, $0B, $03, $94, $0B, $03, $98, $0B, $03, $9C, $0B, $03, $D0, $0B, $03, $D4
LA4EC:  .byte $0B, $03, $D8, $0B, $03, $DC, $0B, $03, $FF

;Room #$07
LA4F5:  .byte $03                       ;Attribute table data.
;Room object data:
LA4F6:  .byte $00, $0B, $03, $04, $0B, $03, $08, $0B, $03, $0C, $0B, $03, $40, $0B, $03, $44
LA506:  .byte $0B, $03, $48, $0B, $03, $4C, $0B, $03, $74, $0B, $03, $80, $0B, $03, $88, $0B
LA516:  .byte $03, $8C, $0B, $03, $B0, $0B, $03, $B4, $0B, $03, $BC, $0B, $03, $C8, $0B, $03
LA526:  .byte $FF

;Room #$08
LA527:  .byte $03                       ;Attribute table data.
;Room object data:
LA528:  .byte $00, $07, $03, $08, $06, $03, $0E, $07, $03, $1D, $18, $01, $32, $06, $03, $50
LA538:  .byte $07, $03, $5F, $03, $02, $86, $10, $01, $8D, $18, $01, $8E, $07, $03, $A0, $07
LA548:  .byte $03, $A9, $10, $01, $BE, $0B, $03, $CD, $18, $01, $FD
;Enemy/door data.
LA553:  .byte $02, $A1, $41, $02, $8B, $51, $06, $76, $21, $82, $A3, $FF

;Room #$09
LA55F:  .byte $03                       ;Attribute table data.
;Room object data:
LA560:  .byte $00, $07, $03, $0E, $0B, $03, $2A, $06, $03, $33, $06, $03, $35, $06, $03, $43
LA570:  .byte $0A, $03, $4E, $0B, $03, $50, $07, $03, $6E, $07, $03, $80, $07, $03, $87, $06
LA580:  .byte $03, $97, $0A, $03, $BE, $0B, $03, $C0, $07, $03, $D4, $06, $03, $FD
;Enemy/door data.
LA58E:  .byte $01, $86, $25, $11, $82, $C5, $41, $06, $79, $FF

;Room #$0A
LA598:  .byte $02                       ;Attribute table data.
;Room object data:
LA599:  .byte $00, $07, $03, $05, $06, $03, $0C, $18, $01, $0E, $07, $03, $40, $07, $03, $57
LA5A9:  .byte $06, $03, $5F, $03, $02, $80, $0B, $03, $84, $00, $02, $8C, $0B, $03, $A4, $17
LA5B9:  .byte $03, $A5, $0B, $03, $A9, $0B, $03, $C0, $0B, $03, $C9, $0B, $03, $CD, $0B, $03
LA5C9:  .byte $D4, $17, $03, $E5, $0B, $03, $FD
;Enemy/door data.
LA5D0:  .byte $02, $A1, $31, $02, $36, $41, $86, $48, $FF

;Room #$0B
LA5D9:  .byte $01                       ;Attribute table data.
;Room object data:
LA5DA:  .byte $00, $07, $03, $0E, $07, $03, $12, $06, $03, $39, $06, $03, $50, $03, $02, $5E
LA5EA:  .byte $0B, $03, $80, $0B, $03, $84, $0B, $03, $88, $0B, $03, $8C, $17, $03, $8D, $0B
LA5FA:  .byte $03, $B0, $0B, $03, $B8, $0B, $03, $BC, $17, $03, $BD, $0B, $03, $C4, $0B, $03
LA60A:  .byte $EC, $17, $03, $FD
;Enemy/door data.
LA60E:  .byte $02, $B1, $41, $06, $2B, $51, $02, $1A, $FF

;Room #$0C
LA617:  .byte $03                       ;Attribute table data.
;Room object data:
LA618:  .byte $00, $07, $03, $0D, $18, $01, $0E, $07, $03, $4D, $18, $01, $50, $07, $03, $5E
LA628:  .byte $07, $03, $8D, $18, $01, $A0, $07, $03, $AE, $07, $03, $CD, $18, $01, $FD
;Enemy/door data.
LA637:  .byte $01, $02, $33, $31, $82, $88, $FF

;Room #$0D
LA63E:  .byte $03                       ;Attribute table data.
;Room object data:
LA63F:  .byte $10, $0B, $03, $14, $0B, $03, $18, $0B, $03, $1C, $0B, $03, $50, $03, $02, $5F
LA64F:  .byte $03, $02, $80, $07, $03, $81, $17, $03, $82, $06, $03, $86, $06, $03, $8A, $06
LA65F:  .byte $03, $8E, $07, $03, $97, $0A, $03, $C0, $0B, $03, $CC, $0B, $03, $D4, $19, $02
LA66F:  .byte $FD
;Enemy/door data.
LA670:  .byte $02, $A1, $02, $B1, $21, $0D, $E5, $FF

;Room #$0E
LA678:  .byte $03                       ;Attribute table data.
;Room object data:
LA679:  .byte $00, $07, $03, $0E, $07, $03, $2B, $06, $03, $30, $06, $03, $4A, $06, $03, $50
LA689:  .byte $03, $02, $5E, $07, $03, $80, $07, $03, $81, $06, $03, $AE, $07, $03, $B0, $07
LA699:  .byte $03, $B5, $06, $03, $FD
;Enemy/door data.
LA69E:  .byte $02, $B1, $11, $86, $A6, $31, $02, $EA, $21, $02, $39, $FF

;Room #$0F
LA6A9:  .byte $00                       ;Attribute table data.
;Room object data:
LA6AB:  .byte $00, $0E, $00, $04, $0D, $00, $0C, $0D, $00, $10, $0C, $00, $50, $04, $02, $80
LA6BB:  .byte $09, $00, $90, $0C, $00, $92, $09, $00, $AF, $09, $00, $B9, $09, $00, $D0, $0E
LA6CB:  .byte $00, $D3, $00, $02, $DB, $00, $02, $FD
;Enemy/door data.
LA6D3:  .byte $02, $B0, $01, $0D, $E7, $11, $8D, $ED, $31, $06, $AA, $FF

;Room #$10
LA6DF:  .byte $01                       ;Attribute table data.
;Room object data:
LA6E0:  .byte $00, $0D, $00, $04, $0D, $00, $0C, $0E, $00, $1F, $0C, $00, $5F, $03, $02, $8C
LA6F0:  .byte $09, $00, $94, $09, $00, $9F, $0C, $00, $D0, $00, $02, $D5, $00, $02, $DD, $0E
LA700:  .byte $00, $FD
;Enemy/door data.
LA702:  .byte $02, $A1, $21, $0D, $E2, $41, $0D, $EA, $31, $06, $85, $FF

;Room #$11
LA70E:  .byte $03                       ;Attribute table data.
;Room object data:
LA70F:  .byte $10, $0B, $03, $14, $0B, $03, $18, $0B, $03, $1C, $0B, $03, $50, $03, $02, $5C
LA71F:  .byte $0B, $03, $80, $07, $03, $81, $17, $03, $82, $06, $03, $86, $06, $03, $8A, $06
LA72F:  .byte $03, $8C, $0B, $03, $B0, $0B, $03, $B4, $19, $02, $BC, $17, $03, $CD, $0B, $03
LA73F:  .byte $D4, $0B, $03, $D8, $0B, $03, $FD
;Enemy/door data.
LA746:  .byte $02, $B1, $FF

;Room #$12
LA749:  .byte $03                       ;Attribute table data.
;Room object data:
LA74A:  .byte $00, $2D, $03, $08, $2D, $03, $10, $1B, $03, $14, $0A, $03, $50, $03, $02, $80
LA75A:  .byte $1B, $03, $9A, $1C, $03, $B0, $1B, $03, $B6, $1C, $03, $BE, $1C, $03, $C4, $1C
LA76A:  .byte $03, $D4, $00, $02, $D9, $00, $02, $FD
;Enemy/door data.
LA772:  .byte $02, $B1, $01, $00, $1C, $41, $00, $18, $21, $0D, $EC, $FF

;Room #$13
LA77E:  .byte $03                       ;Attribute table data.
;Room object data:
LA77F:  .byte $00, $2D, $03, $08, $2D, $03, $12, $0A, $03, $1E, $1B, $03, $5F, $03, $02, $69
LA78F:  .byte $1C, $03, $8D, $1B, $03, $A3, $1D, $03, $B0, $1C, $03, $CE, $1B, $03, $D0, $00
LA79F:  .byte $02, $D6, $00, $02, $FD
;Enemy/door data.
LA7A4:  .byte $02, $A1, $51, $80, $24, $41, $0D, $E2, $31, $86, $94, $11, $86, $69, $FF

;Room #$14
LA7B3:  .byte $03                       ;Attribute table data.
;Room object data:
LA7B4:  .byte $00, $2D, $03, $08, $2D, $03, $16, $0A, $03, $30, $1A, $01, $32, $1A, $01, $3A
LA7C4:  .byte $1A, $01, $3E, $1A, $01, $50, $1A, $01, $52, $1A, $01, $5A, $1A, $01, $5E, $1A
LA7D4:  .byte $01, $B7, $1C, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA7DF:  .byte $31, $0D, $E6, $51, $8D, $EB, $FF

;Room #$15
LA7E6:  .byte $01                       ;Attribute table data.
;Room object data:
LA7E7:  .byte $00, $2D, $03, $08, $2D, $03, $1C, $0A, $03, $52, $1C, $03, $58, $1C, $03, $5A
LA7F7:  .byte $1C, $03, $64, $1C, $03, $86, $1C, $03, $8C, $1C, $03, $8E, $1C, $03, $A0, $1C
LA807:  .byte $03, $D0, $1B, $03, $D3, $00, $02, $D4, $1B, $03, $D7, $00, $02, $DA, $1B, $03
LA817:  .byte $DD, $00, $02, $DE, $1B, $03, $FD
;Enemy/door data.
LA81E:  .byte $31, $0C, $1B, $01, $86, $54, $21, $86, $48, $51, $06, $7C, $FF

;Room #$16
LA82B:  .byte $03                       ;Attribute table data.
;Room object data:
LA82C:  .byte $00, $2D, $03, $08, $2D, $03, $12, $0A, $03, $1C, $0A, $03, $A2, $1D, $03, $AB
LA83C:  .byte $1D, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA845:  .byte $01, $0D, $E8, $11, $86, $94, $21, $86, $9C, $51, $00, $18, $FF

;Room #$17
LA852:  .byte $03                       ;Attribute table data.
;Room object data:
LA853:  .byte $00, $2D, $03, $08, $2D, $03, $16, $0A, $03, $80, $2D, $03, $8A, $2D, $03, $91
LA863:  .byte $0A, $03, $B8, $05, $01, $C7, $1D, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA872:  .byte $41, $06, $73, $51, $86, $7C, $31, $00, $27, $27, $87, $B9, $FF

;Room #$18
LA87F:  .byte $03                       ;Attribute table data.
;Room object data:
LA880:  .byte $00, $2D, $03, $08, $2D, $03, $1A, $0A, $03, $24, $1C, $03, $3E, $18, $01, $54
LA890:  .byte $18, $01, $7E, $18, $01, $A2, $1C, $03, $A7, $1D, $03, $BE, $1C, $03, $D0, $00
LA8A0:  .byte $02, $D8, $00, $02, $FD
;Enemy/door data.
LA8A5:  .byte $31, $00, $17, $41, $06, $97, $21, $8B, $E6, $01, $0D, $EC, $FF

;Room #$19
LA8B2:  .byte $00                       ;Attribute table data.
;Room object data:
LA8B3:  .byte $00, $0D, $00, $08, $0D, $00, $10, $1F, $00, $44, $1F, $00, $80, $12, $00, $81
LA8C3:  .byte $0D, $00, $90, $1F, $00, $98, $1F, $00, $AE, $0D, $00, $BB, $1F, $00, $D0, $00
LA8D3:  .byte $02, $D8, $00, $02, $FD
;Enemy/door data.
LA8D8:  .byte $31, $80, $17, $FF

;Room #$1A
LA8DC:  .byte $03                       ;Attribute table data.
;Room object data:
LA8DD:  .byte $00, $30, $01, $08, $30, $01, $80, $0D, $00, $84, $05, $02, $86, $05, $02, $88
LA8ED:  .byte $0D, $00, $8C, $20, $01, $94, $20, $01, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA8FC:  .byte $27, $87, $85, $37, $87, $87, $41, $00, $29, $51, $00, $2C, $FF

;Room #$1B
LA909:  .byte $00                       ;Attribute table data.
;Room object data:
LA90A:  .byte $00, $20, $01, $04, $20, $01, $08, $20, $01, $0C, $2E, $01, $10, $2E, $01, $4C
LA91A:  .byte $2E, $01, $50, $03, $02, $80, $2E, $01, $8C, $21, $01, $98, $20, $01, $9C, $2E
LA92A:  .byte $01, $A2, $20, $01, $C0, $2E, $01, $D2, $00, $02, $DA, $00, $02, $FD
;Enemy/door data.
LA938:  .byte $02, $B1, $01, $0C, $98, $31, $8C, $3A, $11, $0C, $38, $41, $8B, $E6, $FF

;Room #$1C
LA947:  .byte $02                       ;Attribute table data.
;Room object data:
LA948:  .byte $00, $22, $02, $04, $22, $02, $08, $22, $02, $0C, $22, $02, $1C, $22, $02, $5F
LA958:  .byte $03, $02, $8C, $22, $02, $A8, $22, $02, $B0, $22, $02, $B1, $23, $01, $B4, $22
LA968:  .byte $02, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA970:  .byte $02, $A1, $41, $0E, $B1, $31, $00, $49, $FF

;Room #$1D
LA979:  .byte $02                       ;Attribute table data.
;Room object data:
LA97A:  .byte $00, $22, $02, $04, $22, $02, $08, $22, $02, $0C, $22, $02, $10, $22, $02, $50
LA98A:  .byte $03, $02, $80, $22, $02, $B4, $22, $02, $B8, $22, $02, $BC, $22, $02, $BD, $23
LA999:  .byte $01, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA9A2:  .byte $02, $B1, $01, $0E, $BD, $21, $00, $49, $FF

;Room #$1E
LA9AB:  .byte $02                       ;Attribute table data.
;Room object data:
LA9AC:  .byte $00, $22, $02, $04, $22, $02, $08, $22, $02, $0C, $22, $02, $B6, $22, $02, $B7
LA9BC:  .byte $23, $01, $C1, $22, $02, $CB, $22, $02, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LA9CB:  .byte $51, $0E, $B7, $11, $06, $BD, $31, $86, $B3, $FF

;Room #$1F
LA9D5:  .byte $02                       ;Attribute table data.
;Room object data:
LA9D6:  .byte $00, $22, $02, $04, $22, $02, $08, $22, $02, $0C, $22, $02, $90, $22, $02, $9C
LA9E6:  .byte $22, $02, $A7, $23, $01, $B4, $22, $02, $B8, $22, $02, $D0, $00, $02, $D8, $00
LA9F6:  .byte $02, $FD
;Enemy/door data.
LA9F8:  .byte $41, $0E, $A7, $11, $02, $99, $FF

;Room #$20
LA9FF:  .byte $00                       ;Attribute table data.
;Room object data:
LAA00:  .byte $00, $2F, $03, $08, $2F, $03, $0B, $06, $03, $1C, $26, $03, $21, $25, $03, $22
LAA10:  .byte $06, $03, $5F, $04, $02, $8C, $26, $03, $B0, $25, $03, $B3, $23, $01, $B7, $24
LAA20:  .byte $03, $C2, $26, $03, $CE, $26, $03, $D0, $00, $02, $D6, $00, $02, $FD
;Enemy/door data.
LAA2E:  .byte $02, $A1, $41, $0E, $B3, $11, $86, $A9, $21, $0C, $43, $01, $0B, $EB, $FF

;Room #$21
LAA3D:  .byte $03                       ;Attribute table data.
;Room object data:
LAA3E:  .byte $00, $2F, $03, $08, $2F, $03, $10, $26, $03, $19, $06, $03, $50, $03, $02, $80
LAA4E:  .byte $26, $03, $AA, $25, $03, $B3, $24, $03, $CE, $24, $03, $D0, $00, $02, $D8, $00
LAA5E:  .byte $02, $FD
;Enemy/door data.
LAA60:  .byte $02, $B1, $31, $06, $BE, $51, $86, $9A, $41, $0C, $77, $21, $0C, $38, $FF

;Room #$22
LAA6F:  .byte $03                       ;Attribute table data.
;Room object data:
LAA70:  .byte $00, $2F, $03, $08, $2F, $03, $14, $06, $03, $17, $24, $03, $1E, $26, $03, $23
LAA80:  .byte $25, $03, $5F, $03, $02, $8D, $26, $03, $C2, $24, $03, $C7, $24, $03, $CC, $26
LAA90:  .byte $03, $D0, $00, $02, $D6, $00, $02, $FD
;Enemy/door data.
LAA98:  .byte $02, $A1, $01, $86, $B4, $11, $86, $B8, $21, $0C, $59, $31, $0C, $55, $FF

;Room #$23
LAAA7:  .byte $03                       ;Attribute table data.
;Room object data:
LAAA8:  .byte $00, $2F, $03, $08, $2F, $03, $14, $06, $03, $8D, $24, $03, $8F, $29, $03, $97
LAAB8:  .byte $24, $03, $B1, $24, $03, $B2, $05, $01, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LAAC7:  .byte $31, $86, $88, $41, $06, $7C, $51, $00, $29, $17, $87, $B3, $FF

;Room #$24
LAAD4:  .byte $03                       ;Attribute table data.
;Room object data:
LAAD5:  .byte $00, $2F, $03, $08, $2F, $03, $50, $2A, $03, $56, $2A, $03, $63, $2A, $03, $6E
LAAE5:  .byte $2A, $03, $78, $2A, $03, $8C, $2A, $03, $9F, $2A, $03, $A1, $2A, $03, $A5, $2A
LAAF5:  .byte $03, $BA, $2A, $03, $C7, $2A, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LAB03:  .byte $01, $0D, $E8, $21, $8B, $ED, $31, $0B, $E9, $FF

;Room #$25
LAB0D:  .byte $00                       ;Attribute table data.
;Room object data:
LAB0E:  .byte $00, $2F, $03, $08, $2F, $03, $0A, $25, $03, $90, $2F, $03, $99, $05, $01, $9B
LAB1E:  .byte $24, $03, $9F, $06, $03, $A7, $06, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LAB2D:  .byte $01, $0C, $27, $37, $07, $9A, $FF

;Room #$26
LAB34:  .byte $00                       ;Attribute table data.
;Room object data:
LAB35:  .byte $00, $0E, $00, $04, $0D, $00, $0C, $0E, $00, $20, $0C, $00, $2F, $0C, $00, $52
LAB45:  .byte $1F, $00, $60, $28, $03, $64, $1F, $00, $6F, $25, $03, $7F, $29, $03, $8E, $1F
LAB55:  .byte $00, $97, $1F, $00, $CB, $1F, $00, $D0, $00, $02, $D8, $00, $02, $FD
;Enemy/door data.
LAB63:  .byte $31, $86, $54, $41, $86, $87, $51, $0D, $E9, $01, $8B, $E5, $FF

;Room #$27
LAB70:  .byte $02                       ;Attribute table data.
;Room object data:
LAB71:  .byte $00, $20, $01, $04, $20, $01, $08, $20, $01, $0C, $20, $01, $10, $2C, $01, $50
LAB81:  .byte $04, $02, $80, $2C, $01, $81, $15, $03, $87, $27, $03, $8A, $27, $03, $8C, $27
LAB91:  .byte $03, $8E, $27, $03, $C0, $2C, $01, $D2, $00, $02, $DA, $00, $02, $FD
;Enemy/door data.
LAB9F:  .byte $02, $B1, $51, $0D, $E9, $FF

;Room #$28
LABA5:  .byte $02                       ;Attribute table data.
;Room object data:
LABA6:  .byte $00, $30, $01, $08, $30, $01, $10, $2C, $01, $17, $15, $03, $50, $03, $02, $80
LABB6:  .byte $20, $01, $86, $2B, $00, $8A, $2B, $00, $A0, $2C, $01, $BC, $2B, $00, $D2, $00
LABC6:  .byte $02, $DA, $00, $02, $E0, $2C, $01, $FD
;Enemy/door data.
LABCE:  .byte $02, $B1, $01, $06, $77, $11, $86, $7C, $21, $00, $2A, $FF

;Room #$29
LABDA:  .byte $00                       ;Attribute table data.
;Room object data:
LABDB:  .byte $00, $30, $01, $05, $15, $03, $08, $30, $01, $50, $2B, $00, $55, $2B, $00, $6B
LABEB:  .byte $2B, $00, $91, $2B, $00, $A8, $2B, $00, $B3, $2B, $00, $CC, $2B, $00, $D0, $00
LABFB:  .byte $02, $D8, $00, $02, $FD
;Enemy/door data.
LAC00:  .byte $41, $06, $43, $51, $86, $47, $31, $06, $84, $21, $86, $99, $FF

;Room #$2A
LAC0D:  .byte $02                       ;Attribute table data.
;Room object data:
LAC0E:  .byte $00, $30, $01, $08, $30, $01, $15, $15, $03, $1E, $2C, $01, $5F, $03, $02, $8C
LAC1E:  .byte $20, $01, $97, $2B, $00, $AE, $2C, $01, $C2, $2B, $00, $D0, $00, $02, $D6, $00
LAC2E:  .byte $02, $EE, $2C, $01, $FD
;Enemy/door data.
LAC33:  .byte $02, $A1, $21, $86, $88, $31, $86, $B3, $41, $0B, $E0, $51, $8B, $EB, $FF

;Room #$2B
LAC42:  .byte $00                       ;Attribute table data.
;Room object data:
LAC43:  .byte $00, $30, $01, $08, $30, $01, $2B, $18, $01, $55, $18, $01, $6B, $18, $01, $95
LAC53:  .byte $18, $01, $A0, $2C, $01, $AE, $2C, $01, $B8, $2C, $01, $D0, $00, $02, $D8, $00
LAC63:  .byte $02, $FD
;Enemy/door data.
LAC65:  .byte $31, $86, $45, $21, $06, $A9, $11, $86, $9E, $01, $0B, $E3, $FF

;Room #$2C
LAC72:  .byte $00                       ;Attribute table data.
;Room object data:
LAC73:  .byte $00, $30, $01, $08, $30, $01, $46, $2C, $01, $86, $2C, $01, $94, $20, $01, $AF
LAC83:  .byte $20, $01, $C0, $30, $01, $CB, $20, $01, $D0, $00, $02, $D5, $20, $01, $D9, $00
LAC93:  .byte $02, $FD
;Enemy/door data.
LAC95:  .byte $01, $0C, $59, $FF

;Room #$2D
LAC99:  .byte $03                       ;Attribute table data.
;Room object data:
LAC9A:  .byte $00, $07, $03, $0E, $07, $03, $19, $06, $03, $44, $06, $03, $50, $07, $03, $5E
LACAA:  .byte $07, $03, $93, $06, $03, $A0, $07, $03, $AE, $07, $03, $C7, $06, $03, $FF

;---------------------------------------[ Structure definitions ]------------------------------------

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LACB9:  .byte $08, $01, $01, $01, $01, $01, $01, $01, $01, $08, $00, $00, $00, $00, $00, $00
LACC9:  .byte $00, $00, $FF

;Structure #$01
LACCC:  .byte $08, $02, $02, $02, $02, $02, $02, $02, $02, $01, $0A, $01, $0A, $01, $0A, $08
LACDC:  .byte $02, $02, $02, $02, $02, $02, $02, $02, $FF

;Structure #$02
LACE5:  .byte $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02
LACF5:  .byte $04, $05, $02, $04, $05, $02, $04, $05, $FF

;Structure #$03
LACFE:  .byte $01, $06, $01, $06, $01, $06, $FF

;Structure #$04
LAD05:  .byte $01, $07, $01, $07, $01, $07, $FF

;Structure #$05
LAD0C:  .byte $02, $08, $09, $FF

;Structure #$06
LAD10:  .byte $04, $0B, $0B, $0B, $0B, $FF

;Structure #$07
LAD16:  .byte $02, $0B, $0F, $02, $0C, $0B, $02, $0F, $0C, $02, $0B, $0B, $02, $0C, $0F, $FF 

;Structure #$08
LAD26:  .byte $01, $0D, $01, $0E, $FF

;Structure #$09
LAD2B:  .byte $04, $10, $10, $10, $10, $FF

;Structure #$0A
LAD31:  .byte $04, $12, $13, $11, $13, $01, $13, $FF

;Structure #$0B
LAD39:  .byte $04, $0F, $0C, $0C, $0B, $04, $0B, $0F, $0B, $0C, $04, $0C, $0F, $0C, $0B, $04
LAD49:  .byte $0F, $0B, $0F, $0C, $FF

;Structure #$0C
LAD4E:  .byte $01, $1F, $01, $1F, $01, $1F, $01, $1F, $FF

;Structure #$0D
LAD57:  .byte $08, $20, $20, $20, $20, $20, $20, $20, $20, $FF

;Structure #$0E
LAD61:  .byte $04, $21, $21, $21, $21, $04, $21, $21, $21, $21, $FF

;Structure #$0F
LAD6C:  .byte $02, $15, $18, $03, $16, $19, $1E, $03, $17, $1A, $1B, $FF

;Structure #$10
LAD78:  .byte $01, $1E, $FF

;Structure #$11
LAD7B:  .byte $08, $22, $22, $22, $22, $22, $22, $22, $22, $FF

;Structure #$12
LAD85:  .byte $01, $23, $FF

;Structure #$13
LAD88:  .byte $04, $24, $26, $26, $26, $04, $25, $26, $26, $26, $13, $27, $26, $26, $04, $28
LAD98:  .byte $29, $26, $2A, $FF

;Structure #$14
LAD9C:  .byte $04, $26, $26, $26, $26, $04, $26, $26, $26, $26, $04, $26, $26, $26, $26, $04
LADAC:  .byte $26, $26, $26, $26, $FF

;Structure #$15
LADB1:  .byte $04, $0F, $0F, $0F, $0F, $FF

;Structure #$16
LADB7:  .byte $04, $2D, $3D, $2C, $3D, $FF

;Structure #$17
LADBD:  .byte $01, $2D, $01, $3D, $01, $2C, $01, $3D, $FF

;Structure #$18
LADC6:  .byte $01, $1D, $01, $1D, $01, $1D, $01, $1D, $FF

;Structure #$19
LADCF:  .byte $08, $2E, $2E, $2E, $2E, $2E, $2E, $2E, $2E, $08, $2F, $2F, $2F, $2F, $2F, $2F
LADDF:  .byte $2F, $2F, $FF

;Structure #$1A
LADE2:  .byte $04, $1D, $1D, $1D, $1D, $04, $1D, $1D, $1D, $1D, $04, $1D, $1D, $1D, $1D, $04
LADF2:  .byte $1D, $1D, $1D, $1D, $FF

;Structure #$1B
LADF7:  .byte $04, $31, $30, $31, $30, $04, $30, $30, $30, $30, $04, $31, $30, $31, $31, $04
LAE07:  .byte $30, $31, $30, $30, $FF

;Structure #$1C
LAE0C:  .byte $01, $30, $01, $31, $01, $30, $01, $30, $01, $31, $01, $31, $01, $30, $01, $30
LAE1C:  .byte $FF

;Structure #$1D
LAE1D:  .byte $04, $30, $31, $30, $30, $FF

;Structure #$1E
LAE23:  .byte $01, $1C, $FF

;Structure #$1F
LAE26:  .byte $01, $21, $01, $1F, $01, $1F, $01, $21, $FF

;Structure #$20
LAE2F:  .byte $04, $34, $34, $34, $34, $04, $34, $34, $34, $34, $FF

;Structure #$21
LAE3A:  .byte $04, $35, $35, $35, $35, $FF

;Structure #$22
LAE40:  .byte $04, $37, $37, $37, $37, $04, $37, $36, $37, $36, $04, $36, $37, $36, $37, $04
LAE50:  .byte $37, $37, $36, $37, $FF

;Structure #$23
LAE55:  .byte $02, $32, $33, $FF

;Structure #$24
LAE59:  .byte $04, $2B, $2B, $2B, $2B, $04, $2B, $2B, $2B, $2B, $FF

;Structure #$25
LAE64:  .byte $01, $2B, $01, $2B, $01, $2B, $01, $2B, $FF

;Structure #$26
LAE6D:  .byte $04, $2B, $2B, $2B, $2B, $04, $2B, $2B, $2B, $2B, $04, $2B, $2B, $2B, $2B, $04
LAE7D:  .byte $2B, $2B, $2B, $2B, $FF

;Structure #$27
LAE82:  .byte $01, $14, $FF

;Structure #$28
LAE85:  .byte $01, $2B, $01, $2B, $01, $2B, $01, $2B, $FF

;Structure #$29
LAE8E:  .byte $01, $39, $FF

;Structure #$2A
LAE91:  .byte $01, $38, $FF

;Structure #$2B
LAE94:  .byte $04, $3A, $3B, $3B, $3C, $FF

;Structure #$2C
LAE9A:  .byte $02, $34, $34, $02, $34, $34, $02, $34, $34, $02, $34, $34, $FF

;Structure #$2D
LAEA7:  .byte $08, $30, $31, $30, $31, $30, $30, $31, $30, $FF

;Structure #$2E
LAEB1:  .byte $04, $34, $34, $34, $34, $04, $34, $34, $34, $34, $04, $34, $34, $34, $34, $04
LAEC1:  .byte $34, $34, $34, $34, $FF

;Structure #$2F
LAEC6:  .byte $08, $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B, $08, $2B, $2B, $2B, $2B, $2B, $2B
LAED6:  .byte $2B, $2B, $FF

;Structure #$30
LAED9:  .byte $08, $34, $34, $34, $34, $34, $34, $34, $34, $08, $34, $34, $34, $34, $34, $34
LAEE9:  .byte $34, $34, $FF

;----------------------------------------[ Macro definitions ]---------------------------------------

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

MacroDefs:

LAEEC:  .byte $F1, $F1, $F1, $F1
LAEF0:  .byte $FF, $FF, $F0, $F0
LAEF4:  .byte $64, $64, $64, $64
LAEF8:  .byte $FF, $FF, $64, $64
LAEFC:  .byte $A4, $FF, $A4, $FF
LAF00:  .byte $FF, $A5, $FF, $A5
LAF04:  .byte $A0, $A0, $A0, $A0
LAF08:  .byte $A1, $A1, $A1, $A1
LAF0C:  .byte $FF, $FF, $59, $5A
LAF10:  .byte $FF, $FF, $5A, $5B
LAF14:  .byte $FF, $FF, $FF, $FF
LAF18:  .byte $10, $10, $10, $10
LAF1C:  .byte $23, $24, $25, $0B
LAF20:  .byte $1B, $1C, $1D, $1E
LAF24:  .byte $17, $18, $19, $1A
LAF28:  .byte $1F, $20, $21, $22
LAF2C:  .byte $60, $61, $62, $63
LAF30:  .byte $0E, $0F, $FF, $FF
LAF34:  .byte $0C, $0D, $0D, $0D
LAF38:  .byte $10, $0D, $FF, $10
LAF3C:  .byte $10, $FF, $FF, $FF
LAF40:  .byte $FF, $FF, $FF, $30
LAF44:  .byte $FF, $33, $FF, $36
LAF48:  .byte $FF, $39, $FF, $3D
LAF4C:  .byte $FF, $FF, $31, $32
LAF50:  .byte $34, $35, $37, $38
LAF54:  .byte $3A, $3B, $3E, $3F
LAF58:  .byte $3C, $41, $40, $42
LAF5C:  .byte $84, $85, $86, $87
LAF60:  .byte $80, $81, $82, $83
LAF64:  .byte $88, $89, $8A, $8B
LAF68:  .byte $45, $46, $45, $46
LAF6C:  .byte $47, $48, $48, $47
LAF70:  .byte $5C, $5D, $5E, $5F
LAF74:  .byte $B8, $B8, $B9, $B9
LAF78:  .byte $74, $75, $75, $74
LAF7C:  .byte $C1, $13, $13, $13
LAF80:  .byte $36, $BE, $BC, $BD
LAF84:  .byte $BF, $14, $15, $14
LAF88:  .byte $C0, $14, $C0, $16
LAF8C:  .byte $FF, $C1, $FF, $FF
LAF90:  .byte $C2, $14, $FF, $FF
LAF94:  .byte $30, $13, $BC, $BD
LAF98:  .byte $13, $14, $15, $16
LAF9C:  .byte $D7, $D7, $D7, $D7
LAFA0:  .byte $76, $76, $76, $76
LAFA4:  .byte $FF, $FF, $BA, $BA
LAFA8:  .byte $BB, $BB, $BB, $BB
LAFAC:  .byte $00, $01, $02, $03
LAFB0:  .byte $04, $05, $06, $07
LAFB4:  .byte $FF, $FF, $08, $09
LAFB8:  .byte $FF, $FF, $09, $0A
LAFBC:  .byte $55, $56, $57, $58
LAFC0:  .byte $90, $91, $92, $93
LAFC4:  .byte $4B, $4C, $4D, $50
LAFC8:  .byte $51, $52, $53, $54
LAFCC:  .byte $70, $71, $72, $73
LAFD0:  .byte $8C, $8D, $8E, $8F
LAFD4:  .byte $11, $12, $FF, $11
LAFD8:  .byte $11, $12, $12, $11
LAFDC:  .byte $11, $12, $12, $FF
LAFE0:  .byte $C3, $C4, $C5, $C6

LAFE4:  .byte $30, $00, $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93
LAFF4:  .byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0

.advance $B000, $00
.include "../music/NorfairMusic.asm"

.advance $B200, $00
.include "../SoundEngine.asm"

.advance $C000, $00