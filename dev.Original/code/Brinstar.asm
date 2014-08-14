; -------------------
; METROID source code
; -------------------
; MAIN PROGRAMMERS
;     HAI YUKAMI
;   ZARU SOBAJIMA
;    GPZ SENGOKU
;    N.SHIOTANI
;     M.HOUDAI
; (C) 1986 NINTENDO
; 
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Disassembled using TRaCER.
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Brinstar (memory page 1)

.org $8000

.include "Defines.asm"

;--------------------------------------[ Forward declarations ]--------------------------------------

.alias startup			$C01A
.alias NMI			$C0D9
.alias ChooseRoutine		$C27C
.alias Adiv32			$C2BE
.alias Amul16			$C2C5
.alias TwosCompliment		$C3D4
.alias Base10Subtract		$C3FB
.alias SubtractHealth		$CE92
.alias SetProjectileAnim	$D2FA
.alias UpdateEnemyAnim		$E094
.alias VerticalRoomCentered	$E21B

;-----------------------------------------[ Start of code ]------------------------------------------

L8000:	JMP $F410
L8003:	JMP $F438
L8006:	JMP $F416
L8009:	JMP $F852
L800C:	JMP UpdateEnemyAnim		;($E094)
L800F:	JMP $F68D
L8012:	JMP $F83E
L8015:	JMP $F85A
L8018:	JMP $FBB9
L801B:	JMP $FB88
L801E:	JMP $FBCA
L8021:	JMP $F870
L8024:	JMP ChooseRoutine		;($C27C)
L8027:	JMP $FD8F
L802A:	JMP $EB6E
L802D:	JMP $8244
L8030:	JMP $8318
L8033:	JMP $FA1E
L8036:	JMP $833F
L8039:	JMP $8395
L803C:	JMP $DD8B
L803F:	JMP $FEDC
L8042:	JMP SubtractHealth		;($CE92)
L8045:	JMP Base10Subtract		;($C3FB)

L8048:	.word $84FD, $84A6, $844A, $844A, $84A6, $84FD, $83F4, $83F4

L8058:	LDX PageIndex
L805A:	LDA $0405,X
L805D:	ASL 
L805E:	BMI ++++++++
L8060:	LDA EnStatus,X
L8063:	CMP #$02
L8065:	BNE ++++++++
L8067:	JSR $8244
L806A:	LDA $00
L806C:	BPL ++
L806E:	JSR TwosCompliment		;($C3D4)
L8071:	STA $66
L8073:*	JSR $83F5
L8076:	JSR $80B8
L8079:	DEC $66
L807B:	BNE -
L807D:*	BEQ ++
L807F:	STA $66
L8081:*	JSR $844B
L8084:	JSR $80FB
L8087:	DEC $66
L8089:	BNE -
L808B:*	JSR $8318
L808E:	LDA $00
L8090:	BPL ++
L8092:	JSR TwosCompliment		;($C3D4)
L8095:	STA $66
L8097:*	JSR $84A7
L809A:	JSR $816E
L809D:	DEC $66
L809F:	BNE -
L80A1:*	BEQ ++
L80A3:	STA $66
L80A5:*	JSR $84FE
L80A8:	JSR $8134
L80AB:	DEC $66
L80AD:	BNE -
L80AF:*	RTS
 
L80B0:	LDY EnDataIndex,X
L80B3:	LDA $977B,Y
L80B6:	ASL				;*2 
L80B7:	RTS

L80B8:	LDX PageIndex
L80BA:	BCS $80FA
L80BC:	LDA $0405,X
L80BF:	BPL $80C7
L80C1:	JSR $81FC
L80C4:	JMP $80F6
L80C7:	JSR $80B0
L80CA:	BPL $80EA
L80CC:	LDA $6B03,X
L80CF:	BEQ $80C1
L80D1:	BPL $80D8
L80D3:	JSR $81B1
L80D6:	BEQ $80E2
L80D8:	SEC 
L80D9:	ROR $0402,X
L80DC:	ROR EnCounter,X
L80DF:	JMP $80F6
L80E2:	STA $0402,X
L80E5:	STA EnCounter,X
L80E8:	BEQ $80F6
L80EA:	LDA $977B,Y
L80ED:	LSR 
L80EE:	LSR 
L80EF:	BCC $80F6
L80F1:	LDA #$04
L80F3:	JSR $856B
L80F6:	LDA #$01
L80F8:	STA $66
L80FA:	RTS
 
L80FB:	LDX PageIndex
L80FD:	BCS $8133
L80FF:	LDA $0405,X
L8102:	BPL $810A
L8104:	JSR $81FC
L8107:	JMP $812F
L810A:	JSR $80B0
L810D:	BPL $8123
L810F:	LDA $6B03,X
L8112:	BEQ $8104
L8114:	BPL $8120
L8116:	CLC 
L8117:	ROR $0402,X
L811A:	ROR EnCounter,X
L811D:	JMP $812F
L8120:	JSR $81B1
L8123:	LDA $977B,Y
L8126:	LSR 
L8127:	LSR 
L8128:	BCC $812F
L812A:	LDA #$04
L812C:	JSR $856B
L812F:	LDA #$01
L8131:	STA $66
L8133:	RTS
 
L8134:	LDX PageIndex
L8136:	BCS $816D
L8138:	JSR $80B0
L813B:	BPL $815E
L813D:	LDA $0405,X
L8140:	BMI $8148
L8142:	JSR $81C7
L8145:	JMP $8169
L8148:	LDA $6B03,X
L814B:	BEQ $8142
L814D:	BPL $8159
L814F:	CLC 
L8150:	ROR $0403,X
L8153:	ROR $0407,X
L8156:	JMP $8169
L8159:	JSR $81C0
L815C:	BEQ $8169
L815E:	LDA $977B,Y
L8161:	LSR 
L8162:	BCC $8169
L8164:	LDA #$01
L8166:	JSR $856B
L8169:	LDA #$01
L816B:	STA $66
L816D:	RTS

L816E:	LDX PageIndex
L8170:	BCS $81B0
L8172:	JSR $80B0
L8175:	BPL $81A0
L8177:	LDA $0405,X
L817A:	BMI $8182
L817C:	JSR $81C7
L817F:	JMP $81AC
L8182:	LDA $6B03,X
L8185:	BEQ $817C
L8187:	BPL $818E
L8189:	JSR $81C0
L818C:	BEQ $8198
L818E:	SEC 
L818F:	ROR $0403,X
L8192:	ROR $0407,X
L8195:	JMP $81AC
L8198:	STA $0403,X
L819B:	STA $0407,X
L819E:	BEQ $81AC
L81A0:	JSR $80B0
L81A3:	LSR 
L81A4:	LSR 
L81A5:	BCC $81AC
L81A7:	LDA #$01
L81A9:	JSR $856B
L81AC:	LDA #$01
L81AE:	STA $66
L81B0:	RTS
 
L81B1:	JSR $81B8
L81B4:	STA $6AFE,X
L81B7:	RTS

L81B8:	LDA #$20
L81BA:	JSR $F744
L81BD:	LDA #$00
L81BF:	RTS

L81C0:	JSR $81B8
L81C3:	STA $6AFF,X
L81C6:	RTS

L81C7:	JSR $81F6
L81CA:	BNE $81F5
L81CC:	LDA #$01
L81CE:	JSR $856B
L81D1:	LDA $6AFF,X
L81D4:	JSR $C3D4
L81D7:	STA $6AFF,X

L81DA:	JSR $81F6
L81DD:	BNE $81F5
L81DF:	JSR $80B0
L81E2:	SEC 
L81E3:	BPL $81ED
L81E5:	LDA #$00
L81E7:	SBC $0407,X
L81EA:	STA $0407,X
L81ED:	LDA #$00
L81EF:	SBC $0403,X
L81F2:	STA $0403,X
L81F5:	RTS

L81F6:	JSR $F74B
L81F9:	AND #$20
L81FB:	RTS

L81FC:	JSR $81F6
L81FF:	BNE $81F5
L8201:	LDA #$04
L8203:	JSR $856B
L8206:	LDA $6AFE,X
L8209:	JSR $C3D4
L820C:	STA $6AFE,X

L820F:	JSR $81F6
L8212:	BNE $822A
L8214:	JSR $80B0
L8217:	SEC 
L8218:	BPL $8222
L821A:	LDA #$00
L821C:	SBC EnCounter,X
L821F:	STA EnCounter,X
L8222:	LDA #$00
L8224:	SBC $0402,X
L8227:	STA $0402,X
L822A:	RTS 

L822B:	LDA $0405,X
L822E:	BPL $8232
L8230:	LSR 
L8231:	LSR 
L8232:	LSR 
L8233:	LDA $0408,X
L8236:	ROL 
L8237:	ASL 
L8238:	TAY 
L8239:	LDA $96DB,Y
L823C:	STA $81
L823E:	LDA $96DC,Y
L8241:	STA $82
L8243:	RTS

L8244:	JSR $80B0
L8247:	BPL $824C
L8249:	JMP $833F
L824C:	LDA $0405,X
L824F:	AND #$20
L8251:	EOR #$20
L8253:	BEQ $82A2
L8255:	JSR $822B
L8258:	LDY EnCounter,X
L825B:	LDA ($81),Y
L825D:	CMP #$F0
L825F:	BCC $827F
L8261:	CMP #$FA
L8263:	BEQ $827C
L8265:	CMP #$FB
L8267:	BEQ $82B0
L8269:	CMP #$FC
L826B:	BEQ $82B3
L826D:	CMP #$FD
L826F:	BEQ $82A5
L8271:	CMP #$FE
L8273:	BEQ $82DE
L8275:	LDA #$00
L8277:	STA EnCounter,X
L827A:	BEQ $8258
L827C:	JMP $8312
L827F:	SEC 
L8280:	SBC EnDelay,X
L8283:	BNE $8290
L8285:	STA EnDelay,X
L8288:	INY 
L8289:	INY 
L828A:	TYA 
L828B:	STA EnCounter,X
L828E:	BNE $825B
L8290:	INC EnDelay,X
L8293:	INY 
L8294:	LDA ($81),Y
L8296:	ASL 
L8297:	PHP 
L8298:	JSR Adiv32			;($C2BE)Divide by 32.
L829B:	PLP 
L829C:	BCC $82A2
L829E:	EOR #$FF
L82A0:	ADC #$00
L82A2:	STA $00
L82A4:	RTS

L82A5:	INC EnCounter,X
L82A8:	INY 
L82A9:	LDA #$00
L82AB:	STA $6B01,X
L82AE:	BEQ $825B
L82B0:	PLA 
L82B1:	PLA 
L82B2:	RTS

L82B3:	LDA $6B03,X
L82B6:	BPL $82BE
L82B8:	JSR $E770
L82BB:	JMP $82C3
L82BE:	BEQ $82D2
L82C0:	JSR $E77B
L82C3:	LDX PageIndex
L82C5:	BCS $82D2
L82C7:	LDY EnCounter,X
L82CA:	INY 
L82CB:	LDA #$00
L82CD:	STA $6B03,X
L82D0:	BEQ $82D7
L82D2:	LDY EnCounter,X
L82D5:	DEY 
L82D6:	DEY 
L82D7:	TYA 
L82D8:	STA EnCounter,X
L82DB:	JMP $825B
L82DE:	DEY 
L82DF:	DEY 
L82E0:	TYA 
L82E1:	STA EnCounter,X
L82E4:	LDA $6B03,X
L82E7:	BPL $82EF
L82E9:	JSR $E770
L82EC:	JMP $82F4
L82EF:	BEQ $82FB
L82F1:	JSR $E77B
L82F4:	LDX PageIndex
L82F6:	BCC $82FB
L82F8:	JMP $8258
L82FB:	LDY EnDataIndex,X
L82FE:	LDA $968B,Y
L8301:	AND #$20
L8303:	BEQ $8312
L8305:	LDA $0405,X
L8308:	EOR #$05
L830A:	ORA $968B,Y
L830D:	AND #$1F
L830F:	STA $0405,X
L8312:	JSR $81B1
L8315:	JMP $82A2
L8318:	JSR $80B0
L831B:	BPL $8320
L831D:	JMP $8395
L8320:	LDA $0405,X
L8323:	AND #$20
L8325:	EOR #$20
L8327:	BEQ $833C
L8329:	LDY EnCounter,X
L832C:	INY 
L832D:	LDA ($81),Y
L832F:	TAX 
L8330:	AND #$08
L8332:	PHP 
L8333:	TXA 
L8334:	AND #$07
L8336:	PLP 
L8337:	BEQ $833C
L8339:	JSR $C3D4
L833C:	STA $00
L833E:	RTS

L833F:	LDY #$0E
L8341:	LDA $6AFE,X
L8344:	BMI $835E
L8346:	CLC 
L8347:	ADC EnCounter,X
L834A:	STA EnCounter,X
L834D:	LDA $0402,X
L8350:	ADC #$00
L8352:	STA $0402,X
L8355:	BPL $8376
L8357:	JSR $C3D4
L835A:	LDY #$F2
L835C:	BNE $8376
L835E:	JSR $C3D4
L8361:	SEC 
L8362:	STA $00
L8364:	LDA EnCounter,X
L8367:	SBC $00
L8369:	STA EnCounter,X
L836C:	LDA $0402,X
L836F:	SBC #$00
L8371:	STA $0402,X
L8374:	BMI $8357
L8376:	CMP #$0E
L8378:	BCC $8383
L837A:	LDA #$00
L837C:	STA EnCounter,X
L837F:	TYA 
L8380:	STA $0402,X
L8383:	LDA $6AFC,X
L8386:	CLC 
L8387:	ADC EnCounter,X
L838A:	STA $6AFC,X
L838D:	LDA #$00
L838F:	ADC $0402,X
L8392:	STA $00
L8394:	RTS

L8395:	LDA #$00
L8397:	STA $00
L8399:	STA $02
L839B:	LDA #$0E
L839D:	STA $01
L839F:	STA $03
L83A1:	LDA $0407,X
L83A4:	CLC 
L83A5:	ADC $6AFF,X
L83A8:	STA $0407,X
L83AB:	STA $04
L83AD:	LDA #$00
L83AF:	LDY $6AFF,X
L83B2:	BPL $83B6
L83B4:	LDA #$FF
L83B6:	ADC $0403,X
L83B9:	STA $0403,X
L83BC:	TAY 
L83BD:	BPL $83D0
L83BF:	LDA #$00
L83C1:	SEC 
L83C2:	SBC $0407,X
L83C5:	STA $04
L83C7:	LDA #$00
L83C9:	SBC $0403,X
L83CC:	TAY 
L83CD:	JSR $E449
L83D0:	LDA $04
L83D2:	CMP $02
L83D4:	TYA 
L83D5:	SBC $03
L83D7:	BCC $83E3
L83D9:	LDA $00
L83DB:	STA $0407,X
L83DE:	LDA $01
L83E0:	STA $0403,X
L83E3:	LDA $6AFD,X
L83E6:	CLC 
L83E7:	ADC $0407,X
L83EA:	STA $6AFD,X
L83ED:	LDA #$00
L83EF:	ADC $0403,X
L83F2:	STA $00
L83F4:	RTS

L83F5:	LDX PageIndex
L83F7:	LDA EnYRoomPos,X
L83FA:	SEC 
L83FB:	SBC EnRadY,X
L83FE:	AND #$07
L8400:	SEC 
L8401:	BNE $8406
L8403:	JSR $E770
L8406:	LDY #$00
L8408:	STY $00
L840A:	LDX PageIndex
L840C:	BCC $844A
L840E:	INC $00
L8410:	LDY EnYRoomPos,X
L8413:	BNE $8429
L8415:	LDY #$F0
L8417:	LDA $49
L8419:	CMP #$02
L841B:	BCS $8429
L841D:	LDA $FC
L841F:	BEQ $844A
L8421:	JSR $8563
L8424:	BEQ $844A
L8426:	JSR $855A
L8429:	DEY 
L842A:	TYA 
L842B:	STA EnYRoomPos,X
L842E:	CMP EnRadY,X
L8431:	BNE $8441
L8433:	LDA $FC
L8435:	BEQ $843C
L8437:	JSR $8563
L843A:	BNE $8441
L843C:	INC EnYRoomPos,X
L843F:	CLC 
L8440:	RTS

L8441:	LDA $0405,X
L8444:	BMI $8449
L8446:	INC $6B01,X
L8449:	SEC 
L844A:	RTS

L844B:	LDX PageIndex
L844D:	LDA EnYRoomPos,X
L8450:	CLC 
L8451:	ADC EnRadY,X
L8454:	AND #$07
L8456:	SEC 
L8457:	BNE $845C
L8459:	JSR $E77B
L845C:	LDY #$00
L845E:	STY $00
L8460:	LDX PageIndex
L8462:	BCC $84A6
L8464:	INC $00
L8466:	LDY EnYRoomPos,X
L8469:	CPY #$EF
L846B:	BNE $8481
L846D:	LDY #$FF
L846F:	LDA $49
L8471:	CMP #$02
L8473:	BCS $8481
L8475:	LDA $FC
L8477:	BEQ $84A6
L8479:	JSR $8563
L847C:	BNE $84A6
L847E:	JSR $855A
L8481:	INY 
L8482:	TYA 
L8483:	STA EnYRoomPos,X
L8486:	CLC 
L8487:	ADC EnRadY,X
L848A:	CMP #$EF
L848C:	BNE $849D
L848E:	LDA $FC
L8490:	BEQ $8497
L8492:	JSR $8563
L8495:	BEQ $849D
L8497:	DEC EnYRoomPos,X
L849A:	CLC 
L849B:	BCC $84A6
L849D:	LDA $0405,X
L84A0:	BMI $84A5
L84A2:	DEC $6B01,X
L84A5:	SEC 
L84A6:	RTS

L84A7:	LDX PageIndex
L84A9:	LDA EnXRoomPos,X
L84AC:	SEC 
L84AD:	SBC EnRadX,X
L84B0:	AND #$07
L84B2:	SEC 
L84B3:	BNE $84B8
L84B5:	JSR $E8F1
L84B8:	LDY #$00
L84BA:	STY $00
L84BC:	LDX PageIndex
L84BE:	BCC $84FD
L84C0:	INC $00
L84C2:	LDY EnXRoomPos,X
L84C5:	BNE $84DA
L84C7:	LDA $49
L84C9:	CMP #$02
L84CB:	BCC $84DA
L84CD:	LDA $FD
L84CF:	BEQ $84D4
L84D1:	JSR $8563
L84D4:	CLC 
L84D5:	BEQ $84FD
L84D7:	JSR $855A
L84DA:	DEC EnXRoomPos,X
L84DD:	LDA EnXRoomPos,X
L84E0:	CMP EnRadX,X
L84E3:	BNE $84F4
L84E5:	LDA $FD
L84E7:	BEQ $84EE
L84E9:	JSR $8563
L84EC:	BNE $84F4
L84EE:	INC EnXRoomPos,X
L84F1:	CLC 
L84F2:	BCC $84FD
L84F4:	LDA $0405,X
L84F7:	BPL $84FC
L84F9:	INC $6B01,X
L84FC:	SEC 
L84FD:	RTS

L84FE:	LDX PageIndex
L8500:	LDA EnXRoomPos,X
L8503:	CLC 
L8504:	ADC EnRadX,X
L8507:	AND #$07
L8509:	SEC 
L850A:	BNE $850F
L850C:	JSR $E8FC
L850F:	LDY #$00
L8511:	STY $00
L8513:	LDX PageIndex
L8515:	BCC $8559
L8517:	INC $00
L8519:	INC EnXRoomPos,X
L851C:	BNE $8536
L851E:	LDA $49
L8520:	CMP #$02
L8522:	BCC $8536
L8524:	LDA $FD
L8526:	BEQ $852D
L8528:	JSR $8563
L852B:	BEQ $8533
L852D:	DEC EnXRoomPos,X
L8530:	CLC 
L8531:	BCC $8559
L8533:	JSR $855A
L8536:	LDA EnXRoomPos,X
L8539:	CLC 
L853A:	ADC EnRadX,X
L853D:	CMP #$FF
L853F:	BNE $8550
L8541:	LDA $FD
L8543:	BEQ $854A
L8545:	JSR $8563
L8548:	BEQ $8550
L854A:	DEC EnXRoomPos,X
L854D:	CLC 
L854E:	BCC $8559
L8550:	LDA $0405,X
L8553:	BPL $8558
L8555:	DEC $6B01,X
L8558:	SEC 
L8559:	RTS

L855A:	LDA EnNameTable,X
L855D:	EOR #$01
L855F:	STA EnNameTable,X
L8562:	RTS

L8563:	LDA EnNameTable,X
L8566:	EOR $FF
L8568:	AND #$01
L856A:	RTS

L856B:	EOR $0405,X
L856E:	STA $0405,X
L8571:	RTS 

;---------------------------------[ Object animation data tables ]----------------------------------

;The following tables are indices into the FramePtrTable that correspond to various animations. The
;FramePtrTable represents individual frames and the entries in ObjectAnimIndexTbl are the groups of
;frames responsible for animaton Samus, her weapons and other objects.

ObjectAnimIndexTbl:

;Samus run animation.
L8572:	.byte $03, $04, $05, $FF

;Samus front animation.
L8576:	.byte $07, $FF

;Samus jump out of ball animation.
L8578:	.byte $17

;Samus Stand animation.
L8579:	.byte $08, $FF

;Samus stand and fire animation.
L857B:	.byte $22, $FF

;Samus stand and jump animation.
L857D:	.byte $04

;Samus Jump animation.
L857E:	.byte $10, $FF

;Samus summersault animation.
L8580:	.byte $17, $18, $19, $1A, $FF

;Samus run and jump animation.
L8585:	.byte $03, $17, $FF

;Samus roll animation.
L8588:	.byte $1E, $1D, $1C, $1B, $FF

;Bullet animation.
L858D:	.byte $28, $FF

;Bullet hit animation.
L858F:	.byte $2A, $F7, $FF

;Samus jump and fire animation.
L8592:	.byte $12, $FF

;Samus run and fire animation.
L8594:	.byte $0C, $0D, $0E, $FF

;Samus point up and shoot animation.
L8598:	.byte $30 

;Samus point up animation.
L8599:	.byte $2B, $FF

;Door open animation.
L859B:	.byte $31, $31, $33, $F7, $FF

;Door close animation.
L85A0:	.byte $33, $33, $31, $FF

;Samus explode animation.
L85A4: .byte $35, $FF

;Samus jump and point up animation.
L85A6: .byte $39, $38, $FF

;Samus run and point up animation.
L85A9:	.byte $40, $41, $42, $FF

;Samus run, point up and shoot animation 1.
L85AD:	.byte $46, $FF

;Samus run, point up and shoot animation 2.
L85AF:	.byte $47, $FF

;Samus run, point up and shoot animation 3.
L85B1:	.byte $48, $FF

;Samus on elevator animation 1.
L85B3:	.byte $07, $F7, $F7, $07, $F7, $F7, $F7, $07, $F7, $F7, $F7, $F7, $07, $F7, $FF

;Samus on elevator animation 2.
L85C2:	.byte $23, $F7, $F7, $23, $F7, $F7, $F7, $23, $F7, $F7, $F7, $F7, $23, $F7, $FF

;Samus on elevator animation 3.
L85D1:	.byte $07, $F7, $F7, $F7, $F7, $07, $F7, $F7, $F7, $07, $F7, $F7, $07, $F7, $FF

;Samus on elevator animation 4.
L85E0:	.byte $23, $F7, $F7, $F7, $F7, $23, $F7, $F7, $F7, $23, $F7, $F7, $23, $F7, $FF

;Wave beam animation.
L85EF:	.byte $4B, $FF

;Bomb tick animation.
L85F1:	.byte $4E, $4F, $FF

;Bomb explode animation.
L85F4:	.byte $3C, $4A, $49, $4A, $4D, $4A, $4D, $F7, $FF

;Missile left animation.
L85FD:	.byte $26, $FF

;Missile right animation.
L85FF:	.byte $25, $FF

;Missile up animation.
L8601:	.byte $27, $FF

;Missile explode animation.
L8603:	.byte $67, $67, $67, $68, $68, $69, $F7, $FF

;----------------------------[ Sprite drawing pointer tables ]--------------------------------------

;The above animation pointers provide an index into the following table
;for the animation sequences.

FramePtrTable:
L860B:	.word $87CB, $87CB, $87CB, $87CB, $87DD, $87F0, $8802, $8802
L861B:	.word $8818, $882C, $882C, $882C, $882C, $883E, $8851, $8863
L862B:	.word $8863, $8874, $8874, $8885, $8885, $8885, $8885, $8885
L863B:	.word $888F, $8899, $88A3, $88AD, $88B8, $88C3, $88CE, $88D9
L864B:	.word $88D9, $88D9, $88D9, $88EE, $88F8, $88F8, $88FE, $8904
L865B:	.word $890A, $890F, $890F, $8914, $8928, $8928, $8928, $8928
L866B:	.word $8928, $893C, $8948, $8948, $8954, $8954, $8961, $8961
L867B:	.word $8961, $8974, $8987, $8987, $8987, $8995, $8995, $8995
L868B:	.word $8995, $89A9, $89BE, $89D2, $89D2, $89D2, $89D2, $89E6
L869B:	.word $89FB, $8A0F, $8A1D, $8A21, $8A26, $8A26, $8A3C, $8A41
L86AB:	.word $8A46, $8A4E, $8A56, $8A5E, $8A66, $8A6E, $8A76, $8A7E
L86BB:	.word $8A86, $8A8E, $8A9C, $8AA1, $8AA6, $8AAE, $8ABA, $8AC4
L86CB:	.word $8AC4, $8AC4, $8AC4, $8AC4, $8AC4, $8AC4, $8AD8, $8AE9
L86DB:	.word $8AF3, $8B03

;The following table provides pointers to data used for the placement of the sprites that make up
;Samus and other non-enemy objects.

PlacePtrTable:
L86DF:	.word $8701, $871F, $872B, $8737, $8747, $8751, $86FD, $875D
L86EF:	.word $8775, $878D, $8791, $8799, $87A5, $8749, $87B1

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
L86FD:	.byte $E8, $FC, $EA, $FC

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
L8701:	.byte $F0, $F8, $F0, $00, $F8, $F0, $F8, $F8, $F8, $00, $00, $F8, $00, $00, $00, $08
;              +--8--+   +--9--+   +--A--+   +--B--+   +--C--+   +--D--+   +--E--+
L8711:	.byte $08, $F8, $08, $00, $08, $08, $F8, $F4, $F8, $F6, $EC, $F4, $EE, $F4

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
L871F:	.byte $F3, $F8, $F3, $00, $FB, $F8, $FB, $00, $03, $F8, $03, $00 

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
L872B:	.byte $F8, $F6, $F8, $FE, $F8, $06, $00, $F6, $00, $FE, $00, $06

;Elevator frame.
;          +--------+--------+--------+--------+--------+--------+--------+--------+
;          |        |        |        |        |        |        |        |        |
;          |        |        |        |        |        |        |        |        |
;          |        |        *        |        |        |        |        |        |
;          |       0|       1|       2|       3|       4|       5|       6|       7|
;          +--------+--------+--------+--------+--------+--------+--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+   +--4--+   +--5--+   +--6--+   +--7--+
L8737:	.byte $FC, $F0, $FC, $F8, $FC, $00, $FC, $08, $FC, $10, $FC, $18, $FC, $20, $FC, $28

;Several projectile frames.
;          +--------+
;          |        |
;          |        |
;          |    *   |
;          |       0|
;          +--------+
;              +--0--+
L8747:	.byte $FC, $FC

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
L8749:	.byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

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
L8751:	.byte $E8, $00, $F0, $00, $F8, $00, $00, $00, $08, $00, $10, $00 

;Samus explode. Special case. The bytes that are #$8X indicate displacement data will be loaded
;from a table for the y direction and from a counter for the x direction.  The initial displacement
;bytes start at $8769.  If the LSB is clear in the bytes where the upper nibble is #$8, those
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
L875D:	.byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
;              +--2--+   +--3--+   +--4--+   +--5--+
L876D:	.byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

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
L8775:	.byte $F0, $00, $F0, $08, $F8, $08, $F0, $F0, $F0, $F8, $F8, $F0, $00, $F0, $08, $F0
;              +--8--+   +--9--+   +--A--+   +--B--+
L8785:	.byte $08, $F8, $00, $08, $08, $00, $08, $08

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
L878D:	.byte $F8, $FC, $00, $FC

;Missile left/right and missile explode frames.
;          +--------+--------+        +--------+--------+
;          |        |        |        |        |        |
;          |        |        |        |        |        |
;          |        *        |        |        |        |
;          |       0|       1|        |       2|       3|
;          +--------+--------+        +--------+--------+
;              +--0--+   +--1--+   +--2--+   +--3--+
L8791:	.byte $FC, $F8, $FC, $00, $FC, $10, $FC, $18

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
L8799:	.byte $FC, $F0, $F4, $F8, $F4, $00, $FC, $08, $04, $F8, $04, $00

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
L87A5:	.byte $FC, $E8, $EC, $F0, $EC, $08, $FC, $10, $0C, $F0, $0C, $08

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
L87B1:	.byte $00, $F8, $00, $00, $08, $F8, $08, $00, $E8, $F0, $E8, $F8, $E8, $00, $F0, $F0
;              +--8--+   +--9--+   +--A--+   +--B--+   +--C--+
L87C1:	.byte $F0, $F8, $F0, $00, $F8, $F0, $F8, $F8, $F8, $00

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
L87CB:	.byte $40, $0F, $04, $00, $01, $FD, $20, $FE, $41, $40, $FD, $60, $20, $21, $FE, $FE
L87DB:	.byte $31, $FF

;Samus run.
L87DD:	.byte $40, $0F, $04, $02, $03, $FD, $20, $FE, $43, $42, $FD, $60, $22, $23, $FE, $32
L87ED:	.byte $33, $34, $FF

;Samus run.
L87F0:	.byte $40, $0F, $04, $05, $06, $FD, $20, $FE, $45, $44, $FD, $60, $25, $26, $27, $35
L8800:	.byte $36, $FF

;Samus facing forward.
L8802:	.byte $00, $0F, $04, $09, $FD, $60, $09, $FD, $20, $FE, $19, $1A, $FD, $20, $29, $2A
L8812:	.byte $FE, $39, $FD, $60, $39, $FF

;Samus stand.
L8818:	.byte $40, $0F, $04, $FD, $20, $0E, $0D, $FE, $1E, $1D, $2E, $2D, $FE, $FD, $60, $3B
L8828:	.byte $3C, $FE, $17, $FF

;Samus run and fire.
L882C:	.byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $20, $21, $FE, $FE
L883C:	.byte $31, $FF

;Samus run and fire.
L883E:	.byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $22, $23, $FE, $32
L884E:	.byte $33, $34, $FF

;Samus run and fire.
L8851:	.byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $25, $26, $27, $35
L8861:	.byte $36, $FF

;Samus stand and jump.
L8863:	.byte $40, $0F, $04, $00, $01, $FD, $20, $FE, $41, $40, $FD, $60, $22, $07, $08, $32
L8873:	.byte $FF

;Samus jump and fire.
L8874:	.byte $40, $0F, $04, $00, $01, $FD, $20, $4B, $4A, $49, $FD, $60, $22, $07, $08, $32
L8884:	.byte $FF

;Samus summersault.
L8885:	.byte $41, $0F, $04, $52, $53, $62, $63, $72, $73, $FF

;Samus summersault.
L888F:	.byte $42, $0F, $04, $54, $55, $56, $64, $65, $66, $FF

;Samus summersault.
L8899:	.byte $81, $0F, $04, $52, $53, $62, $63, $72, $73, $FF

;Samus summersault.
L88A3:	.byte $82, $0F, $04, $54, $55, $56, $64, $65, $66, $FF

;Samus roll.
L88AD:	.byte $01, $08, $04, $FC, $03, $00, $50, $51, $60, $61, $FF

;Samus roll.
L88B8:	.byte $81, $08, $04, $FC, $FD, $00, $50, $51, $60, $61, $FF

;Samus roll.
L88C3:	.byte $C1, $08, $04, $FC, $FD, $00, $50, $51, $60, $61, $FF

;Samus roll.
L88CE:	.byte $41, $08, $04, $FC, $03, $00, $50, $51, $60, $61, $FF

;Samus stand and fire.
L88D9:	.byte $40, $0F, $04, $FD, $20, $0E, $0D, $FE, $1E, $1D, $2E, $2D, $FE, $FD, $60, $3B
L88E9:	.byte $3C, $FE, $FE, $17, $FF

;Elevator.
L88EE:	.byte $03, $04, $10, $28, $38, $38, $FD, $60, $28, $FF

;Missile right.
L88F8:	.byte $4A, $04, $08, $5E, $5F, $FF

;Missile left.
L88FE:	.byte $0A, $04, $08, $5E, $5F, $FF

;Missile up.
L8904:	.byte $09, $08, $04, $14, $24, $FF

;Bullet fire.
L890A:	.byte $04, $02, $02, $30, $FF

;Bullet hit.
L890F:	.byte $04, $00, $00, $04, $FF

;Samus stand and point up.
L8914:	.byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $2E, $2D, $FE, $FD
L8924:	.byte $60, $3B, $3C, $FF

;Samus from ball to pointing up.
L8928:	.byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $2E, $2D, $FE, $FD
L8938:	.byte $60, $3B, $3C, $FF

;Door closed.
L893C:	.byte $35, $18, $08, $0F, $1F, $2F, $FD, $A3, $2F, $1F, $0F, $FF

;Door open/close.
L8948:	.byte $35, $18, $04, $6A, $6B, $6C, $FD, $A3, $6C, $6B, $6A, $FF

;Samus explode.
L8954:	.byte $07, $00, $00, $FC, $FC, $00, $0B, $0C, $1B, $1C, $2B, $2C, $FF

;Samus jump and point up.
L8961:	.byte $46, $0F, $04, $69, $FD, $20, $FE, $7A, $79, $FE, $78, $77, $FD, $60, $22, $07
L8971:	.byte $08, $32, $FF

;Samus jump and point up.
L8974:	.byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $22, $07
L8984:	.byte $08, $32, $FF

;Bomb explode.
L8987:	.byte $0D, $0C, $0C, $74, $FD, $60, $74, $FD, $A0, $74, $FD, $E0, $74, $FF

;Samus run and point up.
L8995:	.byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $20, $21
L89A5:	.byte $FE, $FE, $31, $FF

;Samus run and point up.
L89A9:	.byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $22, $23
L89B9:	.byte $FE, $32, $33, $34, $FF

;Samus run and point up.
L89BE:	.byte $46, $0F, $04, $69, $FE, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $25, $26
L89CE:	.byte $27, $35, $36, $FF

;Samus run and point up.
L89D2:	.byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $20, $21
L89E2:	.byte $FE, $FE, $31, $FF

;Samus point up, run and fire.
L89E6:	.byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $22, $23
L89F6:	.byte $FE, $32, $33, $34, $FF

;Samus point up, run and fire.
L89FB:	.byte $46, $0F, $04, $FE, $69, $FD, $20, $7A, $79, $FE, $78, $77, $FD, $60, $25, $26
L8A0B:	.byte $27, $35, $36, $FF

;Bomb explode.
L8A0F:	.byte $0D, $0C, $0C, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

;Bomb explode.
L8A1D:	.byte $00, $00, $00, $FF

;Wave beam.
L8A21:	.byte $04, $04, $04, $4C, $FF

;Bomb explode.
L8A26:	.byte $08, $10, $10, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD, $E0, $4E, $3E, $3D
L8A36:	.byte $FD, $A0, $4E, $3D, $3E, $FF

;Bomb tick.
L8A3C:	.byte $04, $04, $04, $70, $FF

;Bomb tick.
L8A41:	.byte $04, $04, $04, $71, $FF

;Bomb item.
L8A46:	.byte $0D, $03, $03, $86, $87, $96, $97, $FF

;High jump item.
L8A4E:	.byte $0D, $03, $03, $7B, $7C, $8B, $8C, $FF

;Long beam item.
L8A56:	.byte $0D, $03, $03, $88, $67, $98, $99, $FF

;Screw attack item.
L8A5E:	.byte $0D, $03, $03, $80, $81, $90, $91, $FF

;Maru Mari item.
L8A66:	.byte $0D, $03, $03, $7D, $7E, $8D, $8E, $FF

;Varia item.
L8A6E:	.byte $0D, $03, $03, $82, $83, $92, $93, $FF

;Wave beam item.
L8A76:	.byte $0D, $03, $03, $88, $89, $98, $99, $FF

;Ice beam item.
L8A7E:	.byte $0D, $03, $03, $88, $68, $98, $99, $FF

;Energy tank item.
L8A86:	.byte $0D, $03, $03, $84, $85, $94, $95, $FF

;Missile item.
L8A8E:	.byte $0D, $03, $03, $3F, $FD, $40, $3F, $FD, $00, $4F, $FD, $40, $4F, $FF

;Skree burrow.
L8A9C:	.byte $34, $04, $04, $F2, $FF

;Not used.
L8AA1:	.byte $04, $00, $00, $5A, $FF, $13, $00, $00, $B0, $B1, $B2, $B3, $FF, $13, $00, $00
L8AB1:	.byte $B4, $B5, $B6, $B7, $B8, $B6, $B9, $B3, $FF, $13, $00, $00, $B3, $BA, $BA, $FE
L8AC1:	.byte $80, $80, $FF

;Kraid statue.
L8AC4:	.byte $1E, $00, $08, $FA, $FB, $FA, $FB, $FC, $00, $04, $C5, $C6, $C7, $D5, $D6, $D7
L8AD4:	.byte $E5, $E6, $E7, $FF

;Ridley statue.
L8AD8:	.byte $1E, $00, $08, $FA, $FB, $FA, $FB, $FE, $C8, $C9, $EB, $D8, $D9, $EA, $E8, $E9
L8AE8:	.byte $FF

;Missile explode.
L8AE9:	.byte $0A, $04, $08, $FD, $00, $57, $FD, $40, $57, $FF

;Missile explode.
L8AF3:	.byte $0B, $04, $0C, $FD, $00, $57, $18, $FD, $40, $18, $57, $FD, $C0, $18, $18, $FF

;Missile explode.
L8B03:	.byte $0C, $04, $10, $FD, $00, $57, $18, $FD, $40, $18, $57, $FD, $C0, $18, $18, $FF

;------------------------------------[ Samus enter door routines ]-----------------------------------

;This function is called once when Samus first enters a door.

SamusEnterDoor:
L8B13:	LDA DoorStatus			;The code determines if Samus has entered a door if the-->
L8B15:	BNE ++++			;door status is 0, but door data information has been-->
L8B17:	LDY SamusDoorData		;written. If both conditions are met, Samus has just-->
L8B19:	BEQ ++++			;entered a door.
L8B1B:	STA CurrentMissilePickups	;
L8B1D:	STA CurrentEnergyPickups	;Reset current missile and energy power-up counters.
L8B1F:	LDA RandomNumber1		;
L8B21:	AND #$0F			;Randomly recalculate max missile pickups(16 max, 0 min).
L8B23:	STA MaxMissilePickup		;
L8B25:	ASL				;
L8B26:	ORA #$40			;*2 for energy pickups and set bit 6(128 max, 64 min).
L8B28:	STA MaxEnergyPickup		;
L8B2A:	LDA PPUCNT0ZP			;
L8B2C:	EOR #$01			;
L8B2E:	AND #$01			;Erase name table door data for new room.
L8B30:	TAY				;
L8B31:	LSR				;
L8B32:	STA $006C,Y			;
L8B35:	LDA ScrollDir			;
L8B37:	AND #$02			;Is Samus scrolling horizontally?-->
L8B39:	BNE +				;If so, branch.
L8B3B:	LDX #$04			;Samus currently scrolling vertically.
L8B3D:	LDA ScrollY			;Is room centered on screen?-->
L8B3F:	BEQ +++++			;If so, branch.
L8B41:	LDA $FF				;
L8B43:	EOR ObjectHi			;Get inverse of Samus' current nametable.
L8B46:	LSR				;
L8B47:	BCC +++				;If Samus is on nametable 3, branch.
L8B49:	BCS ++				;If Samus is on nametable 0, branch to decrement x.

L8B4B:*	LDX #$02			;Samus is currently scrolling horizontally.
L8B4D:	LDA ObjectX			;Is Samus entering a left hand door?-->
L8B50:	BPL ++				;If so, branch.
L8B52:*	DEX				;

SetDoorEntryInfo:
L8B53:*	TXA				;X contains door scroll status and is transferred to A.
L8B54:	STA DoorScrollStatus		;Save door scroll status.
L8B56:	JSR SamusInDoor			;($8B74)Indicate Samus just entered a door.
L8B59:	LDA #$12			;
L8B5B:	STA DoorDelay			;Set DoorDelay to 18 frames(going into door).
L8B5D:	LDA SamusDoorData		;
L8B5F:	JSR Amul16			;($C2C5)*16. Move scroll toggle data to upper 4 bits.
L8B62:	ORA ObjAction			;Keep Samus action so she will appear the same comming-->
L8B65:	STA SamusDoorData		;out of the door as she did going in.
L8B67:	LDA #$05			;
L8B69:	STA ObjAction			;Indicate Samus is in a door.
L8B6C:*	RTS				;

L8B6D:*	JSR SetDoorEntryInfo		;($8B53)Save Samus action and set door entry timer.
L8B70:	JSR VerticalRoomCentered	;($E21B)Room is centered. Toggle scroll.

L8B73:	TXA				;X=#$01 or #$02(depending on which door Samus is in).

SamusInDoor:
L8B74:	ORA #$80			;Set MSB of DoorStatus to indicate Samus has just-->
L8B76:	STA DoorStatus			;entered a door.
L8B78:	RTS				;

;----------------------------------------------------------------------------------------------------

L8B79:	LDX #$B0
L8B7B:*	JSR $8B87
L8B7E:	LDA PageIndex
L8B80:	SEC 
L8B81:	SBC #$10
L8B83:	TAX 
L8B84:	BMI -
L8B86:	RTS

L8B87:	STX PageIndex
L8B89:	LDA ObjAction,X
L8B8C:	JSR ChooseRoutine		;($C27C)

L8B8F:	.word $C45C
L8B91:	.word $8B9D
L8B93:	.word $8BD5
L8B95:	.word $8C01
L8B97:	.word $8C84
L8B99:	.word $8CC6
L8B9B:	.word $8CF0

L8B9D:	INC $0300,X
L8BA0:	LDA #$30
L8BA2:	JSR SetProjectileAnim		;($D2FA)
L8BA5:	JSR $8CFB
L8BA8:	LDY $0307,X
L8BAB:	LDA $8BD1,Y
L8BAE:	STA $030F,X
L8BB1:	LDA $0307,X
L8BB4:	CMP #$03
L8BB6:	BNE $8BBA
L8BB8:	LDA #$01
L8BBA:	ORA #$A0
L8BBC:	STA $6B
L8BBE:	LDA #$00
L8BC0:	STA $030A,X
L8BC3:	TXA 
L8BC4:	AND #$10
L8BC6:	EOR #$10
L8BC8:	ORA $6B
L8BCA:	STA $6B
L8BCC:	LDA #$06
L8BCE:	JMP $DE47

L8BD1:	.byte $05, $01, $0A, $01

L8BD5:	LDA $030A,X
L8BD8:	AND #$04
L8BDA:	BEQ $8BB1
L8BDC:	DEC $030F,X
L8BDF:	BNE $8BB1
L8BE1:	LDA #$03
L8BE3:	CMP $0307,X
L8BE6:	BNE $8BEE
L8BE8:	LDY $010B
L8BEB:	INY 
L8BEC:	BNE $8BB1
L8BEE:	STA $0300,X
L8BF1:	LDA #$50
L8BF3:	STA $030F,X
L8BF6:	LDA #$2C
L8BF8:	STA $0305,X
L8BFB:	SEC 
L8BFC:	SBC #$03
L8BFE:	JMP $8C7E
L8C01:	LDA DoorStatus
L8C03:	BEQ $8C1D
L8C05:	LDA $030C
L8C08:	EOR $030C,X
L8C0B:	LSR 
L8C0C:	BCS $8C1D
L8C0E:	LDA $030E
L8C11:	EOR $030E,X
L8C14:	BMI $8C1D
L8C16:	LDA #$04
L8C18:	STA $0300,X
L8C1B:	BNE $8C73
L8C1D:	LDA $0306,X
L8C20:	CMP $0305,X
L8C23:	BCC $8C73
L8C25:	LDA $030F,X
L8C28:	CMP #$50
L8C2A:	BNE $8C57
L8C2C:	JSR $8CF7
L8C2F:	LDA $0307,X
L8C32:	CMP #$01
L8C34:	BEQ $8C57
L8C36:	CMP #$03
L8C38:	BEQ $8C57
L8C3A:	LDA #$0A
L8C3C:	STA $09
L8C3E:	LDA $030C,X
L8C41:	STA $08
L8C43:	LDY $50
L8C45:	TXA 
L8C46:	JSR $C2C5
L8C49:	BCC $8C4C
L8C4B:	DEY 
L8C4C:	TYA 
L8C4D:	JSR $DC1E
L8C50:	LDA #$00
L8C52:	STA $0300,X
L8C55:	BEQ $8C73
L8C57:	LDA $2D
L8C59:	LSR 
L8C5A:	BCS $8C73
L8C5C:	DEC $030F,X
L8C5F:	BNE $8C73
L8C61:	LDA #$01
L8C63:	STA $030F,X
L8C66:	JSR $8CFB
L8C69:	LDA #$02
L8C6B:	STA $0300,X
L8C6E:	JSR $8C76
L8C71:	LDX PageIndex
L8C73:	JMP $8BB1
L8C76:	LDA #$30
L8C78:	STA $0305,X
L8C7B:	SEC 
L8C7C:	SBC #$02
L8C7E:	JSR $D2FD
L8C81:	JMP $CBDA
L8C84:	LDA DoorStatus
L8C86:	CMP #$05
L8C88:	BCS $8CC3
L8C8A:	JSR $8CFB
L8C8D:	JSR $8C76
L8C90:	LDX PageIndex
L8C92:	LDA $91
L8C94:	BEQ $8CA7
L8C96:	TXA 
L8C97:	JSR $C2BF
L8C9A:	EOR $91
L8C9C:	LSR 
L8C9D:	BCC $8CA7
L8C9F:	LDA $76
L8CA1:	EOR #$07
L8CA3:	STA $76
L8CA5:	STA $1C
L8CA7:	INC $0300,X
L8CAA:	LDA #$00
L8CAC:	STA $91
L8CAE:	LDA $0307,X
L8CB1:	CMP #$03
L8CB3:	BNE $8CC3
L8CB5:	TXA 
L8CB6:	JSR $C2C5
L8CB9:	BCS $8CC0
L8CBB:	JSR $CC07
L8CBE:	BNE $8CC3
L8CC0:	JSR $CC03
L8CC3:	JMP $8C71
L8CC6:	LDA DoorStatus
L8CC8:	CMP #$05
L8CCA:	BNE $8CED
L8CCC:	TXA 
L8CCD:	EOR #$10
L8CCF:	TAX 
L8CD0:	LDA #$06
L8CD2:	STA $0300,X
L8CD5:	LDA #$2C
L8CD7:	STA $0305,X
L8CDA:	SEC 
L8CDB:	SBC #$03
L8CDD:	JSR $D2FD
L8CE0:	JSR $CBDA
L8CE3:	JSR $CB73
L8CE6:	LDX PageIndex
L8CE8:	LDA #$02
L8CEA:	STA $0300,X
L8CED:	JMP $8BB1
L8CF0:	LDA DoorStatus
L8CF2:	BNE $8CED
L8CF4:	JMP $8C61
L8CF7:	LDA #$FF
L8CF9:	BNE $8CFD
L8CFB:	LDA #$4E
L8CFD:	PHA 
L8CFE:	LDA #$50
L8D00:	STA $02
L8D02:	TXA 
L8D03:	JSR $C2BF
L8D06:	AND #$01
L8D08:	TAY 
L8D09:	LDA $8D3A,Y
L8D0C:	STA $03
L8D0E:	LDA $030C,X
L8D11:	STA $0B
L8D13:	JSR $E96A
L8D16:	LDY #$00
L8D18:	PLA 
L8D19:	STA ($04),Y
L8D1B:	TAX 
L8D1C:	TYA 
L8D1D:	CLC 
L8D1E:	ADC #$20
L8D20:	TAY 
L8D21:	TXA 
L8D22:	CPY #$C0
L8D24:	BNE $8D19
L8D26:	LDX PageIndex
L8D28:	TXA 
L8D29:	JSR $C2C0
L8D2C:	AND #$06
L8D2E:	TAY 
L8D2F:	LDA $04
L8D31:	STA $005C,Y
L8D34:	LDA $05
L8D36:	STA $005D,Y
L8D39:	RTS

L8D3A:	.byte $E8, $10, $60, $AD, $91, $69, $8D, $78, $68, $AD, $92, $69, $8D, $79, $68, $A9 
L8D4A:	.byte $00, $85, $00, $85, $02, $AD, $97, $69, $29, $80, $F0, $06, $A5, $00, $09, $80
L8D5A:	.byte $85, $00, $AD, $97, $69, $29

;------------------------------------------[ Graphics data ]-----------------------------------------

;Partial font, "THE END".
L8D60:	.byte $00, $00, $00, $00, $00, $18, $18, $08, $00, $00, $00, $00, $00, $00, $00, $00
L8D70:	.byte $18, $38, $18, $18, $18, $18, $7E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8D80:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $78, $70, $F0, $F0, $78, $79, $1F, $00
L8D90:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $03, $87, $46, $4E, $4C, $8C, $08, $00
L8DA0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $39, $99, $3B, $33, $73, $79, $30, $00
L8DB0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $FC, $DC, $98, $B8, $B8, $FD, $66, $00
L8DC0:	.byte $3C, $60, $C0, $FC, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DD0:	.byte $00, $00, $00, $00, $00, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DE0:	.byte $7C, $C6, $C6, $7C, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DF0:	.byte $7C, $C6, $C6, $7E, $06, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E00:	.byte $38, $6C, $C6, $C6, $FE, $C6, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E10:	.byte $FC, $C6, $C6, $FC, $C6, $C6, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E20:	.byte $3C, $66, $C0, $C0, $C0, $66, $3C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E30:	.byte $F8, $CC, $C6, $C6, $C6, $CC, $F8, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E40:	.byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E50:	.byte $FE, $C0, $C0, $FC, $C0, $C0, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E60:	.byte $3E, $60, $C0, $CE, $C6, $66, $3E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E70:	.byte $C6, $C6, $C6, $FE, $C6, $C6, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E80:	.byte $7E, $18, $18, $18, $18, $18, $7E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8E90:	.byte $1E, $06, $06, $06, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EA0:	.byte $C6, $CC, $D8, $F0, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EB0:	.byte $60, $60, $60, $60, $60, $60, $7E, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EC0:	.byte $C6, $EE, $FE, $FE, $D6, $C6, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8ED0:	.byte $C6, $E6, $F6, $FE, $DE, $CE, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EE0:	.byte $7C, $C6, $C6, $C6, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8EF0:	.byte $FC, $C6, $C6, $C6, $FC, $C0, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F00:	.byte $7C, $C6, $C6, $C6, $DE, $CC, $7A, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F10:	.byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F20:	.byte $78, $CC, $C0, $7C, $06, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F30:	.byte $7E, $18, $18, $18, $18, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F40:	.byte $C6, $C6, $C6, $C6, $C6, $C6, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F50:	.byte $C6, $C6, $C6, $EE, $7C, $38, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F60:	.byte $C6, $C6, $D6, $FE, $FE, $EE, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F70:	.byte $C6, $EE, $7C, $38, $7C, $EE, $C6, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F80:	.byte $66, $66, $66, $3C, $18, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F90:	.byte $FE, $0E, $1C, $38, $70, $E0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FA0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $01, $07, $0F, $0C, $08, $08, $04, $03
L8FB0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $C1, $FF, $FF, $3E, $00, $08, $88, $19
L8FC0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $20, $60, $60, $E0, $C0, $C8
L8FD0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $38
L8FE0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $30, $48, $40, $61, $3F, $3F, $1F, $00
L8FF0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $11, $33, $73, $E7, $E6, $C6, $04, $00
L9000:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $9C, $CC, $1C, $19, $3A, $3C, $18, $00
L9010:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $7C, $74, $E4, $F8, $E0, $72, $3C, $00
L9020:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $03, $06, $0C, $0C, $06, $02, $1E, $3C
L9030:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $40, $20, $20, $40, $03, $01, $03
L9040:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $80, $90
L9050:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $03, $03, $07, $06, $EE
L9060:	.byte $32, $FF, $F7, $FF, $7F, $FF, $DB, $FF, $73, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9070:	.byte $B4, $FF, $FF, $FF, $FE, $7B, $FF, $FD, $B6, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9080:	.byte $B5, $FF, $7F, $9D, $F6, $7F, $DD, $77, $FF, $FF, $FF, $FF, $EF, $FF, $BB, $FE
L9090:	.byte $D7, $FF, $79, $DE, $F5, $3F, $ED, $BF, $FF, $FF, $FF, $FF, $BF, $FF, $FB, $FF
L90A0:	.byte $89, $F7, $5F, $F3, $E7, $FD, $70, $CF, $FF, $BF, $EC, $FF, $9F, $FE, $AF, $F9
L90B0:	.byte $9F, $F9, $3D, $F7, $3F, $99, $FD, $CF, $F6, $7F, $FF, $FD, $CF, $FF, $FF, $FB
L90C0:	.byte $B9, $59, $CC, $7F, $DF, $9F, $BF, $1E, $7F, $FF, $B7, $F3, $FD, $6F, $FF, $E7
L90D0:	.byte $7F, $F9, $F3, $FF, $FF, $FF, $FF, $BB, $9F, $FF, $CF, $9F, $FD, $FF, $27, $DF
L90E0:	.byte $63, $EF, $EE, $1F, $B9, $1C, $F7, $FF, $9D, $38, $FF, $FF, $C7, $E3, $FF, $BF
L90F0:	.byte $FF, $9D, $7E, $FF, $B3, $C7, $FF, $A1, $3C, $7E, $FF, $E7, $CF, $FF, $FB, $7F
L9100:	.byte $C8, $ED, $BE, $DC, $9E, $F8, $36, $CC, $3F, $1E, $7F, $FF, $EF, $07, $CF, $FF
L9110:	.byte $C7, $BF, $3A, $7F, $BD, $A3, $7F, $FC, $3C, $7C, $FD, $E7, $CF, $FE, $8C, $0F
L9120:	.byte $00, $00, $18, $18, $3C, $7E, $5E, $FF, $10, $10, $18, $38, $7C, $7E, $FE, $FF
L9130:	.byte $00, $10, $10, $10, $10, $30, $30, $10, $10, $10, $10, $10, $30, $30, $30, $30
L9140:	.byte $20, $30, $30, $20, $60, $30, $70, $F8, $20, $30, $30, $60, $60, $70, $F0, $F8
L9150:	.byte $10, $10, $10, $10, $10, $10, $00, $10, $00, $00, $00, $00, $00, $00, $00, $00

;Brinstar enemy tile patterns.
L9160:	.byte $03, $0F, $05, $32, $D1, $48, $12, $24, $01, $02, $02, $11, $48, $20, $00, $00
L9170:	.byte $E0, $F0, $EC, $DE, $92, $8D, $A0, $3C, $C0, $00, $0C, $02, $01, $0C, $02, $00
L9180:	.byte $00, $00, $F8, $3E, $1F, $0F, $0F, $0E, $00, $00, $00, $08, $04, $00, $00, $00
L9190:	.byte $18, $30, $6C, $7C, $5C, $78, $70, $21, $00, $00, $0C, $1C, $1C, $38, $30, $3C
L91A0:	.byte $18, $30, $60, $60, $40, $40, $40, $01, $00, $00, $00, $00, $00, $00, $00, $3C
L91B0:	.byte $00, $01, $00, $00, $03, $04, $48, $3C, $00, $01, $00, $03, $0C, $08, $10, $03
L91C0:	.byte $48, $2F, $B3, $4D, $32, $CC, $84, $6F, $48, $28, $AF, $3D, $78, $CD, $B6, $6F
L91D0:	.byte $00, $50, $00, $C8, $74, $34, $90, $38, $00, $00, $B0, $E8, $74, $BC, $18, $18
L91E0:	.byte $3C, $7F, $FF, $FF, $FF, $7E, $7B, $3D, $3C, $7F, $FF, $FC, $D1, $50, $69, $0E
L91F0:	.byte $00, $00, $C0, $E0, $B0, $08, $07, $87, $00, $00, $C0, $60, $B0, $68, $73, $B2
L9200:	.byte $01, $00, $1C, $0F, $07, $03, $0F, $3F, $01, $00, $10, $08, $04, $00, $08, $20
L9210:	.byte $80, $C0, $F8, $C8, $88, $32, $51, $68, $0C, $10, $A0, $06, $01, $32, $11, $00
L9220:	.byte $00, $01, $21, $33, $3B, $1F, $9F, $FF, $00, $01, $20, $12, $08, $00, $80, $20
L9230:	.byte $00, $00, $08, $98, $B8, $F0, $F2, $FE, $00, $00, $08, $90, $20, $00, $02, $04
L9240:	.byte $81, $A5, $E7, $00, $00, $24, $18, $24, $81, $A5, $E7, $42, $66, $C3, $66, $18
L9250:	.byte $00, $24, $1B, $1F, $3B, $44, $5B, $3F, $BD, $9B, $E4, $C0, $C4, $98, $83, $C7
L9260:	.byte $00, $20, $60, $C3, $CC, $60, $20, $00, $0A, $0F, $0F, $1C, $13, $0F, $0F, $0A
L9270:	.byte $00, $00, $00, $00, $E0, $00, $00, $00, $40, $E8, $FA, $FF, $1F, $FA, $E8, $40
L9280:	.byte $1E, $1C, $18, $3A, $36, $60, $00, $00, $00, $00, $00, $02, $06, $00, $03, $00
L9290:	.byte $43, $C6, $FE, $F8, $F6, $A9, $21, $20, $38, $00, $00, $00, $66, $AD, $F9, $20
L92A0:	.byte $73, $DE, $EF, $F8, $F6, $A9, $21, $20, $38, $1E, $0F, $00, $66, $AD, $F9, $20
L92B0:	.byte $03, $02, $30, $7E, $70, $D0, $6C, $1D, $04, $30, $48, $00, $80, $11, $30, $21
L92C0:	.byte $61, $30, $1E, $81, $28, $FF, $FF, $F1, $61, $32, $1E, $81, $F8, $FF, $FF, $F9
L92D0:	.byte $B8, $D0, $6C, $36, $9E, $0C, $C0, $E8, $FC, $FC, $7E, $36, $BE, $0C, $E0, $F8
L92E0:	.byte $1F, $0F, $07, $03, $01, $0E, $1F, $3F, $07, $03, $03, $01, $00, $06, $17, $13
L92F0:	.byte $C3, $66, $9E, $DE, $EF, $F7, $73, $B9, $DA, $66, $DE, $C6, $E3, $61, $25, $B9
L9300:	.byte $0F, $03, $07, $0F, $1D, $00, $01, $03, $08, $00, $04, $08, $10, $00, $01, $02
L9310:	.byte $60, $51, $32, $88, $C8, $F8, $C0, $00, $0C, $11, $32, $00, $04, $02, $12, $20
L9320:	.byte $78, $33, $65, $26, $19, $00, $04, $02, $00, $00, $04, $46, $80, $90, $14, $0A
L9330:	.byte $1C, $C8, $A4, $64, $18, $00, $20, $40, $00, $00, $25, $62, $80, $88, $26, $40
L9340:	.byte $00, $02, $0D, $17, $2D, $62, $6D, $2E, $83, $C5, $F2, $E0, $C2, $81, $8C, $CE
L9350:	.byte $00, $40, $B0, $E8, $B4, $46, $B6, $74, $C1, $A3, $4F, $07, $43, $81, $31, $73
L9360:	.byte $00, $00, $00, $00, $00, $20, $73, $DF, $00, $00, $0A, $0F, $1F, $14, $11, $18
L9370:	.byte $00, $00, $00, $00, $00, $00, $12, $C0, $00, $00, $40, $E8, $FA, $FF, $70, $00
L9380:	.byte $24, $3C, $5A, $DB, $66, $99, $5A, $24, $00, $00, $42, $C3, $66, $00, $00, $42
L9390:	.byte $00, $00, $44, $EE, $B2, $82, $84, $40, $04, $38, $54, $EE, $B2, $80, $00, $00
L93A0:	.byte $00, $00, $0C, $04, $62, $12, $1F, $01, $00, $B0, $50, $78, $9C, $6C, $20, $00
L93B0:	.byte $38, $72, $C5, $73, $72, $6F, $22, $00, $40, $82, $05, $23, $42, $07, $1E, $00
L93C0:	.byte $C3, $E0, $7C, $8F, $C7, $F3, $72, $00, $E3, $F0, $7E, $8F, $C7, $F2, $71, $01
L93D0:	.byte $F0, $E8, $3C, $9C, $80, $18, $1C, $00, $F0, $E8, $3C, $9E, $42, $5A, $5C, $00
L93E0:	.byte $3B, $7D, $7B, $7D, $7E, $FF, $FF, $00, $31, $3D, $3B, $1C, $6E, $37, $79, $00
L93F0:	.byte $F9, $B9, $50, $E0, $7C, $8C, $E0, $00, $F9, $B1, $40, $60, $3C, $8E, $C2, $02
L9400:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9410:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9420:	.byte $60, $71, $30, $18, $0C, $00, $00, $00, $62, $72, $37, $93, $81, $7E, $34, $06
L9430:	.byte $00, $01, $00, $08, $1C, $30, $70, $60, $02, $02, $07, $83, $91, $7E, $74, $66
L9440:	.byte $26, $31, $10, $1C, $18, $0C, $00, $00, $C6, $C0, $60, $60, $20, $30, $18, $08
L9450:	.byte $5E, $2C, $20, $3C, $24, $18, $00, $00, $87, $C3, $42, $42, $42, $66, $24, $24
L9460:	.byte $00, $00, $00, $00, $0B, $27, $73, $DF, $0A, $0F, $1F, $34, $0B, $07, $11, $18
L9470:	.byte $00, $00, $00, $00, $00, $8C, $F2, $E0, $40, $E8, $FA, $FF, $60, $80, $30, $00
L9480:	.byte $00, $00, $1C, $3E, $3E, $3E, $1C, $00, $00, $1C, $26, $69, $55, $53, $32, $1C
L9490:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94A0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94B0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94C0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94D0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94E0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94F0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9500:	.byte $1D, $1D, $1D, $1D, $1D, $1D, $1D, $1D, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
L9510:	.byte $F8, $F8, $F8, $F8, $F8, $F8, $F8, $F8, $A0, $A0, $A0, $A0, $A0, $A0, $A0, $A0
L9520:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9530:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9540:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9550:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

PalPntrTbl:
L9560:	.word Palette00			;($A271)
L9562:	.word Palette01			;($A295)
L9564:	.word Palette02			;($A2A1)
L9566:	.word Palette03			;($A29B)
L9568:	.word Palette04			;($A2A7)
L956A:	.word Palette05			;($A2AD)
L956C:	.word Palette06			;($A2D0)
L956E:	.word Palette06			;($A2D0)
L9570:	.word Palette06			;($A2D0)
L9572:	.word Palette06			;($A2D0)
L9574:	.word Palette06			;($A2D0)
L9576:	.word Palette06			;($A2D0)
L9578:	.word Palette06			;($A2D0)
L957A:	.word Palette06			;($A2D0)
L957C:	.word Palette06			;($A2D0)
L957E:	.word Palette06			;($A2D0)
L9580:	.word Palette06			;($A2D0)
L9582:	.word Palette06			;($A2D0)
L9584:	.word Palette06			;($A2D0)
L9586:	.word Palette06			;($A2D0)
L9588:	.word Palette07			;($A2D7)
L958A:	.word Palette08			;($A2DE)
L958C:	.word Palette09			;($A2E5)
L958E:	.word Palette0A			;($A2EC)
L9590:	.word Palette0B			;($A2F4)
L9592:	.word Palette0C			;($A2FC)
L9594:	.word Palette0D			;($A304)
L9596:	.word Palette0E			;($A30C)

AreaPointers:
L9598:	.word SpecItmsTbl		;($A3D6)Beginning of special items table.
L959A:	.word RmPtrTbl			;($A314)Beginning of room pointer table.	
L959C:	.word StrctPtrTbl		;($A372)Beginning of structure pointer table.
L959E:	.word MacroDefs			;($AEF0)Beginning of macro definitions.
L95A0:	.word EnemyFramePtrTbl1		;($9DE0)Pointer table into enemy animation data. Two-->
L95A2:	.word EnemyFramePtrTbl2		;($9EE0)tables needed to accommodate all entries.
L95A4:	.word EnemyPlacePtrTbl		;($9F0E)Pointers to enemy frame placement data.
L95A6:	.word EnemyAnimIndexTbl		;($9D6A)index to values in addr tables for enemy animations.

L95A8:	.byte $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60 
L95B8:	.byte $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA

AreaRoutine:
L95C3:	JMP $9D35			;Area specific routine.

TwosCompliment_:
L95C6:	EOR #$FF			;
L95C8:	CLC				;The following routine returns the twos-->
L95C9:	ADC #$01			;compliment of the value stored in A.
L95CB:	RTS				;

L95CC:	.byte $FF			;Not used.
				
L95CD:	.byte $01			;Brinstar music init flag.

L95CE:	.byte $80			;Base damage caused by area enemies to lower health byte.
L95CF:	.byte $00			;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:	.byte $2B, $2C, $28, $0B, $1C, $0A, $1A

L95D7:	.byte $03			;Samus start x coord on world map.
L95D8:	.byte $0E			;Samus start y coord on world map.
L95D9:	.byte $B0			;Samus start verticle screen position.

L95DA:	.byte $01, $00, $03, $43, $00, $00, $00, $00, $00, $00, $69 

L95E5:	LDA EnDataIndex, X
L95E8:	JSR $8024

L95EB:	.word $99B8
L95ED:	.word $99D3
L95EF:	.word $99E5
L95F1:	.word $99D8
L95F3:	.word $99FA
L95F5:	.word $9A4C
L95F7:	.word $9AF5
L95F9:	.word $9B32
L95FB:	.word $9BA2
L95FD:	.word $9BD2
L95FF:	.word $9C1A
L9601:	.word $0000
L9603:	.word $0000
L9605:	.word $0000
L9607:	.word $0000
L9609:	.word $0000

L960B:	.byte $27, $27, $29, $29, $2D, $2B, $31, $2F, $33, $33, $41, $41, $4B, $4B, $55, $53

L961B:	.byte $72, $74, $00, $00, $00, $00, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

EnemyHitPointTbl:
L962B:	.byte $08, $08, $04, $FF, $02, $02, $04, $01, $20, $FF, $FF, $04, $01, $00, $00, $00

L963B:	.byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $59, $57 

L964B:	.byte $6C, $6F, $5B, $5D, $62, $67, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

L965B:	.byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $50, $4D

L966B:	.byte $6C, $6F, $5B, $5D, $5F, $64, $69, $69, $69, $69, $00, $00, $00, $00, $00, $00

L967B:	.byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00 

L968B:	.byte $01, $01, $01, $00, $86, $04, $89, $80, $81, $00, $00, $00, $82, $00, $00, $00 

L969B:	.byte $01, $01, $01, $01, $01, $01, $01, $01, $20, $01, $01, $01, $40, $00, $00, $00 

L96AB:	.byte $00, $00, $06, $00, $83, $00, $88, $00, $00, $00, $00, $00, $00, $00, $00, $00 

EnemyInitDelayTbl:
L96BB:	.byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

L96CB:	.byte $00, $03, $06, $08, $0A, $10, $0C, $0E, $14, $17, $19, $10, $12, $00, $00, $00

L96DB:	.word $97EF, $97F2, $97F5, $97F5, $97F5, $97F5, $97F5, $97F5
L96EB:	.word $97F5, $97F5, $97F5, $9840, $988B, $988E, $9891, $98A5
L96FB:	.word $98B9, $98B9, $98B9, $98B9, $98B9, $98B9, $98B9, $98B9
L970B:	.word $98B9, $98C0, $98C7, $98CE, $98D5, $98D8, $98DB, $98F2
L971B:	.word $9909, $9920, $9937, $994E

L9723:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $7F, $40, $30, $C0, $D0, $00, $00, $7F
L9733:	.byte $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9743:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:	.byte $F6, $FC, $FE, $04, $02, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00
L9763:	.byte $00, $00, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02
L9773:	.byte $00, $00, $00, $00, $00, $00, $00, $00

L977B:	.byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00 

L978B:	.byte $00, $00, $64, $67, $69, $69, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:	.byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

L97A7:	.word $9965, $9974, $9983, $9992, $9D36, $9D3B, $9D40, $9D45
L97B7:	.word $9D4A, $9D4F, $9D54, $9D59, $9D5E, $9D63, $9D6A, $9D6A
L97C7:	.word $9D6A, $9D6A, $9D6A, $9D6A, $9D6A

L97D1:	.byte $01, $01, $02, $01, $03, $04, $00, $05, $00, $06, $00, $07, $00, $08, $00, $09
L97E1:	.byte $00, $00, $00, $0B, $01, $0C, $0D, $00, $0E, $03, $0F, $10, $11, $0F

L97EF:	.byte $20, $22, $FE

L97F2:	.byte $20, $2A, $FE

L97F5:	.byte $02, $F2, $04, $E2, $04, $D2, $05, $B2, $03, $92, $04, $02, $05, $12, $03, $32
L9805:	.byte $05, $52, $04, $62, $02, $72, $02, $72, $04, $62, $04, $52, $05, $32, $03, $12
L9815:	.byte $04, $02, $05, $92, $03, $B2, $05, $D2, $04, $E2, $02, $F2, $FD, $03, $D2, $06
L9825:	.byte $B2, $08, $92, $05, $02, $07, $12, $05, $32, $04, $52, $03, $52, $06, $32, $08
L9835:	.byte $12, $05, $02, $07, $92, $05, $B2, $04, $D2, $FD, $FF

L9840:	.byte $02, $FA, $04, $EA, $04, $DA, $05, $BA, $03, $9A, $04, $0A, $05, $1A, $03, $3A
L9850:	.byte $05, $5A, $04, $6A, $02, $7A, $02, $7A, $04, $6A, $04, $5A, $05, $3A, $03, $1A
L9860:	.byte $04, $0A, $05, $9A, $03, $BA, $05, $DA, $04, $EA, $02, $FA, $FD, $03, $DA, $06
L9870:	.byte $BA, $08, $9A, $05, $0A, $07, $1A, $05, $3A, $04, $5A, $03, $5A, $06, $3A, $08
L9880:	.byte $1A, $05, $0A, $07, $9A, $05, $BA, $04, $DA, $FD, $FF

L988B:	.byte $01, $01, $FF

L988E:	.byte $01, $09, $FF

L9891:	.byte $04, $22, $01, $42, $01, $22, $01, $42, $01, $62, $01, $42, $04, $62, $FC, $01
L98A1:	.byte $00, $64, $00, $FB

L98A5:	.byte $04, $2A, $01, $4A, $01, $2A, $01, $4A, $01, $6A, $01, $4A, $04, $6A, $FC, $01
L98B5:	.byte $00, $64, $00, $FB

L98B9:	.byte $14, $11, $0A, $00, $14, $19, $FE

L98C0:	.byte $14, $19, $0A, $00, $14, $11, $FE

L98C7:	.byte $1E, $11, $0A, $00, $1E, $19, $FE 

L98CE:	.byte $1E, $19, $0A, $00, $1E, $11, $FE

L98D5:	.byte $50, $04, $FF

L98D8:	.byte $50, $0C, $FF

L98DB:	.byte $02, $F3, $04, $E3, $04, $D3, $05, $B3, $03, $93, $04, $03, $05, $13, $03, $33
L98EB:	.byte $05, $53, $04, $63, $50, $73, $FF

L98F2:	.byte $02, $FB, $04, $EB, $04, $DB, $05, $BB, $03, $9B, $04, $0B, $05, $1B, $03, $3B
L9902:	.byte $05, $5B, $04, $6B, $50, $7B, $FF

L9909:	.byte $02, $F4, $04, $E4, $04, $D4, $05, $B4, $03, $94, $04, $04, $05, $14, $03, $34
L9919:	.byte $05, $54, $04, $64, $50, $74, $FF

L9920:	.byte $02, $FC, $04, $EC, $04, $DC, $05, $BC, $03, $9C, $04, $0C, $05, $1C, $03, $3C
L9930:	.byte $05, $5C, $04, $6C, $50, $7C, $FF

L9937:	.byte $02, $F2, $04, $E2, $04, $D2, $05, $B2, $03, $92, $04, $02, $05, $12, $03, $32
L9947:	.byte $05, $52, $04, $62, $50, $72, $FF

L994E:	.byte $02, $FA, $04, $EA, $04, $DA, $05, $BA, $03, $9A, $04, $0A, $05, $1A, $03, $3A
L995E:	.byte $05, $5A, $04, $6A, $50, $7A, $FF

L9965:	.byte $04, $B3, $05, $A3, $06, $93, $07, $03, $06, $13, $05, $23, $50, $33, $FF

L9974:	.byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L9983:	.byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L9992:	.byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

L99A1:	LDA $81
L99A3:	CMP #$01
L99A5:	BEQ $99B0
L99A7:	CMP #$03
L99A9:	BEQ $99B5
L99AB:	LDA $00
L99AD:	JMP $8000
L99B0:	LDA $01
L99B2:	JMP $8003
L99B5:	JMP $8006

L99B8:	LDA #$09
L99BA:	STA $85
L99BC:	STA $86
L99BE:	LDA EnStatus,X
L99C1:	CMP #$03
L99C3:	BEQ $99C8
L99C5:	JSR $801B
L99C8:	LDA #$06
L99CA:	STA $00
L99CC:	LDA #$08
L99CE:	STA $01
L99D0:	JMP $99A1

L99D3:	LDA #$0F
L99D5:	JMP $99BA
L99D8:	LDA EnStatus,X
L99DB:	CMP #$03
L99DD:	BEQ $99E2
L99DF:	JSR $801E
L99E2:	JMP $99C8
L99E5:	LDA #$21
L99E7:	STA $85
L99E9:	LDA #$1E
L99EB:	STA $86
L99ED:	LDA EnStatus,X
L99F0:	CMP #$03
L99F2:	BEQ $99F7
L99F4:	JSR $801B
L99F7:	JMP $99C8
L99FA:	LDA $81
L99FC:	CMP #$01
L99FE:	BEQ $9A44
L9A00:	CMP #$03
L9A02:	BEQ $9A49
L9A04:	LDA EnCounter,X
L9A07:	CMP #$0F
L9A09:	BCC $9A3F
L9A0B:	CMP #$11
L9A0D:	BCS $9A16
L9A0F:	LDA #$3A
L9A11:	STA $6B01,X
L9A14:	BNE $9A3F
L9A16:	DEC $6B01,X
L9A19:	BNE $9A3F
L9A1B:	LDA #$00
L9A1D:	STA EnStatus,X
L9A20:	LDY #$0C
L9A22:	LDA #$0A
L9A24:	STA $00A0,Y
L9A27:	LDA EnYRoomPos,X
L9A2A:	STA $00A1,Y
L9A2D:	LDA EnXRoomPos,X
L9A30:	STA $00A2,Y
L9A33:	LDA EnNameTable,X
L9A36:	STA $00A3,Y
L9A39:	DEY 
L9A3A:	DEY 
L9A3B:	DEY 
L9A3C:	DEY 
L9A3D:	BPL $9A22
L9A3F:	LDA #$02
L9A41:	JMP $8000
L9A44:	LDA #$08
L9A46:	JMP $8003
L9A49:	JMP $8006

L9A4C:	JSR $8009
L9A4F:	AND #$03
L9A51:	BEQ $9A87
L9A53:	LDA $81
L9A55:	CMP #$01
L9A57:	BEQ $9A44
L9A59:	CMP #$03
L9A5B:	BEQ $9A49
L9A5D:	LDA EnStatus,X
L9A60:	CMP #$03
L9A62:	BEQ $9A87
L9A64:	LDA $040A,X
L9A67:	AND #$03
L9A69:	CMP #$01
L9A6B:	BNE $9A7E
L9A6D:	LDY EnYRoomPos,X
L9A70:	CPY #$E4
L9A72:	BNE $9A7E
L9A74:	JSR $9ABD
L9A77:	LDA #$03
L9A79:	STA $040A,X
L9A7C:	BNE $9A84
L9A7E:	JSR $9AE2
L9A81:	JSR $9AA8
L9A84:	JSR $9AC6
L9A87:	LDA #$03
L9A89:	JSR $800C
L9A8C:	JMP $8006
L9A8F:	LDA $0405,X
L9A92:	LSR 
L9A93:	LDA $040A,X
L9A96:	AND #$03
L9A98:	ROL 
L9A99:	TAY 
L9A9A:	LDA $9AA0,Y
L9A9D:	JMP $800F

L9AA0:	.byte $35, $35, $3E, $38, $3B, $3B, $38, $3E 

L9AA8:	LDX PageIndex
L9AAA:	BCS $9AC5
L9AAC:	LDA $00
L9AAE:	BNE $9ABD
L9AB0:	LDY $040A,X
L9AB3:	DEY 
L9AB4:	TYA 
L9AB5:	AND #$03
L9AB7:	STA $040A,X
L9ABA:	JMP $9A8F
L9ABD:	LDA $0405,X
L9AC0:	EOR #$01
L9AC2:	STA $0405,X
L9AC5:	RTS

L9AC6:	JSR $9ADA
L9AC9:	JSR $9AE2
L9ACC:	LDX PageIndex
L9ACE:	BCC $9AD9
L9AD0:	JSR $9ADA
L9AD3:	STA $040A,X
L9AD6:	JSR $9A8F
L9AD9:	RTS

L9ADA:	LDY $040A,X
L9ADD:	INY 
L9ADE:	TYA 
L9ADF:	AND #$03
L9AE1:	RTS

L9AE2:	LDY $0405,X
L9AE5:	STY $00
L9AE7:	LSR $00
L9AE9:	ROL 
L9AEA:	ASL 
L9AEB:	TAY 
L9AEC:	LDA $8049,Y
L9AEF:	PHA 
L9AF0:	LDA $8048,Y
L9AF3:	PHA 
L9AF4:	RTS

L9AF5:	LDA $81
L9AF7:	CMP #$01
L9AF9:	BEQ $9B2D
L9AFB:	CMP #$03
L9AFD:	BEQ $9B2A
L9AFF:	LDA #$80
L9B01:	STA $6AFE,X
L9B04:	LDA $0402,X
L9B07:	BMI $9B25
L9B09:	LDA $0405,X
L9B0C:	AND #$10
L9B0E:	BEQ $9B25
L9B10:	LDA EnYRoomPos,X
L9B13:	SEC 
L9B14:	SBC $030D
L9B17:	BPL $9B1C
L9B19:	JSR $95C6
L9B1C:	CMP #$10
L9B1E:	BCS $9B25
L9B20:	LDA #$00
L9B22:	STA $6AFE,X
L9B25:	LDA #$03
L9B27:	JMP $8000
L9B2A:	JMP $8006
L9B2D:	LDA #$08
L9B2F:	JMP $8003
L9B32:	LDA EnStatus,X
L9B35:	CMP #$02
L9B37:	BNE $9B71
L9B39:	LDA $0403,X
L9B3C:	BNE $9B71
L9B3E:	LDA $6AFE,X
L9B41:	BNE $9B55
L9B43:	LDA $030D
L9B46:	SEC 
L9B47:	SBC EnYRoomPos,X
L9B4A:	CMP #$40
L9B4C:	BCS $9B71
L9B4E:	LDA #$7F
L9B50:	STA $6AFE,X
L9B53:	BNE $9B71
L9B55:	LDA $0402,X
L9B58:	BMI $9B71
L9B5A:	LDA #$00
L9B5C:	STA $0402,X
L9B5F:	STA EnCounter,X
L9B62:	STA $6AFE,X
L9B65:	LDA $0405,X
L9B68:	AND #$01
L9B6A:	TAY 
L9B6B:	LDA $9BA0,Y
L9B6E:	STA $0403,X
L9B71:	LDA $0405,X
L9B74:	ASL 
L9B75:	BMI $9B95
L9B77:	LDA EnStatus,X
L9B7A:	CMP #$02
L9B7C:	BNE $9B95
L9B7E:	JSR $8036
L9B81:	PHA 
L9B82:	JSR $8039
L9B85:	STA $05
L9B87:	PLA 
L9B88:	STA $04
L9B8A:	JSR $9CA8
L9B8D:	JSR $8027
L9B90:	BCC $9B9A
L9B92:	JSR $9C96
L9B95:	LDA #$03
L9B97:	JMP $8003
L9B9A:	LDA #$00
L9B9C:	STA EnStatus,X
L9B9F:	RTS

L9BA0:	.byte $04, $FC

L9BA2:	LDA EnStatus,X
L9BA5:	CMP #$03
L9BA7:	BCC $9BC2
L9BA9:	BEQ $9BAF
L9BAB:	CMP #$05
L9BAD:	BNE $9BCB
L9BAF:	LDA #$00
L9BB1:	STA $6B04
L9BB4:	STA $6B14
L9BB7:	STA $6B24
L9BBA:	STA $6B34
L9BBD:	STA $6B44
L9BC0:	BEQ $9BCB
L9BC2:	JSR $9C1D
L9BC5:	JSR $9CCC
L9BC8:	JSR $9D05
L9BCB:	LDA #$0A
L9BCD:	STA $00
L9BCF:	JMP $99CC
L9BD2:	LDA $0405,X
L9BD5:	AND #$02
L9BD7:	BEQ $9BE0
L9BD9:	LDA EnStatus,X
L9BDC:	CMP #$03
L9BDE:	BNE $9BE7
L9BE0:	LDA #$00
L9BE2:	STA EnStatus,X
L9BE5:	BEQ $9C12
L9BE7:	LDA $0405,X
L9BEA:	ASL 
L9BEB:	BMI $9C12
L9BED:	LDA EnStatus,X
L9BF0:	CMP #$02
L9BF2:	BNE $9C12
L9BF4:	JSR $802D
L9BF7:	LDX PageIndex
L9BF9:	LDA $00
L9BFB:	STA $0402,X
L9BFE:	JSR $8030
L9C01:	LDX PageIndex
L9C03:	LDA $00
L9C05:	STA $0403,X
L9C08:	JSR $8033
L9C0B:	BCS $9C12
L9C0D:	LDA #$03
L9C0F:	STA EnStatus,X
L9C12:	LDA #$01
L9C14:	JSR $800C
L9C17:	JMP $8006
L9C1A:	JMP $9BD2
L9C1D:	LDX #$50
L9C1F:	JSR $9C2A
L9C22:	TXA 
L9C23:	SEC 
L9C24:	SBC #$10
L9C26:	TAX 
L9C27:	BNE $9C1F
L9C29:	RTS

L9C2A:	LDY EnStatus,X
L9C2D:	BEQ $9C55
L9C2F:	LDA EnDataIndex,X
L9C32:	CMP #$0A
L9C34:	BEQ $9C3A
L9C36:	CMP #$09
L9C38:	BNE $9CA7
L9C3A:	LDA $0405,X
L9C3D:	AND #$02
L9C3F:	BEQ $9C55
L9C41:	DEY 
L9C42:	BEQ $9C60
L9C44:	CPY #$02
L9C46:	BEQ $9C55
L9C48:	CPY #$03
L9C4A:	BNE $9CA7
L9C4C:	LDA $040C,X
L9C4F:	CMP #$01
L9C51:	BNE $9CA7
L9C53:	BEQ $9C60
L9C55:	LDA #$00
L9C57:	STA EnStatus,X
L9C5A:	STA EnSpecialAttribs,X
L9C5D:	JSR $802A
L9C60:	LDA $0405
L9C63:	STA $0405,X
L9C66:	LSR 
L9C67:	PHP 
L9C68:	TXA 
L9C69:	LSR 
L9C6A:	LSR 
L9C6B:	LSR 
L9C6C:	LSR 
L9C6D:	TAY 
L9C6E:	LDA $9CB7,Y
L9C71:	STA $04
L9C73:	LDA $9CC6,Y
L9C76:	STA EnDataIndex,X
L9C79:	TYA 
L9C7A:	PLP 
L9C7B:	ROL 
L9C7C:	TAY 
L9C7D:	LDA $9CBB,Y
L9C80:	STA $05
L9C82:	LDX #$00
L9C84:	JSR $9CA8
L9C87:	JSR $8027
L9C8A:	LDX PageIndex
L9C8C:	BCC $9CA7
L9C8E:	LDA EnStatus,X
L9C91:	BNE $9C96
L9C93:	INC EnStatus,X
L9C96:	LDA $08
L9C98:	STA EnYRoomPos,X
L9C9B:	LDA $09
L9C9D:	STA EnXRoomPos,X
L9CA0:	LDA $0B
L9CA2:	AND #$01
L9CA4:	STA EnNameTable,X
L9CA7:	RTS

L9CA8:	LDA EnYRoomPos,X
L9CAB:	STA $08
L9CAD:	LDA EnXRoomPos,X
L9CB0:	STA $09
L9CB2:	LDA EnNameTable,X
L9CB5:	STA $0B
L9CB7:	RTS

L9CB8:	.byte $F5, $FD, $05, $F6, $FE, $0A, $F6, $0C, $F4, $0E, $F2, $F8, $08, $F4, $0C, $09
L9CC8:	.byte $09, $09, $0A, $0A
 
L9CCC:	LDY $7E
L9CCE:	BNE $9CD2
L9CD0:	LDY #$80
L9CD2:	LDA $2D
L9CD4:	AND #$02
L9CD6:	BNE $9D04
L9CD8:	DEY 
L9CD9:	STY $7E
L9CDB:	TYA 
L9CDC:	ASL 
L9CDD:	BMI $9D04
L9CDF:	AND #$0F
L9CE1:	CMP #$0A
L9CE3:	BNE $9D04
L9CE5:	LDA #$01
L9CE7:	LDX #$10
L9CE9:	CMP EnStatus,X
L9CEC:	BEQ $9CFF
L9CEE:	LDX #$20
L9CF0:	CMP EnStatus,X
L9CF3:	BEQ $9CFF
L9CF5:	LDX #$30
L9CF7:	CMP EnStatus,X
L9CFA:	BEQ $9CFF
L9CFC:	INC $7E
L9CFE:	RTS

L9CFF:	LDA #$08
L9D01:	STA EnDelay,X
L9D04:	RTS

L9D05:	LDY $7F
L9D07:	BNE $9D0B
L9D09:	LDY #$60
L9D0B:	LDA $2D
L9D0D:	AND #$02
L9D0F:	BNE $9D34
L9D11:	DEY 
L9D12:	STY $7F
L9D14:	TYA 
L9D15:	ASL 
L9D16:	BMI $9D34
L9D18:	AND #$0F
L9D1A:	BNE $9D34
L9D1C:	LDA #$01
L9D1E:	LDX #$40
L9D20:	CMP EnStatus,X
L9D23:	BEQ $9D2F
L9D25:	LDX #$50
L9D27:	CMP EnStatus,X
L9D2A:	BEQ $9D2F
L9D2C:	INC $7F
L9D2E:	RTS

L9D2F:	LDA #$08
L9D31:	STA EnDelay,X
L9D34:	RTS

L9D35:	.byte $60, $22, $FF, $FF, $FF, $FF, $22, $80, $81, $82, $83, $22, $84, $85, $86, $87
L9D45:	.byte $22, $88, $89, $8A, $8B, $22, $8C, $8D, $8E, $8F, $22, $94, $95, $96, $97, $22
L9D55:	.byte $9C, $9D, $9D, $9C, $22, $9E, $9F, $9F, $9E, $22, $90, $91, $92, $93, $32, $4E
L9D65:	.byte $4E, $4E, $4E, $4E, $4E

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:

L9D6A:	.byte $00, $01, $FF

L9D6D:	.byte $02, $FF

L9D6F:	.byte $19, $1A, $FF

L9D72:	.byte $1A, $1B, $FF

L9D75:	.byte $1C, $1D, $FF

L9D78:	.byte $1D, $1E, $FF

L9D7B:	.byte $22, $23, $24, $FF

L9D7F:	.byte $1F, $20, $21, $FF

L9D83:	.byte $22, $FF

L9D85:	.byte $1F, $FF

L9D87:	.byte $23, $04, $FF

L9D8A:	.byte $20, $03, $FF

L9D8D:	.byte $27, $28, $29, $FF

L9D91:	.byte $37, $FF

L9D93:	.byte $38, $FF

L9D95:	.byte $39, $FF

L9D97:	.byte $3A, $FF

L9D99:	.byte $3B, $FF

L9D9B:	.byte $3C, $FF

L9D9D:	.byte $3D, $FF

L9D9F:	.byte $58, $59, $FF

L9DA2:	.byte $5A, $5B, $FF

L9DA5:	.byte $5C, $5D, $FF

L9DA8:	.byte $5E, $5F, $FF

L9DAB:	.byte $60, $FF

L9DAD:	.byte $61, $F7, $62, $F7, $FF

L9DB2:	.byte $63, $64, $FF

L9DB5:	.byte $65, $FF

L9DB7:	.byte $66, $67, $FF

L9DBA:	.byte $69, $6A, $FF

L9DBD:	.byte $68, $FF

L9DBF:	.byte $6B, $FF

L9DC1:	.byte $66, $FF

L9DC3:	.byte $69, $FF

L9DC5:	.byte $6C, $FF

L9DC7:	.byte $6D, $FF

L9DC9:	.byte $6F, $70, $71, $6E, $FF

L9DCE:	.byte $73, $74, $75, $72, $FF

L9DD3:	.byte $8F, $90, $FF

L9DD6:	.byte $91, $92, $FF

L9DD9:	.byte $93, $94, $FF

L9DDC:	.byte $95, $FF

L9DDE:	.byte $96, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9DE0:	.word $9FC2, $9FC7, $9FCC, $9FD1, $9FDA, $9FE3, $9FE3, $9FE3
L9DF0:	.word $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3
L9E00:	.word $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3, $9FE3
L9E10:	.word $9FE3, $9FE3, $9FF1, $9FFF, $A00B, $A019, $A027, $A033
L9E20:	.word $A03C, $A046, $A050, $A059, $A063, $A06D, $A06D, $A06D
L9E30:	.word $A07B, $A082, $A08B, $A08B, $A08B, $A08B, $A08B, $A08B
L9E40:	.word $A08B, $A08B, $A08B, $A08B, $A08B, $A08B, $A08B, $A08B
L9E50:	.word $A09F, $A0B3, $A0BE, $A0C9, $A0D2, $A0DB, $A0E6, $A0E6
L9E60:	.word $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9E70:	.word $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9E80:	.word $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6, $A0E6
L9E90:	.word $A0E6, $A0EE, $A0F6, $A0FE, $A106, $A10E, $A116, $A11E
L9EA0:	.word $A126, $A12E, $A13C, $A156, $A162, $A16F, $A177, $A17F
L9EB0:	.word $A187, $A18F, $A197, $A19F, $A1A7, $A1AF, $A1B7, $A1BF
L9EC0:	.word $A1C7, $A1CF, $A1D7, $A1DF, $A1E7, $A1EF, $A1F7, $A1F7
L9ED0:	.word $A1F7, $A1F7, $A1F7, $A1F7, $A1F7, $A1F7, $A1F7, $A1F7

EnemyFramePtrTbl2:
L9EE0:	.word $A1F7, $A1FF, $A204, $A204, $A204, $A204, $A204, $A204
L9EF0:	.word $A204, $A204, $A209, $A209, $A209, $A209, $A209, $A209
L9F00:	.word $A213, $A21D, $A22D, $A23D, $A24D, $A25D, $A267

EnemyPlacePtrTbl:
L9F0E:	.word $9F2E, $9F30, $9F48, $9F60, $9F60, $9F60, $9F70, $9F7C
L9F1E:	.word $9F84, $9F90, $9F90, $9FB0, $9FBE, $9FBE, $9FBE, $9FBE

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9F2E:	.byte $FC, $FC

;Enemy explode.
L9F30:	.byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9F40:	.byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9F48:	.byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
L9F58:	.byte $00, $04, $08, $F4, $08, $FC, $08, $04

L9F60:	.byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9F70:	.byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

L9F7C:	.byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

L9F84:	.byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

L9F90:	.byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9FA0:	.byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9FB0:	.byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9FBE:	.byte $FC, $F8, $FC, $00 

;Enemy frame drawing data.

L9FC2:	.byte $00, $02, $02, $14, $FF

L9FC7:	.byte $00, $02, $02, $24, $FF

L9FCC:	.byte $00, $00, $00, $04, $FF

L9FD1:	.byte $27, $06, $08, $FC, $04, $00, $D0, $D1, $FF

L9FDA:	.byte $67, $06, $08, $FC, $04, $00, $D0, $D1, $FF

L9FE3:	.byte $25, $08, $0A, $A3, $B3, $A4, $B4, $FE, $FE, $FD, $62, $A3, $B3, $FF

L9FF1:	.byte $25, $08, $0A, $A5, $B3, $FE, $FE, $A4, $B4, $FD, $62, $A5, $B3, $FF

L9FFF:	.byte $26, $08, $0A, $B5, $B3, $A4, $B4, $FD, $62, $B5, $B3, $FF

LA00B:	.byte $A5, $08, $0A, $A3, $B3, $A4, $B4, $FE, $FE, $FD, $E2, $A3, $B3, $FF

LA019:	.byte $A5, $08, $0A, $A5, $B3, $FE, $FE, $A4, $B4, $FD, $E2, $A5, $B3, $FF

LA027:	.byte $A6, $08, $0A, $B5, $B3, $A4, $B4, $FD, $E2, $B5, $B3, $FF

LA033:	.byte $27, $06, $08, $FC, $04, $00, $C0, $C1, $FF

LA03C:	.byte $27, $06, $08, $E0, $E1, $FD, $A2, $E0, $E1, $FF

LA046:	.byte $27, $06, $08, $F0, $F1, $FD, $A2, $F0, $F1, $FF

LA050:	.byte $67, $06, $08, $FC, $04, $00, $C0, $C1, $FF

LA059:	.byte $67, $06, $08, $E0, $E1, $FD, $E2, $E0, $E1, $FF

LA063:	.byte $67, $06, $08, $F0, $F1, $FD, $E2, $F0, $F1, $FF

LA06D:	.byte $28, $0C, $08, $CE, $FC, $00, $FC, $DE, $EE, $DF, $FD, $62, $EE, $FF

LA07B:	.byte $28, $0C, $08, $CE, $CF, $EF, $FF

LA082:	.byte $28, $0C, $08, $CE, $FD, $62, $CF, $EF, $FF

LA08B:	.byte $21, $00, $00, $FC, $08, $FC, $A3, $FC, $00, $08, $A3, $FC, $00, $F8, $B3, $FC
LA09B:	.byte $00, $08, $B3, $FF

LA09F:	.byte $21, $00, $00, $FC, $00, $FC, $B3, $FC, $00, $08, $B3, $FC, $00, $F8, $A3, $FC
LA0AF:	.byte $00, $08, $A3, $FF

LA0B3:	.byte $21, $00, $00, $FC, $04, $00, $F1, $F0, $F1, $F0, $FF

LA0BE:	.byte $21, $00, $00, $FC, $04, $00, $F0, $F1, $F0, $F1, $FF

LA0C9:	.byte $21, $00, $00, $FC, $08, $00, $D1, $D0, $FF

LA0D2:	.byte $21, $00, $00, $FC, $08, $00, $D0, $D1, $FF

LA0DB:	.byte $21, $00, $00, $FC, $08, $00, $DE, $DF, $EE, $EE, $FF

LA0E6:	.byte $27, $08, $08, $CC, $CD, $DC, $DD, $FF

LA0EE:	.byte $67, $08, $08, $CC, $CD, $DC, $DD, $FF

LA0F6:	.byte $27, $08, $08, $CA, $CB, $DA, $DB, $FF

LA0FE:	.byte $A7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA106:	.byte $A7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA10E:	.byte $E7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA116:	.byte $67, $08, $08, $CA, $CB, $DA, $DB, $FF

LA11E:	.byte $E7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA126:	.byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA12E:	.byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA13C:	.byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA14C:	.byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA156:	.byte $2B, $08, $08, $E2, $E3, $E4, $FE, $FD, $62, $E3, $E4, $FF

LA162:	.byte $2B, $08, $08, $E2, $E3, $FE, $E4, $FD, $62, $E3, $FE, $E4, $FF

LA16F:	.byte $21, $00, $00, $96, $96, $98, $98, $FF

LA177:	.byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA17F:	.byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA187:	.byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA18F:	.byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA197:	.byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA19F:	.byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA1A7:	.byte $20, $02, $04, $FC, $FF

LA1AC:	.byte $00, $F8, $FF

LA1AF:	.byte $60, $02, $04, $FC, $FF

LA1B4:	.byte $00, $F8, $FF

LA1B7:	.byte $20, $02, $02, $FC, $FE, $00, $D9, $FF

LA1BF:	.byte $E0, $02, $02, $FC, $00, $02, $D8, $FF

LA1C7:	.byte $E0, $02, $02, $FC, $02, $00, $D9, $FF

LA1CF:	.byte $20, $02, $02, $FC, $00, $FE, $D8, $FF

LA1D7:	.byte $60, $02, $02, $FC, $FE, $00, $D9, $FF

LA1DF:	.byte $A0, $02, $02, $FC, $00, $FE, $D8, $FF

LA1E7:	.byte $A0, $02, $02, $FC, $02, $00, $D9, $FF

LA1EF:	.byte $60, $02, $02, $FC, $00, $02, $D8, $FF

LA1F7:	.byte $06, $08, $04, $FE, $FE, $14, $24, $FF

LA1FF:	.byte $00, $04, $04, $8A, $FF

LA204:	.byte $00, $04, $04, $8A, $FF

LA209:	.byte $3F, $04, $08, $FD, $03, $EC, $FD, $43, $EC, $FF

LA213:	.byte $3F, $04, $08, $FD, $03, $ED, $FD, $43, $ED, $FF

LA21D:	.byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA22D:	.byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA23D:	.byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA24D:	.byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA25D:	.byte $21, $00, $00, $C5, $C7, $D5, $D7, $E5, $E7, $FF

LA267:	.byte $21, $00, $00, $C7, $C5, $D7, $D5, $E7, $E5, $FF

;----------------------------------------[ Palette data ]--------------------------------------------

Palette00:
LA271:	.byte $3F			;Upper byte of PPU palette adress.
LA272:	.byte $00			;Lower byte of PPU palette adress.
LA273:	.byte $20			;Palette data length.
;The following values are written to the background palette:
LA274:	.byte $0F, $22, $12, $1C, $0F, $22, $12, $1C, $0F, $27, $11, $07, $0F, $22, $12, $1C
;The following values are written to the sprite palette:
LA284:	.byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $2A, $3C, $0F, $15, $21, $38

LA294:	.byte $00			;End Palette00 info.

Palette01:
LA295:	.byte $3F			;Upper byte of PPU palette adress.
LA296:	.byte $12			;Lower byte of PPU palette adress.
LA297:	.byte $02			;Palette data length.
;The following values are written to the sprite palette:
LA298:	.byte $19, $27

LA29A:	.byte $00			;End Palette01 info.

Palette03:
LA29B:	.byte $3F			;Upper byte of PPU palette adress.
LA29C:	.byte $12			;Lower byte of PPU palette adress.
LA29D:	.byte $02			;Palette data length.
;The following values are written to the sprite palette:
LA29E:	.byte $2C, $27

LA2A0:	.byte $00			;End Palette02 info.

Palette02:
LA2A1:	.byte $3F			;Upper byte of PPU palette adress.
LA2A2:	.byte $12			;Lower byte of PPU palette adress.
LA2A3:	.byte $02			;Palette data length.
;The following values are written to the sprite palette:
LA2A4:	.byte $19, $35

LA2A6:	.byte $00			;End Palette03 info.

Palette04:
LA2A7:	.byte $3F			;Upper byte of PPU palette adress.
LA2A8:	.byte $12			;Lower byte of PPU palette adress.
LA2A9:	.byte $02			;Palette data length.
;The following values are written to the sprite palette:
LA2AA:	.byte $2C, $24

LA2AC:	.byte $00			;End Palette04 info.

Palette05:
LA2AD:	.byte $3F			;Upper byte of PPU palette adress.
LA2AE:	.byte $00			;Lower byte of PPU palette adress.
LA2AF:	.byte $10			;Palette data length.
;The following values are written to the background palette:
LA2B0:	.byte $0F, $20, $10, $00, $0F, $28, $19, $17, $0F, $27, $11, $07, $0F, $28, $16, $17
LA2C0:	.byte $3F			;Upper byte of PPU palette adress.
LA2C1:	.byte $14			;Lower byte of PPU palette adress.
LA2C2:	.byte $0C			;Palette data length.
;The following values are written to the sprite palette:
LA2C3:	.byte $0F, $12, $30, $21, $0F, $26, $1A, $31, $0F, $15, $21, $38

LA2CF:	.byte $00			;End Palette05 info.

Palette06:
LA2D0:	.byte $3F			;Upper byte of PPU palette adress.
LA2D1:	.byte $11			;Lower byte of PPU palette adress.
LA2D2:	.byte $03			;Palette data length.
;The following values are written to the sprite palette:
LA2D3:	.byte $04, $09, $07

LA2D6:	.byte $00			;End Palette06 info.

Palette07:
LA2D7:	.byte $3F			;Upper byte of PPU palette adress.
LA2D8:	.byte $11			;Lower byte of PPU palette adress.
LA2D9:	.byte $03			;Palette data length.
;The following values are written to the sprite palette:
LA2DA:	.byte $05, $09, $17

LA2DD:	.byte $00			;End Palette07 info.

Palette08:
LA2DE:	.byte $3F			;Upper byte of PPU palette adress.
LA2DF:	.byte $11			;Lower byte of PPU palette adress.
LA2E0:	.byte $03			;Palette data length.
;The following values are written to the sprite palette:
LA2E1:	.byte $06, $0A, $26

LA2E4:	.byte $00			;End Palette08 info.

Palette09:
LA2E5:	.byte $3F			;Upper byte of PPU palette adress.
LA2E6:	.byte $11			;Lower byte of PPU palette adress.
LA2E7:	.byte $03			;Palette data length.
;The following values are written to the sprite palette:
LA2E8:	.byte $16, $19, $27

LA2EB:	.byte $00			;End Palette09 info.

Palette0A:
LA2EC:	.byte $3F			;Upper byte of PPU palette adress.
LA2ED:	.byte $00			;Lower byte of PPU palette adress.
LA2EE:	.byte $04			;Palette data length.
;The following values are written to the background palette:
LA2EF:	.byte $0F, $30, $30, $21

LA2F3:	.byte $00			;End Palette0A info.

Palette0B:
LA2F4:	.byte $3F			;Upper byte of PPU palette adress.
LA2F5:	.byte $10			;Lower byte of PPU palette adress.
LA2F6:	.byte $04			;Palette data length.
;The following values are written to the sprite palette:
LA2F7:	.byte $0F, $15, $34, $17

LA2FB:	.byte $00			;End Palette0B info.

Palette0C:
LA2FC:	.byte $3F			;Upper byte of PPU palette adress.
LA2FD:	.byte $10			;Lower byte of PPU palette adress.
LA2FE:	.byte $04			;Palette data length.
;The following values are written to the sprite palette:
LA2FF:	.byte $0F, $15, $34, $19

LA303:	.byte $00			;End Palette0C info.

Palette0D:
LA304:	.byte $3F			;Upper byte of PPU palette adress.
LA305:	.byte $10			;Lower byte of PPU palette adress.
LA306:	.byte $04			;Palette data length.
;The following values are written to the sprite palette:
LA307:	.byte $0F, $15, $34, $28

LA30B:	.byte $00			;End Palette0D info.

Palette0E:
LA30C:	.byte $3F			;Upper byte of PPU palette adress.
LA30D:	.byte $10			;Lower byte of PPU palette adress.
LA30E:	.byte $04			;Palette data length.
;The following values are written to the sprite palette:
LA30F:	.byte $0F, $15, $34, $29

LA313:	.byte $00			;End Palette0E info.

;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
LA314:	.word $A441, $A454, $A45C, $A480, $A4BB, $A4ED, $A524, $A55A
LA324:	.word $A587, $A5B9, $A5DD, $A615, $A635, $A661, $A68D, $A6B1
LA334:	.word $A6DB, $A715, $A73C, $A768, $A78B, $A7A3, $A7D0, $A7F1
LA344:	.word $A81B, $A85B, $A88B, $A8B1, $A8E7, $A910, $A92B, $A96B
LA354:	.word $A997, $A9C6, $A9F6, $AA20, $AA56, $AAA4, $AAE6, $AB19
LA364:	.word $AB48, $AB71, $AB92, $ABBF, $AC24, $AC4D, $AC6A 

StrctPtrTbl:
LA372:	.word $AC84, $AC97, $ACB0, $ACC9, $ACD0, $ACD7, $ACDB, $ACE6
LA382:	.word $ACF3, $ACFF, $AD05, $AD0A, $AD1A, $AD1E, $AD28, $AD4D 
LA392:	.word $AD57, $AD6A, $AD7F, $AD8E, $AD98, $ADA2, $ADAD, $ADBE
LA3A2:	.word $ADE3, $ADE6, $ADEC, $ADF9, $AE09, $AE13, $AE18, $AE2D
LA3B2:	.word $AE42, $AE48, $AE4B, $AE5F, $AE70, $AE85, $AE8E, $AE92
LA3C2:	.word $AEA5, $AEB0, $AEB3, $AEBE, $AEC8, $AECB, $AEDE, $AEE1
LA3D2:	.word $AEE4, $AEED 

;------------------------------------[ Special items table ]-----------------------------------------

;The way the bytes work int the special items table is as follows:
;Long entry(one with a data word in it):
;Byte 0=Y coordinate of room on the world map.
;Word 0=Address of next entry in the table that has a different Y coordinate.--> 
;	$FFFF=No more items with different Y coordinates.
;Byte 1=X coordinate of room in the world map.
;Byte 2=byte offset-1 of next special item in the table that has the same-->
;	Y coordinate(short entry). $FF=No more items with different X-->
;	coordinates until next long entry.
;Byte 3=Item type. See list below for special item types.
;Bytes 4 to end of entry(ends with #$00)=Data bytes for special item(s).-->
;	It is possible to have multiple special items in one room.
;
;Short entry(one without a data word in it):
;Byte 0=X coordinate of room in the world map(Y coordinate is the same-->
;	as the last long item entry in the table).
;Byte 1=byte offset-1 of next special item in the table that has the same-->
;	Y coordinate(short entry). $FF=No more items with different X-->
;	coordinates until next long entry.
;Byte 2=Item type. See list below for special item types.
;Bytes 3 to end of entry(ends with #$00)=Data bytes for special item(s).-->
;	It is possible to have multiple special items in one room.
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
LA3D6:	.byte $02
LA3D7:	.word $A3E4
LA3D9:	.byte $03, $05, $04, $03, $00

;Varia suit.
LA3DE:	.byte $0F, $FF, $02, $05, $37, $00

;Missiles.
LA3E4:	.byte $03
LA3E5:	.word $A3F3
LA3E7:	.byte $18, $06, $02, $09, $67, $00

;Energy tank.
LA3ED:	.byte $1B, $FF, $02, $08, $87, $00

;Long beam.
LA3F3:	.byte $05
LA3F4:	.word $A402
LA3F6:	.byte $07, $06, $02, $02, $37, $00

;Bombs.
LA3FC:	.byte $19, $FF, $02, $00, $37, $00

;Palette change room.
LA402:	.byte $07
LA403:	.word $A40F
LA405:	.byte $0C, $04, $0A, $00

;Energy tank.
LA409:	.byte $19, $FF, $02, $08, $87, $00

;Ice beam.
LA40F:	.byte $09
LA410:	.word $A41C
LA412:	.byte $13, $06, $02, $07, $37, $00

;Mellows.
LA418:	.byte $15, $FF, $03, $00

;Missiles.
LA41C:	.byte $0B
LA41D:	.word $A42A
LA41F:	.byte $12, $06, $02, $09, $67, $00

;Elevator to Norfair.
LA425:	.byte $16, $FF, $04, $01, $00

;Maru Mari.
LA42A:	.byte $0E
LA42B:	.word $A439
LA42D:	.byte $02, $06, $02, $04, $96, $00

;Energy tank.
LA433:	.byte $09, $FF, $02, $08, $12, $00

;Elevator to Kraid.
LA439:	.byte $12
LA43A:	.word $FFFF
LA43C:	.byte $07, $FF, $04, $02, $00

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
LA441:	.byte $02				;Attribute table data.
;Room object data:
LAA42:	.byte $40, $01, $02, $48, $01, $02, $50, $03, $02, $5F, $03, $02, $FD
;Room enemy/door data:
LAA4F:	.byte $02, $A1, $02, $B1, $FF

;Room #$01
LA454:	.byte $02				;Attribute table data.
;Room object data:
LA455:	.byte $07, $02, $02, $87, $02, $02, $FF

;Room #$02
LA45C:	.byte $03				;Attribute table data.
;Room object data:
LA45D:	.byte $00, $0B, $03, $0E, $0B, $03, $50, $0B, $03, $5E, $0B, $03, $A0, $0B, $03, $AE
LA46D:	.byte $0B, $03, $FD
;Room enemy/door data: 
LA470:	.byte $01, $03, $42, $11, $83, $8A, $21, $03, $B5, $31, $02, $59, $41, $02, $A3, $FF

;Room #$03
LA480:	.byte $02				;Attribute table data.
;Room object data:
LA481:	.byte $00, $0B, $03, $02, $09, $03, $0E, $0B, $03, $50, $0B, $03, $56, $0A, $03, $5F
LA491:	.byte $03, $02, $8B, $0A, $03, $8E, $0B, $03, $92, $0A, $03, $A0, $0B, $03, $C7, $09
LA4A1:	.byte $03, $DE, $0B, $03, $FD 
;Room enemy/door data:
LA4A6:	.byte $02, $A1, $01, $85, $47, $11, $05, $BA, $21, $03, $08, $31, $83, $53, $41, $83
LA4B6:	.byte $97, $51, $03, $C5, $FF

;Room #$04
LA4BB:	.byte $03				;Attribute table data.
;Room object data:
LA4BC:	.byte $00, $0B, $03, $04, $0A, $03, $0E, $0B, $03, $47, $09, $03, $50, $03, $02, $5E
LA4CC:	.byte $0B, $03, $80, $0B, $03, $82, $0A, $03, $9C, $0A, $03, $AE, $0B, $03, $B6, $0A
LA4DC:	.byte $03, $C0, $0B, $03, $FD
;Room enemy/door data:
LA4E1:	.byte $02, $B1, $41, $03, $45, $51, $03, $BB, $31, $05, $39, $FF 

;Room #$05
LA4ED:	.byte $03				;Attribute table data.
;Room object data:
LA4EE:	.byte $00, $0B, $03, $0E, $0B, $03, $15, $09, $03, $50, $03, $02, $57, $0A, $03, $5F
LA4FE:	.byte $03, $02, $80, $0B, $03, $82, $0A, $03, $8B, $0A, $03, $8E, $0B, $03, $B0, $0B
LA50E:	.byte $03, $C6, $09, $03, $CE, $0B, $03, $FD
;Room enemy/door data:
LA516:	.byte $02, $A1, $02, $B1, $01, $83, $43, $31, $85, $48, $51, $05, $B7, $FF

;Room #$06
LA524:	.byte $03				;Attribute table data.
;Room object data:
LA525:	.byte $00, $0B, $03, $0E, $0B, $03, $12, $0A, $03, $37, $0A, $03, $50, $0B, $03, $5E
LA535:	.byte $0B, $03, $73, $0A, $03, $8A, $0A, $03, $A0, $0B, $03, $AE, $0B, $03, $B6, $09
LA545:	.byte $03, $FD 
;Room enemy/door data:
LA547:	.byte $01, $03, $B3, $11, $03, $3C, $21, $05, $A8, $31, $05, $64, $51, $85, $7B, $41
LA557:	.byte $05, $28, $FF

;Room #$07
LA55A:	.byte $03				;Attribute table data.
;Room object data:
LA55B:	.byte $00, $0D, $03, $08, $0D, $03, $54, $06, $03, $5A, $06, $03, $67, $07, $03, $A0
LA56B:	.byte $0B, $03, $AE, $0B, $03, $C2, $06, $03, $CD, $06, $03, $D2, $00, $02, $D6, $00
LA57B:	.byte $02, $FD
;Room enemy/door data:
LA57D:	.byte $51, $05, $B2, $41, $05, $BD, $31, $05, $67, $FF

;Room #$08
LA587:	.byte $03				;Attribute table data.
;Room object data:
LA588:	.byte $00, $1E, $03, $04, $1E, $03, $08, $1E, $03, $0C, $1E, $03, $38, $1E, $03, $40
LA598:	.byte $1E, $03, $44, $1E, $03, $4C, $1E, $03, $74, $1E, $03, $78, $1E, $03, $80, $1E
LA5A8:	.byte $03, $8C, $1E, $03, $B0, $1E, $03, $B4, $1E, $03, $B8, $1E, $03, $CC, $1E, $03
LA5B8:	.byte $FF

;Room #$09(Starting room).
LA5B9:	.byte $03				;Attribute table data.
;Room object data:
LA5BA:	.byte $00, $11, $01, $08, $11, $01, $35, $1D, $03, $3B, $1D, $03, $55, $0B, $03, $5A
LA5CA:	.byte $0B, $03, $C5, $16, $00, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data: 
LA5D6:	.byte $51, $05, $25, $41, $05, $2B, $FF

;Room #$0A
LA5DD:	.byte $00				;Attribute table data.
;Room object data:
LA5DE:	.byte $00, $14, $00, $08, $14, $00, $0F, $15, $00, $10, $15, $00, $14, $15, $00, $25
LA5EE:	.byte $08, $03, $50, $14, $00, $58, $0C, $00, $5F, $04, $02, $60, $14, $00, $70, $13
LA5FE:	.byte $00, $80, $14, $00, $88, $14, $00, $90, $16, $00, $99, $16, $00, $B3, $15, $00
LA60E:	.byte $BC, $15, $00, $FD
;Room enemy/door data: 
LA612:	.byte $02, $A0, $FF

;Room #$0B
LA615:	.byte $00				;Attribute table data.
;Room object data:
LA616:	.byte $00, $15, $00, $01, $16, $00, $08, $16, $00, $0F, $15, $00, $4F, $15, $00, $50
LA626:	.byte $04, $02, $80, $16, $00, $87, $02, $02, $89, $16, $00, $FD
;Room enemy/door data:
LA632:	.byte $02, $B1, $FF

;Room #$0C
LA635:	.byte $02				;Attribute table data.
;Room object data:
LA636:	.byte $00, $1B, $02, $08, $1B, $02, $10, $1A, $02, $50, $03, $02, $80, $1A, $02, $82
LA646:	.byte $19, $02, $BC, $19, $02, $C0, $1A, $02, $C6, $1B, $02, $D1, $00, $02, $D9, $00
LA656:	.byte $02, $FD
;Room enemy/door data:
LA658:	.byte $02, $B1, $51, $02, $5A, $31, $02, $AA, $FF

;Room #$0D
LA661:	.byte $02				;Attribute table data.
;Room object data:
LA662:	.byte $00, $1B, $02, $08, $1B, $02, $1E, $1A, $02, $5F, $03, $02, $8C, $19, $02, $8E
LA672:	.byte $1A, $02, $B7, $1A, $02, $C2, $1A, $02, $CE, $1A, $02, $D0, $00, $02, $D7, $00
LA682:	.byte $02, $FD
;Room enemy/door data:
LA684:	.byte $02, $A1, $31, $05, $B3, $51, $02, $44, $FF

;Room #$0E
LA68D:	.byte $02				;Attribute table data.
;Room object data:
LA68E:	.byte $00, $1B, $02, $08, $1B, $02, $AC, $19, $02, $B4, $19, $02, $B8, $1A, $02, $D0
LA69E:	.byte $00, $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA6A4:	.byte $01, $82, $28, $11, $05, $A5, $21, $02, $8B, $31, $02, $BD, $FF 

;Room #$0F
LA6B1:	.byte $03				;Attribute table data.
;Room object data:
LA6B2:	.byte $00, $1B, $02, $08, $1B, $02, $59, $06, $03, $92, $19, $02, $AC, $19, $02, $BB
LA6C2:	.byte $19, $02, $C0, $06, $03, $D0, $00, $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA6CE:	.byte $01, $02, $3B, $11, $02, $B8, $51, $85, $84, $41, $05, $49, $FF

;Room #$10
LA6DB:	.byte $02				;Attribute table data.
;Room object data:
LA6DC:	.byte $00, $17, $02, $08, $17, $02, $10, $17, $02, $18, $17, $02, $50, $03, $02, $5F
LA6EC:	.byte $03, $02, $80, $1A, $02, $82, $19, $02, $86, $2E, $02, $87, $1B, $02, $8E, $1A
LA6FC:	.byte $02, $C0, $1A, $02, $CE, $1A, $02, $D2, $12, $02, $D8, $12, $02, $FD
;Room enemy/door data:
LA70A:	.byte $02, $A1, $02, $B1, $01, $02, $5C, $11, $02, $A7, $FF

;Room #$11
LA715:	.byte $03				;Attribute table data.
;Room object data:
LA716:	.byte $00, $0B, $03, $02, $06, $03, $0E, $0B, $03, $50, $0B, $03, $52, $06, $03, $5E
LA726:	.byte $0B, $03, $A0, $0B, $03, $A2, $06, $03, $AE, $0B, $03, $FD
;Room enemy/door data:
LA732:	.byte $01, $83, $DD, $11, $03, $35, $21, $02, $7D, $FF

;Room #$12
LA73C:	.byte $03				;Attribute table data.
;Room object data:
LA73D:	.byte $00, $0B, $03, $02, $11, $01, $0A, $11, $01, $50, $03, $02, $80, $0B, $03, $82
LA74D:	.byte $0A, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA756:	.byte $02, $B1, $01, $05, $C7, $11, $05, $CB, $51, $04, $3A, $41, $04, $29, $31, $04
LA766:	.byte $1E, $FF

;Room #$13
LA768:	.byte $03				;Attribute table data.
;Room object data:
LA769:	.byte $00, $11, $01, $07, $10, $03, $0E, $0B, $03, $5F, $03, $02, $8A, $09, $03, $8E
LA779:	.byte $0B, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA782:	.byte $02, $A1, $01, $05, $7B, $11, $05, $C8, $FF

;Room #$14
LA78B:	.byte $01				;Attribute table data.
;Room object data:
LA78C:	.byte $00, $11, $01, $08, $11, $01, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA799:	.byte $51, $04, $14, $21, $04, $38, $41, $04, $2E, $FF

;Room #$15
LA7A3:	.byte $03				;Attribute table data.
;Room object data:
LA7A4:	.byte $00, $10, $03, $08, $10, $03, $90, $1F, $01, $96, $1F, $01, $AA, $05, $03, $AC
LA7B4:	.byte $1F, $01, $BA, $10, $03, $C4, $05, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA7C3:	.byte $51, $05, $89, $37, $87, $AB, $21, $06, $23, $17, $07, $C5, $FF

;Room #$16
LA7D0:	.byte $01				;Attribute table data.
;Room object data:
LA7D1:	.byte $00, $11, $01, $08, $11, $01, $B0, $1F, $01, $B6, $05, $03, $B8, $05, $03, $BC
LA7E1:	.byte $1F, $01, $C6, $1F, $01, $D4, $00, $02, $FD
;Room enemy/door data:
LA7EA:	.byte $07, $07, $B7, $47, $87, $B9, $FF

;Room #$17
LA7F1:	.byte $03				;Attribute table data.
;Room object data:
LA7F2:	.byte $00, $11, $01, $08, $10, $03, $4A, $1E, $03, $6B, $1E, $03, $8C, $1E, $03, $A6
LA802:	.byte $15, $00, $B3, $1D, $03, $B9, $1D, $03, $C3, $0C, $00, $C8, $0C, $00, $D0, $10
LA812:	.byte $03, $D8, $10, $03, $FD
;Room enemy/door data:
LA817:	.byte $41, $05, $B4, $FF

;Room #$18
LA81B:	.byte $01				;Attribute table data.
;Room object data:
LA81C:	.byte $00, $0B, $03, $01, $11, $01, $09, $11, $01, $0E, $0B, $03, $50, $03, $02, $5F
LA82C:	.byte $03, $02, $64, $0D, $03, $66, $20, $01, $80, $1F, $01, $84, $20, $01, $88, $20
LA83C:	.byte $01, $8C, $1E, $03, $A6, $20, $01, $B0, $0B, $03, $BE, $0B, $03, $E6, $20, $01
LA84C:	.byte $FD
;Room enemy/door data:
LA84D:	.byte $02, $A1, $02, $B1, $31, $05, $56, $01, $85, $5A, $21, $05, $D9, $FF

;Room #$19
LA85B:	.byte $01				;Attribute table data.
;Room object data:
LA85C:	.byte $00, $10, $03, $04, $1F, $01, $08, $1F, $01, $0C, $11, $01, $12, $31, $03, $44
LA86C:	.byte $1F, $01, $48, $1F, $01, $84, $1F, $01, $88, $1F, $01, $D0, $1F, $01, $D4, $1F
LA87C:	.byte $01, $D8, $10, $03, $FD
;Room enemy/door data:
LA881:	.byte $51, $05, $C0, $41, $05, $CA, $31, $06, $3C, $FF

;Room #$1A
LA88B:	.byte $02				;Attribute table data.
;Room object data:
LA88C:	.byte $00, $28, $02, $01, $2D, $02, $09, $2D, $02, $50, $04, $02, $80, $28, $02, $81
LA89C:	.byte $14, $00, $95, $15, $00, $D0, $2D, $02, $D8, $2D, $02, $FD
;Room enemy/door data:
LA8A8:	.byte $02, $B0, $01, $05, $C7, $11, $85, $CA, $FF

;Room #$1B
LA8B1:	.byte $00				;Attribute table data.
;Room object data:
LA8B2:	.byte $00, $14, $00, $04, $15, $00, $08, $14, $00, $0A, $15, $00, $97, $06, $03, $A0
LA8C2:	.byte $0B, $03, $A6, $15, $00, $A8, $15, $00, $AE, $0B, $03, $B4, $06, $03, $BA, $06
LA8D2:	.byte $03, $C2, $06, $03, $D2, $00, $02, $D6, $00, $02, $FD
;Room enemy/door data:
LA8DD:	.byte $41, $05, $AA, $21, $06, $17, $11, $05, $A4, $FF

;Room #$1C
LA8E7:	.byte $00				;Attribute table data.
;Room object data:
LA8E8:	.byte $00, $15, $00, $01, $0D, $03, $09, $0E, $01, $2A, $23, $01, $37, $22, $03, $4D
LA8F8:	.byte $0E, $01, $50, $03, $02, $6A, $16, $00, $6D, $0E, $01, $80, $14, $00, $87, $02
LA908:	.byte $02, $89, $14, $00, $FD
;Room enemy/door data:
LA90D:	.byte $02, $B1, $FF

;Room #$1D
LA910:	.byte $01				;Attribute table data.
;Room object data:
LA911:	.byte $00, $0E, $01, $08, $0E, $01, $44, $0E, $01, $84, $0F, $01, $94, $0E, $01, $B0
LA921:	.byte $0E, $01, $B8, $0E, $01, $FD 
;Room enemy/door data:
LA927:	.byte $31, $06, $42, $FF

;Room #$1E
LA92B:	.byte $01				;Attribute table data.
;Room object data:
LA92C:	.byte $00, $0E, $01, $02, $2A, $01, $07, $25, $01, $08, $0E, $01, $10, $0E, $01, $12
LA93c:	.byte $2A, $01, $17, $25, $01, $18, $0E, $01, $50, $03, $02, $5F, $03, $02, $74, $26
LA94C:	.byte $01, $78, $26, $01, $80, $0E, $01, $88, $0E, $01, $C0, $24, $01, $CC, $24, $01
LA95C:	.byte $D4, $00, $02, $FD
;Room enemy/door data:
LA960:	.byte $02, $A1, $02, $B1, $11, $02, $52, $01, $03, $C8, $FF

;Room #$1F
LA96B:	.byte $01				;Attribute table data.
;Room object data:
LA96C:	.byte $00, $27, $01, $08, $27, $01, $10, $24, $01, $50, $03, $02, $80, $24, $01, $A6
LA97C:	.byte $26, $01, $B0, $0E, $01, $CA, $26, $01, $D8, $0E, $01, $FD
;Room enemy/door data:
LA988:	.byte $02, $B1, $01, $02, $2B, $11, $02, $BB, $21, $82, $5B, $31, $02, $8B, $FF

;Room #$20
LA997:	.byte $01				;Attribute table data.
;Room object data:
LA998:	.byte $00, $27, $01, $08, $27, $01, $1C, $24, $01, $20, $24, $01, $5F, $03, $02, $8C
LA9A8:	.byte $24, $01, $BA, $26, $01, $C4, $26, $01, $C8, $0E, $01, $D0, $0E, $01, $FD 
;Room enemy/door data:
LA9B7:	.byte $02, $A1, $51, $02, $85, $41, $02, $C5, $31, $05, $BA, $21, $05, $C5, $FF

;Room #$21
LA9C6:	.byte $01				;Attribute table data.
;Room object data:
LA9C7:	.byte $00, $0E, $01, $08, $0E, $01, $30, $0E, $01, $38, $0E, $01, $A7, $26, $01, $B0
LA9D7:	.byte $24, $01, $B6, $24, $01, $BC, $24, $01, $C4, $05, $03, $D4, $27, $01, $DA, $00
LA9E7:	.byte $02, $FD
;Room enemy/door data:
LA9E9:	.byte $07, $07, $C5, $11, $05, $AC, $21, $05, $A8, $51, $06, $7A, $FF

;Room #$22
LA9F6:	.byte $01				;Attribute table data.
;Room object data:
LA9F7:	.byte $00, $0E, $01, $08, $0E, $01, $30, $0E, $01, $37, $25, $01, $48, $2A, $01, $4C
LAA07:	.byte $2A, $01, $68, $0E, $01, $78, $0E, $01, $A3, $26, $01, $B0, $0E, $01, $B8, $0E
LAA17:	.byte $01, $FD
;Room enemy/door data:
LAA19:	.byte $41, $06, $75, $21, $03, $85, $FF

;Room #$23
LAA20:	.byte $02				;Attribute table data.
;Room object data:
LAA21:	.byte $00, $27, $01, $08, $27, $01, $63, $29, $01, $73, $28, $02, $8B, $29, $01, $9B
LAA31:	.byte $28, $02, $C0, $26, $01, $C6, $26, $01, $D0, $0E, $01, $D8, $00, $02, $D9, $0E
LAA41:	.byte $01, $DE, $05, $03, $FD
;Room enemy/door data:
LAA46:	.byte $01, $85, $63, $11, $05, $8B, $21, $02, $6E, $47, $07, $DF, $31, $83, $A8, $FF

;Room #$24
LAA56:	.byte $01				;Attribute table data.
;Room object data:
LAA57:	.byte $00, $0E, $01, $08, $0E, $01, $40, $2B, $00, $48, $2B, $00, $50, $0E, $01, $53
LAA67:	.byte $20, $01, $58, $0E, $01, $5B, $20, $01, $60, $2B, $00, $68, $13, $00, $70, $27
LAA77:	.byte $01, $78, $27, $01, $80, $2B, $00, $88, $2B, $00, $90, $27, $01, $98, $27, $01
LAA87:	.byte $A0, $13, $00, $A8, $2B, $00, $B0, $0E, $01, $B8, $0E, $01, $FD
;Room enemy/door data:
LAA94:	.byte $01, $05, $4D, $11, $85, $6C, $21, $05, $8A, $31, $85, $AF, $41, $05, $47, $FF

;Room #$25
LAAA4:	.byte $02				;Attribute table data.
;Room object data:
LAAA5:	.byte $00, $27, $01, $05, $27, $01, $0A, $0E, $01, $23, $24, $01, $4A, $13, $00, $52
LAAB5:	.byte $24, $01, $59, $20, $01, $5A, $0E, $01, $6A, $2B, $00, $79, $0E, $01, $89, $2B
LAAC5:	.byte $00, $90, $28, $02, $94, $06, $03, $98, $0E, $01, $A8, $13, $00, $B0, $0E, $01
LAAD5:	.byte $B8, $0E, $01, $FD
;Room enemy/door data:
LAAD9:	.byte $51, $05, $4F, $41, $05, $6E, $31, $05, $8E, $21, $02, $48, $FF

;Room #$26
LAAE6:	.byte $01				;Attribute table data.
;Room object data:
LAAE7:	.byte $00, $0E, $01, $08, $27, $01, $40, $2B, $00, $50, $0E, $01, $56, $20, $01, $60
LAAF7:	.byte $2B, $00, $68, $2C, $00, $80, $27, $01, $8B, $24, $01, $D0, $00, $02, $D8, $00
LAB07:	.byte $02, $FD
;Room enemy/door data:
LAB09:	.byte $51, $05, $67, $41, $05, $7E, $21, $05, $7B, $31, $03, $49, $11, $02, $C6, $FF

;Room #$27
LAB19:	.byte $03				;Attribute table data.
;Room object data:
LAB1A:	.byte $00, $0B, $03, $02, $11, $01, $09, $11, $01, $50, $04, $02, $80, $0B, $03, $82
LAB2A:	.byte $1E, $03, $B6, $1D, $03, $B7, $1D, $03, $C2, $09, $03, $C8, $1D, $03, $D0, $10
LAB3A:	.byte $03, $D8, $10, $03, $FD
;Room enemy/door data:
LAB3F:	.byte $02, $B0, $11, $04, $38, $31, $06, $27, $FF

;Room #$28
LAB48:	.byte $00				;Attribute table data.
;Room object data:
LAB49:	.byte $00, $2D, $02, $08, $2D, $02, $0F, $28, $02, $5F, $03, $02, $87, $14, $00, $8F
LAB59:	.byte $28, $02, $9A, $15, $00, $C3, $26, $01, $D0, $2D, $02, $D8, $2D, $02, $FD 
;Room enemy/door data:
LAB68:	.byte $02, $A1, $01, $06, $23, $31, $05, $7D, $FF

;Room #$29
LAB71:	.byte $02				;Attribute table data.
;Room object data:
LAB72:	.byte $00, $2D, $02, $08, $2D, $02, $C2, $26, $01, $C7, $26, $01, $C9, $26, $01, $D0
LAB82:	.byte $2D, $02, $D8, $2D, $02, $FD
;Room enemy/door data:
LAB88:	.byte $41, $86, $25, $51, $06, $2A, $21, $05, $CB, $FF

;Room #$2A
LAB92:	.byte $00				;Attribute table data.
;Room object data:
LAB93:	.byte $00, $11, $01, $08, $11, $01, $68, $21, $02, $78, $15, $00, $95, $15, $00, $A0
LABA3:	.byte $0B, $03, $AE, $0B, $03, $BB, $15, $00, $C2, $06, $03, $D2, $00, $02, $D6, $00
LABB3:	.byte $02, $FD
;Room enemy/door data:
LABB5:	.byte $01, $05, $58, $11, $05, $85, $31, $06, $26, $FF

;Room #$2B(Bridge to Tourian).
LABBF:	.byte $02				;Attribute table data.
;Room object data:
LABC0:	.byte $00, $30, $00, $01, $1A, $02, $02, $30, $00, $03, $1A, $02, $05, $1C, $02, $0A
LABD0:	.byte $1B, $02, $0F, $30, $00, $10, $30, $00, $14, $30, $00, $1F, $30, $00, $2C, $18
LABE0:	.byte $02, $35, $18, $02, $41, $19, $02, $44, $2F, $02, $45, $18, $02, $46, $2F, $02
LABF0:	.byte $50, $04, $02, $53, $19, $02, $5F, $04, $02, $64, $1C, $02, $65, $1C, $02, $68
LAC00:	.byte $2F, $02, $80, $15, $00, $81, $19, $02, $8D, $19, $02, $9C, $19, $02, $9F, $15
LAC10:	.byte $00, $C0, $30, $00, $D1, $00, $02, $D7, $00, $02, $DF, $30, $00, $FD
;Room enemy/door data:
LAC1E:	.byte $02, $A0, $02, $B1, $06, $FF

;Room #$2C
LAC24:	.byte $00				;Attribute table data.
;Room object data:
LAC25:	.byte $00, $16, $00, $07, $16, $00, $0E, $16, $00, $1F, $15, $00, $20, $15, $00, $40
LAC35:	.byte $30, $00, $5F, $04, $02, $80, $16, $00, $87, $02, $02, $89, $16, $00, $A0, $15
LAC45:	.byte $00, $AF, $15, $00, $FD
;Room enemy/door data:
LAC4A:	.byte $02, $A1, $FF

;Room #$2D
LAC4D:	.byte $03				;Attribute table data.
;Room object data:
LAC4E:	.byte $00, $11, $01, $08, $11, $01, $1E, $1E, $03, $5F, $04, $02, $8B, $10, $03, $9E
LAC5E:	.byte $0B, $03, $D0, $10, $03, $D8, $10, $03, $FD
;Room enemy/door data:
LAC67:	.byte $02, $A1, $FF

;Room #$2E
LAC6A:	.byte $03				;Attribute table data.
;Room object data:
LAC6B:	.byte $00, $0B, $03, $0E, $0B, $03, $50, $03, $02, $5E, $0B, $03, $80, $0B, $03, $AE
LAC7B:	.byte $0B, $03, $D0, $0B, $03, $FD
;Room enemy/door data:
LAC81:	.byte $02, $B1, $FF

;---------------------------------------[ Structure definitions ]------------------------------------

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LAC84:	.byte $08, $01, $01, $01, $01, $01, $01, $01, $01, $08, $00, $00, $00, $00, $00, $00
LAC94:	.byte $00, $00, $FF

;Structure #$01
LAC97:	.byte $08, $02, $02, $02, $02, $02, $02, $02, $02, $01, $28, $01, $28, $01, $28, $08
LACA7:	.byte $02, $02, $02, $02, $02, $02, $02, $02, $FF

;Structure #$02
LACB0:	.byte $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02
LACC0:	.byte $04, $05, $02, $04, $05, $02, $04, $05, $FF

;Structure #$03
LACC9:	.byte $01, $06, $01, $06, $01, $06, $FF

;Structure #$04
LACD0:	.byte $01, $07, $01, $07, $01, $07, $FF

;Structure #$05
LACD7:	.byte $02, $31, $32, $FF

;Structure #$06
LACDB:	.byte $01, $08, $01, $33, $01, $33, $01, $33, $01, $33, $FF

;Structure #$07
LACE6:	.byte $01, $28, $01, $08, $01, $1F, $01, $17, $01, $17, $01, $1F, $FF

;Structure #$08
LACF3:	.byte $02, $0E, $11, $03, $0F, $12, $22, $03, $10, $13, $14, $FF

;Structure #$09
LACFF:	.byte $04, $08, $35, $35, $08, $FF

;Structure #$0A
LAD05:	.byte $03, $08, $35, $08, $FF

;Structure #$0B
LAD0A:	.byte $02, $36, $36, $02, $1C, $08, $02, $08, $34, $02, $34, $34, $02, $08, $08, $FF

;Structure #$0C
LAD1A:	.byte $02, $20, $20, $FF

;Structure #$0D
LAD1E:	.byte $08, $08, $1C, $08, $35, $08, $35, $1C, $08, $FF

;Structure #$0E
LAD28:	.byte $08, $1E, $1E, $1C, $1C, $1E, $1E, $1E, $1E, $08, $1E, $1E, $1E, $1E, $1C, $1E
LAD38:	.byte $1E, $1E, $08, $1C, $1E, $1E, $1E, $1E, $1E, $1C, $1E, $08, $1E, $1E, $1E, $1C
LAD48:	.byte $1E, $1C, $1C, $1E, $FF

;Structure #$0F
LAD4D:	.byte $08, $2E, $2E, $2E, $2E, $2E, $2E, $2E, $2E, $FF

;Structure #$10
LAD57:	.byte $08, $08, $0B, $0B, $0B, $0B, $08, $0B, $0B, $08, $08, $08, $1C, $1C, $08, $08
LAD67:	.byte $1C, $08, $FF

;Structure #$11
LAD6A:	.byte $08, $1C, $08, $08, $08, $08, $0A, $08, $1C, $08, $08, $0A, $09, $0A, $28, $28
LAD7A:	.byte $08, $08, $01, $08, $FF

;Structure #$12
LAD7F:	.byte $06, $2C, $2C, $2C, $2C, $15, $2C, $06, $2D, $2D, $2D, $2D, $16, $2D, $FF

;Structure #$13
LAD8E:	.byte $08, $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B, $FF

;Structure #$14
LAD98:	.byte $08, $1A, $1A, $1A, $1A, $1A, $1A, $1A, $1A, $FF

;Structure #$15
LADA2:	.byte $01, $20, $01, $20, $01, $17, $01, $17, $01, $20, $FF

;Structure #$16
LADAD:	.byte $07, $20, $20, $20, $20, $20, $20, $20, $07, $20, $1A, $20, $1F, $20, $1A, $20
LADBD:	.byte $FF

;Structure #$17
LADBE:	.byte $08, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $08, $0D, $0D, $0D, $0D, $0D, $0D
LADCE:	.byte $0D, $0D, $08, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $08, $0D, $0D, $0D, $0D
LADDE:	.byte $0D, $0D, $0D, $0D, $FF

;Structure #$18
LADE3:	.byte $01, $0D, $FF

;Structure #$19
LADE6:	.byte $04, $0D, $0D, $0D, $0D, $FF

;Structure #$1A
LADEC:	.byte $02, $0D, $0D, $02, $0D, $0D, $02, $0D, $0D, $02, $0D, $0D, $FF

;Structure #$1B
LADF9:	.byte $08, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $05, $27, $30, $0D, $0D, $30, $FF

;Structure #$1C
LAE09:	.byte $08, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $FF

;Structure #$1D
LAE13:	.byte $01, $0C, $01, $1F, $FF

;Structure #$1E
LAE18:	.byte $04, $08, $35, $08, $08, $04, $08, $1C, $08, $34, $04, $34, $08, $08, $08, $04
LAE28:	.byte $08, $08, $1C, $08, $FF

;Structure #$1F
LAE2D:	.byte $04, $1D, $1D, $1D, $1D, $04, $1D, $1C, $1C, $1D, $04, $1C, $1D, $1C, $1C, $04
LAE3D:	.byte $1D, $1C, $1D, $1D, $FF

;Structure #$20
LAE42:	.byte $04, $33, $33, $33, $33, $FF

;Structure #$21
LAE48:	.byte $01, $22, $FF

;Structure #$22
LAE4B:	.byte $03, $28, $0E, $08, $03, $37, $08, $39, $03, $38, $39, $39, $03, $28, $3A, $0A
LAE5B:	.byte $02, $3B, $3C, $FF

;Structure #$23
LAE5F:	.byte $03, $1E, $1E, $1C, $03, $39, $08, $1E, $03, $0A, $09, $1E, $03, $3D, $0B, $0A
LAE6F:	.byte $FF

;Structure #$24
LAE70:	.byte $04, $1E, $1E, $1C, $1E, $04, $1E, $1E, $1E, $1E, $04, $1C, $1E, $1E, $1E, $04
LAE80:	.byte $1E, $1E, $1C, $1E, $FF

;Structure #$25
LAE85:	.byte $01, $23, $01, $23, $01, $23, $01, $23, $FF

;Structure #$26
LAE8E:	.byte $02, $3E, $3F, $FF

;Structure #$27
LAE92:	.byte $08, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $08, $1E, $1E, $1E, $1E, $1E, $1E
LAEA2:	.byte $1E, $1E, $FF

;Structure #$28
LAEA5:	.byte $01, $1F, $01, $1F, $01, $1F, $01, $1F, $01, $1F, $FF

;Structure #$29
LAEB0:	.byte $01, $3E, $FF

;Structure #$2A
LAEB3:	.byte $04, $2E, $2A, $2E, $2E, $04, $2E, $2E, $2E, $2A, $FF

;Structure #$2B
LAEBE:	.byte $08, $2B, $03, $03, $2B, $03, $03, $03, $2B, $FF

;Structure #$2C
LAEC8:	.byte $01, $1B, $FF

;Structure #$2D
LAECB:	.byte $08, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $1F, $08, $1F, $1F, $1F, $1F, $1F, $1F
LAEDB:	.byte $1F, $1F, $FF

;Structure #$2E
LAEDE:	.byte $01, $2F, $FF

;Structure #$2F
LAEE1:	.byte $01, $1F, $FF

;Structure #$30
LAEE4:	.byte $01, $17, $01, $17, $01, $17, $01, $17, $FF

;Structure #$31
LAEED:	.byte $01, $24, $FF

;----------------------------------------[ Macro definitions ]---------------------------------------

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

MacroDefs:

LAEF0:	.byte $F1, $F1, $F1, $F1
LAEF4:	.byte $FF, $FF, $F0, $F0
LAEF8:	.byte $64, $64, $64, $64
LAEFC:	.byte $D5, $D6, $CB, $CC
LAF00:	.byte $A4, $FF, $A4, $FF
LAF04:	.byte $FF, $A5, $FF, $A5
LAF08:	.byte $A0, $A0, $A0, $A0
LAF0C:	.byte $A1, $A1, $A1, $A1
LAF10:	.byte $00, $01, $02, $03
LAF14:	.byte $0B, $00, $FF, $0B
LAF18:	.byte $03, $0A, $0A, $FF
LAF1C:	.byte $08, $09, $02, $03
LAF20:	.byte $0E, $0F, $10, $11
LAF24:	.byte $12, $13, $14, $0C
LAF28:	.byte $FF, $FF, $FF, $30
LAF2C:	.byte $FF, $33, $FF, $36
LAF30:	.byte $FF, $39, $FF, $3D
LAF34:	.byte $FF, $FF, $31, $32
LAF38:	.byte $34, $35, $37, $38
LAF3C:	.byte $3A, $3B, $3E, $3F
LAF40:	.byte $3C, $41, $40, $42
LAF44:	.byte $FF, $FF, $43, $43
LAF48:	.byte $44, $44, $44, $44
LAF4C:	.byte $45, $46, $45, $46
LAF50:	.byte $FF, $47, $47, $48
LAF54:	.byte $48, $FF, $47, $48
LAF58:	.byte $48, $47, $47, $48
LAF5C:	.byte $49, $49, $4A, $4A
LAF60:	.byte $4B, $4C, $4D, $50
LAF64:	.byte $51, $52, $53, $54
LAF68:	.byte $55, $56, $57, $58
LAF6C:	.byte $59, $5B, $59, $5B
LAF70:	.byte $5C, $5D, $5E, $5F
LAF74:	.byte $4F, $4F, $4F, $4F
LAF78:	.byte $88, $89, $8A, $8B
LAF7C:	.byte $84, $85, $86, $87
LAF80:	.byte $8C, $8D, $8E, $8F
LAF84:	.byte $FF, $FF, $FF, $FF	;Not used.
LAF88:	.byte $FF, $FF, $FF, $FF	;Not used.
LAF8C:	.byte $FF, $FF, $FF, $FF	;Not used.
LAF90:	.byte $FF, $FF, $FF, $FF	;Not used.
LAF94:	.byte $B0, $B1, $B2, $B3
LAF98:	.byte $B4, $B5, $B6, $B7
LAF9C:	.byte $B8, $B8, $B9, $B9
LAFA0:	.byte $FF, $FF, $BA, $BA
LAFA4:	.byte $BB, $BB, $BB, $BB
LAFA8:	.byte $C7, $C8, $C9, $CA
LAFAC:	.byte $94, $95, $96, $97
LAFB0:	.byte $0D, $FF, $FF, $FF
LAFB4:	.byte $FF, $FF, $59, $5A
LAFB8:	.byte $FF, $FF, $5A, $5B
LAFBC:	.byte $80, $81, $82, $83
LAFC0:	.byte $04, $05, $04, $05
LAFC4:	.byte $06, $06, $07, $07
LAFC8:	.byte $60, $61, $62, $63
LAFCC:	.byte $C1, $00, $00, $08
LAFD0:	.byte $0B, $BE, $BC, $BD
LAFD4:	.byte $BF, $01, $02, $03
LAFD8:	.byte $C0, $01, $C0, $03
LAFDC:	.byte $FF, $C1, $FF, $FF
LAFE0:	.byte $C2, $01, $FF, $FF
LAFE4:	.byte $30, $00, $BC, $BD
LAFE8:	.byte $CD, $CE, $CF, $D0
LAFEC:	.byte $D1, $D2, $D3, $D4
LAFF0:	.byte $90, $91, $92, $93

;Not used.
LAFF4:	.byte $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0

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
LB000:	.byte $C2			;
LB001:	.byte $B4			;1 1/2 seconds	+
LB002:	.byte $2E			;B3		| Repeat 2 times
LB003:	.byte $30			;C4		+
LB004:	.byte $FF			;
LB005:	.byte $C3			;
LB006:	.byte $B3			;3/4 seconds	+
LB007:	.byte $2E			;B3		|
LB008:	.byte $34			;D4		| Repeat 3 times
LB009:	.byte $30			;C4		|
LB00A:	.byte $3A			;F4		+
LB00B:	.byte $FF			;
LB00C:	.byte $B4			;1 1/2 seconds
LB00d:	.byte $2E			;B3
LB00E:	.byte $B3			;3/4 seconds
LB00F:	.byte $30			;C4
LB010:	.byte $34			;D4
LB011:	.byte $C3			;
LB012:	.byte $B6			;1 3/16 seconds	+
LB013:	.byte $38			;E4		|
LB014:	.byte $B9			;1/8 seconds	|
LB015:	.byte $30			;C4		|
LB016:	.byte $26			;G3		| Repeat 3 times
LB017:	.byte $30			;C4		|
LB018:	.byte $B3			;3/4 seconds	|
LB019:	.byte $3A			;F4		|
LB01A:	.byte $34			;D4		+
LB01B:	.byte $FF			;
LB01C:	.byte $B4			;1 1/2 seconds
LB01D:	.byte $38			;E4
LB01E:	.byte $38			;E4
LB01F:	.byte $B2			;3/8 seconds
LB020:	.byte $3A			;F4
LB021:	.byte $30			;C4
LB022:	.byte $2A			;A3
LB023:	.byte $B9			;1/8 seconds
LB024:	.byte $30			;C4
LB025:	.byte $2C			;A#3
LB026:	.byte $30			;C4
LB027:	.byte $B2			;3/8 seconds
LB028:	.byte $34			;D4
LB029:	.byte $3A			;F4
LB02A:	.byte $B3			;3/4 seconds
LB02B:	.byte $30			;C4
LB02C:	.byte $B2			;3/8 seconds
LB02D:	.byte $36			;D#4
LB02E:	.byte $2A			;A3
LB02F:	.byte $22			;F3
LB030:	.byte $B9			;1/8 seconds
LB031:	.byte $18			;C3
LB032:	.byte $2C			;A#3
LB033:	.byte $18			;C3
LB034:	.byte $B2			;3/8 seconds
LB035:	.byte $1C			;D3
LB036:	.byte $22			;F3
LB037:	.byte $2C			;A#3
LB038:	.byte $B9			;1/8 seconds
LB039:	.byte $18			;C3
LB03A:	.byte $22			;F3
LB03B:	.byte $2A			;A3
LB03C:	.byte $B3			;3/4 seconds
LB03D:	.byte $2E			;B3
LB03E:	.byte $2A			;A3
LB03F:	.byte $26			;G3
LB040:	.byte $34			;D4
LB041:	.byte $B2			;3/8 seconds
LB042:	.byte $36			;D#4
LB043:	.byte $3A			;F4
LB044:	.byte $28			;Ab3
LB045:	.byte $B9			;1/8 seconds
LB046:	.byte $26			;G3
LB047:	.byte $22			;F3
LB048:	.byte $1E			;D#3
LB049:	.byte $B2			;3/8 seconds
LB04A:	.byte $22			;F3
LB04B:	.byte $2C			;A#3
LB04C:	.byte $26			;G3
LB04D:	.byte $B9			;1/8 seconds
LB04E:	.byte $22			;F3
LB04F:	.byte $44			;A#4
LB050:	.byte $34			;D4
LB051:	.byte $B4			;1 1/2 seconds
LB052:	.byte $34			;D4
LB053:	.byte $B3			;3/4 seconds
LB054:	.byte $2E			;B3
LB055:	.byte $26			;G3
LB056:	.byte $00			;End Brinstar music

BrinstarSQ2IndexData:
LB057:	.byte $C2			;
LB058:	.byte $B2			;3/8 seconds	+
LB059:	.byte $0E			;G2		|
LB05A:	.byte $B9			;1/8 seconds	|
LB05B:	.byte $0E			;G2		|
LB05C:	.byte $06			;D2		|
LB05D:	.byte $0E			;G2		|
LB05E:	.byte $B2			;3/8 seconds	|
LB05F:	.byte $0E			;G2		|
LB060:	.byte $B9			;1/8 seconds	|
LB061:	.byte $0E			;G2		|
LB062:	.byte $06			;D2		|
LB063:	.byte $0E			;G2		| Repeat 2 times
LB064:	.byte $B2			;3/8 seconds	|
LB065:	.byte $14			;A#2		|
LB066:	.byte $B9			;1/8 seconds	|
LB067:	.byte $14			;A#2		|
LB068:	.byte $0A			;F2		|
LB069:	.byte $14			;A#2		|
LB06A:	.byte $B2			;3/8 seconds	|
LB06B:	.byte $14			;A#2		|
LB06C:	.byte $B9			;1/8 seconds	|
LB06D:	.byte $14			;A#2		|
LB06E:	.byte $0A			;F2		|
LB06F:	.byte $14			;A#2		+
LB070:	.byte $FF			;
LB071:	.byte $C3			;
LB072:	.byte $B4			;1 1/2 seconds	+
LB073:	.byte $3E			;G4		|
LB074:	.byte $B6			;1 3/16 seconds	|
LB075:	.byte $44			;A#4		|
LB076:	.byte $B0			;3/32 seconds	| Repeat 3 times
LB077:	.byte $42			;A4		|
LB078:	.byte $44			;A#4		|
LB079:	.byte $42			;A4		|
LB07A:	.byte $3A			;F4		+
LB07B:	.byte $FF			;
LB07C:	.byte $B4			;1 1/2 seconds
LB07D:	.byte $3E			;G4
LB07E:	.byte $3E			;G4
LB07F:	.byte $C3			;
LB080:	.byte $B6			;1 3/16 seconds	+
LB081:	.byte $48			;C5		|
LB082:	.byte $B2			;3/8 seconds	|
LB083:	.byte $3E			;G4		|
LB084:	.byte $B6			;1 3/16 seconds	|
LB085:	.byte $44			;A#4		| Repeat 3 times
LB086:	.byte $B0			;3/32 seconds	|
LB087:	.byte $42			;A4		|
LB088:	.byte $44			;A#4		|
LB089:	.byte $42			;A4		|
LB08A:	.byte $3A			;F4		+
LB08B:	.byte $FF			;
LB08C:	.byte $B4			;1 1/2 seconds
LB08D:	.byte $3E			;G4
LB08E:	.byte $26			;G3
LB08F:	.byte $B6			;1 3/16 seconds
LB090:	.byte $42			;A4
LB091:	.byte $B9			;1/8 seconds
LB092:	.byte $42			;A4
LB093:	.byte $3E			;G4
LB094:	.byte $42			;A4
LB095:	.byte $B3			;3/4 seconds
LB096:	.byte $44			;A#4
LB097:	.byte $B2			;3/8 seconds
LB098:	.byte $3A			;F4
LB099:	.byte $B9			;1/8 seconds
LB09A:	.byte $30			;C4
LB09B:	.byte $3A			;F4
LB09C:	.byte $3E			;G4
LB09D:	.byte $B6			;1 3/16 seconds
LB09E:	.byte $42			;A4
LB09F:	.byte $B9			;1/8 seconds
LB0A0:	.byte $42			;A4
LB0A1:	.byte $3E			;G4
LB0A2:	.byte $42			;A4
LB0A3:	.byte $B3			;3/4 seconds
LB0A4:	.byte $44			;A#4
LB0A5:	.byte $B2			;3/8 seconds
LB0A6:	.byte $3A			;F4
LB0A7:	.byte $B9			;1/8 seconds
LB0A8:	.byte $3A			;F4
LB0A9:	.byte $44			;A#4
LB0AA:	.byte $48			;C5
LB0AB:	.byte $B4			;1 1/2 seconds
LB0AC:	.byte $4C			;D5
LB0AD:	.byte $B3			;3/4 seconds
LB0AE:	.byte $48			;C5
LB0AF:	.byte $46			;B4
LB0B0:	.byte $B6			;1 3/16 seconds
LB0B1:	.byte $48			;C5
LB0B2:	.byte $B9			;1/8 seconds
LB0B3:	.byte $4E			;D#5
LB0B4:	.byte $4C			;D5
LB0B5:	.byte $48			;C5
LB0B6:	.byte $B3			;3/4 seconds
LB0B7:	.byte $4C			;D5
LB0B8:	.byte $B2			;3/8 seconds
LB0B9:	.byte $44			;A#4
LB0BA:	.byte $B9			;1/8 seconds
LB0BB:	.byte $44			;A#4
LB0BC:	.byte $4C			;D5
LB0BD:	.byte $52			;F5
LB0BE:	.byte $B4			;1 1/2 seconds
LB0BF:	.byte $54			;F#5
LB0C0:	.byte $54			;F#5

BrinstarTriangleIndexData:
LB0C1:	.byte $C4			;
LB0C2:	.byte $B4			;1 1/2 seconds	+ Repeat 4 times
LB0C3:	.byte $02			;No sound	+
LB0C4:	.byte $FF			;
LB0C5:	.byte $C3			;
LB0C6:	.byte $B2			;3/8 seconds	+
LB0C7:	.byte $26			;G3		|
LB0C8:	.byte $B9			;1/8 seconds	|
LB0C9:	.byte $26			;G3		|
LB0CA:	.byte $3E			;G4		|
LB0CB:	.byte $34			;D4		|
LB0CC:	.byte $B2			;3/8 seconds	|
LB0CD:	.byte $26			;G3		|
LB0CE:	.byte $B9			;1/8 seconds	|
LB0CF:	.byte $26			;G3		|
LB0D0:	.byte $34			;D4		| Repeat 3 times
LB0D1:	.byte $26			;G3		|
LB0D2:	.byte $B2			;3/8 seconds	|
LB0D3:	.byte $2C			;A#3		|
LB0D4:	.byte $B9			;1/8 seconds	|
LB0D5:	.byte $2C			;A#3		|
LB0D6:	.byte $3A			;F4		|
LB0D7:	.byte $2C			;A#3		|
LB0D8:	.byte $B2			;3/8 seconds	|
LB0D9:	.byte $2C			;A#3		|
LB0DA:	.byte $B9			;1/8 seconds	|
LB0DB:	.byte $2C			;A#3		|
LBoDC:	.byte $3A			;F4		|
LB0DD:	.byte $2C			;A#3		+
LB0DE:	.byte $FF			;
LB0DF:	.byte $C4			;
LB0E0:	.byte $B2			;3/8 seconds	+
LB0E1:	.byte $26			;G3		|
LB0E2:	.byte $B9			;1/8 seconds	| Repeat 4 times
LB0E3:	.byte $34			;D4		|
LB0E4:	.byte $26			;G3		|
LB0E5:	.byte $26			;G3		+
LB0E6:	.byte $FF			;
LB0E7:	.byte $D0			;
LB0E8:	.byte $B9			;1/8 seconds	+				
LB0E9:	.byte $18			;C3		|
LB0EA:	.byte $26			;G3		| Repeat 16 times
LB0EB:	.byte $18			;C3		|
LB0EC:	.byte $B2			;3/8 seconds	|
LB0ED:	.byte $18			;C3		+
LB0EE:	.byte $FF			;
LB0EF:	.byte $C2			;
LB0F0:	.byte $B2			;3/8 seconds	+
LB0F1:	.byte $1E			;D#3		|
LB0F2:	.byte $B9			;1/8 seconds	|
LB0F3:	.byte $1E			;D#3		|
LB0F4:	.byte $18			;C3		|
LB0F5:	.byte $1E			;D#3		|
LB0F6:	.byte $B2			;3/8 seconds	|
LB0F7:	.byte $1E			;D#3		|
LB0F8:	.byte $B9			;1/8 seconds	|
LB0F9:	.byte $1E			;D#3		|
LB0FA:	.byte $18			;C3		| Repeat 2 times
LB0FB:	.byte $1E			;D#3		|
LB0FC:	.byte $B2			;3/8 seconds	|
LB0FD:	.byte $1C			;D3		|
LB0FE:	.byte $B9			;1/8 seconds	|
LB0FF:	.byte $1C			;D3		|
LB100:	.byte $14			;A#2		|
LB101:	.byte $1C			;D3		|
LB102:	.byte $B2			;3/8 seconds	|
LB103:	.byte $1C			;D3		|
LB104:	.byte $B9			;1/8 seconds	|
LB105:	.byte $1C			;D3		|
LB106:	.byte $14			;A#2		|
LB107:	.byte $1C			;D3		+
LB108:	.byte $FF			;
LB109:	.byte $B2			;3/8 seconds
LB10A:	.byte $26			;G3
LB10B:	.byte $12			;A2
LB10C:	.byte $16			;B2
LB10D:	.byte $18			;C3
LB10E:	.byte $1C			;D3
LB10F:	.byte $20			;E3
LB110:	.byte $24			;F#3
LB111:	.byte $26			;G3
LB112:	.byte $B2			;3/8 seconds
LB113:	.byte $28			;Ab3
LB114:	.byte $B9			;1/8 seconds
LB115:	.byte $28			;Ab3
LB116:	.byte $1E			;D#3
LB117:	.byte $18			;C3
LB118:	.byte $B2			;3/8 seconds
LB119:	.byte $10			;Ab2
LB11A:	.byte $B9			;1/8 seconds
LB11B:	.byte $30			;C4
LB11C:	.byte $2C			;A#3
LB11D:	.byte $28			;Ab3
LB11E:	.byte $B2			;3/8 seconds
LB11F:	.byte $1E			;D#3
LB120:	.byte $1C			;D3
LB121:	.byte $18			;C3
LB122:	.byte $14			;A#2
LB123:	.byte $2A			;A3
LB124:	.byte $2A			;A3
LB125:	.byte $2A			;A3
LB126:	.byte $2A			;A3
LB127:	.byte $CC			;
LB128:	.byte $B9			;1/8 seconds	+ Repeat 12 times
LB129:	.byte $2A			;A3		+
LB12A:	.BYTE $FF			;

BrinstarNoiseIndexData:
LB12B:	.byte $E8			;
LB12C:	.byte $B2			;3/8 seconds	+
LB12D:	.byte $04			;Drumbeat 01	|
LB12E:	.byte $04			;Drumbeat 01	|
LB12F:	.byte $04			;Drumbeat 01	| Repeat 40 times
LB130:	.byte $B9			;1/8 seconds	|
LB131:	.byte $04			;Drumbeat 01	|
LB132:	.byte $04			;Drumbeat 01	|
LB133:	.byte $04			;Drumbeat 01	+
LB134:	.byte $FF			;

;Unused tile patterns. 
LB135:	.byte $E0, $E0, $F0, $00, $00, $00, $00, $00, $00, $00, $00, $21, $80, $40, $02, $05
LB145:	.byte $26, $52, $63, $00, $00, $00, $06, $07, $67, $73, $73, $FF, $AF, $2F, $07, $0B
LB155:	.byte $8D, $A7, $B1, $00, $00, $00, $00, $00, $80, $80, $80, $F8, $B8, $F8, $F8, $F0
LB165:	.byte $F0, $F8, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $07
LB175:	.byte $03, $03, $01, $00, $00, $00, $00, $00, $00, $00, $80, $FF, $C7, $83, $03, $C7
LB185:	.byte $CF, $FE, $EC, $00, $30, $78, $F8, $30, $00, $01, $12, $F5, $EA, $FB, $FD, $F9
LB195:	.byte $1E, $0E, $44, $07, $03, $03, $01, $01, $E0, $10, $48, $2B, $3B, $1B, $5A, $D0
LB1A5:	.byte $D1, $C3, $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30
LB1B5:	.byte $98, $CF, $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60
LB1C5:	.byte $70, $FC, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00
LB1D5:	.byte $00, $00, $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B
LB1E5:	.byte $03, $03, $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C
LB1F5:	.byte $3C, $18, $30, $E8, $E8, $C8, $90, $60, $00, $00, $00

;------------------------------------------[ Sound Engine ]------------------------------------------

;SFXdata. The top four entries are used by the noise music player for drum beats.
LB200:	.byte $00			;Base for drum beat music data.

DrumBeat00SFXData:
LB201:	.byte $10, $01, $18		;Noise channel music data #$01.
DrumBeat01SFXData:
LB204:	.byte $00, $01, $38		;Noise channel music data #$04.
DrumBeat02SFXData:
LB207:	.byte $01, $02, $40		;Noise channel music data #$07.
DrumBeat03SFXData:
LB20A:	.byte $00, $09, $58		;Noise channel music data #$0A.
GamePausedSFXData:
LB20D:	.byte $80, $7F, $80, $48
ScrewAttSFXData:
LB211:	.byte $35, $7F, $00, $B0
MissileLaunchSFXData:
LB215:	.byte $19, $7F, $0E, $A0
BombExplodeSFXData:
LB219:	.byte $0D, $7F, $0F, $08
SamusWalkSFXData:
LB21D:	.byte $16, $7F, $0B, $18
SpitFlameSFXData:
LB221:	.byte $13, $7F, $0E, $F8
SamusHitSQ1SQ2SFXData:
LC225:	.byte $C1, $89, $02, $0F
BossHitSQ2SFXData:
LB229:	.byte $34, $BA, $E0, $05
BossHitSQ1SFXData:
LB22D:	.byte $34, $BB, $CE, $05
IncorrectPasswordSQ1SFXData:
LB231:	.byte $B6, $7F, $00, $C2
IncorrectPasswordSQ2SFXData:
LB235:	.byte $B6, $7F, $04, $C2
TimeBombTickSFXData:
LB239:	.byte $17, $7F, $66, $89
EnergyPickupSFXData:
LB23D:	.byte $89, $7F, $67, $18
MissilePickupSFXData:
LB241:	.byte $8B, $7F, $FD, $28
MetalSFXData:
LB245:	.byte $02, $7F, $A8, $F8
LongRangeShotSFXData:
LB249:	.byte $D7, $83, $58, $F8
ShortRangeShotSFXData:
LB24D:	.byte $D6, $82, $58, $F8
JumpSFXData:
LB251:	.byte $95, $8C, $40, $B9
EnemyHitSFXData:
LB255:	.byte $1D, $9A, $20, $8F
BugOutOFHoleSFXData:
LB259:	.byte $16, $8D, $E0, $42
WaveBeamSFXData:
LB25D:	.byte $19, $7F, $6F, $40
IceBeamSFXData:
LB261:	.byte $18, $7F, $80, $40
BombLaunch1SFXData:
LB265:	.byte $07, $7F, $40, $28
BombLaunch2SFXData:
LB269:	.byte $07, $7F, $45, $28
SamusToBallSFXData:
LB26D:	.byte $7F, $7F, $DD, $3B
MetroidHitSFXData:
LB26E:	.byte $7F, $7F, $FF, $98
SamusDieSFXData:
LB275:	.byte $7F, $7F, $40, $08
SamusBeepSFXData:
LB279:	.byte $09, $7F, $30, $48
BigEnemyHitSFXData:
LB27D:	.byte $03, $7F, $42, $18
StatueRaiseSFXData:
LB281:	.byte $03, $7F, $11, $09
DoorSFXData:
LB285:	.byte $7F, $7F, $30, $B2

;The following table is used by the CheckSFXFlag routine.  The first two bytes of each row
;are the address of the pointer table used for handling SFX and music  routines for set flags.
;The second pair of bytes is the address of the routine to next jump to if no SFX or music
;flags were found.  The final byte represents what type of channel is currently being
;processed: 0=Noise, 1=SQ1, 3=Triangle, 4=Multiple channels.

ChooseNextSFXRoutineTbl:

LB289:	.word $B2BB, $B322		;Noise init SFX		(1st).
LB28D:	.byte $00
	
LB28E:	.word $B2CB, $B4EE		;Noise continue SFX	(2nd).
LB292:	.byte $00

LB293:	.word $B2DB, $B330		;SQ1 init SFX		(5th).
LB297:	.byte $01

LB298:	.word $B2EB, $B4EE		;SQ2 continue SFX	(6th).
LB29C:	.byte $01

LB29D:	.word $B2FB, $B344		;Triangle init SFX	(7th).
LB2A1:	.byte $03

LB2A2:	.word $B30B, $B4EE		;Triangle continue SFX	(8th).
LB2A6:	.byte $03

LB2A7:	.word $BC06, $B35C		;Multi init SFX		(3rd).
LB2AB:	.byte $04

LB2AC:	.word $BC16, $B364		;Multi continue SFX	(4th).
LB2B0:	.byte $04

LB2B1:	.word $BC26, $BC4B		;temp flag Music	(10th).
LB2B5:	.byte $00

LB2B6:	.word $BC26, $BC3D		;Music			(9th).
LB2BA:	.byte $00

;The tables below contain addresses for SFX handling routines.

;Noise Init SFX handling routine addresses:
LB2BB:	.word $B4EE			;No sound.
LB2BD:	.word $B52B			;Screw attack init SFX.
LB2BF:	.word $B56E			;Missile launch init SFX.
LB2C1:	.word $B583			;Bomb explode init SFX.
LB2C3:	.word $B598			;Samus walk init SFX.
LB2C5:	.word $B50F			;Spit flame init SFX.
LB2C7:	.word $B4EE			;No sound.
LB2C9:	.word $B4EE			;No sound.

;Noise Continue SFX handling routine addresses:

LB2CB:	.word $B4EE			;No sound.
LB2CD:	.word $B539			;Screw attack continue SFX.
LB2CF:	.word $B57B			;Missile launch continue SFX.
LB2D1:	.word $B58A			;Bomb explode continue SFX.
LB2D3:	.word $B58A			;Samus walk continue SFX.
LB2D5:	.word $B516			;Spit flame continue SFX.
LB2D7:	.word $B4EE			;No sound.
LB2D9:	.word $B4EE			;No sound.

;SQ1 Init SFX handling routine addresses:

LB2DB:	.word $B6CD			;Missile pickup init SFX.
LB2DD:	.word $B6E7			;Energy pickup init SFX.
LB2DF:	.word $B735			;Metal init SFX.
LB2E1:	.word $B716			;Bullet fire init SFX.
LB2E3:	.word $B73C			;Bird out of hole init SFX.
LB2E5:	.word $B710			;Enemy hit init SFX.
LB2E7:	.word $B703			;Samus jump init SFX.
LB2E9:	.word $B77A			;Wave beam init SFX.

;SQ1 Continue SFX handling routine addresses:

LB2EB:	.word $B6B0			;Missile pickup continue SFX.
LB2ED:	.word $B6D3			;Energy pickup continue SFX.
LB2EF:	.word $B6ED			;Metal continue SFX.
LB2F1:	.word $B74F			;Bullet fire continue SFX.
LB2F3:	.word $B6ED			;Bird out of hole continue SFX.
LB2F5:	.word $B6ED			;Enemy hit continue SFX.
LB2F7:	.word $B6ED			;Samus jump continue SFX.
LB2F9:	.word $B781			;Wave beam continue SFX.

;Triangle init handling routine addresses:

LB2FB:	.word $B8D2			;Samus die init SFX.
LB2FD:	.word $B7AC			;Door open close init SFX.
LB2FF:	.word $B8A7			;Metroid hit init SFX.
LB301:	.word $B921			;Statue raise init SFX.
LB303:	.word $B7D9			;Beep init SFX.
LB305:	.word $B7EF			;Big enemy hit init SFX.
LB307:	.word $B834			;Samus to ball init SFX.
LB309:	.word $B878			;Bomb launch init SFX.

;Triangle continue handling routine addresses:

LB30B:	.word $B8ED			;Samus die continue SFX.
LB30E:	.word $B7CB			;Door open close continue SFX.
LB30F:	.word $B8B1			;Metroid hit continue SFX.
LB311:	.word $B940			;Statue raise continue SFX.
LB313:	.word $B7E7			;Beep continue SFX.
LB315:	.word $B80E			;Big enemy hit continue SFX.
LB317:	.word $B84F			;Samus to ball continue SFX.
LB319:	.word $B87F			;Bomb launch continue SFX.

LoadNoiseSFXInitFlags:
LB31B:	LDA NoiseSFXFlag		;Load A with Noise init SFX flags, (1st SFX cycle).
LB31E:	LDX #$89			;Lower address byte in ChooseNextSFXRoutineTbl.
LB320:	BNE GotoSFXCheckFlags		;Branch always.

LoadNoiseSFXContFlags:
LB322:	LDA NoiseContSFX		;Load A with Noise continue flags, (2nd SFX cycle).
LB325:	LDX #$8E			;Lower address byte in ChooseNextSFXRoutineTbl.
LB327:	BNE GotoSFXCheckFlags		;Branch always.

LoadSQ1SFXInitFlags:
LB329:	LDA SQ1SFXFlag			;Load A with SQ1 init flags, (5th SFX cycle).
LB32C:	LDX #$93			;Lower address byte in ChooseNextSFXRoutineTbl.
LB32E:	BNE GotoSFXCheckFlags		;Branch always.

LoadSQ1SFXContFlags:
LB330:	LDA SQ1ContSFX			;Load A with SQ1 continue flags, (6th SFX cycle).
LB333:	LDX #$98			;Lower address byte in ChooseNextSFXRoutineTbl.
LB335:	BNE GotoSFXCheckFlags		;Branch always.

GotoSFXCheckFlags:
LB337:	JSR CheckSFXFlag		;($B4BD)Checks to see if SFX flags set.		
LB33A:	JMP ($00E2)			;if no flag found, Jump to next SFX cycle,-->
					;else jump to specific SFX handling routine.
LoadSTriangleSFXInitFlags:
LB33D:	LDA TriangleSFXFlag		;Load A with Triangle init flags, (7th SFX cycle).
LB340:	LDX #$9D			;Lower address byte in ChooseNextSFXRoutineTbl.
LB342:	BNE GotoSFXCheckFlags		;Brach always.

LoadTriangleSFXContFlags:
LB344:	LDA TriangleContSFX		;Load A with Triangle continue flags, (8th SFX cycle).
LB347:	LDX #$A2			;Lower address byte in ChooseNextSFXRoutineTbl.
LB349:	BNE GotoSFXCheckFlags		;Branch always.

LoadMultiSFXInitFlags:
LB34B:	LDA MultiSFXFlag		;Load A with Multi init flags, (3rd SFX cycle).
LB34E:	LDX #$A7			;Lower address byte in ChooseNextSFXRoutineTbl.
LB350:	JSR CheckSFXFlag		;($B4BD)Checks to see if SFX or music flags set.
LB353:	JSR FindMusicInitIndex		;($BC53)Find bit containing music init flag.
LB356:	JSR Add8			;($BC64)Add 8 to MusicInitIndex.
LB359:	JMP ($00E2)			;If no flag found, Jump to next SFX cycle,-->
					;else jump to specific SFX handling subroutine.
LoadMultiSFXContFlags:
LB35C:	LDA MultiContSFX		;Load A with $68C flags (4th SFX cycle).
LB35F:	LDX #$AC			;Lower address byte in ChooseNextSFXRoutineTbl.
LB361:	JMP GotoSFXCheckFlags		;($B337)Checks to see if SFX or music flags set.

LoadSQ1Flags:
LB364:	JSR LoadSQ1SFXInitFlags		;($B329)Check for SQ1 init flags.
LB367:	RTS				;

LoadSQ1ChannelSFX:			;Used to determine which sound registers to change-->
LB368:	LDA #$00			;($4000 - $4003) - SQ1.
LB36A:	BEQ +				;Branch always.

LoadTriangleChannelSFX:			;Used to determine which sound registers to change-->
LB36C:	LDA #$08			;($4008 - $400B) - Triangle.
LB36E:	BNE +				;Branch always.

LoadNoiseChannelSFX:			;Used to determine which sound registers to change-->
LB370:	LDA #$0C			;($400C - $400F) - Noise.
LB372:	BNE +				;Branch always.

LoadSQ2ChannelSFX:			;Used to determine which sound registers to change-->
LB374:	LDA #$04			;($4004 - $4007) - SQ2.

LoadSFXData:
LB376:*	STA $E0				;Lower address byte of desired APU control register.
LB378:	LDA #$40			;
LB37A:	STA $E1				;Upper address byte of desired APU control register.
LB37C:	STY $E2				;Lower address byte of data to load into sound channel.
LB37E:	LDA #$B2			;
LB380:	STA $E3				;Upper address byte of data to load into sound channel.
LB382:	LDY #$00			;Starting index for loading four byte sound data.

LoadSFXRegisters:
LB384:*	LDA ($E2),Y			;Load A with SFX data byte.
LB386:	STA ($E0),Y			;Store A in SFX register.
LB388:	INY 				;
LB389:	TYA 				;The four registers associated with each sound-->
LB38A:	CMP #$04			;channel are loaded one after the other (the loop-->
LB38C:	BNE -				;repeats four times).
LB38E:	RTS 				;

PauseSFX:
LB38F:*	INC SFXPaused			;SFXPaused=#$01
LB392:	JSR ClearSounds			;($B43E)Clear sound registers of data.		
LB395:	STA PauseSFXStatus		;PauseSFXStatus=#$00
LB398:	RTS				;

LB399:*	LDA SFXPaused			;Has SFXPaused been set? if not, branch
LB39C:	BEQ --				;
LB39E:	LDA PauseSFXStatus		;For the first #$12 frames after the game has been-->
LB3A1:	CMP #$12			;paused, play GamePaused SFX.  If paused for #$12-->
LB3A3:	BEQ ++				;frames or more, branch to exit.
LB3A5:	AND #$03			;
LB3A7:	CMP #$03			;Every fourth frame, repeat GamePaused SFX
LB3A9:	BNE +				;
LB3AB:	LDY #$0D			;Lower address byte of GamePaused SFX data(Base=$B200)
LB3AD:	JSR LoadSQ1ChannelSFX		;($B368) Load GamePaused SFX data.
LB3B0:*	INC PauseSFXStatus		;
LB3B3:*	RTS				;

;------------------------------------[ Sound Engine Entry Point ]------------------------------------
;NOTES:  
;SFX take priority over music.
;
;There are 10 SFX cycles run every time the sound engine subroutine is called.  The cycles
;search for set sound flags in the following registers in order:
;$680, $688, $684, $68C, $681, $689, $683, $68B, $65D, $685 
;
;The sound channels are assigned SFX numbers.  Those SFX numbers are:
;Noise=0, sq1=1, sq2=2, triangle=3, Multi=4
;The sound channels are assigned music numbers.  Those music numbers are:
;SQ1=0, SQ2=1, Triangle=2, Noise=3

SoundEngine: 
LB3B4:	LDA #$C0			;Set APU to 5 frame cycle, disable frame interrupt.
LB3B6:	STA APUCommonCntrl1		;
LB3B9:	LDA NoiseSFXFlag		;is bit zero is set in NoiseSFXFlag(Silence-->
LB3BC:	LSR 				;music)?  If yes, branch.
LB3BD:	BCS ++				;
LB3BF:	LDA MainRoutine			;
LB3C1:	CMP #$05			;Is game paused?  If yes, branch.
LB3C3:	BEQ ---				;
LB3C5:	LDA #$00			;Clear SFXPaused when game is running.
LB3C7:	STA SFXPaused			;
LB3CA:	JSR LoadNoiseSFXInitFlags	;($B31B)Check noise SFX flags.
LB3CD:	JSR LoadMultiSFXInitFlags	;($B34B)Check multichannel SFX flags.
LB3D0:	JSR LoadSTriangleSFXInitFlags	;($B33D)Check triangle SFX flags.
LB3D3:	JSR LoadMusicTempFlags		;($BC36)Check music flags.

ClearSFXFlags:
LB3D6:*	LDA #$00			;
LB3D8:	STA NoiseSFXFlag		;
LB3DB:	STA SQ1SFXFlag			;
LB3DE:	STA SQ2SFXFlag			;Clear all SFX flags.
LB3E1:	STA TriangleSFXFlag		;
LB3E4:	STA MultiSFXFlag		;
LB3E7:	STA MusicInitFlag		;
LB3EA:	RTS				;

LB3EB:*	JSR InitializeSoundAddresses	;($B404)Prepare to start playing music.		
LB3EE:	BEQ --				;Branch always.

CheckRepeatMusic:
LB3F0:	LDA MusicRepeat			;
LB3F3:	BEQ +				;If music is supposed to repeat, reset music,-->
LB3F5:	LDA CurrentMusic		;flags else branch to exit.
LB3F8:	STA CurrentMusicRepeat		;
LB3FB:	RTS				;

CheckMusicFlags:
LB3FC:	LDA CurrentMusic		;Loads A with current music flags and compares it-->
LB3FF:	CMP CurrentSFXFlags		;with current SFX flags.  If both are equal,-->
LB402:	BEQ ++				;just clear music counters, else clear everything.

InitializeSoundAddresses:		;
LB404:*	JSR ClearMusicAndSFXAddresses	;($B41D)Jumps to all subroutines needed to reset-->
LB407:	JSR ClearSounds			;($B43E)all sound addresses in order to start-->
LB40A:*	JSR ClearSpecialAddresses	;($B40E)playing music.
LB40D:	RTS 				;

ClearSpecialAddresses:
LB40E:	LDA #$00			;	
LB410:	STA TriangleCounterCntrl	;Clears addresses used for repeating music,-->
LB413:	STA SFXPaused			;pausing music and controlling triangle length.
LB416:	STA CurrentMusicRepeat		;
LB419:	STA MusicRepeat			;
LB41C:	RTS				;

ClearMusicAndSFXAddresses:		;
LB41D:	LDA #$00			;
LB41F:	STA SQ1InUse			;
LB422:	STA SQ2InUse			;
LB425:	STA TriangleInUse		;
LB428:	STA WriteMultiChannelData	;
LB42B:	STA NoiseContSFX		;Clears any SFX or music--> 
LB42E:	STA SQ1ContSFX			;currently being played.
LB431:	STA SQ2ContSFX			;
LB434:	STA TriangleContSFX		;
LB437:	STA MultiContSFX		;
LB43A:	STA CurrentMusic		;
LB43D:	RTS 				;

ClearSounds:				;
LB43E:	LDA #$10			;
LB440:	STA SQ1Cntrl0			;
LB443:	STA SQ2Cntrl0			;
LB446:	STA NoiseCntrl0			;Clears all sounds that might be in-->
LB449:	LDA #$00			;The sound channel registers.
LB44B:	STA TriangleCntrl0		;
LB44E:	STA DMCCntrl1			;
LB451:	RTS 				;

SelectSFXRoutine:
LB452:	LDX ChannelType			;
LB455:	STA NoiseSFXLength,X		;Stores frame length of SFX in corresponding address.
LB458:	TXA				;
LB459:	BEQ ++				;Branch if SFX uses noise channel.
LB45B:	CMP #$01			;
LB45D:	BEQ +				;Branch if SFX uses SQ1 channel.
LB45F:	CMP #$02			;
LB461:	BEQ MusicBranch00		;Branch if SFX uses SQ2 channel.
LB463:	CMP #$03			;
LB465:	BEQ MusicBranch01		;Branch if SFX uses triangle wave.
LB467:	RTS				;Exit if SFX routine uses no channels.

LB468:*	JSR LoadSQ1ChannelSFX		;($B368)Prepare to load SQ1 channel with data.
LB46B:	BEQ ++				;Branch always.
MusicBranch00:				;
LB46D:	JSR LoadSQ2ChannelSFX		;($B374)Prepare to load SQ2 channel with data.
LB470:	BEQ ++				;Branch always.
MusicBranch01:				;
LB472:	JSR LoadTriangleChannelSFX	;($B36C)Prepare to load triangle channel with data.
LB475:	BEQ ++				;Branch always.
LB477:*	JSR LoadNoiseChannelSFX		;($B370)Prepare to load noise channel with data.
LB47A:*	JSR UpdateContFlags		;($B493)Set continuation flags for this SFX.
LB47D:	TXA				;
LB47E:	STA NoiseInUse,X		;Indicate sound channel is in use.
LB481:	LDA #$00			;
LB483:	STA ThisNoiseFrame,X		;
LB486:	STA NoiseSFXData,X		;Clears all the following addresses before going-->
LB489:	STA MultiSFXData,X		;to the proper SFX handling routine.
LB48C:	STA ScrewAttackSFXData,X	;
LB48F:	STA WriteMultiChannelData	;
LB492:	RTS				;

UpdateContFlags:
LB493:*	LDX ChannelType			;Loads X register with sound channel just changed.
LB496:	LDA NoiseContSFX,X		;Clear existing continuation SFX-->
LB499:	AND #$00			;flags for that channel.
LB49B:	ORA CurrentSFXFlags		;Load new continuation flags.
LB49E:	STA NoiseContSFX,X		;Save results.
LB4A1:	RTS				;

ClearCurrentSFXFlags:
LB4A2:	LDA #$00			;Once SFX has completed, this block clears the-->
LB4A4:	STA CurrentSFXFlags		;SFX flag from the current flag register.
LB4A7:	BEQ -				;

IncrementSFXFrame:
LB4A9:	LDX ChannelType			;Load SFX channel number.
LB4AC:	INC ThisNoiseFrame,X		;increment current frame to play on given channel.
LB4AF:	LDA ThisNoiseFrame,X		;Load current frame to play on given channel.
LB4B2:	CMP NoiseSFXLength,X		;Check to see if current frame is last frame to play.
LB4B5:	BNE +				;
LB4B7:	LDA #$00			;If current frame is last frame,-->
LB4B9:	STA ThisNoiseFrame,X		;reset current frame to 0.
LB4BC:*	RTS 				;

;The CheckSFXFlag routine loads E0 thru E3 with the below values:
;1st  SFX cycle $E0=#$BB, $E1=#$B2, $E2=#$22, $E3=#$B3.  Base address=$B289
;2nd  SFX cycle $E0=#$CB, $E1=#$B2, $E2=#$EE, $E3=#$B4.  Base address=$B28E
;3rd  SFX cycle $E0=#$06, $E1=#$BC, $E2=#$5C, $E3=#$B3.  Base address=$B2A7
;4th  SFX cycle $E0=#$16, $E1=#$BC, $E2=#$64, $E3=#$B3.  Base address=$B2AC
;5th  SFX cycle $E0=#$DB, $E1=#$B2, $E2=#$30, $E3=#$B3.  Base address=$B293
;6th  SFX cycle $E0=#$EB, $E1=#$B2, $E2=#$EE, $E3=#$B4.  Base address=$B298
;7th  SFX cycle $E0=#$FB, $E1=#$B2, $E2=#$44, $E3=#$B3.  Base address=$B29D
;8th  SFX cycle $E0=#$0B, $E1=#$B3, $E2=#$EE, $E3=#$B4.  Base address=$B2A2
;9th  SFX cycle $E0=#$26, $E1=#$BC, $E2=#$3D, $E3=#$BC.  Base address=$B2B6
;10th SFX cycle $E0=#$26, $E1=#$BC, $E2=#$4B, $E3=#$BC.  Base address=$B2B1

CheckSFXFlag:
LB4BD:	STA CurrentSFXFlags		;Store any set flags in $064D.
LB4C0:	STX $E4				;
LB4C2:	LDY #$B2			;
LB4C4:	STY $E5				;
LB4C6:	LDY #$00			;Y=0 for counting loop ahead.
LB4C8:*	LDA ($E4),Y			;
LB4CA:	STA $00E0,Y			;See table above for values loaded into $E0-->
LB4CD:	INY 				;thru $E3 during this loop.
LB4CE:	TYA 				;
LB4CF:	CMP #$04			;Loop repeats four times to load the values.
LB4D1:	BNE -				;
LB4D3:	LDA ($E4),Y			;
LB4D5:	STA ChannelType			;#$00=SQ1,#$01=SQ2,#$02=Triangle,#$03=Noise
LB4D8:	LDY #$00			;Set y to 0 for counting loop ahead.
LB4DA:	LDA CurrentSFXFlags		;
LB4DD:	PHA 				;Push current SFX flags on stack.
LB4DE:*	ASL CurrentSFXFlags		;
LB4E1:	BCS +				;This portion of the routine loops a maximum of-->
LB4E3:	INY				;eight times looking for any SFX flags that have-->
LB4E4:	INY 				;been set in the current SFX cycle.  If a flag-->
LB4E5:	TYA 				;is found, Branch to SFXFlagFound for further-->
LB4E6:	CMP #$10			;processing, if no flags are set, continue to-->
LB4E8:	BNE -				;next SFX cycle.

RestoreSFXFlags:
LB4EA:	PLA				;
LB4EB:	STA CurrentSFXFlags		;Restore original data in CurrentSFXFlags.
LB4EE:	RTS				;

SFXFlagFound:				;
LB4EF:*	LDA ($E0),Y			;This routine stores the starting address of the-->
LB4F1:	STA $E2				;specific SFX handling routine for the SFX flag--> 
LB4F3:	INY 				;found.  The address is stored in registers-->
LB4F4:	LDA ($E0),Y			;$E2 and $E3.
LB4F6:	STA $E3				;
LB4F8:	JMP RestoreSFXFlags		;($B4EA)Restore original data in CurrentSFXFlags.

;-----------------------------------[ SFX Handling Routines ]---------------------------------------

;The following table is used by the SpitFlamesSFXContinue routine to change the volume-->
;on the SFX.  It starts out quiet, then becomes louder then goes quiet again.
SpitFlamesTbl:
LB4FB:	.byte $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1B, $1A, $19, $17
LB50B:	.byte $16, $15, $14, $12

SpitFlameSFXStart:
LB50F:	LDA #$14			;Number of frames to play sound before a change.
LB511:	LDY #$21			;Lower byte of sound data start address(base=$B200).
LB513:	JMP SelectSFXRoutine		;($B452)Setup registers for SFX.

SpitFlameSFXContinue:
LB516:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB519:	BNE +				;If more frames to process, branch.
LB51B:	JMP EndNoiseSFX			;($B58F)End SFX.
LB51E:*	LDY NoiseSFXData		;
LB521:	LDA $B4FB,Y			;Load data from table above and store in NoiseCntrl0.
LB524:	STA NoiseCntrl0			;
LB527:	INC NoiseSFXData		;Increment to next entry in data table.
LB52A:	RTS 

ScrewAttackSFXStart:
LB52B:	LDA #$05			;Number of frames to play sound before a change.
LB52D:	LDY #$11			;Lower byte of sound data start address(base=$B200).
LB52F:	JSR SelectSFXRoutine		;($B452)Setup registers for SFX.
LB532:	LDA $B213			;#$00.
LB535:	STA NoiseSFXData		;Clear NoiseSFXData.
LB538:*	RTS				;

ScrewAttackSFXContinue:
LB539:	LDA ScrewAttackSFXData		;Prevents period index from being incremented until-->
LB53C:	CMP #$02			;after the tenth frame of the SFX.
LB53E:	BEQ +				;Branch if not ready to increment.
LB540:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB543:	BNE -				;
LB545:	INC ScrewAttackSFXData		;Increment every fifth frame.
LB548:	RTS				;

LB549:*	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB54C:	BNE IncrementPeriodIndex	;Start increasing period index after first ten frames.
LB54E:	DEC NoiseSFXData		;
LB551:	DEC NoiseSFXData		;Decrement NoiseSFXData by three every fifth frame.
LB554:	DEC NoiseSFXData		;
LB557:	INC MultiSFXData		;Increment MultiSFXData.  When it is equal to #$0F-->
LB55A:	LDA MultiSFXData		;end screw attack SFX.  MultiSFXData does not-->
LB55D:	CMP #$0F			;appear to be linked to multi SFX channels in-->
LB55F:	BNE --				;this routine.
LB561:	JMP EndNoiseSFX			;($B58F)End SFX.

IncrementPeriodIndex:
LB564:	INC NoiseSFXData		;Incrementing the period index has the effect of-->
LB567:	LDA NoiseSFXData		;lowering the frequency of the noise SFX.
LB56A:	STA NoiseCntrl2			;
LB56D:	RTS				;

MissileLaunchSFXStart:
LB56E:	LDA #$18			;Number of frames to play sound before a change.
LB570:	LDY #$15			;Lower byte of sound data start address(base=$B200).
LB572:	JSR GotoSelectSFXRoutine	;($B587)Prepare to setup registers for SFX.
LB575:	LDA #$0A			;
LB577:	STA NoiseSFXData		;Start increment index for noise channel at #$0A.
LB57A:	RTS				;

MissileLaunchSFXContine:
LB57B:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB57E:	BNE IncrementPeriodIndex	;
LB580:	JMP EndNoiseSFX			;($B58F)End SFX.

BombExplodeSFXStart:
LB583:	LDA #$30			;Number of frames to play sound before a change.
LB585:	LDY #$19			;Lower byte of sound data start address(base=$B200).

GotoSelectSFXRoutine:
LB587:*	JMP SelectSFXRoutine		;($B452)Setup registers for SFX.

;The following routine is used to continue BombExplode and SamusWalk SFX.

NoiseSFXContinue:
LB58A:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB58D:	BNE MusicBranch02		;If more frames to process, branch to exit. 

EndNoiseSFX:
LB58F:	JSR ClearCurrentSFXFlags	;($B4A2)Clear all SFX flags.
LB592:	LDA #$10			;
LB594:	STA NoiseCntrl0			;disable envelope generator(sound off).

MusicBranch02:
LB597:	RTS				;Exit for multiple routines.
 
SamusWalkSFXStart:
LB598:	LDA NoiseContSFX		;If MissileLaunch, SamusWalk or SpitFire SFX are-->
LB59B:	AND #$34			;already being played, branch to exit.
LB59D:	BNE MusicBranch02		;
LB59F:	LDA #$03			;Number of frames to play sound before a change.
LB5A1:	LDY #$1D			;Lower byte of sound data start address(base=$B200).
LB5A3:	BNE -				;Branch always.

MultiSFXInit:
LB5A5:	STA MultiSFXLength		;
LB5A8:	JSR LoadSQ2ChannelSFX		;($B374)Set SQ2 SFX data.
LB5AB:	JSR UpdateContFlags		;($B493)Set continue SFX flag.
LB5AE:	LDA #$01			;
LB5B0:	STA SQ1InUse			;Disable music from using SQ1 and SQ2 while-->
LB5B3:	LDA #$02			;SFX are playing.
LB5B5:	STA SQ2InUse			;
LB5B8:	LDA #$00			;
LB5BA:	STA SQ1ContSFX			;
LB5BD:	STA SQ1SFXData			;
LB5C0:	STA SQ1SQ2SFXData		;Clear all listed memory addresses.
LB5C3:	STA SQ1SFXPeriodLow		;
LB5C6:	STA ThisMultiFrame		;
LB5C9:	STA WriteMultiChannelData	;
LB5CC:	RTS				;

EndMultiSFX:
LB5CD:	LDA #$10			;
LB5CF:	STA SQ1Cntrl0			;Disable SQ1 envelope generator(sound off).
LB5D2:	STA SQ2Cntrl0			;Disable SQ2 envelope generator(sound off).
LB5D5:	LDA #$7F			;
LB5D7:	STA SQ1Cntrl1			;Disable SQ1 sweep.
LB5DA:	STA SQ2Cntrl1			;Disable SQ2 sweep.
LB5DD:	JSR ClearCurrentSFXFlags	;($B4A2)Clear all SFX flags.
LB5E0:	LDA #$00			;
LB5E2:	STA SQ1InUse			;
LB5E5:	STA SQ2InUse			;Allows music player to use SQ1 and SQ2 channels.
LB5E8:	INC WriteMultiChannelData	;
LB5EB:	RTS				;

BossHitSFXStart:
LB5EC:	LDY #$2D			;Low byte of SQ1 sound data start address(base=$B200).
LB5EE:	JSR LoadSQ1ChannelSFX		;($B368)Set SQ1 SFX data.
LB5F1:	LDY #$29			;Low byte of SQ2 sound data start address(base=$B200).
LB5F3:	JMP MultiSFXInit		;($B5A5)Initiate multi channel SFX.

BossHitSFXContinue:
LB5F6:	INC SQ1SFXData			;Increment index to data in table below.
LB5F9:	LDY SQ1SFXData			;
LB5FC:	LDA $B63C,Y			;
LB5FF:	STA SQ1Cntrl0			;Load SQ1Cntrl0 and SQ2Cntrl0 from table below.
LB602:	STA SQ2Cntrl0			;
LB605:	LDA SQ1SFXData			;
LB608:	CMP #$14			;After #$14 frames, end SFX.
LB60A:	BEQ ++				;
LB60C:	CMP #$06			;After six or more frames of SFX, branch.
LB60E:	BCC +				;
LB610:	LDA RandomNumber1		;
LB612:	ORA #$10			;Set bit 5.
LB614:	AND #$7F			;Randomly set bits 7, 3, 2, 1 and 0.
LB616:	STA SQ1SFXPeriodLow		;Store in SQ1 period low.
LB619:	ROL				;
LB61A:	STA SQ1SQ2SFXData		;
LB61D:	JMP WriteSQ1SQ2PeriodLow	;($B62C)Write period low data to SQ1 and SQ2.
LB620:*	INC SQ1SQ2SFXData		;
LB623:	INC SQ1SQ2SFXData		;Increment SQ1 and SQ2 period low by two.
LB626:	INC SQ1SFXPeriodLow		;
LB629:	INC SQ1SFXPeriodLow		;

WriteSQ1SQ2PeriodLow:
LB62C:	LDA SQ1SQ2SFXData		;
LB62F:	STA SQ2Cntrl2			;Write new SQ1 and SQ2 period lows to SQ1 and SQ2-->
LB632:	LDA SQ1SFXPeriodLow		;channels.
LB635:	STA SQ1Cntrl2			;
LB638:	RTS				;

LB639:*	JMP EndMultiSFX			;($B5CD)End SFX.

BossHitSFXDataTbl:
LB63C:	.byte $38, $3D, $3F, $3F, $3F, $3F, $3F, $3D, $3B, $39, $3B, $3D, $3F, $3D, $3B, $39
LB64C:	.byte $3B, $3D, $3F, $39

SamusHitSFXContinue:
LB650:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB653:	BNE +				;If more SFX frames to process, branch.
LB655:	JMP EndMultiSFX			;($B5CD)End SFX.
LB658:*	LDY #$25			;Low byte of SQ1 sound data start address(base=$B200).
LB65A:	JSR LoadSQ1ChannelSFX		;($B368)Set SQ1 SFX data.
LB65D:	LDA RandomNumber1		;
LB65F:	AND #$0F			;Randomly set last four bits of SQ1 period low.
LB661:	STA SQ1Cntrl2			;
LB664:	LDY #$25			;Low byte of SQ2 sound data start address(base=$B200).
LB666:	JSR LoadSQ2ChannelSFX		;($B374)Set SQ2 SFX data.
LB669:	LDA RandomNumber1		;
LB66B:	LSR				;Multiply random number by 4.
LB66C:	LSR				;
LB66D:	AND #$0F			;
LB66F:	STA SQ2Cntrl2			;Randomly set bits 2 and 3 of SQ2 period low.
LB672:	RTS				;

SamusHitSFXStart:
LB673:	LDY #$25			;Low byte of SQ1 sound data start address(base=$B200).
LB675:	JSR LoadSQ1ChannelSFX		;($B368)Set SQ1 SFX data.
LB678:	LDA RandomNumber1		;
LB67A:	AND #$0F			;Randomly set last four bits of SQ1 period low.
LB67C:	STA SQ1Cntrl2			;
LB67F:	CLC				;
LB680:	LDA RandomNumber1		;Randomly set last three bits of SQ2 period low+1.
LB682:	AND #$03			;
LB684:	ADC #$01			;Number of frames to play sound before a change.
LB686:	LDY #$25			;Low byte of SQ2 sound data start address(base=$B200).
LB688:	JSR MultiSFXInit		;($B5A5)Initiate multi channel SFX.
LB68B:	LDA RandomNumber1		;
LB68D:	LSR				;Multiply random number by 4.
LB68E:	LSR				;
LB68F:	AND #$0F			;
LB691:	STA SQ2Cntrl2			;Randomly set bits 2 and 3 of SQ2 period low.
LB694:*	RTS				;

IncorrectPasswordSFXStart:
LB695:	LDY #$31			;Low byte of SQ1 sound data start address(base=$B200).
LB697:	JSR LoadSQ1ChannelSFX		;($B368)Set SQ1 SFX data.
LB69A:	LDA #$20			;Number of frames to play sound before a change.
LB69C:	LDY #$35			;Low byte of SQ2 sound data start address(base=$B200).
LB69E:	JMP MultiSFXInit		;($B5A5)Initiate multi channel SFX.

IncorrectPasswordSFXContinue:
LB6A1:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB6A4:	BNE -				;If more frames to process, branch to exit.
LB6A6:	JMP EndMultiSFX			;($B5CD)End SFX.

;The following table is used by the below routine to load SQ1Cntrl2 data in the-->
;MissilePickupSFXContinue routine.

MissilePickupSFXTbl:
LB6A9:	.byte $BD, $8D, $7E, $5E, $46, $3E, $00 

MissilePickupSFXContinue:
LB6B0:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB6B3:	BNE MusicBranch03		;If more frames to process, branch to exit.
LB6B5:	LDY SQ1SFXData			;
LB6B8:	LDA MissilePickupSFXTbl,Y	;Load SFX data from table above.
LB6BB:	BNE +				;
LB6BD:	JMP EndSQ1SFX			;($B6F2)SFX completed.
LB6C0:*	STA SQ1Cntrl2			;
LB6C3:	LDA $B244			;#$28.
LB6C6:	STA SQ1Cntrl3			;load SQ1Cntrl3 with #$28.
LB6C9:	INC SQ1SFXData			;Increment index to data table above every 5 frames.

MusicBranch03:
LB6CC:	RTS				;Exit from multiple routines.

MissilePickupSFXStart:
LB6CD:	LDA #$05			;Number of frames to play sound before a change.
LB6CF:	LDY #$41			;Lower byte of sound data start address(base=$B200).
LB6D1:	BNE +++				;Branch always.

EnergyPickupSFXContinue:
LB6D3:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB6D6:	BNE MusicBranch03		;If more frames to process, branch to exit.
LB6D8:	INC SQ1SFXData			;
LB6DB:	LDA SQ1SFXData			;Every six frames, reload SFX info.  Does it-->
LB6DE:	CMP #$03			;three times for a total of 18 frames.
LB6E0:	BEQ +				;
LB6E2:	LDY #$3D			;
LB6E4:	JMP LoadSQ1ChannelSFX		;($B368)Set SQ1 SFX data.

EnergyPickupSFXStart:
LB6E7:	LDA #$06			;Number of frames to play sound before a change.
LB6E9:	LDY #$3D			;Lower byte of sound data start address(base=$B200).
LB6EB:	BNE +++				;Branch always.

;The following continue routine is used by the metal, bird out of hole,
;enemy hit and the Samus jump SFXs.

SQ1SFXContinue:
LB6ED:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB6F0:	BNE MusicBranch03		;

EndSQ1SFX:
LB6F2:*	LDA #$10			;
LB6F4:	STA SQ1Cntrl0			;Disable envelope generator(sound off).
LB6F7:	LDA #$00			;
LB6F9:	STA SQ1InUse			;Allows music to use SQ1 channel.
LB6FC:	JSR ClearCurrentSFXFlags	;($B4A2)Clear all SFX flags.
LB6FF:	INC WriteMultiChannelData	;Allows music routines to load SQ1 and SQ2 music.
LB702:	RTS				;

SamusJumpSFXStart:
LB703:	LDA CurrentMusic		;If escape music is playing, exit without playing-->
LB706:	CMP #$04			;Samus jump SFX.
LB708:	BEQ MusicBranch03		;
LB70A:	LDA #$0C			;Number of frames to play sound before a change.
LB70C:	LDY #$51			;Lower byte of sound data start address(base=$B200).
LB70E:	BNE SelectSFX1			;Branch always.

EnemyHitSFXStart:
LB710:	LDA #$08			;Number of frames to play sound before a change.
LB712:	LDY #$55			;Lower byte of sound data start address(base=$B200).
LB714:	BNE SelectSFX1			;Branch always.

BulletFireSFXStart:
LB716:	LDA HasBeamSFX			;
LB719:	LSR				;If Samus has ice beam, branch.
LB71A:	BCS +++++			;
LB71C:	LDA SQ1ContSFX			;If MissilePickup, EnergyPickup, BirdOutOfHole-->
LB71F:	AND #$CC			;or EnemyHit SFX already playing, branch to exit.
LB721:	BNE MusicBranch03		;
LB723:	LDA HasBeamSFX			;
LB726:	ASL				;If Samus has long beam, branch.
LB727:	BCS +				;
LB729:	LDA #$03			;Number of frames to play sound before a change.
LB72B:	LDY #$4D			;Lower byte of sound data start address(base=$B200).
LB72D:	BNE SelectSFX1			;Branch always (Plays ShortBeamSFX).

HasLongBeamSFXStart:
LB72F:*	LDA #$07			;Number of frames to play sound before a change.
LB731:	LDY #$49			;Lower byte of sound data start address(base=$B200).
LB733:	BNE SelectSFX1			;Branch always.

MetalSFXStart:
LB735:	LDA #$0B			;Number of frames to play sound before a change.
LB737:	LDY #$45			;Lower byte of sound data start address(base=$B200).

SelectSFX1:
LB739:*	JMP SelectSFXRoutine		;($B452)Setup registers for SFX.

BirdOutOfHoleSFXStart:
LB73C:	LDA CurrentMusic		;If escape music is playing, use this SFX to make-->
LB73F:	CMP #$04			;the bomb ticking sound, else play regular SFX.
LB741:	BEQ +				;
LB743:	LDA #$16			;Number of frames to play sound before a change.
LB745:	LDY #$59			;Lower byte of sound data start address(base=$B200).
LB747:	BNE SelectSFX1			;Branch always.
LB749:*	LDA #$07			;Number of frames to play sound before a change.
LB74B:	LDY #$39			;Lower byte of sound data start address(base=$B200).
LB74D:	BNE SelectSFX1			;Branch always.

BulletFireSFXContinue:
LB74F:	LDA HasBeamSFX			;
LB752:	LSR				;If Samus has ice beam, branch.
LB753:	BCS +++				;
LB755:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB758:	BNE +				;If more frames to process, branch to exit.
LB75A:	JMP EndSQ1SFX			;($B6F2)If SFX finished, jump.
LB75D:*	RTS				;

HasIceBeamSFXStart:
LB75E:*	LDA #$07			;Number of frames to play sound before a change.
LB760:	LDY #$61			;Lower byte of sound data start address(base=$B200).
LB762:	JMP SelectSFXRoutine		;($B452)Setup registers for SFX.

HasIceBeamSFXContinue:
LB765:*	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB768:	BNE +				;If more frames to process, branch.
LB76A:	JMP EndSQ1SFX			;($B6F2)If SFX finished, jump.
LB76D:*	LDA SQ1SFXData			;
LB770:	AND #$01			;Determine index for IceBeamSFXDataTbl below.
LB772:	TAY				;
LB773:	LDA IceBeamSFXDataTbl,Y		;Loads A with value from IceBeamSFXDataTbl below.
LB776:	BNE ++				;

IceBeamSFXDataTbl:
LB778:	.byte $93			;Ice beam SFX period low data.
LB779:	.byte $81 			;

WaveBeamSFXStart:
LB77A:	LDA #$08			;Number of frames to play sound before a change.
LB77C:	LDY #$5D			;Lower byte of sound data start address(base=$B200).
LB77E:	JMP SelectSFXRoutine		;($B452)Setup registers for SFX.

WaveBeamSFXContinue:
LB781:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB784:	BNE +				;If more frames to process, branch.
LB786:	LDY SQ1SQ2SFXData		;
LB789:	INC SQ1SQ2SFXData		;Load wave beam SFXDisable/enable envelope length-->
LB78C:	LDA WaveBeamSFXDisLngthTbl,Y	;data from WaveBeamSFXDisableLengthTbl.
LB78F:	STA SQ1Cntrl0			;
LB792:	BNE MusicBranch10		;If at end of WaveBeamSFXDisableLengthTbl, end SFX.
LB794:	JMP EndSQ1SFX			;($B6F2)If SFX finished, jump.
LB797:*	LDA SQ1SFXData
LB79A:	AND #$01			;
LB79C:	TAY				;Load wave beam SFX period low data from-->
LB79D:	LDA WaveBeamSFXPeriodLowTbl,Y	;WaveBeamSFXPeriodLowTbl.

LoadSQ1PeriodLow:
LB7A0:*	STA SQ1Cntrl2			;Change the period low data for SQ1 channel.
LB7A3:	INC SQ1SFXData			;

MusicBranch10:
LB7A6:	RTS				;Exit for multiple routines.
 
WaveBeamSFXPeriodLowTbl:
LB7A7:	.byte $58			;Wave beam SFX period low data.
LB7A8:	.byte $6F			;

WaveBeamSFXDisLngthTbl:
LB7A9:	.byte $93			;
LB7AA:	.byte $91			;Wave beam SFX Disable/enable envelope length data.
LB7AB:	.byte $00			;

DoorOpenCloseSFXStart:
LB7AC:	LDA $B287			;#$30.
LB7AF:	STA TrianglePeriodLow		;Set triangle period low data byte.
LB7B2:	LDA $B288			;#$B2.
LB7B5:	AND #$07			;Set triangle period high data byte.
LB7B7:	STA TrianglePeriodHigh		;#$B7.
LB7BA:	LDA #$0F			;
LB7BC:	STA TriangleChangeLow		;Change triangle channel period low every frame by #$0F.
LB7BF:	LDA #$00			;
LB7C1:	STA TriangleChangeHigh		;No change in triangle channel period high.
LB7C4:	LDA #$1F			;Number of frames to play sound before a change.
LB7C6:	LDY #$85			;Lower byte of sound data start address(base=$B200).
LB7C8:	JMP SelectSFXRoutine		;($B452)Setup registers for SFX.

DoorOpenCloseSFXContinue:
LB7CB:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB7CE:	BNE +				;
LB7D0:	JMP EndTriangleSFX		;($B896)End SFX.
LB7D3:*	JSR DecreaseTrianglePeriods	;($B98C)Decrease periods.
LB7D6:	JMP WriteTrianglePeriods	;($B869)Save new periods.

BeepSFXStart:
LB7D9:	LDA TriangleContSFX		;If BombLaunchSFX is already playing, branch-->
LB7DC:	AND #$80			;without playing BeepSFX.
LB7DE:	BNE MusicBranch10		;
LB7E0:	LDA #$03			;Number of frames to play sound before a change.
LB7E2:	LDY #$79			;Lower byte of sound data start address(base=$B200).
LB7E4:	JMP SelectSFXRoutine		;($B452)Setup registers for SFX.

BeepSFXContinue:
LB7E7:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB7EA:	BNE MusicBranch10		;If more frames to process, branch to exit.
LB7EC:	JMP EndTriangleSFX		;($B896)End SFX.

BigEnemyHitSFXStart:
LB7EF:	LDA #$12			;Increase triangle low period by #$12 every frame.
LB7F1:	STA TriangleChangeLow		;
LB7F4:	LDA #$00			;
LB7F6:	STA TriangleChangeHigh		;Does not change triangle period high.
LB7F9:	LDA $B27F			;#$42.
LB7FC:	STA TrianglePeriodLow		;Save new triangle period low data.
LB7FF:	LDA $B280			;#$18.
LB802:	AND #$07			;#$1F.
LB804:	STA TrianglePeriodHigh		;Save new triangle period high data.
LB807:	LDA #$0A			;Number of frames to play sound before a change.
LB809:	LDY #$7D			;Lower byte of sound data start address(base=$B200).
LB80B:	JMP SelectSFXRoutine		;($B452)Setup registers for SFX.

BigEnemyHitSFXContinue:
LB80E:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB811:	BNE +				;If more frames to process, branch
LB813:	JMP EndTriangleSFX		;($B896)End SFX
LB816:*	JSR IncreaseTrianglePeriods	;($B978)Increase periods.
LB819:	LDA RandomNumber1		;
LB81B:	AND #$3C			;
LB81D:	STA TriangleSFXData		;
LB820:	LDA TrianglePeriodLow		;Randomly set or clear bits 2, 3, 4 and 5 in-->
LB823:	AND #$C3			;triangle channel period low.
LB825:	ORA TriangleSFXData		;
LB828:	STA TriangleCntrl2		;
LB82B:	LDA TrianglePeriodHigh		;
LB82E:	ORA #$40			;Set 4th bit in triangle channel period high.
LB830:	STA TriangleCntrl3		;
LB833:	RTS				;

SamusToBallSFXStart:
LB834:	LDA #$08			;Number of frames to play sound before a change.
LB836:	LDY #$6D			;Lower byte of sound data start address(base=$B200).
LB838:	JSR SelectSFXRoutine		;($B452)Setup registers for SFX.
LB83B:	LDA #$05			;
LB83D:	STA PercentDifference		;Stores percent difference. In this case 5 = 1/5 = 20%.
LB840:	LDA $B26F			;#$DD.
LB843:	STA TrianglePeriodLow		;Save new triangle period low data.
LB846:	LDA $B270			;#$3B.
LB849:	AND #$07			;#$02.
LB84B:	STA TrianglePeriodHigh		;Save new triangle period high data.
LB84E:	RTS				;

SamusToBallSFXContinue:
LB84F:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB852:	BNE +				;If more frames to process, branch.
LB854:	JMP EndTriangleSFX		;($B896)End SFX.
LB857:*	JSR DivideTrianglePeriods	;($B9A0)reduces triangle period low by 20% each frame.
LB85A:	LDA TriangleLowPercentage	;
LB85D:	STA TriangleChangeLow		;Store new values to change triangle periods.
LB860:	LDA TriangleHighPercentage	;
LB863:	STA TriangleChangeHigh		;
LB866:	JSR DecreaseTrianglePeriods	;($B98C)Decrease periods.

WriteTrianglePeriods:
LB869:	LDA TrianglePeriodLow		;Write TrianglePeriodLow to triangle channel.
LB86C:	STA TriangleCntrl2		;
LB86F:	LDA TrianglePeriodHigh		;
LB872:	ORA #$08			;Write TrianglePeriodHigh to triangle channel.
LB874:	STA TriangleCntrl3		;
LB877:	RTS				;

BombLaunchSFXStart:
LB878:	LDA #$04			;Number of frames to play sound before a change.
LB87A:	LDY #$65			;Lower byte of sound data start address(base=$B200).
LB87C:	JMP SelectSFXRoutine		;($B452)Setup registers for SFX.

BombLaunchSFXContinue:
LB87F:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB882:	BNE MusicBranch04		;If more frames to process, branch to exit.
LB884:	INC TriangleSFXData		;
LB887:	LDA TriangleSFXData		;After four frames, load second part of SFX.
LB88A:	CMP #$02			;
LB88C:	BNE +				;
LB88E:	JMP EndTriangleSFX		;($B896)End SFX.
LB891:*	LDY #$69			;Lower byte of sound data start address(base=$B200).
LB893:	JMP LoadTriangleChannelSFX	;($B36C)Prepare to load triangle channel with data.

EndTriangleSFX:
LB896:	LDA #$00			;
LB898:	STA TriangleCntrl0		;clear TriangleCntr0(sound off).
LB89B:	STA TriangleInUse		;Allows music to use triangle channel.
LB89E:	LDA #$18			;
LB8A0:	STA TriangleCntrl3		;Set length index to #$03.
LB8A3:	JSR ClearCurrentSFXFlags	;($B4A2)Clear all SFX flags.

MusicBranch04:
LB8A6:	RTS				;Exit from for multiple routines.

MetroidHitSFXStart:
LB8A7:	LDA #$03			;Number of frames to play sound before a change.
LB8A9:	LDY #$71			;Lower byte of sound data start address(base=$B200).
LB8AB:	JSR SelectSFXRoutine		;($B452)Setup registers for SFX.
LB8AE:	JMP RndTrianglePeriods		;($B8C3)MetroidHit SFX has several different sounds.

MetroiHitSFXContinue:
LB8B1:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB8B4:	BEQ +				;
LB8B6:	INC TriangleSFXData		;
LB8B9:	LDA TriangleSFXData		;Randomize triangle periods nine times throughout-->
LB8BC:	CMP #$09			;the course of the SFX.
LB8BE:	BNE MusicBranch04		;If SFX not done, branch.
LB8C0:	JMP EndTriangleSFX		;($B896)End SFX.

RndTrianglePeriods:
LB8C3:*	LDA RandomNumber1		;Randomly set or reset bits 7, 4, 2 and 1 of-->
LB8C5:	ORA #$6C			;triangle channel period low.
LB8C7:	STA TriangleCntrl2		;
LB8CA:	AND #$01			;
LB8CC:	ORA #$F8			;Randomly set or reset last bit of triangle-->
LB8CE:	STA TriangleCntrl3		;channel period high.
LB8D1:	RTS				;

SamusDieSFXStart:
LB8D2:	JSR InitializeSoundAddresses	;($B404)Clear all sound addresses.
LB8D5:	LDA #$0E			;Number of frames to play sound before a change.
LB8D7:	LDY #$75			;Lower byte of sound data start address(base=$B200).
LB8D9:	JSR SelectSFXRoutine		;($B452)Setup registers for SFX.
LB8DC:	LDA #$15			;Decrease triangle SFX periods by 4.8% every frame.
LB8DE:	STA PercentDifference		;
LB8E1:	LDA $B277			;#$40.
LB8E4:	STA TrianglePeriodLow		;
LB8E7:	LDA #$00			;Initial values of triangle periods.
LB8E9:	STA TrianglePeriodHigh		;
LB8EC:*	RTS				;

SamusDieSFXContinue:
LB8ED:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB8F0:	BNE +				;
LB8F2:	LDA #$20			;Store change in triangle period low.
LB8F4:	STA TriangleChangeLow		;
LB8F7:	LDA #$00			;
LB8F9:	STA TriangleChangeHigh		;No change in triangle period high.
LB8FC:	JSR DecreaseTrianglePeriods	;($B98C)Decrease periods.
LB8FF:	INC TriangleSFXData		;
LB902:	LDA TriangleSFXData		;
LB905:	CMP #$06			;
LB907:	BNE -				;If more frames to process, branch to exit.
LB909:	JMP EndTriangleSFX		;($B896)End SFX.
LB90C:*	JSR DivideTrianglePeriods	;($B9A0)reduces triangle period low.
LB90F:	LDA TriangleLowPercentage	;
LB912:	STA TriangleChangeLow		;Update triangle periods.
LB915:	LDA TriangleHighPercentage	;
LB918:	STA TriangleChangeHigh		;
LB91B:	JSR IncreaseTrianglePeriods	;($B978)Increase periods.
LB91E:	JMP WriteTrianglePeriods	;($B869)Save new periods.

StatueRaiseSFXStart:
LB921:	LDA $B283			;#$11.
LB924:	STA TrianglePeriodLow		;Save period low data.
LB927:	LDA $B284			;#$09.
LB92A:	AND #$07			;
LB92C:	STA TrianglePeriodHigh		;Store last three bits in $B284.
LB92F:	LDA #$00			;
LB931:	STA TriangleChangeHigh		;No change in Triangle period high.
LB934:	LDA #$0B			;
LB936:	STA TriangleChangeLow		;
LB939:	LDA #$06			;Number of frames to play sound before a change.
LB93B:	LDY #$81			;Lower byte of sound data start address(base=$B200).
LB93D:	JMP SelectSFXroutine		;($B452)Setup registers for SFX.

StatueRaiseSFXContinue:
LB940:	JSR IncrementSFXFrame		;($B4A9)Get next databyte to process in SFX.
LB943:	BNE ++				;
LB945:	INC TriangleSFXData		;Increment TriangleSFXData every 6 frames.
LB948:	LDA TriangleSFXData		;
LB94B:	CMP #$09			;When TriangleSFXData = #$09, end SFX.
LB94D:	BNE +				;
LB94F:	JMP EndTriangleSFX		;($B896)End SFX.
LB952:*	LDA TriangleChangeLow		;
LB955:	PHA				;Save triangle periods.
LB956:	LDA TriangleChangeHigh		;
LB959:	PHA				;
LB95A:	LDA #$25			;
LB95C:	STA TriangleChangeLow		;
LB95F:	LDA #$00			;No change in triangle period high.
LB961:	STA TriangleChangeHigh		;
LB964:	JSR IncreaseTrianglePeriods	;($B978)Increase periods.
LB967:	PLA				;
LB968:	STA TriangleChangeHigh		;Restore triangle periods.
LB96B:	PLA				;
LB96C:	STA TriangleChangeLow		;
LB96F:	JMP WriteTrianglePeriods	;($B869)Save new periods.
LB972:*	JSR DecreaseTrianglePeriods	;($B98C)Decrease periods.
LB975:	JMP WriteTrianglePeriods	;($B869)Save new periods.

IncreaseTrianglePeriods:
LB978:	CLC 
LB979:	LDA TrianglePeriodLow		;
LB97C:	ADC TriangleChangeLow		;Calculate new TrianglePeriodLow.
LB97F:	STA TrianglePeriodLow		;
LB982:	LDA TrianglePeriodHigh		;
LB985:	ADC TriangleChangeHigh		;Calculate new TrianglePeriodHigh.
LB988:	STA TrianglePeriodHigh		;
LB98B:	RTS				;

DecreaseTrianglePeriods:
LB98C:	SEC 
LB98D:	LDA TrianglePeriodLow		;
LB990:	SBC TriangleChangeLow		;Calculate new TrianglePeriodLow.
LB993:	STA TrianglePeriodLow		;
LB996:	LDA TrianglePeriodHigh		;
LB999:	SBC TriangleChangeHigh		;Calculate new TrianglePeriodHigh.
LB99C:	STA TrianglePeriodHigh		;
LB99F:	RTS				;

DivideTrianglePeriods:
LB9A0:	LDA TrianglePeriodLow		;
LB9A3:	PHA				;Store TrianglePeriodLow and TrianglePeriodHigh.
LB9A4:	LDA TrianglePeriodHigh		;
LB9A7:	PHA				;
LB9A8:	LDA #$00			;
LB9AA:	STA DivideData			;
LB9AD:	LDX #$10			;
LB9AF:	ROL TrianglePeriodLow		;
LB9B2:	ROL TrianglePeriodHigh		;
LB9B5:*	ROL DivideData			;The following routine takes the triangle period-->
LB9B8:	LDA DivideData			;high and triangle period low values and reduces-->
LB9BB:	CMP PercentDifference		;them by a certain percent.  The percent is-->
LB9BE:	BCC +				;determined by the value stored in-->
LB9C0:	SBC PercentDifference		;PercentDifference.  If PercentDifference=#$05,-->
LB9C3:	STA DivideData			;then the values will be reduced by 20%(1/5).-->
LB9C6:*	ROL TrianglePeriodLow		;If PercentDifference=#$0A,Then the value will-->
LB9C9:	ROL TrianglePeriodHigh		;be reduced by 10%(1/10), etc. This function is-->
LB9CC:	DEX				;basically a software emulation of a sweep function.
LB9CD:	BNE --				;
LB9CF:	LDA TrianglePeriodLow		;
LB9D2:	STA TriangleLowPercentage	;
LB9D5:	LDA TrianglePeriodHigh		;
LB9D8:	STA TriangleHighPercentage	;
LB9DB:	PLA				;
LB9DC:	STA TrianglePeriodHigh		;Restore TrianglePerodLow and TrianglePeriodHigh.
LB9DF:	PLA				;
LB9E0:	STA TrianglePeriodLow		;
LB9E3:	RTS				;

;--------------------------------------[ End SFX routines ]-------------------------------------
 
SetVolumeAndDisableSweep:
LB9E4:	LDA #$7F			;
LB9E6:	STA MusicSQ1Sweep		;Disable sweep generator on SQ1 and SQ2.
LB9E9:	STA MusicSQ2Sweep		;
LB9EC:	STX SQ1DutyEnvelope		;Store duty cycle and volume data for SQ1 and SQ2.
LB9EF:	STY SQ2DutyEnvelope		;
LB9F2:	RTS				;

ResetVolumeIndex:
LB9F3:	LDA SQ1MusicFrameCount		;If at the beginning of a new SQ1 note, set-->
LB9F6:	CMP #$01			;SQ1VolumeIndex = #$01.
LB9F8:	BNE +				;
LB9FA:	STA SQ1VolumeIndex		;
LB9FD:*	LDA SQ2MusicFrameCount		;
LBA00:	CMP #$01			;If at the beginning of a new SQ2 note, set-->
LBA02:	BNE +				;SQ2VolumeIndex = #$01.
LBA04:	STA SQ2VolumeIndex		;
LBA07:*	RTS 				;

LoadSQ1SQ2Periods:
LBA08:	LDA WriteMultiChannelData	;If a Multi channel data does not need to be-->
LBA0B:	BEQ +				;loaded, branch to exit.
LBA0D:	LDA #$00			;
LBA0F:	STA WriteMultiChannelData	;Clear multi channel data write flag.
LBA12:	LDA MusicSQ1Sweep		;
LBA15:	STA SQ1Cntrl1			;
LBA18:	LDA MusicSQ1PeriodLow		;
LBA1B:	STA SQ1Cntrl2			;Loads SQ1 channel addresses $4001, $4002, $4003.
LBA1E:	LDA MusicSQ1PeriodHigh		;
LBA21:	STA SQ1Cntrl3			;
LBA24:	LDA MusicSQ2Sweep		;
LBA27:	STA SQ2Cntrl1			;
LBA2A:	LDA MusicSQ2PeriodLow		;
LBA2D:	STA SQ2Cntrl2			;Loads SQ2 channel addresses $4005, $4006, $4007.
LBA30:	LDA MusicSQ2PeriodHigh		;
LBA33:	STA SQ2Cntrl3			;
LBA36:*	RTS				;

LoadSQ1SQ2Channels:
LBA37:	LDX #$00			;Load SQ1 channel data.
LBA39:	JSR WriteSQCntrl0		;($BA41)Write Cntrl0 data.
LBA3C:	INX				;Load SQ2 channel data.
LBA3D:	JSR WriteSQCntrl0		;($BA41)Write Cntrl0 data.
LBA40:	RTS				;

WriteSQCntrl0:
LBA41:	LDA SQ1VolumeCntrl,X		;Load SQ channel volume data. If zero, branch to exit.
LBA44:	BEQ +++++			;
LBA46:	STA VolumeCntrlAddress		;
LBA48:	JSR LoadSQ1SQ2Periods		;($BA08)Load SQ1 and SQ2 control information.
LBA4B:	LDA SQ1VolumeData,X		;
LBA4E:	CMP #$10			;If sound channel is not currently-->
LBA50:	BEQ +++++++			;playing sound, branch.
LBA52:	LDY #$00			;
LBA54:*	DEC VolumeCntrlAddress		;Desired entry in VolumeCntrlAdressTbl.
LBA56:	BEQ +				;
LBA58:	INY				;*2(2 byte address to find voulume control data).
LBA59:	INY				;
LBA5A:	BNE -				;Keep decrementing until desired address is found.
LBA5C:*	LDA VolumeCntrlAddressTbl,Y	;Base is $BCB0.
LBA5F:	STA $EC				;Volume data address low byte.
LBA61:	LDA VolumeCntrlAddressTbl+1,Y	;Base is $BCB1.
LBA64:	STA $ED				;Volume data address high byte.
LBA66:	LDY SQ1VolumeIndex,X		;Index to desired volume data.
LBA69:	LDA ($EC),Y			;Load desired volume for current channel into-->
LBA6B:	STA Cntrl0Data			;Cntrl0Data.
LBA6D:	CMP #$FF			;If last entry in volume table is #$FF, restore-->
LBA6F:	BEQ MusicBranch05		;volume to its original level after done reading-->
LBA71:	CMP #$F0			;Volume data.  If #$F0 is last entry, turn sound-->
LBA73:	BEQ MusicBranch06		;off on current channel until next note.
LBA75:	LDA SQ1DutyEnvelope,X		;Remove duty cycle data For current channel and-->
LBA78:	AND #$F0			;add this frame of volume data and store results--> 
LBA7A:	ORA Cntrl0Data			;in Cntrl0Data.
LBA7C:	TAY				;
LBA7D:*	INC SQ1VolumeIndex,X		;Increment Index to volume data.
LBA80:*	LDA SQ1InUse,X			;If SQ1 or SQ2(depends on loop iteration) in use,-->
LBA83:	BNE +				;branch to exit, else write SQ(1 or 2)Cntrl0.
LBA85:	TXA				;
LBA86:	BEQ ++				;If currently on SQ1, branch to write SQ1 data.

WriteSQ2Cntrl0:				;
LBA88:	STY SQ2Cntrl0			;Write SQ2Cntrl0 data.
LBA8B:*	RTS				;

WriteSQ1Cntrl0:				;
LBA8C:*	STY SQ1Cntrl0			;Write SQ1Cntrl0 data.
LBA8F:	RTS				;

MusicBranch05:
LBA90:	LDY SQ1DutyEnvelope,X		;Restore original volume of sound channel.
LBA93:	BNE ---				;Branch always.

MusicBranch06:
LBA95:	LDY #$10			;Disable envelope generator and set volume to 0.
LBA97:	BNE ---				;Branch always.
LBA99:*	LDY #$10			;Disable envelope generator and set volume to 0.
LBA9B:	BNE -----			;Branch always.

GotoCheckRepeatMusic:
LBA9D:*	JSR CheckRepeatMusic		;($B3F0)Resets music flags if music repeats.
LBAA0:	RTS				;

GotoLoadSQ1SQ2Channels:
LBAA1:*	JSR LoadSQ1SQ2Channels		;($BA37)Load SQ1 and SQ2 channel data.
LBAA4:	RTS				;

LoadCurrentMusicFrameData:
LBAA5:	JSR ResetVolumeIndex		;($B9F3)Reset index if at the beginning of a new note.
LBAA8:	LDA #$00			;
LBAAA:	TAX				;X = #$00.
LBAAB:	STA ThisSoundChannel		;(#$00, #$04, #$08 or #$0C).
LBAAE:	BEQ ++				;
LBAB0:*	TXA				;
LBAB1:	LSR				;
LBAB2:	TAX				;Increment to next sound channel(1,2 or 3).
					;
IncrementToNextChannel:			;
LBAB3:	INX				;
LBAB4:	TXA				;
LBAB5:	CMP #$04			;If done with four sound channels, branch to load-->
LBAB7:	BEQ --				;sound channel SQ1 SQ2 data.
LBAB9:	LDA ThisSoundChannel		;Add 4 to the least significant byte of the current-->
LBABC:	CLC 				;sound channel start address.  This moves to next-->
LBABD:	ADC #$04			;sound channel address ranges to process.
LBABF:	STA ThisSoundChannel		;
LBAC2:*	TXA				;
LBAC3:	ASL				;*2(two bytes for sound channel info base address).
LBAC4:	TAX				;
LBAC5:	LDA SQ1LowBaseByte,X		;
LBAC8:	STA $E6				;Load sound channel info base address into $E6-->
LBACA:	LDA SQ1HighBaseByte,X		;and $E7. ($E6=low byte, $E7=high byte).
LBACD:	STA $E7				;
LBACF:	LDA SQ1HighBaseByte,X		;If no data for this sound channel, branch-->
LBAD2:	BEQ --				;to find data for next sound channel.
LBAD4:	TXA				;
LBAD5:	LSR				;/2. Determine current sound channel (0,1,2 or3).
LBAD6:	TAX				;
LBAD7:	DEC SQ1MusicFrameCount,X	;Decrement the current sound channel frame count-->
LBADA:	BNE IncrementToNextChannel	;If not zero, branch to check next channel, else-->
					;load the next set of sound channel data.
LoadNextChannelIndexData:
LBADC:	LDY SQ1MusicIndexIndex,X	;Load current channel index to music data index.
LBADF:	INC SQ1MusicIndexIndex,X	;Increment current channel index to music data index.
LBAE2:	LDA ($E6),Y			;
LBAE4:	BEQ ----				;Branch if music has reached the end.
LBAE6:	TAY				;Transfer music data index to Y (base=$BE77) .
LBAE7:	CMP #$FF			;
LBAE9:	BEQ +				;At end of loop? If yes, branch.
LBAEB:	AND #$C0			;
LBAED:	CMP #$C0			;At beginnig of new loop? if yes, branch.
LBAEF:	BEQ ++				;
LBAF1:	JMP LoadMusicChannel		;($BB1C)Load music data into channel.

RepeatMusicLoop:
LBAF4:*	LDA SQ1RepeatCounter,X		;If loop counter has reached zero, branch to exit.
LBAF7:	BEQ ++				;
LBAF9:	DEC SQ1RepeatCounter,X		;Decrement loop counter.
LBAFC:	LDA SQ1LoopIndex,X		;Load loop index for proper channel and store it in-->
LBAFF:	STA SQ1MusicIndexIndex,X	;music index index address.
LBB02:	BNE ++				;Branch unless music has reached the end.

StartNewMusicLoop:
LBB04:*	TYA				;
LBB05:	AND #$3F			;Remove last six bits of loop controller and save-->
LBB07:	STA SQ1RepeatCounter,X		;in repeat counter addresses.  # of times to loop.
LBB0A:	DEC SQ1RepeatCounter,X		;Decrement loop counter.
LBB0D:	LDA SQ1MusicIndexIndex,X	;Store location of loop start in loop index address.
LBB10:	STA SQ1LoopIndex,X		;
LBB13:*	JMP LoadNextChannelIndexData	;($BADC)Load next channel index data.

LBB16:*	JMP LoadNoiseChannelMusic	;($BBDE)Load data for noise channel music.

LBB19:*	JMP LoadTriangleCntrl0		;($BBB7)Load Cntrl0 byte of triangle channel.

LoadMusicChannel:
LBB1C:	TYA				;
LBB1D:	AND #$B0			;
LBB1F:	CMP #$B0			;Is data byte music note length data?  If not, branch.
LBB21:	BNE +				;
LBB23:	TYA				;
LBB24:	AND #$0F			;Separate note length data.
LBB26:	CLC				;
LBB27:	ADC NoteLengthTblOffset		;Find proper note lengths table for current music.
LBB2A:	TAY				;
LBB2B:	LDA NoteLengths0Tbl,Y		;(Base is $BEF7)Load note length and store in--> 
LBB2E:	STA SQ1FrameCountInit,X		;frame count init address.
LBB31:	TAY				;Y now contains note length.
LBB32:	TXA				;
LBB33:	CMP #$02			;If loading Triangle channel data, branch.
LBB35:	BEQ -				;

LoadSoundDataIndexIndex:
LBB37:	LDY SQ1MusicIndexIndex,X	;Load current index to sound data index.
LBB3A:	INC SQ1MusicIndexIndex,X	;Increment music index index address.
LBB3D:	LDA ($E6),Y			;Load index to sound channel music data.
LBB3F:	TAY				;
LBB40:*	TXA				;
LBB41:	CMP #$03			;If loading Noise channel data, branch.
LBB43:	BEQ ---				;
LBB45:	PHA				;Push music channel number on stack(0, 1 or 2).
LBB46:	LDX ThisSoundChannel		;
LBB49:	LDA MusicNotesTbl+1,Y		;(Base=$BE78)Load A with music channel period low data.
LBB4C:	BEQ +				;If data is #$00, skip period high and low loading.
LBB4E:	STA MusicSQ1PeriodLow,X		;Store period low data in proper period low address.
LBB51:	LDA MusicNotesTbl,Y		;(Base=$BE77)Load A with music channel period high data.
LBB54:	ORA #$08			;Ensure minimum index length of 1.
LBB56:	STA MusicSQ1PeriodHigh,X	;Store period high data in proper period high address.
LBB59:*	TAY				;
LBB5A:	PLA				;Pull stack and restore channel number to X.
LBB5B:	TAX				;
LBB5C:	TYA				;
LBB5D:	BNE +				;If period information was present, branch.
				
NoPeriodInformation:
LBB5F:	LDA #$00			;Turn off channel volume since no period data present.
LBB61:	STA Cntrl0Data			;
LBB63:	TXA				;
LBB64:	CMP #$02			;If loading triangle channel data, branch.
LBB66:	BEQ ++				;
LBB68:	LDA #$10			;Turn off volume and disable env. generator(SQ1,SQ2).
LBB6A:	STA Cntrl0Data			;
LBB6C:	BNE ++				;Branch always.

PeriodInformationFound:
LBB6E:*	LDA SQ1DutyEnvelope,X		;Store channel duty cycle and volume info in $EA.
LBB71:	STA Cntrl0Data			;
LBB73:*	TXA				;
LBB74:	DEC SQ1InUse,X			;
LBB77:	CMP SQ1InUse,X			;If SQ1 or SQ2 are being used by SFX routines, branch.
LBB7A:	BEQ +++				;
LBB7C:	INC SQ1InUse,X			;Restore not in use status of SQ1 or SQ2.
LBB7F:	LDY ThisSoundChannel		;
LBB82:	TXA				;
LBB83:	CMP #$02			;If loading triangle channel data, branch.
LBB85:	BEQ +				;
LBB87:	LDA SQ1VolumeCntrl,X		;If $062E or $062F has volume data, skip writing-->
LBB8A:	BNE ++				;Cntrl0Data to SQ1 or SQ2.
LBB8C:*	LDA Cntrl0Data			;
LBB8E:	STA SQ1Cntrl0,Y			;Write Cntrl0Data.
LBB91:*	LDA Cntrl0Data			;
LBB93:	STA SQ1VolumeData,X		;Store volume data index to volume data.
LBB96:	LDA MusicSQ1PeriodLow,Y		;
LBB99:	STA SQ1Cntrl2,Y			;
LBB9C:	LDA MusicSQ1PeriodHigh,Y	;Write data to three sound channel addresses.
LBB9F:	STA SQ1Cntrl3,Y			;
LBBA2:	LDA MusicSQ1Sweep,X		;
LBBA5:	STA SQ1Cntrl1,Y			;

LoadNewMusicFrameCount:
LBBA8:	LDA SQ1FrameCountInit,X		;Load new music frame count and store it in music-->
LBBAB:	STA SQ1MusicFrameCount,X	;frame count address.
LBBAE:	JMP IncrementToNextChannel	;($BAB3)Move to next sound channel.

SQ1SQ2InUse:
LBBB1:*	INC SQ1InUse,X			;Restore in use status of SQ1 or SQ1.
LBBB4:	JMP LoadNewMusicFrameCount	;($BBA8)Load new music frame count.

LoadTriangleCntrl0:
LBBB7:	LDA TriangleCounterCntrl	;
LBBBA:	AND #$0F			;If lower bits set, branch to play shorter note. 
LBBBC:	BNE ++				;
LBBBE:	LDA TriangleCounterCntrl	;
LBBC1:	AND #$F0			;If upper bits are set, branch to play longer note.
LBBC3:	BNE +				;
LBBC5:	TYA				;
LBBC6:	JMP AddTriangleLength		;($BBCD)Calculate length to play note.
LBBC9:*	LDA #$FF			;Disable length cntr(play until triangle data changes).
LBBCB:	BNE +				;Branch always.

AddTriangleLength:
LBBCD:	CLC 				;
LBBCE:	ADC #$FF			;Add #$FF(Effectively subtracts 1 from A).
LBBD0:	ASL				;*2.
LBBD1:	ASL				;*2.
LBBD2:	CMP #$3C			;
LBBD4:	BCC +				;If result is greater than #$3C, store #$3C(highest-->
LBBD6:	LDA #$3C			;triangle linear count allowed).
LBBD8:*	STA TriLinearCount		;
LBBDB:*	JMP LoadSoundDataIndexIndex	;($BB37)Load index to sound data index.

LoadNoiseChannelMusic:
LBBDE:	LDA NoiseContSFX		;
LBBE1:	AND #$FC			;If playing any Noise SFX, branch to exit.
LBBE3:	BNE +				;
LBBE5:	LDA $B200,Y			;
LBBE8:	STA NoiseCntrl0			;Load noise channel with drum beat SFX starting-->
LBBEB:	LDA $B201,Y			;at address B201.  The possible values of Y are-->
LBBEE:	STA NoiseCntrl2			;#$01, #$04, #$07 or #$0A.
LBBF1:	LDA $B202,Y			;
LBBF4:	STA NoiseCntrl3			;
LBBF7:*	JMP LoadNewMusicFrameCount	;($BBA8)Load new music frame count.

;The following table is used by the InitializeMusic routine to find the index for loading
;addresses $062B thru $0637.  Base is $BD31.

InitMusicIndexTbl:
LBBFA:	.byte $41			;Ridley area music.
LBBFB:	.byte $8F			;Tourian music.
LBBFC:	.byte $34			;Item room music.
LBBFD:	.byte $27			;Kraid area music.
LBBFE:	.byte $1A			;Norfair music.
LBBFF:	.byte $0D			;Escape music.
LBC00:	.byte $00			;Mother brain music.
LBC01:	.byte $82			;Brinstar music.
LBC02:	.byte $68			;Fade in music.
LBC03:	.byte $75			;Power up music.
LBC04:	.byte $4E			;End music.
LBC05:	.byte $5B			;Intro music.

;The tables below contain addresses for SFX and music handling routines.
;Multi channel Init SFX and music handling routine addresses:

LBC06:	.word $BC80			;Fade in music.
LBC08:	.word $BC7A			;Power up music. 
LBC0A:	.word $BC86			;End game music.
LBC0C:	.word $BC7A			;Intro music.
LBC0E:	.word $B4EE			;No sound.
LBC10:	.word $B673			;Samus hit init SFX.
LBC12:	.word $B5EC			;Boss hit init SFX.
LBC14:	.word $B695			;Incorrect password init SFX.

;Multi channel continue SFX handling routine addresses:

LBC16:	.word $B4EE			;No sound.
LBC18:	.word $B4EE			;No sound.
LBC1A:	.word $B4EE			;No sound.
LBC1C:	.word $B4EE			;No sound.
LBC1E:	.word $B4EE			;No sound.
LBC20:	.word $B650			;Samus hit continue SFX.
LBC22:	.word $B5F6			;Boss hit continue SFX.
LBC24:	.word $B6A1			;Incorrect password continue SFX.

;Music handling routine addresses:

LBC26:	.word $BC83			;Ridley area music.
LBC28:	.word $BC77			;Tourian music.
LBC2A:	.word $BC77			;Item room music.
LBC2C:	.word $BC77			;Kraid area music.
LBC2E:	.word $BC80			;Norfair music.
LBC30:	.word $BC7D			;Escape music.
LBC32:	.word $BC77			;Mother brain music.
LBC34:	.word $BC80			;Brinstar music.

;-----------------------------------[ Entry point for music routines ]--------------------------------

LoadMusicTempFlags:
LBC36:	LDA CurrentMusicRepeat		;Load A with temp music flags, (9th SFX cycle).
LBC39:	LDX #$B6			;Lower address byte in ChooseNextSFXRoutineTbl.
LBC3B:	BNE +				;Branch always.

LoadMusicInitFlags:
LBC3D:	LDA MusicInitFlag		;Load A with Music flags, (10th SFX cycle).
LBC40:	LDX #$B1			;Lower address byte in ChooseNextSFXRoutineTbl.
LBC42:*	JSR CheckSFXFlag		;($B4BD)Checks to see if SFX or music flags set.
LBC45:	JSR FindMusicInitIndex		;($BC53)Find bit containing music init flag.
LBC48:	JMP ($00E2)			;If no flag found, Jump to next SFX cycle,-->
					;else jump to specific SFX handling subroutine.

ContinueMusic:				;11th and last SFX cycle.
LBC4B:	LDA CurrentMusic		;
LBC4E:	BEQ +++				;Branch to exit of no music playing.
LBC50:	JMP LoadCurrentMusicFrameData	;($BAA5)Load info for current frame of music data.

;MusicInitIndex values correspond to the following music:
;#$00=Ridley area music, #$01=Tourian music, #$02=Item room music, #$03=Kraid area music,
;#$04=Norfair music, #$05=Escape music, #$06=Mother brain music, #$07=Brinstar music,
;#$08=Fade in music, #$09=Power up music, #$0A=End game music, #$0B=Intro music.

FindMusicInitIndex:
LBC53:	LDA #$FF			;Load MusicInitIndex with #$FF.
LBC55:	STA MusicInitIndex		;
LBC58:	LDA CurrentSFXFlags		;
LBC5B:	BEQ ++				;Branch to exit if no SFX flags set for Multi SFX.
LBC5D:*	INC MusicInitIndex		;
LBC60:	ASL				;Shift left until bit flag is in carry bit.
LBC61:	BCC -				;Loop until SFX flag found.  Store bit-->
LBC63:*	RTS				;number of music in MusicInitIndex.

;The following routine is used to add eight to the music index when looking for music flags
;in the MultiSFX address.  
Add8:
LBC64:	LDA MusicInitIndex		;
LBC67:	CLC				;
LBC68:	ADC #$08			;Add #$08 to MusicInitIndex.
LBC6A:	STA MusicInitIndex		;
LBC6D:	RTS				;

LBC6E:	LDA CurrentMusic		;
LBC71:	ORA #$F0			;This code does not appear to be used in this page.
LBC73:	STA CurrentMusic		;
LBC76:*	RTS				;

Music00Start:
LBC77:	JMP Music00Init			;($BCAA)Initialize music 00.

Music01Start:
LBC7A:	JMP Music01Init			;($BCA4)Initialize music 01.

Music02Start:
LBC7D:	JMP Music02Init			;($BC9A)Initialize music 02.

Msic03Start:
LBC80:	JMP Music03Init			;($BC96)Initialize music 03.

Music04Start:
LBC83:	JMP Music04Init			;($BC89)Initialize music 04.

Music05Start:
LBC86:	JMP Music05Init			;($BC9E)Initialize music 05.

Music04Init:
LBC89:	LDA #$B3			;Duty cycle and volume data for SQ1 and SQ2.

XYMusicInit:
LBC8B:*	TAX				;Duty cycle and volume data for SQ1.
LBC8C:	TAY				;Duty cycle and volume data for SQ2.

LBC8D:*	JSR SetVolumeAndDisableSweep	;($B9E4)Set duty cycle and volume data for SQ1 and SQ2.
LBC90:	JSR InitializeMusic		;($BF19)Setup music registers.
LBC93:	JMP LoadCurrentMusicFrameData	;($BAA5)Load info for current frame of music data.

Music03Init:
LBC96:	LDA #$34			;Duty cycle and volume data for SQ1 and SQ2.
LBC98:	BNE --				;Branch always

Music02Init:
LBC9A:	LDA #$F4			;Duty cycle and volume data for SQ1 and SQ2.
LBC9C:	BNE --				;Branch always

Music05Init:
LBC9E:	LDX #$F5			;Duty cycle and volume data for SQ1.
LBCA0:	LDY #$F6			;Duty cycle and volume data for SQ2.
LBCA2:	BNE -				;Branch always

Music01Init:
LBCA4:	LDX #$B6			;Duty cycle and volume data for SQ1.
LBCA6:	LDY #$F6			;Duty cycle and volume data for SQ2.
LBCA8:	BNE -				;Branch always

Music00Init:
LBCAA:	LDX #$92			;Duty cycle and volume data for SQ1.
LBCAC:	LDY #$96			;Duty cycle and volume data for SQ2.
LBCAE:	BNE -				;Branch always

;The following address table provides starting addresses of the volume data tables below:
VolumeCntrlAddressTbl:
LBCB0:	.word $BCBA, $BCC5, $BCCF, $BCDA, $BD03

VolumeDataTbl1:
LBCBA:	.byte $01, $02, $02, $03, $03, $04, $05, $06, $07, $08, $FF

VolumeDataTbl2:
LBCC5:	.byte $02, $04, $05, $06, $07, $08, $07, $06, $05, $FF

VolumeDataTbl3:
LBCCF:	.byte $00, $0D, $09, $07, $06, $05, $05, $05, $04, $04, $FF

VolumeDataTbl4:
LBCDA:	.byte $02, $06, $07, $07, $07, $06, $06, $06, $06, $05, $05, $05, $04, $04, $04, $03
LBCEA:	.byte $03, $03, $03, $02, $03, $03, $03, $03, $03, $02, $02, $02, $02, $02, $02, $02
LBCFA:	.byte $02, $02, $02, $01, $01, $01, $01, $01, $F0

VolumeDataTbl5:
LBD03:	.byte $0A, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $07, $07, $06, $05, $04, $04
LBD13:	.byte $03, $02, $02, $02, $05, $05, $05, $04, $03, $02, $02, $02, $01, $01, $04, $04
LBD23:	.byte $03, $02, $01, $02, $02, $01, $01, $01, $02, $02, $02, $01, $01, $F0 

;The init music table loads addresses $062B thru $0637 with the initial data needed to play the
;selected music.  The data for each entry in the table have the following format:
;.byte $xx, $xx, $xx, $xx, $xx : .word $xxxx, $xxxx, $xxxx, $xxxx.
;The first five bytes have the following functions:
;Byte 0=index to proper note length table.  Will be either #$00, #$0B or #$17.
;Byte 1=Repeat music byte. #$00=no repeat, any other value and the music repeats.
;Byte 2=Controls length counter for triangle channel.
;Byte 3=Volume control byte for SQ1.
;Byte 4=Volume control byte for SQ2.
;Address 0=Base address of SQ1 music data.
;Address 1=Base address of SQ2 music data.
;Address 2=Base address of triangle music data.
;Address 3=Base address of noise music data.

InitMusicTbl:

;Mother brain music(not used this memory page).
LBD31:	.byte $0B, $FF, $F5, $00, $00
LBD36:	.word $0100, $0300, $0500, $0000

;Escape music(not used this memory page).
LBD3E:	.byte $0B, $FF, $00, $02, $02
LBD43:	.word $0100, $0300, $0500, $0700

;Norfair music(not used this memory page).
LBD4B:	.byte $0B, $FF, $F0, $04, $04
LBD50:	.word $0100, $0300, $0500, $0700

;Kraid area music(not used this memory page).
LBD58:	.byte $00, $FF, $F0, $00, $00
LBD5D:	.word $0100, $0300, $0500, $0000

;Item room music.
LBD65:	.byte $0B, $FF, $03, $00, $00
LBD6A:	.word $BDDA, $BDDC, $BDCD, $0000

;Ridley area music(not used this memory page).
LBD72:	.byte $0B, $FF, $F0, $01, $01
LBD77:	.word $0100, $0300, $0500, $0000

;End game music(not used this memory page).
LBD7F:	.byte $17, $00, $00, $02, $01
LBD84:	.word $0100, $0300, $0500, $0700

;Intro music(not used this memory page).
LBD8C:	.byte $17, $00, $F0, $02, $05
LBD91:	.word $0100, $0300, $0500, $0700

;Fade in music
LBD99:	.byte $0B, $00, $F0, $02, $00
LBD9E:	.word $BE3E, $BE1D, $BE36, $0000

;Power up music
LBDA6:	.byte $00, $00, $F0, $01, $00
LBDAB:	.word $BDF7, $BE0D, $BE08, $0000

;Brinstar music
LBDB3:	.byte $0B, $FF, $00, $02, $03
LBDB8:	.word $B000, $B057, $B0C1, $B12B

;Tourian music
LBDC0:	.byte $0B, $FF, $03, $00, $00
LBDC5:	.word $BE59, $BE47, $BE62, $0000

ItemRoomTriangleIndexData:
LBDCD:	.byte $C8			;
LBDCE:	.byte $B0			;3/32 seconds	+
LBDCF:	.byte $38			;E3		|
LBDD0:	.byte $3A			;F3		|
LBDD1:	.byte $3C			;F#3		|
LBDD2:	.byte $3E			;G3		|
LBDD3:	.byte $40			;Ab3		| Repeat 8 times
LBDD4:	.byte $3E			;G3		|
LBDD5:	.byte $3C			;F#3		|
LBDD6:	.byte $3A			;F3		|
LBDD7:	.byte $B6			;1 3/16 seconds	|
LBDD8:	.byte $02			;no sound	+
LBDD9:	.byte $FF			;

ItemRoomSQ1IndexData:
LBDDA:	.byte $B8			;1/4 seconds
LBDDB:	.byte $02			;No sound

ItemRoomSQ2IndexData:
LBDDC:	.byte $B3			;3/4 seconds
LBDDD:	.byte $02			;No sound
LBDDE:	.byte $B2			;3/8 seconds
LBDDF:	.byte $74			;A#6
LBDE0:	.byte $02			;No sound
LBDE1:	.byte $6A			;F5
LBDE2:	.byte $02			;No sound
LBDE3:	.byte $72			;A6
LBDE4:	.byte $02			;No sound
LBDE5:	.byte $62			;C#5
LBDE6:	.byte $B4			;1 1/2 seconds
LBDE7:	.byte $02			;No sound
LBDE8:	.byte $B2			;3/8 seconds
LBDE9:	.byte $60			;C5
LBDEA:	.byte $02			;No sound
LBDEB:	.byte $6C			;F#5
LBDEC:	.byte $02			;No sound
LBDED:	.byte $76			;B6
LBDEE:	.byte $B3			;3/4 seconds
LBDEF:	.byte $02			;No sound
LBDF0:	.byte $B2			;3/8 seconds
LBDF1:	.byte $7E			;F6
LBDF2:	.byte $02			;No sound
LBDF3:	.byte $7C			;D6
LBDF4:	.byte $B3			;3/4 seconds
LBDF5:	.byte $02			;No sound
LBDF6:	.byte $00			;End item room music.

PowerUpSQ1IndexData:
LBDF7:	.byte $B3			;1/2 seconds
LBDF8:	.byte $48			;C4
LBDF9:	.byte $42			;A4
LBDFA:	.byte $B2			;1/4 seconds
LBDFB:	.byte $3E			;G3
LBDFC:	.byte $38			;E3
LBDFD:	.byte $30			;C3
LBDFE:	.byte $38			;E3
LBDFF:	.byte $4C			;D4
LBE00:	.byte $44			;A#4
LBE01:	.byte $3E			;G3
LBE02:	.byte $36			;D#3
LBE03:	.byte $C8			;
LBE04:	.byte $B0			;1/16 seconds	+
LBE05:	.byte $38			;E3		| Repeat 8 times
LBE06:	.byte $3C			;F#3		+
LBE07:	.byte $FF

PowerUpTriangleIndexData:
LBE08:	.byte $B4			;1 second
LBE09:	.byte $2C			;A#3
LBE0A:	.byte $2A			;A3
LBE0B:	.byte $1E			;D#2
LBE0C:	.byte $1C			;D2

PowerUpSQ2IndexData:
LBE0D:	.byte $B2			;1/4 seconds
LBE0E:	.byte $22			;F2
LBE0F:	.byte $2C			;A#3
LBE10:	.byte $30			;C3
LBE11:	.byte $34			;D3
LBE12:	.byte $38			;E3
LBE13:	.byte $30			;C3
LBE14:	.byte $26			;G2
LBE15:	.byte $30			;C3
LBE16:	.byte $3A			;F3
LBE17:	.byte $34			;D3
LBE18:	.byte $2C			;A#3
LBE19:	.byte $26			;G2
LBE1A: 	.byte $B4			;1 second
LBE1B:	.byte $2A			;A3
LBE1C:	.byte $00			;End power up music.

FadeInSQ2IndexData:
LBE1D:	.byte $C4
LBE1E:	.byte $B0			;3/32 seconds	+
LBE1F:	.byte $3E			;G3		| Repeat 4 times
LBE20:	.byte $30			;C3		+
LBE21:	.byte $FF			;
LBE22:	.byte $C4			;
LBE23:	.byte $42			;A4		+ Repeat 4 times
LBE24:	.byte $30			;C3		+
LBE25:	.byte $FF			;
LBE26:	.byte $C4			;
LBE27:	.byte $3A			;F3		+ Repeat 4 times
LBE28:	.byte $2C			;A#3		+
LBE29:	.byte $FF			;
LBE2A:	.byte $C4			;
LBE2B:	.byte $38			;E3		+ Repeat 4 times
LBE2C:	.byte $26			;G2		+
LBE2D:	.byte $FF			;
LBE2E:	.byte $C4			;
LBE2F:	.byte $34			;D3		+ Repeat 4 times
LBE30:	.byte $20			;E2		+
LBE31:	.byte $FF			;
LBE32:	.byte $E0			;
LBE33:	.byte $34			;D3		+ Repeat 32 times
LBE34:	.byte $24			;F#2		+
LBE35:	.byte $FF			;

FadeInTriangleIndexData:
LBE36:	.byte $B3			;3/4 seconds
LBE37:	.byte $36			;D#3
LBE38:	.byte $34			;D3
LBE39:	.byte $30			;C3
LBE3A:	.byte $2A			;A3
LBE3B:	.byte $B4			;1 1/2 seconds
LBE3C:	.byte $1C			;D2
LBE3D:	.byte $1C			;D2

FadeInSQ1IndexData:
LBE3E:	.byte $B3			;3/4 seconds
LBE3F:	.byte $34			;D3
LBE40:	.byte $3A			;F3
LBE41:	.byte $34			;D3
LBE42:	.byte $30			;C3
LBE43:	.byte $B4			;1 1/2 seconds
LBE44:	.byte $2A			;A3
LBE45:	.byte $2A			;A3
LBE46:	.byte $00			;End fade in music.

TourianSQ2IndexData:
LBE47:	.byte $B4			;1 1/2 seconds
LBE48:	.byte $12			;A2
LBE49:	.byte $B3			;3/4 seconds
LBE4A:	.byte $10			;Ab1
LBE4B:	.byte $18			;C2
LBE4C:	.byte $16			;B2
LBE4D:	.byte $0A			;F1
LBE4E:	.byte $B4			;1 1/2 seconds
LBE4F:	.byte $14			;A#2
LBE50:	.byte $12			;A2
LBE51:	.byte $B3			;3/4 seconds
LBE52:	.byte $10			;Ab1
LBE53:	.byte $06			;D1
LBE54:	.byte $0E			;G1
LBE55:	.byte $04			;C#1
LBE56:	.byte $B4			;1 1/2 seconds
LBE57:	.byte $0C			;F#1
LBE58:	.byte $00			;End Tourian music.

TourianSQ1IndexData:
LBE59:	.byte $E0			;
LBE5A:	.byte $B0			;3/32 seconds	+
LBE5B:	.byte $54			;F#4		|
LBE5C:	.byte $4E			;D#4		|
LBE5D:	.byte $48			;C4		| Repeat 32 times
LBE5E:	.byte $42			;A4		|
LBE5F:	.byte $48			;C4		|
LBE60:	.byte $4E			;D#4		+
LBE61:	.byte $FF			;

TourianTriangleIndexData:
LBE62:	.byte $E0			;
LBE63:	.byte $B3			;3/4 seconds	+
LBE64:	.byte $02			;No sound	|
LBE65:	.byte $B0			;3/32 seconds	|
LBE66:	.byte $3C			;F#3		|
LBE67:	.byte $40			;Ab3		|
LBE68:	.byte $44			;A#4		|
LBE69:	.byte $4A			;C#4		|
LBE6A:	.byte $4E			;D#4		|
LBE6B:	.byte $54			;F#4		|
LBE6C:	.byte $58			;Ab4		| Repeat 32 times
LBE6D:	.byte $5C			;A#5		|
LBE6E:	.byte $62			;C#5		|
LBE6F:	.byte $66			;D#5		|
LBE70:	.byte $6C			;F#5		|
LBE71:	.byte $70			;Ab5		|
LBE72:	.byte $74			;A#6		|
LBE73:	.byte $7A			;C#6		|
LBE74:	.byte $B3			;3/4 seconds	|
LBE75:	.byte $02			;No sound	+
LBE76:	.byte $FF

;The following table contains the musical notes used by the music player.  The first byte is
;the period high information(3 bits) and the second byte is the period low information(8 bits).
;The formula for figuring out the frequency is as follows: 1790000/16/(hhhllllllll + 1)

MusicNotesTbl:
LBE77:	.byte $07			;55.0Hz (A1)	Index #$00 (Not used)
LBE78:	.byte $F0			;

LBE79:	.byte $00			;No sound	Index #$02
LBE7A:	.byte $00			;

LBE7B:	.byte $06			;69.3Hz (C#2)	Index #$04
LBE7C:	.byte $4E			;

LBE7D:	.byte $05			;73.4Hz (D2)	Index #$06
LBE7E:	.byte $F3			;

LBE7F:	.byte $05			;82.4Hz (E2)	Index #$08
LBE80:	.byte $4D			;

LBE81:	.byte $05			;87.3Hz (F2)	Index #$0A
LBE82:	.byte $01			;

LBE83:	.byte $04			;92.5Hz (F#2)	Index #$0C
LBE84:	.byte $B9			;

LBE85:	.byte $04			;98.0Hz (G2)	Index #$0E
LBE86:	.byte $75			;

LBE87:	.byte $04			;103.8Hz (Ab2)	Index #$10
LBE88:	.byte $35			;

LBE89:	.byte $03			;110.0Hz (A2)	Index #$12
LBE8A:	.byte $F8			;

LBE8B:	.byte $03			;116.5Hz (A#2)	Index #$14
LBE8C:	.byte $BF			;

LBE8D:	.byte $03			;123.5Hz (B2)	Index #$16
LBE8E:	.byte $89			;

LBE8F:	.byte $03			;130.7Hz (C3)	Index #$18
LBE90:	.byte $57			;

LBE91:	.byte $03			;138.5Hz (C#3)	Index #$1A
LBE92:	.byte $27			;

LBE93:	.byte $02			;146.8Hz (D3)	Index #$1C
LBE94:	.byte $F9			;

LBE95:	.byte $02			;155.4Hz (D#3)	Index #$1E
LBE96:	.byte $CF			;

LBE97:	.byte $02			;164.8Hz (E3)	Index #$20
LBE98:	.byte $A6			;

LBE99:	.byte $02			;174.5Hz (F3)	Index #$22
LBE9A:	.byte $80			;

LBE9B:	.byte $02			;184.9Hz (F#3)	Index #$24
LBE9C:	.byte $5C			;

LBE9D:	.byte $02			;196.0Hz (G3)	Index #$26
LBE9E:	.byte $3A			;	
	
LBE9F:	.byte $02			;207.6Hz (Ab3)	Index #$28
LBEA0:	.byte $1A			;

LBEA1:	.byte $01			;219.8Hz (A3)	Index #$2A
LBEA2:	.byte $FC			;

LBEA3:	.byte $01			;233.1Hz (A#3)	Index #$2C
LBEA4:	.byte $DF			;

LBEA5:	.byte $01			;247.0Hz (B3)	Index #$2E
LBEA6:	.byte $C4			;

LBEA7:	.byte $01			;261.4Hz (C4)	Index #$30
LBEA8:	.byte $AB			;

LBEA9:	.byte $01			;276.9Hz (C#4)	Index #$32
LBEAA:	.byte $93			;

LBEAB:	.byte $01			;293.6Hz (D4)	Index #$34
LBEAC:	.byte $7C			;

LBEAD:	.byte $01			;310.8Hz (D#4)	Index #$36
LBEAE:	.byte $67			;

LBEAF:	.byte $01			;330.0Hz (E4)	Index #$38
LBEB0:	.byte $52			;

LBEB1:	.byte $01			;349.6Hz (F4)	Index #$3A
LBEB2:	.byte $3F			;

LBEB3:	.byte $01			;370.4Hz (F#4)	Index #$3C
LBEB4:	.byte $2D			;

LBEB5:	.byte $01			;392.5Hz (G4)	Index #$3E
LBEB6:	.byte $1C			;

LBEB7:	.byte $01			;415.9Hz (Ab4)	Index #$40
LBEB8:	.byte $0C			;

LBEB9:	.byte $00			;440.4Hz (A4)	Index #$42
LBEBA:	.byte $FD			;

LBEBB:	.byte $00			;468.1Hz (A#4)	Index #$44
LBEBC:	.byte $EE			;

LBEBD:	.byte $00			;495.0Hz (B4)	Index #$46
LBEBE:	.byte $E1			;

LBEBF:	.byte $00			;525.2Hz (C5)	Index #$48
LBEC0:	.byte $D4			;

LBEC1:	.byte $00			;556.6Hz (C#5)	Index #$4A
LBEC2:	.byte $C8			;

LBEC3:	.byte $00			;588.8Hz (D5)	Index #$4C
LBEC4:	.byte $BD			;

LBEC5:	.byte $00			;625.0Hz (D#5)	Index #$4E
LBEC6:	.byte $B2			;

LBEC7:	.byte $00			;662.0Hz (E5)	Index #$50
LBEC8:	.byte $A8			;

LBEC9:	.byte $00			;699.2Hz (F5)	Index #$52
LBECA:	.byte $9F			;

LBECB:	.byte $00			;740.9Hz (F#5)	Index #$54
LBECC:	.byte $96			;

LBECD:	.byte $00			;787.9Hz (G5)	Index #$56
LBECE:	.byte $8D			;

LBECF:	.byte $00			;834.9Hz (Ab5)	Index #$58
LBED0:	.byte $85			;

LBED1:	.byte $00			;880.9HZ (A5)	Index #$5A
LBED2:	.byte $7E			;

LBED3:	.byte $00			;940.1Hz (A#5)	Index #$5C
LBED4:	.byte $76			;

LBED5:	.byte $00			;990.0Hz (B5)	Index #$5E
LBED6:	.byte $70			;

LBED7:	.byte $00			;1055Hz (C6)	Index #$60
LBED8:	.byte $69			;

LBED9:	.byte $00			;1118Hz (C#6)	Index #$62
LBEDA:	.byte $63			;

LBEDB: 	.byte $00			;1178Hz (D6)	Index #$64
LBEDC:	.byte $5E			;

LBEDD:	.byte $00			;1257Hz (D#6)	Index #$66
LBEDE:	.byte $58			;

LBEDF:	.byte $00			;1332Hz (E6)	Index #$68
LBEE0:	.byte $53			;

LBEE1:	.byte $00			;1398Hz (F6)	Index #$6A
LBEE2:	.byte $4F			;

LBEE3:	.byte $00			;1492Hz (F#6)	Index #$6C
LBEE4:	.byte $4A			;

LBEE5:	.byte $00			;1576Hz (G6)	Index #$6E
LBEE6:	.byte $46			;

LBEE7:	.byte $00			;1670Hz (Ab6)	Index #$70
LBEE8:	.byte $42			;

LBEE9:	.byte $00			;1776Hz (A6)	Index #$72
LBEEA:	.byte $3E			;

LBEEB:	.byte $00			;1896Hz (A#6)	Index #$74
LBEEC:	.byte $3A			;

LBEED:	.byte $00			;1998Hz (B6)	Index #$76
LBEEE:	.byte $37			;

LBEEF:	.byte $00			;2111Hz (C7)	Index #$78
LBEF0:	.byte $34			;

LBEF1:	.byte $00			;2238Hz (C#7)	Index #$7A
LBEF2:	.byte $31			;

LBEF3:	.byte $00			;2380Hz (D7)	Index #$7C
LBEF4:	.byte $2E			;

LBEF5:	.byte $00			;2796Hz (F7)	Index #$7E
LBEF6:	.byte $27			;

;The following tables are used to load the music frame count addresses ($0640 thru $0643). The
;larger the number, the longer the music will play a solid note.  The number represents how
;many frames the note will play.  There is a small discrepancy in time length because the
;Nintendo runs at 60 frames pers second and I am using 64 frames per second to make the
;numbers below divide more evenly.

;Used by power up music and Kraid area music.

NoteLengths0Tbl:
LBEF7:	.byte $04			;About    1/16 seconds ($B0)
LBEF8:	.byte $08			;About    1/8  seconds ($B1)
LBEF9:	.byte $10			;About    1/4  seconds ($B2)
LBEFA:	.byte $20			;About    1/2  seconds ($B3)
LBEFB:	.byte $40			;About 1       seconds ($B4)
LBEFC:	.byte $18			;About    3/8  seconds ($B5)
LBEFD:	.byte $30			;About    3/4  seconds ($B6)
LBEFE:	.byte $0C			;About    3/16 seconds ($B7)
LBEFF:	.byte $0B			;About   11/64 seconds ($B8)
LBF00:	.byte $05			;About    5/64 seconds ($B9)
LBF01:	.byte $02			;About    1/32 seconds ($BA)

;Used by item room, fade in, Brinstar music, Ridley area music, Mother brain music,
;escape music, Norfair music and Tourian music.

NoteLengths1Tbl:
LBF02:	.byte $06			;About    3/32 seconds ($B0)
LBF03:	.byte $0C			;About    3/16 seconds ($B1)
LBF04:	.byte $18			;About    3/8  seconds ($B2)
LBF05:	.byte $30			;About    3/4  seconds ($B3)
LBF06:	.byte $60			;About 1  1/2  seconds ($B4)
LBF07:	.byte $24			;About    9/16 seconds ($B5)
LBF08:	.byte $48			;About 1  3/16 seconds ($B6)
LBF09:	.byte $12			;About    9/32 seconds ($B7)
LBF0A:	.byte $10			;About    1/4  seconds ($B8)
LBF0B:	.byte $08			;About    1/8  seconds ($B9)
LBF0C:	.byte $03			;About    3/64 seconds ($BA)

;Used by intro and end game music.

NoteLengths2Tbl:
LBF0D:	.byte $10			;About    1/4  seconds ($B0)
LBF0E:	.byte $07			;About    7/64 seconds ($B1)
LBF0F:	.byte $0E			;About    7/32 seconds ($B2)
LBF10:	.byte $1C			;About    7/16 seconds ($B3)
LBF11:	.byte $38			;About    7/8  seconds ($B4)
LBF12:	.byte $70			;About 1 13/16 seconds ($B5)
LBF13:	.byte $2A			;About   21/32 seconds ($B6)
LBF14:	.byte $54			;About 1  5/16 seconds ($B7)
LBF15:	.byte $15			;About   21/64 seconds ($B8)
LBF16:	.byte $12			;About    9/32 seconds ($B9)
LBF17:	.byte $02			;About    1/32 seconds ($BA)
LBF18:	.byte $03			;About    3/64 seconds ($BB)

InitializeMusic:					
LBF19:	JSR CheckMusicFlags		;($B3FC)Check to see if restarting current music.
LBF1C:	LDA CurrentSFXFlags		;Load current SFX flags and store CurrentMusic address.
LBF1F:	STA CurrentMusic		;
LBF22:	LDA MusicInitIndex		;
LBF25:	TAY				;
LBF26:	LDA InitMusicIndexTbl,Y		;($BBFA)Find index for music in InitMusicInitIndexTbl.
LBF29:	TAY				;
LBF2A:	LDX #$00			;

LBF2C:*	LDA InitMusicTbl,Y		;Base is $BD31.
LBF2F:	STA NoteLengthTblOffset,X	;
LBF32:	INY 				;The following loop repeats 13 times to-->
LBF33:	INX 				;load the initial music addresses -->
LBF34:	TXA 				;(registers $062B thru $0637).
LBF35:	CMP #$0D			;
LBF37:	BNE -				;

LBF39:	LDA #$01			;Resets addresses $0640 thru $0643 to #$01.-->
LBF3B:	STA SQ1MusicFrameCount		;These addresses are used for counting the-->
LBF3E:	STA SQ2MusicFrameCount		;number of frames music channels have been playing.
LBF41:	STA TriangleMusicFrameCount	;
LBF44:	STA NoiseMusicFrameCount	;
LBF47:	LDA #$00			;
LBF49:	STA SQ1MusicIndexIndex		;
LBF4C:	STA SQ2MusicIndexIndex		;Resets addresses $0638 thru $063B to #$00.-->
LBF4F:	STA TriangleMusicIndexIndex	;These are the index to find sound channel data index.
LBF52:	STA NoiseMusicIndexIndex	;
LBF55:	RTS				;

;Not used.
LBF56:	.byte $10, $07, $0E, $1C, $38, $70, $2A, $54, $15, $12, $02, $03, $20, $2C, $B4, $AD
LBF66:	.byte $4D, $06, $8D, $8D, $06, $AD, $5E, $06, $A8, $B9, $2A, $BC, $A8, $A2, $00, $B9
LBF76:	.byte $61, $BD, $9D, $2B, $06, $C8, $E8, $8A, $C9, $0D, $D0, $F3, $A9, $01, $8D, $40
LBF86:	.byte $06, $8D, $41, $06, $8D, $42, $06, $8D, $43, $06, $A9, $00, $8D, $38, $06, $8D
LBF96:	.byte $39, $06, $8D, $3A, $06, $8D, $3B, $06, $60, $FF, $00, $00, $00, $00, $00, $00
LBFA6:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------[ RESET ]--------------------------------------------

RESET:
LBFB0:	SEI				;Disables interrupt.
LBFB1:	CLD				;Sets processor to binary mode.
LBFB2:	LDX #$00			;
LBFB4:	STX PPUControl0			;Clear PPU control registers.
LBFB7:	STX PPUControl1			;
LBFBA:*	LDA PPUStatus			;
LBFBD:	BPL -				;Wait for VBlank.
LBFBF:*	LDA PPUStatus			;
LBFC2:	BPL -				;
LBFC4:	ORA #$FF			;
LBFC6:	STA MMC1Reg0			;Reset MMC1 chip.-->
LBFC9:	STA MMC1Reg1			;(MSB is set).
LBFCC:	STA MMC1Reg2			;
LBFCF:	STA MMC1Reg3			;
LBFD2:	JMP Startup			;($C01A)Does preliminry housekeeping.

;Not used.
LBFD5: 	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00
LBFE5: 	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LBFF5:	.byte $00, $00, $00, $00, $00

;----------------------------------------[ Interrupt vectors ]--------------------------------------

LBFFA: 	.word NMI			;($C0D9)NMI vector.
LBFFC:	.word RESET			;($FFB0)Reset vector.
LBFFE: 	.word RESET			;($FFB0)IRQ vector.