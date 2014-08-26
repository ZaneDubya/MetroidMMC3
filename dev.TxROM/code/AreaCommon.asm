; METROID Disassembly (c) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
; Disassembled by Kent Hansen. Commented by Nick Mikstas.
; This version is organized and ported to use the MMC3.
; Area ROM Bank Common Routines & Data (8000 - 8D60)
.require "Defines.asm"
.require "GameEngineDeclarations.asm"

.alias EnemyDataTable7B     $977B
.alias EnemyDataTable8B     $968B
.alias EnemyDataPtrTable    $96DB

.word $0000
.word $0000
.word $0000
.word $0000
.byte $00

;-----------------------------------------[ Start of code ]------------------------------------------
; The CommonJump table. Area code will JMP/JSR directly to this table.
; Name / Address JMP/JSR to.        ; JMP/JSR?  Area?   Description      
CommonJump_UnknownUpdateAnim0:      ; JMP       All     UpdateEnemyAnim, followed 
    JMP UpdateEnemyAnim0            ;                   by call to 8058
CommonJump_UnknownUpdateAnim1:      ; JMP       All     UpdateEnemyAnim, followed 
    JMP UpdateEnemyAnim1            ;                   by call to $*F416
CommonJump_Unknown06:               ; JMP       All     ??????
    JMP CheckObjectAttribs          ; 
CommonJump_Unknown09:               ; JSR       BKNR    Get a random value, using EnIndex (X)
    JMP GetRandom_EnIdxFrCnt        ;                   and current NES frame (0-255)
CommonJump_UpdateEnemyAnim:         ; JSR       BKNR    Advance to next frame 
    JMP UpdateEnemyAnim             ;                   of enemy's animation.
CommonJump_ResetAnimIndex:          ; Both      BKNR    ??????
    JMP ResetAnimIndex              ;
CommonJump_Unknown1B:               ; JSR       BKNR    ??????
    JMP UnknownFB88                 ;
CommonJump_Unknown1E:               ; JSR       BKNR    ??????
    JMP UnknownFBCA                 ;
CommonJump_Unknown21:               ; Both      NR      ??????
    JMP UnknownF870                 ;
CommonJump_ChooseRoutine:           ; JSR       All     Calls ChooseRoutine in GameEngine
    JMP ChooseRoutine               ; 
CommonJump_Unknown27:               ; JSR       All     ??????
    JMP UnknownFD8F                 ;
CommonJump_Unknown2A:               ; Both      All     ??????    
    JMP UnknownEB6E                 ;
CommonJump_Unknown2D:               ; JSR       BK      ??????
    JMP Common8244                  ;
CommonJump_Unknown30:               ; JSR       BK      ??????
    JMP Common8318                  ;
CommonJump_EnemyBGCollision:        ; JSR       BK      ??????
    JMP EnemyBGCrashDetection       ;
CommonJump_Unknown36:               ; JSR       BKNR    ??????    
    JMP Common833F                  ;
CommonJump_Unknown39:               ; JSR       BKNR    ??????    
    JMP Common8395                  ;
CommonJump_Unknown3C:               ; JSR       T       Clears object control byte if
    JMP ClrObjCntrlIfFrameIsF7      ;                   AnimFrame == $F7
CommonJump_DrawTileBlast:           ; JSR       T       Calls DrawTileBlast
    JMP DrawTileBlast               ; 
CommonJump_SubtractHealth:          ; JSR       T       Calls SubtractHealth
    JMP SubtractHealth              ; 
CommonJump_Base10Subtract:          ; JSR       T       Calls Base10Subtract
    JMP Base10Subtract              ; 

; These are the addresses of four common routines (minus one). These routines
; are called by pushing the address onto the stack, and then executing RTS. An
; example of this calling scheme can be seen at 9AE2 in the Brinstar ROM bank.
; Each address is repeated one time, in this order: A B C C B A D D
CommonRoutines:
    .word Unknown84FE-1, Unknown84A7-1, Unknown844B-1
    .word Unknown844B-1, Unknown84A7-1, Unknown84FE-1
    .word Unknown83F5-1, Unknown83F5-1

RunObjectRoutine:
L8058:  LDX PageIndex                   ;   X = Index of object we are working on ($00, $10, $20 ... $f0)
L805A:  LDA EnData05,X                  ;   A = EnData05 of object X.       
L805D:  ASL                             ;   if (A & $40 == $40) 
L805E:  BMI ++++++++                    ;       { rts }
L8060:  LDA EnStatus,X                  ;   A = EnStatus of object X. 
L8063:  CMP #$02                        ;   if (A == 2) 
L8065:  BNE ++++++++                    ;       { rts }
L8067:  JSR Common8244                  ;   ???
L806A:  LDA $00                         ;   A = Mem[$00] (set by Common8244???)
L806C:  BPL ++                          ;   if (A & $80 == $80)
                                        ;   {
L806E:  JSR TwosCompliment              ;       Mem[$66] = $100 - A 
L8071:  STA $66                         ;       while (Mem[$66] != 0)
                                        ;       {
L8073:* JSR Unknown83F5                 ;           ???
L8076:  JSR Unknown80B8                 ;           ???
L8079:  DEC $66                         ;           Mem[$66]--
L807B:  BNE -                           ;       }
                                        ;       ; Because Mem[$66] == 0, we skip the next loop.
                                        ;   }
L807D:* BEQ ++                          ;   else if (A != 0)
                                        ;   {
L807F:  STA $66                         ;       Mem[$66] = A
                                        ;       while (Mem[$66] != 0)
                                        ;       {
L8081:* JSR Unknown844B                 ;           ???    
L8084:  JSR Unknown80FB                 ;           ???
L8087:  DEC $66                         ;           Mem[$66]--
                                        ;       }
L8089:  BNE -                           ;   }
L808B:* JSR Common8318                  ;   ???
L808E:  LDA $00                         ;   A == Mem[$00] (set by Common8318???)
L8090:  BPL ++                          ;   if (A & $80 == $80)
                                        ;   {
L8092:  JSR TwosCompliment              ;       A = $100 - A 
L8095:  STA $66                         ;       Mem[$66] = A
                                        ;       while (Mem[$66] != 0)
                                        ;       {
L8097:* JSR Unknown84A7                 ;           ???    
L809A:  JSR Unknown816E                 ;           ???
L809D:  DEC $66                         ;           Mem[$66]--
L809F:  BNE -                           ;       }
                                        ;       ; Because Mem[$66] == 0, we skip the next loop.
                                        ;   }
L80A1:* BEQ ++                          ;   else if (A != 0)
                                        ;   {
L80A3:  STA $66                         ;       Mem[$66] = A
                                        ;       while (Mem[$66] != 0)
                                        ;       {
L80A5:* JSR Unknown84FE                 ;           ???
L80A8:  JSR Unknown8134                 ;           ???
L80AB:  DEC $66                         ;           Mem[$66]--
L80AD:  BNE -                           ;       }
                                        ;   }
L80AF:* RTS                             ;   rts

Unknown80B0:
    LDY EnDataIndex,X               
    LDA EnemyDataTable7B,Y
    ASL                             ;*2 
    RTS

Unknown80B8:
L80B8:  LDX PageIndex
L80BA:  BCS L80FA
L80BC:  LDA EnData05,X
L80BF:  BPL L80C7
L80C1:  JSR Unknown81FC
L80C4:  JMP L80F6
L80C7:  JSR Unknown80B0
L80CA:  BPL L80EA
L80CC:  LDA $6B03,X
L80CF:  BEQ L80C1
L80D1:  BPL L80D8
L80D3:  JSR Unknown81B1
L80D6:  BEQ L80E2
L80D8:  SEC 
L80D9:  ROR $0402,X
L80DC:  ROR EnCounter,X
L80DF:  JMP L80F6
L80E2:  STA $0402,X
L80E5:  STA EnCounter,X
L80E8:  BEQ L80F6
L80EA:  LDA EnemyDataTable7B,Y
L80ED:  LSR 
L80EE:  LSR 
L80EF:  BCC L80F6
L80F1:  LDA #$04
L80F3:  JSR ClearEnData05
L80F6:  LDA #$01
L80F8:  STA $66
L80FA:  RTS

Unknown80FB:
L80FB:  LDX PageIndex
L80FD:  BCS L8133
L80FF:  LDA EnData05,X
L8102:  BPL L810A
L8104:  JSR Unknown81FC
L8107:  JMP Unknown812F
L810A:  JSR Unknown80B0
L810D:  BPL L8123
L810F:  LDA $6B03,X
L8112:  BEQ L8104
L8114:  BPL L8120
L8116:  CLC 
L8117:  ROR $0402,X
L811A:  ROR EnCounter,X
L811D:  JMP Unknown812F
L8120:  JSR Unknown81B1
L8123:  LDA EnemyDataTable7B,Y
L8126:  LSR 
L8127:  LSR 
L8128:  BCC Unknown812F
L812A:  LDA #$04
L812C:  JSR ClearEnData05

Unknown812F:
L812F:  LDA #$01
L8131:  STA $66
L8133:  RTS

Unknown8134:
L8134:  LDX PageIndex
L8136:  BCS L816D
L8138:  JSR Unknown80B0
L813B:  BPL L815E
L813D:  LDA EnData05,X
L8140:  BMI L8148
L8142:  JSR Unknown81C7
L8145:  JMP Set66To01AndReturn
L8148:  LDA $6B03,X
L814B:  BEQ L8142
L814D:  BPL L8159
L814F:  CLC 
L8150:  ROR $0403,X
L8153:  ROR $0407,X
L8156:  JMP Set66To01AndReturn
L8159:  JSR Unknown81C0
L815C:  BEQ Set66To01AndReturn
L815E:  LDA EnemyDataTable7B,Y
L8161:  LSR 
L8162:  BCC Set66To01AndReturn
L8164:  LDA #$01
L8166:  JSR ClearEnData05
Set66To01AndReturn:
L8169:  LDA #$01
L816B:  STA $66
L816D:  RTS

Unknown816E:
L816E:  LDX PageIndex
L8170:  BCS L81B0
L8172:  JSR Unknown80B0
L8175:  BPL L81A0
L8177:  LDA EnData05,X
L817A:  BMI L8182
L817C:  JSR Unknown81C7
L817F:  JMP Set66To01AndReturn1
L8182:  LDA $6B03,X
L8185:  BEQ L817C
L8187:  BPL L818E
L8189:  JSR Unknown81C0
L818C:  BEQ L8198
L818E:  SEC 
L818F:  ROR $0403,X
L8192:  ROR $0407,X
L8195:  JMP Set66To01AndReturn1
L8198:  STA $0403,X
L819B:  STA $0407,X
L819E:  BEQ Set66To01AndReturn1
L81A0:  JSR Unknown80B0
L81A3:  LSR 
L81A4:  LSR 
L81A5:  BCC Set66To01AndReturn1
L81A7:  LDA #$01
L81A9:  JSR ClearEnData05
Set66To01AndReturn1:
L81AC:  LDA #$01
L81AE:  STA $66
L81B0:  RTS

Unknown81B1:
L81B1:  JSR Unknown81B8
L81B4:  STA $6AFE,X
L81B7:  RTS

Unknown81B8:
L81B8:  LDA #$20
L81BA:  JSR AddFlagToEnData05
L81BD:  LDA #$00
L81BF:  RTS

Unknown81C0:
L81C0:  JSR Unknown81B8
L81C3:  STA $6AFF,X
L81C6:  RTS

Unknown81C7:
L81C7:  JSR GetEnemy8BFlag
L81CA:  BNE L81F5
L81CC:  LDA #$01
L81CE:  JSR ClearEnData05
L81D1:  LDA $6AFF,X
L81D4:  JSR TwosCompliment
L81D7:  STA $6AFF,X
Unknown81DA:
L81DA:  JSR GetEnemy8BFlag
L81DD:  BNE L81F5
L81DF:  JSR Unknown80B0
L81E2:  SEC 
L81E3:  BPL L81ED
L81E5:  LDA #$00
L81E7:  SBC $0407,X
L81EA:  STA $0407,X
L81ED:  LDA #$00
L81EF:  SBC $0403,X
L81F2:  STA $0403,X
L81F5:  RTS

GetEnemy8BFlag:
L81F6:  JSR GetEnemy8BValue
L81F9:  AND #$20
L81FB:  RTS

Unknown81FC:
L81FC:  JSR GetEnemy8BFlag
L81FF:  BNE L81F5
L8201:  LDA #$04
L8203:  JSR ClearEnData05
Unknown8206:                    ; Called from GameEngine.asm
L8206:  LDA $6AFE,X
L8209:  JSR TwosCompliment
L820C:  STA $6AFE,X
Unknown820F:                    ; Called from GameEngine.asm
L820F:  JSR GetEnemy8BFlag
L8212:  BNE L822A
L8214:  JSR Unknown80B0
L8217:  SEC 
L8218:  BPL L8222
L821A:  LDA #$00
L821C:  SBC EnCounter,X
L821F:  STA EnCounter,X
L8222:  LDA #$00
L8224:  SBC $0402,X
L8227:  STA $0402,X
L822A:  RTS 

Unknown822B:
L822B:  LDA EnData05,X
L822E:  BPL L8232
L8230:  LSR 
L8231:  LSR 
L8232:  LSR 
L8233:  LDA $0408,X
L8236:  ROL 
L8237:  ASL 
L8238:  TAY 
L8239:  LDA EnemyDataPtrTable,Y
L823C:  STA $81
L823E:  LDA EnemyDataPtrTable+1,Y
L8241:  STA $82
L8243:  RTS

Common8244:
L8244:  JSR Unknown80B0
L8247:  BPL L824C
L8249:  JMP Common833F
L824C:  LDA EnData05,X
L824F:  AND #$20
L8251:  EOR #$20
L8253:  BEQ Clear00AndReturn
L8255:  JSR Unknown822B
Unknown8258:
L8258:  LDY EnCounter,X
Unknown825B:
L825B:  LDA ($81),Y
L825D:  CMP #$F0
L825F:  BCC L827F
L8261:  CMP #$FA
L8263:  BEQ L827C
L8265:  CMP #$FB
L8267:  BEQ L82B0
L8269:  CMP #$FC
L826B:  BEQ L82B3
L826D:  CMP #$FD
L826F:  BEQ L82A5
L8271:  CMP #$FE
L8273:  BEQ L82DE
L8275:  LDA #$00
L8277:  STA EnCounter,X
L827A:  BEQ Unknown8258
L827C:  JMP Unknown8312
L827F:  SEC 
L8280:  SBC EnDelay,X
L8283:  BNE L8290
L8285:  STA EnDelay,X
L8288:  INY 
L8289:  INY 
L828A:  TYA 
L828B:  STA EnCounter,X
L828E:  BNE Unknown825B
L8290:  INC EnDelay,X
L8293:  INY 
L8294:  LDA ($81),Y
Unknown8296:
L8296:  ASL 
L8297:  PHP 
L8298:  JSR Adiv32
L829B:  PLP 
L829C:  BCC Clear00AndReturn
L829E:  EOR #$FF
L82A0:  ADC #$00
Clear00AndReturn:
L82A2:  STA $00
L82A4:  RTS

L82A5:  INC EnCounter,X
L82A8:  INY 
L82A9:  LDA #$00
L82AB:  STA $6B01,X
L82AE:  BEQ Unknown825B
L82B0:  PLA 
L82B1:  PLA 
L82B2:  RTS

L82B3:  LDA $6B03,X
L82B6:  BPL L82BE
L82B8:  JSR CheckYPlus8
L82BB:  JMP SkipAlways
L82BE:  BEQ L82D2
L82C0:  JSR CheckNegativeYPlus8
SkipAlways:
L82C3:  LDX PageIndex
L82C5:  BCS L82D2
L82C7:  LDY EnCounter,X
L82CA:  INY 
L82CB:  LDA #$00
L82CD:  STA $6B03,X
L82D0:  BEQ L82D7
L82D2:  LDY EnCounter,X
L82D5:  DEY 
L82D6:  DEY 
L82D7:  TYA 
L82D8:  STA EnCounter,X
L82DB:  JMP Unknown825B
L82DE:  DEY 
L82DF:  DEY 
L82E0:  TYA 
L82E1:  STA EnCounter,X
L82E4:  LDA $6B03,X
L82E7:  BPL L82EF
L82E9:  JSR CheckYPlus8
L82EC:  JMP SkipAlways82F4
L82EF:  BEQ L82FB
L82F1:  JSR CheckNegativeYPlus8
SkipAlways82F4:
L82F4:  LDX PageIndex
L82F6:  BCC L82FB
L82F8:  JMP Unknown8258
L82FB:  LDY EnDataIndex,X
L82FE:  LDA EnemyDataTable8B,Y
L8301:  AND #$20
L8303:  BEQ Unknown8312
L8305:  LDA EnData05,X
L8308:  EOR #$05
L830A:  ORA EnemyDataTable8B,Y
L830D:  AND #$1F
L830F:  STA EnData05,X
Unknown8312:
L8312:  JSR Unknown81B1
L8315:  JMP Clear00AndReturn

Common8318:
L8318:  JSR Unknown80B0
L831B:  BPL +
L831D:  JMP Common8395
L8320:* LDA EnData05,X
L8323:  AND #$20
L8325:  EOR #$20
L8327:  BEQ +
L8329:  LDY EnCounter,X
L832C:  INY 
L832D:  LDA ($81),Y
Unknown832F:                    ; called from GameEngine.asm
L832F:  TAX 
L8330:  AND #$08
L8332:  PHP 
L8333:  TXA 
L8334:  AND #$07
L8336:  PLP 
L8337:  BEQ +
L8339:  JSR TwosCompliment
L833C:* STA $00
L833E:  RTS

Common833F:
L833F:  LDY #$0E
L8341:  LDA $6AFE,X
L8344:  BMI L835E
L8346:  CLC 
L8347:  ADC EnCounter,X
L834A:  STA EnCounter,X
L834D:  LDA $0402,X
L8350:  ADC #$00
L8352:  STA $0402,X
L8355:  BPL L8376
L8357:  JSR TwosCompliment
L835A:  LDY #$F2
L835C:  BNE L8376
L835E:  JSR TwosCompliment
L8361:  SEC 
L8362:  STA $00
L8364:  LDA EnCounter,X
L8367:  SBC $00
L8369:  STA EnCounter,X
L836C:  LDA $0402,X
L836F:  SBC #$00
L8371:  STA $0402,X
L8374:  BMI L8357
L8376:  CMP #$0E
L8378:  BCC L8383
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

Common8395:
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
L83B2:  BPL L83B6
L83B4:  LDA #$FF
L83B6:  ADC $0403,X
L83B9:  STA $0403,X
L83BC:  TAY 
L83BD:  BPL L83D0
L83BF:  LDA #$00
L83C1:  SEC 
L83C2:  SBC $0407,X
L83C5:  STA $04
L83C7:  LDA #$00
L83C9:  SBC $0403,X
L83CC:  TAY 
L83CD:  JSR SubtractFromZero00And01
L83D0:  LDA $04
L83D2:  CMP $02
L83D4:  TYA 
L83D5:  SBC $03
L83D7:  BCC L83E3
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

Unknown83F5:
L83F5:  LDX PageIndex
L83F7:  LDA EnYRoomPos,X
L83FA:  SEC 
L83FB:  SBC EnRadY,X
L83FE:  AND #$07
L8400:  SEC 
L8401:  BNE L8406
L8403:  JSR CheckYPlus8
L8406:  LDY #$00
L8408:  STY $00
L840A:  LDX PageIndex
L840C:  BCC L844A
L840E:  INC $00
L8410:  LDY EnYRoomPos,X
L8413:  BNE L8429
L8415:  LDY #$F0
L8417:  LDA $49
L8419:  CMP #$02
L841B:  BCS L8429
L841D:  LDA $FC
L841F:  BEQ L844A
L8421:  JSR Unknown8563
L8424:  BEQ L844A
L8426:  JSR Unknown855A
L8429:  DEY 
L842A:  TYA 
L842B:  STA EnYRoomPos,X
L842E:  CMP EnRadY,X
L8431:  BNE L8441
L8433:  LDA $FC
L8435:  BEQ L843C
L8437:  JSR Unknown8563
L843A:  BNE L8441
L843C:  INC EnYRoomPos,X
L843F:  CLC 
L8440:  RTS

L8441:  LDA EnData05,X
L8444:  BMI L8449
L8446:  INC $6B01,X
L8449:  SEC 
L844A:  RTS

Unknown844B:
L844B:  LDX PageIndex
L844D:  LDA EnYRoomPos,X
L8450:  CLC 
L8451:  ADC EnRadY,X
L8454:  AND #$07
L8456:  SEC 
L8457:  BNE L845C
L8459:  JSR CheckNegativeYPlus8
L845C:  LDY #$00
L845E:  STY $00
L8460:  LDX PageIndex
L8462:  BCC L84A6
L8464:  INC $00
L8466:  LDY EnYRoomPos,X
L8469:  CPY #$EF
L846B:  BNE L8481
L846D:  LDY #$FF
L846F:  LDA $49
L8471:  CMP #$02
L8473:  BCS L8481
L8475:  LDA $FC
L8477:  BEQ L84A6
L8479:  JSR Unknown8563
L847C:  BNE L84A6
L847E:  JSR Unknown855A
L8481:  INY 
L8482:  TYA 
L8483:  STA EnYRoomPos,X
L8486:  CLC 
L8487:  ADC EnRadY,X
L848A:  CMP #$EF
L848C:  BNE L849D
L848E:  LDA $FC
L8490:  BEQ L8497
L8492:  JSR Unknown8563
L8495:  BEQ L849D
L8497:  DEC EnYRoomPos,X
L849A:  CLC 
L849B:  BCC L84A6
L849D:  LDA EnData05,X
L84A0:  BMI L84A5
L84A2:  DEC $6B01,X
L84A5:  SEC 
L84A6:  RTS

Unknown84A7:
L84A7:  LDX PageIndex
L84A9:  LDA EnXRoomPos,X
L84AC:  SEC 
L84AD:  SBC EnRadX,X
L84B0:  AND #$07
L84B2:  SEC 
L84B3:  BNE L84B8
L84B5:  JSR UnknownE8F1
L84B8:  LDY #$00
L84BA:  STY $00
L84BC:  LDX PageIndex
L84BE:  BCC L84FD
L84C0:  INC $00
L84C2:  LDY EnXRoomPos,X
L84C5:  BNE L84DA
L84C7:  LDA $49
L84C9:  CMP #$02
L84CB:  BCC L84DA
L84CD:  LDA $FD
L84CF:  BEQ L84D4
L84D1:  JSR Unknown8563
L84D4:  CLC 
L84D5:  BEQ L84FD
L84D7:  JSR Unknown855A
L84DA:  DEC EnXRoomPos,X
L84DD:  LDA EnXRoomPos,X
L84E0:  CMP EnRadX,X
L84E3:  BNE L84F4
L84E5:  LDA $FD
L84E7:  BEQ L84EE
L84E9:  JSR Unknown8563
L84EC:  BNE L84F4
L84EE:  INC EnXRoomPos,X
L84F1:  CLC 
L84F2:  BCC L84FD
L84F4:  LDA EnData05,X
L84F7:  BPL L84FC
L84F9:  INC $6B01,X
L84FC:  SEC 
L84FD:  RTS

Unknown84FE:
L84FE:  LDX PageIndex
L8500:  LDA EnXRoomPos,X
L8503:  CLC 
L8504:  ADC EnRadX,X
L8507:  AND #$07
L8509:  SEC 
L850A:  BNE L850F
L850C:  JSR UnknownE8FC
L850F:  LDY #$00
L8511:  STY $00
L8513:  LDX PageIndex
L8515:  BCC L8559
L8517:  INC $00
L8519:  INC EnXRoomPos,X
L851C:  BNE L8536
L851E:  LDA $49
L8520:  CMP #$02
L8522:  BCC L8536
L8524:  LDA $FD
L8526:  BEQ L852D
L8528:  JSR Unknown8563
L852B:  BEQ L8533
L852D:  DEC EnXRoomPos,X
L8530:  CLC 
L8531:  BCC L8559
L8533:  JSR Unknown855A
L8536:  LDA EnXRoomPos,X
L8539:  CLC 
L853A:  ADC EnRadX,X
L853D:  CMP #$FF
L853F:  BNE L8550
L8541:  LDA $FD
L8543:  BEQ L854A
L8545:  JSR Unknown8563
L8548:  BEQ L8550
L854A:  DEC EnXRoomPos,X
L854D:  CLC 
L854E:  BCC L8559
L8550:  LDA EnData05,X
L8553:  BPL L8558
L8555:  DEC $6B01,X
L8558:  SEC 
L8559:  RTS

Unknown855A:
L855A:  LDA EnNameTable,X
L855D:  EOR #$01
L855F:  STA EnNameTable,X
L8562:  RTS

Unknown8563:
L8563:  LDA EnNameTable,X
L8566:  EOR $FF
L8568:  AND #$01
L856A:  RTS

ClearEnData05:
L856B:  EOR EnData05,X
L856E:  STA EnData05,X
L8571:  RTS 

SpriteData:
.include "SpriteData.asm"

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
L8B56:  JSR SamusInDoor                 ;Indicate Samus just entered a door.
L8B59:  LDA #$12                        ;
L8B5B:  STA DoorDelay                   ;Set DoorDelay to 18 frames(going into door).
L8B5D:  LDA SamusDoorData               ;
L8B5F:  JSR Amul16                      ;*16. Move scroll toggle data to upper 4 bits.
L8B62:  ORA ObjAction                   ;Keep Samus action so she will appear the same comming-->
L8B65:  STA SamusDoorData               ;out of the door as she did going in.
L8B67:  LDA #$05                        ;
L8B69:  STA ObjAction                   ;Indicate Samus is in a door.
L8B6C:* RTS                             ;

L8B6D:* JSR SetDoorEntryInfo            ;Save Samus action and set door entry timer.
L8B70:  JSR VerticalRoomCentered        ;Room is centered. Toggle scroll.

L8B73:  TXA                             ;X=#$01 or #$02(depending on which door Samus is in).

SamusInDoor:
L8B74:  ORA #$80                        ;Set MSB of DoorStatus to indicate Samus has just-->
L8B76:  STA DoorStatus                  ;entered a door.
L8B78:  RTS                             ;

;----------------------------------------------------------------------------------------------------
DisplayDoors:
L8B79:  LDX #$B0
L8B7B:* JSR DoorRoutine
L8B7E:  LDA PageIndex
L8B80:  SEC 
L8B81:  SBC #$10
L8B83:  TAX 
L8B84:  BMI -
L8B86:  RTS

DoorRoutine:
L8B87:  STX PageIndex
L8B89:  LDA ObjAction,X
L8B8C:  JSR ChooseRoutine

L8B8F:  .word ExitSub
L8B91:  .word DoorAction0
L8B93:  .word DoorAction1
L8B95:  .word DoorAction2
L8B97:  .word DoorAction3
L8B99:  .word DoorAction4
L8B9B:  .word DoorAction5

DoorAction0:
L8B9D:  INC $0300,X
L8BA0:  LDA #$30
L8BA2:  JSR SetProjectileAnim
L8BA5:  JSR ObjActionSubRoutine8CFB
L8BA8:  LDY $0307,X
L8BAB:  LDA ObjActionAnimTable,Y
L8BAE:  STA $030F,X
ObjActionSubRoutine8BB1:
L8BB1:  LDA $0307,X
L8BB4:  CMP #$03
L8BB6:  BNE L8BBA
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
L8BCE:  JMP AnimDrawObject

ObjActionAnimTable:
L8BD1:  .byte $05, $01, $0A, $01

DoorAction1:
L8BD5:  LDA $030A,X
L8BD8:  AND #$04
L8BDA:  BEQ ObjActionSubRoutine8BB1
L8BDC:  DEC $030F,X
L8BDF:  BNE ObjActionSubRoutine8BB1
L8BE1:  LDA #$03
L8BE3:  CMP $0307,X
L8BE6:  BNE L8BEE
L8BE8:  LDY $010B
L8BEB:  INY 
L8BEC:  BNE ObjActionSubRoutine8BB1
L8BEE:  STA $0300,X
L8BF1:  LDA #$50
L8BF3:  STA $030F,X
L8BF6:  LDA #$2C
L8BF8:  STA $0305,X
L8BFB:  SEC 
L8BFC:  SBC #$03
L8BFE:  JMP ObjActionSubRoutine8C7E

DoorAction2:
L8C01:  LDA DoorStatus
L8C03:  BEQ L8C1D
L8C05:  LDA $030C
L8C08:  EOR $030C,X
L8C0B:  LSR 
L8C0C:  BCS L8C1D
L8C0E:  LDA $030E
L8C11:  EOR $030E,X
L8C14:  BMI L8C1D
L8C16:  LDA #$04
L8C18:  STA $0300,X
L8C1B:  BNE L8C73
L8C1D:  LDA $0306,X
L8C20:  CMP $0305,X
L8C23:  BCC L8C73
L8C25:  LDA $030F,X
L8C28:  CMP #$50
L8C2A:  BNE L8C57
L8C2C:  JSR ObjActionSubRoutine8CF7
L8C2F:  LDA $0307,X
L8C32:  CMP #$01
L8C34:  BEQ L8C57
L8C36:  CMP #$03
L8C38:  BEQ L8C57
L8C3A:  LDA #$0A
L8C3C:  STA $09
L8C3E:  LDA $030C,X
L8C41:  STA $08
L8C43:  LDY $50
L8C45:  TXA 
L8C46:  JSR Amul16
L8C49:  BCC L8C4C
L8C4B:  DEY 
L8C4C:  TYA 
L8C4D:  JSR MapScrollRoutine
L8C50:  LDA #$00
L8C52:  STA $0300,X
L8C55:  BEQ L8C73
L8C57:  LDA $2D
L8C59:  LSR 
L8C5A:  BCS L8C73
L8C5C:  DEC $030F,X
L8C5F:  BNE L8C73
ObjActionSubRoutine8C61:
L8C61:  LDA #$01
L8C63:  STA $030F,X
L8C66:  JSR ObjActionSubRoutine8CFB
L8C69:  LDA #$02
L8C6B:  STA $0300,X
L8C6E:  JSR ObjActionSubRoutine8C76
ObjActionSubRoutine8C71:
L8C71:  LDX PageIndex
L8C73:  JMP ObjActionSubRoutine8BB1

ObjActionSubRoutine8C76:
L8C76:  LDA #$30
L8C78:  STA $0305,X
L8C7B:  SEC 
L8C7C:  SBC #$02
ObjActionSubRoutine8C7E:
L8C7E:  JSR SetProjectileAnim2
L8C81:  JMP SFX_Door

DoorAction3:
L8C84:  LDA DoorStatus
L8C86:  CMP #$05
L8C88:  BCS L8CC3
L8C8A:  JSR ObjActionSubRoutine8CFB
L8C8D:  JSR ObjActionSubRoutine8C76
L8C90:  LDX PageIndex
L8C92:  LDA $91
L8C94:  BEQ L8CA7
L8C96:  TXA 
L8C97:  JSR Adiv16
L8C9A:  EOR $91
L8C9C:  LSR 
L8C9D:  BCC L8CA7
L8C9F:  LDA $76
L8CA1:  EOR #$07
L8CA3:  STA $76
L8CA5:  STA $1C
L8CA7:  INC $0300,X
L8CAA:  LDA #$00
L8CAC:  STA $91
L8CAE:  LDA $0307,X
L8CB1:  CMP #$03
L8CB3:  BNE L8CC3
L8CB5:  TXA 
L8CB6:  JSR Amul16
L8CB9:  BCS L8CC0
L8CBB:  JSR TourianMusic
L8CBE:  BNE L8CC3
L8CC0:  JSR MotherBrainMusic
L8CC3:  JMP ObjActionSubRoutine8C71

DoorAction4:
L8CC6:  LDA DoorStatus
L8CC8:  CMP #$05
L8CCA:  BNE L8CED
L8CCC:  TXA 
L8CCD:  EOR #$10
L8CCF:  TAX 
L8CD0:  LDA #$06
L8CD2:  STA $0300,X
L8CD5:  LDA #$2C
L8CD7:  STA $0305,X
L8CDA:  SEC 
L8CDB:  SBC #$03
L8CDD:  JSR SetProjectileAnim2
L8CE0:  JSR SFX_Door
L8CE3:  JSR SelectSamusPal
L8CE6:  LDX PageIndex
L8CE8:  LDA #$02
L8CEA:  STA $0300,X
L8CED:  JMP ObjActionSubRoutine8BB1

DoorAction5:
L8CF0:  LDA DoorStatus
L8CF2:  BNE L8CED
L8CF4:  JMP ObjActionSubRoutine8C61

ObjActionSubRoutine8CF7:
L8CF7:  LDA #$FF
L8CF9:  BNE L8CFD
ObjActionSubRoutine8CFB:
L8CFB:  LDA #$4E
L8CFD:  PHA 
L8CFE:  LDA #$50
L8D00:  STA $02
L8D02:  TXA 
L8D03:  JSR Adiv16
L8D06:  AND #$01
L8D08:  TAY 
L8D09:  LDA DoorDataTable,Y
L8D0C:  STA $03
L8D0E:  LDA $030C,X
L8D11:  STA $0B
L8D13:  JSR MakeWRAMPtr
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
L8D24:  BNE L8D19
L8D26:  LDX PageIndex
L8D28:  TXA 
L8D29:  JSR Adiv8
L8D2C:  AND #$06
L8D2E:  TAY 
L8D2F:  LDA $04
L8D31:  STA $005C,Y
L8D34:  LDA $05
L8D36:  STA $005D,Y
L8D39:  RTS

DoorDataTable:
L8D3A:  .byte $E8, $10, $60, $AD, $91, $69, $8D, $78, $68, $AD, $92, $69, $8D, $79, $68, $A9 
L8D4A:  .byte $00, $85, $00, $85, $02, $AD, $97, $69, $29, $80, $F0, $06, $A5, $00, $09, $80
L8D5A:  .byte $85, $00, $AD, $97, $69, $29

