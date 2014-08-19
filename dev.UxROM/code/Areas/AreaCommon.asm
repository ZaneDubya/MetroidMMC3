; METROID source code
; (C) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, 
;      GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Can be reassembled using Ophis.

;Area ROM Bank Common Routines & Data ($8000 - $8D60)

.require "../Defines.asm"
.require "../GameEngineDeclarations.asm"

;-----------------------------------------[ Start of code ]------------------------------------------
; The CommonJump table. Area code will JMP/JSR directly to this table.
; Name / Address JMP/JSR to.        ; JMP/JSR?  Area?   Description      
CommonJump_UnknownUpdateAnim0:      ; JMP       All     UpdateEnemyAnim, followed 
    JMP $F410                       ;                   by call to $8058
CommonJump_UnknownUpdateAnim1:      ; JMP       All     UpdateEnemyAnim, followed 
    JMP $F438                       ;                   by call to $F416
CommonJump_Unknown06:               ; JMP       All     ??????
    JMP $F416                       ; 
CommonJump_Unknown09:               ; JSR       BKNR    Get a random value, using EnIndex (X)
    JMP $F852                       ;                   and current NES frame (0-255)
CommonJump_UpdateEnemyAnim:         ; JSR       BKNR    Advance to next frame 
    JMP UpdateEnemyAnim             ;                   of enemy's animation.
CommonJump_ResetAnimIndex:          ; Both      BKNR    ??????
    JMP $F68D                       ;
CommonJump_Unused12:                ; N/A       None    Not used by any Area code.
    JMP $F83E                       ;
CommonJump_Unused15:                ; N/A       None    Not used by any Area code.
    JMP $F85A                       ;
CommonJump_Unused18:                ; N/A       None    Not used by any Area code.
    JMP $FBB9                       ;
CommonJump_Unknown1B:               ; JSR       BKNR    ??????
    JMP $FB88                       ;
CommonJump_Unknown1E:               ; JSR       BKNR    ??????
    JMP $FBCA                       ;
CommonJump_Unknown21:               ; Both      NR      ??????
    JMP $F870                       ;
CommonJump_ChooseRoutine:           ; JSR       All     Calls ChooseRoutine in GameEngine
    JMP ChooseRoutine               ; 
CommonJump_Unknown27:               ; JSR       All     ??????
    JMP $FD8F                       ;
CommonJump_Unknown2A:               ; Both      All     ??????    
    JMP $EB6E                       ;
CommonJump_Unknown2D:               ; JSR       BK      ??????
    JMP $8244                       ;
CommonJump_Unknown30:               ; JSR       BK      ??????
    JMP $8318                       ;
CommonJump_EnemyBGCollision:        ; JSR       BK      ??????
    JMP $FA1E                       ;
CommonJump_Unknown36:               ; JSR       BKNR    ??????    
    JMP $833F                       ;
CommonJump_Unknown39:               ; JSR       BKNR    ??????    
    JMP $8395                       ;
CommonJump_Unknown3C:               ; JSR       T       ??????
    JMP $DD8B                       ;
CommonJump_DrawTileBlast:           ; JSR       T       Calls DrawTileBlast
    JMP DrawTileBlast               ; 
CommonJump_SubtractHealth:          ; JSR       T       Calls SubtractHealth
    JMP SubtractHealth              ; 
CommonJump_Base10Subtract:          ; JSR       T       Calls Base10Subtract
    JMP Base10Subtract              ; 

; These are the addresses of four common routines (minus one). These routines
; are called by pushing the address onto the stack, and then executing RTS. An
; example of this calling scheme can be seen at $9AE2 in the Brinstar ROM bank.
; Each address is repeated one time, in this order: A B C C B A D D
L8048:  .word $84FD, $84A6, $844A, $844A, $84A6, $84FD, $83F4, $83F4

L8058:  LDX PageIndex                   ;   X = Index of object we are working on ($00, $10, $20 ... $f0)
L805A:  LDA EnData05,X                  ;   A = EnData05 of object X.       
L805D:  ASL                             ;   if (A & $40 == $40) 
L805E:  BMI ++++++++                    ;       { rts }
L8060:  LDA EnStatus,X                  ;   A = EnStatus of object X. 
L8063:  CMP #$02                        ;   if (A == 2) 
L8065:  BNE ++++++++                    ;       { rts }
L8067:  JSR $8244                       ;   ???
L806A:  LDA $00                         ;   A = Mem[$00] (set by $8244???)
L806C:  BPL ++                          ;   if (A & $80 == $80)
                                        ;   {
L806E:  JSR TwosCompliment              ;       A = $100 - A 
L8071:  STA $66                         ;       Mem[$66] = A
                                        ;       while (Mem[$66] != 0)
                                        ;       {
L8073:* JSR $83F5                       ;           ???
L8076:  JSR $80B8                       ;           ???
L8079:  DEC $66                         ;           Mem[$66]--
L807B:  BNE -                           ;       }
                                        ;       ; Because Mem[$66] == 0, we skip the next loop.
                                        ;   }
L807D:* BEQ ++                          ;   else if (A != 0)
                                        ;   {
L807F:  STA $66                         ;       Mem[$66] = A
                                        ;       while (Mem[$66] != 0)
                                        ;       {
L8081:* JSR $844B                       ;           ???    
L8084:  JSR $80FB                       ;           ???
L8087:  DEC $66                         ;           Mem[$66]--
                                        ;       }
L8089:  BNE -                           ;   }
L808B:* JSR $8318                       ;   ???
L808E:  LDA $00                         ;   A == Mem[$00] (set by $8318???)
L8090:  BPL ++                          ;   if (A & $80 == $80)
                                        ;   {
L8092:  JSR TwosCompliment              ;       A = $100 - A 
L8095:  STA $66                         ;       Mem[$66] = A
                                        ;       while (Mem[$66] != 0)
                                        ;       {
L8097:* JSR $84A7                       ;           ???    
L809A:  JSR $816E                       ;           ???
L809D:  DEC $66                         ;           Mem[$66]--
L809F:  BNE -                           ;       }
                                        ;       ; Because Mem[$66] == 0, we skip the next loop.
                                        ;   }
L80A1:* BEQ ++                          ;   else if (A != 0)
                                        ;   {
L80A3:  STA $66                         ;       Mem[$66] = A
                                        ;       while (Mem[$66] != 0)
                                        ;       {
L80A5:* JSR $84FE                       ;           ???
L80A8:  JSR $8134                       ;           ???
L80AB:  DEC $66                         ;           Mem[$66]--
L80AD:  BNE -                           ;       }
                                        ;   }
L80AF:* RTS                             ;   rts


L80B0:  LDY EnDataIndex,X               
L80B3:  LDA $977B,Y
L80B6:  ASL                             ;*2 
L80B7:  RTS

L80B8:  LDX PageIndex
L80BA:  BCS $80FA
L80BC:  LDA EnData05,X
L80BF:  BPL $80C7
L80C1:  JSR $81FC
L80C4:  JMP $80F6
L80C7:  JSR $80B0
L80CA:  BPL $80EA
L80CC:  LDA $6B03,X
L80CF:  BEQ $80C1
L80D1:  BPL $80D8
L80D3:  JSR $81B1
L80D6:  BEQ $80E2
L80D8:  SEC 
L80D9:  ROR $0402,X
L80DC:  ROR EnCounter,X
L80DF:  JMP $80F6
L80E2:  STA $0402,X
L80E5:  STA EnCounter,X
L80E8:  BEQ $80F6
L80EA:  LDA $977B,Y
L80ED:  LSR 
L80EE:  LSR 
L80EF:  BCC $80F6
L80F1:  LDA #$04
L80F3:  JSR $856B
L80F6:  LDA #$01
L80F8:  STA $66
L80FA:  RTS
 
L80FB:  LDX PageIndex
L80FD:  BCS $8133
L80FF:  LDA EnData05,X
L8102:  BPL $810A
L8104:  JSR $81FC
L8107:  JMP $812F
L810A:  JSR $80B0
L810D:  BPL $8123
L810F:  LDA $6B03,X
L8112:  BEQ $8104
L8114:  BPL $8120
L8116:  CLC 
L8117:  ROR $0402,X
L811A:  ROR EnCounter,X
L811D:  JMP $812F
L8120:  JSR $81B1
L8123:  LDA $977B,Y
L8126:  LSR 
L8127:  LSR 
L8128:  BCC $812F
L812A:  LDA #$04
L812C:  JSR $856B
L812F:  LDA #$01
L8131:  STA $66
L8133:  RTS
 
L8134:  LDX PageIndex
L8136:  BCS $816D
L8138:  JSR $80B0
L813B:  BPL $815E
L813D:  LDA EnData05,X
L8140:  BMI $8148
L8142:  JSR $81C7
L8145:  JMP $8169
L8148:  LDA $6B03,X
L814B:  BEQ $8142
L814D:  BPL $8159
L814F:  CLC 
L8150:  ROR $0403,X
L8153:  ROR $0407,X
L8156:  JMP $8169
L8159:  JSR $81C0
L815C:  BEQ $8169
L815E:  LDA $977B,Y
L8161:  LSR 
L8162:  BCC $8169
L8164:  LDA #$01
L8166:  JSR $856B
L8169:  LDA #$01
L816B:  STA $66
L816D:  RTS

L816E:  LDX PageIndex
L8170:  BCS $81B0
L8172:  JSR $80B0
L8175:  BPL $81A0
L8177:  LDA EnData05,X
L817A:  BMI $8182
L817C:  JSR $81C7
L817F:  JMP $81AC
L8182:  LDA $6B03,X
L8185:  BEQ $817C
L8187:  BPL $818E
L8189:  JSR $81C0
L818C:  BEQ $8198
L818E:  SEC 
L818F:  ROR $0403,X
L8192:  ROR $0407,X
L8195:  JMP $81AC
L8198:  STA $0403,X
L819B:  STA $0407,X
L819E:  BEQ $81AC
L81A0:  JSR $80B0
L81A3:  LSR 
L81A4:  LSR 
L81A5:  BCC $81AC
L81A7:  LDA #$01
L81A9:  JSR $856B
L81AC:  LDA #$01
L81AE:  STA $66
L81B0:  RTS
 
L81B1:  JSR $81B8
L81B4:  STA $6AFE,X
L81B7:  RTS

L81B8:  LDA #$20
L81BA:  JSR $F744
L81BD:  LDA #$00
L81BF:  RTS

L81C0:  JSR $81B8
L81C3:  STA $6AFF,X
L81C6:  RTS

L81C7:  JSR $81F6
L81CA:  BNE $81F5
L81CC:  LDA #$01
L81CE:  JSR $856B
L81D1:  LDA $6AFF,X
L81D4:  JSR $C3D4
L81D7:  STA $6AFF,X

L81DA:  JSR $81F6
L81DD:  BNE $81F5
L81DF:  JSR $80B0
L81E2:  SEC 
L81E3:  BPL $81ED
L81E5:  LDA #$00
L81E7:  SBC $0407,X
L81EA:  STA $0407,X
L81ED:  LDA #$00
L81EF:  SBC $0403,X
L81F2:  STA $0403,X
L81F5:  RTS

L81F6:  JSR $F74B
L81F9:  AND #$20
L81FB:  RTS

L81FC:  JSR $81F6
L81FF:  BNE $81F5
L8201:  LDA #$04
L8203:  JSR $856B
L8206:  LDA $6AFE,X
L8209:  JSR $C3D4
L820C:  STA $6AFE,X

L820F:  JSR $81F6
L8212:  BNE $822A
L8214:  JSR $80B0
L8217:  SEC 
L8218:  BPL $8222
L821A:  LDA #$00
L821C:  SBC EnCounter,X
L821F:  STA EnCounter,X
L8222:  LDA #$00
L8224:  SBC $0402,X
L8227:  STA $0402,X
L822A:  RTS 

L822B:  LDA EnData05,X
L822E:  BPL $8232
L8230:  LSR 
L8231:  LSR 
L8232:  LSR 
L8233:  LDA $0408,X
L8236:  ROL 
L8237:  ASL 
L8238:  TAY 
L8239:  LDA $96DB,Y
L823C:  STA $81
L823E:  LDA $96DC,Y
L8241:  STA $82
L8243:  RTS

Common8244:
L8244:  JSR $80B0
L8247:  BPL $824C
L8249:  JMP $833F
L824C:  LDA EnData05,X
L824F:  AND #$20
L8251:  EOR #$20
L8253:  BEQ $82A2
L8255:  JSR $822B
L8258:  LDY EnCounter,X
L825B:  LDA ($81),Y
L825D:  CMP #$F0
L825F:  BCC $827F
L8261:  CMP #$FA
L8263:  BEQ $827C
L8265:  CMP #$FB
L8267:  BEQ $82B0
L8269:  CMP #$FC
L826B:  BEQ $82B3
L826D:  CMP #$FD
L826F:  BEQ $82A5
L8271:  CMP #$FE
L8273:  BEQ $82DE
L8275:  LDA #$00
L8277:  STA EnCounter,X
L827A:  BEQ $8258
L827C:  JMP $8312
L827F:  SEC 
L8280:  SBC EnDelay,X
L8283:  BNE $8290
L8285:  STA EnDelay,X
L8288:  INY 
L8289:  INY 
L828A:  TYA 
L828B:  STA EnCounter,X
L828E:  BNE $825B
L8290:  INC EnDelay,X
L8293:  INY 
L8294:  LDA ($81),Y
L8296:  ASL 
L8297:  PHP 
L8298:  JSR Adiv32                      ;($C2BE)Divide by 32.
L829B:  PLP 
L829C:  BCC $82A2
L829E:  EOR #$FF
L82A0:  ADC #$00
L82A2:  STA $00
L82A4:  RTS

L82A5:  INC EnCounter,X
L82A8:  INY 
L82A9:  LDA #$00
L82AB:  STA $6B01,X
L82AE:  BEQ $825B
L82B0:  PLA 
L82B1:  PLA 
L82B2:  RTS

L82B3:  LDA $6B03,X
L82B6:  BPL $82BE
L82B8:  JSR $E770
L82BB:  JMP $82C3
L82BE:  BEQ $82D2
L82C0:  JSR $E77B
L82C3:  LDX PageIndex
L82C5:  BCS $82D2
L82C7:  LDY EnCounter,X
L82CA:  INY 
L82CB:  LDA #$00
L82CD:  STA $6B03,X
L82D0:  BEQ $82D7
L82D2:  LDY EnCounter,X
L82D5:  DEY 
L82D6:  DEY 
L82D7:  TYA 
L82D8:  STA EnCounter,X
L82DB:  JMP $825B
L82DE:  DEY 
L82DF:  DEY 
L82E0:  TYA 
L82E1:  STA EnCounter,X
L82E4:  LDA $6B03,X
L82E7:  BPL $82EF
L82E9:  JSR $E770
L82EC:  JMP $82F4
L82EF:  BEQ $82FB
L82F1:  JSR $E77B
L82F4:  LDX PageIndex
L82F6:  BCC $82FB
L82F8:  JMP $8258
L82FB:  LDY EnDataIndex,X
L82FE:  LDA $968B,Y
L8301:  AND #$20
L8303:  BEQ $8312
L8305:  LDA EnData05,X
L8308:  EOR #$05
L830A:  ORA $968B,Y
L830D:  AND #$1F
L830F:  STA EnData05,X
L8312:  JSR $81B1
L8315:  JMP $82A2
L8318:  JSR $80B0
L831B:  BPL $8320
L831D:  JMP $8395
L8320:  LDA EnData05,X
L8323:  AND #$20
L8325:  EOR #$20
L8327:  BEQ $833C
L8329:  LDY EnCounter,X
L832C:  INY 
L832D:  LDA ($81),Y
L832F:  TAX 
L8330:  AND #$08
L8332:  PHP 
L8333:  TXA 
L8334:  AND #$07
L8336:  PLP 
L8337:  BEQ $833C
L8339:  JSR $C3D4
L833C:  STA $00
L833E:  RTS

L833F:  LDY #$0E
L8341:  LDA $6AFE,X
L8344:  BMI $835E
L8346:  CLC 
L8347:  ADC EnCounter,X
L834A:  STA EnCounter,X
L834D:  LDA $0402,X
L8350:  ADC #$00
L8352:  STA $0402,X
L8355:  BPL $8376
L8357:  JSR $C3D4
L835A:  LDY #$F2
L835C:  BNE $8376
L835E:  JSR $C3D4
L8361:  SEC 
L8362:  STA $00
L8364:  LDA EnCounter,X
L8367:  SBC $00
L8369:  STA EnCounter,X
L836C:  LDA $0402,X
L836F:  SBC #$00
L8371:  STA $0402,X
L8374:  BMI $8357
L8376:  CMP #$0E
L8378:  BCC $8383
L837A:  LDA #$00
L837C:  STA EnCounter,X
L837F:  TYA 
L8380:  STA $0402,X
L8383:  LDA $6AFC,X
L8386:  CLC 
L8387:  ADC EnCounter,X
L838A:  STA $6AFC,X
L838D:  LDA #$00
L838F:  ADC $0402,X
L8392:  STA $00
L8394:  RTS

L8395:  LDA #$00
L8397:  STA $00
L8399:  STA $02
L839B:  LDA #$0E
L839D:  STA $01
L839F:  STA $03
L83A1:  LDA $0407,X
L83A4:  CLC 
L83A5:  ADC $6AFF,X
L83A8:  STA $0407,X
L83AB:  STA $04
L83AD:  LDA #$00
L83AF:  LDY $6AFF,X
L83B2:  BPL $83B6
L83B4:  LDA #$FF
L83B6:  ADC $0403,X
L83B9:  STA $0403,X
L83BC:  TAY 
L83BD:  BPL $83D0
L83BF:  LDA #$00
L83C1:  SEC 
L83C2:  SBC $0407,X
L83C5:  STA $04
L83C7:  LDA #$00
L83C9:  SBC $0403,X
L83CC:  TAY 
L83CD:  JSR $E449
L83D0:  LDA $04
L83D2:  CMP $02
L83D4:  TYA 
L83D5:  SBC $03
L83D7:  BCC $83E3
L83D9:  LDA $00
L83DB:  STA $0407,X
L83DE:  LDA $01
L83E0:  STA $0403,X
L83E3:  LDA $6AFD,X
L83E6:  CLC 
L83E7:  ADC $0407,X
L83EA:  STA $6AFD,X
L83ED:  LDA #$00
L83EF:  ADC $0403,X
L83F2:  STA $00
L83F4:  RTS

L83F5:  LDX PageIndex
L83F7:  LDA EnYRoomPos,X
L83FA:  SEC 
L83FB:  SBC EnRadY,X
L83FE:  AND #$07
L8400:  SEC 
L8401:  BNE $8406
L8403:  JSR $E770
L8406:  LDY #$00
L8408:  STY $00
L840A:  LDX PageIndex
L840C:  BCC $844A
L840E:  INC $00
L8410:  LDY EnYRoomPos,X
L8413:  BNE $8429
L8415:  LDY #$F0
L8417:  LDA $49
L8419:  CMP #$02
L841B:  BCS $8429
L841D:  LDA $FC
L841F:  BEQ $844A
L8421:  JSR $8563
L8424:  BEQ $844A
L8426:  JSR $855A
L8429:  DEY 
L842A:  TYA 
L842B:  STA EnYRoomPos,X
L842E:  CMP EnRadY,X
L8431:  BNE $8441
L8433:  LDA $FC
L8435:  BEQ $843C
L8437:  JSR $8563
L843A:  BNE $8441
L843C:  INC EnYRoomPos,X
L843F:  CLC 
L8440:  RTS

L8441:  LDA EnData05,X
L8444:  BMI $8449
L8446:  INC $6B01,X
L8449:  SEC 
L844A:  RTS

L844B:  LDX PageIndex
L844D:  LDA EnYRoomPos,X
L8450:  CLC 
L8451:  ADC EnRadY,X
L8454:  AND #$07
L8456:  SEC 
L8457:  BNE $845C
L8459:  JSR $E77B
L845C:  LDY #$00
L845E:  STY $00
L8460:  LDX PageIndex
L8462:  BCC $84A6
L8464:  INC $00
L8466:  LDY EnYRoomPos,X
L8469:  CPY #$EF
L846B:  BNE $8481
L846D:  LDY #$FF
L846F:  LDA $49
L8471:  CMP #$02
L8473:  BCS $8481
L8475:  LDA $FC
L8477:  BEQ $84A6
L8479:  JSR $8563
L847C:  BNE $84A6
L847E:  JSR $855A
L8481:  INY 
L8482:  TYA 
L8483:  STA EnYRoomPos,X
L8486:  CLC 
L8487:  ADC EnRadY,X
L848A:  CMP #$EF
L848C:  BNE $849D
L848E:  LDA $FC
L8490:  BEQ $8497
L8492:  JSR $8563
L8495:  BEQ $849D
L8497:  DEC EnYRoomPos,X
L849A:  CLC 
L849B:  BCC $84A6
L849D:  LDA EnData05,X
L84A0:  BMI $84A5
L84A2:  DEC $6B01,X
L84A5:  SEC 
L84A6:  RTS

L84A7:  LDX PageIndex
L84A9:  LDA EnXRoomPos,X
L84AC:  SEC 
L84AD:  SBC EnRadX,X
L84B0:  AND #$07
L84B2:  SEC 
L84B3:  BNE $84B8
L84B5:  JSR $E8F1
L84B8:  LDY #$00
L84BA:  STY $00
L84BC:  LDX PageIndex
L84BE:  BCC $84FD
L84C0:  INC $00
L84C2:  LDY EnXRoomPos,X
L84C5:  BNE $84DA
L84C7:  LDA $49
L84C9:  CMP #$02
L84CB:  BCC $84DA
L84CD:  LDA $FD
L84CF:  BEQ $84D4
L84D1:  JSR $8563
L84D4:  CLC 
L84D5:  BEQ $84FD
L84D7:  JSR $855A
L84DA:  DEC EnXRoomPos,X
L84DD:  LDA EnXRoomPos,X
L84E0:  CMP EnRadX,X
L84E3:  BNE $84F4
L84E5:  LDA $FD
L84E7:  BEQ $84EE
L84E9:  JSR $8563
L84EC:  BNE $84F4
L84EE:  INC EnXRoomPos,X
L84F1:  CLC 
L84F2:  BCC $84FD
L84F4:  LDA EnData05,X
L84F7:  BPL $84FC
L84F9:  INC $6B01,X
L84FC:  SEC 
L84FD:  RTS

L84FE:  LDX PageIndex
L8500:  LDA EnXRoomPos,X
L8503:  CLC 
L8504:  ADC EnRadX,X
L8507:  AND #$07
L8509:  SEC 
L850A:  BNE $850F
L850C:  JSR $E8FC
L850F:  LDY #$00
L8511:  STY $00
L8513:  LDX PageIndex
L8515:  BCC $8559
L8517:  INC $00
L8519:  INC EnXRoomPos,X
L851C:  BNE $8536
L851E:  LDA $49
L8520:  CMP #$02
L8522:  BCC $8536
L8524:  LDA $FD
L8526:  BEQ $852D
L8528:  JSR $8563
L852B:  BEQ $8533
L852D:  DEC EnXRoomPos,X
L8530:  CLC 
L8531:  BCC $8559
L8533:  JSR $855A
L8536:  LDA EnXRoomPos,X
L8539:  CLC 
L853A:  ADC EnRadX,X
L853D:  CMP #$FF
L853F:  BNE $8550
L8541:  LDA $FD
L8543:  BEQ $854A
L8545:  JSR $8563
L8548:  BEQ $8550
L854A:  DEC EnXRoomPos,X
L854D:  CLC 
L854E:  BCC $8559
L8550:  LDA EnData05,X
L8553:  BPL $8558
L8555:  DEC $6B01,X
L8558:  SEC 
L8559:  RTS

L855A:  LDA EnNameTable,X
L855D:  EOR #$01
L855F:  STA EnNameTable,X
L8562:  RTS

L8563:  LDA EnNameTable,X
L8566:  EOR $FF
L8568:  AND #$01
L856A:  RTS

L856B:  EOR EnData05,X
L856E:  STA EnData05,X
L8571:  RTS 

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
L860B:  .word $87CB, $87CB, $87CB, $87CB, $87DD, $87F0, $8802, $8802
L861B:  .word $8818, $882C, $882C, $882C, $882C, $883E, $8851, $8863
L862B:  .word $8863, $8874, $8874, $8885, $8885, $8885, $8885, $8885
L863B:  .word $888F, $8899, $88A3, $88AD, $88B8, $88C3, $88CE, $88D9
L864B:  .word $88D9, $88D9, $88D9, $88EE, $88F8, $88F8, $88FE, $8904
L865B:  .word $890A, $890F, $890F, $8914, $8928, $8928, $8928, $8928
L866B:  .word $8928, $893C, $8948, $8948, $8954, $8954, $8961, $8961
L867B:  .word $8961, $8974, $8987, $8987, $8987, $8995, $8995, $8995
L868B:  .word $8995, $89A9, $89BE, $89D2, $89D2, $89D2, $89D2, $89E6
L869B:  .word $89FB, $8A0F, $8A1D, $8A21, $8A26, $8A26, $8A3C, $8A41
L86AB:  .word $8A46, $8A4E, $8A56, $8A5E, $8A66, $8A6E, $8A76, $8A7E
L86BB:  .word $8A86, $8A8E, $8A9C, $8AA1, $8AA6, $8AAE, $8ABA, $8AC4
L86CB:  .word $8AC4, $8AC4, $8AC4, $8AC4, $8AC4, $8AC4, $8AD8, $8AE9
L86DB:  .word $8AF3, $8B03

;The following table provides pointers to data used for the placement of the sprites that make up
;Samus and other non-enemy objects.

PlacePtrTable:
L86DF:  .word $8701, $871F, $872B, $8737, $8747, $8751, $86FD, $875D
L86EF:  .word $8775, $878D, $8791, $8799, $87A5, $8749, $87B1

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
L8AA1:  .byte $04, $00, $00, $5A, $FF, $13, $00, $00, $B0, $B1, $B2, $B3, $FF, $13, $00, $00
L8AB1:  .byte $B4, $B5, $B6, $B7, $B8, $B6, $B9, $B3, $FF, $13, $00, $00, $B3, $BA, $BA, $FE
L8AC1:  .byte $80, $80, $FF

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

;------------------------------------[ Samus enter door routines ]-----------------------------------

;This function is called once when Samus first enters a door.

SamusEnterDoor:
L8B13:  LDA DoorStatus                  ;The code determines if Samus has entered a door if the-->
L8B15:  BNE ++++                        ;door status is 0, but door data information has been-->
L8B17:  LDY SamusDoorData               ;written. If both conditions are met, Samus has just-->
L8B19:  BEQ ++++                        ;entered a door.
L8B1B:  STA CurrentMissilePickups       ;
L8B1D:  STA CurrentEnergyPickups        ;Reset current missile and energy power-up counters.
L8B1F:  LDA RandomNumber1               ;
L8B21:  AND #$0F                        ;Randomly recalculate max missile pickups(16 max, 0 min).
L8B23:  STA MaxMissilePickup            ;
L8B25:  ASL                             ;
L8B26:  ORA #$40                        ;*2 for energy pickups and set bit 6(128 max, 64 min).
L8B28:  STA MaxEnergyPickup             ;
L8B2A:  LDA PPUCNT0ZP                   ;
L8B2C:  EOR #$01                        ;
L8B2E:  AND #$01                        ;Erase name table door data for new room.
L8B30:  TAY                             ;
L8B31:  LSR                             ;
L8B32:  STA $006C,Y                     ;
L8B35:  LDA ScrollDir                   ;
L8B37:  AND #$02                        ;Is Samus scrolling horizontally?-->
L8B39:  BNE +                           ;If so, branch.
L8B3B:  LDX #$04                        ;Samus currently scrolling vertically.
L8B3D:  LDA ScrollY                     ;Is room centered on screen?-->
L8B3F:  BEQ +++++                       ;If so, branch.
L8B41:  LDA $FF                         ;
L8B43:  EOR ObjectHi                    ;Get inverse of Samus' current nametable.
L8B46:  LSR                             ;
L8B47:  BCC +++                         ;If Samus is on nametable 3, branch.
L8B49:  BCS ++                          ;If Samus is on nametable 0, branch to decrement x.

L8B4B:* LDX #$02                        ;Samus is currently scrolling horizontally.
L8B4D:  LDA ObjectX                     ;Is Samus entering a left hand door?-->
L8B50:  BPL ++                          ;If so, branch.
L8B52:* DEX                             ;

SetDoorEntryInfo:
L8B53:* TXA                             ;X contains door scroll status and is transferred to A.
L8B54:  STA DoorScrollStatus            ;Save door scroll status.
L8B56:  JSR SamusInDoor                 ;($8B74)Indicate Samus just entered a door.
L8B59:  LDA #$12                        ;
L8B5B:  STA DoorDelay                   ;Set DoorDelay to 18 frames(going into door).
L8B5D:  LDA SamusDoorData               ;
L8B5F:  JSR Amul16                      ;($C2C5)*16. Move scroll toggle data to upper 4 bits.
L8B62:  ORA ObjAction                   ;Keep Samus action so she will appear the same comming-->
L8B65:  STA SamusDoorData               ;out of the door as she did going in.
L8B67:  LDA #$05                        ;
L8B69:  STA ObjAction                   ;Indicate Samus is in a door.
L8B6C:* RTS                             ;

L8B6D:* JSR SetDoorEntryInfo            ;($8B53)Save Samus action and set door entry timer.
L8B70:  JSR VerticalRoomCentered        ;($E21B)Room is centered. Toggle scroll.

L8B73:  TXA                             ;X=#$01 or #$02(depending on which door Samus is in).

SamusInDoor:
L8B74:  ORA #$80                        ;Set MSB of DoorStatus to indicate Samus has just-->
L8B76:  STA DoorStatus                  ;entered a door.
L8B78:  RTS                             ;

;----------------------------------------------------------------------------------------------------

L8B79:  LDX #$B0
L8B7B:* JSR $8B87
L8B7E:  LDA PageIndex
L8B80:  SEC 
L8B81:  SBC #$10
L8B83:  TAX 
L8B84:  BMI -
L8B86:  RTS

L8B87:  STX PageIndex
L8B89:  LDA ObjAction,X
L8B8C:  JSR ChooseRoutine               ;($C27C)

L8B8F:  .word $C45C
L8B91:  .word $8B9D
L8B93:  .word $8BD5
L8B95:  .word $8C01
L8B97:  .word $8C84
L8B99:  .word $8CC6
L8B9B:  .word $8CF0

L8B9D:  INC $0300,X
L8BA0:  LDA #$30
L8BA2:  JSR SetProjectileAnim           ;($D2FA)
L8BA5:  JSR $8CFB
L8BA8:  LDY $0307,X
L8BAB:  LDA $8BD1,Y
L8BAE:  STA $030F,X
L8BB1:  LDA $0307,X
L8BB4:  CMP #$03
L8BB6:  BNE $8BBA
L8BB8:  LDA #$01
L8BBA:  ORA #$A0
L8BBC:  STA $6B
L8BBE:  LDA #$00
L8BC0:  STA $030A,X
L8BC3:  TXA 
L8BC4:  AND #$10
L8BC6:  EOR #$10
L8BC8:  ORA $6B
L8BCA:  STA $6B
L8BCC:  LDA #$06
L8BCE:  JMP $DE47

L8BD1:  .byte $05, $01, $0A, $01

L8BD5:  LDA $030A,X
L8BD8:  AND #$04
L8BDA:  BEQ $8BB1
L8BDC:  DEC $030F,X
L8BDF:  BNE $8BB1
L8BE1:  LDA #$03
L8BE3:  CMP $0307,X
L8BE6:  BNE $8BEE
L8BE8:  LDY $010B
L8BEB:  INY 
L8BEC:  BNE $8BB1
L8BEE:  STA $0300,X
L8BF1:  LDA #$50
L8BF3:  STA $030F,X
L8BF6:  LDA #$2C
L8BF8:  STA $0305,X
L8BFB:  SEC 
L8BFC:  SBC #$03
L8BFE:  JMP $8C7E
L8C01:  LDA DoorStatus
L8C03:  BEQ $8C1D
L8C05:  LDA $030C
L8C08:  EOR $030C,X
L8C0B:  LSR 
L8C0C:  BCS $8C1D
L8C0E:  LDA $030E
L8C11:  EOR $030E,X
L8C14:  BMI $8C1D
L8C16:  LDA #$04
L8C18:  STA $0300,X
L8C1B:  BNE $8C73
L8C1D:  LDA $0306,X
L8C20:  CMP $0305,X
L8C23:  BCC $8C73
L8C25:  LDA $030F,X
L8C28:  CMP #$50
L8C2A:  BNE $8C57
L8C2C:  JSR $8CF7
L8C2F:  LDA $0307,X
L8C32:  CMP #$01
L8C34:  BEQ $8C57
L8C36:  CMP #$03
L8C38:  BEQ $8C57
L8C3A:  LDA #$0A
L8C3C:  STA $09
L8C3E:  LDA $030C,X
L8C41:  STA $08
L8C43:  LDY $50
L8C45:  TXA 
L8C46:  JSR $C2C5
L8C49:  BCC $8C4C
L8C4B:  DEY 
L8C4C:  TYA 
L8C4D:  JSR $DC1E
L8C50:  LDA #$00
L8C52:  STA $0300,X
L8C55:  BEQ $8C73
L8C57:  LDA $2D
L8C59:  LSR 
L8C5A:  BCS $8C73
L8C5C:  DEC $030F,X
L8C5F:  BNE $8C73
L8C61:  LDA #$01
L8C63:  STA $030F,X
L8C66:  JSR $8CFB
L8C69:  LDA #$02
L8C6B:  STA $0300,X
L8C6E:  JSR $8C76
L8C71:  LDX PageIndex
L8C73:  JMP $8BB1
L8C76:  LDA #$30
L8C78:  STA $0305,X
L8C7B:  SEC 
L8C7C:  SBC #$02
L8C7E:  JSR $D2FD
L8C81:  JMP $CBDA
L8C84:  LDA DoorStatus
L8C86:  CMP #$05
L8C88:  BCS $8CC3
L8C8A:  JSR $8CFB
L8C8D:  JSR $8C76
L8C90:  LDX PageIndex
L8C92:  LDA $91
L8C94:  BEQ $8CA7
L8C96:  TXA 
L8C97:  JSR $C2BF
L8C9A:  EOR $91
L8C9C:  LSR 
L8C9D:  BCC $8CA7
L8C9F:  LDA $76
L8CA1:  EOR #$07
L8CA3:  STA $76
L8CA5:  STA $1C
L8CA7:  INC $0300,X
L8CAA:  LDA #$00
L8CAC:  STA $91
L8CAE:  LDA $0307,X
L8CB1:  CMP #$03
L8CB3:  BNE $8CC3
L8CB5:  TXA 
L8CB6:  JSR $C2C5
L8CB9:  BCS $8CC0
L8CBB:  JSR $CC07
L8CBE:  BNE $8CC3
L8CC0:  JSR $CC03
L8CC3:  JMP $8C71
L8CC6:  LDA DoorStatus
L8CC8:  CMP #$05
L8CCA:  BNE $8CED
L8CCC:  TXA 
L8CCD:  EOR #$10
L8CCF:  TAX 
L8CD0:  LDA #$06
L8CD2:  STA $0300,X
L8CD5:  LDA #$2C
L8CD7:  STA $0305,X
L8CDA:  SEC 
L8CDB:  SBC #$03
L8CDD:  JSR $D2FD
L8CE0:  JSR $CBDA
L8CE3:  JSR $CB73
L8CE6:  LDX PageIndex
L8CE8:  LDA #$02
L8CEA:  STA $0300,X
L8CED:  JMP $8BB1
L8CF0:  LDA DoorStatus
L8CF2:  BNE $8CED
L8CF4:  JMP $8C61
L8CF7:  LDA #$FF
L8CF9:  BNE $8CFD
L8CFB:  LDA #$4E
L8CFD:  PHA 
L8CFE:  LDA #$50
L8D00:  STA $02
L8D02:  TXA 
L8D03:  JSR $C2BF
L8D06:  AND #$01
L8D08:  TAY 
L8D09:  LDA $8D3A,Y
L8D0C:  STA $03
L8D0E:  LDA $030C,X
L8D11:  STA $0B
L8D13:  JSR $E96A
L8D16:  LDY #$00
L8D18:  PLA 
L8D19:  STA ($04),Y
L8D1B:  TAX 
L8D1C:  TYA 
L8D1D:  CLC 
L8D1E:  ADC #$20
L8D20:  TAY 
L8D21:  TXA 
L8D22:  CPY #$C0
L8D24:  BNE $8D19
L8D26:  LDX PageIndex
L8D28:  TXA 
L8D29:  JSR $C2C0
L8D2C:  AND #$06
L8D2E:  TAY 
L8D2F:  LDA $04
L8D31:  STA $005C,Y
L8D34:  LDA $05
L8D36:  STA $005D,Y
L8D39:  RTS

L8D3A:  .byte $E8, $10, $60, $AD, $91, $69, $8D, $78, $68, $AD, $92, $69, $8D, $79, $68, $A9 
L8D4A:  .byte $00, $85, $00, $85, $02, $AD, $97, $69, $29, $80, $F0, $06, $A5, $00, $09, $80
L8D5A:  .byte $85, $00, $AD, $97, $69, $29
