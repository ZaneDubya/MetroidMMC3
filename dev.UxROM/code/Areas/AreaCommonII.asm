; METROID source code
; (C) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, 
;      GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Can be reassembled using Ophis.

;Area ROM Bank Common Routines & Data II ($B200 - $BFFF)

.require "../Defines.asm"
.require "../GameEngineDeclarations.asm"

;------------------------------------------[ Sound Engine ]------------------------------------------

;SFXdata. The top four entries are used by the noise music player for drum beats.
LB200:  .byte $00                       ;Base for drum beat music data.

DrumBeat00SFXData:
LB201:  .byte $10, $01, $18             ;Noise channel music data #$01.
DrumBeat01SFXData:
LB204:  .byte $00, $01, $38             ;Noise channel music data #$04.
DrumBeat02SFXData:
LB207:  .byte $01, $02, $40             ;Noise channel music data #$07.
DrumBeat03SFXData:
LB20A:  .byte $00, $09, $58             ;Noise channel music data #$0A.
GamePausedSFXData:
LB20D:  .byte $80, $7F, $80, $48
ScrewAttSFXData:
LB211:  .byte $35, $7F, $00, $B0
MissileLaunchSFXData:
LB215:  .byte $19, $7F, $0E, $A0
BombExplodeSFXData:
LB219:  .byte $0D, $7F, $0F, $08
SamusWalkSFXData:
LB21D:  .byte $16, $7F, $0B, $18
SpitFlameSFXData:
LB221:  .byte $13, $7F, $0E, $F8
SamusHitSQ1SQ2SFXData:
LC225:  .byte $C1, $89, $02, $0F
BossHitSQ2SFXData:
LB229:  .byte $34, $BA, $E0, $05
BossHitSQ1SFXData:
LB22D:  .byte $34, $BB, $CE, $05
IncorrectPasswordSQ1SFXData:
LB231:  .byte $B6, $7F, $00, $C2
IncorrectPasswordSQ2SFXData:
LB235:  .byte $B6, $7F, $04, $C2
TimeBombTickSFXData:
LB239:  .byte $17, $7F, $66, $89
EnergyPickupSFXData:
LB23D:  .byte $89, $7F, $67, $18
MissilePickupSFXData:
LB241:  .byte $8B, $7F, $FD, $28
MetalSFXData:
LB245:  .byte $02, $7F, $A8, $F8
LongRangeShotSFXData:
LB249:  .byte $D7, $83, $58, $F8
ShortRangeShotSFXData:
LB24D:  .byte $D6, $82, $58, $F8
JumpSFXData:
LB251:  .byte $95, $8C, $40, $B9
EnemyHitSFXData:
LB255:  .byte $1D, $9A, $20, $8F
BugOutOFHoleSFXData:
LB259:  .byte $16, $8D, $E0, $42
WaveBeamSFXData:
LB25D:  .byte $19, $7F, $6F, $40
IceBeamSFXData:
LB261:  .byte $18, $7F, $80, $40
BombLaunch1SFXData:
LB265:  .byte $07, $7F, $40, $28
BombLaunch2SFXData:
LB269:  .byte $07, $7F, $45, $28
SamusToBallSFXData:
LB26D:  .byte $7F, $7F, $DD, $3B
MetroidHitSFXData:
LB26E:  .byte $7F, $7F, $FF, $98
SamusDieSFXData:
LB275:  .byte $7F, $7F, $40, $08
SamusBeepSFXData:
LB279:  .byte $09, $7F, $30, $48
BigEnemyHitSFXData:
LB27D:  .byte $03, $7F, $42, $18
StatueRaiseSFXData:
LB281:  .byte $03, $7F, $11, $09
DoorSFXData:
LB285:  .byte $7F, $7F, $30, $B2

;The following table is used by the CheckSFXFlag routine.  The first two bytes of each row
;are the address of the pointer table used for handling SFX and music  routines for set flags.
;The second pair of bytes is the address of the routine to next jump to if no SFX or music
;flags were found.  The final byte represents what type of channel is currently being
;processed: 0=Noise, 1=SQ1, 3=Triangle, 4=Multiple channels.

ChooseNextSFXRoutineTbl:

LB289:  .word $B2BB, $B322              ;Noise init SFX         (1st).
LB28D:  .byte $00
        
LB28E:  .word $B2CB, $B4EE              ;Noise continue SFX     (2nd).
LB292:  .byte $00

LB293:  .word $B2DB, $B330              ;SQ1 init SFX           (5th).
LB297:  .byte $01

LB298:  .word $B2EB, $B4EE              ;SQ2 continue SFX       (6th).
LB29C:  .byte $01

LB29D:  .word $B2FB, $B344              ;Triangle init SFX      (7th).
LB2A1:  .byte $03

LB2A2:  .word $B30B, $B4EE              ;Triangle continue SFX  (8th).
LB2A6:  .byte $03

LB2A7:  .word $BC06, $B35C              ;Multi init SFX         (3rd).
LB2AB:  .byte $04

LB2AC:  .word $BC16, $B364              ;Multi continue SFX     (4th).
LB2B0:  .byte $04

LB2B1:  .word $BC26, $BC4B              ;temp flag Music        (10th).
LB2B5:  .byte $00

LB2B6:  .word $BC26, $BC3D              ;Music                  (9th).
LB2BA:  .byte $00

;The tables below contain addresses for SFX handling routines.

;Noise Init SFX handling routine addresses:
LB2BB:  .word $B4EE                     ;No sound.
LB2BD:  .word $B52B                     ;Screw attack init SFX.
LB2BF:  .word $B56E                     ;Missile launch init SFX.
LB2C1:  .word $B583                     ;Bomb explode init SFX.
LB2C3:  .word $B598                     ;Samus walk init SFX.
LB2C5:  .word $B50F                     ;Spit flame init SFX.
LB2C7:  .word $B4EE                     ;No sound.
LB2C9:  .word $B4EE                     ;No sound.

;Noise Continue SFX handling routine addresses:

LB2CB:  .word $B4EE                     ;No sound.
LB2CD:  .word $B539                     ;Screw attack continue SFX.
LB2CF:  .word $B57B                     ;Missile launch continue SFX.
LB2D1:  .word $B58A                     ;Bomb explode continue SFX.
LB2D3:  .word $B58A                     ;Samus walk continue SFX.
LB2D5:  .word $B516                     ;Spit flame continue SFX.
LB2D7:  .word $B4EE                     ;No sound.
LB2D9:  .word $B4EE                     ;No sound.

;SQ1 Init SFX handling routine addresses:

LB2DB:  .word $B6CD                     ;Missile pickup init SFX.
LB2DD:  .word $B6E7                     ;Energy pickup init SFX.
LB2DF:  .word $B735                     ;Metal init SFX.
LB2E1:  .word $B716                     ;Bullet fire init SFX.
LB2E3:  .word $B73C                     ;Bird out of hole init SFX.
LB2E5:  .word $B710                     ;Enemy hit init SFX.
LB2E7:  .word $B703                     ;Samus jump init SFX.
LB2E9:  .word $B77A                     ;Wave beam init SFX.

;SQ1 Continue SFX handling routine addresses:

LB2EB:  .word $B6B0                     ;Missile pickup continue SFX.
LB2ED:  .word $B6D3                     ;Energy pickup continue SFX.
LB2EF:  .word $B6ED                     ;Metal continue SFX.
LB2F1:  .word $B74F                     ;Bullet fire continue SFX.
LB2F3:  .word $B6ED                     ;Bird out of hole continue SFX.
LB2F5:  .word $B6ED                     ;Enemy hit continue SFX.
LB2F7:  .word $B6ED                     ;Samus jump continue SFX.
LB2F9:  .word $B781                     ;Wave beam continue SFX.

;Triangle init handling routine addresses:

LB2FB:  .word $B8D2                     ;Samus die init SFX.
LB2FD:  .word $B7AC                     ;Door open close init SFX.
LB2FF:  .word $B8A7                     ;Metroid hit init SFX.
LB301:  .word $B921                     ;Statue raise init SFX.
LB303:  .word $B7D9                     ;Beep init SFX.
LB305:  .word $B7EF                     ;Big enemy hit init SFX.
LB307:  .word $B834                     ;Samus to ball init SFX.
LB309:  .word $B878                     ;Bomb launch init SFX.

;Triangle continue handling routine addresses:

LB30B:  .word $B8ED                     ;Samus die continue SFX.
LB30E:  .word $B7CB                     ;Door open close continue SFX.
LB30F:  .word $B8B1                     ;Metroid hit continue SFX.
LB311:  .word $B940                     ;Statue raise continue SFX.
LB313:  .word $B7E7                     ;Beep continue SFX.
LB315:  .word $B80E                     ;Big enemy hit continue SFX.
LB317:  .word $B84F                     ;Samus to ball continue SFX.
LB319:  .word $B87F                     ;Bomb launch continue SFX.

LoadNoiseSFXInitFlags:
LB31B:  LDA NoiseSFXFlag                ;Load A with Noise init SFX flags, (1st SFX cycle).
LB31E:  LDX #$89                        ;Lower address byte in ChooseNextSFXRoutineTbl.
LB320:  BNE GotoSFXCheckFlags           ;Branch always.

LoadNoiseSFXContFlags:
LB322:  LDA NoiseContSFX                ;Load A with Noise continue flags, (2nd SFX cycle).
LB325:  LDX #$8E                        ;Lower address byte in ChooseNextSFXRoutineTbl.
LB327:  BNE GotoSFXCheckFlags           ;Branch always.

LoadSQ1SFXInitFlags:
LB329:  LDA SQ1SFXFlag                  ;Load A with SQ1 init flags, (5th SFX cycle).
LB32C:  LDX #$93                        ;Lower address byte in ChooseNextSFXRoutineTbl.
LB32E:  BNE GotoSFXCheckFlags           ;Branch always.

LoadSQ1SFXContFlags:
LB330:  LDA SQ1ContSFX                  ;Load A with SQ1 continue flags, (6th SFX cycle).
LB333:  LDX #$98                        ;Lower address byte in ChooseNextSFXRoutineTbl.
LB335:  BNE GotoSFXCheckFlags           ;Branch always.

GotoSFXCheckFlags:
LB337:  JSR CheckSFXFlag                ;($B4BD)Checks to see if SFX flags set.         
LB33A:  JMP ($00E2)                     ;if no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling routine.
LoadSTriangleSFXInitFlags:
LB33D:  LDA TriangleSFXFlag             ;Load A with Triangle init flags, (7th SFX cycle).
LB340:  LDX #$9D                        ;Lower address byte in ChooseNextSFXRoutineTbl.
LB342:  BNE GotoSFXCheckFlags           ;Brach always.

LoadTriangleSFXContFlags:
LB344:  LDA TriangleContSFX             ;Load A with Triangle continue flags, (8th SFX cycle).
LB347:  LDX #$A2                        ;Lower address byte in ChooseNextSFXRoutineTbl.
LB349:  BNE GotoSFXCheckFlags           ;Branch always.

LoadMultiSFXInitFlags:
LB34B:  LDA MultiSFXFlag                ;Load A with Multi init flags, (3rd SFX cycle).
LB34E:  LDX #$A7                        ;Lower address byte in ChooseNextSFXRoutineTbl.
LB350:  JSR CheckSFXFlag                ;($B4BD)Checks to see if SFX or music flags set.
LB353:  JSR FindMusicInitIndex          ;($BC53)Find bit containing music init flag.
LB356:  JSR Add8                        ;($BC64)Add 8 to MusicInitIndex.
LB359:  JMP ($00E2)                     ;If no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling subroutine.
LoadMultiSFXContFlags:
LB35C:  LDA MultiContSFX                ;Load A with $68C flags (4th SFX cycle).
LB35F:  LDX #$AC                        ;Lower address byte in ChooseNextSFXRoutineTbl.
LB361:  JMP GotoSFXCheckFlags           ;($B337)Checks to see if SFX or music flags set.

LoadSQ1Flags:
LB364:  JSR LoadSQ1SFXInitFlags         ;($B329)Check for SQ1 init flags.
LB367:  RTS                             ;

LoadSQ1ChannelSFX:                      ;Used to determine which sound registers to change-->
LB368:  LDA #$00                        ;($4000 - $4003) - SQ1.
LB36A:  BEQ +                           ;Branch always.

LoadTriangleChannelSFX:                 ;Used to determine which sound registers to change-->
LB36C:  LDA #$08                        ;($4008 - $400B) - Triangle.
LB36E:  BNE +                           ;Branch always.

LoadNoiseChannelSFX:                    ;Used to determine which sound registers to change-->
LB370:  LDA #$0C                        ;($400C - $400F) - Noise.
LB372:  BNE +                           ;Branch always.

LoadSQ2ChannelSFX:                      ;Used to determine which sound registers to change-->
LB374:  LDA #$04                        ;($4004 - $4007) - SQ2.

LoadSFXData:
LB376:* STA $E0                         ;Lower address byte of desired APU control register.
LB378:  LDA #$40                        ;
LB37A:  STA $E1                         ;Upper address byte of desired APU control register.
LB37C:  STY $E2                         ;Lower address byte of data to load into sound channel.
LB37E:  LDA #$B2                        ;
LB380:  STA $E3                         ;Upper address byte of data to load into sound channel.
LB382:  LDY #$00                        ;Starting index for loading four byte sound data.

LoadSFXRegisters:
LB384:* LDA ($E2),Y                     ;Load A with SFX data byte.
LB386:  STA ($E0),Y                     ;Store A in SFX register.
LB388:  INY                             ;
LB389:  TYA                             ;The four registers associated with each sound-->
LB38A:  CMP #$04                        ;channel are loaded one after the other (the loop-->
LB38C:  BNE -                           ;repeats four times).
LB38E:  RTS                             ;

PauseSFX:
LB38F:* INC SFXPaused                   ;SFXPaused=#$01
LB392:  JSR ClearSounds                 ;($B43E)Clear sound registers of data.          
LB395:  STA PauseSFXStatus              ;PauseSFXStatus=#$00
LB398:  RTS                             ;

LB399:* LDA SFXPaused                   ;Has SFXPaused been set? if not, branch
LB39C:  BEQ --                          ;
LB39E:  LDA PauseSFXStatus              ;For the first #$12 frames after the game has been-->
LB3A1:  CMP #$12                        ;paused, play GamePaused SFX.  If paused for #$12-->
LB3A3:  BEQ ++                          ;frames or more, branch to exit.
LB3A5:  AND #$03                        ;
LB3A7:  CMP #$03                        ;Every fourth frame, repeat GamePaused SFX
LB3A9:  BNE +                           ;
LB3AB:  LDY #$0D                        ;Lower address byte of GamePaused SFX data(Base=$B200)
LB3AD:  JSR LoadSQ1ChannelSFX           ;($B368) Load GamePaused SFX data.
LB3B0:* INC PauseSFXStatus              ;
LB3B3:* RTS                             ;

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
LB3B4:  LDA #$C0                        ;Set APU to 5 frame cycle, disable frame interrupt.
LB3B6:  STA APUCommonCntrl1             ;
LB3B9:  LDA NoiseSFXFlag                ;is bit zero is set in NoiseSFXFlag(Silence-->
LB3BC:  LSR                             ;music)?  If yes, branch.
LB3BD:  BCS ++                          ;
LB3BF:  LDA MainRoutine                 ;
LB3C1:  CMP #$05                        ;Is game paused?  If yes, branch.
LB3C3:  BEQ ---                         ;
LB3C5:  LDA #$00                        ;Clear SFXPaused when game is running.
LB3C7:  STA SFXPaused                   ;
LB3CA:  JSR LoadNoiseSFXInitFlags       ;($B31B)Check noise SFX flags.
LB3CD:  JSR LoadMultiSFXInitFlags       ;($B34B)Check multichannel SFX flags.
LB3D0:  JSR LoadSTriangleSFXInitFlags   ;($B33D)Check triangle SFX flags.
LB3D3:  JSR LoadMusicTempFlags          ;($BC36)Check music flags.

ClearSFXFlags:
LB3D6:* LDA #$00                        ;
LB3D8:  STA NoiseSFXFlag                ;
LB3DB:  STA SQ1SFXFlag                  ;
LB3DE:  STA SQ2SFXFlag                  ;Clear all SFX flags.
LB3E1:  STA TriangleSFXFlag             ;
LB3E4:  STA MultiSFXFlag                ;
LB3E7:  STA MusicInitFlag               ;
LB3EA:  RTS                             ;

LB3EB:* JSR InitializeSoundAddresses    ;($B404)Prepare to start playing music.         
LB3EE:  BEQ --                          ;Branch always.

CheckRepeatMusic:
LB3F0:  LDA MusicRepeat                 ;
LB3F3:  BEQ +                           ;If music is supposed to repeat, reset music,-->
LB3F5:  LDA CurrentMusic                ;flags else branch to exit.
LB3F8:  STA CurrentMusicRepeat          ;
LB3FB:  RTS                             ;

CheckMusicFlags:
LB3FC:  LDA CurrentMusic                ;Loads A with current music flags and compares it-->
LB3FF:  CMP CurrentSFXFlags             ;with current SFX flags.  If both are equal,-->
LB402:  BEQ ++                          ;just clear music counters, else clear everything.

InitializeSoundAddresses:               ;
LB404:* JSR ClearMusicAndSFXAddresses   ;($B41D)Jumps to all subroutines needed to reset-->
LB407:  JSR ClearSounds                 ;($B43E)all sound addresses in order to start-->
LB40A:* JSR ClearSpecialAddresses       ;($B40E)playing music.
LB40D:  RTS                             ;

ClearSpecialAddresses:
LB40E:  LDA #$00                        ;       
LB410:  STA TriangleCounterCntrl        ;Clears addresses used for repeating music,-->
LB413:  STA SFXPaused                   ;pausing music and controlling triangle length.
LB416:  STA CurrentMusicRepeat          ;
LB419:  STA MusicRepeat                 ;
LB41C:  RTS                             ;

ClearMusicAndSFXAddresses:              ;
LB41D:  LDA #$00                        ;
LB41F:  STA SQ1InUse                    ;
LB422:  STA SQ2InUse                    ;
LB425:  STA TriangleInUse               ;
LB428:  STA WriteMultiChannelData       ;
LB42B:  STA NoiseContSFX                ;Clears any SFX or music--> 
LB42E:  STA SQ1ContSFX                  ;currently being played.
LB431:  STA SQ2ContSFX                  ;
LB434:  STA TriangleContSFX             ;
LB437:  STA MultiContSFX                ;
LB43A:  STA CurrentMusic                ;
LB43D:  RTS                             ;

ClearSounds:                            ;
LB43E:  LDA #$10                        ;
LB440:  STA SQ1Cntrl0                   ;
LB443:  STA SQ2Cntrl0                   ;
LB446:  STA NoiseCntrl0                 ;Clears all sounds that might be in-->
LB449:  LDA #$00                        ;The sound channel registers.
LB44B:  STA TriangleCntrl0              ;
LB44E:  STA DMCCntrl1                   ;
LB451:  RTS                             ;

SelectSFXRoutine:
LB452:  LDX ChannelType                 ;
LB455:  STA NoiseSFXLength,X            ;Stores frame length of SFX in corresponding address.
LB458:  TXA                             ;
LB459:  BEQ ++                          ;Branch if SFX uses noise channel.
LB45B:  CMP #$01                        ;
LB45D:  BEQ +                           ;Branch if SFX uses SQ1 channel.
LB45F:  CMP #$02                        ;
LB461:  BEQ MusicBranch00               ;Branch if SFX uses SQ2 channel.
LB463:  CMP #$03                        ;
LB465:  BEQ MusicBranch01               ;Branch if SFX uses triangle wave.
LB467:  RTS                             ;Exit if SFX routine uses no channels.

LB468:* JSR LoadSQ1ChannelSFX           ;($B368)Prepare to load SQ1 channel with data.
LB46B:  BEQ ++                          ;Branch always.
MusicBranch00:                          ;
LB46D:  JSR LoadSQ2ChannelSFX           ;($B374)Prepare to load SQ2 channel with data.
LB470:  BEQ ++                          ;Branch always.
MusicBranch01:                          ;
LB472:  JSR LoadTriangleChannelSFX      ;($B36C)Prepare to load triangle channel with data.
LB475:  BEQ ++                          ;Branch always.
LB477:* JSR LoadNoiseChannelSFX         ;($B370)Prepare to load noise channel with data.
LB47A:* JSR UpdateContFlags             ;($B493)Set continuation flags for this SFX.
LB47D:  TXA                             ;
LB47E:  STA NoiseInUse,X                ;Indicate sound channel is in use.
LB481:  LDA #$00                        ;
LB483:  STA ThisNoiseFrame,X            ;
LB486:  STA NoiseSFXData,X              ;Clears all the following addresses before going-->
LB489:  STA MultiSFXData,X              ;to the proper SFX handling routine.
LB48C:  STA ScrewAttackSFXData,X        ;
LB48F:  STA WriteMultiChannelData       ;
LB492:  RTS                             ;

UpdateContFlags:
LB493:* LDX ChannelType                 ;Loads X register with sound channel just changed.
LB496:  LDA NoiseContSFX,X              ;Clear existing continuation SFX-->
LB499:  AND #$00                        ;flags for that channel.
LB49B:  ORA CurrentSFXFlags             ;Load new continuation flags.
LB49E:  STA NoiseContSFX,X              ;Save results.
LB4A1:  RTS                             ;

ClearCurrentSFXFlags:
LB4A2:  LDA #$00                        ;Once SFX has completed, this block clears the-->
LB4A4:  STA CurrentSFXFlags             ;SFX flag from the current flag register.
LB4A7:  BEQ -                           ;

IncrementSFXFrame:
LB4A9:  LDX ChannelType                 ;Load SFX channel number.
LB4AC:  INC ThisNoiseFrame,X            ;increment current frame to play on given channel.
LB4AF:  LDA ThisNoiseFrame,X            ;Load current frame to play on given channel.
LB4B2:  CMP NoiseSFXLength,X            ;Check to see if current frame is last frame to play.
LB4B5:  BNE +                           ;
LB4B7:  LDA #$00                        ;If current frame is last frame,-->
LB4B9:  STA ThisNoiseFrame,X            ;reset current frame to 0.
LB4BC:* RTS                             ;

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
LB4BD:  STA CurrentSFXFlags             ;Store any set flags in $064D.
LB4C0:  STX $E4                         ;
LB4C2:  LDY #$B2                        ;
LB4C4:  STY $E5                         ;
LB4C6:  LDY #$00                        ;Y=0 for counting loop ahead.
LB4C8:* LDA ($E4),Y                     ;
LB4CA:  STA $00E0,Y                     ;See table above for values loaded into $E0-->
LB4CD:  INY                             ;thru $E3 during this loop.
LB4CE:  TYA                             ;
LB4CF:  CMP #$04                        ;Loop repeats four times to load the values.
LB4D1:  BNE -                           ;
LB4D3:  LDA ($E4),Y                     ;
LB4D5:  STA ChannelType                 ;#$00=SQ1,#$01=SQ2,#$02=Triangle,#$03=Noise
LB4D8:  LDY #$00                        ;Set y to 0 for counting loop ahead.
LB4DA:  LDA CurrentSFXFlags             ;
LB4DD:  PHA                             ;Push current SFX flags on stack.
LB4DE:* ASL CurrentSFXFlags             ;
LB4E1:  BCS +                           ;This portion of the routine loops a maximum of-->
LB4E3:  INY                             ;eight times looking for any SFX flags that have-->
LB4E4:  INY                             ;been set in the current SFX cycle.  If a flag-->
LB4E5:  TYA                             ;is found, Branch to SFXFlagFound for further-->
LB4E6:  CMP #$10                        ;processing, if no flags are set, continue to-->
LB4E8:  BNE -                           ;next SFX cycle.

RestoreSFXFlags:
LB4EA:  PLA                             ;
LB4EB:  STA CurrentSFXFlags             ;Restore original data in CurrentSFXFlags.
LB4EE:  RTS                             ;

SFXFlagFound:                           ;
LB4EF:* LDA ($E0),Y                     ;This routine stores the starting address of the-->
LB4F1:  STA $E2                         ;specific SFX handling routine for the SFX flag--> 
LB4F3:  INY                             ;found.  The address is stored in registers-->
LB4F4:  LDA ($E0),Y                     ;$E2 and $E3.
LB4F6:  STA $E3                         ;
LB4F8:  JMP RestoreSFXFlags             ;($B4EA)Restore original data in CurrentSFXFlags.

;-----------------------------------[ SFX Handling Routines ]---------------------------------------

;The following table is used by the SpitFlamesSFXContinue routine to change the volume-->
;on the SFX.  It starts out quiet, then becomes louder then goes quiet again.
SpitFlamesTbl:
LB4FB:  .byte $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1B, $1A, $19, $17
LB50B:  .byte $16, $15, $14, $12

SpitFlameSFXStart:
LB50F:  LDA #$14                        ;Number of frames to play sound before a change.
LB511:  LDY #$21                        ;Lower byte of sound data start address(base=$B200).
LB513:  JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

SpitFlameSFXContinue:
LB516:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB519:  BNE +                           ;If more frames to process, branch.
LB51B:  JMP EndNoiseSFX                 ;($B58F)End SFX.
LB51E:* LDY NoiseSFXData                ;
LB521:  LDA $B4FB,Y                     ;Load data from table above and store in NoiseCntrl0.
LB524:  STA NoiseCntrl0                 ;
LB527:  INC NoiseSFXData                ;Increment to next entry in data table.
LB52A:  RTS 

ScrewAttackSFXStart:
LB52B:  LDA #$05                        ;Number of frames to play sound before a change.
LB52D:  LDY #$11                        ;Lower byte of sound data start address(base=$B200).
LB52F:  JSR SelectSFXRoutine            ;($B452)Setup registers for SFX.
LB532:  LDA $B213                       ;#$00.
LB535:  STA NoiseSFXData                ;Clear NoiseSFXData.
LB538:* RTS                             ;

ScrewAttackSFXContinue:
LB539:  LDA ScrewAttackSFXData          ;Prevents period index from being incremented until-->
LB53C:  CMP #$02                        ;after the tenth frame of the SFX.
LB53E:  BEQ +                           ;Branch if not ready to increment.
LB540:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB543:  BNE -                           ;
LB545:  INC ScrewAttackSFXData          ;Increment every fifth frame.
LB548:  RTS                             ;

LB549:* JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB54C:  BNE IncrementPeriodIndex        ;Start increasing period index after first ten frames.
LB54E:  DEC NoiseSFXData                ;
LB551:  DEC NoiseSFXData                ;Decrement NoiseSFXData by three every fifth frame.
LB554:  DEC NoiseSFXData                ;
LB557:  INC MultiSFXData                ;Increment MultiSFXData.  When it is equal to #$0F-->
LB55A:  LDA MultiSFXData                ;end screw attack SFX.  MultiSFXData does not-->
LB55D:  CMP #$0F                        ;appear to be linked to multi SFX channels in-->
LB55F:  BNE --                          ;this routine.
LB561:  JMP EndNoiseSFX                 ;($B58F)End SFX.

IncrementPeriodIndex:
LB564:  INC NoiseSFXData                ;Incrementing the period index has the effect of-->
LB567:  LDA NoiseSFXData                ;lowering the frequency of the noise SFX.
LB56A:  STA NoiseCntrl2                 ;
LB56D:  RTS                             ;

MissileLaunchSFXStart:
LB56E:  LDA #$18                        ;Number of frames to play sound before a change.
LB570:  LDY #$15                        ;Lower byte of sound data start address(base=$B200).
LB572:  JSR GotoSelectSFXRoutine        ;($B587)Prepare to setup registers for SFX.
LB575:  LDA #$0A                        ;
LB577:  STA NoiseSFXData                ;Start increment index for noise channel at #$0A.
LB57A:  RTS                             ;

MissileLaunchSFXContine:
LB57B:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB57E:  BNE IncrementPeriodIndex        ;
LB580:  JMP EndNoiseSFX                 ;($B58F)End SFX.

BombExplodeSFXStart:
LB583:  LDA #$30                        ;Number of frames to play sound before a change.
LB585:  LDY #$19                        ;Lower byte of sound data start address(base=$B200).

GotoSelectSFXRoutine:
LB587:* JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

;The following routine is used to continue BombExplode and SamusWalk SFX.

NoiseSFXContinue:
LB58A:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB58D:  BNE MusicBranch02               ;If more frames to process, branch to exit. 

EndNoiseSFX:
LB58F:  JSR ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
LB592:  LDA #$10                        ;
LB594:  STA NoiseCntrl0                 ;disable envelope generator(sound off).

MusicBranch02:
LB597:  RTS                             ;Exit for multiple routines.
 
SamusWalkSFXStart:
LB598:  LDA NoiseContSFX                ;If MissileLaunch, SamusWalk or SpitFire SFX are-->
LB59B:  AND #$34                        ;already being played, branch to exit.
LB59D:  BNE MusicBranch02               ;
LB59F:  LDA #$03                        ;Number of frames to play sound before a change.
LB5A1:  LDY #$1D                        ;Lower byte of sound data start address(base=$B200).
LB5A3:  BNE -                           ;Branch always.

MultiSFXInit:
LB5A5:  STA MultiSFXLength              ;
LB5A8:  JSR LoadSQ2ChannelSFX           ;($B374)Set SQ2 SFX data.
LB5AB:  JSR UpdateContFlags             ;($B493)Set continue SFX flag.
LB5AE:  LDA #$01                        ;
LB5B0:  STA SQ1InUse                    ;Disable music from using SQ1 and SQ2 while-->
LB5B3:  LDA #$02                        ;SFX are playing.
LB5B5:  STA SQ2InUse                    ;
LB5B8:  LDA #$00                        ;
LB5BA:  STA SQ1ContSFX                  ;
LB5BD:  STA SQ1SFXData                  ;
LB5C0:  STA SQ1SQ2SFXData               ;Clear all listed memory addresses.
LB5C3:  STA SQ1SFXPeriodLow             ;
LB5C6:  STA ThisMultiFrame              ;
LB5C9:  STA WriteMultiChannelData       ;
LB5CC:  RTS                             ;

EndMultiSFX:
LB5CD:  LDA #$10                        ;
LB5CF:  STA SQ1Cntrl0                   ;Disable SQ1 envelope generator(sound off).
LB5D2:  STA SQ2Cntrl0                   ;Disable SQ2 envelope generator(sound off).
LB5D5:  LDA #$7F                        ;
LB5D7:  STA SQ1Cntrl1                   ;Disable SQ1 sweep.
LB5DA:  STA SQ2Cntrl1                   ;Disable SQ2 sweep.
LB5DD:  JSR ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
LB5E0:  LDA #$00                        ;
LB5E2:  STA SQ1InUse                    ;
LB5E5:  STA SQ2InUse                    ;Allows music player to use SQ1 and SQ2 channels.
LB5E8:  INC WriteMultiChannelData       ;
LB5EB:  RTS                             ;

BossHitSFXStart:
LB5EC:  LDY #$2D                        ;Low byte of SQ1 sound data start address(base=$B200).
LB5EE:  JSR LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
LB5F1:  LDY #$29                        ;Low byte of SQ2 sound data start address(base=$B200).
LB5F3:  JMP MultiSFXInit                ;($B5A5)Initiate multi channel SFX.

BossHitSFXContinue:
LB5F6:  INC SQ1SFXData                  ;Increment index to data in table below.
LB5F9:  LDY SQ1SFXData                  ;
LB5FC:  LDA $B63C,Y                     ;
LB5FF:  STA SQ1Cntrl0                   ;Load SQ1Cntrl0 and SQ2Cntrl0 from table below.
LB602:  STA SQ2Cntrl0                   ;
LB605:  LDA SQ1SFXData                  ;
LB608:  CMP #$14                        ;After #$14 frames, end SFX.
LB60A:  BEQ ++                          ;
LB60C:  CMP #$06                        ;After six or more frames of SFX, branch.
LB60E:  BCC +                           ;
LB610:  LDA RandomNumber1               ;
LB612:  ORA #$10                        ;Set bit 5.
LB614:  AND #$7F                        ;Randomly set bits 7, 3, 2, 1 and 0.
LB616:  STA SQ1SFXPeriodLow             ;Store in SQ1 period low.
LB619:  ROL                             ;
LB61A:  STA SQ1SQ2SFXData               ;
LB61D:  JMP WriteSQ1SQ2PeriodLow        ;($B62C)Write period low data to SQ1 and SQ2.
LB620:* INC SQ1SQ2SFXData               ;
LB623:  INC SQ1SQ2SFXData               ;Increment SQ1 and SQ2 period low by two.
LB626:  INC SQ1SFXPeriodLow             ;
LB629:  INC SQ1SFXPeriodLow             ;

WriteSQ1SQ2PeriodLow:
LB62C:  LDA SQ1SQ2SFXData               ;
LB62F:  STA SQ2Cntrl2                   ;Write new SQ1 and SQ2 period lows to SQ1 and SQ2-->
LB632:  LDA SQ1SFXPeriodLow             ;channels.
LB635:  STA SQ1Cntrl2                   ;
LB638:  RTS                             ;

LB639:* JMP EndMultiSFX                 ;($B5CD)End SFX.

BossHitSFXDataTbl:
LB63C:  .byte $38, $3D, $3F, $3F, $3F, $3F, $3F, $3D, $3B, $39, $3B, $3D, $3F, $3D, $3B, $39
LB64C:  .byte $3B, $3D, $3F, $39

SamusHitSFXContinue:
LB650:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB653:  BNE +                           ;If more SFX frames to process, branch.
LB655:  JMP EndMultiSFX                 ;($B5CD)End SFX.
LB658:* LDY #$25                        ;Low byte of SQ1 sound data start address(base=$B200).
LB65A:  JSR LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
LB65D:  LDA RandomNumber1               ;
LB65F:  AND #$0F                        ;Randomly set last four bits of SQ1 period low.
LB661:  STA SQ1Cntrl2                   ;
LB664:  LDY #$25                        ;Low byte of SQ2 sound data start address(base=$B200).
LB666:  JSR LoadSQ2ChannelSFX           ;($B374)Set SQ2 SFX data.
LB669:  LDA RandomNumber1               ;
LB66B:  LSR                             ;Multiply random number by 4.
LB66C:  LSR                             ;
LB66D:  AND #$0F                        ;
LB66F:  STA SQ2Cntrl2                   ;Randomly set bits 2 and 3 of SQ2 period low.
LB672:  RTS                             ;

SamusHitSFXStart:
LB673:  LDY #$25                        ;Low byte of SQ1 sound data start address(base=$B200).
LB675:  JSR LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
LB678:  LDA RandomNumber1               ;
LB67A:  AND #$0F                        ;Randomly set last four bits of SQ1 period low.
LB67C:  STA SQ1Cntrl2                   ;
LB67F:  CLC                             ;
LB680:  LDA RandomNumber1               ;Randomly set last three bits of SQ2 period low+1.
LB682:  AND #$03                        ;
LB684:  ADC #$01                        ;Number of frames to play sound before a change.
LB686:  LDY #$25                        ;Low byte of SQ2 sound data start address(base=$B200).
LB688:  JSR MultiSFXInit                ;($B5A5)Initiate multi channel SFX.
LB68B:  LDA RandomNumber1               ;
LB68D:  LSR                             ;Multiply random number by 4.
LB68E:  LSR                             ;
LB68F:  AND #$0F                        ;
LB691:  STA SQ2Cntrl2                   ;Randomly set bits 2 and 3 of SQ2 period low.
LB694:* RTS                             ;

IncorrectPasswordSFXStart:
LB695:  LDY #$31                        ;Low byte of SQ1 sound data start address(base=$B200).
LB697:  JSR LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.
LB69A:  LDA #$20                        ;Number of frames to play sound before a change.
LB69C:  LDY #$35                        ;Low byte of SQ2 sound data start address(base=$B200).
LB69E:  JMP MultiSFXInit                ;($B5A5)Initiate multi channel SFX.

IncorrectPasswordSFXContinue:
LB6A1:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB6A4:  BNE -                           ;If more frames to process, branch to exit.
LB6A6:  JMP EndMultiSFX                 ;($B5CD)End SFX.

;The following table is used by the below routine to load SQ1Cntrl2 data in the-->
;MissilePickupSFXContinue routine.

MissilePickupSFXTbl:
LB6A9:  .byte $BD, $8D, $7E, $5E, $46, $3E, $00 

MissilePickupSFXContinue:
LB6B0:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB6B3:  BNE MusicBranch03               ;If more frames to process, branch to exit.
LB6B5:  LDY SQ1SFXData                  ;
LB6B8:  LDA MissilePickupSFXTbl,Y       ;Load SFX data from table above.
LB6BB:  BNE +                           ;
LB6BD:  JMP EndSQ1SFX                   ;($B6F2)SFX completed.
LB6C0:* STA SQ1Cntrl2                   ;
LB6C3:  LDA $B244                       ;#$28.
LB6C6:  STA SQ1Cntrl3                   ;load SQ1Cntrl3 with #$28.
LB6C9:  INC SQ1SFXData                  ;Increment index to data table above every 5 frames.

MusicBranch03:
LB6CC:  RTS                             ;Exit from multiple routines.

MissilePickupSFXStart:
LB6CD:  LDA #$05                        ;Number of frames to play sound before a change.
LB6CF:  LDY #$41                        ;Lower byte of sound data start address(base=$B200).
LB6D1:  BNE +++                         ;Branch always.

EnergyPickupSFXContinue:
LB6D3:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB6D6:  BNE MusicBranch03               ;If more frames to process, branch to exit.
LB6D8:  INC SQ1SFXData                  ;
LB6DB:  LDA SQ1SFXData                  ;Every six frames, reload SFX info.  Does it-->
LB6DE:  CMP #$03                        ;three times for a total of 18 frames.
LB6E0:  BEQ +                           ;
LB6E2:  LDY #$3D                        ;
LB6E4:  JMP LoadSQ1ChannelSFX           ;($B368)Set SQ1 SFX data.

EnergyPickupSFXStart:
LB6E7:  LDA #$06                        ;Number of frames to play sound before a change.
LB6E9:  LDY #$3D                        ;Lower byte of sound data start address(base=$B200).
LB6EB:  BNE +++                         ;Branch always.

;The following continue routine is used by the metal, bird out of hole,
;enemy hit and the Samus jump SFXs.

SQ1SFXContinue:
LB6ED:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB6F0:  BNE MusicBranch03               ;

EndSQ1SFX:
LB6F2:* LDA #$10                        ;
LB6F4:  STA SQ1Cntrl0                   ;Disable envelope generator(sound off).
LB6F7:  LDA #$00                        ;
LB6F9:  STA SQ1InUse                    ;Allows music to use SQ1 channel.
LB6FC:  JSR ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.
LB6FF:  INC WriteMultiChannelData       ;Allows music routines to load SQ1 and SQ2 music.
LB702:  RTS                             ;

SamusJumpSFXStart:
LB703:  LDA CurrentMusic                ;If escape music is playing, exit without playing-->
LB706:  CMP #$04                        ;Samus jump SFX.
LB708:  BEQ MusicBranch03               ;
LB70A:  LDA #$0C                        ;Number of frames to play sound before a change.
LB70C:  LDY #$51                        ;Lower byte of sound data start address(base=$B200).
LB70E:  BNE SelectSFX1                  ;Branch always.

EnemyHitSFXStart:
LB710:  LDA #$08                        ;Number of frames to play sound before a change.
LB712:  LDY #$55                        ;Lower byte of sound data start address(base=$B200).
LB714:  BNE SelectSFX1                  ;Branch always.

BulletFireSFXStart:
LB716:  LDA HasBeamSFX                  ;
LB719:  LSR                             ;If Samus has ice beam, branch.
LB71A:  BCS +++++                       ;
LB71C:  LDA SQ1ContSFX                  ;If MissilePickup, EnergyPickup, BirdOutOfHole-->
LB71F:  AND #$CC                        ;or EnemyHit SFX already playing, branch to exit.
LB721:  BNE MusicBranch03               ;
LB723:  LDA HasBeamSFX                  ;
LB726:  ASL                             ;If Samus has long beam, branch.
LB727:  BCS +                           ;
LB729:  LDA #$03                        ;Number of frames to play sound before a change.
LB72B:  LDY #$4D                        ;Lower byte of sound data start address(base=$B200).
LB72D:  BNE SelectSFX1                  ;Branch always (Plays ShortBeamSFX).

HasLongBeamSFXStart:
LB72F:* LDA #$07                        ;Number of frames to play sound before a change.
LB731:  LDY #$49                        ;Lower byte of sound data start address(base=$B200).
LB733:  BNE SelectSFX1                  ;Branch always.

MetalSFXStart:
LB735:  LDA #$0B                        ;Number of frames to play sound before a change.
LB737:  LDY #$45                        ;Lower byte of sound data start address(base=$B200).

SelectSFX1:
LB739:* JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

BirdOutOfHoleSFXStart:
LB73C:  LDA CurrentMusic                ;If escape music is playing, use this SFX to make-->
LB73F:  CMP #$04                        ;the bomb ticking sound, else play regular SFX.
LB741:  BEQ +                           ;
LB743:  LDA #$16                        ;Number of frames to play sound before a change.
LB745:  LDY #$59                        ;Lower byte of sound data start address(base=$B200).
LB747:  BNE SelectSFX1                  ;Branch always.
LB749:* LDA #$07                        ;Number of frames to play sound before a change.
LB74B:  LDY #$39                        ;Lower byte of sound data start address(base=$B200).
LB74D:  BNE SelectSFX1                  ;Branch always.

BulletFireSFXContinue:
LB74F:  LDA HasBeamSFX                  ;
LB752:  LSR                             ;If Samus has ice beam, branch.
LB753:  BCS +++                         ;
LB755:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB758:  BNE +                           ;If more frames to process, branch to exit.
LB75A:  JMP EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
LB75D:* RTS                             ;

HasIceBeamSFXStart:
LB75E:* LDA #$07                        ;Number of frames to play sound before a change.
LB760:  LDY #$61                        ;Lower byte of sound data start address(base=$B200).
LB762:  JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

HasIceBeamSFXContinue:
LB765:* JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB768:  BNE +                           ;If more frames to process, branch.
LB76A:  JMP EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
LB76D:* LDA SQ1SFXData                  ;
LB770:  AND #$01                        ;Determine index for IceBeamSFXDataTbl below.
LB772:  TAY                             ;
LB773:  LDA IceBeamSFXDataTbl,Y         ;Loads A with value from IceBeamSFXDataTbl below.
LB776:  BNE ++                          ;

IceBeamSFXDataTbl:
LB778:  .byte $93                       ;Ice beam SFX period low data.
LB779:  .byte $81                       ;

WaveBeamSFXStart:
LB77A:  LDA #$08                        ;Number of frames to play sound before a change.
LB77C:  LDY #$5D                        ;Lower byte of sound data start address(base=$B200).
LB77E:  JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

WaveBeamSFXContinue:
LB781:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB784:  BNE +                           ;If more frames to process, branch.
LB786:  LDY SQ1SQ2SFXData               ;
LB789:  INC SQ1SQ2SFXData               ;Load wave beam SFXDisable/enable envelope length-->
LB78C:  LDA WaveBeamSFXDisLngthTbl,Y    ;data from WaveBeamSFXDisableLengthTbl.
LB78F:  STA SQ1Cntrl0                   ;
LB792:  BNE MusicBranch10               ;If at end of WaveBeamSFXDisableLengthTbl, end SFX.
LB794:  JMP EndSQ1SFX                   ;($B6F2)If SFX finished, jump.
LB797:* LDA SQ1SFXData
LB79A:  AND #$01                        ;
LB79C:  TAY                             ;Load wave beam SFX period low data from-->
LB79D:  LDA WaveBeamSFXPeriodLowTbl,Y   ;WaveBeamSFXPeriodLowTbl.

LoadSQ1PeriodLow:
LB7A0:* STA SQ1Cntrl2                   ;Change the period low data for SQ1 channel.
LB7A3:  INC SQ1SFXData                  ;

MusicBranch10:
LB7A6:  RTS                             ;Exit for multiple routines.
 
WaveBeamSFXPeriodLowTbl:
LB7A7:  .byte $58                       ;Wave beam SFX period low data.
LB7A8:  .byte $6F                       ;

WaveBeamSFXDisLngthTbl:
LB7A9:  .byte $93                       ;
LB7AA:  .byte $91                       ;Wave beam SFX Disable/enable envelope length data.
LB7AB:  .byte $00                       ;

DoorOpenCloseSFXStart:
LB7AC:  LDA $B287                       ;#$30.
LB7AF:  STA TrianglePeriodLow           ;Set triangle period low data byte.
LB7B2:  LDA $B288                       ;#$B2.
LB7B5:  AND #$07                        ;Set triangle period high data byte.
LB7B7:  STA TrianglePeriodHigh          ;#$B7.
LB7BA:  LDA #$0F                        ;
LB7BC:  STA TriangleChangeLow           ;Change triangle channel period low every frame by #$0F.
LB7BF:  LDA #$00                        ;
LB7C1:  STA TriangleChangeHigh          ;No change in triangle channel period high.
LB7C4:  LDA #$1F                        ;Number of frames to play sound before a change.
LB7C6:  LDY #$85                        ;Lower byte of sound data start address(base=$B200).
LB7C8:  JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

DoorOpenCloseSFXContinue:
LB7CB:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB7CE:  BNE +                           ;
LB7D0:  JMP EndTriangleSFX              ;($B896)End SFX.
LB7D3:* JSR DecreaseTrianglePeriods     ;($B98C)Decrease periods.
LB7D6:  JMP WriteTrianglePeriods        ;($B869)Save new periods.

BeepSFXStart:
LB7D9:  LDA TriangleContSFX             ;If BombLaunchSFX is already playing, branch-->
LB7DC:  AND #$80                        ;without playing BeepSFX.
LB7DE:  BNE MusicBranch10               ;
LB7E0:  LDA #$03                        ;Number of frames to play sound before a change.
LB7E2:  LDY #$79                        ;Lower byte of sound data start address(base=$B200).
LB7E4:  JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

BeepSFXContinue:
LB7E7:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB7EA:  BNE MusicBranch10               ;If more frames to process, branch to exit.
LB7EC:  JMP EndTriangleSFX              ;($B896)End SFX.

BigEnemyHitSFXStart:
LB7EF:  LDA #$12                        ;Increase triangle low period by #$12 every frame.
LB7F1:  STA TriangleChangeLow           ;
LB7F4:  LDA #$00                        ;
LB7F6:  STA TriangleChangeHigh          ;Does not change triangle period high.
LB7F9:  LDA $B27F                       ;#$42.
LB7FC:  STA TrianglePeriodLow           ;Save new triangle period low data.
LB7FF:  LDA $B280                       ;#$18.
LB802:  AND #$07                        ;#$1F.
LB804:  STA TrianglePeriodHigh          ;Save new triangle period high data.
LB807:  LDA #$0A                        ;Number of frames to play sound before a change.
LB809:  LDY #$7D                        ;Lower byte of sound data start address(base=$B200).
LB80B:  JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

BigEnemyHitSFXContinue:
LB80E:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB811:  BNE +                           ;If more frames to process, branch
LB813:  JMP EndTriangleSFX              ;($B896)End SFX
LB816:* JSR IncreaseTrianglePeriods     ;($B978)Increase periods.
LB819:  LDA RandomNumber1               ;
LB81B:  AND #$3C                        ;
LB81D:  STA TriangleSFXData             ;
LB820:  LDA TrianglePeriodLow           ;Randomly set or clear bits 2, 3, 4 and 5 in-->
LB823:  AND #$C3                        ;triangle channel period low.
LB825:  ORA TriangleSFXData             ;
LB828:  STA TriangleCntrl2              ;
LB82B:  LDA TrianglePeriodHigh          ;
LB82E:  ORA #$40                        ;Set 4th bit in triangle channel period high.
LB830:  STA TriangleCntrl3              ;
LB833:  RTS                             ;

SamusToBallSFXStart:
LB834:  LDA #$08                        ;Number of frames to play sound before a change.
LB836:  LDY #$6D                        ;Lower byte of sound data start address(base=$B200).
LB838:  JSR SelectSFXRoutine            ;($B452)Setup registers for SFX.
LB83B:  LDA #$05                        ;
LB83D:  STA PercentDifference           ;Stores percent difference. In this case 5 = 1/5 = 20%.
LB840:  LDA $B26F                       ;#$DD.
LB843:  STA TrianglePeriodLow           ;Save new triangle period low data.
LB846:  LDA $B270                       ;#$3B.
LB849:  AND #$07                        ;#$02.
LB84B:  STA TrianglePeriodHigh          ;Save new triangle period high data.
LB84E:  RTS                             ;

SamusToBallSFXContinue:
LB84F:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB852:  BNE +                           ;If more frames to process, branch.
LB854:  JMP EndTriangleSFX              ;($B896)End SFX.
LB857:* JSR DivideTrianglePeriods       ;($B9A0)reduces triangle period low by 20% each frame.
LB85A:  LDA TriangleLowPercentage       ;
LB85D:  STA TriangleChangeLow           ;Store new values to change triangle periods.
LB860:  LDA TriangleHighPercentage      ;
LB863:  STA TriangleChangeHigh          ;
LB866:  JSR DecreaseTrianglePeriods     ;($B98C)Decrease periods.

WriteTrianglePeriods:
LB869:  LDA TrianglePeriodLow           ;Write TrianglePeriodLow to triangle channel.
LB86C:  STA TriangleCntrl2              ;
LB86F:  LDA TrianglePeriodHigh          ;
LB872:  ORA #$08                        ;Write TrianglePeriodHigh to triangle channel.
LB874:  STA TriangleCntrl3              ;
LB877:  RTS                             ;

BombLaunchSFXStart:
LB878:  LDA #$04                        ;Number of frames to play sound before a change.
LB87A:  LDY #$65                        ;Lower byte of sound data start address(base=$B200).
LB87C:  JMP SelectSFXRoutine            ;($B452)Setup registers for SFX.

BombLaunchSFXContinue:
LB87F:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB882:  BNE MusicBranch04               ;If more frames to process, branch to exit.
LB884:  INC TriangleSFXData             ;
LB887:  LDA TriangleSFXData             ;After four frames, load second part of SFX.
LB88A:  CMP #$02                        ;
LB88C:  BNE +                           ;
LB88E:  JMP EndTriangleSFX              ;($B896)End SFX.
LB891:* LDY #$69                        ;Lower byte of sound data start address(base=$B200).
LB893:  JMP LoadTriangleChannelSFX      ;($B36C)Prepare to load triangle channel with data.

EndTriangleSFX:
LB896:  LDA #$00                        ;
LB898:  STA TriangleCntrl0              ;clear TriangleCntr0(sound off).
LB89B:  STA TriangleInUse               ;Allows music to use triangle channel.
LB89E:  LDA #$18                        ;
LB8A0:  STA TriangleCntrl3              ;Set length index to #$03.
LB8A3:  JSR ClearCurrentSFXFlags        ;($B4A2)Clear all SFX flags.

MusicBranch04:
LB8A6:  RTS                             ;Exit from for multiple routines.

MetroidHitSFXStart:
LB8A7:  LDA #$03                        ;Number of frames to play sound before a change.
LB8A9:  LDY #$71                        ;Lower byte of sound data start address(base=$B200).
LB8AB:  JSR SelectSFXRoutine            ;($B452)Setup registers for SFX.
LB8AE:  JMP RndTrianglePeriods          ;($B8C3)MetroidHit SFX has several different sounds.

MetroiHitSFXContinue:
LB8B1:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB8B4:  BEQ +                           ;
LB8B6:  INC TriangleSFXData             ;
LB8B9:  LDA TriangleSFXData             ;Randomize triangle periods nine times throughout-->
LB8BC:  CMP #$09                        ;the course of the SFX.
LB8BE:  BNE MusicBranch04               ;If SFX not done, branch.
LB8C0:  JMP EndTriangleSFX              ;($B896)End SFX.

RndTrianglePeriods:
LB8C3:* LDA RandomNumber1               ;Randomly set or reset bits 7, 4, 2 and 1 of-->
LB8C5:  ORA #$6C                        ;triangle channel period low.
LB8C7:  STA TriangleCntrl2              ;
LB8CA:  AND #$01                        ;
LB8CC:  ORA #$F8                        ;Randomly set or reset last bit of triangle-->
LB8CE:  STA TriangleCntrl3              ;channel period high.
LB8D1:  RTS                             ;

SamusDieSFXStart:
LB8D2:  JSR InitializeSoundAddresses    ;($B404)Clear all sound addresses.
LB8D5:  LDA #$0E                        ;Number of frames to play sound before a change.
LB8D7:  LDY #$75                        ;Lower byte of sound data start address(base=$B200).
LB8D9:  JSR SelectSFXRoutine            ;($B452)Setup registers for SFX.
LB8DC:  LDA #$15                        ;Decrease triangle SFX periods by 4.8% every frame.
LB8DE:  STA PercentDifference           ;
LB8E1:  LDA $B277                       ;#$40.
LB8E4:  STA TrianglePeriodLow           ;
LB8E7:  LDA #$00                        ;Initial values of triangle periods.
LB8E9:  STA TrianglePeriodHigh          ;
LB8EC:* RTS                             ;

SamusDieSFXContinue:
LB8ED:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB8F0:  BNE +                           ;
LB8F2:  LDA #$20                        ;Store change in triangle period low.
LB8F4:  STA TriangleChangeLow           ;
LB8F7:  LDA #$00                        ;
LB8F9:  STA TriangleChangeHigh          ;No change in triangle period high.
LB8FC:  JSR DecreaseTrianglePeriods     ;($B98C)Decrease periods.
LB8FF:  INC TriangleSFXData             ;
LB902:  LDA TriangleSFXData             ;
LB905:  CMP #$06                        ;
LB907:  BNE -                           ;If more frames to process, branch to exit.
LB909:  JMP EndTriangleSFX              ;($B896)End SFX.
LB90C:* JSR DivideTrianglePeriods       ;($B9A0)reduces triangle period low.
LB90F:  LDA TriangleLowPercentage       ;
LB912:  STA TriangleChangeLow           ;Update triangle periods.
LB915:  LDA TriangleHighPercentage      ;
LB918:  STA TriangleChangeHigh          ;
LB91B:  JSR IncreaseTrianglePeriods     ;($B978)Increase periods.
LB91E:  JMP WriteTrianglePeriods        ;($B869)Save new periods.

StatueRaiseSFXStart:
LB921:  LDA $B283                       ;#$11.
LB924:  STA TrianglePeriodLow           ;Save period low data.
LB927:  LDA $B284                       ;#$09.
LB92A:  AND #$07                        ;
LB92C:  STA TrianglePeriodHigh          ;Store last three bits in $B284.
LB92F:  LDA #$00                        ;
LB931:  STA TriangleChangeHigh          ;No change in Triangle period high.
LB934:  LDA #$0B                        ;
LB936:  STA TriangleChangeLow           ;
LB939:  LDA #$06                        ;Number of frames to play sound before a change.
LB93B:  LDY #$81                        ;Lower byte of sound data start address(base=$B200).
LB93D:  JMP SelectSFXroutine            ;($B452)Setup registers for SFX.

StatueRaiseSFXContinue:
LB940:  JSR IncrementSFXFrame           ;($B4A9)Get next databyte to process in SFX.
LB943:  BNE ++                          ;
LB945:  INC TriangleSFXData             ;Increment TriangleSFXData every 6 frames.
LB948:  LDA TriangleSFXData             ;
LB94B:  CMP #$09                        ;When TriangleSFXData = #$09, end SFX.
LB94D:  BNE +                           ;
LB94F:  JMP EndTriangleSFX              ;($B896)End SFX.
LB952:* LDA TriangleChangeLow           ;
LB955:  PHA                             ;Save triangle periods.
LB956:  LDA TriangleChangeHigh          ;
LB959:  PHA                             ;
LB95A:  LDA #$25                        ;
LB95C:  STA TriangleChangeLow           ;
LB95F:  LDA #$00                        ;No change in triangle period high.
LB961:  STA TriangleChangeHigh          ;
LB964:  JSR IncreaseTrianglePeriods     ;($B978)Increase periods.
LB967:  PLA                             ;
LB968:  STA TriangleChangeHigh          ;Restore triangle periods.
LB96B:  PLA                             ;
LB96C:  STA TriangleChangeLow           ;
LB96F:  JMP WriteTrianglePeriods        ;($B869)Save new periods.
LB972:* JSR DecreaseTrianglePeriods     ;($B98C)Decrease periods.
LB975:  JMP WriteTrianglePeriods        ;($B869)Save new periods.

IncreaseTrianglePeriods:
LB978:  CLC 
LB979:  LDA TrianglePeriodLow           ;
LB97C:  ADC TriangleChangeLow           ;Calculate new TrianglePeriodLow.
LB97F:  STA TrianglePeriodLow           ;
LB982:  LDA TrianglePeriodHigh          ;
LB985:  ADC TriangleChangeHigh          ;Calculate new TrianglePeriodHigh.
LB988:  STA TrianglePeriodHigh          ;
LB98B:  RTS                             ;

DecreaseTrianglePeriods:
LB98C:  SEC 
LB98D:  LDA TrianglePeriodLow           ;
LB990:  SBC TriangleChangeLow           ;Calculate new TrianglePeriodLow.
LB993:  STA TrianglePeriodLow           ;
LB996:  LDA TrianglePeriodHigh          ;
LB999:  SBC TriangleChangeHigh          ;Calculate new TrianglePeriodHigh.
LB99C:  STA TrianglePeriodHigh          ;
LB99F:  RTS                             ;

DivideTrianglePeriods:
LB9A0:  LDA TrianglePeriodLow           ;
LB9A3:  PHA                             ;Store TrianglePeriodLow and TrianglePeriodHigh.
LB9A4:  LDA TrianglePeriodHigh          ;
LB9A7:  PHA                             ;
LB9A8:  LDA #$00                        ;
LB9AA:  STA DivideData                  ;
LB9AD:  LDX #$10                        ;
LB9AF:  ROL TrianglePeriodLow           ;
LB9B2:  ROL TrianglePeriodHigh          ;
LB9B5:* ROL DivideData                  ;The following routine takes the triangle period-->
LB9B8:  LDA DivideData                  ;high and triangle period low values and reduces-->
LB9BB:  CMP PercentDifference           ;them by a certain percent.  The percent is-->
LB9BE:  BCC +                           ;determined by the value stored in-->
LB9C0:  SBC PercentDifference           ;PercentDifference.  If PercentDifference=#$05,-->
LB9C3:  STA DivideData                  ;then the values will be reduced by 20%(1/5).-->
LB9C6:* ROL TrianglePeriodLow           ;If PercentDifference=#$0A,Then the value will-->
LB9C9:  ROL TrianglePeriodHigh          ;be reduced by 10%(1/10), etc. This function is-->
LB9CC:  DEX                             ;basically a software emulation of a sweep function.
LB9CD:  BNE --                          ;
LB9CF:  LDA TrianglePeriodLow           ;
LB9D2:  STA TriangleLowPercentage       ;
LB9D5:  LDA TrianglePeriodHigh          ;
LB9D8:  STA TriangleHighPercentage      ;
LB9DB:  PLA                             ;
LB9DC:  STA TrianglePeriodHigh          ;Restore TrianglePerodLow and TrianglePeriodHigh.
LB9DF:  PLA                             ;
LB9E0:  STA TrianglePeriodLow           ;
LB9E3:  RTS                             ;

;--------------------------------------[ End SFX routines ]-------------------------------------
 
SetVolumeAndDisableSweep:
LB9E4:  LDA #$7F                        ;
LB9E6:  STA MusicSQ1Sweep               ;Disable sweep generator on SQ1 and SQ2.
LB9E9:  STA MusicSQ2Sweep               ;
LB9EC:  STX SQ1DutyEnvelope             ;Store duty cycle and volume data for SQ1 and SQ2.
LB9EF:  STY SQ2DutyEnvelope             ;
LB9F2:  RTS                             ;

ResetVolumeIndex:
LB9F3:  LDA SQ1MusicFrameCount          ;If at the beginning of a new SQ1 note, set-->
LB9F6:  CMP #$01                        ;SQ1VolumeIndex = #$01.
LB9F8:  BNE +                           ;
LB9FA:  STA SQ1VolumeIndex              ;
LB9FD:* LDA SQ2MusicFrameCount          ;
LBA00:  CMP #$01                        ;If at the beginning of a new SQ2 note, set-->
LBA02:  BNE +                           ;SQ2VolumeIndex = #$01.
LBA04:  STA SQ2VolumeIndex              ;
LBA07:* RTS                             ;

LoadSQ1SQ2Periods:
LBA08:  LDA WriteMultiChannelData       ;If a Multi channel data does not need to be-->
LBA0B:  BEQ +                           ;loaded, branch to exit.
LBA0D:  LDA #$00                        ;
LBA0F:  STA WriteMultiChannelData       ;Clear multi channel data write flag.
LBA12:  LDA MusicSQ1Sweep               ;
LBA15:  STA SQ1Cntrl1                   ;
LBA18:  LDA MusicSQ1PeriodLow           ;
LBA1B:  STA SQ1Cntrl2                   ;Loads SQ1 channel addresses $4001, $4002, $4003.
LBA1E:  LDA MusicSQ1PeriodHigh          ;
LBA21:  STA SQ1Cntrl3                   ;
LBA24:  LDA MusicSQ2Sweep               ;
LBA27:  STA SQ2Cntrl1                   ;
LBA2A:  LDA MusicSQ2PeriodLow           ;
LBA2D:  STA SQ2Cntrl2                   ;Loads SQ2 channel addresses $4005, $4006, $4007.
LBA30:  LDA MusicSQ2PeriodHigh          ;
LBA33:  STA SQ2Cntrl3                   ;
LBA36:* RTS                             ;

LoadSQ1SQ2Channels:
LBA37:  LDX #$00                        ;Load SQ1 channel data.
LBA39:  JSR WriteSQCntrl0               ;($BA41)Write Cntrl0 data.
LBA3C:  INX                             ;Load SQ2 channel data.
LBA3D:  JSR WriteSQCntrl0               ;($BA41)Write Cntrl0 data.
LBA40:  RTS                             ;

WriteSQCntrl0:
LBA41:  LDA SQ1VolumeCntrl,X            ;Load SQ channel volume data. If zero, branch to exit.
LBA44:  BEQ +++++                       ;
LBA46:  STA VolumeCntrlAddress          ;
LBA48:  JSR LoadSQ1SQ2Periods           ;($BA08)Load SQ1 and SQ2 control information.
LBA4B:  LDA SQ1VolumeData,X             ;
LBA4E:  CMP #$10                        ;If sound channel is not currently-->
LBA50:  BEQ +++++++                     ;playing sound, branch.
LBA52:  LDY #$00                        ;
LBA54:* DEC VolumeCntrlAddress          ;Desired entry in VolumeCntrlAdressTbl.
LBA56:  BEQ +                           ;
LBA58:  INY                             ;*2(2 byte address to find voulume control data).
LBA59:  INY                             ;
LBA5A:  BNE -                           ;Keep decrementing until desired address is found.
LBA5C:* LDA VolumeCntrlAddressTbl,Y     ;Base is $BCB0.
LBA5F:  STA $EC                         ;Volume data address low byte.
LBA61:  LDA VolumeCntrlAddressTbl+1,Y   ;Base is $BCB1.
LBA64:  STA $ED                         ;Volume data address high byte.
LBA66:  LDY SQ1VolumeIndex,X            ;Index to desired volume data.
LBA69:  LDA ($EC),Y                     ;Load desired volume for current channel into-->
LBA6B:  STA Cntrl0Data                  ;Cntrl0Data.
LBA6D:  CMP #$FF                        ;If last entry in volume table is #$FF, restore-->
LBA6F:  BEQ MusicBranch05               ;volume to its original level after done reading-->
LBA71:  CMP #$F0                        ;Volume data.  If #$F0 is last entry, turn sound-->
LBA73:  BEQ MusicBranch06               ;off on current channel until next note.
LBA75:  LDA SQ1DutyEnvelope,X           ;Remove duty cycle data For current channel and-->
LBA78:  AND #$F0                        ;add this frame of volume data and store results--> 
LBA7A:  ORA Cntrl0Data                  ;in Cntrl0Data.
LBA7C:  TAY                             ;
LBA7D:* INC SQ1VolumeIndex,X            ;Increment Index to volume data.
LBA80:* LDA SQ1InUse,X                  ;If SQ1 or SQ2(depends on loop iteration) in use,-->
LBA83:  BNE +                           ;branch to exit, else write SQ(1 or 2)Cntrl0.
LBA85:  TXA                             ;
LBA86:  BEQ ++                          ;If currently on SQ1, branch to write SQ1 data.

WriteSQ2Cntrl0:                         ;
LBA88:  STY SQ2Cntrl0                   ;Write SQ2Cntrl0 data.
LBA8B:* RTS                             ;

WriteSQ1Cntrl0:                         ;
LBA8C:* STY SQ1Cntrl0                   ;Write SQ1Cntrl0 data.
LBA8F:  RTS                             ;

MusicBranch05:
LBA90:  LDY SQ1DutyEnvelope,X           ;Restore original volume of sound channel.
LBA93:  BNE ---                         ;Branch always.

MusicBranch06:
LBA95:  LDY #$10                        ;Disable envelope generator and set volume to 0.
LBA97:  BNE ---                         ;Branch always.
LBA99:* LDY #$10                        ;Disable envelope generator and set volume to 0.
LBA9B:  BNE -----                       ;Branch always.

GotoCheckRepeatMusic:
LBA9D:* JSR CheckRepeatMusic            ;($B3F0)Resets music flags if music repeats.
LBAA0:  RTS                             ;

GotoLoadSQ1SQ2Channels:
LBAA1:* JSR LoadSQ1SQ2Channels          ;($BA37)Load SQ1 and SQ2 channel data.
LBAA4:  RTS                             ;

LoadCurrentMusicFrameData:
LBAA5:  JSR ResetVolumeIndex            ;($B9F3)Reset index if at the beginning of a new note.
LBAA8:  LDA #$00                        ;
LBAAA:  TAX                             ;X = #$00.
LBAAB:  STA ThisSoundChannel            ;(#$00, #$04, #$08 or #$0C).
LBAAE:  BEQ ++                          ;
LBAB0:* TXA                             ;
LBAB1:  LSR                             ;
LBAB2:  TAX                             ;Increment to next sound channel(1,2 or 3).
                                        ;
IncrementToNextChannel:                 ;
LBAB3:  INX                             ;
LBAB4:  TXA                             ;
LBAB5:  CMP #$04                        ;If done with four sound channels, branch to load-->
LBAB7:  BEQ --                          ;sound channel SQ1 SQ2 data.
LBAB9:  LDA ThisSoundChannel            ;Add 4 to the least significant byte of the current-->
LBABC:  CLC                             ;sound channel start address.  This moves to next-->
LBABD:  ADC #$04                        ;sound channel address ranges to process.
LBABF:  STA ThisSoundChannel            ;
LBAC2:* TXA                             ;
LBAC3:  ASL                             ;*2(two bytes for sound channel info base address).
LBAC4:  TAX                             ;
LBAC5:  LDA SQ1LowBaseByte,X            ;
LBAC8:  STA $E6                         ;Load sound channel info base address into $E6-->
LBACA:  LDA SQ1HighBaseByte,X           ;and $E7. ($E6=low byte, $E7=high byte).
LBACD:  STA $E7                         ;
LBACF:  LDA SQ1HighBaseByte,X           ;If no data for this sound channel, branch-->
LBAD2:  BEQ --                          ;to find data for next sound channel.
LBAD4:  TXA                             ;
LBAD5:  LSR                             ;/2. Determine current sound channel (0,1,2 or3).
LBAD6:  TAX                             ;
LBAD7:  DEC SQ1MusicFrameCount,X        ;Decrement the current sound channel frame count-->
LBADA:  BNE IncrementToNextChannel      ;If not zero, branch to check next channel, else-->
                                        ;load the next set of sound channel data.
LoadNextChannelIndexData:
LBADC:  LDY SQ1MusicIndexIndex,X        ;Load current channel index to music data index.
LBADF:  INC SQ1MusicIndexIndex,X        ;Increment current channel index to music data index.
LBAE2:  LDA ($E6),Y                     ;
LBAE4:  BEQ ----                                ;Branch if music has reached the end.
LBAE6:  TAY                             ;Transfer music data index to Y (base=$BE77) .
LBAE7:  CMP #$FF                        ;
LBAE9:  BEQ +                           ;At end of loop? If yes, branch.
LBAEB:  AND #$C0                        ;
LBAED:  CMP #$C0                        ;At beginnig of new loop? if yes, branch.
LBAEF:  BEQ ++                          ;
LBAF1:  JMP LoadMusicChannel            ;($BB1C)Load music data into channel.

RepeatMusicLoop:
LBAF4:* LDA SQ1RepeatCounter,X          ;If loop counter has reached zero, branch to exit.
LBAF7:  BEQ ++                          ;
LBAF9:  DEC SQ1RepeatCounter,X          ;Decrement loop counter.
LBAFC:  LDA SQ1LoopIndex,X              ;Load loop index for proper channel and store it in-->
LBAFF:  STA SQ1MusicIndexIndex,X        ;music index index address.
LBB02:  BNE ++                          ;Branch unless music has reached the end.

StartNewMusicLoop:
LBB04:* TYA                             ;
LBB05:  AND #$3F                        ;Remove last six bits of loop controller and save-->
LBB07:  STA SQ1RepeatCounter,X          ;in repeat counter addresses.  # of times to loop.
LBB0A:  DEC SQ1RepeatCounter,X          ;Decrement loop counter.
LBB0D:  LDA SQ1MusicIndexIndex,X        ;Store location of loop start in loop index address.
LBB10:  STA SQ1LoopIndex,X              ;
LBB13:* JMP LoadNextChannelIndexData    ;($BADC)Load next channel index data.

LBB16:* JMP LoadNoiseChannelMusic       ;($BBDE)Load data for noise channel music.

LBB19:* JMP LoadTriangleCntrl0          ;($BBB7)Load Cntrl0 byte of triangle channel.

LoadMusicChannel:
LBB1C:  TYA                             ;
LBB1D:  AND #$B0                        ;
LBB1F:  CMP #$B0                        ;Is data byte music note length data?  If not, branch.
LBB21:  BNE +                           ;
LBB23:  TYA                             ;
LBB24:  AND #$0F                        ;Separate note length data.
LBB26:  CLC                             ;
LBB27:  ADC NoteLengthTblOffset         ;Find proper note lengths table for current music.
LBB2A:  TAY                             ;
LBB2B:  LDA NoteLengths0Tbl,Y           ;(Base is $BEF7)Load note length and store in--> 
LBB2E:  STA SQ1FrameCountInit,X         ;frame count init address.
LBB31:  TAY                             ;Y now contains note length.
LBB32:  TXA                             ;
LBB33:  CMP #$02                        ;If loading Triangle channel data, branch.
LBB35:  BEQ -                           ;

LoadSoundDataIndexIndex:
LBB37:  LDY SQ1MusicIndexIndex,X        ;Load current index to sound data index.
LBB3A:  INC SQ1MusicIndexIndex,X        ;Increment music index index address.
LBB3D:  LDA ($E6),Y                     ;Load index to sound channel music data.
LBB3F:  TAY                             ;
LBB40:* TXA                             ;
LBB41:  CMP #$03                        ;If loading Noise channel data, branch.
LBB43:  BEQ ---                         ;
LBB45:  PHA                             ;Push music channel number on stack(0, 1 or 2).
LBB46:  LDX ThisSoundChannel            ;
LBB49:  LDA MusicNotesTbl+1,Y           ;(Base=$BE78)Load A with music channel period low data.
LBB4C:  BEQ +                           ;If data is #$00, skip period high and low loading.
LBB4E:  STA MusicSQ1PeriodLow,X         ;Store period low data in proper period low address.
LBB51:  LDA MusicNotesTbl,Y             ;(Base=$BE77)Load A with music channel period high data.
LBB54:  ORA #$08                        ;Ensure minimum index length of 1.
LBB56:  STA MusicSQ1PeriodHigh,X        ;Store period high data in proper period high address.
LBB59:* TAY                             ;
LBB5A:  PLA                             ;Pull stack and restore channel number to X.
LBB5B:  TAX                             ;
LBB5C:  TYA                             ;
LBB5D:  BNE +                           ;If period information was present, branch.
                                
NoPeriodInformation:
LBB5F:  LDA #$00                        ;Turn off channel volume since no period data present.
LBB61:  STA Cntrl0Data                  ;
LBB63:  TXA                             ;
LBB64:  CMP #$02                        ;If loading triangle channel data, branch.
LBB66:  BEQ ++                          ;
LBB68:  LDA #$10                        ;Turn off volume and disable env. generator(SQ1,SQ2).
LBB6A:  STA Cntrl0Data                  ;
LBB6C:  BNE ++                          ;Branch always.

PeriodInformationFound:
LBB6E:* LDA SQ1DutyEnvelope,X           ;Store channel duty cycle and volume info in $EA.
LBB71:  STA Cntrl0Data                  ;
LBB73:* TXA                             ;
LBB74:  DEC SQ1InUse,X                  ;
LBB77:  CMP SQ1InUse,X                  ;If SQ1 or SQ2 are being used by SFX routines, branch.
LBB7A:  BEQ +++                         ;
LBB7C:  INC SQ1InUse,X                  ;Restore not in use status of SQ1 or SQ2.
LBB7F:  LDY ThisSoundChannel            ;
LBB82:  TXA                             ;
LBB83:  CMP #$02                        ;If loading triangle channel data, branch.
LBB85:  BEQ +                           ;
LBB87:  LDA SQ1VolumeCntrl,X            ;If $062E or $062F has volume data, skip writing-->
LBB8A:  BNE ++                          ;Cntrl0Data to SQ1 or SQ2.
LBB8C:* LDA Cntrl0Data                  ;
LBB8E:  STA SQ1Cntrl0,Y                 ;Write Cntrl0Data.
LBB91:* LDA Cntrl0Data                  ;
LBB93:  STA SQ1VolumeData,X             ;Store volume data index to volume data.
LBB96:  LDA MusicSQ1PeriodLow,Y         ;
LBB99:  STA SQ1Cntrl2,Y                 ;
LBB9C:  LDA MusicSQ1PeriodHigh,Y        ;Write data to three sound channel addresses.
LBB9F:  STA SQ1Cntrl3,Y                 ;
LBBA2:  LDA MusicSQ1Sweep,X             ;
LBBA5:  STA SQ1Cntrl1,Y                 ;

LoadNewMusicFrameCount:
LBBA8:  LDA SQ1FrameCountInit,X         ;Load new music frame count and store it in music-->
LBBAB:  STA SQ1MusicFrameCount,X        ;frame count address.
LBBAE:  JMP IncrementToNextChannel      ;($BAB3)Move to next sound channel.

SQ1SQ2InUse:
LBBB1:* INC SQ1InUse,X                  ;Restore in use status of SQ1 or SQ1.
LBBB4:  JMP LoadNewMusicFrameCount      ;($BBA8)Load new music frame count.

LoadTriangleCntrl0:
LBBB7:  LDA TriangleCounterCntrl        ;
LBBBA:  AND #$0F                        ;If lower bits set, branch to play shorter note. 
LBBBC:  BNE ++                          ;
LBBBE:  LDA TriangleCounterCntrl        ;
LBBC1:  AND #$F0                        ;If upper bits are set, branch to play longer note.
LBBC3:  BNE +                           ;
LBBC5:  TYA                             ;
LBBC6:  JMP AddTriangleLength           ;($BBCD)Calculate length to play note.
LBBC9:* LDA #$FF                        ;Disable length cntr(play until triangle data changes).
LBBCB:  BNE +                           ;Branch always.

AddTriangleLength:
LBBCD:  CLC                             ;
LBBCE:  ADC #$FF                        ;Add #$FF(Effectively subtracts 1 from A).
LBBD0:  ASL                             ;*2.
LBBD1:  ASL                             ;*2.
LBBD2:  CMP #$3C                        ;
LBBD4:  BCC +                           ;If result is greater than #$3C, store #$3C(highest-->
LBBD6:  LDA #$3C                        ;triangle linear count allowed).
LBBD8:* STA TriLinearCount              ;
LBBDB:* JMP LoadSoundDataIndexIndex     ;($BB37)Load index to sound data index.

LoadNoiseChannelMusic:
LBBDE:  LDA NoiseContSFX                ;
LBBE1:  AND #$FC                        ;If playing any Noise SFX, branch to exit.
LBBE3:  BNE +                           ;
LBBE5:  LDA $B200,Y                     ;
LBBE8:  STA NoiseCntrl0                 ;Load noise channel with drum beat SFX starting-->
LBBEB:  LDA $B201,Y                     ;at address B201.  The possible values of Y are-->
LBBEE:  STA NoiseCntrl2                 ;#$01, #$04, #$07 or #$0A.
LBBF1:  LDA $B202,Y                     ;
LBBF4:  STA NoiseCntrl3                 ;
LBBF7:* JMP LoadNewMusicFrameCount      ;($BBA8)Load new music frame count.

;The following table is used by the InitializeMusic routine to find the index for loading
;addresses $062B thru $0637.  Base is $BD31.

InitMusicIndexTbl:
LBBFA:  .byte $41                       ;Ridley area music.
LBBFB:  .byte $8F                       ;Tourian music.
LBBFC:  .byte $34                       ;Item room music.
LBBFD:  .byte $27                       ;Kraid area music.
LBBFE:  .byte $1A                       ;Norfair music.
LBBFF:  .byte $0D                       ;Escape music.
LBC00:  .byte $00                       ;Mother brain music.
LBC01:  .byte $82                       ;Brinstar music.
LBC02:  .byte $68                       ;Fade in music.
LBC03:  .byte $75                       ;Power up music.
LBC04:  .byte $4E                       ;End music.
LBC05:  .byte $5B                       ;Intro music.

;The tables below contain addresses for SFX and music handling routines.
;Multi channel Init SFX and music handling routine addresses:

LBC06:  .word $BC80                     ;Fade in music.
LBC08:  .word $BC7A                     ;Power up music. 
LBC0A:  .word $BC86                     ;End game music.
LBC0C:  .word $BC7A                     ;Intro music.
LBC0E:  .word $B4EE                     ;No sound.
LBC10:  .word $B673                     ;Samus hit init SFX.
LBC12:  .word $B5EC                     ;Boss hit init SFX.
LBC14:  .word $B695                     ;Incorrect password init SFX.

;Multi channel continue SFX handling routine addresses:

LBC16:  .word $B4EE                     ;No sound.
LBC18:  .word $B4EE                     ;No sound.
LBC1A:  .word $B4EE                     ;No sound.
LBC1C:  .word $B4EE                     ;No sound.
LBC1E:  .word $B4EE                     ;No sound.
LBC20:  .word $B650                     ;Samus hit continue SFX.
LBC22:  .word $B5F6                     ;Boss hit continue SFX.
LBC24:  .word $B6A1                     ;Incorrect password continue SFX.

;Music handling routine addresses:

LBC26:  .word $BC83                     ;Ridley area music.
LBC28:  .word $BC77                     ;Tourian music.
LBC2A:  .word $BC77                     ;Item room music.
LBC2C:  .word $BC77                     ;Kraid area music.
LBC2E:  .word $BC80                     ;Norfair music.
LBC30:  .word $BC7D                     ;Escape music.
LBC32:  .word $BC77                     ;Mother brain music.
LBC34:  .word $BC80                     ;Brinstar music.

;-----------------------------------[ Entry point for music routines ]--------------------------------

LoadMusicTempFlags:
LBC36:  LDA CurrentMusicRepeat          ;Load A with temp music flags, (9th SFX cycle).
LBC39:  LDX #$B6                        ;Lower address byte in ChooseNextSFXRoutineTbl.
LBC3B:  BNE +                           ;Branch always.

LoadMusicInitFlags:
LBC3D:  LDA MusicInitFlag               ;Load A with Music flags, (10th SFX cycle).
LBC40:  LDX #$B1                        ;Lower address byte in ChooseNextSFXRoutineTbl.
LBC42:* JSR CheckSFXFlag                ;($B4BD)Checks to see if SFX or music flags set.
LBC45:  JSR FindMusicInitIndex          ;($BC53)Find bit containing music init flag.
LBC48:  JMP ($00E2)                     ;If no flag found, Jump to next SFX cycle,-->
                                        ;else jump to specific SFX handling subroutine.

ContinueMusic:                          ;11th and last SFX cycle.
LBC4B:  LDA CurrentMusic                ;
LBC4E:  BEQ +++                         ;Branch to exit of no music playing.
LBC50:  JMP LoadCurrentMusicFrameData   ;($BAA5)Load info for current frame of music data.

;MusicInitIndex values correspond to the following music:
;#$00=Ridley area music, #$01=Tourian music, #$02=Item room music, #$03=Kraid area music,
;#$04=Norfair music, #$05=Escape music, #$06=Mother brain music, #$07=Brinstar music,
;#$08=Fade in music, #$09=Power up music, #$0A=End game music, #$0B=Intro music.

FindMusicInitIndex:
LBC53:  LDA #$FF                        ;Load MusicInitIndex with #$FF.
LBC55:  STA MusicInitIndex              ;
LBC58:  LDA CurrentSFXFlags             ;
LBC5B:  BEQ ++                          ;Branch to exit if no SFX flags set for Multi SFX.
LBC5D:* INC MusicInitIndex              ;
LBC60:  ASL                             ;Shift left until bit flag is in carry bit.
LBC61:  BCC -                           ;Loop until SFX flag found.  Store bit-->
LBC63:* RTS                             ;number of music in MusicInitIndex.

;The following routine is used to add eight to the music index when looking for music flags
;in the MultiSFX address.  
Add8:
LBC64:  LDA MusicInitIndex              ;
LBC67:  CLC                             ;
LBC68:  ADC #$08                        ;Add #$08 to MusicInitIndex.
LBC6A:  STA MusicInitIndex              ;
LBC6D:  RTS                             ;

LBC6E:  LDA CurrentMusic                ;
LBC71:  ORA #$F0                        ;This code does not appear to be used in this page.
LBC73:  STA CurrentMusic                ;
LBC76:* RTS                             ;

Music00Start:
LBC77:  JMP Music00Init                 ;($BCAA)Initialize music 00.

Music01Start:
LBC7A:  JMP Music01Init                 ;($BCA4)Initialize music 01.

Music02Start:
LBC7D:  JMP Music02Init                 ;($BC9A)Initialize music 02.

Msic03Start:
LBC80:  JMP Music03Init                 ;($BC96)Initialize music 03.

Music04Start:
LBC83:  JMP Music04Init                 ;($BC89)Initialize music 04.

Music05Start:
LBC86:  JMP Music05Init                 ;($BC9E)Initialize music 05.

Music04Init:
LBC89:  LDA #$B3                        ;Duty cycle and volume data for SQ1 and SQ2.

XYMusicInit:
LBC8B:* TAX                             ;Duty cycle and volume data for SQ1.
LBC8C:  TAY                             ;Duty cycle and volume data for SQ2.

LBC8D:* JSR SetVolumeAndDisableSweep    ;($B9E4)Set duty cycle and volume data for SQ1 and SQ2.
LBC90:  JSR InitializeMusic             ;($BF19)Setup music registers.
LBC93:  JMP LoadCurrentMusicFrameData   ;($BAA5)Load info for current frame of music data.

Music03Init:
LBC96:  LDA #$34                        ;Duty cycle and volume data for SQ1 and SQ2.
LBC98:  BNE --                          ;Branch always

Music02Init:
LBC9A:  LDA #$F4                        ;Duty cycle and volume data for SQ1 and SQ2.
LBC9C:  BNE --                          ;Branch always

Music05Init:
LBC9E:  LDX #$F5                        ;Duty cycle and volume data for SQ1.
LBCA0:  LDY #$F6                        ;Duty cycle and volume data for SQ2.
LBCA2:  BNE -                           ;Branch always

Music01Init:
LBCA4:  LDX #$B6                        ;Duty cycle and volume data for SQ1.
LBCA6:  LDY #$F6                        ;Duty cycle and volume data for SQ2.
LBCA8:  BNE -                           ;Branch always

Music00Init:
LBCAA:  LDX #$92                        ;Duty cycle and volume data for SQ1.
LBCAC:  LDY #$96                        ;Duty cycle and volume data for SQ2.
LBCAE:  BNE -                           ;Branch always

;The following address table provides starting addresses of the volume data tables below:
VolumeCntrlAddressTbl:
LBCB0:  .word $BCBA, $BCC5, $BCCF, $BCDA, $BD03

VolumeDataTbl1:
LBCBA:  .byte $01, $02, $02, $03, $03, $04, $05, $06, $07, $08, $FF

VolumeDataTbl2:
LBCC5:  .byte $02, $04, $05, $06, $07, $08, $07, $06, $05, $FF

VolumeDataTbl3:
LBCCF:  .byte $00, $0D, $09, $07, $06, $05, $05, $05, $04, $04, $FF

VolumeDataTbl4:
LBCDA:  .byte $02, $06, $07, $07, $07, $06, $06, $06, $06, $05, $05, $05, $04, $04, $04, $03
LBCEA:  .byte $03, $03, $03, $02, $03, $03, $03, $03, $03, $02, $02, $02, $02, $02, $02, $02
LBCFA:  .byte $02, $02, $02, $01, $01, $01, $01, $01, $F0

VolumeDataTbl5:
LBD03:  .byte $0A, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $07, $07, $06, $05, $04, $04
LBD13:  .byte $03, $02, $02, $02, $05, $05, $05, $04, $03, $02, $02, $02, $01, $01, $04, $04
LBD23:  .byte $03, $02, $01, $02, $02, $01, $01, $01, $02, $02, $02, $01, $01, $F0 

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

;Mother brain music.
LBD31:  .byte $0B, $FF, $F5, $00, $00
LBD36:  .word $B18C, $B18E, $B161, $0000

;Escape music.
LBD3E:  .byte $0B, $FF, $00, $02, $02
LBD43:  .word $B04D, $B000, $B0CF, $B15A

;Norfair music.
LBD4B:  .byte $0B, $FF, $F0, $04, $04
LBD50:  .word $B000, $B026, $B057, $B08B

;Kraid area music.
LBD58:  .byte $00, $FF, $F0, $00, $00
LBD5D:  .word $B03F, $B041, $B0AA, $0000

;Item room music.
LBD65:  .byte $0B, $FF, $03, $00, $00
LBD6A:  .word $BDDA, $BDDC, $BDCD, $0000

;Ridley area music.
LBD72:  .byte $0B, $FF, $F0, $01, $01
LBD77:  .word $B022, $B031, $B000, $0000

;End game music(not used this memory page).
LBD7F:  .byte $17, $00, $00, $02, $01
LBD84:  .word $0100, $0300, $0500, $0700

;Intro music(not used this memory page).
LBD8C:  .byte $17, $00, $F0, $02, $05
LBD91:  .word $0100, $0300, $0500, $0700

;Fade in music
LBD99:  .byte $0B, $00, $F0, $02, $00
LBD9E:  .word $BE3E, $BE1D, $BE36, $0000

;Power up music
LBDA6:  .byte $00, $00, $F0, $01, $00
LBDAB:  .word $BDF7, $BE0D, $BE08, $0000

;Brinstar music
LBDB3:  .byte $0B, $FF, $00, $02, $03
LBDB8:  .word $B000, $B057, $B0C1, $B12B

;Tourian music
LBDC0:  .byte $0B, $FF, $03, $00, $00
LBDC5:  .word $BE59, $BE47, $BE62, $0000

ItemRoomTriangleIndexData:
LBDCD:  .byte $C8                       ;
LBDCE:  .byte $B0                       ;3/32 seconds   +
LBDCF:  .byte $38                       ;E3             |
LBDD0:  .byte $3A                       ;F3             |
LBDD1:  .byte $3C                       ;F#3            |
LBDD2:  .byte $3E                       ;G3             |
LBDD3:  .byte $40                       ;Ab3            | Repeat 8 times
LBDD4:  .byte $3E                       ;G3             |
LBDD5:  .byte $3C                       ;F#3            |
LBDD6:  .byte $3A                       ;F3             |
LBDD7:  .byte $B6                       ;1 3/16 seconds |
LBDD8:  .byte $02                       ;no sound       +
LBDD9:  .byte $FF                       ;

ItemRoomSQ1IndexData:
LBDDA:  .byte $B8                       ;1/4 seconds
LBDDB:  .byte $02                       ;No sound

ItemRoomSQ2IndexData:
LBDDC:  .byte $B3                       ;3/4 seconds
LBDDD:  .byte $02                       ;No sound
LBDDE:  .byte $B2                       ;3/8 seconds
LBDDF:  .byte $74                       ;A#6
LBDE0:  .byte $02                       ;No sound
LBDE1:  .byte $6A                       ;F5
LBDE2:  .byte $02                       ;No sound
LBDE3:  .byte $72                       ;A6
LBDE4:  .byte $02                       ;No sound
LBDE5:  .byte $62                       ;C#5
LBDE6:  .byte $B4                       ;1 1/2 seconds
LBDE7:  .byte $02                       ;No sound
LBDE8:  .byte $B2                       ;3/8 seconds
LBDE9:  .byte $60                       ;C5
LBDEA:  .byte $02                       ;No sound
LBDEB:  .byte $6C                       ;F#5
LBDEC:  .byte $02                       ;No sound
LBDED:  .byte $76                       ;B6
LBDEE:  .byte $B3                       ;3/4 seconds
LBDEF:  .byte $02                       ;No sound
LBDF0:  .byte $B2                       ;3/8 seconds
LBDF1:  .byte $7E                       ;F6
LBDF2:  .byte $02                       ;No sound
LBDF3:  .byte $7C                       ;D6
LBDF4:  .byte $B3                       ;3/4 seconds
LBDF5:  .byte $02                       ;No sound
LBDF6:  .byte $00                       ;End item room music.

PowerUpSQ1IndexData:
LBDF7:  .byte $B3                       ;1/2 seconds
LBDF8:  .byte $48                       ;C4
LBDF9:  .byte $42                       ;A4
LBDFA:  .byte $B2                       ;1/4 seconds
LBDFB:  .byte $3E                       ;G3
LBDFC:  .byte $38                       ;E3
LBDFD:  .byte $30                       ;C3
LBDFE:  .byte $38                       ;E3
LBDFF:  .byte $4C                       ;D4
LBE00:  .byte $44                       ;A#4
LBE01:  .byte $3E                       ;G3
LBE02:  .byte $36                       ;D#3
LBE03:  .byte $C8                       ;
LBE04:  .byte $B0                       ;1/16 seconds   +
LBE05:  .byte $38                       ;E3             | Repeat 8 times
LBE06:  .byte $3C                       ;F#3            +
LBE07:  .byte $FF

PowerUpTriangleIndexData:
LBE08:  .byte $B4                       ;1 second
LBE09:  .byte $2C                       ;A#3
LBE0A:  .byte $2A                       ;A3
LBE0B:  .byte $1E                       ;D#2
LBE0C:  .byte $1C                       ;D2

PowerUpSQ2IndexData:
LBE0D:  .byte $B2                       ;1/4 seconds
LBE0E:  .byte $22                       ;F2
LBE0F:  .byte $2C                       ;A#3
LBE10:  .byte $30                       ;C3
LBE11:  .byte $34                       ;D3
LBE12:  .byte $38                       ;E3
LBE13:  .byte $30                       ;C3
LBE14:  .byte $26                       ;G2
LBE15:  .byte $30                       ;C3
LBE16:  .byte $3A                       ;F3
LBE17:  .byte $34                       ;D3
LBE18:  .byte $2C                       ;A#3
LBE19:  .byte $26                       ;G2
LBE1A:  .byte $B4                       ;1 second
LBE1B:  .byte $2A                       ;A3
LBE1C:  .byte $00                       ;End power up music.

FadeInSQ2IndexData:
LBE1D:  .byte $C4
LBE1E:  .byte $B0                       ;3/32 seconds   +
LBE1F:  .byte $3E                       ;G3             | Repeat 4 times
LBE20:  .byte $30                       ;C3             +
LBE21:  .byte $FF                       ;
LBE22:  .byte $C4                       ;
LBE23:  .byte $42                       ;A4             + Repeat 4 times
LBE24:  .byte $30                       ;C3             +
LBE25:  .byte $FF                       ;
LBE26:  .byte $C4                       ;
LBE27:  .byte $3A                       ;F3             + Repeat 4 times
LBE28:  .byte $2C                       ;A#3            +
LBE29:  .byte $FF                       ;
LBE2A:  .byte $C4                       ;
LBE2B:  .byte $38                       ;E3             + Repeat 4 times
LBE2C:  .byte $26                       ;G2             +
LBE2D:  .byte $FF                       ;
LBE2E:  .byte $C4                       ;
LBE2F:  .byte $34                       ;D3             + Repeat 4 times
LBE30:  .byte $20                       ;E2             +
LBE31:  .byte $FF                       ;
LBE32:  .byte $E0                       ;
LBE33:  .byte $34                       ;D3             + Repeat 32 times
LBE34:  .byte $24                       ;F#2            +
LBE35:  .byte $FF                       ;

FadeInTriangleIndexData:
LBE36:  .byte $B3                       ;3/4 seconds
LBE37:  .byte $36                       ;D#3
LBE38:  .byte $34                       ;D3
LBE39:  .byte $30                       ;C3
LBE3A:  .byte $2A                       ;A3
LBE3B:  .byte $B4                       ;1 1/2 seconds
LBE3C:  .byte $1C                       ;D2
LBE3D:  .byte $1C                       ;D2

FadeInSQ1IndexData:
LBE3E:  .byte $B3                       ;3/4 seconds
LBE3F:  .byte $34                       ;D3
LBE40:  .byte $3A                       ;F3
LBE41:  .byte $34                       ;D3
LBE42:  .byte $30                       ;C3
LBE43:  .byte $B4                       ;1 1/2 seconds
LBE44:  .byte $2A                       ;A3
LBE45:  .byte $2A                       ;A3
LBE46:  .byte $00                       ;End fade in music.

TourianSQ2IndexData:
LBE47:  .byte $B4                       ;1 1/2 seconds
LBE48:  .byte $12                       ;A2
LBE49:  .byte $B3                       ;3/4 seconds
LBE4A:  .byte $10                       ;Ab1
LBE4B:  .byte $18                       ;C2
LBE4C:  .byte $16                       ;B2
LBE4D:  .byte $0A                       ;F1
LBE4E:  .byte $B4                       ;1 1/2 seconds
LBE4F:  .byte $14                       ;A#2
LBE50:  .byte $12                       ;A2
LBE51:  .byte $B3                       ;3/4 seconds
LBE52:  .byte $10                       ;Ab1
LBE53:  .byte $06                       ;D1
LBE54:  .byte $0E                       ;G1
LBE55:  .byte $04                       ;C#1
LBE56:  .byte $B4                       ;1 1/2 seconds
LBE57:  .byte $0C                       ;F#1
LBE58:  .byte $00                       ;End Tourian music.

TourianSQ1IndexData:
LBE59:  .byte $E0                       ;
LBE5A:  .byte $B0                       ;3/32 seconds   +
LBE5B:  .byte $54                       ;F#4            |
LBE5C:  .byte $4E                       ;D#4            |
LBE5D:  .byte $48                       ;C4             | Repeat 32 times
LBE5E:  .byte $42                       ;A4             |
LBE5F:  .byte $48                       ;C4             |
LBE60:  .byte $4E                       ;D#4            +
LBE61:  .byte $FF                       ;

TourianTriangleIndexData:
LBE62:  .byte $E0                       ;
LBE63:  .byte $B3                       ;3/4 seconds    +
LBE64:  .byte $02                       ;No sound       |
LBE65:  .byte $B0                       ;3/32 seconds   |
LBE66:  .byte $3C                       ;F#3            |
LBE67:  .byte $40                       ;Ab3            |
LBE68:  .byte $44                       ;A#4            |
LBE69:  .byte $4A                       ;C#4            |
LBE6A:  .byte $4E                       ;D#4            |
LBE6B:  .byte $54                       ;F#4            |
LBE6C:  .byte $58                       ;Ab4            | Repeat 32 times
LBE6D:  .byte $5C                       ;A#5            |
LBE6E:  .byte $62                       ;C#5            |
LBE6F:  .byte $66                       ;D#5            |
LBE70:  .byte $6C                       ;F#5            |
LBE71:  .byte $70                       ;Ab5            |
LBE72:  .byte $74                       ;A#6            |
LBE73:  .byte $7A                       ;C#6            |
LBE74:  .byte $B3                       ;3/4 seconds    |
LBE75:  .byte $02                       ;No sound       +
LBE76:  .byte $FF

;The following table contains the musical notes used by the music player.  The first byte is
;the period high information(3 bits) and the second byte is the period low information(8 bits).
;The formula for figuring out the frequency is as follows: 1790000/16/(hhhllllllll + 1)

MusicNotesTbl:
LBE77:  .byte $07                       ;55.0Hz (A1)    Index #$00 (Not used)
LBE78:  .byte $F0                       ;

LBE79:  .byte $00                       ;No sound       Index #$02
LBE7A:  .byte $00                       ;

LBE7B:  .byte $06                       ;69.3Hz (C#2)   Index #$04
LBE7C:  .byte $4E                       ;

LBE7D:  .byte $05                       ;73.4Hz (D2)    Index #$06
LBE7E:  .byte $F3                       ;

LBE7F:  .byte $05                       ;82.4Hz (E2)    Index #$08
LBE80:  .byte $4D                       ;

LBE81:  .byte $05                       ;87.3Hz (F2)    Index #$0A
LBE82:  .byte $01                       ;

LBE83:  .byte $04                       ;92.5Hz (F#2)   Index #$0C
LBE84:  .byte $B9                       ;

LBE85:  .byte $04                       ;98.0Hz (G2)    Index #$0E
LBE86:  .byte $75                       ;

LBE87:  .byte $04                       ;103.8Hz (Ab2)  Index #$10
LBE88:  .byte $35                       ;

LBE89:  .byte $03                       ;110.0Hz (A2)   Index #$12
LBE8A:  .byte $F8                       ;

LBE8B:  .byte $03                       ;116.5Hz (A#2)  Index #$14
LBE8C:  .byte $BF                       ;

LBE8D:  .byte $03                       ;123.5Hz (B2)   Index #$16
LBE8E:  .byte $89                       ;

LBE8F:  .byte $03                       ;130.7Hz (C3)   Index #$18
LBE90:  .byte $57                       ;

LBE91:  .byte $03                       ;138.5Hz (C#3)  Index #$1A
LBE92:  .byte $27                       ;

LBE93:  .byte $02                       ;146.8Hz (D3)   Index #$1C
LBE94:  .byte $F9                       ;

LBE95:  .byte $02                       ;155.4Hz (D#3)  Index #$1E
LBE96:  .byte $CF                       ;

LBE97:  .byte $02                       ;164.8Hz (E3)   Index #$20
LBE98:  .byte $A6                       ;

LBE99:  .byte $02                       ;174.5Hz (F3)   Index #$22
LBE9A:  .byte $80                       ;

LBE9B:  .byte $02                       ;184.9Hz (F#3)  Index #$24
LBE9C:  .byte $5C                       ;

LBE9D:  .byte $02                       ;196.0Hz (G3)   Index #$26
LBE9E:  .byte $3A                       ;       
        
LBE9F:  .byte $02                       ;207.6Hz (Ab3)  Index #$28
LBEA0:  .byte $1A                       ;

LBEA1:  .byte $01                       ;219.8Hz (A3)   Index #$2A
LBEA2:  .byte $FC                       ;

LBEA3:  .byte $01                       ;233.1Hz (A#3)  Index #$2C
LBEA4:  .byte $DF                       ;

LBEA5:  .byte $01                       ;247.0Hz (B3)   Index #$2E
LBEA6:  .byte $C4                       ;

LBEA7:  .byte $01                       ;261.4Hz (C4)   Index #$30
LBEA8:  .byte $AB                       ;

LBEA9:  .byte $01                       ;276.9Hz (C#4)  Index #$32
LBEAA:  .byte $93                       ;

LBEAB:  .byte $01                       ;293.6Hz (D4)   Index #$34
LBEAC:  .byte $7C                       ;

LBEAD:  .byte $01                       ;310.8Hz (D#4)  Index #$36
LBEAE:  .byte $67                       ;

LBEAF:  .byte $01                       ;330.0Hz (E4)   Index #$38
LBEB0:  .byte $52                       ;

LBEB1:  .byte $01                       ;349.6Hz (F4)   Index #$3A
LBEB2:  .byte $3F                       ;

LBEB3:  .byte $01                       ;370.4Hz (F#4)  Index #$3C
LBEB4:  .byte $2D                       ;

LBEB5:  .byte $01                       ;392.5Hz (G4)   Index #$3E
LBEB6:  .byte $1C                       ;

LBEB7:  .byte $01                       ;415.9Hz (Ab4)  Index #$40
LBEB8:  .byte $0C                       ;

LBEB9:  .byte $00                       ;440.4Hz (A4)   Index #$42
LBEBA:  .byte $FD                       ;

LBEBB:  .byte $00                       ;468.1Hz (A#4)  Index #$44
LBEBC:  .byte $EE                       ;

LBEBD:  .byte $00                       ;495.0Hz (B4)   Index #$46
LBEBE:  .byte $E1                       ;

LBEBF:  .byte $00                       ;525.2Hz (C5)   Index #$48
LBEC0:  .byte $D4                       ;

LBEC1:  .byte $00                       ;556.6Hz (C#5)  Index #$4A
LBEC2:  .byte $C8                       ;

LBEC3:  .byte $00                       ;588.8Hz (D5)   Index #$4C
LBEC4:  .byte $BD                       ;

LBEC5:  .byte $00                       ;625.0Hz (D#5)  Index #$4E
LBEC6:  .byte $B2                       ;

LBEC7:  .byte $00                       ;662.0Hz (E5)   Index #$50
LBEC8:  .byte $A8                       ;

LBEC9:  .byte $00                       ;699.2Hz (F5)   Index #$52
LBECA:  .byte $9F                       ;

LBECB:  .byte $00                       ;740.9Hz (F#5)  Index #$54
LBECC:  .byte $96                       ;

LBECD:  .byte $00                       ;787.9Hz (G5)   Index #$56
LBECE:  .byte $8D                       ;

LBECF:  .byte $00                       ;834.9Hz (Ab5)  Index #$58
LBED0:  .byte $85                       ;

LBED1:  .byte $00                       ;880.9HZ (A5)   Index #$5A
LBED2:  .byte $7E                       ;

LBED3:  .byte $00                       ;940.1Hz (A#5)  Index #$5C
LBED4:  .byte $76                       ;

LBED5:  .byte $00                       ;990.0Hz (B5)   Index #$5E
LBED6:  .byte $70                       ;

LBED7:  .byte $00                       ;1055Hz (C6)    Index #$60
LBED8:  .byte $69                       ;

LBED9:  .byte $00                       ;1118Hz (C#6)   Index #$62
LBEDA:  .byte $63                       ;

LBEDB:  .byte $00                       ;1178Hz (D6)    Index #$64
LBEDC:  .byte $5E                       ;

LBEDD:  .byte $00                       ;1257Hz (D#6)   Index #$66
LBEDE:  .byte $58                       ;

LBEDF:  .byte $00                       ;1332Hz (E6)    Index #$68
LBEE0:  .byte $53                       ;

LBEE1:  .byte $00                       ;1398Hz (F6)    Index #$6A
LBEE2:  .byte $4F                       ;

LBEE3:  .byte $00                       ;1492Hz (F#6)   Index #$6C
LBEE4:  .byte $4A                       ;

LBEE5:  .byte $00                       ;1576Hz (G6)    Index #$6E
LBEE6:  .byte $46                       ;

LBEE7:  .byte $00                       ;1670Hz (Ab6)   Index #$70
LBEE8:  .byte $42                       ;

LBEE9:  .byte $00                       ;1776Hz (A6)    Index #$72
LBEEA:  .byte $3E                       ;

LBEEB:  .byte $00                       ;1896Hz (A#6)   Index #$74
LBEEC:  .byte $3A                       ;

LBEED:  .byte $00                       ;1998Hz (B6)    Index #$76
LBEEE:  .byte $37                       ;

LBEEF:  .byte $00                       ;2111Hz (C7)    Index #$78
LBEF0:  .byte $34                       ;

LBEF1:  .byte $00                       ;2238Hz (C#7)   Index #$7A
LBEF2:  .byte $31                       ;

LBEF3:  .byte $00                       ;2380Hz (D7)    Index #$7C
LBEF4:  .byte $2E                       ;

LBEF5:  .byte $00                       ;2796Hz (F7)    Index #$7E
LBEF6:  .byte $27                       ;

;The following tables are used to load the music frame count addresses ($0640 thru $0643). The
;larger the number, the longer the music will play a solid note.  The number represents how
;many frames the note will play.  There is a small discrepancy in time length because the
;Nintendo runs at 60 frames pers second and I am using 64 frames per second to make the
;numbers below divide more evenly.

;Used by power up music and Kraid area music.

NoteLengths0Tbl:
LBEF7:  .byte $04                       ;About    1/16 seconds ($B0)
LBEF8:  .byte $08                       ;About    1/8  seconds ($B1)
LBEF9:  .byte $10                       ;About    1/4  seconds ($B2)
LBEFA:  .byte $20                       ;About    1/2  seconds ($B3)
LBEFB:  .byte $40                       ;About 1       seconds ($B4)
LBEFC:  .byte $18                       ;About    3/8  seconds ($B5)
LBEFD:  .byte $30                       ;About    3/4  seconds ($B6)
LBEFE:  .byte $0C                       ;About    3/16 seconds ($B7)
LBEFF:  .byte $0B                       ;About   11/64 seconds ($B8)
LBF00:  .byte $05                       ;About    5/64 seconds ($B9)
LBF01:  .byte $02                       ;About    1/32 seconds ($BA)

;Used by item room, fade in, Brinstar music, Ridley area music, Mother brain music,
;escape music, Norfair music and Tourian music.

NoteLengths1Tbl:
LBF02:  .byte $06                       ;About    3/32 seconds ($B0)
LBF03:  .byte $0C                       ;About    3/16 seconds ($B1)
LBF04:  .byte $18                       ;About    3/8  seconds ($B2)
LBF05:  .byte $30                       ;About    3/4  seconds ($B3)
LBF06:  .byte $60                       ;About 1  1/2  seconds ($B4)
LBF07:  .byte $24                       ;About    9/16 seconds ($B5)
LBF08:  .byte $48                       ;About 1  3/16 seconds ($B6)
LBF09:  .byte $12                       ;About    9/32 seconds ($B7)
LBF0A:  .byte $10                       ;About    1/4  seconds ($B8)
LBF0B:  .byte $08                       ;About    1/8  seconds ($B9)
LBF0C:  .byte $03                       ;About    3/64 seconds ($BA)

;Used by intro and end game music.

NoteLengths2Tbl:
LBF0D:  .byte $10                       ;About    1/4  seconds ($B0)
LBF0E:  .byte $07                       ;About    7/64 seconds ($B1)
LBF0F:  .byte $0E                       ;About    7/32 seconds ($B2)
LBF10:  .byte $1C                       ;About    7/16 seconds ($B3)
LBF11:  .byte $38                       ;About    7/8  seconds ($B4)
LBF12:  .byte $70                       ;About 1 13/16 seconds ($B5)
LBF13:  .byte $2A                       ;About   21/32 seconds ($B6)
LBF14:  .byte $54                       ;About 1  5/16 seconds ($B7)
LBF15:  .byte $15                       ;About   21/64 seconds ($B8)
LBF16:  .byte $12                       ;About    9/32 seconds ($B9)
LBF17:  .byte $02                       ;About    1/32 seconds ($BA)
LBF18:  .byte $03                       ;About    3/64 seconds ($BB)

InitializeMusic:                                        
LBF19:  JSR CheckMusicFlags             ;($B3FC)Check to see if restarting current music.
LBF1C:  LDA CurrentSFXFlags             ;Load current SFX flags and store CurrentMusic address.
LBF1F:  STA CurrentMusic                ;
LBF22:  LDA MusicInitIndex              ;
LBF25:  TAY                             ;
LBF26:  LDA InitMusicIndexTbl,Y         ;($BBFA)Find index for music in InitMusicInitIndexTbl.
LBF29:  TAY                             ;
LBF2A:  LDX #$00                        ;

LBF2C:* LDA InitMusicTbl,Y              ;Base is $BD31.
LBF2F:  STA NoteLengthTblOffset,X       ;
LBF32:  INY                             ;The following loop repeats 13 times to-->
LBF33:  INX                             ;load the initial music addresses -->
LBF34:  TXA                             ;(registers $062B thru $0637).
LBF35:  CMP #$0D                        ;
LBF37:  BNE -                           ;

LBF39:  LDA #$01                        ;Resets addresses $0640 thru $0643 to #$01.-->
LBF3B:  STA SQ1MusicFrameCount          ;These addresses are used for counting the-->
LBF3E:  STA SQ2MusicFrameCount          ;number of frames music channels have been playing.
LBF41:  STA TriangleMusicFrameCount     ;
LBF44:  STA NoiseMusicFrameCount        ;
LBF47:  LDA #$00                        ;
LBF49:  STA SQ1MusicIndexIndex          ;
LBF4C:  STA SQ2MusicIndexIndex          ;Resets addresses $0638 thru $063B to #$00.-->
LBF4F:  STA TriangleMusicIndexIndex     ;These are the index to find sound channel data index.
LBF52:  STA NoiseMusicIndexIndex        ;
LBF55:  RTS                             ;
