;----------------------------------[ Initiate SFX and music routines ]-------------------------------

;Initiate sound effects.

SilenceMusic:                           ;The sound flags are stored in memory-->
LCB8E:  lda #$01                        ;starting at $0680. The following is a-->
LCB90:  bne SFX_SetX0                   ;list of sound effects played when the-->
                                        ;flags are set:
PauseMusic:                             ;
LCB92:  lda #$02                        ;$0680: These SFX use noise channel.
LCB94:  bne SFX_SetX0                   ;Bit 7 - No sound.
                                        ;Bit 6 - ScrewAttack.
SFX_SamusWalk:                          ;Bit 5 - MissileLaunch.
LCB96:  lda #$08                        ;Bit 4 - BombExplode.
LCB98:  bne SFX_SetX0                   ;Bit 3 - SamusWalk.
                                        ;Bit 2 - SpitFlame.
SFX_BombExplode:                        ;Bit 1 - No sound.
LCB9A:  lda #$10                        ;Bit 0 - No sound.
LCB9C:  bne SFX_SetX0                   ;
                                        ;$0681: These SFX use sq1 channel.
SFX_MissileLaunch:                      ;Bit 7 - MissilePickup.
LCB9E:  lda #$20                        ;Bit 6 - EnergyPickup.
                                        ;Bit 5 - Metal.
SFX_SetX0:                              ;Bit 4 - BulletFire.
LCBA0:  ldx #$00                        ;Bit 3 - OutOfHole.
LCBA2:  beq SFX_SetSoundFlag            ;Bit 2 - EnemyHit.
                                        ;Bit 1 - SamusJump.
SFX_OutOfHole:                          ;Bit 0 - WaveFire.
LCBA4:  lda #$08                        ;
LCBA6:  bne SFX_SetX1                   ;$0682: Not used.
                                        ;
SFX_BombLaunch:                         ;$0683: These SFX use tri channel.
LCBA8:  lda #$01                        ;Bit 7 - SamusDie.
LCBAA:  bne SFX_SetX3                   ;Bit 6 - DoorOpenClose.
                                        ;Bit 5 - MetroidHit.
SFX_SamusJump:                          ;Bit 4 - StatueRaise.
LCBAC:  lda #$02                        ;Bit 3 - Beep.
LCBAE:  bne SFX_SetX1                   ;Bit 2 - BigEnemyHit.
                                        ;Bit 1 - SamusBall.
SFX_EnemyHit:                           ;Bit 0 - BombLaunch.
LCBB0:  lda #$04                        ;
LCBB2:  bne SFX_SetX1                   ;$0684: These SFX use multi channels.
                                        ;Bit 7 - FadeInMusic            (music).
SFX_BulletFire:                         ;Bit 6 - PowerUpMusic           (music).
LCBB4:  lda #$10                        ;Bit 5 - EndMusic  (Page 0 only)(music).
LCBB6:  bne SFX_SetX1                   ;Bit 4 - IntroMusic(Page 0 only)(music).
                                        ;Bit 3 - not used               (SFX).
SFX_Metal:                              ;Bit 2 - SamusHit               (SFX).
LCBB8:  lda #$20                        ;Bit 1 - BossHit                (SFX).
LCBBA:  bne SFX_SetX1                   ;Bit 0 - IncorrectPassword      (SFX).
                                        ;
SFX_EnergyPickup:                       ;$0685: Music flags. The music flags start different-->
LCBBC:  lda #$40                        ;music depending on what memory page is loaded. The-->
LCBBD:  bne SFX_SetX1                   ;following lists what bits start what music for each-->
                                        ;memory page.
SFX_MissilePickup:                      ;
LCBC0:  lda #$80                        ;Page 0: Intro/ending.
                                        ;Bit 7 - Not used.
SFX_SetX1:                              ;Bit 6 - TourianMusic.
LCBC2:  ldx #$01                        ;Bit 5 - ItemRoomMusic.
LCBC4:  bne SFX_SetSoundFlag            ;Bit 4 - Not used.
                                        ;Bit 3 - Not used.
SFX_WaveFire:                           ;Bit 2 - Not used.
LCBC6:  lda #$01                        ;Bit 1 - Not used.
LCBC8:  bne SFX_SetX1                   ;Bit 0 - Not used.
                                        ;
SFX_ScrewAttack:                        ;Page 1: Brinstar.
LCBCA:  lda #$40                        ;Bit 7 - Not used.
LCBCC:  bne SFX_SetX0                   ;Bit 6 - TourianMusic.
                                        ;Bit 5 - ItemRoomMusic.
SFX_BigEnemyHit:                        ;Bit 4 - Not used.
LCBCE:  lda #$04                        ;Bit 3 - Not used.
LCBD0:  bne SFX_SetX3                   ;Bit 2 - Not used.
                                        ;Bit 1 - Not used.
SFX_MetroidHit:                         ;Bit 0 - BrinstarMusic.
LCBD2:  lda #$20                        ;
LCBD4:  bne SFX_SetX3                   ;Page 2: Norfair.
                                        ;Bit 7 - Not used.
SFX_BossHit:                            ;Bit 6 - TourianMusic.
LCBD6:  lda #$02                        ;Bit 5 - ItemRoomMusic.
LCBD8:  bne SFX_SetX4                   ;Bit 4 - Not used.
                                        ;Bit 3 - NorfairMusic.
SFX_Door:                               ;Bit 2 - Not used.
LCBDA:  lda #$40                        ;Bit 1 - Not used.
LCBDC:  bne SFX_SetX3                   ;Bit 0 - Not used.
                                        ;
SFX_SamusHit:                           ;Page 3: Tourian.
LCBDE:  lda #$04                        ;Bit 7 - Not used.
LCBE0:  bne SFX_SetX4                   ;Bit 6 - TourianMusic
                                        ;Bit 5 - ItemRoomMusic.
SFX_SamusDie:                           ;Bit 4 - Not used.
LCBE2:  lda #$80                        ;Bit 3 - Not used.
LCBE4:  bne SFX_SetX3                   ;Bit 2 - EscapeMusic.
                                        ;Bit 1 - MotherBrainMusic
SFX_SetX2:                              ;Bit 0 - Not used.
LCBE6:  ldx #$02                        ;
                                        ;Page 4: Kraid.
SFX_SetSoundFlag:                       ;Bit 7 - RidleyAreaMusic.
LCBE8:  ora $0680,x                     ;Bit 6 - TourianMusic.
LCBEB:  sta $0680,x                     ;Bit 5 - ItemRoomMusic.
LCBEE:  rts                             ;Bit 4 - KraidAreaMusic.
                                        ;Bit 3 - Not used.
SFX_SamusBall:                          ;Bit 2 - Not used.
LCBEF:  lda #$02                        ;Bit 1 - Not used.
LCBF1:  bne SFX_SetX3                   ;Bit 0 - Not used.
                                        ;
SFX_Beep:                               ;Page 5: Ridley.
LCBF3:  lda #$08                        ;Bit 7 - RidleyAreaMusic.
                                        ;Bit 6 - TourianMusic.
SFX_SetX3:                              ;Bit 5 - ItemRoomMusic.
LCBF5:  ldx #$03                        ;Bit 4 - KraidAreaMusic.
LCBF7:  bne SFX_SetSoundFlag            ;Bit 3 - Not used.
                                        ;Bit 2 - Not used.
;Initiate music                         ;Bit 1 - Not used.
                                        ;Bit 0 - Not used.
PowerUpMusic:                           ;
LCBF9:  lda #$40                        ;
LCBFB:  bne SFX_SetX4                   ;
                                        ;
IntroMusic:                             ;
LCBFD:  lda #$80                        ;
                                        ;
SFX_SetX4:                              ;
LCBFF:  ldx #$04                        ;
LCC01:  bne SFX_SetSoundFlag            ;
                                        ;
MotherBrainMusic:                       ;
LCC03:  lda #$02                        ;
LCC05:  bne SFX_SetX5                   ;
                                        ;
TourianMusic:                           ;
LCC07:  lda #$40                        ;
                                        ;
SFX_SetX5:                              ;
LCC09:  ldx #$05                        ;
LCC0B:  bne SFX_SetSoundFlag            ;