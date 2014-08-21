;----------------------------------------[Read joy pad status ]--------------------------------------

;The following routine reads the status of both joypads

ReadJoyPads:
LC215:  ldx #$00                        ;Load x with #$00. Used to read status of joypad 1.
LC217:  stx $01                         ;
LC219:  jsr ReadOnePad                  ;
LC21C:  inx                             ;Load x with #$01. Used to read status of joypad 2.
LC21D:  inc $01                         ;

ReadOnePad:
LC21F:  ldy #$01                        ;These lines strobe the -->       
LC221:  sty CPUJoyPad1                  ;joystick to enable the -->
LC224:  dey                             ;program to read the -->
LC225:  sty CPUJoyPad1                  ;buttons pressed.
        
LC228:  ldy #$08                        ;Do 8 buttons.
LC22A:* pha                             ;Store A.
LC22B:  lda CPUJoyPad1,x                ;Read button status. Joypad 1 or 2.
LC22E:  sta $00                         ;Store button press at location $00.
LC230:  lsr                             ;Move button push to carry bit.
LC231:  ora $00                         ;If joystick not connected, -->
LC233:  lsr                             ;fills Joy1Status with all 1s.
LC234:  pla                             ;Restore A.
LC235:  rol                             ;Add button press status to A.
LC236:  dey                             ;Loop 8 times to get -->
LC237:  bne -                           ;status of all 8 buttons.

LC239:  ldx $01                         ;Joypad #(0 or 1).
LC23B:  ldy Joy1Status,x                ;Get joypad status of previous refresh.
LC23D:  sty $00                         ;Store at $00.
LC23F:  sta Joy1Status,x                ;Store current joypad status.
LC241:  eor $00                         ;
LC243:  beq +                           ;Branch if no buttons changed.
LC245:  lda $00                         ;                       
LC247:  and #$BF                        ;Remove the previous status of the B button.
LC249:  sta $00                         ;
LC24B:  eor Joy1Status,x                ;
LC24D:* and Joy1Status,x                ;Save any button changes from the current frame-->
LC24F:  sta Joy1Change,x                ;and the last frame to the joy change addresses.
LC251:  sta Joy1Retrig,x                ;Store any changed buttons in JoyRetrig address.
LC253:  ldy #$20                        ;
LC255:  lda Joy1Status,x                ;Checks to see if same buttons are being-->
LC257:  cmp $00                         ;pressed this frame as last frame.-->
LC259:  bne +                           ;If none, branch.
LC25B:  dec RetrigDelay1,x              ;Decrement RetrigDelay if same buttons pressed.
LC25D:  bne ++                          ;               
LC25F:  sta Joy1Retrig,x                ;Once RetrigDelay=#$00, store buttons to retrigger.
LC261:  ldy #$08                        ;
LC263:* sty RetrigDelay1,x              ;Reset retrigger delay to #$20(32 frames)-->
LC265:* rts                             ;or #$08(8 frames) if already retriggering.