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
;;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Disassembled using TRaCER.
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Kraid hideout (memory page 4)

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

;Samus end tile patterns.
L8D60:	.byte $00, $00, $00, $00, $01, $01, $03, $03, $00, $00, $00, $00, $00, $00, $00, $00
L8D70:	.byte $00, $00, $3C, $FF, $FF, $BD, $5A, $24, $00, $00, $00, $20, $00, $42, $E7, $FF
L8D80:	.byte $00, $00, $00, $00, $00, $01, $01, $03, $00, $00, $00, $00, $00, $00, $0C, $1C
L8D90:	.byte $00, $00, $00, $3C, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $40, $80, $00
L8DA0:	.byte $00, $00, $00, $00, $00, $80, $A0, $F0, $00, $00, $00, $00, $00, $00, $20, $30
L8DB0:	.byte $1D, $39, $38, $70, $F0, $F0, $F0, $E0, $1D, $39, $18, $60, $F0, $F0, $F0, $E0
L8DC0:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L8DD0:	.byte $80, $80, $00, $00, $00, $00, $00, $00, $80, $80, $00, $00, $00, $00, $00, $00
L8DE0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8DF0:	.byte $E7, $E7, $C3, $C3, $42, $C3, $E7, $E7, $E7, $E7, $C3, $00, $42, $C3, $E7, $E7
L8E00:	.byte $0E, $0D, $07, $0E, $1C, $19, $1B, $1A, $0E, $0D, $07, $0E, $1C, $18, $18, $18
L8E10:	.byte $7C, $6D, $39, $10, $38, $FF, $FF, $7C, $00, $11, $01, $00, $00, $00, $00, $82
L8E20:	.byte $88, $0C, $8C, $DC, $5C, $0C, $88, $98, $80, $00, $80, $C0, $40, $00, $00, $00
L8E30:	.byte $00, $00, $01, $03, $03, $07, $07, $0E, $00, $00, $01, $03, $03, $07, $07, $0E
L8E40:	.byte $1C, $7E, $FF, $E7, $99, $3D, $7C, $56, $1C, $7E, $FF, $E7, $81, $01, $00, $00
L8E50:	.byte $00, $00, $00, $00, $80, $80, $80, $80, $00, $00, $00, $00, $80, $80, $80, $80
L8E60:	.byte $03, $03, $03, $0F, $1F, $1F, $1F, $07, $00, $00, $00, $0F, $1F, $1F, $1F, $0E
L8E70:	.byte $00, $81, $C3, $66, $A5, $DB, $FF, $FF, $7E, $3C, $18, $00, $C3, $A7, $44, $88
L8E80:	.byte $03, $03, $02, $0F, $1F, $1F, $1F, $07, $1C, $0C, $00, $0F, $1F, $1F, $1F, $0F
L8E90:	.byte $FF, $00, $FF, $FF, $FF, $FF, $FF, $FF, $00, $3C, $FF, $FF, $FF, $FF, $FF, $FF
L8EA0:	.byte $D8, $D8, $78, $F0, $F0, $E0, $C0, $80, $18, $18, $38, $F0, $F0, $E0, $C0, $80
L8EB0:	.byte $70, $F9, $F9, $D1, $71, $01, $00, $00, $40, $01, $01, $01, $01, $01, $00, $00
L8EC0:	.byte $FF, $FF, $E7, $E7, $E7, $E7, $E7, $E7, $FF, $FF, $E7, $E7, $E7, $E7, $E7, $E7
L8ED0:	.byte $00, $80, $80, $80, $80, $80, $00, $00, $00, $80, $80, $80, $80, $80, $00, $00
L8EE0:	.byte $01, $01, $01, $03, $03, $01, $01, $00, $01, $01, $00, $00, $00, $02, $00, $00
L8EF0:	.byte $E7, $E7, $E7, $E7, $E7, $C3, $C3, $00, $E7, $E7, $E7, $C3, $C3, $24, $00, $00
L8F00:	.byte $0A, $0A, $02, $06, $06, $06, $0C, $0C, $09, $09, $00, $00, $00, $00, $00, $00
L8F10:	.byte $38, $00, $10, $38, $7C, $7C, $38, $81, $C7, $EF, $C6, $00, $00, $00, $C6, $3C
L8F20:	.byte $D8, $F8, $70, $30, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8F30:	.byte $0E, $0D, $07, $0E, $1C, $18, $18, $18, $0E, $0D, $07, $0E, $1C, $19, $1B, $1A
L8F40:	.byte $7C, $6D, $39, $10, $38, $7C, $7C, $38, $00, $11, $01, $00, $82, $83, $83, $C6
L8F50:	.byte $88, $0C, $8C, $DC, $5C, $0C, $00, $00, $80, $00, $80, $C0, $40, $00, $80, $98
L8F60:	.byte $0D, $1D, $1C, $39, $78, $08, $00, $10, $0C, $1C, $05, $31, $78, $78, $B8, $B8
L8F70:	.byte $FF, $FF, $E7, $66, $99, $FF, $FF, $FF, $10, $00, $18, $99, $FF, $FF, $FF, $FF
L8F80:	.byte $B0, $B8, $38, $9C, $1E, $1E, $1E, $3F, $30, $38, $B0, $8C, $1E, $1E, $1C, $00
L8F90:	.byte $00, $00, $00, $18, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FA0:	.byte $00, $00, $00, $00, $00, $00, $04, $00, $00, $40, $00, $00, $00, $00, $00, $00
L8FB0:	.byte $00, $00, $00, $00, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L8FC0:	.byte $00, $00, $04, $00, $00, $00, $00, $00, $00, $00, $00, $00, $40, $00, $00, $00
L8FD0:	.byte $00, $00, $00, $00, $81, $DB, $FF, $FF, $00, $00, $00, $00, $C3, $A7, $44, $88
L8FE0:	.byte $00, $00, $00, $F0, $F8, $F8, $F8, $E0, $00, $00, $00, $F0, $F8, $F8, $F8, $70
L8FF0:	.byte $80, $00, $80, $C0, $40, $00, $00, $00, $80, $00, $80, $C0, $40, $00, $80, $80
L9000:	.byte $80, $00, $80, $C0, $40, $00, $01, $00, $80, $00, $80, $C0, $40, $00, $80, $C2
L9010:	.byte $00, $00, $00, $00, $40, $F8, $F8, $70, $00, $00, $00, $00, $00, $00, $00, $00
L9020:	.byte $80, $00, $80, $C0, $40, $00, $80, $80, $80, $00, $80, $C0, $40, $00, $00, $00
L9030:	.byte $08, $08, $00, $00, $00, $00, $00, $00, $0B, $0B, $02, $06, $06, $06, $0C, $0C
L9040:	.byte $10, $00, $00, $00, $00, $00, $00, $81, $EF, $EF, $D6, $38, $7C, $7C, $FE, $3C
L9050:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $D8, $78, $70, $30, $00, $00, $00, $00
L9060:	.byte $10, $00, $01, $01, $01, $01, $01, $01, $B8, $B8, $B9, $89, $89, $71, $01, $01
L9070:	.byte $FF, $FF, $E7, $E7, $C3, $C3, $C3, $C3, $FF, $FF, $E7, $E7, $C3, $C3, $C3, $C3
L9080:	.byte $1E, $0F, $9F, $9F, $96, $86, $8C, $80, $00, $00, $80, $80, $80, $80, $80, $80
L9090:	.byte $C0, $80, $00, $80, $00, $00, $00, $00, $40, $00, $80, $80, $00, $00, $00, $00
L90A0:	.byte $0E, $1F, $1F, $1B, $9F, $8F, $C7, $CE, $00, $00, $00, $00, $00, $00, $00, $02
L90B0:	.byte $00, $00, $00, $0F, $1F, $1F, $1F, $07, $00, $00, $00, $0F, $1F, $1F, $1F, $0E
L90C0:	.byte $00, $00, $01, $03, $03, $07, $07, $0F, $00, $00, $01, $03, $03, $07, $07, $0F
L90D0:	.byte $1C, $7E, $FF, $FF, $FF, $FF, $FF, $FF, $1C, $7E, $FF, $FF, $E7, $C3, $83, $A9
L90E0:	.byte $00, $00, $00, $00, $80, $80, $C0, $C0, $00, $00, $00, $00, $80, $80, $C0, $C0
L90F0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $80, $80, $C0, $C0, $C0, $C0, $60, $70
L9100:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $E7, $7E, $18, $00, $00, $00, $00, $00
L9110:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $78, $38, $38, $30, $78, $78, $F8, $C0
L9120:	.byte $80, $80, $80, $C0, $C0, $60, $60, $30, $00, $00, $00, $00, $00, $00, $00, $00
L9130:	.byte $09, $0D, $0D, $09, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9140:	.byte $C3, $C3, $E7, $E7, $E7, $E7, $E7, $63, $18, $18, $00, $00, $00, $00, $00, $00
L9150:	.byte $00, $80, $80, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9160:	.byte $01, $01, $01, $03, $03, $03, $07, $07, $01, $00, $01, $03, $03, $03, $07, $07
L9170:	.byte $81, $81, $81, $00, $81, $81, $81, $81, $81, $81, $00, $00, $81, $81, $81, $81
L9180:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9190:	.byte $00, $00, $80, $80, $80, $80, $80, $80, $00, $00, $80, $80, $80, $80, $80, $80
L91A0:	.byte $CF, $C7, $F7, $EF, $EF, $FF, $FE, $DE, $07, $07, $77, $EF, $EF, $FF, $FA, $5C
L91B0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $03
L91C0:	.byte $0F, $0F, $00, $00, $00, $00, $00, $00, $0F, $0F, $00, $00, $00, $00, $00, $00
L91D0:	.byte $FF, $EF, $FF, $7C, $38, $00, $00, $00, $83, $93, $C7, $6C, $00, $00, $00, $00
L91E0:	.byte $C0, $C0, $00, $00, $00, $00, $00, $00, $C0, $C0, $00, $00, $00, $00, $00, $00
L91F0:	.byte $81, $81, $00, $81, $00, $81, $00, $00, $00, $00, $00, $00, $81, $00, $00, $00
L9200:	.byte $80, $00, $80, $C0, $40, $00, $81, $C3, $80, $00, $80, $C0, $40, $00, $00, $00
L9210:	.byte $00, $00, $00, $00, $40, $F8, $F8, $70, $00, $00, $00, $00, $00, $00, $00, $00
L9220:	.byte $10, $B0, $B0, $90, $90, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9230:	.byte $E7, $7E, $18, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9240:	.byte $63, $31, $31, $39, $39, $39, $18, $00, $00, $00, $00, $00, $00, $00, $00, $60
L9250:	.byte $00, $80, $80, $C0, $C0, $C0, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $30
L9260:	.byte $07, $07, $0F, $08, $07, $0F, $07, $00, $03, $00, $00, $07, $08, $00, $00, $00
L9270:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $F0, $F0, $70, $78, $38, $78, $7C, $1E

;Unused tile patterns.
L9280:	.byte $F2, $64, $0F, $DA, $8D, $5B, $10, $10, $FB, $70, $01, $C0, $8D, $58, $10, $10
L9290:	.byte $90, $40, $20, $80, $B0, $70, $5C, $60, $EF, $3E, $18, $80, $00, $10, $5C, $60
L92A0:	.byte $B8, $38, $30, $80, $80, $60, $20, $18, $A0, $A4, $66, $C6, $3E, $0C, $20, $18
L92B0:	.byte $30, $27, $2D, $38, $2A, $5E, $70, $40, $10, $00, $01, $00, $12, $20, $00, $00
L92C0:	.byte $0A, $40, $40, $51, $78, $C4, $C2, $90, $31, $3D, $3B, $2C, $06, $3B, $3D, $6F
L92D0:	.byte $00, $08, $10, $80, $42, $00, $2E, $5A, $F9, $B1, $40, $60, $3E, $0E, $82, $92
L92E0:	.byte $00, $00, $00, $00, $00, $0C, $0E, $0C, $00, $00, $00, $0C, $1E, $13, $15, $16
L92F0:	.byte $00, $01, $01, $00, $00, $08, $04, $12, $00, $00, $00, $06, $0F, $07, $03, $09
L9300:	.byte $5D, $23, $54, $2B, $24, $1E, $0F, $04, $5D, $23, $55, $2B, $20, $1C, $0F, $04
L9310:	.byte $01, $A7, $06, $0B, $4A, $D6, $2C, $F0, $59, $F1, $52, $FB, $6A, $D6, $2C, $F0
L9320:	.byte $EC, $F5, $7C, $99, $42, $60, $38, $0F, $CE, $D5, $70, $9D, $47, $68, $38, $0F
L9330:	.byte $AF, $73, $36, $26, $0C, $1C, $78, $C0, $AF, $73, $76, $A6, $4C, $1C, $78, $C0
L9340:	.byte $69, $2C, $0E, $77, $D4, $B4, $E2, $00, $03, $01, $00, $70, $F0, $F0, $E0, $00
L9350:	.byte $69, $2C, $0E, $37, $14, $04, $02, $00, $03, $01, $00, $30, $10, $00, $00, $00

;Misc. tile patterns.
L9360:	.byte $FF, $FF, $C0, $C0, $CF, $CB, $CC, $CC, $00, $00, $1F, $3F, $3F, $38, $3B, $3B
L9370:	.byte $FC, $FC, $0C, $0C, $CC, $4C, $CC, $CC, $00, $04, $EC, $FC, $FC, $3C, $BC, $BC
L9380:	.byte $CB, $CF, $C0, $C0, $FF, $FF, $00, $00, $3B, $30, $3F, $1F, $7F, $FF, $00, $00
L9390:	.byte $4C, $CC, $0C, $0C, $FC, $FC, $00, $00, $3C, $3C, $FC, $EC, $FC, $FC, $00, $00
L93A0:	.byte $FE, $02, $02, $02, $FE, $00, $00, $7F, $00, $FE, $0E, $FE, $FE, $00, $00, $00
L93B0:	.byte $7F, $40, $40, $40, $7F, $00, $00, $FE, $00, $3F, $30, $3F, $7F, $00, $00, $00
L93C0:	.byte $40, $40, $40, $7F, $00, $00, $00, $FF, $3F, $30, $3F, $7F, $00, $00, $FF, $FF
L93D0:	.byte $02, $02, $02, $FE, $00, $00, $00, $FF, $FE, $0E, $FE, $FE, $00, $00, $FF, $FF
L93E0:	.byte $FF, $FF, $C0, $D0, $C0, $C0, $C0, $C0, $00, $00, $3F, $27, $3F, $3F, $3F, $3F
L93F0:	.byte $FC, $FC, $0C, $4C, $0C, $0C, $0C, $0C, $00, $04, $FC, $9C, $FC, $FC, $FC, $FC
L9400:	.byte $C0, $C0, $D0, $C0, $FF, $FF, $00, $00, $3F, $3F, $27, $3F, $3F, $7F, $00, $00
L9410:	.byte $0C, $0C, $4C, $0C, $FC, $FC, $00, $00, $FC, $FC, $9C, $FC, $FC, $FC, $00, $00
L9420:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $20, $48, $30, $5A, $FC, $76, $BE, $2C
L9430:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $7E, $75, $1C, $AA, $54, $30, $44, $10
L9440:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $04, $12, $0C, $5A, $3F, $6E, $7D, $34
L9450:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $7E, $AE, $38, $55, $2A, $0C, $22, $08
L9460:	.byte $45, $D7, $FF, $FF, $FD, $FF, $BF, $FB, $00, $00, $00, $00, $02, $00, $40, $04
L9470:	.byte $FF, $BB, $FF, $FF, $EF, $FF, $7F, $FD, $00, $44, $00, $00, $10, $00, $80, $02
L9480:	.byte $7E, $42, $C2, $1E, $02, $06, $7C, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9490:	.byte $00, $00, $00, $00, $04, $12, $08, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94A0:	.byte $44, $FE, $44, $44, $04, $0C, $78, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94B0:	.byte $06, $0C, $38, $F0, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94C0:	.byte $FE, $C0, $C0, $FC, $C0, $C0, $FE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94D0:	.byte $FC, $C6, $C6, $CE, $F8, $DC, $CE, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94E0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L94F0:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9500:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9510:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9520:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9530:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L9540:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L9550:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;----------------------------------------------------------------------------------------------------

L9560:	.word Palette00			;($A155)
L9562:	.word Palette01			;($A179)
L9564:	.word Palette02			;($A185)
L9566:	.word Palette03			;($A17F)
L9668:	.word Palette04			;($A18B)
L966A:	.word Palette05			;($A191)
L956C:	.word Palette05			;($A191)
L956E:	.word Palette05			;($A191)
L9570:	.word Palette05			;($A191)
L9572:	.word Palette05			;($A191)
L9574:	.word Palette05			;($A191)
L9576:	.word Palette05			;($A191)
L9578:	.word Palette05			;($A191)
L957A:	.word Palette05			;($A191)
L957C:	.word Palette05			;($A191)
L957E:	.word Palette05			;($A191)
L9580:	.word Palette05			;($A191)
L9582:	.word Palette05			;($A191)
L9584:	.word Palette05			;($A191)
L9586:	.word Palette05			;($A191)
L9588:	.word Palette06			;($A198)
L958A:	.word Palette07			;($A19F)
L958C:	.word Palette08			;($A1A6)
L958E:	.word Palette09			;($A1AD)
L9590:	.word Palette0A			;($A1B5)
L9592:	.word Palette0B			;($A1BD)
L9594:	.word Palette0C			;($A1C5)
L9596:	.word Palette0D			;($A1CD)

AreaPointers:
L9598:	.word SpecItmsTbl		;($A26D)Beginning of special items table.
L959A:	.word RmPtrTbl			;($A1D5)Beginning of room pointer table.
L959C:	.word StrctPtrTbl		;($A21F)Beginning of structure pointer table.
L959E:	.word MacroDefs			;($AC32)Beginning of macro definitions.
L95A0:	.word EnemyFramePtrTbl1		;($9CF7)Address table into enemy animation data. Two-->
L95A2:	.word EnemyFramePtrTbl2		;($9DF7)tables needed to accommodate all entries.
L95A4:	.word EnemyPlacePtrTbl		;($9E25)Pointers to enemy frame placement data.
L95A6:	.word EnemyAnimIndexTbl		;($9C86)Index to values in addr tables for enemy animations.

L95A8:	.byte $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60
L95B8:	.byte $EA, $EA, $60, $EA, $EA, $60, $EA, $EA, $60, $EA, $EA

L95C3:	JMP $9C49			;Area specific routine.

TwosCompliment_:
L95C6:	EOR #$FF			;
L95C8:	CLC				;The following routine returns the twos-->
L95C9:	ADC #$01			;compliment of the value stored in A.
L95CB:	RTS				;

L95CC:	.byte $1D			;Kraid's room.

L95CD:	.byte $10			;Kraid's hideout music init flag.

L95CE:	.byte $00			;Base damage caused by area enemies to lower health byte.
L95CF:	.byte $02			;Base damage caused by area enemies to upper health byte.

;Special room numbers(used to start item room music).
L95D0:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF

L95D7:	.byte $07			;Samus start x coord on world map.
L95D8:	.byte $14			;Samus start y coord on world map.
L95D9:	.byte $6E			;Samus start verticle screen position.

L95DA:	.byte $06, $00, $03, $43, $00, $00, $00, $00, $00, $00, $64

L95E5:	LDA $6B02,X
L95E8:	JSR $8024

L95EB:	.word $991C
L95ED:	.word $9937
L95EF:	.word $95CB
L95F1:	.word $993C
L95F3:	.word $9949
L95F5:	.word $999B
L95F7:	.word $95CB
L95F9:	.word $9A44
L95FB:	.word $9AB4
L95FD:	.word $9AE4
L95FF:	.word $9B2C
L9601:	.word $95CB
L9603:	.word $95CB
L9605:	.word $95CB
L9607:	.word $95CB
L9609:	.word $95CB

L960B:	.byte $27, $27, $29, $29, $2D, $2B, $31, $2F, $33, $33, $41, $41, $48, $48, $50, $4E

L961B:	.byte $6D, $6F, $00, $00, $00, $00, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L962B:	.byte $08, $08, $00, $FF, $02, $02, $00, $01, $60, $FF, $FF, $00, $00, $00, $00, $00

L963B:	.byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $54, $52

L964B:	.byte $67, $6A, $56, $58, $5D, $62, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L965B:	.byte $05, $05, $0B, $0B, $17, $13, $1B, $19, $23, $23, $35, $35, $48, $48, $4B, $48

L966B:	.byte $67, $6A, $56, $58, $5A, $5F, $64, $64, $64, $64, $00, $00, $00, $00, $00, $00

L967B:	.byte $00, $00, $00, $80, $00, $00, $00, $00, $00, $00, $00, $00, $80, $00, $00, $00

L968B:	.byte $89, $89, $09, $00, $86, $04, $89, $80, $83, $00, $00, $00, $82, $00, $00, $00

L969B:	.byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $40, $00, $00, $00

L96AB:	.byte $00, $00, $06, $00, $83, $00, $84, $00, $00, $00, $00, $00, $00, $00, $00, $00

L96BB:	.byte $08, $08, $01, $01, $01, $01, $10, $08, $10, $00, $00, $01, $01, $00, $00, $00

L96CB:	.byte $00, $03, $00, $06, $08, $0C, $00, $0A, $0E, $11, $13, $00, $00, $00, $00, $00


L96DB:	.word $97E9, $97EC, $97EF, $97EF, $97EF, $97EF, $97EF, $97EF
L96EB:	.word $97EF, $97EF, $97EF, $97EF, $97EF, $97F2, $97F5, $9809
L96FB:	.word $981D, $981D, $981D, $981D, $981D, $981D, $981D, $981D
L970B:	.word $981D, $9824, $982B, $9832, $9839, $983C, $983F, $9856
L971B:	.word $986D, $9884, $989B, $98B2

L9723:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $7F, $70, $70, $90, $90, $00, $00, $7F
L9733:	.byte $80, $00, $54, $70, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9743:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L9753:	.byte $F6, $F6, $FC, $0A, $04, $00, $00, $00, $0C, $FC, $FC, $00, $00, $00, $00, $00
L9763:	.byte $00, $00, $00, $00, $00, $02, $02, $02, $02, $00, $00, $00, $02, $00, $02, $02
L9773:	.byte $00, $00, $00, $00, $00, $00, $00, $00

L977B:	.byte $64, $6C, $21, $01, $04, $00, $4C, $40, $04, $00, $00, $40, $40, $00, $00, $00

L978B:	.byte $00, $00, $5F, $62, $64, $64, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L979B:	.byte $0C, $F4, $00, $00, $00, $00, $00, $00, $F4, $00, $00, $00

L97A7:	.word $98C9, $98D8, $98E7, $98F6, $9C4A, $9C4F, $9C54, $9C59
L97B7:	.word $9C5E, $9C63, $9C68, $9C6D, $9C72, $9C77, $9C7C, $9C81
L97C7:	.word $9C86, $9C86, $9C86, $9C86, $9C86

L97D1:	.byte $01, $01, $02, $01, $03, $04, $00, $06, $00, $07, $00, $09, $00, $00, $01, $0C
L97E1:	.byte $0D, $00, $0E, $03, $0F, $10, $11, $0F

L97E9:	.byte $20, $22, $FE

L97EC:	.byte $20, $2A, $FE

L97EF:	.byte $01, $01, $FF

L97F2:	.byte $01, $09, $FF

L97F5:	.byte $04, $22, $01, $42, $01, $22, $01, $42, $01, $62, $01, $42, $04, $62, $FC, $01
L9805:	.byte $00, $64, $00, $FB

L9809:	.byte $04, $2A, $01, $4A, $01, $2A, $01, $4A, $01, $6A, $01, $4A, $04, $6A, $FC, $01
L9819:	.byte $00, $64, $00, $FB

L981D:	.byte $14, $11, $0A, $00, $14, $19, $FE

L9824:	.byte $14, $19, $0A, $00, $14, $11, $FE

L982B:	.byte $32, $11, $0A, $00, $32, $19, $FE

L9832:	.byte $32, $19, $0A, $00, $32, $11, $FE

L9839:	.byte $50, $04, $FF

L983C:	.byte $50, $0C, $FF

L983F:	.byte $02, $F3, $04, $E3, $04, $D3, $05, $B3, $03, $93, $04, $03, $05, $13, $03, $33
L984F:	.byte $05, $53, $04, $63, $50, $73, $FF

L9856:	.byte $02, $FB, $04, $EB, $04, $DB, $05, $BB, $03, $9B, $04, $0B, $05, $1B, $03, $3B
L9866:	.byte $05, $5B, $04, $6B, $50, $7B, $FF

L986D:	.byte $02, $F4, $04, $E4, $04, $D4, $05, $B4, $03, $94, $04, $04, $05, $14, $03, $34
L987D:	.byte $05, $54, $04, $64, $50, $74, $FF

L9884:	.byte $02, $FC, $04, $EC, $04, $DC, $05, $BC, $03, $9C, $04, $0C, $05, $1C, $03, $3C
L9894:	.byte $05, $5C, $04, $6C, $50, $7C, $FF

L989B:	.byte $02, $F2, $04, $E2, $04, $D2, $05, $B2, $03, $92, $04, $02, $05, $12, $03, $32
L98AB:	.byte $05, $52, $04, $62, $50, $72, $FF

L98B2:	.byte $02, $FA, $04, $EA, $04, $DA, $05, $BA, $03, $9A, $04, $0A, $05, $1A ,$03, $3A
L98C2:	.byte $05, $5A, $04, $6A, $50, $7A, $FF

L98C9:	.byte $04, $B3, $05, $A3, $06, $93, $07, $03, $06, $13, $05, $23, $50, $33, $FF

L98D8:	.byte $09, $C2, $08, $A2, $07, $92, $07, $12, $08, $22, $09, $42, $50, $72, $FF

L98E7:	.byte $07, $C2, $06, $A2, $05, $92, $05, $12, $06, $22, $07, $42, $50, $72, $FF

L98F6:	.byte $05, $C2, $04, $A2, $03, $92, $03, $12, $04, $22, $05, $42, $50, $72, $FF

L9905:	LDA $81
L9907:	CMP #$01
L9909:	BEQ $9914
L990B:	CMP #$03
L990D:	BEQ $9919
L990F:	LDA $00
L9911:	JMP $8000
L9914:	LDA $01
L9916:	JMP $8003
L9919:	JMP $8006
L991C:	LDA #$09
L991E:	STA $85
L9920:	STA $86
L9922:	LDA $6AF4,X
L9925:	CMP #$03
L9927:	BEQ $992C
L9929:	JSR $801B
L992C:	LDA #$06
L992E:	STA $00
L9930:	LDA #$08
L9932:	STA $01
L9934:	JMP $9905
L9937:	LDA #$0F
L9939:	JMP $991E
L993C:	LDA $6AF4,X
L993F:	CMP #$03
L9941:	BEQ $9946
L9943:	JSR $801E
L9946:	JMP $992C
L9949:	LDA $81
L994B:	CMP #$01
L994D:	BEQ $9993
L994F:	CMP #$03
L9951:	BEQ $9998
L9953:	LDA $0406,X
L9956:	CMP #$0F
L9958:	BCC $998E
L995A:	CMP #$11
L995C:	BCS $9965
L995E:	LDA #$3A
L9960:	STA $6B01,X
L9963:	BNE $998E
L9965:	DEC $6B01,X
L9968:	BNE $998E
L996A:	LDA #$00
L996C:	STA $6AF4,X
L996F:	LDY #$0C
L9971:	LDA #$0A
L9973:	STA $00A0,Y
L9976:	LDA $0400,X
L9979:	STA $00A1,Y
L997C:	LDA $0401,X
L997F:	STA $00A2,Y
L9982:	LDA $6AFB,X
L9985:	STA $00A3,Y
L9988:	DEY
L9989:	DEY
L998A:	DEY
L998B:	DEY
L998C:	BPL $9971
L998E:	LDA #$02
L9990:	JMP $8000
L9993:	LDA #$08
L9995:	JMP $8003
L9998:	JMP $8006
L999B:	JSR $8009
L999E:	AND #$03
L99A0:	BEQ $99D6
L99A2:	LDA $81
L99A4:	CMP #$01
L99A6:	BEQ $9993
L99A8:	CMP #$03
L99AA:	BEQ $9998
L99AC:	LDA $6AF4,X
L99AF:	CMP #$03
L99B1:	BEQ $99D6
L99B3:	LDA $040A,X
L99B6:	AND #$03
L99B8:	CMP #$01
L99BA:	BNE $99CD
L99BC:	LDY $0400,X
L99BF:	CPY #$E4
L99C1:	BNE $99CD
L99C3:	JSR $9A0C
L99C6:	LDA #$03
L99C8:	STA $040A,X
L99CB:	BNE $99D3
L99CD:	JSR $9A31
L99D0:	JSR $99F7
L99D3:	JSR $9A15
L99D6:	LDA #$03
L99D8:	JSR $800C
L99DB:	JMP $8006
L99DE:	LDA $0405,X
L99E1:	LSR 
L99E2:	LDA $040A,X
L99E5:	AND #$03
L99E7:	ROL 
L99E8:	TAY 
L99E9:	LDA $99EF,Y
L99EC:	JMP $800F

L99EF:	.byte $35, $35, $3E, $38, $3B, $3B, $38, $3E

L99F7:	LDX $4B
L99F9:	BCS $9A14
L99FB:	LDA $00
L99FD:	BNE $9A0C
L99FF:	LDY $040A,X
L9A02:	DEY 
L9A03:	TYA 
L9A04:	AND #$03
L9A06:	STA $040A,X
L9A09:	JMP $99DE
L9A0C:	LDA $0405,X
L9A0F:	EOR #$01
L9A11:	STA $0405,X
L9A14:	RTS

L9A15:	JSR $9A29
L9A18:	JSR $9A31
L9A1B:	LDX $4B
L9A1D:	BCC $9A28
L9A1F:	JSR $9A29
L9A22:	STA $040A,X
L9A25:	JSR $99DE
L9A28:	RTS

L9A29:	LDY $040A,X
L9A2C:	INY 
L9A2D:	TYA 
L9A2E:	AND #$03
L9A30:	RTS

L9A31:	LDY $0405,X
L9A34:	STY $00
L9A36:	LSR $00
L9A38:	ROL 
L9A39:	ASL 
L9A3A:	TAY 
L9A3B:	LDA $8049,Y
L9A3E:	PHA 
L9A3F:	LDA $8048,Y
L9A42:	PHA 
L9A43:	RTS

L9A44:	LDA $6AF4,X
L9A47:	CMP #$02
L9A49:	BNE $9A83
L9A4B:	LDA $0403,X
L9A4E:	BNE $9A83
L9A50:	LDA $6AFE,X
L9A53:	BNE $9A67
L9A55:	LDA $030D
L9A58:	SEC 
L9A59:	SBC $0400,X
L9A5C:	CMP #$40
L9A5E:	BCS $9A83
L9A60:	LDA #$7F
L9A62:	STA $6AFE,X
L9A65:	BNE $9A83
L9A67:	LDA $0402,X
L9A6A:	BMI $9A83
L9A6C:	LDA #$00
L9A6E:	STA $0402,X
L9A71:	STA $0406,X
L9A74:	STA $6AFE,X
L9A77:	LDA $0405,X
L9A7A:	AND #$01
L9A7C:	TAY 
L9A7D:	LDA $9AB2,Y
L9A80:	STA $0403,X
L9A83:	LDA $0405,X
L9A86:	ASL 
L9A87:	BMI $9AA7
L9A89:	LDA $6AF4,X
L9A8C:	CMP #$02
L9A8E:	BNE $9AA7
L9A90:	JSR $8036
L9A93:	PHA 
L9A94:	JSR $8039
L9A97:	STA $05
L9A99:	PLA 
L9A9A:	STA $04
L9A9C:	JSR $9BBC
L9A9F:	JSR $8027
L9AA2:	BCC $9AAC
L9AA4:	JSR $9BAA
L9AA7:	LDA #$03
L9AA9:	JMP $8003
L9AAC:	LDA #$00
L9AAE:	STA $6AF4,X
L9AB1:	RTS

L9AB2:	PHP 
L9AB3:	SED 
L9AB4:	LDA $6AF4,X
L9AB7:	CMP #$03
L9AB9:	BCC $9AD4
L9ABB:	BEQ $9AC1
L9ABD:	CMP #$05
L9ABF:	BNE $9ADD
L9AC1:	LDA #$00
L9AC3:	STA $6B04
L9AC6:	STA $6B14
L9AC9:	STA $6B24
L9ACC:	STA $6B34
L9ACF:	STA $6B44
L9AD2:	BEQ $9ADD
L9AD4:	JSR $9B2F
L9AD7:	JSR $9BE0
L9ADA:	JSR $9C19
L9ADD:	LDA #$0A
L9ADF:	STA $00
L9AE1:	JMP $9930
L9AE4:	LDA $0405,X
L9AE7:	AND #$02
L9AE9:	BEQ $9AF2
L9AEB:	LDA $6AF4,X
L9AEE:	CMP #$03
L9AF0:	BNE $9AF9
L9AF2:	LDA #$00
L9AF4:	STA $6AF4,X
L9AF7:	BEQ $9B24
L9AF9:	LDA $0405,X
L9AFC:	ASL 
L9AFD:	BMI $9B24
L9AFF:	LDA $6AF4,X
L9B02:	CMP #$02
L9B04:	BNE $9B24
L9B06:	JSR $802D
L9B09:	LDX $4B
L9B0B:	LDA $00
L9B0D:	STA $0402,X
L9B10:	JSR $8030
L9B13:	LDX $4B
L9B15:	LDA $00
L9B17:	STA $0403,X
L9B1A:	JSR $8033
L9B1D:	BCS $9B24
L9B1F:	LDA #$03
L9B21:	STA $6AF4,X
L9B24:	LDA #$01
L9B26:	JSR $800C
L9B29:	JMP $8006
L9B2C:	JMP $9AE4
L9B2F:	LDX #$50
L9B31:	JSR $9B3C
L9B34:	TXA 
L9B35:	SEC 
L9B36:	SBC #$10
L9B38:	TAX 
L9B39:	BNE $9B31
L9B3B:	RTS

L9B3C:	LDY $6AF4,X
L9B3F:	BEQ $9B67
L9B41:	LDA $6B02,X
L9B44:	CMP #$0A
L9B46:	BEQ $9B4C
L9B48:	CMP #$09
L9B4A:	BNE $9BBB
L9B4C:	LDA $0405,X
L9B4F:	AND #$02
L9B51:	BEQ $9B67
L9B53:	DEY 
L9B54:	BEQ $9B72
L9B56:	CPY #$02
L9B58:	BEQ $9B67
L9B5A:	CPY #$03
L9B5C:	BNE $9BBB
L9B5E:	LDA $040C,X
L9B61:	CMP #$01
L9B63:	BNE $9BBB
L9B65:	BEQ $9B72
L9B67:	LDA #$00
L9B69:	STA $6AF4,X
L9B6C:	STA $040F,X
L9B6F:	JSR $802A
L9B72:	LDA $0405
L9B75:	STA $0405,X
L9B78:	LSR 
L9B79:	PHP 
L9B7A:	TXA 
L9B7B:	LSR 
L9B7C:	LSR 
L9B7D:	LSR 
L9B7E:	LSR 
L9B7F:	TAY 
L9B80:	LDA $9BCB,Y
L9B83:	STA $04
L9B85:	LDA $9BDA,Y
L9B88:	STA $6B02,X
L9B8B:	TYA 
L9B8C:	PLP 
L9B8D:	ROL 
L9B8E:	TAY 
L9B8F:	LDA $9BCF,Y
L9B92:	STA $05
L9B94:	TXA 
L9B95:	PHA 
L9B96:	LDX #$00
L9B98:	JSR $9BBC
L9B9B:	PLA 
L9B9C:	TAX 
L9B9D:	JSR $8027
L9BA0:	BCC $9BBB
L9BA2:	LDA $6AF4,X
L9BA5:	BNE $9BAA
L9BA7:	INC $6AF4,X
L9BAA:	LDA $08
L9BAC:	STA $0400,X
L9BAF:	LDA $09
L9BB1:	STA $0401,X
L9BB4:	LDA $0B
L9BB6:	AND #$01
L9BB8:	STA $6AFB,X
L9BBB:	RTS

L9BBC:	LDA $0400,X
L9BBF:	STA $08
L9BC1:	LDA $0401,X
L9BC4:	STA $09
L9BC6:	LDA $6AFB,X
L9BC9:	STA $0B
L9BCB:	RTS

L9BCC:	.byte $F5, $FD, $05, $F6, $FE, $0A, $F6, $0C, $F4, $0E, $F2, $F8, $08, $F4, $0C, $09
L9BDC:	.byte $09, $09, $0A, $0A

L9BE0:	LDY $7E
L9BE2:	BNE $9BE6
L9BE4:	LDY #$80
L9BE6:	LDA $2D
L9BE8:	AND #$02
L9BEA:	BNE $9C18
L9BEC:	DEY 
L9BED:	STY $7E
L9BEF:	TYA 
L9BF0:	ASL 
L9BF1:	BMI $9C18
L9BF3:	AND #$0F
L9BF5:	CMP #$0A
L9BF7:	BNE $9C18
L9BF9:	LDA #$01
L9BFB:	LDX #$10
L9BFD:	CMP $6AF4,X
L9C00:	BEQ $9C13
L9C02:	LDX #$20
L9C04:	CMP $6AF4,X
L9C07:	BEQ $9C13
L9C09:	LDX #$30
L9C0B:	CMP $6AF4,X
L9C0E:	BEQ $9C13
L9C10:	INC $7E
L9C12:	RTS

L9C13:	LDA #$08
L9C15:	STA $0409,X
L9C18:	RTS

L9C19:	LDY $7F
L9C1B:	BNE $9C1F
L9C1D:	LDY #$60
L9C1F:	LDA $2D
L9C21:	AND #$02
L9C23:	BNE $9C48
L9C25:	DEY 
L9C26:	STY $7F
L9C28:	TYA 
L9C29:	ASL 
L9C2A:	BMI $9C48
L9C2C:	AND #$0F
L9C2E:	BNE $9C48
L9C30:	LDA #$01
L9C32:	LDX #$40
L9C34:	CMP $6AF4,X
L9C37:	BEQ $9C43
L9C39:	LDX #$50
L9C3B:	CMP $6AF4,X
L9C3E:	BEQ $9C43
L9C40:	INC $7F
L9C42:	RTS

L9C43:	LDA #$08
L9C45:	STA $0409,X
L9C48:	RTS 

L9C49:	.byte $60

L9C4A:	.byte $22, $FF, $FF, $FF, $FF

L9C4F:	.byte $22, $80, $81, $82, $83

L9C54:	.byte $22, $84, $85, $86, $87

L9C59:	.byte $22, $88, $89, $8A, $8B

L9C5E:	.byte $22, $8C, $8D, $8E, $8F

L9C63:	.byte $22, $94, $95, $96, $97

L9C68:	.byte $22, $9C, $9D, $9D, $9C

L9C6D:	.byte $22, $9E, $9F, $9F, $9E

L9C72:	.byte $22, $90, $91, $92, $93

L9C77:	.byte $22, $70, $71, $72, $73

L9C7C:	.byte $22, $74, $75, $76, $77

L9C81:	.byte $22, $78, $79, $7A, $7B

;-----------------------------------[ Enemy animation data tables ]----------------------------------

EnemyAnimIndexTbl:
L9C86:	.byte $00, $01, $FF

L9C89:	.byte $02, $FF

L9C8B:	.byte $19, $1A, $FF

L9C8E:	.byte $1A, $1B, $FF

L9C91:	.byte $1C, $1D, $FF

L9C94:	.byte $1D, $1E, $FF

L9C97:	.byte $22, $23, $24, $FF

L9C9B:	.byte $1F, $20, $21, $FF

L9C9F:	.byte $22, $FF

L9CA1:	.byte $1F, $FF

L9CA3:	.byte $23, $04, $FF

L9CA6:	.byte $20, $03, $FF

L9CA9:	.byte $27, $28, $29, $FF

L9CAD:	.byte $37, $FF

L9CAF:	.byte $38, $FF

L9CB1:	.byte $39, $FF

L9CB3:	.byte $3A, $FF

L9CB5:	.byte $3B, $FF

L9CB7:	.byte $3C, $FF

L9CB9:	.byte $3D, $FF

L9CBB:	.byte $58, $59, $FF

L9CBE:	.byte $5A, $5B, $FF

L9CC1:	.byte $5C, $5D, $FF

L9CC4:	.byte $5E, $5F, $FF

L9CC7:	.byte $60, $FF

L9CC9:	.byte $61, $F7, $62, $F7, $FF

L9CCE:	.byte $66, $67, $FF

L9CD1:	.byte $69, $6A, $FF

L9CD4:	.byte $68, $FF

L9CD6:	.byte $6B, $FF

L9CD8:	.byte $66, $FF

L9CDA:	.byte $69, $FF

L9CDC:	.byte $6C, $FF

L9CDE:	.byte $6D, $FF

L9CE0:	.byte $6F, $70, $71, $6E, $FF

L9CE5:	.byte $73, $74, $75, $72, $FF

L9CEA:	.byte $8F, $90, $FF

L9CED:	.byte $91, $92, $FF

L9CF0:	.byte $93, $94, $FF

L9CF3:	.byte $95, $FF

L9CF5:	.byte $96, $FF

;----------------------------[ Enemy sprite drawing pointer tables ]---------------------------------

EnemyFramePtrTbl1:
L9CF7:	.word $9ED9, $9EDE, $9EE3, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8
L9D07:	.word $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8
L9D17:	.word $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8, $9EE8 
L9D27:	.word $9EE8, $9EE8, $9EF6, $9F04, $9F10, $9F1E, $9F2C, $9F38 
L9D37:	.word $9F41, $9F4B, $9F55, $9F5E, $9F68, $9F72, $9F72, $9F72
L9D47:	.word $9F80, $9F87, $9F90, $9F90, $9F90, $9F90, $9F90, $9F90
L9D57:	.word $9F90, $9F90, $9F90, $9F90, $9F90, $9F90, $9F90, $9F90
L9D67:	.word $9FA4, $9FB8, $9FC3, $9FCE, $9FD7, $9FE0, $9FEB, $9FEB
L9D77:	.word $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB
L9D87:	.word $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB
L9D97:	.word $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB, $9FEB
L9DA7:	.word $9FEB, $9FF3, $9FFB, $A003, $A00B, $A013, $A01B, $A023
L9DB7:	.word $A02B, $A033, $A041, $A05B, $A05B, $A05B, $A05B, $A063
L9BC7:	.word $A06B, $A073, $A07B, $A083, $A08B, $A093, $A09B, $A0A3
L9BD7:	.word $A0AB, $A0B3, $A0BB, $A0C3, $A0CB, $A0D3, $A0DB, $A0DB
L9BE7:	.word $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB, $A0DB

EnemyFramePtrTbl2:
L9DF7:	.word $A0DB, $A0E3, $A0E8, $A0E8, $A0E8, $A0E8, $A0E8, $A0E8
L9E07:	.word $A0E8, $A0E8, $A0ED, $A0ED, $A0ED, $A0ED, $A0ED, $A0ED
L9E17:	.word $A0F7, $A101, $A111, $A121, $A131, $A141, $A14B

EnemyPlacePtrTbl:
L9E25:	.word $9E45, $9E47, $9E5F, $9E77, $9E77, $9E77, $9E87, $9E93
L9E35:	.word $9E9B, $9EA7, $9EA7, $9EC7, $9ED5, $9ED5, $9ED5, $9ED5

;------------------------------[ Enemy sprite placement data tables ]--------------------------------

L9E45:	.byte $FC, $FC

L9E47:	.byte $80, $80, $81, $81, $82, $82, $83, $83, $84, $84, $85, $85, $F4, $F8, $F4, $00
L9E57:	.byte $FC, $F8, $FC, $00, $04, $F8, $04, $00

L9E5F:	.byte $F0, $F4, $F0, $FC, $F0, $04, $F8, $F4, $F8, $FC, $F8, $04, $00, $F4, $00, $FC
L9E6F:	.byte $00, $04, $08, $F4, $08, $FC, $08, $04

L9E77:	.byte $F8, $F4, $00, $F4, $F8, $FC, $00, $FC, $F4, $FC, $FC, $FC, $F8, $04, $00, $04

L9E87:	.byte $02, $F4, $0A, $F4, $F8, $FC, $00, $FC, $02, $04, $0A, $04

L9E93:	.byte $F8, $F8, $F8, $00, $00, $F8, $00, $00

L9E9B:	.byte $F4, $FC, $FC, $FC, $04, $FC, $FC, $04, $04, $04, $0C, $FC

L9EA7:	.byte $F8, $F8, $F8, $00, $00, $F8, $00, $00, $F0, $00, $F0, $08, $F8, $08, $F0, $F0
L9EB7:	.byte $F0, $F8, $F8, $F0, $00, $F0, $08, $F0, $08, $F8, $00, $08, $08, $00, $08, $08

L9EC7:	.byte $F8, $FC, $00, $F8, $F4, $F4, $FC, $F4, $00, $00, $F4, $04, $FC, $04

L9ED5:	.byte $FC, $F8, $FC, $00

;Enemy frame drawing data.

L9ED9:	.byte $00, $02, $02, $14, $FF

L9EDE:	.byte $00, $02, $02, $24, $FF

L9EE3:	.byte $00, $00, $00, $04, $FF

L9EE8:	.byte $25, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $62, $E2, $F2, $FF

L9EF6:	.byte $25, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $62, $E4, $F2, $FF

L9F04:	.byte $26, $08, $0A, $F4, $F2, $E3, $F3, $FD, $62, $F4, $F2, $FF

L9F10:	.byte $A5, $08, $0A, $E2, $F2, $E3, $F3, $FE, $FE, $FD, $E2, $E2, $F2, $FF

L9F1E:	.byte $A5, $08, $0A, $E4, $F2, $FE, $FE, $E3, $F3, $FD, $E2, $E4, $F2, $FF

L9F2C:	.byte $A6, $08, $0A, $F4, $F2, $E3, $F3, $FD, $E2, $F4, $F2, $FF

L9F38:	.byte $27, $06, $08, $FC, $04, $00, $C0, $C1, $FF

L9F41:	.byte $27, $06, $08, $E0, $E1, $FD, $A2, $E0, $E1, $FF

L9F4B:	.byte $27, $06, $08, $F0, $F1, $FD, $A2, $F0, $F1, $FF

L9F55:	.byte $67, $06, $08, $FC, $04, $00, $C0, $C1, $FF

L9F5E:	.byte $67, $06, $08, $E0, $E1, $FD, $E2, $E0, $E1, $FF

L9F68:	.byte $67, $06, $08, $F0, $F1, $FD, $E2, $F0, $F1, $FF

L9F72:	.byte $28, $0C, $08, $CE, $FC, $00, $FC, $DE, $EE, $DF, $FD, $62, $EE, $FF

L9F80:	.byte $28, $0C, $08, $CE, $CF, $EF, $FF

L9F87:	.byte $28, $0C, $08, $CE, $FD, $62, $CF, $EF, $FF

L9F90:	.byte $21, $00, $00, $FC, $08, $FC, $E2, $FC, $00, $08, $E2, $FC, $00, $F8, $F2, $FC
L9FA0:	.byte $00, $08, $F2, $FF

L9FA4:	.byte $21, $00, $00, $FC, $00, $FC, $F2, $FC, $00, $08, $F2, $FC, $00, $F8, $E2, $FC
L9FB4:	.byte $00, $08, $E2, $FF

L9FB8:	.byte $21, $00, $00, $FC, $04, $00, $F1, $F0, $F1, $F0, $FF

L9FC3:	.byte $21, $00, $00, $FC, $04, $00, $F0, $F1, $F0, $F1, $FF

L9FCE:	.byte $21, $00, $00, $FC, $08, $00, $D1, $D0, $FF

L9FD7:	.byte $21, $00, $00, $FC, $08, $00, $D0, $D1, $FF

L9FE0:	.byte $21, $00, $00, $FC, $08, $00, $DE, $DF, $EE, $EE, $FF

L9FEB:	.byte $27, $08, $08, $CC, $CD, $DC, $DD, $FF

L9FF3:	.byte $67, $08, $08, $CC, $CD, $DC, $DD, $FF

L9FFB:	.byte $27, $08, $08, $CA, $CB, $DA, $DB, $FF

LA003:	.byte $A7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA00B:	.byte $A7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA013:	.byte $E7, $08, $08, $CC, $CD, $DC, $DD, $FF

LA01B:	.byte $67, $08, $08, $CA, $CB, $DA, $DB, $FF

LA023:	.byte $E7, $08, $08, $CA, $CB, $DA, $DB, $FF

LA02B:	.byte $21, $00, $00, $CC, $CD, $DC, $DD, $FF

LA033:	.byte $0A, $00, $00, $75, $FD, $60, $75, $FD, $A0, $75, $FD, $E0, $75, $FF

LA041:	.byte $0A, $00, $00, $FE, $FE, $FE, $FE, $3D, $3E, $4E, $FD, $60, $3E, $3D, $4E, $FD
LA051:	.byte $E0, $4E, $3E, $3D, $FD, $A0, $4E, $3D, $3E, $FF

LA05B:	.byte $2A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA063:	.byte $2A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA06B:	.byte $21, $08, $08, $C2, $C4, $D2, $D4, $FF

LA073:	.byte $6A, $08, $08, $C2, $C3, $D2, $D3, $FF

LA07B:	.byte $6A, $08, $08, $C2, $C4, $D2, $D4, $FF

LA083:	.byte $61, $08, $08, $C2, $C4, $D2, $D4, $FF

LA08B:	.byte $20, $02, $04, $FC, $FF

LA090:	.byte $00, $F8, $FF

LA093:	.byte $60, $02, $04, $FC, $FF

LA098:	.byte $00, $F8, $FF

LA09B:	.byte $20, $02, $02, $FC, $FE, $00, $D9, $FF

LA0A3:	.byte $E0, $02, $02, $FC, $00, $02, $D8, $FF

LA0AB:	.byte $E0, $02, $02, $FC, $02, $00, $D9, $FF

LA0B3:	.byte $20, $02, $02, $FC, $00, $FE, $D8, $FF

LA0BB:	.byte $60, $02, $02, $FC, $FE, $00, $D9, $FF

LA0C3:	.byte $A0, $02, $02, $FC, $00, $FE, $D8, $FF

LA0CB:	.byte $A0, $02, $02, $FC, $02, $00, $D9, $FF

LA0D3:	.byte $60, $02, $02, $FC, $00, $02, $D8, $FF

LA0DB:	.byte $06, $08, $04, $FE, $FE, $14, $24, $FF

LA0E3:	.byte $00, $04, $04, $8A, $FF

LA0E8:	.byte $00, $04, $04, $8A, $FF

LA0ED:	.byte $3F, $04, $08, $FD, $03, $EC, $FD, $43, $EC, $FF

LA0F7:	.byte $3F, $04, $08, $FD, $03, $ED, $FD, $43, $ED, $FF

LA101:	.byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA111:	.byte $22, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA121:	.byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $F5, $F6, $F7, $FF

LA131:	.byte $62, $10, $0C, $C5, $C6, $C7, $D5, $D6, $D7, $E5, $E6, $E7, $E8, $E9, $F9, $FF

LA141:	.byte $21, $00, $00, $C5, $C7, $D5, $D7, $E5, $E7, $FF

LA14B:	.byte $21, $00, $00, $C7, $C5, $D7, $D5, $E7, $E5, $FF

;----------------------------------------[ Palette data ]--------------------------------------------

Palette00:
LA155:	.byte $3F			;Upper byte of PPU palette adress.
LA156:	.byte $00			;Lower byte of PPU palette adress.
LA157:	.byte $20			;Palette data length.
;The following values are written to the background palette:
LA158:	.byte $0F, $20, $10, $00, $0F, $28, $19, $1A, $0F, $28, $16, $04, $0F, $23, $11, $02
;The following values are written to the sprite palette:
LA168:	.byte $0F, $16, $19, $27, $0F, $12, $30, $21, $0F, $27, $1B, $36, $0F, $17, $22, $31

LA178:	.byte $00			;End Palette00 info.

Palette01:
LA179:	.byte $3F			;Upper byte of PPU palette adress.
LA17A:	.byte $12			;Lower byte of PPU palette adress.
LA17B:	.byte $02			;Palette data length.
;The following values are written to the sprite palette:
LA17C:	.byte $19, $27

LA17E:	.byte $00			;End Palette01 info.

Palette03:
LA17F:	.byte $3F			;Upper byte of PPU palette adress.
LA180:	.byte $12			;Lower byte of PPU palette adress.
LA181:	.byte $02			;Palette data length.
;The following values are written to the sprite palette:
LA182:	.byte $2C, $27

LA184:	.byte $00			;End Palette03 info.

Palette02:
LA185:	.byte $3F			;Upper byte of PPU palette adress.
LA186:	.byte $12			;Lower byte of PPU palette adress.
LA187:	.byte $02			;Palette data length.
;The following values are written to the sprite palette:
LA188:	.byte $19, $35

LA18A:	.byte $00			;End Palette02 info.

Palette04:
LA18B:	.byte $3F			;Upper byte of PPU palette adress.
LA18C:	.byte $12			;Lower byte of PPU palette adress.
LA18D:	.byte $02			;Palette data length.
;The following values are written to the sprite palette:
LA18E:	.byte $2C, $24

LA190:	.byte $00			;End Palette04 info.

Palette05:
LA191:	.byte $3F			;Upper byte of PPU palette adress.
LA192:	.byte $11			;Lower byte of PPU palette adress.
LA193:	.byte $03			;Palette data length.
;The following values are written to the sprite palette:
LA194:	.byte $04, $09, $07

LA196:	.byte $00			;End Palette05 info.

Palette06:
La198:	.byte $3F			;Upper byte of PPU palette adress.
LA199:	.byte $11			;Lower byte of PPU palette adress.
LA19A:	.byte $03			;Palette data length.
;The following values are written to the sprite palette:
LA19B:	.byte $05, $09, $17

LA19E:	.byte $00			;End Palette06 info.

Palette07:
LA19F:	.byte $3F			;Upper byte of PPU palette adress.
LA1A0:	.byte $11			;Lower byte of PPU palette adress.
LA1A1:	.byte $03			;Palette data length.
;The following values are written to the sprite palette:
LA1A2:	.byte $06, $0A, $26

LA1A5:	.byte $00			;End Palette07 info.

Palette08:
LA1A6:	.byte $3F			;Upper byte of PPU palette adress.
LA1A7:	.byte $11			;Lower byte of PPU palette adress.
LA1A8:	.byte $03			;Palette data length.
;The following values are written to the sprite palette:
LA1A9:	.byte $16, $19, $27

LA1AC:	.byte $00			;End Palette08 info.

Palette09:
LA1AD:	.byte $3F			;Upper byte of PPU palette adress.
LA1AE:	.byte $00			;Lower byte of PPU palette adress.
LA1AF:	.byte $04			;Palette data length.
;The following values are written to the background palette:
LA1B0:	.byte $0F, $30, $30, $21

LA1B4:	.byte $00			;End Palette09 info.

Palette0A:
LA1B5:	.byte $3F			;Upper byte of PPU palette adress.
LA1B6:	.byte $10			;Lower byte of PPU palette adress.
LA1B7:	.byte $04			;Palette data length.
;The following values are written to the sprite palette:
LA1B8:	.byte $0F, $15, $34, $17

LA1BC:	.byte $00			;End Palette0A info.

Palette0B:
LA1BD:	.byte $3F			;Upper byte of PPU palette adress.
LA1BE:	.byte $10			;Lower byte of PPU palette adress.
LA1BF:	.byte $04			;Palette data length.
;The following values are written to the sprite palette:
LA1C0:	.byte $0F, $15, $34, $19

LA1C4:	.byte $00			;End Palette0B info.

Palette0C:
LA1C5:	.byte $3F			;Upper byte of PPU palette adress.
LA1C6:	.byte $10			;Lower byte of PPU palette adress.
LA1C7:	.byte $04			;Palette data length.
;The following values are written to the sprite palette:
LA1C8:	.byte $0F, $15, $34, $28

LA1CC:	.byte $00			;End Palette0C info.

Palette0D:
LA1CD:	.byte $3F			;Upper byte of PPU palette adress.
LA1CE:	.byte $10			;Lower byte of PPU palette adress.
LA1CF:	.byte $04			;Palette data length.
;The following values are written to the sprite palette:
LA1D0:	.byte $0F, $15, $34, $29

LA1D4:	.byte $00			;End Palette0D info.


;----------------------------[ Room and structure pointer tables ]-----------------------------------

RmPtrTbl:
LA1D5:	.word $A2B7, $A2C5, $A2CD, $A308, $A345, $A388, $A3B8, $A401
LA1E5:	.word $A442, $A47E, $A4AD, $A4E2, $A514, $A558, $A590, $A5BF
LA1F5:	.word $A5E8, $A647, $A647, $A683, $A6B5, $A6D9, $A713, $A745
LA205:	.word $A780, $A7B2, $A7F6, $A83F, $A8A3, $A8C7, $A923, $A94F
LA215:	.word $A972, $A990, $A9BE, $A9FE, $AA33

StrctPtrTbl:
LA21F:	.word $AA6B, $AA7E, $AA97, $AAB0, $AAB7, $AABE, $AAC2, $AAD2
LA22F:	.word $AAE2, $AAE7, $AAEC, $AAEF, $AAF2, $AAFD, $AB03, $AB08
LA23F:	.word $AB11, $AB26, $AB29, $AB3C, $AB51, $AB55, $AB68, $AB75
LA24F:	.word $AB88, $AB9B, $ABB0, $ABBA, $ABBD, $ABC4, $ABE0, $ABE9
LA25F:	.word $ABFE, $AC01, $AC0A, $AC0F, $AC14, $AC1E, $AC27

;-----------------------------------[ Special items table ]-----------------------------------------

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

;Elevator from Brinstar.
LA26D:	.byte $12
LA26E:	.word $A275
LA270:	.byte $07, $FF, $04, $81, $00

;Elevator to Brinstar.
LA275:	.byte $14
LA276:	.word $A27D
LA278:	.byte $07, $FF, $04, $82, $00

;Missiles.
LA27D:	.byte $15
LA27E:	.word $A28C
LA27F:	.byte $04, $06, $02, $09, $47, $00

;Missiles.
LA286:	.byte $09, $FF, $02, $09, $47, $00

;Energy tank.
LA28C:	.byte $16
LA28D:	.word $A295
LA28F:	.byte $0A, $FF, $02, $08, $66, $00

;Missiles.
LA295:	.byte $19
LA296:	.word $A29E
LA298:	.byte $0A, $FF, $02, $09, $47, $00

;Missiles.
LA29E:	.byte $1B
LA29F:	.word $A2A7
LA2A1:	.byte $05, $FF, $02, $09, $47, $00

;Memus.
LA2A7:	.byte $1C
LA2A8:	.word $A2AE
LA2A9:	.byte $07, $FF, $03, $00

;Energy tank.
LA2AE:	.byte $1D
LA2AF:	.word $FFFF
LA2B1:	.byte $08, $FF, $02, $08, $BE, $00

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
LA2B7:	.byte $02			;Attribute table data.
;Room object data:
LA2B8:	.byte $40, $01, $03, $48, $01, $03, $50, $04, $02, $5F, $04, $02, $FF

;Room #$01
LA2C5:	.byte $02			;Attribute table data.
;Room object data:
LA2C6:	.byte $07, $02, $02, $87, $02, $02, $FF

;Room #$02
LA2CD:	.byte $00			;Attribute table data.
;Room object data:
LA2CE:	.byte $00, $10, $00, $04, $10, $00, $08, $10, $00, $0C, $10, $00, $40, $06, $00, $42
LA2DE:	.byte $08, $01, $4E, $06, $00, $6D, $09, $01, $75, $0C, $00, $7A, $0C, $00, $90, $06
LA2EE:	.byte $00, $92, $0C, $00, $96, $0D, $00, $9D, $0C, $00, $9E, $06, $00, $E0, $06, $00
LA2FE:	.byte $E1, $0D, $00, $EB, $0D, $00, $EE, $06, $00, $FF

;Room #$03
LA308:	.byte $00			;Attribute table data.
;Room object data:
LA309:	.byte $00, $06, $00, $0A, $0D, $00, $0E, $06, $00, $22, $08, $01, $2D, $09, $01, $45
LA319:	.byte $0D, $00, $50, $03, $02, $5F, $03, $02, $80, $10, $00, $8A, $06, $00, $8C, $10
LA329:	.byte $00, $A4, $08, $01, $C0, $10, $00, $C9, $0D, $00, $CC, $10, $00, $DB, $09, $01
LA339:	.byte $E1, $10, $00, $FD
;Room enemy/door data:
LA33D:	.byte $02, $A0, $02, $B1, $31, $85, $37, $FF

;Room #$04
LA345:	.byte $00			;Attribute table data.
;Room object data:
LA346:	.byte $00, $06, $00, $07, $06, $00, $0B, $10, $00, $0E, $06, $00, $22, $08, $01, $2A
LA356:	.byte $09, $01, $35, $0D, $00, $50, $03, $02, $57, $06, $00, $5F, $03, $02, $80, $0D
LA366:	.byte $00, $8C, $0D, $00, $8E, $06, $00, $90, $06, $00, $92, $08, $01, $BE, $06, $00
LA376:	.byte $CD, $09, $01, $D0, $06, $00, $FD
;Room enemy/door data:
LA37D:	.byte $02, $A0, $02, $B1, $41, $85, $25, $21, $83, $C8, $FF

;Room #$05
LA388:	.byte $00			;Attribute table data.
;Room object data:
LA389:	.byte $00, $10, $00, $0C, $10, $00, $14, $08, $01, $40, $10, $00, $4C, $10, $00, $6B
LA399:	.byte $09, $01, $7C, $10, $00, $80, $10, $00, $94, $08, $01, $BC, $10, $00, $C0, $10
LA3A9:	.byte $00, $DB, $09, $01, $FD
;Room enemy/door data:
LA3AE:	.byte $51, $83, $57, $01, $03, $95, $11, $03, $CA, $FF

;Room #$06
LA3B8:	.byte $00			;Attribute table data.
;Room object data:
LA3B9:	.byte $00, $06, $00, $0E, $06, $00, $12, $08, $01, $17, $0E, $00, $1A, $0D, $00, $27
LA3C9:	.byte $0C, $00, $31, $0E, $00, $36, $11, $00, $39, $07, $00, $50, $03, $02, $59, $0E
LA3D9:	.byte $00, $5F, $03, $02, $80, $10, $00, $84, $10, $00, $88, $10, $00, $8C, $10, $00
LA3E9:	.byte $C0, $10, $00, $C4, $10, $00, $C8, $10, $00, $CC, $10, $00, $FD
;Room enemy/door data:
LA3F6:	.byte $02, $A1, $02, $B1, $01, $85, $2A, $51, $85, $26, $FF

;Room #$07
LA401:	.byte $00			;Attribute table data.
;Room object data:
LA402:	.byte $00, $10, $00, $0A, $10, $00, $0E, $07, $00, $24, $08, $01, $27, $0E, $00, $40
LA412:	.byte $07, $00, $5F, $03, $02, $62, $10, $00, $8B, $0E, $00, $8E, $07, $00, $90, $07
LA422:	.byte $00, $9D, $09, $01, $B0, $07, $00, $B2, $10, $00, $B6, $0D, $00, $CE, $07, $00
LA432:	.byte $D6, $08, $01, $FD
;Room enemy/door data:
LA436:	.byte $02, $A1, $01, $85, $17, $21, $85, $A8, $31, $03, $87, $FF

;Room #$08
LA442:	.byte $00			;Attribute table data.
;Room object data:
LA443:	.byte $00, $10, $00, $03, $10, $00, $0A, $10, $00, $0C, $10, $00, $29, $09, $01, $35
LA453:	.byte $0E, $00, $40, $10, $00, $44, $08, $01, $4C, $10, $00, $79, $0E, $00, $80, $10
LA463:	.byte $00, $8C, $10, $00, $AB, $09, $01, $B0, $10, $00, $B4, $0D, $00, $CC, $10, $00
LA473:	.byte $D4, $08, $01, $FD
;Room enemy/door data:
LA477:	.byte $11, $85, $6A, $41, $85, $A6, $FF

;Room #$09
LA47E:	.byte $00			;Attribute table data.
;Room object data:
LA47F:	.byte $00, $07, $00, $0D, $09, $01, $0E, $07, $00, $42, $08, $01, $50, $07, $00, $5F
LA48F:	.byte $03, $02, $8B, $0E, $00, $8E, $07, $00, $9D, $09, $01, $A0, $07, $00, $A6, $0E
LA49F:	.byte $00, $DE, $07, $00, $FD
;Room enemy/door data:
LA4A4:	.byte $02, $A1, $21, $85, $97, $31, $03, $83, $FF

;Room #$0A
LA4AD:	.byte $00			;Attribute table data.
;Room object data:
LA4AE:	.byte $00, $07, $00, $0E, $07, $00, $12, $08, $01, $50, $07, $00, $5F, $03, $02, $72
LA4BE:	.byte $08, $01, $87, $0E, $00, $8B, $0E, $00, $8E, $07, $00, $A0, $10, $00, $AD, $09
LA4CE:	.byte $01, $CC, $10, $00, $D4, $00, $02, $E0, $10, $00, $FD
;Room enemy/door data:
LA4D9:	.byte $02, $A1, $01, $85, $78, $11, $03, $28, $FF

;Room #$0B
LA4E2:	.byte $00			;Attribute table data.
;Room object data:
LA4E3:	.byte $00, $10, $00, $04, $10, $00, $08, $10, $00, $0C, $10, $00, $40, $10, $00, $44
LA4F3:	.byte $10, $00, $48, $10, $00, $4C, $10, $00, $80, $10, $00, $84, $10, $00, $88, $10
LA503:	.byte $00, $8C, $10, $00, $B0, $10, $00, $B4, $10, $00, $B8, $10, $00, $BC, $10, $00
LA513:	.byte $FF

;Room #$0C
LA514:	.byte $00			;Attribute table data.
;Room object data:
LA515:	.byte $00, $07, $00, $0A, $11, $00, $0E, $07, $00, $25, $11, $00, $32, $08, $01, $49
LA525:	.byte $11, $00, $50, $03, $02, $5D, $09, $01, $5E, $07, $00, $80, $07, $00, $82, $11
LA535:	.byte $00, $86, $11, $00, $9C, $11, $00, $AE, $07, $00, $BD, $09, $01, $C2, $08, $01
LA545:	.byte $C8, $11, $00, $D0, $07, $00, $D4, $11, $00, $FD
;Room enemy/door data:
LA54F:	.byte $02, $B1, $51, $85, $39, $41, $05, $C4, $FF

;Room #$0D
LA558:	.byte $00			;Attribute table data.
;Room object data:
LA559:	.byte $00, $07, $00, $0A, $0F, $02, $0E, $07, $00, $1D, $09, $01, $4A, $0F, $02, $50
LA569:	.byte $03, $02, $5E, $07, $00, $80, $07, $00, $86, $0F, $02, $8A, $0F, $02, $8C, $11
LA579:	.byte $00, $9D, $09, $01, $A2, $11, $00, $AE, $07, $00, $C2, $08, $01, $CA, $0F, $02
LA589:	.byte $D0, $07, $00, $FD
;Room enemy/door data:
LA58D:	.byte $02, $B1, $FF

;Room #$0E
LA590:	.byte $00			;Attribute table data.
;Room object data:
LA591:	.byte $00, $07, $00, $0A, $0F, $02, $0E, $07, $00, $2D, $09, $01, $32, $08, $01, $4A
LA5A1:	.byte $0F, $02, $50, $07, $00, $5E, $07, $00, $78, $11, $00, $8A, $0F, $02, $92, $08
LA5B1:	.byte $01, $A0, $07, $00, $AE, $07, $00, $BD, $09, $01, $CA, $0F, $02, $FF

;Room #$0F
LA5BF:	.byte $01			;Attribute table data.
;Room object data:
LA5C0:	.byte $00, $1D, $01, $08, $1D, $01, $1E, $1F, $01, $5F, $03, $02, $8C, $1F, $01, $9B
LA5D0:	.byte $09, $01, $C9, $1D, $01, $D0, $1F, $01, $D4, $00, $02, $FD
;Room enemy/door data:
LA5DC:	.byte $02, $A1, $41, $84, $31, $57, $87, $D5, $07, $87, $D8, $FF

;Room #$10
LA5E8:	.byte $00			;Attribute table data.
;Room object data:
LA5E9:	.byte $00, $12, $00, $08, $12, $00, $57, $0C, $00, $75, $0C, $00, $79, $0C, $00, $93
LA5F9:	.byte $0C, $00, $9B, $0C, $00, $B1, $0C, $00, $BD, $0C, $00, $CF, $0C, $00, $D0, $00
LA609:	.byte $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA60E:	.byte $41, $81, $2D, $27, $07, $D4, $17, $87, $DA, $FF

;Room #$11 (not used).
LA618:	.byte $00			;Attribute table data.
;Room object data:
LA619:	.byte $00, $07, $00, $02, $08, $01, $0E, $07, $00, $2D, $09, $01, $32, $0E, $00, $50
LA629:	.byte $03, $02, $5F, $03, $02, $80, $10, $00, $84, $10, $00, $88, $10, $00, $8C, $10
LA639:	.byte $00, $C0, $10, $00, $C4, $10, $00, $C8, $10, $00, $CC, $10, $00, $FF

;Room #$12
LA647:	.byte $00			;Attribute table data.
;Room object data:
LA648:	.byte $00, $12, $00, $08, $12, $00, $24, $11, $00, $37, $0C, $00, $45, $0C, $00, $48
LA658:	.byte $0E, $00, $57, $0C, $00, $63, $0C, $00, $65, $0C, $00, $9B, $0E, $00, $A2, $11
LA668:	.byte $00, $C0, $13, $03, $C5, $0E, $00, $C9, $0C, $00, $CC, $13, $03, $D4, $00, $02
LA678:	.byte $FD
;Room enemy/door data:
LA679:	.byte $21, $85, $39, $31, $85, $8C, $41, $85, $B6, $FF

;Room #$13
LA683:	.byte $03			;Attribute table data.
;Room object data:
LA684:	.byte $00, $15, $03, $08, $15, $03, $10, $16, $03, $50, $03, $02, $68, $14, $03, $80
LA694:	.byte $16, $03, $93, $14, $03, $AB, $14, $03, $BF, $14, $03, $C0, $16, $03, $D2, $00
LA6A4:	.byte $02, $DA, $00, $02, $FD
;Room enemy/door data:
LA6A9:	.byte $02, $B0, $21, $81, $27, $41, $85, $84, $37, $87, $DD, $FF

;Room #$14
LA6B5:	.byte $03			;Attribute table data.
;Room object data:
LA6B6:	.byte $00, $15, $03, $08, $15, $03, $8A, $14, $03, $A4, $14, $03, $AF, $14, $03, $D0
LA6C6:	.byte $00, $02, $D8, $00, $02, $FD
;Room enemy/door data:
LA6CC:	.byte $37, $87, $D1, $47, $87, $D7, $57, $87, $DC, $01, $85, $95, $FF

;Room #$15
LA6D9:	.byte $01			;Attribute table data.
;Room object data:
LA6DA:	.byte $00, $1D, $01, $08, $1D, $01, $20, $1D, $01, $28, $1D, $01, $50, $03, $02, $5F
LA6EA:	.byte $03, $02, $80, $1D, $01, $87, $20, $01, $88, $1D, $01, $97, $21, $01, $B0, $1D
LA6FA:	.byte $01, $B7, $21, $01, $B8, $1D, $01, $C0, $1D, $01, $C7, $21, $01, $C8, $1D, $01
LA70A:	.byte $FD
;Room enemy/door data:
LA70B:	.byte $02, $A1, $02, $B1, $01, $80, $68, $FF

;Room #$16
LA713:	.byte $03			;Attribute table data.
;Room object data:
LA714:	.byte $00, $15, $03, $08, $15, $03, $1E, $16, $03, $5F, $03, $02, $61, $14, $03, $85
LA724:	.byte $14, $03, $8C, $15, $03, $8E, $16, $03, $BA, $14, $03, $CE, $16, $03, $D0, $00
LA734:	.byte $02, $D6, $00, $02, $FD
;Room enemy/door data:
LA739:	.byte $02, $A1, $07, $87, $D3, $17, $07, $D8, $21, $81, $27, $FF

;Room #$17
LA745:	.byte $01			;Attribute table data.
;Room object data:
LA746:	.byte $00, $17, $03, $08, $17, $03, $10, $19, $03, $24, $18, $03, $36, $0C, $00, $3B
LA756:	.byte $0C, $00, $50, $03, $02, $80, $19, $03, $AE, $0C, $00, $C0, $19, $03, $D4, $18
LA766:	.byte $03, $D8, $00, $02, $D9, $18, $03, $DB, $05, $02, $DF, $00, $02, $FD, $02, $B1
LA776:	.byte $41, $80, $C5, $57, $87, $DC, $31, $04, $48, $FF

;Room #$18
LA780:	.byte $01			;Attribute table data.
;Room object data:
LA781:	.byte $00, $17, $03, $08, $17, $03, $1C, $19, $03, $20, $19, $03, $5F, $03, $02, $8C
LA791:	.byte $19, $03, $CC, $19, $03, $D0, $18, $03, $D3, $00, $02, $D4, $18, $03, $D5, $05
LA7A1:	.byte $02, $FD
;Room enemy/door data:
LA7A3:	.byte $02, $A1, $37, $87, $D6, $21, $84, $62, $11, $84, $25, $01, $84, $29, $FF

;Room #$19
LA7B2:	.byte $03			;Attribute table data.
;Room object data:
LA7B3:	.byte $00, $19, $03, $04, $19, $03, $08, $19, $03, $0C, $19, $03, $40, $19, $03, $44
LA7C3:	.byte $19, $03, $48, $19, $03, $4C, $19, $03, $70, $19, $03, $74, $19, $03, $78, $19
LA7D3:	.byte $03, $7C, $19, $03, $90, $1A, $03, $94, $1A, $03, $98, $1A, $03, $9C, $1A, $03
LA7E3:	.byte $B0, $1A, $03, $B8, $1A, $03, $C0, $19, $03, $C4, $19, $03, $C8, $19, $03, $CC
LA7F3:	.byte $19, $03, $FF

;Room #$1A
LA7F6:	.byte $03			;Attribute table data.
;Room object data:
LA7F7:	.byte $00, $13, $03, $04, $13, $03, $08, $13, $03, $0C, $13, $03, $10, $13, $03, $14
LA807:	.byte $13, $03, $18, $13, $03, $1C, $13, $03, $50, $03, $02, $5F, $03, $02, $80, $13
LA817:	.byte $03, $81, $1B, $03, $84, $13, $03, $88, $13, $03, $8C, $13, $03, $91, $1C, $03
LA827:	.byte $C0, $13, $03, $C1, $1C, $03, $C4, $13, $03, $C8, $13, $03, $CC, $13, $03, $FD
;Room enemy/door data:
LA837:	.byte $02, $A0, $02, $B1, $31, $81, $68, $FF

;Room #$1B
LA83F:	.byte $00			;Attribute table data.
;Room object data:
LA840:	.byte $00, $1F, $01, $04, $1D, $01, $07, $21, $01, $0C, $1F, $01, $10, $0C, $00, $14
LA850:	.byte $1F, $01, $17, $21, $01, $18, $1F, $01, $1F, $0C, $00, $25, $0B, $02, $2A, $0B
LA860:	.byte $02, $41, $22, $00, $4C, $23, $00, $50, $03, $02, $54, $22, $00, $59, $23, $00
LA870:	.byte $5F, $03, $02, $80, $07, $00, $82, $14, $03, $84, $14, $03, $86, $14, $03, $88
LA880:	.byte $14, $03, $8A, $14, $03, $8C, $14, $03, $8E, $07, $00, $92, $16, $03, $9C, $16
LA890:	.byte $03, $D0, $12, $00, $D4, $00, $02, $DC, $12, $00, $FD
;Room enemy/door data:
LA89B:	.byte $02, $A1, $02, $B0, $27, $07, $D9, $FF

;Room #$1C
LA8A3:	.byte $03			;Attribute table data.
;Room object data:
LA8A4:	.byte $00, $17, $03, $08, $17, $03, $B0, $18, $03, $B6, $05, $02, $B8, $18, $03, $D0
LA8B4:	.byte $18, $03, $D8, $18, $03, $FD
;Room enemy/door data:
LA8BA:	.byte $37, $87, $B7, $01, $80, $45, $11, $00, $3B, $21, $81, $9A, $FF

;Room #$1D
LA8C7:	.byte $01			;Attribute table data.
;Room object data:
LA8C8:	.byte $00, $15, $03, $08, $15, $03, $10, $24, $03, $13, $0B, $02, $18, $24, $03, $1C
LA8D8:	.byte $0B, $02, $1F, $25, $03, $20, $25, $03, $22, $22, $00, $2B, $23, $00, $5F, $03
LA8E8:	.byte $02, $60, $25, $03, $8E, $25, $03, $8F, $13, $03, $A0, $25, $03, $A2, $11, $00
LA8F8:	.byte $AC, $11, $00, $B3, $12, $00, $BB, $0C, $00, $BE, $1B, $03, $C3, $24, $03, $CE
LA908:	.byte $12, $00, $D1, $00, $02, $D3, $24, $03, $DC, $00, $02, $DE, $12, $00, $E0, $25
LA918:	.byte $03, $E3, $15, $03, $FD
;Room enemy/door data:
LA91D:	.byte $02, $A0, $01, $48, $95, $FF

;Room #$1E
LA923:	.byte $01			;Attribute table data.
;Room object data:
LA924:	.byte $00, $1E, $01, $02, $1D, $01, $08, $1D, $01, $1F, $1F, $01, $40, $1E, $01, $5F
LA934:	.byte $03, $02, $77, $0C, $00, $80, $1E, $01, $87, $1E, $01, $8D, $1F, $01, $C0, $1D
LA944:	.byte $01, $C8, $1D, $01, $FD
;Room enemy/door data:
LA949:	.byte $02, $A1, $11, $81, $35, $FF

;Room #$1F
LA94F:	.byte $01			;Attribute table data.
;Room object data:
LA950:	.byte $00, $1D, $01, $08, $1D, $01, $10, $1E, $01, $50, $03, $02, $80, $1F, $01, $C0
LA960:	.byte $1D, $01, $C8, $1D, $01, $CC, $05, $02, $FD
;Room enemy/door data:
LA969:	.byte $02, $B1, $01, $88, $AB, $17, $07, $CD, $FF

;Room #$20
LA972:	.byte $01			;Attribute table data.
;Room object data:
LA973:	.byte $00, $1D, $01, $08, $1D, $01, $78, $0C, $00, $88, $21, $01, $C0, $1D, $01, $C8
LA983:	.byte $1D, $01, $CD, $05, $02, $FD
;Room enemy/door data:
LA989:	.byte $27, $87, $CE, $41, $80, $BC, $FF

;Room #$21
LA990:	.byte $01			;Attribute table data.
;Room object data:
LA991:	.byte $00, $1D, $01, $08, $1D, $01, $20, $1D, $01, $28, $1D, $01, $50, $03, $02, $5F
LA9A1:	.byte $03, $02, $80, $1D, $01, $88, $1D, $01, $B0, $1D, $01, $B8, $1D, $01, $C0, $1D
LA9B1:	.byte $01, $C8, $1D, $01, $FD
;Room enemy/door data:
LA9B6:	.byte $02, $A1, $02, $B1, $21, $81, $68, $FF

;Room #$22
LA9BE:	.byte $03			;Attribute table data.
;Room object data:
LA9BF:	.byte $00, $13, $03, $04, $13, $03, $08, $13, $03, $0C, $13, $03, $10, $13, $03, $14
LA9CF:	.byte $13, $03, $18, $13, $03, $1C, $13, $03, $50, $03, $02, $5F, $03, $02, $80, $13
LA9DF:	.byte $03, $84, $13, $03, $88, $13, $03, $8C, $13, $03, $C0, $13, $03, $C4, $13, $03
LA9EF:	.byte $C8, $13, $03, $CC, $13, $03, $FD
;Room enemy/door data:
LA9F6:	.byte $02, $A1, $02, $B1, $41, $81, $68, $FF

;Room #$23
LA9FE:	.byte $00			;Attribute table data.
;Room object data:
LA9FF:	.byte $00, $10, $00, $0E, $06, $00, $16, $0D, $00, $2D, $09, $01, $34, $08, $01, $40
LAA0F:	.byte $10, $00, $4B, $0E, $00, $5F, $03, $02, $80, $10, $00, $84, $10, $00, $88, $10
LAA1F:	.byte $00, $8C, $10, $00, $C0, $10, $00, $CC, $10, $00, $D4, $00, $02, $FD
;Room enemy/door data:
LAA2D:	.byte $02, $A1, $01, $03, $38, $FF

;Room #$24
LAA33:	.byte $00			;Attribute table data.
;Room object data:
LAA34:	.byte $00, $07, $00, $0E, $07, $00, $19, $11, $00, $1D, $09, $01, $32, $08, $01, $4C
LAA44:	.byte $11, $00, $50, $03, $02, $5E, $07, $00, $80, $10, $00, $84, $10, $00, $88, $10
LAA54:	.byte $00, $8C, $10, $00, $C0, $10, $00, $CC, $10, $00, $FD
;Room enemy/door data:
LAA5F:	.byte $02, $B1, $41, $80, $75, $51, $00, $7A, $01, $83, $45, $FF

;---------------------------------------[ Structure definitions ]------------------------------------

;The first byte of the structure definition states how many macros are in the first row of the
;structure. The the number of bytes after the macro number byte is equal to the value of the macro
;number byte and those bytes define what each macro in the row are. For example, if the macro number
;byte is #$08, the next 8 bytes represent 8 macros. The macro description bytes are the macro numbers
;and are multiplied by 4 to find the index to the desired macro in MacroDefs.  Any further bytes in
;the structure definition represent the next rows.  #$FF marks the end of the structure definition.

;Structure #$00
LAA6B:	.byte $08, $01, $01, $01, $01, $01, $01, $01, $01, $08, $00, $00, $00, $00, $00, $00
LAA7B:	.byte $00, $00, $FF

;Structure #$01
LAA7E:	.byte $08, $02, $02, $02, $02, $02, $02, $02, $02, $01, $1C, $01, $1C, $01, $1C, $08
LAA8E:	.byte $02, $02, $02, $02, $02, $02, $02, $02, $FF

;Structure #$02
LAA97:	.byte $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02, $04, $05, $02
LAAA7:	.byte $04, $05, $02, $04, $05, $02, $04, $05, $FF

;Structure #$03
LAAB0:	.byte $01, $06, $01, $06, $01, $06, $FF

;Structure #$04
LAAB7:	.byte $01, $07, $01, $07, $01, $07, $FF

;Structure #$05
LAABE:	.byte $02, $14, $15, $FF

;Structure #$06
LAAC2:	.byte $02, $17, $17, $02, $17, $1B, $02, $17, $1B, $02, $1B, $17, $02, $17, $17, $FF

;Structure #$07
LAAD2:	.byte $02, $1A, $17, $02, $17, $17, $02, $1B, $1A, $02, $17, $17, $02, $1A, $1B, $FF

;Structure #$08
LAAE2:	.byte $01, $18, $01, $18, $FF

;Structure #$09
LAAE7:	.byte $01, $19, $01, $19, $FF

;Structure #$0A
LAAEC:	.byte $01, $09, $FF

;Structure #$0B
LAAEF:	.byte $01, $0A, $FF

;Structure #$0C
LAAF2:	.byte $01, $1E, $01, $1A, $01, $1A, $01, $1A, $01, $1E, $FF

;Structure #$0D
LAAFD:	.byte $04, $17, $17, $17, $17, $FF

;Structure #$0E
LAB03:	.byte $03, $17, $1D, $17, $FF

;Structure #$0F
LAB08:	.byte $01, $0B, $01, $0B, $01, $0B, $01, $0B, $FF

;Structure #$10
LAB11:	.byte $04, $17, $17, $1B, $17, $04, $1B, $17, $17, $17, $04, $1B, $17, $1B, $1B, $04
LAB21:	.byte $17, $1B, $17, $17, $FF

;Structure #$11
LAB26:	.byte $01, $17, $FF

;Structure #$12
LAB29:	.byte $08, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $1E, $08, $1E, $1E, $1E, $1E, $1E, $1E
LAB39:	.byte $1E, $1E, $FF

;Structure #$13
LAB3C:	.byte $04, $0F, $0F, $0F, $0F, $04, $0F, $0F, $0F, $0F, $04, $0F, $0F, $0F, $0F, $04
LAB4C:	.byte $0F, $0F, $0F, $0F, $FF

;Structure #$14
LAB51:	.byte $02, $12, $12, $FF

;Structure #$15
LAB55:	.byte $08, $10, $10, $10, $10, $10, $10, $10, $10, $08, $10, $10, $10, $10, $10, $10
LAB65:	.byte $10, $10, $FF

;Structure #$16
LAB68:	.byte $02, $10, $10, $02, $10, $10, $02, $10, $10, $02, $10, $10, $FF

;Structure #$17
LAB75:	.byte $08, $13, $0E, $13, $0E, $0E, $13, $0E, $0E, $08, $0E, $0E, $13, $13, $0E, $0E
LAB85:	.byte $13, $13, $FF

;Structure #$18
LAB88:	.byte $08, $11, $11, $11, $11, $11, $11, $11, $11, $08, $11, $11, $11, $11, $11, $11
LAB98:	.byte $11, $11, $FF

;Structure #$19
LAB9B:	.byte $04, $11, $11, $11, $11, $04, $11, $11, $11, $11, $04, $11, $11, $11, $11, $04
LABAB:	.byte $11, $11, $11, $11, $FF

;Structure #$1A
LABB0:	.byte $08, $20, $22, $22, $22, $22, $22, $22, $22, $FF

;Structure #$1B
LABBA:	.byte $01, $1F, $FF

;Structure #$1C
LABBD:	.byte $01, $21, $01, $21, $01, $21, $FF

;Structure #$1D
LABC4:	.byte $08, $23, $23, $23, $23, $23, $23, $23, $23, $08, $23, $24, $24, $24, $24, $24
LABD4:	.byte $24, $23, $08, $23, $23, $23, $23, $23, $23, $23, $23, $FF

;Structure #$1E
LABE0:	.byte $01, $23, $01, $23, $01, $23, $01, $23, $FF

;Structure #$1F
LABE9:	.byte $04, $23, $23, $23, $23, $04, $23, $24, $24, $23, $04, $23, $24, $24, $23, $04
LABF9:	.byte $23, $23, $23, $23, $FF

;Structure #$20
LABFE:	.byte $01, $25, $FF

;Structure #$21
LAC01:	.byte $01, $26, $01, $26, $01, $26, $01, $26, $FF

;Structure #$22
LAC0A:	.byte $03, $27, $27, $27, $FF

;Structure #$23
LAC0F:	.byte $03, $28, $28, $28, $FF

;Structure #$24
LAC14:	.byte $08, $13, $13, $13, $13, $13, $13, $13, $13, $FF

;Structure #$25
LAC1E:	.byte $01, $13, $01, $13, $01, $13, $01, $13, $FF

;Structure #$26
LAC27:	.byte $04, $0C, $0C, $0C, $0C, $04, $0D, $0D, $0D, $0D, $FF


;----------------------------------------[ Macro definitions ]---------------------------------------

;The macro definitions are simply index numbers into the pattern tables that represent the 4 quadrants
;of the macro definition. The bytes correspond to the following position in order: lower right tile,
;lower left tile, upper right tile, upper left tile. 

MacroDefs:

LAC32:	.byte $F1, $F1, $F1, $F1
LAC36:	.byte $FF, $FF, $F0, $F0
LAC3A:	.byte $64, $64, $64, $64
LAC3E:	.byte $FF, $FF, $64, $64
LAC42:	.byte $A4, $FF, $A4, $FF
LAC46:	.byte $FF, $A5, $FF, $A5
LAC4A:	.byte $A0, $A0, $A0, $A0
LAC4E:	.byte $A1, $A1, $A1, $A1
LAC52:	.byte $4F, $4F, $4F, $4F
LAC56:	.byte $84, $85, $86, $87
LAC5A:	.byte $88, $89, $8A, $8B
LAC5E:	.byte $80, $81, $82, $83
LAC62:	.byte $FF, $FF, $BA, $BA
LAC66:	.byte $BB, $BB, $BB, $BB
LAC6A:	.byte $10, $11, $12, $13
LAC6E:	.byte $04, $05, $06, $07
LAC72:	.byte $14, $15, $16, $17
LAC76:	.byte $1C, $1D, $1E, $1F
LAC7A:	.byte $09, $09, $09, $09
LAC7E:	.byte $0C, $0D, $0E, $0F
LAC82:	.byte $FF, $FF, $59, $5A
LAC86:	.byte $FF, $FF, $5A, $5B
LAC8A:	.byte $51, $52, $53, $54
LAC8E:	.byte $55, $56, $57, $58
LAC92:	.byte $EC, $FF, $ED, $FF
LAC96:	.byte $FF, $EE, $FF, $EF
LAC9A:	.byte $45, $46, $45, $46
LAC9E:	.byte $4B, $4C, $4D, $50
LACA2:	.byte $FF, $FF, $FF, $FF
LACA6:	.byte $47, $48, $47, $48
LACAA:	.byte $08, $08, $08, $08
LACAE:	.byte $70, $71, $72, $73
LACB2:	.byte $74, $75, $76, $77
LACB6:	.byte $E0, $E1, $E2, $E3
LACBA:	.byte $E4, $E5, $E6, $E7
LACBE:	.byte $20, $21, $22, $23
LACC2:	.byte $25, $25, $24, $24
LACC6:	.byte $78, $79, $7A, $7B
LACCA:	.byte $E8, $E9, $EA, $EB
LACCE:	.byte $26, $27, $28, $29
LACD2:	.byte $2A, $2B, $2C, $2D

;Not used.
LACD6:	.byte $0D, $1E, $07, $21, $1D, $0D, $0D, $0D, $1E, $21, $07, $21, $21, $15, $14, $15
LACE6:	.byte $21, $21, $07, $0D, $21, $16, $10, $16, $21, $0D, $07, $1F, $0D, $20, $10, $1F
LACF6:	.byte $0D, $20, $FF, $08, $22, $22, $0D, $22, $22, $1E, $1C, $1D, $08, $1C, $1C, $21
LAD06:	.byte $1C, $1C, $21, $1C, $21, $08, $1C, $1C, $0C, $1C, $1C, $1F, $0D, $20, $07, $1C
LAD16:	.byte $1C, $21, $1C, $1C, $1C, $14, $04, $1C, $14, $0D, $14, $03, $1C, $1C, $15, $FF
LAD26:	.byte $02, $01, $01, $02, $00, $00, $FF, $01, $16, $01, $21, $01, $21, $01, $0C, $01
LAD36:	.byte $21, $01, $0D, $01, $21, $FF, $01, $0C, $FF, $07, $22, $22, $22, $22, $22, $22
LAD46:	.byte $22, $FF, $05, $0B, $1D, $22, $0D, $22, $04, $11, $21, $11, $21, $04, $11, $21
LAD56:	.byte $11, $0D, $03, $11, $21, $11, $03, $23, $23, $23, $FF, $03, $19, $1B, $1A, $FF
LAD66:	.byte $01, $34, $01, $34, $FF, $08, $1D, $22, $17, $0D, $1E, $0D, $17, $0D, $08, $0D
LAD76:	.byte $22, $17, $20, $21, $14, $0D, $11, $08, $21, $1D, $22, $17, $20, $10, $10, $21
LAD86:	.byte $08, $21, $1F, $17, $0D, $22, $0D, $1E, $11, $08, $0D, $14, $10, $1F, $22, $22
LAD96:	.byte $20, $11, $FF, $08, $17, $17, $0D, $17, $17, $0D, $17, $17, $08, $0D, $17, $17
LADA6:	.byte $17, $17, $17, $17, $0D, $FF, $08, $18, $1D, $17, $1E, $1D, $17, $17, $1E, $08
LADB6:	.byte $18, $21, $1C, $21, $21, $1C, $1C, $21, $08, $0D, $20, $1C, $1F, $20, $1C, $1C
LADC6:	.byte $1F, $FF, $04, $0D, $0D, $0D, $0D, $04, $18, $18, $18, $18, $04, $18, $18, $18
LADD6:	.byte $18, $04, $18, $18, $18, $18, $FF, $07, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $07
LADE6:	.byte $0D, $17, $17, $17, $17, $17, $0D, $07, $18, $0A, $10, $0A, $0A, $10, $18, $07
LADF6:	.byte $0D, $17, $17, $17, $17, $17, $0D, $FF, $01, $0A, $01, $0A, $01, $0A, $01, $0A
LAE06:	.byte $01, $0A, $01, $0A, $01, $0A, $01, $0A, $FF, $01, $0D, $01, $18, $01, $18, $01
LAE16:	.byte $18, $01, $18, $FF, $02, $19, $1A, $FF, $01, $0D, $FF, $04, $14, $1C, $1C, $14
LAE26:	.byte $04, $0A, $0A, $0A, $0A, $FF, $08, $0D, $22, $22, $22, $22, $22, $22, $0D, $FF
LAE36:	.byte $08, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $08, $0E, $10, $0E, $0E, $10, $10
LAE46:	.byte $0E, $10, $FF, $A7, $A7, $A7, $A7, $FF, $FF, $A6, $A6, $A2, $A2, $FF, $FF, $FF
LAE56:	.byte $FF, $A3, $A3, $A4, $FF, $A4, $FF, $FF, $A5, $FF, $A5, $FF, $79, $FF, $7E, $4F
LAE66:	.byte $4F, $4F, $4F, $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $04, $05, $06, $07, $10
LAE76:	.byte $11, $12, $13, $00, $01, $02, $03, $08, $08, $08, $08, $18, $19, $1A, $1B, $1C
LAE86:	.byte $1D, $1E, $1F, $0C, $0D, $0E, $0F, $09, $09, $09, $09, $7A, $7B, $7F, $5A, $2A
LAE96:	.byte $2C, $FF, $FF, $14, $15, $16, $17, $20, $21, $22, $23, $24, $25, $20, $21, $28
LAEA6:	.byte $28, $29, $29, $26, $27, $26, $27, $2A, $2B, $FF, $FF, $2B, $2C, $FF, $FF, $2B
LAEB6:	.byte $2B, $FF, $FF, $FF, $FF, $FF, $FF, $31, $32, $33, $34, $35, $36, $37, $38, $3D
LAEC6:	.byte $3E, $3F, $40, $41, $42, $43, $44, $39, $3A, $39, $3A, $3B, $3B, $3C, $3C, $0B
LAED6:	.byte $0B, $2D, $2E, $2F, $30, $0B, $0B, $50, $51, $52, $53, $54, $55, $54, $55, $56
LAEE6:	.byte $57, $58, $59, $FF, $FF, $FF, $5E, $5B, $5C, $5F, $60, $FF, $FF, $61, $FF, $5D
LAEF6:	.byte $62, $67, $68, $63, $64, $69, $6A, $65, $66, $6B, $6C, $6D, $6E, $73, $74, $6F
LAF06:	.byte $70, $75, $76, $71, $72, $77, $78, $45, $46, $47, $48, $FF, $98, $FF, $98, $49
LAF16:	.byte $4A, $4B, $4C, $90, $91, $90, $91, $7C, $7D, $4D, $FF, $1C, $1D, $1E, $17, $18
LAF26:	.byte $19, $1A, $1F, $20, $21, $22, $60, $61, $62, $63, $0E, $0F, $FF, $FF, $0C, $0D
LAF36:	.byte $0D, $0D, $10, $0D, $FF, $10, $10, $FF, $FF, $FF, $FF, $FF, $FF, $30, $FF, $33
LAF46:	.byte $FF, $36, $FF, $39, $FF, $3D, $FF, $FF, $31, $32, $34, $35, $37, $38, $3A, $3B
LAF56:	.byte $3E, $3F, $3C, $41, $40, $42, $84, $85, $86, $87, $80, $81, $82, $83, $88, $89
LAF66:	.byte $8A, $8B, $45, $46, $45, $46, $47, $48, $48, $47, $5C, $5D, $5E, $5F, $B8, $B8
LAF76:	.byte $B9, $B9, $74, $75, $75, $74, $C1, $13, $13, $13, $36, $BE, $BC, $BD, $BF, $14
LAF86:	.byte $15, $14, $C0, $14, $C0, $16, $FF, $C1, $FF, $FF, $C2, $14, $FF, $FF, $30, $13
LAF96:	.byte $BC, $BD, $13, $14, $15, $16, $D7, $D7, $D7, $D7, $76, $76, $76, $76, $FF, $FF
LAFA6:	.byte $BA, $BA, $BB, $BB, $BB, $BB, $00, $01, $02, $03, $04, $05, $06, $07, $FF, $FF
LAFB6:	.byte $08, $09, $FF, $FF, $09, $0A, $55, $56, $57, $58, $90, $91, $92, $93, $4B, $4C
LAFC6:	.byte $4D, $50, $51, $52, $53, $54, $70, $71, $72, $73, $8C, $8D, $8E, $8F, $11, $12
LAFD6:	.byte $FF, $11, $11, $12, $12, $11, $11, $12, $12, $FF, $C3, $C4, $C5, $C6, $30, $00
LAFE6:	.byte $BC, $BD, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $D4, $90, $91, $92, $93, $20, $20
LAFF6:	.byte $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0

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

RidleyTriangleIndexData:
LB000:	.byte $B6			;1 3/16 seconds
LB001:	.byte $20			;E3
LB002:	.byte $B2			;3/8 seconds
LB003:	.byte $28			;Ab3
LB004:	.byte $B3			;3/4 seconds
LB005:	.byte $2C			;A#3
LB006:	.byte $34			;D4
LB007:	.byte $B4			;1 1/2 seconds
LB008:	.byte $30			;C4
LB009:	.byte $30			;C4
LB00A:	.byte $B3			;3/4 seconds
LB00B:	.byte $3C			;F#4
LB00C:	.byte $38			;E4
LB00D:	.byte $30			;C4
LB00E:	.byte $28			;Ab3
LB00F:	.byte $B4			;1 1/2 seconds
LB010:	.byte $24			;F#3
LB011:	.byte $24			;F#3
LB012:	.byte $1E			;D#3
LB013:	.byte $B3			;3/4 seconds
LB014:	.byte $2A			;A3
LB015:	.byte $26			;G3
LB016:	.byte $B4			;1 1/2 seconds
LB017:	.byte $2E			;B3
LB018:	.byte $2E			;B3
LB019:	.byte $B3			;3/4 seconds
LB01A:	.byte $32			;C#4
LB01B:	.byte $36			;D#4
LB01C:	.byte $2E			;B3
LB01D:	.byte $32			;C#4
LB01E:	.byte $B4			;1 1/2 seconds
LB01F:	.byte $2A			;A3
LB020:	.byte $2A			;A3
LB021:	.byte $00			;End Ridley area music.

RidleySQ1IndexData:
LB022:	.byte $BA			;3/64 seconds
LB023:	.byte $02			;No sound
LB024:	.byte $D0			;
LB025:	.byte $B1			;3/16 seconds	+
LB026:	.byte $3C			;F#4		|
LB027:	.byte $40			;Ab4		| Repeat 16 times
LB028:	.byte $44			;A#4		|
LB029:	.byte $40			;Ab4		+
LB02A:	.byte $FF			;
LB02B:	.byte $D0			;
LB02C:	.byte $42			;A4		+
LB02D:	.byte $46			;B4		| Repeat 16 times
LB02E:	.byte $4A			;C#5		|
LB02F:	.byte $46			;B4		+
LB030:	.byte $FF			;

RidleySQ2IndexData:
LB031:	.byte $D0			;
LB032:	.byte $B1			;3/16 seconds	+
LB033:	.byte $44			;A#4		|
LB034:	.byte $48			;C5		| Repeat 16 times
LB035:	.byte $4C			;D5		|
LB036:	.byte $48			;C5		+
LB037:	.byte $FF			;
LB038:	.byte $D0			;
LB039:	.byte $4A			;C#5		+
LB03A:	.byte $4E			;D#5		| Repeat 16 times
LB03B:	.byte $52			;F5		|
LB03C:	.byte $4E			;D#5		+
LB03D:	.byte $FF			;
LB03E:	.byte $00			;End Ridley area music.

KraidSQ1IndexData:
LB03F:	.byte $B8			;11/64 seconds
LB040:	.byte $02			;No sound

;SQ1 music data runs down into the SQ2 music data.
KraidSQ2IndexData:
LB041:	.byte $C4			;
LB042:	.byte $B3			;1/2 seconds	+
LB043:	.byte $38			;E4		|
LB044:	.byte $B2			;1/4 seconds	|
LB045:	.byte $2E			;B3		|
LB046:	.byte $B3			;1/2 seconds	|
LB047:	.byte $42			;A4		|
LB048:	.byte $B2			;1/4 seconds	|
LB049:	.byte $30			;C4		| Repeat 4 times
LB04A:	.byte $B3			;1/2 seconds	|
LB04B:	.byte $3C			;F#4		|
LB04C:	.byte $B2			;1/4 seconds	|
LB04D:	.byte $34			;D4		|
LB04E:	.byte $B3			;1/2 seconds	|
LB04F:	.byte $2E			;B3		|
LB050:	.byte $B2			;1/4 seconds	|
LB051:	.byte $2C			;A#3		+
LB052:	.byte $FF			;
LB053:	.byte $C2			;
LB054:	.byte $B3			;1/2 seconds	+
LB055:	.byte $3E			;G4		|
LB056:	.byte $B2			;1/4 seconds	|
LB057:	.byte $34			;D4		|
LB058:	.byte $B3			;1/2 seconds	|
LB059:	.byte $38			;E4		|
LB05A:	.byte $B2			;1/4 seconds	|
LB05B:	.byte $2E			;B3		| Repeat 2 times
LB05C:	.byte $B3			;1/2 seconds	|
LB05D:	.byte $3C			;F#4		|
LB05E:	.byte $B2			;1/4 seconds	|
LB05F:	.byte $34			;D4		|
LB060:	.byte $B3			;1/2 seconds	|
LB061:	.byte $42			;A4		|
LB062:	.byte $B2			;1/4 seconds	|
LB063:	.byte $38			;E4		+
LB064:	.byte $FF			;
LB065:	.byte $C4			;
LB066:	.byte $B1			;1/8 seconds	+
LB067:	.byte $3E			;G4		|
LB068:	.byte $2E			;B3		|
LB069:	.byte $3E			;G4		|
LB06A:	.byte $2E			;B3		|
LB06B:	.byte $3E			;G4		|
LB06C:	.byte $2E			;B3		|
LB06D:	.byte $44			;A#4		|
LB06E:	.byte $38			;E4		|
LB06F:	.byte $44			;A#4		|
LB070:	.byte $38			;E4		|
LB071:	.byte $44			;A#4		| Repeat 4 times
LB072:	.byte $38			;E4		|
LB073:	.byte $42			;A4		|
LB074:	.byte $30			;C4		|
LB075:	.byte $42			;A4		|
LB076:	.byte $30			;C4		|
LB077:	.byte $42			;A4		|
LB078:	.byte $30			;C4		|
LB079:	.byte $42			;A4		|
LB07A:	.byte $36			;D#4		|
LB07B:	.byte $3C			;F#4		|
LB07C:	.byte $36			;D#4		|
LB07D:	.byte $46			;B4		|
LB07E:	.byte $36			;D#4		+
LB07F:	.byte $FF			;
LB080:	.byte $C2			;
LB081:	.byte $3C			;F#4		+
LB082:	.byte $3E			;G4		|
LB083:	.byte $42			;A4		|
LB084:	.byte $46			;B4		|
LB085:	.byte $4C			;D5		|
LB086:	.byte $46			;B4		|
LB087:	.byte $54			;F#5		|
LB088:	.byte $4C			;D5		|
LB089:	.byte $42			;A4		|
LB08A:	.byte $3E			;G4		|
LB08B:	.byte $3C			;F#4		| Repeat 2 times
LB08C:	.byte $46			;B4		|
LB08D:	.byte $5A			;A5		|
LB08E:	.byte $54			;F#5		|
LB08F:	.byte $4C			;D5		|
LB090:	.byte $42			;A4		|
LB091:	.byte $3E			;G4		|
LB092:	.byte $3C			;F#4		|
LB093:	.byte $38			;E4		|
LB094:	.byte $3E			;G4		|
LB095:	.byte $42			;A4		|
LB096:	.byte $4C			;D5		|
LB097:	.byte $50			;E5		|
LB098:	.byte $02			;No sound	+
LB099:	.byte $FF			;
LB09A:	.byte $C4			;
LB09B:	.byte $B1			;1/8 seconds	+
LB09C:	.byte $5A			;A5		|
LB09D:	.byte $02			;No sound	|
LB09E:	.byte $56			;G5		|
LB09F:	.byte $02			;No sound	|
LB0A0:	.byte $54			;F#5		|
LB0A1:	.byte $02			;No sound	| Repeat 4 times
LB0A2:	.byte $50			;E5		|
LB0A3:	.byte $02			;No sound	|
LB0A4:	.byte $54			;F#5		|
LB0A5:	.byte $02			;No sound	|
LB0A6:	.byte $56			;G5		|
LB0A7:	.byte $02			;No sound	+
LB0A8:	.byte $FF			;
LB0A9:	.byte $00			;End Kraid area music.

KraidTriangleIndexData:
LB0AA:	.byte $D0			;
LB0AB:	.byte $B2			;1/4 seconds	+
LB0AC:	.byte $20			;E3		| Repeat 16 times
LB0AD:	.byte $B3			;1/2 seconds	|
LB0AE:	.byte $38			;E4		+
LB0AF:	.byte $FF			;
LB0B0:	.byte $C2			;
LB0B1:	.byte $B2			;1/4 seconds	+
LB0B2:	.byte $18			;C3		|
LB0B3:	.byte $B3			;1/2 seconds	|
LB0B4:	.byte $30			;C4		|
LB0B5:	.byte $B2			;1/4 seconds	|
LB0B6:	.byte $18			;C3		|
LB0B7:	.byte $B3			;1/2 seconds	|
LB0B8:	.byte $30			;C4		| Repeat 2 times
LB0B9:	.byte $B2			;1/4 seconds	|
LB0BA:	.byte $1C			;D3		|
LB0BB:	.byte $B3			;1/2 seconds	|
LB0BC:	.byte $34			;D4		|
LB0BD:	.byte $B2			;1/4 seconds	|
LB0BE:	.byte $1C			;D3		|
LB0BF:	.byte $B3			;1/2 seconds	|
LB0C0:	.byte $34			;D4		+
LB0C1:	.byte $FF			;
LB0C2:	.byte $C4			;
LB0C3:	.byte $B2			;1/4 seconds	+
LB0C4:	.byte $20			;E3		|
LB0C5:	.byte $38			;E4		|
LB0C6:	.byte $50			;E5		|
LB0C7:	.byte $24			;F#3		|
LB0C8:	.byte $3C			;F#4		| Repeat 4 times
LB0C9:	.byte $54			;F#5		|
LB0CA:	.byte $22			;F3		|
LB0CB:	.byte $3A			;F4		|
LB0CC:	.byte $52			;F5		|
LB0CD:	.byte $16			;B2		|
LB0CE:	.byte $2E			;B3		|
LB0CF:	.byte $46			;B4		+
LB0D0:	.byte $FF			;
LB0D1:	.byte $C2			;
LB0D2:	.byte $B3			;1/2 seconds	+
LB0D3:	.byte $20			;E3		|
LB0D4:	.byte $B2			;1/4 seconds	|
LB0D5:	.byte $2E			;B3		|
LB0D6:	.byte $B3			;1/2 seconds	|
LB0D7:	.byte $30			;C4		|
LB0D8:	.byte $B2			;1/4 seconds	|
LB0D9:	.byte $2E			;B3		| Repeat 2 times
LB0DA:	.byte $B3			;1/2 seconds	|
LB0DB:	.byte $18			;C3		|
LB0DC:	.byte $B2			;1/4 seconds	|
LB0DD:	.byte $26			;G3		|
LB0DE:	.byte $B3			;1/2 seconds	|
LB0DF:	.byte $2A			;A3		|
LB0E0:	.byte $B2			;1/4 seconds	|
LB0E1:	.byte $2E			;B3		+
LB0E2:	.byte $FF			;
LB0E3:	.byte $C8			;
LB0E4:	.byte $B4			;1 second	+ Repeat 8 times
LB0E5:	.byte $08			;E2		+
LB0E6:	.byte $FF			;

;Not used.
LB0E7:	.byte $2A, $2A, $2A, $B9, $2A, $2A, $2A, $B2, $2A, $2A, $2A, $2A, $2A, $B9, $2A, $12
LB0F7:	.byte $2A, $B2, $26, $B9, $0E, $26, $26, $B2, $26, $B9, $0E, $26, $26, $B2, $22, $B9
LB107:	.byte $0A, $22, $22, $B2, $22, $B9, $0A, $22, $22, $B2, $20, $20, $B9, $20, $20, $20
LB117:	.byte $B2, $20, $B9, $34, $30, $34, $38, $34, $38, $3A, $38, $3A, $3E, $3A, $3E, $FF
LB127:	.byte $C2, $B2, $18, $30, $18, $30, $18, $30, $18, $30, $22, $22, $B1, $22, $22, $B2
LB137:	.byte $22, $20, $1C, $18, $16, $14, $14, $14, $2C, $2A, $2A, $B9, $2A, $2A, $2A, $B2
LB147:	.byte $2A, $28, $28, $B9, $28, $28, $28, $B2, $28, $26, $26, $B9, $26, $26, $3E, $26
LB157:	.byte $26, $3E, $FF, $F0, $B2, $01, $04, $01, $04, $FF, $E0, $BA, $2A, $1A, $02, $3A
LB167:	.byte $40, $02, $1C, $2E, $38, $2C, $3C, $38, $02, $40, $44, $46, $02, $1E, $02, $2C
LB177:	.byte $38, $46, $26, $02, $3A, $20, $02, $28, $2E, $02, $18, $44, $02, $46, $48, $4A
LB187:	.byte $4C, $02, $18, $1E, $FF, $B8, $02, $C8, $B0, $0A, $0C, $FF, $C8, $0E, $0C, $FF
LB197:	.byte $C8, $10, $0E, $FF, $C8, $0E, $0C, $FF, $00, $2B, $3B, $1B, $5A, $D0, $D1, $C3
LB1A7:	.byte $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30, $98, $CF
LB1B7:	.byte $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60, $70, $FC
LB1C7:	.byte $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00
LB1D7:	.byte $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B, $03, $03
LB1E7:	.byte $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C, $3C, $18
LB1F7:	.byte $30, $E8, $E8, $C8, $90, $60, $00, $00, $00

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

;----------------------------------[ Sound Engine Entry Point ]-----------------------------------
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

;Kraid area music.
LBD58:	.byte $00, $FF, $F0, $00, $00
LBD5D:	.word $B03F, $B041, $B0AA, $0000

;Item room music.
LBD65:	.byte $0B, $FF, $03, $00, $00
LBD6A:	.word $BDDA, $BDDC, $BDCD, $0000

;Ridley area music.
LBD72:	.byte $0B, $FF, $F0, $01, $01
LBD77:	.word $B022, $B031, $B000, $0000

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

;Brinstar music(not used this memory page).
LBDB3:	.byte $0B, $FF, $00, $02, $03
LBDB8:	.word $0100, $0300, $0500, $0700

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

;The following data is a repeat of the above routine and is not used.

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

;The following data is not used. 

LBFD5: 	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00
LBFE5: 	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LBFF5:	.byte $00, $00, $00, $00, $00

;----------------------------------------[ Interrupt vectors ]--------------------------------------

LBFFA: 	.word NMI			;($C0D9)NMI vector.
LBFFC:	.word RESET			;($FFB0)Reset vector.
LBFFE: 	.word RESET			;($FFB0)IRQ vector.