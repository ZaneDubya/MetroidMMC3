;------------------------------[ Random Numbers ]-------------------------------
;This routine generates pseudo random numbers and updates those numbers
;every frame. The random numbers are used for several purposes including
;password scrambling and determinig what items, if any, an enemy leaves
;behind after it is killed.

RandomNumbers:
    txa                             ;               
    pha                             ;
    ldx #$05                        ;
*   lda RandomNumber1               ;
    clc                             ;
    adc #$05                        ;
    sta RandomNumber1               ;2E is increased by #$19 every frame and-->
    lda RandomNumber2               ;2F is increased by #$5F every frame.                   
    clc                             ;
    adc #$13                        ;
    sta RandomNumber2               ;
    dex                             ;
    bne -                           ;
    pla                             ;
    tax                             ;
    lda RandomNumber1               ;
    rts                             ;
    
;--------------------------------[ Simple divide and multiply routines ]-----------------------------

Adiv32: 
LC2BE:  lsr                             ;Divide by 32.

Adiv16: 
LC2BF:  lsr                             ;Divide by 16.

Adiv8:  
LC2C0:  lsr                             ;Divide by 8.
LC2C1:  lsr                             ;
LC2C2:  lsr                             ;Divide by shifting A right.
LC2C3:  rts                             ;

Amul32: 
LC2C4:  asl                             ;Multiply by 32.

Amul16: 
LC2C5:  asl                             ;Multiply by 16.

Amul8:
LC2C6:  asl                             ;Multiply by 8.
LC2C7:  asl                             ;
LC2C8:  asl                             ;Multiply by shifting A left.
LC2C9:  rts                             ;

;----------------------------------------[ Math routines ]-------------------------------------------

TwosCompliment:
LC3D4:  eor #$FF                        ;
LC3D6:  clc                             ;Generate twos compliment of value stored in A.
LC3D7:  adc #$01                        ;
LC3D9:  rts                             ;

;The following two routines add a Binary coded decimal (BCD) number to another BCD number.
;A base number is stored in $03 and the number in A is added/subtracted from $03.  $01 and $02 
;contain the lower and upper digits of the value in A respectively.  If an overflow happens after
;the addition/subtraction, the carry bit is set before the routine returns.

Base10Add:
LC3DA:  jsr ExtractNibbles              ;Separate upper 4 bits and lower 4 bits.
LC3DD:  adc $01                         ;Add lower nibble to number.
LC3DF:  cmp #$0A                        ;
LC3E1:  bcc +                           ;If result is greater than 9, add 5 to create-->
LC3E3:  adc #$05                        ;valid result(skip #$0A thru #$0F).
LC3E5:* clc                             ;
LC3E6:  adc $02                         ;Add upper nibble to number.
LC3E8:  sta $02                         ;
LC3EA:  lda $03                         ;
LC3EC:  and #$F0                        ;Keep upper 4 bits of HealthLo/HealthHi in A.
LC3EE:  adc $02                         ;
LC3F0:  bcc ++                          ;
LC3F2:* adc #$5F                        ;If upper result caused a carry, add #$5F to create-->
LC3F4:  sec                             ;valid result. Set carry indicating carry to next digit.
LC3F5:  rts                             ;
LC3F6:* cmp #$A0                        ;If result of upper nibble add is greater than #$90,-->
LC3F8:  bcs --                          ;Branch to add #$5F to create valid result.
LC3FA:  rts                             ;

Base10Subtract:
LC3FB:  jsr ExtractNibbles              ;Separate upper 4 bits and lower 4 bits.
LC3FE:  sbc $01                         ;Subtract lower nibble from number.
LC400:  sta $01                         ;
LC402:  bcs +                           ;If result is less than zero, add 10 to create-->
LC404:  adc #$0A                        ;valid result.
LC406:  sta $01                         ;
LC408:  lda $02                         ;
LC40A:  adc #$0F                        ;Adjust $02 to account for borrowing.
LC40C:  sta $02                         ;
LC40E:* lda $03                         ;Keep upper 4 bits of HealthLo/HealthHi in A.
LC410:  and #$F0                        ;
LC412:  sec                             ;
LC413:  sbc $02                         ;If result is greater than zero, branch to finish.
LC415:  bcs +                           ;
LC417:  adc #$A0                        ;Add 10 to create valid result.
LC419:  clc                             ;
LC41A:* ora $01                         ;Combine A and $01 to create final value.
LC41C:  rts                             ;

ExtractNibbles:
LC41D:  pha                             ;
LC41E:  and #$0F                        ;Lower 4 bits of value to change HealthLo/HealthHi by.
LC420:  sta $01                         ;
LC422:  pla                             ;
LC423:  and #$F0                        ;Upper 4 bits of value to change HealthLo/HealthHi by.
LC425:  sta $02                         ;
LC427:  lda $03                         ;
LC429:  and #$0F                        ;Keep lower 4 bits of HealthLo/HealthHi in A.
LC42B:  rts                             ;

;-----------------------------------------[ Add 4 to x ]---------------------------------------------

Xplus4:
LE193:  inx                             ;
LE194:  inx                             ;
LE195:  inx                             ;Add 4 to value stored in X.
LE196:  inx                             ;
LE197:  rts                             ;

;------------------------------------[ Convert hex to decimal ]--------------------------------------

;Convert 8-bit value in A to 3 decimal digits. Upper digit put in $02, middle in $01 and lower in $00.

HexToDec:
LE198:  ldy #100                        ;Find upper digit.
LE19A:  sty $0A                         ;
LE19C:  jsr GetDigit                    ;Extract hundreds digit.
LE19F:  sty $02                         ;Store upper digit in $02.
LE1A1:  ldy #10                         ;Find middle digit.
LE1A3:  sty $0A                         ;
LE1A5:  jsr GetDigit                    ;Extract tens digit.
LE1A8:  sty $01                         ;Store middle digit in $01.
LE1AA:  sta $00                         ;Store lower digit in $00
LE1AC:  rts                             ;

GetDigit:
LE1AD:  ldy #$00                        ;
LE1AF:  sec                             ;
LE1B0:* iny                             ;
LE1B1:  sbc $0A                         ;Loop and subtract value in $0A from A until carry flag-->
LE1B3:  bcs -                           ;is not set.  The resulting number of loops is the decimal-->
LE1B5:  dey                             ;number extracted and A is the remainder.
LE1B6:  adc $0A                         ;
LE1B8:  rts                             ;