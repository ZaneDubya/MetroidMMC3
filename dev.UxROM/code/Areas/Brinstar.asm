; METROID source code
; (C) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, 
;      GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Can be reassembled using Ophis.
;Brinstar (memory page 1)

.org $8000

.require "../Defines.asm"
.require "../GameEngineDeclarations.asm"

.include "AreaCommonI.asm"

;------------------------------------------[ Graphics data ]-----------------------------------------

;Partial font, "THE END".
L8D60:  .byte $00, $00, $00, $00, $00, $18, $18, $08, $00, $00, $00, $00, $00, $00, $00, $00
L8D70:  .byte $18, $38, $18, $18, $18, $18, $7E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D80:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $78, $70, $F0, $F0, $78, $79, $1F, $00
L8D90:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $03, $87, $46, $4E, $4C, $8C, $08, $00
L8DA0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $39, $99, $3B, $33, $73, $79, $30, $00
L8DB0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FC, $DC, $98, $B8, $B8, $FD, $66, $00
L8DC0:  .byte $3C, $60, $C0, $FC, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DD0:  .byte $00, $00, $00, $00, $00, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DE0:  .byte $7C, $C6, $C6, $7C, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DF0:  .byte $7C, $C6, $C6, $7E, $06, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E00:  .byte $38, $6C, $C6, $C6, $FE, $C6, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E10:  .byte $FC, $C6, $C6, $FC, $C6, $C6, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E20:  .byte $3C, $66, $C0, $C0, $C0, $66, $3C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E30:  .byte $F8, $CC, $C6, $C6, $C6, $CC, $F8, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E40:  .byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E50:  .byte $FE, $C0, $C0, $FC, $C0, $C0, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E60:  .byte $3E, $60, $C0, $CE, $C6, $66, $3E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E70:  .byte $C6, $C6, $C6, $FE, $C6, $C6, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E80:  .byte $7E, $18, $18, $18, $18, $18, $7E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E90:  .byte $1E, $06, $06, $06, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EA0:  .byte $C6, $CC, $D8, $F0, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EB0:  .byte $60, $60, $60, $60, $60, $60, $7E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EC0:  .byte $C6, $EE, $FE, $FE, $D6, $C6, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8ED0:  .byte $C6, $E6, $F6, $FE, $DE, $CE, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EE0:  .byte $7C, $C6, $C6, $C6, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EF0:  .byte $FC, $C6, $C6, $C6, $FC, $C0, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F00:  .byte $7C, $C6, $C6, $C6, $DE, $CC, $7A, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F10:  .byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F20:  .byte $78, $CC, $C0, $7C, $06, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F30:  .byte $7E, $18, $18, $18, $18, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F40:  .byte $C6, $C6, $C6, $C6, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F50:  .byte $C6, $C6, $C6, $EE, $7C, $38, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F60:  .byte $C6, $C6, $D6, $FE, $FE, $EE, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F70:  .byte $C6, $EE, $7C, $38, $7C, $EE, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F80:  .byte $66, $66, $66, $3C, $18, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F90:  .byte $FE, $0E, $1C, $38, $70, $E0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FA0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $01, $07, $0F, $0C, $08, $08, $04, $03
L8FB0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $C1, $FF, $FF, $3E, $00, $08, $88, $19
L8FC0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $20, $60, $60, $E0, $C0, $C8
L8FD0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $38
L8FE0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $30, $48, $40, $61, $3F, $3F, $1F, $00
L8FF0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $11, $33, $73, $E7, $E6, $C6, $04, $00
L9000:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $9C, $CC, $1C, $19, $3A, $3C, $18, $00
L9010:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $7C, $74, $E4, $F8, $E0, $72, $3C, $00
L9020:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $03, $06, $0C, $0C, $06, $02, $1E, $3C
L9030:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $40, $20, $20, $40, $03, $01, $03
L9040:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $80, $90
L9050:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $03, $03, $07, $06, $EE
L9060:  .byte $32, $FF, $F7, $FF, $7F, $FF, $DB, $FF, $73, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9070:  .byte $B4, $FF, $FF, $FF, $FE, $7B, $FF, $FD, $B6, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9080:  .byte $B5, $FF, $7F, $9D, $F6, $7F, $DD, $77, $FF, $FF, $FF, $FF, $EF, $FF, $BB, $FE
L9090:  .byte $D7, $FF, $79, $DE, $F5, $3F, $ED, $BF, $FF, $FF, $FF, $FF, $BF, $FF, $FB, $FF
L90A0:  .byte $89, $F7, $5F, $F3, $E7, $FD, $70, $CF, $FF, $BF, $EC, $FF, $9F, $FE, $AF, $F9
L90B0:  .byte $9F, $F9, $3D, $F7, $3F, $99, $FD, $CF, $F6, $7F, $FF, $FD, $CF, $FF, $FF, $FB
L90C0:  .byte $B9, $59, $CC, $7F, $DF, $9F, $BF, $1E, $7F, $FF, $B7, $F3, $FD, $6F, $FF, $E7
L90D0:  .byte $7F, $F9, $F3, $FF, $FF, $FF, $FF, $BB, $9F, $FF, $CF, $9F, $FD, $FF, $27, $DF
L90E0:  .byte $63, $EF, $EE, $1F, $B9, $1C, $F7, $FF, $9D, $38, $FF, $FF, $C7, $E3, $FF, $BF
L90F0:  .byte $FF, $9D, $7E, $FF, $B3, $C7, $FF, $A1, $3C, $7E, $FF, $E7, $CF, $FF, $FB, $7F
L9100:  .byte $C8, $ED, $BE, $DC, $9E, $F8, $36, $CC, $3F, $1E, $7F, $FF, $EF, $07, $CF, $FF
L9110:  .byte $C7, $BF, $3A, $7F, $BD, $A3, $7F, $FC, $3C, $7C, $FD, $E7, $CF, $FE, $8C, $0F
L9120:  .byte $00, $00, $18, $18, $3C, $7E, $5E, $FF, $10, $10, $18, $38, $7C, $7E, $FE, $FF
L9130:  .byte $00, $10, $10, $10, $10, $30, $30, $10, $10, $10, $10, $10, $30, $30, $30, $30
L9140:  .byte $20, $30, $30, $20, $60, $30, $70, $F8, $20, $30, $30, $60, $60, $70, $F0, $F8
L9150:  .byte $10, $10, $10, $10, $10, $10, $00, $10, $00, $00, $00, $00, $00, $00, $00, $00

;Brinstar enemy tile patterns.
L9160:  .byte $03, $0F, $05, $32, $D1, $48, $12, $24, $01, $02, $02, $11, $48, $20, $00, $00
L9170:  .byte $E0, $F0, $EC, $DE, $92, $8D, $A0, $3C, $C0, $00, $0C, $02, $01, $0C, $02, $00
L9180:  .byte $00, $00, $F8, $3E, $1F, $0F, $0F, $0E, $00, $00, $00, $08, $04, $00, $00, $00
L9190:  .byte $18, $30, $6C, $7C, $5C, $78, $70, $21, $00, $00, $0C, $1C, $1C, $38, $30, $3C
L91A0:  .byte $18, $30, $60, $60, $40, $40, $40, $01, $00, $00, $00, $00, $00, $00, $00, $3C
L91B0:  .byte $00, $01, $00, $00, $03, $04, $48, $3C, $00, $01, $00, $03, $0C, $08, $10, $03
L91C0:  .byte $48, $2F, $B3, $4D, $32, $CC, $84, $6F, $48, $28, $AF, $3D, $78, $CD, $B6, $6F
L91D0:  .byte $00, $50, $00, $C8, $74, $34, $90, $38, $00, $00, $B0, $E8, $74, $BC, $18, $18
L91E0:  .byte $3C, $7F, $FF, $FF, $FF, $7E, $7B, $3D, $3C, $7F, $FF, $FC, $D1, $50, $69, $0E
L91F0:  .byte $00, $00, $C0, $E0, $B0, $08, $07, $87, $00, $00, $C0, $60, $B0, $68, $73, $B2
L9200:  .byte $01, $00, $1C, $0F, $07, $03, $0F, $3F, $01, $00, $10, $08, $04, $00, $08, $20
L9210:  .byte $80, $C0, $F8, $C8, $88, $32, $51, $68, $0C, $10, $A0, $06, $01, $32, $11, $00
L9220:  .byte $00, $01, $21, $33, $3B, $1F, $9F, $FF, $00, $01, $20, $12, $08, $00, $80, $20
L9230:  .byte $00, $00, $08, $98, $B8, $F0, $F2, $FE, $00, $00, $08, $90, $20, $00, $02, $04
L9240:  .byte $81, $A5, $E7, $00, $00, $24, $18, $24, $81, $A5, $E7, $42, $66, $C3, $66, $18
L9250:  .byte $00, $24, $1B, $1F, $3B, $44, $5B, $3F, $BD, $9B, $E4, $C0, $C4, $98, $83, $C7
L9260:  .byte $00, $20, $60, $C3, $CC, $60, $20, $00, $0A, $0F, $0F, $1C, $13, $0F, $0F, $0A
L9270:  .byte $00, $00, $00, $00, $E0, $00, $00, $00, $40, $E8, $FA, $FF, $1F, $FA, $E8, $40
L9280:  .byte $1E, $1C, $18, $3A, $36, $60, $00, $00, $00, $00, $00, $02, $06, $00, $03, $00
L9290:  .byte $43, $C6, $FE, $F8, $F6, $A9, $21, $20, $38, $00, $00, $00, $66, $AD, $F9, $20
L92A0:  .byte $73, $DE, $EF, $F8, $F6, $A9, $21, $20, $38, $1E, $0F, $00, $66, $AD, $F9, $20
L92B0:  .byte $03, $02, $30, $7E, $70, $D0, $6C, $1D, $04, $30, $48, $00, $80, $11, $30, $21
L92C0:  .byte $61, $30, $1E, $81, $28, $FF, $FF, $F1, $61, $32, $1E, $81, $F8, $FF, $FF, $F9
L92D0:  .byte $B8, $D0, $6C, $36, $9E, $0C, $C0, $E8, $FC, $FC, $7E, $36, $BE, $0C, $E0, $F8
L92E0:  .byte $1F, $0F, $07, $03, $01, $0E, $1F, $3F, $07, $03, $03, $01, $00, $06, $17, $13
L92F0:  .byte $C3, $66, $9E, $DE, $EF, $F7, $73, $B9, $DA, $66, $DE, $C6, $E3, $61, $25, $B9
L9300:  .byte $0F, $03, $07, $0F, $1D, $00, $01, $03, $08, $00, $04, $08, $10, $00, $01, $02
L9310:  .byte $60, $51, $32, $88, $C8, $F8, $C0, $00, $0C, $11, $32, $00, $04, $02, $12, $20
L9320:  .byte $78, $33, $65, $26, $19, $00, $04, $02, $00, $00, $04, $46, $80, $90, $14, $0A
L9330:  .byte $1C, $C8, $A4, $64, $18, $00, $20, $40, $00, $00, $25, $62, $80, $88, $26, $40
L9340:  .byte $00, $02, $0D, $17, $2D, $62, $6D, $2E, $83, $C5, $F2, $E0, $C2, $81, $8C, $CE
L9350:  .byte $00, $40, $B0, $E8, $B4, $46, $B6, $74, $C1, $A3, $4F, $07, $43, $81, $31, $73
L9360:  .byte $00, $00, $00, $00, $00, $20, $73, $DF, $00, $00, $0A, $0F, $1F, $14, $11, $18
L9370:  .byte $00, $00, $00, $00, $00, $00, $12, $C0, $00, $00, $40, $E8, $FA, $FF, $70, $00
L9380:  .byte $24, $3C, $5A, $DB, $66, $99, $5A, $24, $00, $00, $42, $C3, $66, $00, $00, $42
L9390:  .byte $00, $00, $44, $EE, $B2, $82, $84, $40, $04, $38, $54, $EE, $B2, $80, $00, $00
L93A0:  .byte $00, $00, $0C, $04, $62, $12, $1F, $01, $00, $B0, $50, $78, $9C, $6C, $20, $00
L93B0:  .byte $38, $72, $C5, $73, $72, $6F, $22, $00, $40, $82, $05, $23, $42, $07, $1E, $00
L93C0:  .byte $C3, $E0, $7C, $8F, $C7, $F3, $72, $00, $E3, $F0, $7E, $8F, $C7, $F2, $71, $01
L93D0:  .byte $F0, $E8, $3C, $9C, $80, $18, $1C, $00, $F0, $E8, $3C, $9E, $42, $5A, $5C, $00
L93E0:  .byte $3B, $7D, $7B, $7D, $7E, $FF, $FF, $00, $31, $3D, $3B, $1C, $6E, $37, $79, $00
L93F0:  .byte $F9, $B9, $50, $E0, $7C, $8C, $E0, $00, $F9, $B1, $40, $60, $3C, $8E, $C2, $02
L9400:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9410:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9420:  .byte $60, $71, $30, $18, $0C, $00, $00, $00, $62, $72, $37, $93, $81, $7E, $34, $06
L9430:  .byte $00, $01, $00, $08, $1C, $30, $70, $60, $02, $02, $07, $83, $91, $7E, $74, $66
L9440:  .byte $26, $31, $10, $1C, $18, $0C, $00, $00, $C6, $C0, $60, $60, $20, $30, $18, $08
L9450:  .byte $5E, $2C, $20, $3C, $24, $18, $00, $00, $87, $C3, $42, $42, $42, $66, $24, $24
L9460:  .byte $00, $00, $00, $00, $0B, $27, $73, $DF, $0A, $0F, $1F, $34, $0B, $07, $11, $18
L9470:  .byte $00, $00, $00, $00, $00, $8C, $F2, $E0, $40, $E8, $FA, $FF, $60, $80, $30, $00
L9480:  .byte $00, $00, $1C, $3E, $3E, $3E, $1C, $00, $00, $1C, $26, $69, $55, $53, $32, $1C
L9490:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94A0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94B0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94C0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94D0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94E0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94F0:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9500:  .byte $1D, $1D, $1D, $1D, $1D, $1D, $1D, $1D, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
L9510:  .byte $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0
L9520:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9530:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9540:  .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9550:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
L9560:  .word Palette00                 ;($A271)
L9562:  .word Palette01                 ;($A295)
L9564:  .word Palette02                 ;($A2A1)
L9566:  .word Palette03                 ;($A29B)
L9568:  .word Palette04                 ;($A2A7)
L956A:  .word Palette05                 ;($A2AD)
L956C:  .word Palette06                 ;($A2D0)
L956E:  .word Palette06                 ;($A2D0)
L9570:  .word Palette06                 ;($A2D0)
L9572:  .word Palette06                 ;($A2D0)
L9574:  .word Palette06                 ;($A2D0)
L9576:  .word Palette06                 ;($A2D0)
L9578:  .word Palette06                 ;($A2D0)
L957A:  .word Palette06                 ;($A2D0)
L957C:  .word Palette06                 ;($A2D0)
L957E:  .word Palette06                 ;($A2D0)
L9580:  .word Palette06                 ;($A2D0)
L9582:  .word Palette06                 ;($A2D0)
L9584:  .word Palette06                 ;($A2D0)
L9586:  .word Palette06                 ;($A2D0)
L9588:  .word Palette07                 ;($A2D7)
L958A:  .word Palette08                 ;($A2DE)
L958C:  .word Palette09                 ;($A2E5)
L958E:  .word Palette0A                 ;($A2EC)
L9590:  .word Palette0B                 ;($A2F4)
L9592:  .word Palette0C                 ;($A2FC)
L9594:  .word Palette0D                 ;($A304)
L9596:  .word Palette0E                 ;($A30C)

AreaPointers:
L9598:  .word SpecItmsTbl               ;($A3D6)Beginning of special items table.
L959A:  .word RmPtrTbl                  ;($A314)Beginning of room pointer table.        
L959C:  .word StrctPtrTbl               ;($A372)Beginning of structure pointer table.
L959E:  .word MacroDefs                 ;($AEF0)Beginning of macro definitions.
L95A0:  .word EnemyFramePtrTbl1         ;($9DE0)Pointer table into enemy animation data. Two-->
L95A2:  .word EnemyFramePtrTbl2         ;($9EE0)tables needed to accommodate all entries.
L95A4:  .word EnemyPlacePtrTbl          ;($9F0E)Pointers to enemy frame placement data.
L95A6:  .word EnemyAnimIndexTbl         ;($9D6A)index to values in addr tables for enemy animations.

L95A8:  .byte $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60 
L95B8:  .byte $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA

AreaRoutine:
L95C3:  JMP $9D35                       ;Area specific routine.

TwosCompliment_:
L95C6:  EOR #$FF                        ;
L95C8:  CLC                                 ;The following routine returns the twos-->
L95C9:  ADC #$01                        ;compliment of the value stored in A.
L95CB:  RTS                                 ;

L95CC:  .byte $FF                       ;Not used.
                                
L95CD:  .byte $01                       ;Brinstar music init flag.

L95CE:  .byte $80                       ;Base damage caused by area enemies to lower health byte.
L95CF:  .byte $00                       ;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:  .byte $2B, $2C, $28, $0B, $1C, $0A, $1A

L95D7:  .byte $03                       ;Samus start x coord on world map.
L95D8:  .byte $0E                       ;Samus start y coord on world map.
L95D9:  .byte $B0                       ;Samus start verticle screen position.

L95DA:  .byte $01, $00, $03, $43, $00, $00, $00, $00, $00, $00, $69 

L95E5:  LDA EnDataIndex, X
L95E8:  JSR $8024

L95EB:  .word $99B8
L95ED:  .word $99D3
L95EF:  .word $99E5
L95F1:  .word $99D8
L95F3:  .word $99FA
L95F5:  .word $9A4C
L95F7:  .word $9AF5
L95F9:  .word $9B32
L95FB:  .word $9BA2
L95FD:  .word $9BD2
L95FF:  .word $9C1A
L9601:  .word $0000
L9603:  .word $0000
L9605:  .word $0000
L9607:  .word $0000
L9609:  .word $0000

L960B:  .byte $27, $27, $29, $29, $2D, $2B, $31, $2F, $33, $33, $41, $41, $4B, $4B, $55, $53

L961B:  .byte $72, $74, $00, $00, $00, $00, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

EnemyHitPointTbl:
L962B:  .byte $08, $08, $04, $FF, $02, $02, $04, $01, $20, $FF, $FF, $04, $01, $00, $00, $00

L963B:  .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $59, $57 

L964B:  .byte $6C, $6F, $5B, $5D, $62, $67, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

L965B:  .byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $50, $4D

L966B:  .byte $6C, $6F, $5B, $5D, $5F, $64, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

L967B:  .byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00 

L968B:  .byte $01, $01, $01, $00, $86, $04, $89, $80, $81, $00, $00, $00, $82, $00, $00, $00 

L969B:  .byte $01, $01, $01, $01, $01, $01, $01, $01, $20, $01, $01, $01, $40, $00, $00, $00 

L96AB:  .byte $00, $00, $06, $00, $83, $00, $88, $00, $00, $00, $00, $00, $00, $00, $00, $00 

EnemyInitDelayTbl:
L96BB:  .byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

L96CB:  .byte $00, $03, $06, $08, $0A, $10, $0C, $0E, $14, $17, $19, $10, $12, $00, $00, $00

L96DB:  .word $97EF, $97F2, $97F5, $97F5, $97F5, $97F5, $97F5, $97F5
L96EB:  .word $97F5, $97F5, $97F5, $9840, $988B, $988E, $9891, $98A5
L96FB:  .word $98B9, $98B9, $98B9, $98B9, $98B9, $98B9, $98B9, $98B9
L970B:  .word $98B9, $98C0, $98C7, $98CE, $98D5, $98D8, $98DB, $98F2
L971B:  .word $9909, $9920, $9937, $994E

L9723:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $7F, $40, $30, $C0, $D0, $00, $00, $7F
L9733:  .byte $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9743:  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:  .byte $F6, $FC, $FE, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00
L9763:  .byte $00, $00, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02
L9773:  .byte $00, $00, $00, $00, $00, $00, $00, $00

L977B:  .byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00 

L978B:  .byte $00, $00, $64, $67, $69, $69, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:  .byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

L97A7:  .word $9965, $9974, $9983, $9992, $9D36, $9D3B, $9D40, $9D45
L97B7:  .word $9D4A, $9D4F, $9D54, $9D59, $9D5E, $9D63, $9D6A, $9D6A
L97C7:  .word $9D6A, $9D6A, $9D6A, $9D6A, $9D6A

L97D1:  .byte $01, $01, $02, $01, $03, $04, $00, $05, $00, $06, $00, $07, $00, $08, $00, $09
L97E1:  .byte $00, $00, $00, $0B, $01, $0C, $0D, $00, $0E, $03, $0F, $10, $11, $0F

L97EF:  .byte $20, $22, $FE

L97F2:  .byte $20, $2A, $FE

L97F5:  .byte $02, $F2, $04, $E2, $04, $D2, $05, $B2, $03, $92, $04, $02, $05, $12, $03, $32
L9805:  .byte $05, $52, $04, $62, $02, $72, $02, $72, $04, $62, $04, $52, $05, $32, $03, $12
L9815:  .byte $04, $02, $05, $92, $03, $B2, $05, $D2, $04, $E2, $02, $F2, $FD, $03, $D2, $06
L9825:  .byte $B2, $08, $92, $05, $02, $07, $12, $05, $32, $04, $52, $03, $52, $06, $32, $08
L9835:  .byte $12, $05, $02, $07, $92, $05, $B2, $04, $D2, $FD, $FF

L9840:  .byte $02, $FA, $04, $EA, $04, $DA, $05, $BA, $03, $9A, $04, $0A, $05, $1A, $03, $3A
L9850:  .byte $05, $5A, $04, $6A, $02, $7A, $02, $7A, $04, $6A, $04, $5A, $05, $3A, $03, $1A
L9860:  .byte $04, $0A, $05, $9A, $03, $BA, $05, $DA, $04, $EA, $02, $FA, $FD, $03, $DA, $06
L9870:  .byte $BA, $08, $9A, $05, $0A, $07, $1A, $05, $3A, $04, $5A, $03, $5A, $06, $3A, $08
L9880:  .byte $1A, $05, $0A, $07, $9A, $05, $BA, $04, $DA, $FD, $FF

L988B:  .byte $01, $01, $FF

L988E:  .byte $01, $09, $FF

L9891:  .byte $04, $22, $01, $42, $01, $22, $01, $42, $01, $62, $01, $42, $04, $62, $FC, $01
L98A1:  .byte $00, $64, $00, $FB

L98A5:  .byte $04, $2A, $01, $4A, $01, $2A, $01, $4A, $01, $6A, $01, $4A, $04, $6A, $FC, $01
L98B5:  .byte $00, $64, $00, $FB

L98B9:  .byte $14, $11, $0A, $00, $14, $19, $FE

L98C0:  .byte $14, $19, $0A, $00, $14, $11, $FE

L98C7:  .byte $1E, $11, $0A, $00, $1E, $19, $FE 

L98CE:  .byte $1E, $19, $0A, $00, $1E, $11, $FE

L98D5:  .byte $50, $04, $FF

L98D8:  .byte $50, $0C, $FF

L98DB:  .byte $02, $F3, $04, $E3, $04, $D3, $05, $B3, $03, $93, $04, $03, $05, $13, $03, $33
L98EB:  .byte $05, $53, $04, $63, $50, $73, $FF

L98F2:  .byte $02, $FB, $04, $EB, $04, $DB, $05, $BB, $03, $9B, $04, $0B, $05, $1B, $03, $3B
L9902:  .byte $05, $5B, $04, $6B, $50, $7B, $FF

L9909:  .byte $02, $F4, $04, $E4, $04, $D4, $05, $B4, $03, $94, $04, $04, $05, $14, $03, $34
L9919:  .byte $05, $54, $04, $64, $50, $74, $FF

L9920:  .byte $02, $FC, $04, $EC, $04, $DC, $05, $BC, $03, $9C, $04, $0C, $05, $1C, $03, $3C
L9930:  .byte $05, $5C, $04, $6C, $50, $7C, $FF

L9937:  .byte $02, $F2, $04, $E2, $04, $D2, $05, $B2, $03, $92, $04, $02, $05, $12, $03, $32
L9947:  .byte $05, $52, $04, $62, $50, $72, $FF

L994E:  .byte $02, $FA, $04, $EA, $04, $DA, $05, $BA, $03, $9A, $04, $0A, $05, $1A, $03, $3A
L995E:  .byte $05, $5A, $04, $6A, $50, $7A, $FF

L9965:  .byte $04, $B3, $05, $A3, $06, $93, $07, $03, $06, $13, $05, $23, $50, $33, $FF

L9974:  .byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L9983:  .byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L9992:  .byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

L99A1:  LDA $81
L99A3:  CMP #$01
L99A5:  BEQ $99B0
L99A7:  CMP #$03
L99A9:  BEQ $99B5
L99AB:  LDA $00
L99AD:  JMP $8000
L99B0:  LDA $01
L99B2:  JMP $8003
L99B5:  JMP $8006

L99B8:  LDA #$09
L99BA:  STA $85
L99BC:  STA $86
L99BE:  LDA EnStatus,X
L99C1:  CMP #$03
L99C3:  BEQ $99C8
L99C5:  JSR $801B
L99C8:  LDA #$06
L99CA:  STA $00
L99CC:  LDA #$08
L99CE:  STA $01
L99D0:  JMP $99A1

L99D3:  LDA #$0F
L99D5:  JMP $99BA
L99D8:  LDA EnStatus,X
L99DB:  CMP #$03
L99DD:  BEQ $99E2
L99DF:  JSR $801E
L99E2:  JMP $99C8
L99E5:  LDA #$21
L99E7:  STA $85
L99E9:  LDA #$1E
L99EB:  STA $86
L99ED:  LDA EnStatus,X
L99F0:  CMP #$03
L99F2:  BEQ $99F7
L99F4:  JSR $801B
L99F7:  JMP $99C8
L99FA:  LDA $81
L99FC:  CMP #$01
L99FE:  BEQ $9A44
L9A00:  CMP #$03
L9A02:  BEQ $9A49
L9A04:  LDA EnCounter,X
L9A07:  CMP #$0F
L9A09:  BCC $9A3F
L9A0B:  CMP #$11
L9A0D:  BCS $9A16
L9A0F:  LDA #$3A
L9A11:  STA $6B01,X
L9A14:  BNE $9A3F
L9A16:  DEC $6B01,X
L9A19:  BNE $9A3F
L9A1B:  LDA #$00
L9A1D:  STA EnStatus,X
L9A20:  LDY #$0C
L9A22:  LDA #$0A
L9A24:  STA $00A0,Y
L9A27:  LDA EnYRoomPos,X
L9A2A:  STA $00A1,Y
L9A2D:  LDA EnXRoomPos,X
L9A30:  STA $00A2,Y
L9A33:  LDA EnNameTable,X
L9A36:  STA $00A3,Y
L9A39:  DEY 
L9A3A:  DEY 
L9A3B:  DEY 
L9A3C:  DEY 
L9A3D:  BPL $9A22
L9A3F:  LDA #$02
L9A41:  JMP $8000
L9A44:  LDA #$08
L9A46:  JMP $8003
L9A49:  JMP $8006

L9A4C:  JSR $8009
L9A4F:  AND #$03
L9A51:  BEQ $9A87
L9A53:  LDA $81
L9A55:  CMP #$01
L9A57:  BEQ $9A44
L9A59:  CMP #$03
L9A5B:  BEQ $9A49
L9A5D:  LDA EnStatus,X
L9A60:  CMP #$03
L9A62:  BEQ $9A87
L9A64:  LDA $040A,X
L9A67:  AND #$03
L9A69:  CMP #$01
L9A6B:  BNE $9A7E
L9A6D:  LDY EnYRoomPos,X
L9A70:  CPY #$E4
L9A72:  BNE $9A7E
L9A74:  JSR $9ABD
L9A77:  LDA #$03
L9A79:  STA $040A,X
L9A7C:  BNE $9A84
L9A7E:  JSR $9AE2
L9A81:  JSR $9AA8
L9A84:  JSR $9AC6
L9A87:  LDA #$03
L9A89:  JSR $800C
L9A8C:  JMP $8006
L9A8F:  LDA $0405,X
L9A92:  LSR 
L9A93:  LDA $040A,X
L9A96:  AND #$03
L9A98:  ROL 
L9A99:  TAY 
L9A9A:  LDA $9AA0,Y
L9A9D:  JMP $800F

L9AA0:  .byte $35, $35, $3E, $38, $3B, $3B, $38, $3E 

L9AA8:  LDX PageIndex
L9AAA:  BCS $9AC5
L9AAC:  LDA $00
L9AAE:  BNE $9ABD
L9AB0:  LDY $040A,X
L9AB3:  DEY 
L9AB4:  TYA 
L9AB5:  AND #$03
L9AB7:  STA $040A,X
L9ABA:  JMP $9A8F
L9ABD:  LDA $0405,X
L9AC0:  EOR #$01
L9AC2:  STA $0405,X
L9AC5:  RTS

L9AC6:  JSR $9ADA
L9AC9:  JSR $9AE2
L9ACC:  LDX PageIndex
L9ACE:  BCC $9AD9
L9AD0:  JSR $9ADA
L9AD3:  STA $040A,X
L9AD6:  JSR $9A8F
L9AD9:  RTS

L9ADA:  LDY $040A,X
L9ADD:  INY 
L9ADE:  TYA 
L9ADF:  AND #$03
L9AE1:  RTS

L9AE2:  LDY $0405,X
L9AE5:  STY $00
L9AE7:  LSR $00
L9AE9:  ROL 
L9AEA:  ASL 
L9AEB:  TAY 
L9AEC:  LDA $8049,Y
L9AEF:  PHA 
L9AF0:  LDA $8048,Y
L9AF3:  PHA 
L9AF4:  RTS

L9AF5:  LDA $81
L9AF7:  CMP #$01
L9AF9:  BEQ $9B2D
L9AFB:  CMP #$03
L9AFD:  BEQ $9B2A
L9AFF:  LDA #$80
L9B01:  STA $6AFE,X
L9B04:  LDA $0402,X
L9B07:  BMI $9B25
L9B09:  LDA $0405,X
L9B0C:  AND #$10
L9B0E:  BEQ $9B25
L9B10:  LDA EnYRoomPos,X
L9B13:  SEC 
L9B14:  SBC $030D
L9B17:  BPL $9B1C
L9B19:  JSR $95C6
L9B1C:  CMP #$10
L9B1E:  BCS $9B25
L9B20:  LDA #$00
L9B22:  STA $6AFE,X
L9B25:  LDA #$03
L9B27:  JMP $8000
L9B2A:  JMP $8006
L9B2D:  LDA #$08
L9B2F:  JMP $8003
L9B32:  LDA EnStatus,X
L9B35:  CMP #$02
L9B37:  BNE $9B71
L9B39:  LDA $0403,X
L9B3C:  BNE $9B71
L9B3E:  LDA $6AFE,X
L9B41:  BNE $9B55
L9B43:  LDA $030D
L9B46:  SEC 
L9B47:  SBC EnYRoomPos,X
L9B4A:  CMP #$40
L9B4C:  BCS $9B71
L9B4E:  LDA #$7F
L9B50:  STA $6AFE,X
L9B53:  BNE $9B71
L9B55:  LDA $0402,X
L9B58:  BMI $9B71
L9B5A:  LDA #$00
L9B5C:  STA $0402,X
L9B5F:  STA EnCounter,X
L9B62:  STA $6AFE,X
L9B65:  LDA $0405,X
L9B68:  AND #$01
L9B6A:  TAY 
L9B6B:  LDA $9BA0,Y
L9B6E:  STA $0403,X
L9B71:  LDA $0405,X
L9B74:  ASL 
L9B75:  BMI $9B95
L9B77:  LDA EnStatus,X
L9B7A:  CMP #$02
L9B7C:  BNE $9B95
L9B7E:  JSR $8036
L9B81:  PHA 
L9B82:  JSR $8039
L9B85:  STA $05
L9B87:  PLA 
L9B88:  STA $04
L9B8A:  JSR $9CA8
L9B8D:  JSR $8027
L9B90:  BCC $9B9A
L9B92:  JSR $9C96
L9B95:  LDA #$03
L9B97:  JMP $8003
L9B9A:  LDA #$00
L9B9C:  STA EnStatus,X
L9B9F:  RTS

L9BA0:  .byte $04, $FC

L9BA2:  LDA EnStatus,X
L9BA5:  CMP #$03
L9BA7:  BCC $9BC2
L9BA9:  BEQ $9BAF
L9BAB:  CMP #$05
L9BAD:  BNE $9BCB
L9BAF:  LDA #$00
L9BB1:  STA $6B04
L9BB4:  STA $6B14
L9BB7:  STA $6B24
L9BBA:  STA $6B34
L9BBD:  STA $6B44
L9BC0:  BEQ $9BCB
L9BC2:  JSR $9C1D
L9BC5:  JSR $9CCC
L9BC8:  JSR $9D05
L9BCB:  LDA #$0A
L9BCD:  STA $00
L9BCF:  JMP $99CC
L9BD2:  LDA $0405,X
L9BD5:  AND #$02
L9BD7:  BEQ $9BE0
L9BD9:  LDA EnStatus,X
L9BDC:  CMP #$03
L9BDE:  BNE $9BE7
L9BE0:  LDA #$00
L9BE2:  STA EnStatus,X
L9BE5:  BEQ $9C12
L9BE7:  LDA $0405,X
L9BEA:  ASL 
L9BEB:  BMI $9C12
L9BED:  LDA EnStatus,X
L9BF0:  CMP #$02
L9BF2:  BNE $9C12
L9BF4:  JSR $802D
L9BF7:  LDX PageIndex
L9BF9:  LDA $00
L9BFB:  STA $0402,X
L9BFE:  JSR $8030
L9C01:  LDX PageIndex
L9C03:  LDA $00
L9C05:  STA $0403,X
L9C08:  JSR $8033
L9C0B:  BCS $9C12
L9C0D:  LDA #$03
L9C0F:  STA EnStatus,X
L9C12:  LDA #$01
L9C14:  JSR $800C
L9C17:  JMP $8006
L9C1A:  JMP $9BD2
L9C1D:  LDX #$50
L9C1F:  JSR $9C2A
L9C22:  TXA 
L9C23:  SEC 
L9C24:  SBC #$10
L9C26:  TAX 
L9C27:  BNE $9C1F
L9C29:  RTS

L9C2A:  LDY EnStatus,X
L9C2D:  BEQ $9C55
L9C2F:  LDA EnDataIndex,X
L9C32:  CMP #$0A
L9C34:  BEQ $9C3A
L9C36:  CMP #$09
L9C38:  BNE $9CA7
L9C3A:  LDA $0405,X
L9C3D:  AND #$02
L9C3F:  BEQ $9C55
L9C41:  DEY 
L9C42:  BEQ $9C60
L9C44:  CPY #$02
L9C46:  BEQ $9C55
L9C48:  CPY #$03
L9C4A:  BNE $9CA7
L9C4C:  LDA $040C,X
L9C4F:  CMP #$01
L9C51:  BNE $9CA7
L9C53:  BEQ $9C60
L9C55:  LDA #$00
L9C57:  STA EnStatus,X
L9C5A:  STA EnSpecialAttribs,X
L9C5D:  JSR $802A
L9C60:  LDA $0405
L9C63:  STA $0405,X
L9C66:  LSR 
L9C67:  PHP 
L9C68:  TXA 
L9C69:  LSR 
L9C6A:  LSR 
L9C6B:  LSR 
L9C6C:  LSR 
L9C6D:  TAY 
L9C6E:  LDA $9CB7,Y
L9C71:  STA $04
L9C73:  LDA $9CC6,Y
L9C76:  STA EnDataIndex,X
L9C79:  TYA 
L9C7A:  PLP 
L9C7B:  ROL 
L9C7C:  TAY 
L9C7D:  LDA $9CBB,Y
L9C80:  STA $05
L9C82:  LDX #$00
L9C84:  JSR $9CA8
L9C87:  JSR $8027
L9C8A:  LDX PageIndex
L9C8C:  BCC $9CA7
L9C8E:  LDA EnStatus,X
L9C91:  BNE $9C96
L9C93:  INC EnStatus,X
L9C96:  LDA $08
L9C98:  STA EnYRoomPos,X
L9C9B:  LDA $09
L9C9D:  STA EnXRoomPos,X
L9CA0:  LDA $0B
L9CA2:  AND #$01
L9CA4:  STA EnNameTable,X
L9CA7:  RTS

L9CA8:  LDA EnYRoomPos,X
L9CAB:  STA $08
L9CAD:  LDA EnXRoomPos,X
L9CB0:  STA $09
L9CB2:  LDA EnNameTable,X
L9CB5:  STA $0B
L9CB7:  RTS

L9CB8:  .byte $F5, $FD, $05, $F6, $FE, $0A, $F6, $0C, $F4, $0E, $F2, $F8, $08, $F4, $0C, $09
L9CC8:  .byte $09, $09, $0A, $0A
 
L9CCC:  LDY $7E
L9CCE:  BNE $9CD2
L9CD0:  LDY #$80
L9CD2:  LDA $2D
L9CD4:  AND #$02
L9CD6:  BNE $9D04
L9CD8:  DEY 
L9CD9:  STY $7E
L9CDB:  TYA 
L9CDC:  ASL 
L9CDD:  BMI $9D04
L9CDF:  AND #$0F
L9CE1:  CMP #$0A
L9CE3:  BNE $9D04
L9CE5:  LDA #$01
L9CE7:  LDX #$10
L9CE9:  CMP EnStatus,X
L9CEC:  BEQ $9CFF
L9CEE:  LDX #$20
L9CF0:  CMP EnStatus,X
L9CF3:  BEQ $9CFF
L9CF5:  LDX #$30
L9CF7:  CMP EnStatus,X
L9CFA:  BEQ $9CFF
L9CFC:  INC $7E
L9CFE:  RTS

L9CFF:  LDA #$08
L9D01:  STA EnDelay,X
L9D04:  RTS

L9D05:  LDY $7F
L9D07:  BNE $9D0B
L9D09:  LDY #$60
L9D0B:  LDA $2D
L9D0D:  AND #$02
L9D0F:  BNE $9D34
L9D11:  DEY 
L9D12:  STY $7F
L9D14:  TYA 
L9D15:  ASL 
L9D16:  BMI $9D34
L9D18:  AND #$0F
L9D1A:  BNE $9D34
L9D1C:  LDA #$01
L9D1E:  LDX #$40
L9D20:  CMP EnStatus,X
L9D23:  BEQ $9D2F
L9D25:  LDX #$50
L9D27:  CMP EnStatus,X
L9D2A:  BEQ $9D2F
L9D2C:  INC $7F
L9D2E:  RTS

L9D2F:  LDA #$08
L9D31:  STA EnDelay,X
L9D34:  RTS

L9D35:  .byte $60, $22, $FF, $FF, $FF, $FF, $22, $80, $81, $82, $83, $22, $84, $85, $86, $87
L9D45:  .byte $22, $88, $89, $8A, $8B, $22, $8C, $8D, $8E, $8F, $22, $94, $95, $96, $97, $22
L9D55:  .byte $9C, $9D, $9D, $9C, $22, $9E, $9F, $9F, $9E, $22, $90, $91, $92, $93, $32, $4E
L9D65:  .byte $4E, $4E, $4E, $4E, $4E

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:

L9D6A:  .byte $00, $01, $FF

L9D6D:  .byte $02, $FF

L9D6F:  .byte $19, $1A, $FF

L9D72:  .byte $1A, $1B, $FF

L9D75:  .byte $1C, $1D, $FF

L9D78:  .byte $1D, $1E, $FF

L9D7B:  .byte $22, $23, $24, $FF

L9D7F:  .byte $1F, $20, $21, $FF

L9D83:  .byte $22, $FF

L9D85:  .byte $1F, $FF

L9D87:  .byte $23, $04, $FF

L9D8A:  .byte $20, $03, $FF

L9D8D:  .byte $27, $28, $29, $FF

L9D91:  .byte $37, $FF

L9D93:  .byte $38, $FF

L9D95:  .byte $39, $FF

L9D97:  .byte $3A, $FF

L9D99:  .byte $3B, $FF

L9D9B:  .byte $3C, $FF

L9D9D:  .byte $3D, $FF

L9D9F:  .byte $58, $59, $FF

L9DA2:  .byte $5A, $5B, $FF

L9DA5:  .byte $5C, $5D, $FF

L9DA8:  .byte $5E, $5F, $FF

L9DAB:  .byte $60, $FF

L9DAD:  .byte $61, $F7, $62, $F7, $FF

L9DB2:  .byte $63, $64, $FF

L9DB5:  .byte $65, $FF

L9DB7:  .byte $66, $67, $FF

L9DBA:  .byte $69, $6A, $FF

L9DBD:  .byte $68, $FF

L9DBF:  .byte $6B, $FF

L9DC1:  .byte $66, $FF

L9DC3:  .byte $69, $FF

L9DC5:  .byte $6C, $FF

L9DC7:  .byte $6D, $FF

L9DC9:  .byte $6F, $70, $71, $6E, $FF

L9DCE:  .byte $73, $74, $75, $72, $FF

L9DD3:  .byte $8F, $90, $FF

L9DD6:  .byte $91, $92, $FF

L9DD9:  .byte $93, $94, $FF

L9DDC:  .byte $95, $FF

L9DDE:  .byte $96, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9DE0:  .word $9FC2, $9FC7, $9FCC, $9FD1, $9FDA, $9FE3, $9FE3, $9FE3
L9DF0:  .word $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3
L9E00:  .word $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3
L9E10:  .word $9FE3, $9FE3, $9FF1, $9FFF, $A00B, $A019, $A027, $A033
L9E20:  .word $A03C, $A046, $A050, $A059, $A063, $A06D, $A06D, $A06D
L9E30:  .word $A07B, $A082, $A08B, $A08B, $A08B, $A08B, $A08B, $A08B
L9E40:  .word $A08B, $A08B, $A08B, $A08B, $A08B, $A08B, $A08B, $A08B
L9E50:  .word $A09F, $A0B3, $A0BE, $A0C9, $A0D2, $A0DB, $A0E6, $A0E6
L9E60:  .word $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9E70:  .word $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9E80:  .word $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9E90:  .word $A0E6, $A0EE, $A0F6, $A0FE, $A106, $A10E, $A116, $A11E
L9EA0:  .word $A126, $A12E, $A13C, $A156, $A162, $A16F, $A177, $A17F
L9EB0:  .word $A187, $A18F, $A197, $A19F, $A1A7, $A1AF, $A1B7, $A1BF
L9EC0:  .word $A1C7, $A1CF, $A1D7, $A1DF, $A1E7, $A1EF, $A1F7, $A1F7
L9ED0:  .word $A1F7, $A1F7, $A1F7, $A1F7, $A1F7, $A1F7, $A1F7, $A1F7

EnemyFramePtrTbl2:
L9EE0:  .word $A1F7, $A1FF, $A204, $A204, $A204, $A204, $A204, $A204
L9EF0:  .word $A204, $A204, $A209, $A209, $A209, $A209, $A209, $A209
L9F00:  .word $A213, $A21D, $A22D, $A23D, $A24D, $A25D, $A267

EnemyPlacePtrTbl:
L9F0E:  .word $9F2E, $9F30, $9F48, $9F60, $9F60, $9F60, $9F70, $9F7C
L9F1E:  .word $9F84, $9F90, $9F90, $9FB0, $9FBE, $9FBE, $9FBE, $9FBE

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9F2E:  .byte $FC, $FC

;Enemy explode.
L9F30:  .byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9F40:  .byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9F48:  .byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
L9F58:  .byte $00, $04, $08, $F4, $08, $FC, $08, $04

L9F60:  .byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9F70:  .byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

L9F7C:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

L9F84:  .byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

L9F90:  .byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9FA0:  .byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9FB0:  .byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9FBE:  .byte $FC, $F8, $FC, $00 

;Enemy frame drawing data.

L9FC2:  .byte $00, $02, $02, $14, $FF

L9FC7:  .byte $00, $02, $02, $24, $FF

L9FCC:  .byte $00, $00, $00, $04, $FF

L9FD1:  .byte $27, $06, $08, $FC, $04, $00, $D0, $D1, $FF

L9FDA:  .byte $67, $06, $08, $FC, $04, $00, $D0, $D1, $FF

L9FE3:  .byte $25, $08, $0A, $A3, $B3, $A4, $B4, $FE, $FE, $FD, $62, $A3, $B3, $FF

L9FF1:  .byte $25, $08, $0A, $A5, $B3, $FE, $FE, $A4, $B4, $FD, $62, $A5, $B3, $FF

L9FFF:  .byte $26, $08, $0A, $B5, $B3, $A4, $B4, $FD, $62, $B5, $B3, $FF

LA00B:  .byte $A5, $08, $0A, $A3, $B3, $A4, $B4, $FE, $FE, $FD, $E2, $A3, $B3, $FF

LA019:  .byte $A5, $08, $0A, $A5, $B3, $FE, $FE, $A4, $B4, $FD, $E2, $A5, $B3, $FF

LA027:  .byte $A6, $08, $0A, $B5, $B3, $A4, $B4, $FD, $E2, $B5, $B3, $FF

LA033:  .byte $27, $06, $08, $FC, $04, $00, $C0, $C1, $FF

LA03C:  .byte $27, $06, $08, $E0, $E1, $FD, $A2, $E0, $E1, $FF

LA046:  .byte $27, $06, $08, $F0, $F1, $FD, $A2, $F0, $F1, $FF

LA050:  .byte $67, $06, $08, $FC, $04, $00, $C0, $C1, $FF

LA059:  .byte $67, $06, $08, $E0, $E1, $FD, $E2, $E0, $E1, $FF

LA063:  .byte $67, $06, $08, $F0, $F1, $FD, $E2, $F0, $F1, $FF

LA06D:  .byte $28, $0C, $08, $CE, $FC, $00, $FC, $DE, $EE, $DF, $FD, $62, $EE, $FF

LA07B:  .byte $28, $0C, $08, $CE, $CF, $EF, $FF

LA082:  .byte $28, $0C, $08, $CE, $FD, $62, $CF, $EF, $FF

LA08B:  .byte $21, $00, $00, $FC, $08, $FC, $A3, $FC, $00, $08, $A3, $FC, $00, $F8, $B3, $FC
LA09B:  .byte $00, $08, $B3, $FF

LA09F:  .byte $21, $00, $00, $FC, $00, $FC, $B3, $FC, $00, $08, $B3, $FC, $00, $F8, $A3, $FC
LA0AF:  .byte $00, $08, $A3, $FF

LA0B3:  .byte $21, $00, $00, $FC, $04, $00, $F1, $F0, $F1, $F0, $FF

LA0BE:  .byte $21, $00, $00, $FC, $04, $00, $F0, $F1, $F0, $F1, $FF

LA0C9:  .byte $21, $00, $00, $FC, $08, $00, $D1, $D0, $FF

LA0D2:  .byte $21, $00, $00, $FC, $08, $00, $D0, $D1, $FF

LA0DB:  .byte $21, $00, $00, $FC, $08, $00, $DE, $DF, $EE, $EE, $FF

LA0E6:  .byte $27, $08, $08, $CC, $CD, $DC, $DD, $FF

LA0EE:  .byte $67, $08, $08, $CC, $CD, $DC, $DD, $FF

LA0F6:  .byte $27, $08, $08, $CA, $CB, $DA, $DB, $FF

LA0FE:  .byte $A7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA106:  .byte $A7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA10E:  .byte $E7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA116:  .byte $67, $08, $08, $CA, $CB, $DA, $DB, $FF

LA11E:  .byte $E7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA126:  .byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA12E:  .byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA13C:  .byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA14C:  .byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA156:  .byte $2B, $08, $08, $E2, $E3, $E4, $FE, $FD, $62, $E3, $E4, $FF

LA162:  .byte $2B, $08, $08, $E2, $E3, $FE, $E4, $FD, $62, $E3, $FE, $E4, $FF

LA16F:  .byte $21, $00, $00, $96, $96, $98, $98, $FF

LA177:  .byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA17F:  .byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA187:  .byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA18F:  .byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA197:  .byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA19F:  .byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA1A7:  .byte $20, $02, $04, $FC, $FF

LA1AC:  .byte $00, $F8, $FF

LA1AF:  .byte $60, $02, $04, $FC, $FF

LA1B4:  .byte $00, $F8, $FF

LA1B7:  .byte $20, $02, $02, $FC, $FE, $00, $D9, $FF

LA1BF:  .byte $E0, $02, $02, $FC, $00, $02, $D8, $FF

LA1C7:  .byte $E0, $02, $02, $FC, $02, $00, $D9, $FF

LA1CF:  .byte $20, $02, $02, $FC, $00, $FE, $D8, $FF

LA1D7:  .byte $60, $02, $02, $FC, $FE, $00, $D9, $FF

LA1DF:  .byte $A0, $02, $02, $FC, $00, $FE, $D8, $FF

LA1E7:  .byte $A0, $02, $02, $FC, $02, $00, $D9, $FF

LA1EF:  .byte $60, $02, $02, $FC, $00, $02, $D8, $FF

LA1F7:  .byte $06, $08, $04, $FE, $FE, $14, $24, $FF

LA1FF:  .byte $00, $04, $04, $8A, $FF

LA204:  .byte $00, $04, $04, $8A, $FF

LA209:  .byte $3F, $04, $08, $FD, $03, $EC, $FD, $43, $EC, $FF

LA213:  .byte $3F, $04, $08, $FD, $03, $ED, $FD, $43, $ED, $FF

LA21D:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA22D:  .byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA23D:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA24D:  .byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA25D:  .byte $21, $00, $00, $C5, $C7, $D5, $D7, $E5, $E7, $FF

LA267:  .byte $21, $00, $00, $C7, $C5, $D7, $D5, $E7, $E5, $FF

;----------------------------------------[ Palette data ]--------------------------------------------

Palette00:
LA271:  .byte $3F                       ;Upper byte of PPU palette adress.
LA272:  .byte $00                       ;Lower byte of PPU palette adress.
LA273:  .byte $20                       ;Palette data length.
;The following values are written to the background palette:
LA274:  .byte $0F, $22, $12, $1C, $0F, $22, $12, $1C, $0F, $27, $11, $07, $0F, $22, $12, $1C
;The following values are written to the sprite palette:
LA284:  .byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $2A, $3C, $0F, $15, $21, $38

LA294:  .byte $00                       ;End Palette00 info.

Palette01:
LA295:  .byte $3F                       ;Upper byte of PPU palette adress.
LA296:  .byte $12                       ;Lower byte of PPU palette adress.
LA297:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA298:  .byte $19, $27

LA29A:  .byte $00                       ;End Palette01 info.

Palette03:
LA29B:  .byte $3F                       ;Upper byte of PPU palette adress.
LA29C:  .byte $12                       ;Lower byte of PPU palette adress.
LA29D:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA29E:  .byte $2C, $27

LA2A0:  .byte $00                       ;End Palette02 info.

Palette02:
LA2A1:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2A2:  .byte $12                       ;Lower byte of PPU palette adress.
LA2A3:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA2A4:  .byte $19, $35

LA2A6:  .byte $00                       ;End Palette03 info.

Palette04:
LA2A7:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2A8:  .byte $12                       ;Lower byte of PPU palette adress.
LA2A9:  .byte $02                       ;Palette data length.
;The following values are written to the sprite palette:
LA2AA:  .byte $2C, $24

LA2AC:  .byte $00                       ;End Palette04 info.

Palette05:
LA2AD:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2AE:  .byte $00                       ;Lower byte of PPU palette adress.
LA2AF:  .byte $10                       ;Palette data length.
;The following values are written to the background palette:
LA2B0:  .byte $0F, $20, $10, $00, $0F, $28, $19, $17, $0F, $27, $11, $07, $0F, $28, $16, $17
LA2C0:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2C1:  .byte $14                       ;Lower byte of PPU palette adress.
LA2C2:  .byte $0C                       ;Palette data length.
;The following values are written to the sprite palette:
LA2C3:  .byte $0F, $12, $30, $21, $0F, $26, $1A, $31, $0F, $15, $21, $38

LA2CF:  .byte $00                       ;End Palette05 info.

Palette06:
LA2D0:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2D1:  .byte $11                       ;Lower byte of PPU palette adress.
LA2D2:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA2D3:  .byte $04, $09, $07

LA2D6:  .byte $00                       ;End Palette06 info.

Palette07:
LA2D7:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2D8:  .byte $11                       ;Lower byte of PPU palette adress.
LA2D9:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA2DA:  .byte $05, $09, $17

LA2DD:  .byte $00                       ;End Palette07 info.

Palette08:
LA2DE:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2DF:  .byte $11                       ;Lower byte of PPU palette adress.
LA2E0:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA2E1:  .byte $06, $0A, $26

LA2E4:  .byte $00                       ;End Palette08 info.

Palette09:
LA2E5:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2E6:  .byte $11                       ;Lower byte of PPU palette adress.
LA2E7:  .byte $03                       ;Palette data length.
;The following values are written to the sprite palette:
LA2E8:  .byte $16, $19, $27

LA2EB:  .byte $00                       ;End Palette09 info.

Palette0A:
LA2EC:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2ED:  .byte $00                       ;Lower byte of PPU palette adress.
LA2EE:  .byte $04                       ;Palette data length.
;The following values are written to the background palette:
LA2EF:  .byte $0F, $30, $30, $21

LA2F3:  .byte $00                       ;End Palette0A info.

Palette0B:
LA2F4:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2F5:  .byte $10                       ;Lower byte of PPU palette adress.
LA2F6:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA2F7:  .byte $0F, $15, $34, $17

LA2FB:  .byte $00                       ;End Palette0B info.

Palette0C:
LA2FC:  .byte $3F                       ;Upper byte of PPU palette adress.
LA2FD:  .byte $10                       ;Lower byte of PPU palette adress.
LA2FE:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA2FF:  .byte $0F, $15, $34, $19

LA303:  .byte $00                       ;End Palette0C info.

Palette0D:
LA304:  .byte $3F                       ;Upper byte of PPU palette adress.
LA305:  .byte $10                       ;Lower byte of PPU palette adress.
LA306:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA307:  .byte $0F, $15, $34, $28

LA30B:  .byte $00                       ;End Palette0D info.

Palette0E:
LA30C:  .byte $3F                       ;Upper byte of PPU palette adress.
LA30D:  .byte $10                       ;Lower byte of PPU palette adress.
LA30E:  .byte $04                       ;Palette data length.
;The following values are written to the sprite palette:
LA30F:  .byte $0F, $15, $34, $29

LA313:  .byte $00                       ;End Palette0E info.

;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
LA314:  .word $A441, $A454, $A45C, $A480, $A4BB, $A4ED, $A524, $A55A
LA324:  .word $A587, $A5B9, $A5DD, $A615, $A635, $A661, $A68D, $A6B1
LA334:  .word $A6DB, $A715, $A73C, $A768, $A78B, $A7A3, $A7D0, $A7F1
LA344:  .word $A81B, $A85B, $A88B, $A8B1, $A8E7, $A910, $A92B, $A96B
LA354:  .word $A997, $A9C6, $A9F6, $AA20, $AA56, $AAA4, $AAE6, $AB19
LA364:  .word $AB48, $AB71, $AB92, $ABBF, $AC24, $AC4D, $AC6A 

StrctPtrTbl:
LA372:  .word $AC84, $AC97, $ACB0, $ACC9, $ACD0, $ACD7, $ACDB, $ACE6
LA382:  .word $ACF3, $ACFF, $AD05, $AD0A, $AD1A, $AD1E, $AD28, $AD4D 
LA392:  .word $AD57, $AD6A, $AD7F, $AD8E, $AD98, $ADA2, $ADAD, $ADBE
LA3A2:  .word $ADE3, $ADE6, $ADEC, $ADF9, $AE09, $AE13, $AE18, $AE2D
LA3B2:  .word $AE42, $AE48, $AE4B, $AE5F, $AE70, $AE85, $AE8E, $AE92
LA3C2:  .word $AEA5, $AEB0, $AEB3, $AEBE, $AEC8, $AECB, $AEDE, $AEE1
LA3D2:  .word $AEE4, $AEED 

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

;Elevator to Tourian.
LA3D6:  .byte $02
LA3D7:  .word $A3E4
LA3D9:  .byte $03, $05, $04, $03, $00

;Varia suit.
LA3DE:  .byte $0F, $FF, $02, $05, $37, $00

;Missiles.
LA3E4:  .byte $03
LA3E5:  .word $A3F3
LA3E7:  .byte $18, $06, $02, $09, $67, $00

;Energy tank.
LA3ED:  .byte $1B, $FF, $02, $08, $87, $00

;Long beam.
LA3F3:  .byte $05
LA3F4:  .word $A402
LA3F6:  .byte $07, $06, $02, $02, $37, $00

;Bombs.
LA3FC:  .byte $19, $FF, $02, $00, $37, $00

;Palette change room.
LA402:  .byte $07
LA403:  .word $A40F
LA405:  .byte $0C, $04, $0A, $00

;Energy tank.
LA409:  .byte $19, $FF, $02, $08, $87, $00

;Ice beam.
LA40F:  .byte $09
LA410:  .word $A41C
LA412:  .byte $13, $06, $02, $07, $37, $00

;Mellows.
LA418:  .byte $15, $FF, $03, $00

;Missiles.
LA41C:  .byte $0B
LA41D:  .word $A42A
LA41F:  .byte $12, $06, $02, $09, $67, $00

;Elevator to Norfair.
LA425:  .byte $16, $FF, $04, $01, $00

;Maru Mari.
LA42A:  .byte $0E
LA42B:  .word $A439
LA42D:  .byte $02, $06, $02, $04, $96, $00

;Energy tank.
LA433:  .byte $09, $FF, $02, $08, $12, $00

;Elevator to Kraid.
LA439:  .byte $12
LA43A:  .word $FFFF
LA43C:  .byte $07, $FF, $04, $02, $00

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
LA441:  .byte $02                               ;Attribute table data.
;Room object data:
LAA42:  .byte $40, $01, $02, $48, $01, $02, $50, $03, $02, $5F, $03, $02, $FD
;Room enemy/door data:
LAA4F:  .byte $02, $A1, $02, $B1, $FF

;Room #$01
LA454:  .byte $02                               ;Attribute table data.
;Room object data:
LA455:  .byte $07, $02, $02, $87, $02, $02, $FF

;Room #$02
LA45C:  .byte $03                               ;Attribute table data.
;Room object data:
LA45D:  .byte $00, $0B, $03, $0E, $0B, $03, $50, $0B, $03, $5E, $0B, $03, $A0, $0B, $03, $AE
LA46D:  .byte $0B, $03, $FD
;Room enemy/door data: 
LA470:  .byte $01, $03, $42, $11, $83, $8A, $21, $03, $B5, $31, $02, $59, $41, $02, $A3, $FF

;Room #$03
LA480:  .byte $02                               ;Attribute table data.
;Room object data:
LA481:  .byte $00, $0B, $03, $02, $09, $03, $0E, $0B, $03, $50, $0B, $03, $56, $0A, $03, $5F
LA491:  .byte $03, $02, $8B, $0A, $03, $8E, $0B, $03, $92, $0A, $03, $A0, $0B, $03, $C7, $09
LA4A1:  .byte $03, $DE, $0B, $03, $FD 
;Room enemy/door data:
LA4A6:  .byte $02, $A1, $01, $85, $47, $11, $05, $BA, $21, $03, $08, $31, $83, $53, $41, $83
LA4B6:  .byte $97, $51, $03, $C5, $FF

;Room #$04
LA4BB:  .byte $03                               ;Attribute table data.
;Room object data:
LA4BC:  .byte $00, $0B, $03, $04, $0A, $03, $0E, $0B, $03, $47, $09, $03, $50, $03, $02, $5E
LA4CC:  .byte $0B, $03, $80, $0B, $03, $82, $0A, $03, $9C, $0A, $03, $AE, $0B, $03, $B6, $0A
LA4DC:  .byte $03, $C0, $0B, $03, $FD
;Room enemy/door data:
LA4E1:  .byte $02, $B1, $41, $03, $45, $51, $03, $BB, $31, $05, $39, $FF 

;Room #$05
LA4ED:  .byte $03                               ;Attribute table data.
;Room object data:
LA4EE:  .byte $00, $0B, $03, $0E, $0B, $03, $15, $09, $03, $50, $03, $02, $57, $0A, $03, $5F
LA4FE:  .byte $03, $02, $80, $0B, $03, $82, $0A, $03, $8B, $0A, $03, $8E, $0B, $03, $B0, $0B
LA50E:  .byte $03, $C6, $09, $03, $CE, $0B, $03, $FD
;Room enemy/door data:
LA516:  .byte $02, $A1, $02, $B1, $01, $83, $43, $31, $85, $48, $51, $05, $B7, $FF

;Room #$06
LA524:  .byte $03                               ;Attribute table data.
;Room object data:
LA525:  .byte $00, $0B, $03, $0E, $0B, $03, $12, $0A, $03, $37, $0A, $03, $50, $0B, $03, $5E
LA535:  .byte $0B, $03, $73, $0A, $03, $8A, $0A, $03, $A0, $0B, $03, $AE, $0B, $03, $B6, $09
LA545:  .byte $03, $FD 
;Room enemy/door data:
LA547:  .byte $01, $03, $B3, $11, $03, $3C, $21, $05, $A8, $31, $05, $64, $51, $85, $7B, $41
LA557:  .byte $05, $28, $FF

;Room #$07
LA55A:  .byte $03                               ;Attribute table data.
;Room object data:
LA55B:  .byte $00, $0D, $03, $08, $0D, $03, $54, $06, $03, $5A, $06, $03, $67, $07, $03, $A0
LA56B:  .byte $0B, $03, $AE, $0B, $03, $C2, $06, $03, $CD, $06, $03, $D2, $00, $02, $D6, $00
LA57B:  .byte $02, $FD
;Room enemy/door data:
LA57D:  .byte $51, $05, $B2, $41, $05, $BD, $31, $05, $67, $FF

;Room #$08
LA587:  .byte $03                               ;Attribute table data.
;Room object data:
LA588:  .byte $00, $1E, $03, $04, $1E, $03, $08, $1E, $03, $0C, $1E, $03, $38, $1E, $03, $40
LA598:  .byte $1E, $03, $44, $1E, $03, $4C, $1E, $03, $74, $1E, $03, $78, $1E, $03, $80, $1E
LA5A8:  .byte $03, $8C, $1E, $03, $B0, $1E, $03, $B4, $1E, $03, $B8, $1E, $03, $CC, $1E, $03
LA5B8:  .byte $FF

;Room #$09(Starting room).
LA5B9:  .byte $03                               ;Attribute table data.
;Room object data:
LA5BA:  .byte $00, $11, $01, $08, $11, $01, $35, $1D, $03, $3B, $1D, $03, $55, $0B, $03, $5A
LA5CA:  .byte $0B, $03, $C5, $16, $00, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data: 
LA5D6:  .byte $51, $05, $25, $41, $05, $2B, $FF

;Room #$0A
LA5DD:  .byte $00                               ;Attribute table data.
;Room object data:
LA5DE:  .byte $00, $14, $00, $08, $14, $00, $0F, $15, $00, $10, $15, $00, $14, $15, $00, $25
LA5EE:  .byte $08, $03, $50, $14, $00, $58, $0C, $00, $5F, $04, $02, $60, $14, $00, $70, $13
LA5FE:  .byte $00, $80, $14, $00, $88, $14, $00, $90, $16, $00, $99, $16, $00, $B3, $15, $00
LA60E:  .byte $BC, $15, $00, $FD
;Room enemy/door data: 
LA612:  .byte $02, $A0, $FF

;Room #$0B
LA615:  .byte $00                               ;Attribute table data.
;Room object data:
LA616:  .byte $00, $15, $00, $01, $16, $00, $08, $16, $00, $0F, $15, $00, $4F, $15, $00, $50
LA626:  .byte $04, $02, $80, $16, $00, $87, $02, $02, $89, $16, $00, $FD
;Room enemy/door data:
LA632:  .byte $02, $B1, $FF

;Room #$0C
LA635:  .byte $02                               ;Attribute table data.
;Room object data:
LA636:  .byte $00, $1B, $02, $08, $1B, $02, $10, $1A, $02, $50, $03, $02, $80, $1A, $02, $82
LA646:  .byte $19, $02, $BC, $19, $02, $C0, $1A, $02, $C6, $1B, $02, $D1, $00, $02, $D9, $00
LA656:  .byte $02, $FD
;Room enemy/door data:
LA658:  .byte $02, $B1, $51, $02, $5A, $31, $02, $AA, $FF

;Room #$0D
LA661:  .byte $02                               ;Attribute table data.
;Room object data:
LA662:  .byte $00, $1B, $02, $08, $1B, $02, $1E, $1A, $02, $5F, $03, $02, $8C, $19, $02, $8E
LA672:  .byte $1A, $02, $B7, $1A, $02, $C2, $1A, $02, $CE, $1A, $02, $D0, $00, $02, $D7, $00
LA682:  .byte $02, $FD
;Room enemy/door data:
LA684:  .byte $02, $A1, $31, $05, $B3, $51, $02, $44, $FF

;Room #$0E
LA68D:  .byte $02                               ;Attribute table data.
;Room object data:
LA68E:  .byte $00, $1B, $02, $08, $1B, $02, $AC, $19, $02, $B4, $19, $02, $B8, $1A, $02, $D0
LA69E:  .byte $00, $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA6A4:  .byte $01, $82, $28, $11, $05, $A5, $21, $02, $8B, $31, $02, $BD, $FF 

;Room #$0F
LA6B1:  .byte $03                               ;Attribute table data.
;Room object data:
LA6B2:  .byte $00, $1B, $02, $08, $1B, $02, $59, $06, $03, $92, $19, $02, $AC, $19, $02, $BB
LA6C2:  .byte $19, $02, $C0, $06, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA6CE:  .byte $01, $02, $3B, $11, $02, $B8, $51, $85, $84, $41, $05, $49, $FF

;Room #$10
LA6DB:  .byte $02                               ;Attribute table data.
;Room object data:
LA6DC:  .byte $00, $17, $02, $08, $17, $02, $10, $17, $02, $18, $17, $02, $50, $03, $02, $5F
LA6EC:  .byte $03, $02, $80, $1A, $02, $82, $19, $02, $86, $2E, $02, $87, $1B, $02, $8E, $1A
LA6FC:  .byte $02, $C0, $1A, $02, $CE, $1A, $02, $D2, $12, $02, $D8, $12, $02, $FD
;Room enemy/door data:
LA70A:  .byte $02, $A1, $02, $B1, $01, $02, $5C, $11, $02, $A7, $FF

;Room #$11
LA715:  .byte $03                               ;Attribute table data.
;Room object data:
LA716:  .byte $00, $0B, $03, $02, $06, $03, $0E, $0B, $03, $50, $0B, $03, $52, $06, $03, $5E
LA726:  .byte $0B, $03, $A0, $0B, $03, $A2, $06, $03, $AE, $0B, $03, $FD
;Room enemy/door data:
LA732:  .byte $01, $83, $DD, $11, $03, $35, $21, $02, $7D, $FF

;Room #$12
LA73C:  .byte $03                               ;Attribute table data.
;Room object data:
LA73D:  .byte $00, $0B, $03, $02, $11, $01, $0A, $11, $01, $50, $03, $02, $80, $0B, $03, $82
LA74D:  .byte $0A, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA756:  .byte $02, $B1, $01, $05, $C7, $11, $05, $CB, $51, $04, $3A, $41, $04, $29, $31, $04
LA766:  .byte $1E, $FF

;Room #$13
LA768:  .byte $03                               ;Attribute table data.
;Room object data:
LA769:  .byte $00, $11, $01, $07, $10, $03, $0E, $0B, $03, $5F, $03, $02, $8A, $09, $03, $8E
LA779:  .byte $0B, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA782:  .byte $02, $A1, $01, $05, $7B, $11, $05, $C8, $FF

;Room #$14
LA78B:  .byte $01                               ;Attribute table data.
;Room object data:
LA78C:  .byte $00, $11, $01, $08, $11, $01, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA799:  .byte $51, $04, $14, $21, $04, $38, $41, $04, $2E, $FF

;Room #$15
LA7A3:  .byte $03                               ;Attribute table data.
;Room object data:
LA7A4:  .byte $00, $10, $03, $08, $10, $03, $90, $1F, $01, $96, $1F, $01, $AA, $05, $03, $AC
LA7B4:  .byte $1F, $01, $BA, $10, $03, $C4, $05, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA7C3:  .byte $51, $05, $89, $37, $87, $AB, $21, $06, $23, $17, $07, $C5, $FF

;Room #$16
LA7D0:  .byte $01                               ;Attribute table data.
;Room object data:
LA7D1:  .byte $00, $11, $01, $08, $11, $01, $B0, $1F, $01, $B6, $05, $03, $B8, $05, $03, $BC
LA7E1:  .byte $1F, $01, $C6, $1F, $01, $D4, $00, $02, $FD
;Room enemy/door data:
LA7EA:  .byte $07, $07, $B7, $47, $87, $B9, $FF

;Room #$17
LA7F1:  .byte $03                               ;Attribute table data.
;Room object data:
LA7F2:  .byte $00, $11, $01, $08, $10, $03, $4A, $1E, $03, $6B, $1E, $03, $8C, $1E, $03, $A6
LA802:  .byte $15, $00, $B3, $1D, $03, $B9, $1D, $03, $C3, $0C, $00, $C8, $0C, $00, $D0, $10
LA812:  .byte $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA817:  .byte $41, $05, $B4, $FF

;Room #$18
LA81B:  .byte $01                               ;Attribute table data.
;Room object data:
LA81C:  .byte $00, $0B, $03, $01, $11, $01, $09, $11, $01, $0E, $0B, $03, $50, $03, $02, $5F
LA82C:  .byte $03, $02, $64, $0D, $03, $66, $20, $01, $80, $1F, $01, $84, $20, $01, $88, $20
LA83C:  .byte $01, $8C, $1E, $03, $A6, $20, $01, $B0, $0B, $03, $BE, $0B, $03, $E6, $20, $01
LA84C:  .byte $FD
;Room enemy/door data:
LA84D:  .byte $02, $A1, $02, $B1, $31, $05, $56, $01, $85, $5A, $21, $05, $D9, $FF

;Room #$19
LA85B:  .byte $01                               ;Attribute table data.
;Room object data:
LA85C:  .byte $00, $10, $03, $04, $1F, $01, $08, $1F, $01, $0C, $11, $01, $12, $31, $03, $44
LA86C:  .byte $1F, $01, $48, $1F, $01, $84, $1F, $01, $88, $1F, $01, $D0, $1F, $01, $D4, $1F
LA87C:  .byte $01, $D8, $10, $03, $FD
;Room enemy/door data:
LA881:  .byte $51, $05, $C0, $41, $05, $CA, $31, $06, $3C, $FF

;Room #$1A
LA88B:  .byte $02                               ;Attribute table data.
;Room object data:
LA88C:  .byte $00, $28, $02, $01, $2D, $02, $09, $2D, $02, $50, $04, $02, $80, $28, $02, $81
LA89C:  .byte $14, $00, $95, $15, $00, $D0, $2D, $02, $D8, $2D, $02, $FD
;Room enemy/door data:
LA8A8:  .byte $02, $B0, $01, $05, $C7, $11, $85, $CA, $FF

;Room #$1B
LA8B1:  .byte $00                               ;Attribute table data.
;Room object data:
LA8B2:  .byte $00, $14, $00, $04, $15, $00, $08, $14, $00, $0A, $15, $00, $97, $06, $03, $A0
LA8C2:  .byte $0B, $03, $A6, $15, $00, $A8, $15, $00, $AE, $0B, $03, $B4, $06, $03, $BA, $06
LA8D2:  .byte $03, $C2, $06, $03, $D2, $00, $02, $D6, $00, $02, $FD
;Room enemy/door data:
LA8DD:  .byte $41, $05, $AA, $21, $06, $17, $11, $05, $A4, $FF

;Room #$1C
LA8E7:  .byte $00                               ;Attribute table data.
;Room object data:
LA8E8:  .byte $00, $15, $00, $01, $0D, $03, $09, $0E, $01, $2A, $23, $01, $37, $22, $03, $4D
LA8F8:  .byte $0E, $01, $50, $03, $02, $6A, $16, $00, $6D, $0E, $01, $80, $14, $00, $87, $02
LA908:  .byte $02, $89, $14, $00, $FD
;Room enemy/door data:
LA90D:  .byte $02, $B1, $FF

;Room #$1D
LA910:  .byte $01                               ;Attribute table data.
;Room object data:
LA911:  .byte $00, $0E, $01, $08, $0E, $01, $44, $0E, $01, $84, $0F, $01, $94, $0E, $01, $B0
LA921:  .byte $0E, $01, $B8, $0E, $01, $FD 
;Room enemy/door data:
LA927:  .byte $31, $06, $42, $FF

;Room #$1E
LA92B:  .byte $01                               ;Attribute table data.
;Room object data:
LA92C:  .byte $00, $0E, $01, $02, $2A, $01, $07, $25, $01, $08, $0E, $01, $10, $0E, $01, $12
LA93c:  .byte $2A, $01, $17, $25, $01, $18, $0E, $01, $50, $03, $02, $5F, $03, $02, $74, $26
LA94C:  .byte $01, $78, $26, $01, $80, $0E, $01, $88, $0E, $01, $C0, $24, $01, $CC, $24, $01
LA95C:  .byte $D4, $00, $02, $FD
;Room enemy/door data:
LA960:  .byte $02, $A1, $02, $B1, $11, $02, $52, $01, $03, $C8, $FF

;Room #$1F
LA96B:  .byte $01                               ;Attribute table data.
;Room object data:
LA96C:  .byte $00, $27, $01, $08, $27, $01, $10, $24, $01, $50, $03, $02, $80, $24, $01, $A6
LA97C:  .byte $26, $01, $B0, $0E, $01, $CA, $26, $01, $D8, $0E, $01, $FD
;Room enemy/door data:
LA988:  .byte $02, $B1, $01, $02, $2B, $11, $02, $BB, $21, $82, $5B, $31, $02, $8B, $FF

;Room #$20
LA997:  .byte $01                               ;Attribute table data.
;Room object data:
LA998:  .byte $00, $27, $01, $08, $27, $01, $1C, $24, $01, $20, $24, $01, $5F, $03, $02, $8C
LA9A8:  .byte $24, $01, $BA, $26, $01, $C4, $26, $01, $C8, $0E, $01, $D0, $0E, $01, $FD 
;Room enemy/door data:
LA9B7:  .byte $02, $A1, $51, $02, $85, $41, $02, $C5, $31, $05, $BA, $21, $05, $C5, $FF

;Room #$21
LA9C6:  .byte $01                               ;Attribute table data.
;Room object data:
LA9C7:  .byte $00, $0E, $01, $08, $0E, $01, $30, $0E, $01, $38, $0E, $01, $A7, $26, $01, $B0
LA9D7:  .byte $24, $01, $B6, $24, $01, $BC, $24, $01, $C4, $05, $03, $D4, $27, $01, $DA, $00
LA9E7:  .byte $02, $FD
;Room enemy/door data:
LA9E9:  .byte $07, $07, $C5, $11, $05, $AC, $21, $05, $A8, $51, $06, $7A, $FF

;Room #$22
LA9F6:  .byte $01                               ;Attribute table data.
;Room object data:
LA9F7:  .byte $00, $0E, $01, $08, $0E, $01, $30, $0E, $01, $37, $25, $01, $48, $2A, $01, $4C
LAA07:  .byte $2A, $01, $68, $0E, $01, $78, $0E, $01, $A3, $26, $01, $B0, $0E, $01, $B8, $0E
LAA17:  .byte $01, $FD
;Room enemy/door data:
LAA19:  .byte $41, $06, $75, $21, $03, $85, $FF

;Room #$23
LAA20:  .byte $02                               ;Attribute table data.
;Room object data:
LAA21:  .byte $00, $27, $01, $08, $27, $01, $63, $29, $01, $73, $28, $02, $8B, $29, $01, $9B
LAA31:  .byte $28, $02, $C0, $26, $01, $C6, $26, $01, $D0, $0E, $01, $D8, $00, $02, $D9, $0E
LAA41:  .byte $01, $DE, $05, $03, $FD
;Room enemy/door data:
LAA46:  .byte $01, $85, $63, $11, $05, $8B, $21, $02, $6E, $47, $07, $DF, $31, $83, $A8, $FF

;Room #$24
LAA56:  .byte $01                               ;Attribute table data.
;Room object data:
LAA57:  .byte $00, $0E, $01, $08, $0E, $01, $40, $2B, $00, $48, $2B, $00, $50, $0E, $01, $53
LAA67:  .byte $20, $01, $58, $0E, $01, $5B, $20, $01, $60, $2B, $00, $68, $13, $00, $70, $27
LAA77:  .byte $01, $78, $27, $01, $80, $2B, $00, $88, $2B, $00, $90, $27, $01, $98, $27, $01
LAA87:  .byte $A0, $13, $00, $A8, $2B, $00, $B0, $0E, $01, $B8, $0E, $01, $FD
;Room enemy/door data:
LAA94:  .byte $01, $05, $4D, $11, $85, $6C, $21, $05, $8A, $31, $85, $AF, $41, $05, $47, $FF

;Room #$25
LAAA4:  .byte $02                               ;Attribute table data.
;Room object data:
LAAA5:  .byte $00, $27, $01, $05, $27, $01, $0A, $0E, $01, $23, $24, $01, $4A, $13, $00, $52
LAAB5:  .byte $24, $01, $59, $20, $01, $5A, $0E, $01, $6A, $2B, $00, $79, $0E, $01, $89, $2B
LAAC5:  .byte $00, $90, $28, $02, $94, $06, $03, $98, $0E, $01, $A8, $13, $00, $B0, $0E, $01
LAAD5:  .byte $B8, $0E, $01, $FD
;Room enemy/door data:
LAAD9:  .byte $51, $05, $4F, $41, $05, $6E, $31, $05, $8E, $21, $02, $48, $FF

;Room #$26
LAAE6:  .byte $01                               ;Attribute table data.
;Room object data:
LAAE7:  .byte $00, $0E, $01, $08, $27, $01, $40, $2B, $00, $50, $0E, $01, $56, $20, $01, $60
LAAF7:  .byte $2B, $00, $68, $2C, $00, $80, $27, $01, $8B, $24, $01, $D0, $00, $02, $D8, $00
LAB07:  .byte $02, $FD
;Room enemy/door data:
LAB09:  .byte $51, $05, $67, $41, $05, $7E, $21, $05, $7B, $31, $03, $49, $11, $02, $C6, $FF

;Room #$27
LAB19:  .byte $03                               ;Attribute table data.
;Room object data:
LAB1A:  .byte $00, $0B, $03, $02, $11, $01, $09, $11, $01, $50, $04, $02, $80, $0B, $03, $82
LAB2A:  .byte $1E, $03, $B6, $1D, $03, $B7, $1D, $03, $C2, $09, $03, $C8, $1D, $03, $D0, $10
LAB3A:  .byte $03, $D8, $10, $03, $FD
;Room enemy/door data:
LAB3F:  .byte $02, $B0, $11, $04, $38, $31, $06, $27, $FF

;Room #$28
LAB48:  .byte $00                               ;Attribute table data.
;Room object data:
LAB49:  .byte $00, $2D, $02, $08, $2D, $02, $0F, $28, $02, $5F, $03, $02, $87, $14, $00, $8F
LAB59:  .byte $28, $02, $9A, $15, $00, $C3, $26, $01, $D0, $2D, $02, $D8, $2D, $02, $FD 
;Room enemy/door data:
LAB68:  .byte $02, $A1, $01, $06, $23, $31, $05, $7D, $FF

;Room #$29
LAB71:  .byte $02                               ;Attribute table data.
;Room object data:
LAB72:  .byte $00, $2D, $02, $08, $2D, $02, $C2, $26, $01, $C7, $26, $01, $C9, $26, $01, $D0
LAB82:  .byte $2D, $02, $D8, $2D, $02, $FD
;Room enemy/door data:
LAB88:  .byte $41, $86, $25, $51, $06, $2A, $21, $05, $CB, $FF

;Room #$2A
LAB92:  .byte $00                               ;Attribute table data.
;Room object data:
LAB93:  .byte $00, $11, $01, $08, $11, $01, $68, $21, $02, $78, $15, $00, $95, $15, $00, $A0
LABA3:  .byte $0B, $03, $AE, $0B, $03, $BB, $15, $00, $C2, $06, $03, $D2, $00, $02, $D6, $00
LABB3:  .byte $02, $FD
;Room enemy/door data:
LABB5:  .byte $01, $05, $58, $11, $05, $85, $31, $06, $26, $FF

;Room #$2B(Bridge to Tourian).
LABBF:  .byte $02                               ;Attribute table data.
;Room object data:
LABC0:  .byte $00, $30, $00, $01, $1A, $02, $02, $30, $00, $03, $1A, $02, $05, $1C, $02, $0A
LABD0:  .byte $1B, $02, $0F, $30, $00, $10, $30, $00, $14, $30, $00, $1F, $30, $00, $2C, $18
LABE0:  .byte $02, $35, $18, $02, $41, $19, $02, $44, $2F, $02, $45, $18, $02, $46, $2F, $02
LABF0:  .byte $50, $04, $02, $53, $19, $02, $5F, $04, $02, $64, $1C, $02, $65, $1C, $02, $68
LAC00:  .byte $2F, $02, $80, $15, $00, $81, $19, $02, $8D, $19, $02, $9C, $19, $02, $9F, $15
LAC10:  .byte $00, $C0, $30, $00, $D1, $00, $02, $D7, $00, $02, $DF, $30, $00, $FD
;Room enemy/door data:
LAC1E:  .byte $02, $A0, $02, $B1, $06, $FF

;Room #$2C
LAC24:  .byte $00                               ;Attribute table data.
;Room object data:
LAC25:  .byte $00, $16, $00, $07, $16, $00, $0E, $16, $00, $1F, $15, $00, $20, $15, $00, $40
LAC35:  .byte $30, $00, $5F, $04, $02, $80, $16, $00, $87, $02, $02, $89, $16, $00, $A0, $15
LAC45:  .byte $00, $AF, $15, $00, $FD
;Room enemy/door data:
LAC4A:  .byte $02, $A1, $FF

;Room #$2D
LAC4D:  .byte $03                               ;Attribute table data.
;Room object data:
LAC4E:  .byte $00, $11, $01, $08, $11, $01, $1E, $1E, $03, $5F, $04, $02, $8B, $10, $03, $9E
LAC5E:  .byte $0B, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LAC67:  .byte $02, $A1, $FF

;Room #$2E
LAC6A:  .byte $03                               ;Attribute table data.
;Room object data:
LAC6B:  .byte $00, $0B, $03, $0E, $0B, $03, $50, $03, $02, $5E, $0B, $03, $80, $0B, $03, $AE
LAC7B:  .byte $0B, $03, $D0, $0B, $03, $FD
;Room enemy/door data:
LAC81:  .byte $02, $B1, $FF

;---------------------------------------[ Structure definitions ]------------------------------------

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LAC84:  .byte $08, $01, $01, $01, $01, $01, $01, $01, $01, $08, $00, $00, $00, $00, $00, $00
LAC94:  .byte $00, $00, $FF

;Structure #$01
LAC97:  .byte $08, $02, $02, $02, $02, $02, $02, $02, $02, $01, $28, $01, $28, $01, $28, $08
LACA7:  .byte $02, $02, $02, $02, $02, $02, $02, $02, $FF

;Structure #$02
LACB0:  .byte $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02
LACC0:  .byte $04, $05, $02, $04, $05, $02, $04, $05, $FF

;Structure #$03
LACC9:  .byte $01, $06, $01, $06, $01, $06, $FF

;Structure #$04
LACD0:  .byte $01, $07, $01, $07, $01, $07, $FF

;Structure #$05
LACD7:  .byte $02, $31, $32, $FF

;Structure #$06
LACDB:  .byte $01, $08, $01, $33, $01, $33, $01, $33, $01, $33, $FF

;Structure #$07
LACE6:  .byte $01, $28, $01, $08, $01, $1F, $01, $17, $01, $17, $01, $1F, $FF

;Structure #$08
LACF3:  .byte $02, $0E, $11, $03, $0F, $12, $22, $03, $10, $13, $14, $FF

;Structure #$09
LACFF:  .byte $04, $08, $35, $35, $08, $FF

;Structure #$0A
LAD05:  .byte $03, $08, $35, $08, $FF

;Structure #$0B
LAD0A:  .byte $02, $36, $36, $02, $1C, $08, $02, $08, $34, $02, $34, $34, $02, $08, $08, $FF

;Structure #$0C
LAD1A:  .byte $02, $20, $20, $FF

;Structure #$0D
LAD1E:  .byte $08, $08, $1C, $08, $35, $08, $35, $1C, $08, $FF

;Structure #$0E
LAD28:  .byte $08, $1E, $1E, $1C, $1C, $1E, $1E, $1E, $1E, $08, $1E, $1E, $1E, $1E, $1C, $1E
LAD38:  .byte $1E, $1E, $08, $1C, $1E, $1E, $1E, $1E, $1E, $1C, $1E, $08, $1E, $1E, $1E, $1C
LAD48:  .byte $1E, $1C, $1C, $1E, $FF

;Structure #$0F
LAD4D:  .byte $08, $2E, $2E, $2E, $2E, $2E, $2E, $2E, $2E, $FF

;Structure #$10
LAD57:  .byte $08, $08, $0B, $0B, $0B, $0B, $08, $0B, $0B, $08, $08, $08, $1C, $1C, $08, $08
LAD67:  .byte $1C, $08, $FF

;Structure #$11
LAD6A:  .byte $08, $1C, $08, $08, $08, $08, $0A, $08, $1C, $08, $08, $0A, $09, $0A, $28, $28
LAD7A:  .byte $08, $08, $01, $08, $FF

;Structure #$12
LAD7F:  .byte $06, $2C, $2C, $2C, $2C, $15, $2C, $06, $2D, $2D, $2D, $2D, $16, $2D, $FF

;Structure #$13
LAD8E:  .byte $08, $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B, $FF

;Structure #$14
LAD98:  .byte $08, $1A, $1A, $1A, $1A, $1A, $1A, $1A, $1A, $FF

;Structure #$15
LADA2:  .byte $01, $20, $01, $20, $01, $17, $01, $17, $01, $20, $FF

;Structure #$16
LADAD:  .byte $07, $20, $20, $20, $20, $20, $20, $20, $07, $20, $1A, $20, $1F, $20, $1A, $20
LADBD:  .byte $FF

;Structure #$17
LADBE:  .byte $08, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $08, $0D, $0D, $0D, $0D, $0D, $0D
LADCE:  .byte $0D, $0D, $08, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $08, $0D, $0D, $0D, $0D
LADDE:  .byte $0D, $0D, $0D, $0D, $FF

;Structure #$18
LADE3:  .byte $01, $0D, $FF

;Structure #$19
LADE6:  .byte $04, $0D, $0D, $0D, $0D, $FF

;Structure #$1A
LADEC:  .byte $02, $0D, $0D, $02, $0D, $0D, $02, $0D, $0D, $02, $0D, $0D, $FF

;Structure #$1B
LADF9:  .byte $08, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $05, $27, $30, $0D, $0D, $30, $FF

;Structure #$1C
LAE09:  .byte $08, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $FF

;Structure #$1D
LAE13:  .byte $01, $0C, $01, $1F, $FF

;Structure #$1E
LAE18:  .byte $04, $08, $35, $08, $08, $04, $08, $1C, $08, $34, $04, $34, $08, $08, $08, $04
LAE28:  .byte $08, $08, $1C, $08, $FF

;Structure #$1F
LAE2D:  .byte $04, $1D, $1D, $1D, $1D, $04, $1D, $1C, $1C, $1D, $04, $1C, $1D, $1C, $1C, $04
LAE3D:  .byte $1D, $1C, $1D, $1D, $FF

;Structure #$20
LAE42:  .byte $04, $33, $33, $33, $33, $FF

;Structure #$21
LAE48:  .byte $01, $22, $FF

;Structure #$22
LAE4B:  .byte $03, $28, $0E, $08, $03, $37, $08, $39, $03, $38, $39, $39, $03, $28, $3A, $0A
LAE5B:  .byte $02, $3B, $3C, $FF

;Structure #$23
LAE5F:  .byte $03, $1E, $1E, $1C, $03, $39, $08, $1E, $03, $0A, $09, $1E, $03, $3D, $0B, $0A
LAE6F:  .byte $FF

;Structure #$24
LAE70:  .byte $04, $1E, $1E, $1C, $1E, $04, $1E, $1E, $1E, $1E, $04, $1C, $1E, $1E, $1E, $04
LAE80:  .byte $1E, $1E, $1C, $1E, $FF

;Structure #$25
LAE85:  .byte $01, $23, $01, $23, $01, $23, $01, $23, $FF

;Structure #$26
LAE8E:  .byte $02, $3E, $3F, $FF

;Structure #$27
LAE92:  .byte $08, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $08, $1E, $1E, $1E, $1E, $1E, $1E
LAEA2:  .byte $1E, $1E, $FF

;Structure #$28
LAEA5:  .byte $01, $1F, $01, $1F, $01, $1F, $01, $1F, $01, $1F, $FF

;Structure #$29
LAEB0:  .byte $01, $3E, $FF

;Structure #$2A
LAEB3:  .byte $04, $2E, $2A, $2E, $2E, $04, $2E, $2E, $2E, $2A, $FF

;Structure #$2B
LAEBE:  .byte $08, $2B, $03, $03, $2B, $03, $03, $03, $2B, $FF

;Structure #$2C
LAEC8:  .byte $01, $1B, $FF

;Structure #$2D
LAECB:  .byte $08, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $08, $1F, $1F, $1F, $1F, $1F, $1F
LAEDB:  .byte $1F, $1F, $FF

;Structure #$2E
LAEDE:  .byte $01, $2F, $FF

;Structure #$2F
LAEE1:  .byte $01, $1F, $FF

;Structure #$30
LAEE4:  .byte $01, $17, $01, $17, $01, $17, $01, $17, $FF

;Structure #$31
LAEED:  .byte $01, $24, $FF

;----------------------------------------[ Macro definitions ]---------------------------------------

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

MacroDefs:

LAEF0:  .byte $F1, $F1, $F1, $F1
LAEF4:  .byte $FF, $FF, $F0, $F0
LAEF8:  .byte $64, $64, $64, $64
LAEFC:  .byte $D5, $D6, $CB, $CC
LAF00:  .byte $A4, $FF, $A4, $FF
LAF04:  .byte $FF, $A5, $FF, $A5
LAF08:  .byte $A0, $A0, $A0, $A0
LAF0C:  .byte $A1, $A1, $A1, $A1
LAF10:  .byte $00, $01, $02, $03
LAF14:  .byte $0B, $00, $FF, $0B
LAF18:  .byte $03, $0A, $0A, $FF
LAF1C:  .byte $08, $09, $02, $03
LAF20:  .byte $0E, $0F, $10, $11
LAF24:  .byte $12, $13, $14, $0C
LAF28:  .byte $FF, $FF, $FF, $30
LAF2C:  .byte $FF, $33, $FF, $36
LAF30:  .byte $FF, $39, $FF, $3D
LAF34:  .byte $FF, $FF, $31, $32
LAF38:  .byte $34, $35, $37, $38
LAF3C:  .byte $3A, $3B, $3E, $3F
LAF40:  .byte $3C, $41, $40, $42
LAF44:  .byte $FF, $FF, $43, $43
LAF48:  .byte $44, $44, $44, $44
LAF4C:  .byte $45, $46, $45, $46
LAF50:  .byte $FF, $47, $47, $48
LAF54:  .byte $48, $FF, $47, $48
LAF58:  .byte $48, $47, $47, $48
LAF5C:  .byte $49, $49, $4A, $4A
LAF60:  .byte $4B, $4C, $4D, $50
LAF64:  .byte $51, $52, $53, $54
LAF68:  .byte $55, $56, $57, $58
LAF6C:  .byte $59, $5B, $59, $5B
LAF70:  .byte $5C, $5D, $5E, $5F
LAF74:  .byte $4F, $4F, $4F, $4F
LAF78:  .byte $88, $89, $8A, $8B
LAF7C:  .byte $84, $85, $86, $87
LAF80:  .byte $8C, $8D, $8E, $8F
LAF84:  .byte $FF, $FF, $FF, $FF        ;Not used.
LAF88:  .byte $FF, $FF, $FF, $FF        ;Not used.
LAF8C:  .byte $FF, $FF, $FF, $FF        ;Not used.
LAF90:  .byte $FF, $FF, $FF, $FF        ;Not used.
LAF94:  .byte $B0, $B1, $B2, $B3
LAF98:  .byte $B4, $B5, $B6, $B7
LAF9C:  .byte $B8, $B8, $B9, $B9
LAFA0:  .byte $FF, $FF, $BA, $BA
LAFA4:  .byte $BB, $BB, $BB, $BB
LAFA8:  .byte $C7, $C8, $C9, $CA
LAFAC:  .byte $94, $95, $96, $97
LAFB0:  .byte $0D, $FF, $FF, $FF
LAFB4:  .byte $FF, $FF, $59, $5A
LAFB8:  .byte $FF, $FF, $5A, $5B
LAFBC:  .byte $80, $81, $82, $83
LAFC0:  .byte $04, $05, $04, $05
LAFC4:  .byte $06, $06, $07, $07
LAFC8:  .byte $60, $61, $62, $63
LAFCC:  .byte $C1, $00, $00, $08
LAFD0:  .byte $0B, $BE, $BC, $BD
LAFD4:  .byte $BF, $01, $02, $03
LAFD8:  .byte $C0, $01, $C0, $03
LAFDC:  .byte $FF, $C1, $FF, $FF
LAFE0:  .byte $C2, $01, $FF, $FF
LAFE4:  .byte $30, $00, $BC, $BD
LAFE8:  .byte $CD, $CE, $CF, $D0
LAFEC:  .byte $D1, $D2, $D3, $D4
LAFF0:  .byte $90, $91, $92, $93

;Not used.
LAFF4:  .byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0

;------------------------------------------[ Area music data ]---------------------------------------

;There are 3 control bytes associated with the music data and the rest are musical note indexes.
;If the byte has the binary format 1011xxxx ($Bx), then the byte is an index into the corresponding
;musical notes table and is used to set the note length until it is set by another note length
;byte. The lower 4 bits are the index into the note length table. Another control byte is the loop
;and counter btye. The loop and counter byte has the format 11xxxxxx. Bits 0 thru 6 contain the
;number of times to loop.  The third control byte is #$FF. This control byte marks the end of a loop
;and decrements the loop counter. If #$00 is found in the music data, the music has reached the end.
;A #$00 in any of the different music channel data segments will mark the end of the music. The
;remaining bytes are indexes into the MusicNotesTbl and should only be even numbers as there are 2
;bytes of data per musical note.

BrinstarSQ1IndexData:
LB000:  .byte $C2                       ;
LB001:  .byte $B4                       ;1 1/2 seconds  +
LB002:  .byte $2E                       ;B3             | Repeat 2 times
LB003:  .byte $30                       ;C4             +
LB004:  .byte $FF                       ;
LB005:  .byte $C3                       ;
LB006:  .byte $B3                       ;3/4 seconds    +
LB007:  .byte $2E                       ;B3             |
LB008:  .byte $34                       ;D4             | Repeat 3 times
LB009:  .byte $30                       ;C4             |
LB00A:  .byte $3A                       ;F4             +
LB00B:  .byte $FF                       ;
LB00C:  .byte $B4                       ;1 1/2 seconds
LB00d:  .byte $2E                       ;B3
LB00E:  .byte $B3                       ;3/4 seconds
LB00F:  .byte $30                       ;C4
LB010:  .byte $34                       ;D4
LB011:  .byte $C3                       ;
LB012:  .byte $B6                       ;1 3/16 seconds +
LB013:  .byte $38                       ;E4             |
LB014:  .byte $B9                       ;1/8 seconds    |
LB015:  .byte $30                       ;C4             |
LB016:  .byte $26                       ;G3             | Repeat 3 times
LB017:  .byte $30                       ;C4             |
LB018:  .byte $B3                       ;3/4 seconds    |
LB019:  .byte $3A                       ;F4             |
LB01A:  .byte $34                       ;D4             +
LB01B:  .byte $FF                       ;
LB01C:  .byte $B4                       ;1 1/2 seconds
LB01D:  .byte $38                       ;E4
LB01E:  .byte $38                       ;E4
LB01F:  .byte $B2                       ;3/8 seconds
LB020:  .byte $3A                       ;F4
LB021:  .byte $30                       ;C4
LB022:  .byte $2A                       ;A3
LB023:  .byte $B9                       ;1/8 seconds
LB024:  .byte $30                       ;C4
LB025:  .byte $2C                       ;A#3
LB026:  .byte $30                       ;C4
LB027:  .byte $B2                       ;3/8 seconds
LB028:  .byte $34                       ;D4
LB029:  .byte $3A                       ;F4
LB02A:  .byte $B3                       ;3/4 seconds
LB02B:  .byte $30                       ;C4
LB02C:  .byte $B2                       ;3/8 seconds
LB02D:  .byte $36                       ;D#4
LB02E:  .byte $2A                       ;A3
LB02F:  .byte $22                       ;F3
LB030:  .byte $B9                       ;1/8 seconds
LB031:  .byte $18                       ;C3
LB032:  .byte $2C                       ;A#3
LB033:  .byte $18                       ;C3
LB034:  .byte $B2                       ;3/8 seconds
LB035:  .byte $1C                       ;D3
LB036:  .byte $22                       ;F3
LB037:  .byte $2C                       ;A#3
LB038:  .byte $B9                       ;1/8 seconds
LB039:  .byte $18                       ;C3
LB03A:  .byte $22                       ;F3
LB03B:  .byte $2A                       ;A3
LB03C:  .byte $B3                       ;3/4 seconds
LB03D:  .byte $2E                       ;B3
LB03E:  .byte $2A                       ;A3
LB03F:  .byte $26                       ;G3
LB040:  .byte $34                       ;D4
LB041:  .byte $B2                       ;3/8 seconds
LB042:  .byte $36                       ;D#4
LB043:  .byte $3A                       ;F4
LB044:  .byte $28                       ;Ab3
LB045:  .byte $B9                       ;1/8 seconds
LB046:  .byte $26                       ;G3
LB047:  .byte $22                       ;F3
LB048:  .byte $1E                       ;D#3
LB049:  .byte $B2                       ;3/8 seconds
LB04A:  .byte $22                       ;F3
LB04B:  .byte $2C                       ;A#3
LB04C:  .byte $26                       ;G3
LB04D:  .byte $B9                       ;1/8 seconds
LB04E:  .byte $22                       ;F3
LB04F:  .byte $44                       ;A#4
LB050:  .byte $34                       ;D4
LB051:  .byte $B4                       ;1 1/2 seconds
LB052:  .byte $34                       ;D4
LB053:  .byte $B3                       ;3/4 seconds
LB054:  .byte $2E                       ;B3
LB055:  .byte $26                       ;G3
LB056:  .byte $00                       ;End Brinstar music

BrinstarSQ2IndexData:
LB057:  .byte $C2                       ;
LB058:  .byte $B2                       ;3/8 seconds    +
LB059:  .byte $0E                       ;G2             |
LB05A:  .byte $B9                       ;1/8 seconds    |
LB05B:  .byte $0E                       ;G2             |
LB05C:  .byte $06                       ;D2             |
LB05D:  .byte $0E                       ;G2             |
LB05E:  .byte $B2                       ;3/8 seconds    |
LB05F:  .byte $0E                       ;G2             |
LB060:  .byte $B9                       ;1/8 seconds    |
LB061:  .byte $0E                       ;G2             |
LB062:  .byte $06                       ;D2             |
LB063:  .byte $0E                       ;G2             | Repeat 2 times
LB064:  .byte $B2                       ;3/8 seconds    |
LB065:  .byte $14                       ;A#2            |
LB066:  .byte $B9                       ;1/8 seconds    |
LB067:  .byte $14                       ;A#2            |
LB068:  .byte $0A                       ;F2             |
LB069:  .byte $14                       ;A#2            |
LB06A:  .byte $B2                       ;3/8 seconds    |
LB06B:  .byte $14                       ;A#2            |
LB06C:  .byte $B9                       ;1/8 seconds    |
LB06D:  .byte $14                       ;A#2            |
LB06E:  .byte $0A                       ;F2             |
LB06F:  .byte $14                       ;A#2            +
LB070:  .byte $FF                       ;
LB071:  .byte $C3                       ;
LB072:  .byte $B4                       ;1 1/2 seconds  +
LB073:  .byte $3E                       ;G4             |
LB074:  .byte $B6                       ;1 3/16 seconds |
LB075:  .byte $44                       ;A#4            |
LB076:  .byte $B0                       ;3/32 seconds   | Repeat 3 times
LB077:  .byte $42                       ;A4             |
LB078:  .byte $44                       ;A#4            |
LB079:  .byte $42                       ;A4             |
LB07A:  .byte $3A                       ;F4             +
LB07B:  .byte $FF                       ;
LB07C:  .byte $B4                       ;1 1/2 seconds
LB07D:  .byte $3E                       ;G4
LB07E:  .byte $3E                       ;G4
LB07F:  .byte $C3                       ;
LB080:  .byte $B6                       ;1 3/16 seconds +
LB081:  .byte $48                       ;C5             |
LB082:  .byte $B2                       ;3/8 seconds    |
LB083:  .byte $3E                       ;G4             |
LB084:  .byte $B6                       ;1 3/16 seconds |
LB085:  .byte $44                       ;A#4            | Repeat 3 times
LB086:  .byte $B0                       ;3/32 seconds   |
LB087:  .byte $42                       ;A4             |
LB088:  .byte $44                       ;A#4            |
LB089:  .byte $42                       ;A4             |
LB08A:  .byte $3A                       ;F4             +
LB08B:  .byte $FF                       ;
LB08C:  .byte $B4                       ;1 1/2 seconds
LB08D:  .byte $3E                       ;G4
LB08E:  .byte $26                       ;G3
LB08F:  .byte $B6                       ;1 3/16 seconds
LB090:  .byte $42                       ;A4
LB091:  .byte $B9                       ;1/8 seconds
LB092:  .byte $42                       ;A4
LB093:  .byte $3E                       ;G4
LB094:  .byte $42                       ;A4
LB095:  .byte $B3                       ;3/4 seconds
LB096:  .byte $44                       ;A#4
LB097:  .byte $B2                       ;3/8 seconds
LB098:  .byte $3A                       ;F4
LB099:  .byte $B9                       ;1/8 seconds
LB09A:  .byte $30                       ;C4
LB09B:  .byte $3A                       ;F4
LB09C:  .byte $3E                       ;G4
LB09D:  .byte $B6                       ;1 3/16 seconds
LB09E:  .byte $42                       ;A4
LB09F:  .byte $B9                       ;1/8 seconds
LB0A0:  .byte $42                       ;A4
LB0A1:  .byte $3E                       ;G4
LB0A2:  .byte $42                       ;A4
LB0A3:  .byte $B3                       ;3/4 seconds
LB0A4:  .byte $44                       ;A#4
LB0A5:  .byte $B2                       ;3/8 seconds
LB0A6:  .byte $3A                       ;F4
LB0A7:  .byte $B9                       ;1/8 seconds
LB0A8:  .byte $3A                       ;F4
LB0A9:  .byte $44                       ;A#4
LB0AA:  .byte $48                       ;C5
LB0AB:  .byte $B4                       ;1 1/2 seconds
LB0AC:  .byte $4C                       ;D5
LB0AD:  .byte $B3                       ;3/4 seconds
LB0AE:  .byte $48                       ;C5
LB0AF:  .byte $46                       ;B4
LB0B0:  .byte $B6                       ;1 3/16 seconds
LB0B1:  .byte $48                       ;C5
LB0B2:  .byte $B9                       ;1/8 seconds
LB0B3:  .byte $4E                       ;D#5
LB0B4:  .byte $4C                       ;D5
LB0B5:  .byte $48                       ;C5
LB0B6:  .byte $B3                       ;3/4 seconds
LB0B7:  .byte $4C                       ;D5
LB0B8:  .byte $B2                       ;3/8 seconds
LB0B9:  .byte $44                       ;A#4
LB0BA:  .byte $B9                       ;1/8 seconds
LB0BB:  .byte $44                       ;A#4
LB0BC:  .byte $4C                       ;D5
LB0BD:  .byte $52                       ;F5
LB0BE:  .byte $B4                       ;1 1/2 seconds
LB0BF:  .byte $54                       ;F#5
LB0C0:  .byte $54                       ;F#5

BrinstarTriangleIndexData:
LB0C1:  .byte $C4                       ;
LB0C2:  .byte $B4                       ;1 1/2 seconds  + Repeat 4 times
LB0C3:  .byte $02                       ;No sound       +
LB0C4:  .byte $FF                       ;
LB0C5:  .byte $C3                       ;
LB0C6:  .byte $B2                       ;3/8 seconds    +
LB0C7:  .byte $26                       ;G3             |
LB0C8:  .byte $B9                       ;1/8 seconds    |
LB0C9:  .byte $26                       ;G3             |
LB0CA:  .byte $3E                       ;G4             |
LB0CB:  .byte $34                       ;D4             |
LB0CC:  .byte $B2                       ;3/8 seconds    |
LB0CD:  .byte $26                       ;G3             |
LB0CE:  .byte $B9                       ;1/8 seconds    |
LB0CF:  .byte $26                       ;G3             |
LB0D0:  .byte $34                       ;D4             | Repeat 3 times
LB0D1:  .byte $26                       ;G3             |
LB0D2:  .byte $B2                       ;3/8 seconds    |
LB0D3:  .byte $2C                       ;A#3            |
LB0D4:  .byte $B9                       ;1/8 seconds    |
LB0D5:  .byte $2C                       ;A#3            |
LB0D6:  .byte $3A                       ;F4             |
LB0D7:  .byte $2C                       ;A#3            |
LB0D8:  .byte $B2                       ;3/8 seconds    |
LB0D9:  .byte $2C                       ;A#3            |
LB0DA:  .byte $B9                       ;1/8 seconds    |
LB0DB:  .byte $2C                       ;A#3            |
LBoDC:  .byte $3A                       ;F4             |
LB0DD:  .byte $2C                       ;A#3            +
LB0DE:  .byte $FF                       ;
LB0DF:  .byte $C4                       ;
LB0E0:  .byte $B2                       ;3/8 seconds    +
LB0E1:  .byte $26                       ;G3             |
LB0E2:  .byte $B9                       ;1/8 seconds    | Repeat 4 times
LB0E3:  .byte $34                       ;D4             |
LB0E4:  .byte $26                       ;G3             |
LB0E5:  .byte $26                       ;G3             +
LB0E6:  .byte $FF                       ;
LB0E7:  .byte $D0                       ;
LB0E8:  .byte $B9                       ;1/8 seconds    +                               
LB0E9:  .byte $18                       ;C3             |
LB0EA:  .byte $26                       ;G3             | Repeat 16 times
LB0EB:  .byte $18                       ;C3             |
LB0EC:  .byte $B2                       ;3/8 seconds    |
LB0ED:  .byte $18                       ;C3             +
LB0EE:  .byte $FF                       ;
LB0EF:  .byte $C2                       ;
LB0F0:  .byte $B2                       ;3/8 seconds    +
LB0F1:  .byte $1E                       ;D#3            |
LB0F2:  .byte $B9                       ;1/8 seconds    |
LB0F3:  .byte $1E                       ;D#3            |
LB0F4:  .byte $18                       ;C3             |
LB0F5:  .byte $1E                       ;D#3            |
LB0F6:  .byte $B2                       ;3/8 seconds    |
LB0F7:  .byte $1E                       ;D#3            |
LB0F8:  .byte $B9                       ;1/8 seconds    |
LB0F9:  .byte $1E                       ;D#3            |
LB0FA:  .byte $18                       ;C3             | Repeat 2 times
LB0FB:  .byte $1E                       ;D#3            |
LB0FC:  .byte $B2                       ;3/8 seconds    |
LB0FD:  .byte $1C                       ;D3             |
LB0FE:  .byte $B9                       ;1/8 seconds    |
LB0FF:  .byte $1C                       ;D3             |
LB100:  .byte $14                       ;A#2            |
LB101:  .byte $1C                       ;D3             |
LB102:  .byte $B2                       ;3/8 seconds    |
LB103:  .byte $1C                       ;D3             |
LB104:  .byte $B9                       ;1/8 seconds    |
LB105:  .byte $1C                       ;D3             |
LB106:  .byte $14                       ;A#2            |
LB107:  .byte $1C                       ;D3             +
LB108:  .byte $FF                       ;
LB109:  .byte $B2                       ;3/8 seconds
LB10A:  .byte $26                       ;G3
LB10B:  .byte $12                       ;A2
LB10C:  .byte $16                       ;B2
LB10D:  .byte $18                       ;C3
LB10E:  .byte $1C                       ;D3
LB10F:  .byte $20                       ;E3
LB110:  .byte $24                       ;F#3
LB111:  .byte $26                       ;G3
LB112:  .byte $B2                       ;3/8 seconds
LB113:  .byte $28                       ;Ab3
LB114:  .byte $B9                       ;1/8 seconds
LB115:  .byte $28                       ;Ab3
LB116:  .byte $1E                       ;D#3
LB117:  .byte $18                       ;C3
LB118:  .byte $B2                       ;3/8 seconds
LB119:  .byte $10                       ;Ab2
LB11A:  .byte $B9                       ;1/8 seconds
LB11B:  .byte $30                       ;C4
LB11C:  .byte $2C                       ;A#3
LB11D:  .byte $28                       ;Ab3
LB11E:  .byte $B2                       ;3/8 seconds
LB11F:  .byte $1E                       ;D#3
LB120:  .byte $1C                       ;D3
LB121:  .byte $18                       ;C3
LB122:  .byte $14                       ;A#2
LB123:  .byte $2A                       ;A3
LB124:  .byte $2A                       ;A3
LB125:  .byte $2A                       ;A3
LB126:  .byte $2A                       ;A3
LB127:  .byte $CC                       ;
LB128:  .byte $B9                       ;1/8 seconds    + Repeat 12 times
LB129:  .byte $2A                       ;A3             +
LB12A:  .BYTE $FF                       ;

BrinstarNoiseIndexData:
LB12B:  .byte $E8                       ;
LB12C:  .byte $B2                       ;3/8 seconds    +
LB12D:  .byte $04                       ;Drumbeat 01    |
LB12E:  .byte $04                       ;Drumbeat 01    |
LB12F:  .byte $04                       ;Drumbeat 01    | Repeat 40 times
LB130:  .byte $B9                       ;1/8 seconds    |
LB131:  .byte $04                       ;Drumbeat 01    |
LB132:  .byte $04                       ;Drumbeat 01    |
LB133:  .byte $04                       ;Drumbeat 01    +
LB134:  .byte $FF                       ;

.advance $B200, $00

.include "AreaCommonII.asm"

.advance $C000, $00