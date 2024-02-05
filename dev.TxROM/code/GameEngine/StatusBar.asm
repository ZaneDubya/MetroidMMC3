;---------------------------------------[ Display status bar ]---------------------------------------

;Displays Samus' status bar components.

DisplayBar:
LE0C1:  ldy #$00                        ;Reset data index.
LE0C3:  lda SpritePagePos               ;Load current sprite index.
LE0C5:  pha                             ;save sprite page pos.
LE0C6:  tax                             ;
LE0C7:* lda DataDisplayTbl,y            ;
LE0CA:  sta Sprite00RAM,x               ;Stor contents of DataDisplayTbl in sprite RAM.
LE0CD:  inx                             ;
LE0CE:  iny                             ;
LE0CF:  cpy #$28                        ;10*4. At end of DataDisplayTbl? If not, loop to-->
LE0D1:  bne -                           ;load next byte from table.

;Display 2-digit health count.
LE0D3:  stx SpritePagePos               ;Save new location in sprite RAM.
LE0D5:  pla                             ;Restore initial sprite page pos.
LE0D6:  tax                             ;
LE0D7:  lda HealthHi                    ;
LE0DA:  and #$0F                        ;Extract upper health digit.
LE0DC:  jsr SPRWriteDigit               ;Display digit on screen.
LE0DF:  lda HealthLo                    ;
LE0E2:  jsr Adiv16                      ;Move lower health digit to 4 LSBs.
LE0E5:  jsr SPRWriteDigit               ;Display digit on screen.
LE0E8:  ldy EndTimerHi                  ;
LE0EB:  iny                             ;Is Samus in escape sequence?-->
LE0EC:  bne ++                          ;If so, branch.
LE0EE:  ldy MaxMissiles                 ;
LE0F1:  beq +                           ;Don't show missile count if Samus has no missile containers.

;Display 3-digit missile count.
LE0F3:  lda MissileCount                ;
LE0F6:  jsr HexToDec                    ;Convert missile hex count to decimal cout.
LE0F9:  lda $02                         ;Upper digit.
LE0FB:  jsr SPRWriteDigit               ;Display digit on screen.
LE0FE:  lda $01                         ;Middle digit.
LE100:  jsr SPRWriteDigit               ;Display digit on screen.
LE103:  lda $00                         ;Lower digit.
LE105:  jsr SPRWriteDigit               ;Display digit on screen.
LE108:  bne +++                         ;Branch always.

;Samus has no missiles, erase missile sprite.
LE10A:* lda #$FF                        ;"Blank" tile.
LE10C:  cpx #$F4                        ;If at last 3 sprites, branch to skip.
LE10E:  bcs ++                          ;
LE110:  sta Sprite03RAM+1,x             ;Erase left half of missile.
LE113:  cpx #$F0                        ;If at last 4 sprites, branch to skip.
LE115:  bcs ++                          ;
LE117:  sta Sprite04RAM+1,x             ;Erase right half of missile.
LE11A:  bne ++                          ;Branch always.

;Display 3-digit end sequence timer.
LE11C:* lda EndTimerHi                  ;
LE11F:  jsr Adiv16                      ;Upper timer digit.
LE122:  jsr SPRWriteDigit               ;Display digit on screen.
LE125:  lda EndTimerHi                  ;
LE128:  and #$0F                        ;Middle timer digit.
LE12A:  jsr SPRWriteDigit               ;Display digit on screen.
LE12D:  lda EndTimerLo                  ;
LE130:  jsr Adiv16                      ;Lower timer digit.
LE133:  jsr SPRWriteDigit               ;Display digit on screen.
LE136:  lda #$58                        ;"TI" sprite(left half of "TIME").
LE138:  sta Sprite00RAM+1,x             ;
LE13B:  inc Sprite00RAM+2,x             ;Change color of sprite.
LE13E:  cpx #$FC                        ;If at last sprite, branch to skip.
LE140:  bcs +                           ;
LE142:  lda #$59                        ;"ME" sprite(right half of "TIME").
LE144:  sta Sprite01RAM+1,x             ;
LE147:  inc Sprite01RAM+2,x             ;Change color of sprite.

LE14A:* ldx SpritePagePos               ;Restore initial sprite page pos.
LE14C:  lda TankCount                   ;
LE14F:  beq ++                          ;Branch to exit if Samus has no energy tanks.

;Display full/empty energy tanks.
LE151:  sta $03                         ;Temp store tank count.
LE153:  lda #$40                        ;X coord of right-most energy tank.
LE155:  sta $00                         ;Energy tanks are drawn from right to left.
LE157:  ldy #$6F                        ;"Full energy tank" tile.
LE159:  lda HealthHi                    ;
LE15C:  jsr Adiv16                      ;/16. A contains # of full energy tanks.
LE15F:  sta $01                         ;Storage of full tanks.
LE161:  bne AddTanks                    ;Branch if at least 1 tank is full.
LE163:  dey                             ;Else switch to "empty energy tank" tile.

AddTanks:
LE164:  jsr AddOneTank                  ;Add energy tank to display.
LE167:  dec $01                         ;Any more full energy tanks left?-->
LE169:  bne +                           ;If so, then branch.-->
LE16B:  dey                             ;Otherwise, switch to "empty energy tank" tile.
LE16C:* dec $03                         ;done all tanks?-->
LE16E:  bne AddTanks                    ;if not, loop to do another.

LE170:  stx SpritePagePos               ;Store new sprite page position.
LE172:* rts                             ;

;----------------------------------------[Sprite write digit ]---------------------------------------

;A=value in range 0..9. #$A0 is added to A(the number sprites begin at $A0), and the result is stored
;as the tile # for the sprite indexed by X.

SPRWriteDigit:
LE173:  ora #$A0                        ;#$A0 is index into pattern table for numbers.
LE175:  sta Sprite00RAM+1,x             ;Store proper nametable pattern in sprite RAM.
LE178:  jmp Xplus4                      ;Find next sprite pattern table byte.

;----------------------------------[ Add energy tank to display ]------------------------------------

;Add energy tank to Samus' data display.

AddOneTank:
LE17B:  lda #$17                        ;Y coord-1.
LE17D:  sta Sprite00RAM,x               ;
LE180:  tya                             ;Tile value.
LE181:  sta Sprite00RAM+1,x             ;
LE184:  lda #$01                        ;Palette #.
LE186:  sta Sprite00RAM+2,x             ;
LE189:  lda $00                         ;X coord.
LE18B:  sta Sprite00RAM+3,x             ;
LE18E:  sec                             ;
LE18F:  sbc #$0A                        ;Find x coord of next energy tank.
LE191:  sta $00                         ;
		jmp Xplus4
		rts
;-------------------------------------[ Status bar sprite data ]-------------------------------------

;Sprite data for Samus' data display

DataDisplayTbl:
LE1B9:  .byte $21,$A0,$01,$30           ;Upper health digit.
LE1BD:  .byte $21,$A0,$01,$38           ;Lower health digit.
LE1C1:  .byte $2B,$FF,$01,$28           ;Upper missile digit.
LE1C5:  .byte $2B,$FF,$01,$30           ;Middle missile digit.
LE1C9:  .byte $2B,$FF,$01,$38           ;Lower missile digit.
LE1CD:  .byte $2B,$5E,$00,$18           ;Left half of missile.
LE1D1:  .byte $2B,$5F,$00,$20           ;Right half of missile.
LE1D5:  .byte $21,$76,$01,$18           ;E
LE1D9:  .byte $21,$7F,$01,$20           ;N
LE1DD:  .byte $21,$3A,$00,$28           ;..