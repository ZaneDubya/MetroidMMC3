;----------------------------------------[Read joy pad status ]--------------------------------------

;The following routine reads the status of both joypads

ReadJoyPads:
    ldx #$00                        ;Load x with #$00. Used to read status of joypad 1.
    stx $01                         ;
    jsr ReadOnePad                  ;
    inx                             ;Load x with #$01. Used to read status of joypad 2.
    inc $01                         ;

ReadOnePad:
    ldy #$01                        ;These lines strobe the -->       
    sty CPUJoyPad1                  ;joystick to enable the -->
    dey                             ;program to read the -->
    sty CPUJoyPad1                  ;buttons pressed.
        
    ldy #$08                        ;Do 8 buttons.
    pha                             ;Store A.
    lda CPUJoyPad1,x                ;Read button status. Joypad 1 or 2.
    sta $00                         ;Store button press at location $00.
    lsr                             ;Move button push to carry bit.
    ora $00                         ;If joystick not connected, -->
    lsr                             ;fills Joy1Status with all 1s.
    pla                             ;Restore A.
    rol                             ;Add button press status to A.
    dey                             ;Loop 8 times to get -->
    bne -                           ;status of all 8 buttons.

    ldx $01                         ;Joypad #(0 or 1).
    ldy Joy1Status,x                ;Get joypad status of previous refresh.
    sty $00                         ;Store at $00.
    sta Joy1Status,x                ;Store current joypad status.
    eor $00                         ;
    beq +                           ;Branch if no buttons changed.
    lda $00                         ;                       
    and #$BF                        ;Remove the previous status of the B button.
    sta $00                         ;
    eor Joy1Status,x                ;
    and Joy1Status,x                ;Save any button changes from the current frame-->
    sta Joy1Change,x                ;and the last frame to the joy change addresses.
    sta Joy1Retrig,x                ;Store any changed buttons in JoyRetrig address.
    ldy #$20                        ;
    lda Joy1Status,x                ;Checks to see if same buttons are being-->
    cmp $00                         ;pressed this frame as last frame.-->
    bne +                           ;If none, branch.
    dec RetrigDelay1,x              ;Decrement RetrigDelay if same buttons pressed.
    bne ++                          ;               
    sta Joy1Retrig,x                ;Once RetrigDelay=#$00, store buttons to retrigger.
    ldy #$08                        ;
    sty RetrigDelay1,x              ;Reset retrigger delay to #$20(32 frames)-->
    rts                             ;or #$08(8 frames) if already retriggering.