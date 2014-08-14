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
;Disassembled, reconstructed and commented
;by SnowBro [Kent Hansen] <kentmhan@online.no>
;Continued by Dirty McDingus (nmikstas@yahoo.com)
;Can be reassembled using Ophis.
;A work in progress.
;Last updated: 3/9/2010

;Metroid defines.

;-------------------------------------------[ Defines ]----------------------------------------------

.alias CodePtr			$0C	;Points to address to jump to when choosing-->
;      CodePtr+1		$0D	;a routine from a list of routine addresses.

;The bits of the change and status addresses represent the following joypad buttons:
;bit 7=A, bit 6=B, bit 5=SELECT, bit 4=START, bit 3=Up, bit 2=Down, bit 1=Left, bit 0=Right.

.alias Joy1Change   		$12	;These addresses store any button changes-->
.alias Joy2Change		$13	;that happened since last frame(pads 1 and 2).
.alias Joy1Status   		$14	;These two addresses store all buttons-->
.alias Joy2Status		$15	;currently being pressed on the two controllers.
.alias Joy1Retrig   		$16	;These two addresses store any buttons that need-->
.alias Joy2Retrig		$17	;to retrigger after being held down by player.
.alias RetrigDelay1   		$18	;These two addresses are counters that control-->
.alias RetrigDelay2		$19	;The retriggering of held down buttons.

.alias NMIStatus		$1A	;0=NMI in progress. anything else, NMI not in progress.
.alias PPUDataPending		$1B	;1=not PPU data pending, 1=data pending.
.alias PalDataPending		$1C	;Pending palette data. Palette # = PalDataPending - 1.
.alias GameMode			$1D     ;0 = Game is playing, 1 = At title/password screen
.alias MainRoutine		$1E	;5 = Game paused, 3 = Game engine running
.alias TitleRoutine		$1F	;Stores title routine number currently running.
.alias NextRoutine		$20	;Stores next routine to jump to after WaitTimer expires.
.alias CurrentBank		$23	;0 thru 7. current memory page in lower memory block.
.alias SwitchPending		$24	;Switch memory page. Page # = SwitchPending - 1.
.alias MMCReg0Cntrl		$25	;Stores bits to be loaded into MMC1 Register 0.
.alias SwitchUpperBits		$28	;Used to store bits 3 and 4 for MMC1 register 3.  Bits-->
					;3 and 4 should always be 0 under normal conditions.

.alias TimerDelay		$29	;Count down from 9 to 0. Decremented every frame.
.alias Timer1			$2A	;Decremented every frame after set.
.alias Timer2			$2B	;Decremented every frame after set.
.alias Timer3			$2C	;Decremented every 10 frames after set.

.alias FrameCount		$2D     ;Increments every frame(overflows every 256 frames).

.alias RandomNumber1		$2E	;Random numbers used--> 	
.alias RandomNumber2		$2F	;throughout the game.

.alias SpareMem30		$30	;Written to, but never accessed.
.alias GamePaused		$31	;#$00=Game running, #$01=Game paused.

.alias RoomPtr			$33	;Low byte of room pointer address.
;      RoomPtr+1		$34	;High byte of room pointer address.

.alias StructPtr		$35	;Low bute of structure pointer address.
;      StructPtr+1		$36	;High byte of structure pointer address.
				
.alias CartRAMWorkPtr		$37	;Low byte of pointer to current position in room RAM.
;      CartRAMWorkPtr+1		$38	;High byte of pointer to current position in room RAM.
					;The CartRAMWorkPtr points to the current memory address-->
					;in the room RAM that is being loaded.

.alias CartRAMPtr   		$39	;Low byte of pointer to room RAM (#$00).
;      CartRAMPtr+1		$3A	;High byte of pointer to room RAM (#$60 or #$64).
					;Room RAM is a screen buffer where the objects that make-->
					;up a room are loaded.  There are two room RAM memory-->
					;areas and they are the exact same size as the two name-->
					;tables and attribute tables in the PPU. Once the room-->
					;RAM conatins a completed room in it, the entire contents-->
					;of the room RAM is loaded into the PPU. 

.alias RoomPtrTable		$3B	;Low byte of start of room pointer table.
;      RoomPtrTable+1		$3C	;High byte of start of room pointer table.

.alias StructPtrTable		$3D	;Low byte of start of structure pointer table.
;      StructPtrTable+1		$3E	;High byte of structure pointer table.

.alias MacroPtr			$3F	;Low byte of pointer into macro definitions.
;      MacroPtr+1		$40	;High byte of pointer into macro definitions.

.alias EnmyFrameTbl1Ptr		$41	;Low byte of pointer into address table to find enemy animations.
;      EnmyFrameTbl1Ptr+1	$42	;High byte of pointer into address table to find enemy animations.

.alias EnmyFrameTbl2Ptr		$43	;Same as above except in a second table because there are-->
;      EnmyFrameTbl2Ptr+1	$44	;too many entries to fit into one table.

.alias EnmyPlaceTblPtr		$45	;Low byte of pointer into enemy frame placement table.
;      EnmyPlaceTblPtr+1	$46	;High byte of pointer into enemy frame placement table.

.alias EnemyAnimPtr		$47	;Low byte of start of EnemyAnimIndexTbl.
;      EnemyAnimPtr+1		$48	;High byte of start of EnemyAnimIndexTbl.

.alias ScrollDir		$49     ;0=Up, 1=Down, 2=Left, 3=Right.

.alias TempScrollDir		$4A	;Stores ScrollDir when room is initially loaded.

.alias PageIndex		$4B	;Index to object data.
					;#$D0, #$E0, #$F0 = projectile indices(including bombs).
					;
.alias ItemIndex		$4C	;#$00 or #$08. Added to PowerUpType addresses to determine if-->
					;the first or second item slot is being checked. 

.alias SamusDir			$4D     ;0 = Right, 1 = Left.
.alias SamusDoorDir		$4E     ;Direction Samus passed through door.
.alias MapPosY			$4F	;Current y position on world map.
.alias MapPosX			$50	;Current x position on world map.
.alias SamusScrX		$51	;Samus x position on screen.
.alias SamusScrY		$52	;Samus y position on screen.
.alias WalkSoundDelay		$53
.alias IsSamus			$55	;1=Samus object being accessed, 0=not Samus.
.alias DoorStatus		$56	;0=Not in door, 1=In right door, 2=In left door, 3=Scroll up-->
					;4=Scroll down, 5=Exit door, MSB set=Door entered. If value-->
					;is 3 or 4, a door was entered while in a verticle shaft and-->
					;the door was not centered on the screen and up or down-->
					;scrolling needs to occur before scrolling to the next room.
.alias DoorScrollStatus		$57	;#$01=Entered right hand door from horizontal area.-->
					;#$02=Entered left hand door from horizontal area.-->
					;#$03=Entered door from verticle shaft and room needs to-->
					;be centered before horizontal scrolling. #$04=Entered-->
					;door from verticle shaft and room was already centered.
.alias SamusDoorData		$58	;The upper 4 bits store either 1 or 2. If 1 is stored(bit 4-->
					;set), the scrolling after Samus exits the door is toggled.-->
					;If 2 is stored(bit 5 set), the scrolling is set to-->
					;horizontal scrolling after Samus exits the door. This-->
					;happens mostly in item rooms. The lower 4 bits store Samus'-->
					;action status as she enters the door. This is used to set-->
					;Samus' action after she exits and keeps her looking the same.
.alias DoorDelay		$59	;Number of frames to delay when Samus entering/exiting doors.
.alias RoomNumber		$5A	;Room number currently being loaded.
.alias SpritePagePos		$5B	;Index into sprite RAM used to load object sprite data.
.alias SamusInLava		$64	;#$01=Samus in lava, #$00=She is not.
.alias ObjectCounter		$65	;Counts such things as object explosion time.
.alias ObjectPal		$67	;Attrib. table info for room object(#$00 thru #$03).
.alias RoomPal			$68
.alias TempX			$69
.alias TempY			$6A
.alias ObjectCntrl		$6B	;Controls object properties such as mirroring and color-->
					;bits. Bit 4 controls object mirroring.

.alias DoorOnNameTable3		$6C	;The following two addresses are used to keep track of the-->
.alias DoorOnNameTable0		$6D	;doors loaded on the name tables. The information is used-->
					;in the GetRoomNum routine to prevent the loading of a-->
					;room behind a door when scrolling horizontally. This has-->
					;the effect of stopping scrolling until Samus walks through-->
					;the door. #$01=Left door on name table. #$02=right door-->
					;on name table. #$03 two doors on the same name table.-->
					;#$00 is possible in $6D if 2 doors are on name table 0-->
					;while vertically scrolling.

.alias HealthLoChange		$6E	;Amount to add/subtract from HealthLo.
.alias HealthHiChange		$6F	;Amount to add/subtract from HealthHi.

.alias SamusBlink		$70
.alias UpdatingProjectile	$71	;#$01=Projectile update in process. #$00=not in process.
.alias DamagePushDirection	$72	;#$00=Push Samus left when hit, #$01=Push right, #$FF=No push. 
.alias InArea			$74	;#$10(or #$00)=Brinstar, #$11=Norfair, #$12=Kraid hideout,-->
					;#$13=Tourian, #$14=Ridley hideout.

.alias SpareMem75		$75	;Initialized to #$FF in AreaInit. Not used.
.alias PalToggle		$76

.alias ItemRoomMusicStatus	$79	;#$00=Item room music not playing. 
					;#$01=Play item room music.
					;#$80=Stop item room music once door scroll complete. 
					;#$81=Item room music already playing. Don't restart.

.alias OnFrozenEnemy		$7D	;#$01=Samus standing on frozen enemy, #$00=she is not.

;--------------------------------------[ End routine specific ]--------------------------------------

.alias EndMsgWrite		$7A	;0=don't write end message, 1=write end message.
.alias IsCredits		$7B	;0=credits not rolling, 1=credits rolling.
.alias SpriteByteCounter	$7C	;Used to indicate when Samus sprite load complete.
.alias SpritePointerIndex	$7D	;Index to proper Samus sprite graphics at end game.
.alias SpriteAttribByte		$7E	;#$00.  Attribute byte of some sprites.
.alias ColorCntIndex		$7F	;Index for finding count number for ClrChangeCounter.
.alias CreditPageNumber		$80	;Stores current page of credits(#$00 thru #$06).
.alias HideShowEndMsg		$81	;0=show end message, 1=erase end message.
.alias ClrChangeCounter		$82	;When=#$00, change end Samus sprite colors.
.alias WaveSpritePointer	$83	;Address pointer to Samus hand waving sprites in end.
.alias WaveSpriteCounter	$84	;Stores length of wave sprite data (#$10).

;----------------------------------------------------------------------------------------------------

.alias MetroidOnSamus		$92	;#$01=Metroid on Samus, #$00=Metroid not on Samus.

.alias MaxMissilePickup		$93	;Maximum missiles power-ups that can be picked up. Randomly-->
					;recalculated whenever Samus goes through a door.
.alias MaxEnergyPickup		$94	;Maximum energy power-ups that can be picked up. Randomly-->
					;recalculated whenever Samus goes through a door.
.alias CurrentMissilePickups	$95	;Number of missile power-ups currently collected by Samus-->
					;Reset to 0 when Samus goes through a door.
.alias CurrentEnergyPickups	$96	;Number of energy power-ups currently collected by Samus-->
					;Reset to 0 when Samus goes through a door.

.alias MotherBrainStatus	$98	;#$00=Mother brain not in room, #$01=Mother brain in room,-->
					;#$02=Mother brain hit, #$03=Mother brain dying-->
					;#$04=Mother brain dissapearing, #$05=Mother brain gone,-->
					;#$06=Time bomb set, #$07=Time bomb exploded,-->
					;#$08=Initialize mother brain,-->
					;#$09, #$0A=Mother brain already dead.
.alias MotherBrainHits		$99	;Number of times mother brain has been hit. Dies at #$20.

.alias SpareMemB7		$B7	;Written to in title routine and accessed by unsed routine.
.alias SpareMemB8		$B8	;Written to in title routine and accessed by unsed routine.
.alias SpareMemBB		$BB	;Written to in title routine, but never accessed.

.alias First4SlowCntr		$BC	;This address holds an 8 frame delay. when the delay is up,-->
					;The crosshair sprites double their speed.
.alias Second4Delay		$BD	;This address holds a 32 frame delay.  When the delay is-->
					;up, the second set of crosshair sprites start their movement.
.alias SecondCrosshairSprites	$BF	;#$01=Second crosshair sprites active in intro.

.alias FlashScreen		$C0	;#$01=Flash screen during crosshairs routine.
.alias PalDataIndex		$C1
.alias ScreenFlashPalIndex	$C2	;Index to palette data to flash screen during intro.
.alias IntroStarOffset		$C3	;Contains offset into IntroStarPntr table for twinkle effect.
.alias FadeDataIndex		$C4	;Index to palette data to fade items in and out during intro.

.alias SpareMemC5		$C5	;Written to in title routine, but never accessed.
.alias CrossDataIndex		$C6	;#$00 thru #$04. Index to find cross sprite data.
.alias DrawCross		$C7	;#$01=Draw cross on screen during crosshairs routine.
.alias SpriteLoadPending	$C8	;Set to #$00 after sprite RAM load complete.
.alias SpareMemC9		$C9	:Written to in title routine, but never accessed.
.alias SpareMemCB		$CB	;Written to in title routine, but never accessed.
.alias SpareMemCC		$CC	;Written to in title routine, but never accessed.
.alias SpareMemCD		$CD	;Written to in title routine, but never accessed.
.alias SpareMemCE		$CE	;Written to in title routine, but never accessed.
.alias SpareMemCF		$CF	;Written to in title routine, but never accessed.
.alias SpareMemD0		$D0	;Written to in title routine, but never accessed.
.alias SpareMemD1		$D1	;Written to in title routine, but never accessed.
.alias SpareMemD2		$D2	;Written to in title routine, but never accessed.
.alias SpareMemD3		$D3	;Written to in title routine, but never accessed.
.alias SpareMemD7		$D7	;Written to in title routine, but never accessed.
.alias IntroMusicRestart	$D8	;After all title routines run twice, restarts intro music.
.alias ABStatus			$F0	;Stores A and B button status in AreaInit. Never used.
;				$F7

.alias MirrorCntrl		$FA	;If bit 3 is set, PPU set to horizontal mirroring-->
					;else if bit 3 is clear, PPU is set to vertical-->
					;mirroring. No other bits seem to matter.

.alias ScrollY			$FC	;Y value loaded into scroll register. 
.alias ScrollX			$FD	;X value loaded into scroll register.
.alias PPUCNT1ZP		$FE	;Data byte to be loaded into PPU control register 1.
.alias PPUCNT0ZP		$FF	;Data byte to be loaded into PPU control register 0.

.alias HealthLo			$0106   ;Lower health digit in upper 4 bits.
.alias HealthHi			$0107   ;Upper health digit in lower 4 bits-->
                                        ;# of full tanks in upper 4 bits.
.alias MiniBossKillDelay	$0108	;Initiate power up music and delay after Kraid/Ridley killed.
.alias PowerUpDelay		$0109	;Initiate power up music and delay after item pickup.

.alias EndTimerLo		$010A	;Lower byte of end game escape timer.
.alias EndTimerHi		$010B	;Upper byte of end game escape timer.

.alias MissileToggle		$010E   ;0=fire bullets, 1=fire missiles.

;-----------------------------------------[ Sprite RAM ]---------------------------------------------

.alias Sprite00RAM   		$0200	;$0200 thru $02FF
.alias Sprite01RAM		$0204	;
.alias Sprite02RAM		$0208	;
.alias Sprite03RAM		$020C	;
.alias Sprite04RAM		$0210	;
.alias Sprite05RAM		$0214	;
.alias Sprite06RAM		$0218	;
.alias Sprite07RAM		$021C	;
.alias Sprite08RAM		$0220	;
.alias Sprite09RAM		$0224	;
.alias Sprite0ARAM		$0228	;
.alias Sprite0BRAM		$022C	;
.alias Sprite0CRAM		$0230	;
.alias Sprite0DRAM		$0234	;
.alias Sprite0ERAM		$0238	;
.alias Sprite0FRAM		$023C	;
.alias Sprite10RAM   		$0240	;
.alias Sprite11RAM		$0244	;
.alias Sprite12RAM		$0248	;
.alias Sprite13RAM		$024C	;
.alias Sprite14RAM		$0250	;
.alias Sprite15RAM		$0254	;
.alias Sprite16RAM		$0258	;
.alias Sprite17RAM		$025C	;
.alias Sprite18RAM		$0260	;
.alias Sprite19RAM		$0264	;
.alias Sprite1ARAM		$0268	;These 256 bytes of memory are loaded into sprite
.alias Sprite1BRAM		$026C	;RAM using the DMA sprite register $4014.
.alias Sprite1CRAM		$0270	;
.alias Sprite1DRAM		$0274	;
.alias Sprite1ERAM		$0278	;
.alias Sprite1FRAM		$027C	;
.alias Sprite20RAM   		$0280	;
.alias Sprite21RAM		$0284	;
.alias Sprite22RAM		$0288	;
.alias Sprite23RAM		$028C	;
.alias Sprite24RAM		$0290	;
.alias Sprite25RAM		$0294	;
.alias Sprite26RAM		$0298	;
.alias Sprite27RAM		$029C	;
.alias Sprite28RAM		$02A0	;
.alias Sprite29RAM		$02A4	;
.alias Sprite2ARAM		$02A8	;
.alias Sprite2BRAM		$02AC	;
.alias Sprite2CRAM		$02B0	;
.alias Sprite2DRAM		$02B4	;
.alias Sprite2ERAM		$02B8	;
.alias Sprite2FRAM		$02BC	;
.alias Sprite30RAM   		$02C0	;
.alias Sprite31RAM		$02C4	;
.alias Sprite32RAM		$02C8	;
.alias Sprite33RAM		$02CC	;
.alias Sprite34RAM		$02D0	;
.alias Sprite35RAM		$02D4	;
.alias Sprite36RAM		$02D8	;
.alias Sprite37RAM		$02DC	;
.alias Sprite38RAM		$02E0	;
.alias Sprite39RAM		$02E4	;
.alias Sprite3ARAM		$02E8	;
.alias Sprite3BRAM		$02EC	;
.alias Sprite3CRAM		$02F0	;
.alias Sprite3DRAM		$02F4	;
.alias Sprite3ERAM		$02F8	;
.alias Sprite3FRAM		$02FC	;

;-----------------------------------------[ Object RAM ]---------------------------------------------

;Samus RAM.
.alias ObjAction		$0300	;Status of object. 0=object slot not in use.
.alias ObjRadY			$0301	;Distance in pixels from object center to top or bottom.
.alias ObjRadX			$0302	;Distance in pixels from object center to left or right side.
.alias AnimFrame		$0303	;*2 = Index into FramePtrTable for current animation.
.alias AnimDelay		$0304	;Number of frames to delay between animation frames.
.alias AnimResetIndex		$0305	;Restart index-1 when AnimIndex finished with last frame. 
.alias AnimIndex		$0306	;Current index into ObjectAnimIndexTbl.
.alias SamusOnElevator		$0307   ;0=Samus not on elevator, 1=Samus on elevator.
.alias ObjVertSpeed		$0308	;MSB set=moving up(#$FA max), MSB clear=moving down(#$05 max).
.alias ObjHorzSpeed		$0309	;MSB set=moving lft(#$FE max), MSB clear=moving rt(#$01 max).
.alias SamusHit			$030A	;Samus hit by enemy.
.alias ObjectOnScreen		$030B	;1=Object on screen, 0=Object beyond screen boundaries.
.alias ObjectHi			$030C	;0=Object on nametable 0, 1=Object on nametable 3.
.alias ObjectY			$030D	;Object y position in room(not actual screen position).
.alias ObjectX			$030E	;Object x position in room(not actual screen position).
.alias SamusJumpDsplcmnt	$030F	;Number of pixels vertically displaced from jump point.
.alias VertCntrNonLinear	$0310	;Verticle movement counter. Exponential change in speed.
.alias HorzCntrNonLinear	$0311	;Horizontal movement counter. Exponential change in speed.
.alias VertCntrLinear		$0312	;Verticle movement counter. Linear change in speed.
.alias HorzCntrLinear		$0313	;Horizontal movement counter. Linear change in speed.
.alias SamusGravity		$0314	;Value used in calculating vertical acceleration on Samus.
.alias SamusHorzAccel		$0315	;Value used in calculating horizontal acceleration on Samus.
.alias SamusHorzSpeedMax	$0316	;Used to calc maximum horizontal speed Samus can reach.

;Elevator RAM.
.alias ElevatorStatus		$0320	;#$01=Elevator present, #$00=Elevator not present.

;Power-up item RAM.


;-------------------------------------[ Title routine specific ]-------------------------------------

.alias PasswordCursor		$0320	;Password write position (#$00 - #$17).
.alias InputRow			$0321	;Password character select row (#$00 - #$04).
.alias InputColumn		$0322	;Password character select column (#$00 - #$0C).
.alias PasswordStat00		$0324	;Does not appear to have a function.
.alias StartContinue		$0325	;0=START selected, 1=CONTINUE selected.

;------------------------------------------[ Enemy RAM ]---------------------------------------------

.alias EnYRoomPos		$0400	;Enemy y position in room.(not actual screen position).
.alias EnXRoomPos		$0401	;Enemy x position in room.(not actual screen position).
;				$0402
;				$0403
;				$0404
;				$0405
.alias EnCounter		$0406	;Counts such things as explosion time.
;				$0407
;				$0408
.alias EnDelay			$0409	;Delay counter between enemy actions.
;				$040A
.alias EnHitPoints		$040B	;Current hit points of enemy.
;				$040C
;				$040D
;				$040E
.alias EnSpecialAttribs		$040F	;Bit 7 set=tough version of enemy, bit 6 set=mini boss.

;----------------------------------------------------------------------------------------------------

;Tile respawning
.alias TileRoutine		$0500
.alias TileAnimFrame		$0503
.alias TileAnimDelay		$0504
.alias TileAnimIndex		$0506
.alias TileDelay		$0507
.alias TileWRAMLo		$0508
.alias TileWRAMHi		$0509
.alias TileType			$050A

;---------------------------------[ Sound engine memory addresses ]----------------------------------

.alias Cntrl0Data		$EA 	;Temp storage for data of first address sound channel
.alias VolumeCntrlAddress	$EB	;Desired address number in VolumeCntrlAdressTbl

.alias MusicSQ1PeriodLow	$0600	;Loaded into SQ1Cntrl2 when playing music
.alias MusicSQ1PeriodHigh	$0601	;Loaded into SQ1Cntrl3 when playing music

.alias SFXPaused		$0602	;0=Game not paused, 1=Game paused
.alias PauseSFXStatus		$0603	;Plays PauseMusic SFX if less than #$12

.alias MusicSQ2PeriodLow	$0604	;Loaded into SQ2Cntrl2 when playing music
.alias MusicSQ2PeriodHigh	$0605	;Loaded into SQ2Cntrl3 when playing music

.alias WriteMultiChannelData	$0607	;1=data needs to be written, 0=no data to write

.alias MusicTriPeriodLow	$0608	;Loaded into TriangleCntrl2 when playing music
.alias MisicTriPeriodHigh	$0609	;Loaded into TriangleCntrl3 when playing music 

.alias TrianglePeriodLow	$0610 	;Stores triangle SFX period low for processing
.alias TrianglePeriodHigh	$0611	;Stroes triangle SFX period high for processing
.alias TriangleChangeLow	$0612	;Stores triangle SFX change in period low
.alias TriangleChangeHigh	$0613	;Stores triangle SFX change in period high

.alias TriangleLowPercentage	$0614	;Stores percent to change period low by each frame
.alias TriangleHighPercentage	$0615	;Stores percent to change period high by each frame 
.alias PercentDifference	$0616	;if=5, percent=1/5(20%), if=0A, percent=1/10(10%), etc
.alias DivideData		$0617	;Used in DivideTrianglePeriods

.alias HasBeamSFX		$061F	;Bit 7 set=has long beam, bit 0 set=has ice beam

;The following addresses are loaded into $0640 thru $0643 when those 
;addresses decrement to zero.  These addresses do not decrement.

.alias SQ1FrameCountInit	$0620	;Holds number of frames to play sq1 channel data
.alias SQ2FrameCountInit	$0621	;Holds number of frames to play sq2 channel data
.alias TriangleFrameCountInit	$0622	;Holds number of frames to play triangle channel data
.alias NoiseFrameCountInit	$0623	;Holds number of frames to play noise channel data

.alias SQ1RepeatCounter		$0624	;Number of times to repeat SQ1 music loop
.alias SQ2RepeatCounter		$0625	;Number of times to repeat SQ2 music loop
.alias TriangleRepeatCounter	$0626	;Number of times to repeat Triangle music loop
.alias NoiseRepeatCounter	$0627	;Number of times to repeat Noise music loop

.alias SQ1DutyEnvelope		$0628	;Loaded into SQ1Cntrl0 when playing music
.alias SQ2DutyEnvelope		$0629	;Loaded into SQ2Cntrl0 when playing music
.alias TriLinearCount		$062A	;disable\enable counter, linear count length

.alias NoteLengthTblOffset	$062B	;Stores the offset to find proper note length table
.alias MusicRepeat		$062C	;0=Music does not repeat, Nonzero=music repeats
.alias TriangleCounterCntrl	$062D	;$F0=disable length cntr, $00=long note, $0F=short note
.alias SQ1VolumeCntrl		$062E	;Entry number in VolumeCntrlAdressTbl for SQ1
.alias SQ2VolumeCntrl		$062F	;Entry number in VolumeCntrlAdressTbl for SQ2
.alias SQ1LowBaseByte		$0630	;low byte of base address for SQ1 music data
.alias SQ1HighBaseByte		$0631	;High byte of base address for SQ1 music data
.alias SQ2LowBaseByte		$0632	;low byte of base address for SQ2 music data
.alias SQ2HighBaseByte		$0633	;High byte of base address for SQ2 music data
.alias TriangleLowBaseByte	$0634	;low byte of base address for Triangle music data
.alias TriangleHighBaseByte	$0635	;High byte of base address for Triangle music data
.alias NoiseLowBaseByte		$0636	;low byte of base address for Noise music data
.alias NoiseHighBaseByte	$0637	;High byte of base address for Noise music data

.alias SQ1MusicIndexIndex	$0638	;Index to find sQ1 sound data index. Base=$630,$631
.alias SQ2MusicIndexIndex	$0639	;Index to find SQ2 sound data index. Base=$632,$633
.alias TriangleMusicIndexIndex 	$063A	;Index to find Tri sound data index. Base=$634,$635
.alias NoiseMusicIndexIndex	$063B	;Index to find Noise sound data index. Base=$636,$637

.alias SQ1LoopIndex		$063C	;SQ1 Loop start index
.alias SQ2LoopIndex		$063D	;SQ2 loop start index
.alias TriangleLoopIndex	$063E	;Triangle loop start index
.alias NoiseLoopIndex		$063F	;Noise loop start index

.alias SQ1MusicFrameCount	$0640	;Decrements every sq1 frame. When 0, load new data
.alias SQ2MusicFrameCount	$0641	;Decrements every sq2 frame. when 0, load new data
.alias TriangleMusicFrameCount	$0642	;Decrements every triangle frame. When 0, load new data
.alias NoiseMusicFrameCount	$0643	;Decrements every noise frame. When 0, load new data

.alias MusicSQ1Sweep		$0648	;Value is loaded into SQ1Cntrl1 when playing music
.alias MusicSQ2Sweep		$0649	;Value is loaded into SQ2Cntrl1 when playing music
.alias TriangleSweep		$064A	;Loaded into TriangleCntrl1(not used)

.alias ThisSoundChannel		$064B	;Least sig. byte of current channel(00,04,08 or 0C)

.alias CurrentSFXFlags		$064D	;Stores flags of SFX currently being processed.

.alias NoiseInUse		$0652	;Noise in use? (Not used)
.alias SQ1InUse			$0653	;1=SQ1 channel being used by SFX, 0=not in use
.alias SQ2InUse			$0654	;2=SQ2 channel being used by SFX, 0=not in use
.alias TriangleInUse		$0655	;3=Triangle channel being used by SFX, 0=not in use

.alias ChannelType		$065C	;Stores channel type being processed(0,1,2,3 or 4)
.alias CurrentMusicRepeat	$065D	;Stores flags of music to repeat
.alias MusicInitIndex		$065E	;index for loading $62B thru $637(base=$BD31).

.alias NoiseSFXLength		$0660 	;Stores number of frames to play Noise SFX
.alias SQ1SFXLength		$0661	;Stores number of frames to play SQ1 SFX
.alias SQ2SFXLngth		$0662	;Stores number of frames to play SQ2 SFX
.alias TriangleSFXLength	$0663	;Stores number of frames to play Triangle SFX
.alias MultiSFXLength		$0664	;Stores number of frames to play Multi SFX

.alias ThisNoiseFrame		$0665	;Stores current frame number for noise SFX
.alias ThisSQ1Frame		$0666	;Stores current frame number for sq1 SFX
.alias ThisSQ2Frame		$0667	;Stores current frame number for SQ2 SFX
.alias ThisTriangleFrame	$0668	;Stores current frame number for triangle SFX
.alias ThisMultiFrame		$0669	;Stores current frame number for Multi SFX

.alias SQ1VolumeIndex		$066A	;Stores index to SQ1 volume data in a volume data tbl
.alias SQ2VolumeIndex		$066B	;Stores index to SQ2 volume data in a volume data tbl

.alias SQ1VolumeData		$066C	;stores duty cycle and this frame volume data of SQ1
.alias SQ2VolumeData		$066D	;Stores duty cycle and this frame volume data of SQ2

.alias NoiseSFXData		$0670	;Stores additional info for Noise SFX
.alias SQ1SFXData		$0671	;Stores additional info for SQ1 SFX
.alias SQ2SFXData		$0672	;Stores additional info for SQ2 SFX
.alias TriangleSFXData		$0673	;Stores additional info for triangle SFX
.alias MultiSFXData		$0674	;Stores additional info for Multi SFX
.alias SQ1SQ2SFXData		$0675	;Stores additional info for SQ1 and SQ2 SFX

.alias ScrewAttackSFXData	$0678	;Contains extra data for screw attack SFX
.alias SQ1SFXPeriodLow		$0679	;Period low data for processing multi SFX routines

.alias NoiseSFXFlag		$0680	;Initialization flags for noise SFX
.alias SQ1SFXFlag		$0681	;Initialization flags for SQ1 SFX
.alias SQ2SFXFlag		$0682	;Initialization flags for SQ2 SFX(never used)
.alias TriangleSFXFlag		$0683	;Initialization flags for triangle SFX
.alias MultiSFXFlag		$0684	;Initialization Flags for SFX and some music

.alias MusicInitFlag		$0685	;Music init flags

.alias NoiseContSFX		$0688	;Continuation flags for noise SFX
.alias SQ1ContSFX		$0689	;Continuation flags for SQ1 SFX
.alias SQ2ContSFX		$068A	;Continuation flags for SQ2 SFX (never used)
.alias TriangleContSFX		$068B	;Continuation flags for Triangle SFX
.alias MultiContSFX		$068C	;Continuation flags for Multi SFX

.alias CurrentMusic		$068D	;Stores the flag of the current music being played 

;----------------------------------------------------------------------------------------------------

.alias PowerUpType		$0748	;Holds the byte describing what power-up is on name table.
.alias PowerUpYCoord		$0749	;Y coordinate of the power-up.
.alias PowerUpXCoord		$074A	;X coordiante of the power-up
.alias PowerUpNameTable		$074B	;#$00 if on name table 0, #$01 if on name table 3.

.alias PowerUpAnimIndex		$074F	;Entry into FramePtrTable for item animation.

.alias PowerUpBType		$0750	;Holds the description byte of a second power-up(if any).
.alias PowerUpBYCoord		$0751	;Y coordinate of second power-up.
.alias PowerUpBXCoord		$0752	;X coordiante of second power-up.
.alias PowerUpBNameTable	$0753	;#$00 if on name table 0, #$01 if on name table 3.

.alias TileSize			$0780	;4 MSBs = Y size of tile to erase.-->
					;4 LSBs = X size of tile to erase.
.alias TileInfo0		$0781	;
.alias TileInfo1		$0782	;
.alias TileInfo2		$0783	;Tile patterns to replace blasted tiles.
.alias TileInfo3		$0784	;
.alias TileInfo4		$0785	;
.alias TileInfo5		$0786	;

.alias PPUStrIndex		$07A0	;# of bytes of data in PPUDataString. #$4F bytes max.

;$07A1 thru $07F0 contain a byte string of data to be written the the PPU. The first
;byte in the string is the upper address byte of the starting point in the PPU to write
;the data.  The second bye is the lower address byte. The third byte is a configuration
;byte. if the MSB of this byte is set, the PPU is incremented by 32 after each byte write
;(vertical write).  It the MSB is cleared, the PPU is incremented by 1 after each write
;(horizontal write). If bit 6 is set, the next data byte is repeated multiple times during
;successive PPU writes.  The number of times the next byte is repeated is based on bits
;0-5 of the configuration byte.  Those bytes are a repitition counter. Any following bytes
;are the actual data bytes to be written to the PPU. #$00 separates the data chunks.

.alias PPUDataString		$07A1	;Thru $07F0. String of data bytes to be written to PPU.

;-------------------------------------[ Hardware defines ]-------------------------------------------

.alias PPUControl0		$2000	;
.alias PPUControl1		$2001	;
.alias PPUStatus		$2002	;
.alias SPRAddress		$2003	;PPU hardware control registers.
.alias SPRIOReg			$2004	;
.alias PPUScroll		$2005	;
.alias PPUAddress		$2006	;
.alias PPUIOReg			$2007	;

.alias SQ1Cntrl0		$4000	;
.alias SQ1Cntrl1		$4001	;SQ1 hardware control registers.
.alias SQ1Cntrl2		$4002	;
.alias SQ1Cntrl3		$4003	;

.alias SQ2Cntrl0		$4004	;
.alias SQ2Cntrl1		$4005	;SQ2 hardware control registers.
.alias SQ2Cntrl2		$4006	;
.alias SQ2Cntrl3		$4007	;

.alias TriangleCntrl0		$4008	;
.alias TriangleCntrl1		$4009	;Triangle hardware control registers.
.alias TriangleCntrl2		$400A	;
.alias TriangleCntrl3		$400B	;

.alias NoiseCntrl0		$400C	;
.alias NoiseCntrl1		$400D	;Noise hardware control registers.
.alias NoiseCntrl2		$400E	;
.alias NoiseCntrl3		$400F	;

.alias DMCCntrl0		$4010	;
.alias DMCCntrl1		$4011	;DMC hardware control registers.
.alias DMCCntrl2		$4012	;
.alias DMCCntrl3		$4013	;

.alias SPRDMAReg		$4014	;Sprite RAM DMA register.
.alias APUCommonCntrl0		$4015	;APU common control 1 register.
.alias CPUJoyPad1   		$4016	;Joypad1 register.
.alias APUCommonCntrl1		$4017	;Joypad2/APU common control 2 register.

;----------------------------------------------------------------------------------------------------

.alias RoomRAMA			$6000	;Thru $63FF. Used to load room before it is put into the PPU.
.alias RoomRAMB			$6400	;Thru $67FF. Used to load room before it is put into the PPU.

.alias EndingType		$6872	;1=worst ending, 5=best ending

.alias SamusDataIndex		$6875	;Index for Samus saved game stats(not used). #$00, #$10, #$20.

.alias SamusStat00		$6876	;Unused memory address for storing Samus info.
.alias TankCount		$6877   ;Number of energy tanks.
.alias SamusGear		$6878	;Stores power-up items Samus has.
.alias MissileCount		$6879	;Stores current number of missiles.
.alias MaxMissiles		$687A	;Maximum amount of missiles Samus can carry
.alias KraidStatueStatus	$687B	;bit 0 set, the statues blink, -->
.alias RidleyStatueStatus	$687C	;bit 7 set, statues are up.
.alias SamusAge			$687D	;Low byte of Samus' age.
;      SamusAge+1		$687E	;Mid byte of Samus' age.
;      SamusAge+2		$687F	;High byte of Samus' age.
.alias SamusStat01		$6880	;Unused memory address for storing Samus info.
.alias SamusStat02		$6881	;SamusStat02 and 03 keep track of how many times Samus has-->
.alias SamusStat03		$6882	;died, but this info is never accessed anywhere in the game.

.alias AtEnding			$6883	;1=End scenes playing, 0=Not at ending.

.alias EraseGame		$6884	;MSB set=erase selected saved game(not used in password carts).

.alias DataSlot			$6885	;#$00 thru #$02. Stored Samus data to load. Apparently a save-->
					;game system was going to be used instead of a password routine.-->
					;The code that uses this memory address is never accessed in-->
					;the actual game. It looks like three player slots were going-->
					;to be used to store game data(like Zelda).  

.alias NumberOfUniqueItems	$6886	;Counts number of power-ups and red doors-->
					;opened.  Does not count different beams-->
					;picked up (ice, long, wave). increments by 2.

.alias UniqueItemHistory	$6887 	;Thru $68FC. History of Unique items collected.-->
.alias EndItemHistory		$68FC	;Two bytes per item.

.alias KraidRidleyPresent	$6987	;#$01=Kraid/Ridley present, #$00=Kraid/Ridley not present.

.alias PasswordByte00		$6988	;Stores status of items 0 thru 7.
.alias PasswordByte01		$6989	;Stores status of items 8 thru 15.
.alias PasswordByte02		$698A	;Stores status of items 16 thru 23.
.alias PasswordByte03		$698B	;Stores status of items 24 thru 31.
.alias PasswordByte04		$698C	;Stores status of items 32 thru 39.
.alias PasswordByte05		$698D	;Stores status of items 40 thru 47.
.alias PasswordByte06		$698E	;Stores status of items 48 thru 55.
.alias PasswordByte07		$698F	;Stores status of items 56 thru 58(bits 0 thru 2).
.alias PasswordByte08		$6990	;start location(bits 0 thru 5), Samus suit status (bit 7).
.alias PasswordByte09		$6991	;Stores SamusGear.
.alias PasswordByte0A		$6992	;Stores MissileCount.
.alias PasswordByte0B		$6993	;Stores SamusAge.
.alias PasswordByte0C		$6994	;Stores SamusAge+1.
.alias PasswordByte0D		$6995	;Stores SamusAge+2.
.alias PasswordByte0E		$6996	;Stores no data.
.alias PasswordByte0F		$6997	;Stores Statue statuses(bits 4 thu 7).
.alias PasswordByte10		$6998	;Stores value RandomNumber1.
.alias PasswordByte11		$6999	;Stores sum of $6988 thru $6998(Checksum).

;Upper two bits of PasswordChar bytes will always be 00.
.alias PasswordChar00		$699A	;
.alias PasswordChar01		$699B	;
.alias PasswordChar02		$699C	;
.alias PasswordChar03		$699D	;
.alias PasswordChar04		$699E	;
.alias PasswordChar05		$699F	;
.alias PasswordChar06		$69A0	;
.alias PasswordChar07		$69A1	;
.alias PasswordChar08		$69A2	;
.alias PasswordChar09		$69A3	;
.alias PasswordChar0A		$69A4	;These 18 memory addresses store the 18 characters-->
.alias PasswordChar0B		$69A5	;of the password to be displayed on the screen.
.alias PasswordChar0C		$69A6	;
.alias PasswordChar0D		$69A7	;
.alias PasswordChar0E		$69A8	;
.alias PasswordChar0F		$69A9	;
.alias PasswordChar10		$69AA	;
.alias PasswordChar11		$69AB	;
.alias PasswordChar12		$69AC	;
.alias PasswordChar13		$69AD	;
.alias PasswordChar14		$69AE	;
.alias PasswordChar15		$69AF	;
.alias PasswordChar16		$69B0	;
.alias PasswordChar17		$69B1	;

.alias NARPASSWORD		$69B2	;0 = invinsible Samus not active, 1 = invinsible Samus active.
.alias JustInBailey		$69B3   ;0 = Samus has suit, 1 = Samus is without suit.
.alias ItmeHistory		$69B4	;Thru $6A73. Unique item history saved game data (not used).

;---------------------------------------[ More enemy RAM ]-------------------------------------------

.alias Enstatus			$6AF4	;Keeps track of enemy statuses. #$00=Enemy slot not in use,-->
					;#$04=Enemy frozen.
.alias EnRadY			$6AF5	;Distance in pixels from middle of enemy to top or botom.
.alias EnRadX			$6AF6	;Distance in pixels from middle of enemy to left or right.
.alias EnAnimFrame		$6AF7	;Index into enemy animation frame data.
.alias EnAnimDelay		$6AF8	;Number of frames to delay between animation frames.
.alias EnResetAnimIndex		$6AF9	;Index to beginning of animation sequence.
.alias EnAnimIndex		$6AFA	;Index to current animation.
.alias EnNameTable		$6AFB	;#$00=Enemy on name table 0, #$01=Enemy on name table 3.
;				$6AFC
;				$6AFD
;				$6AFE
;				$6AFF
;				$6B00
;				$6B01
.alias EnDataIndex		$6B02	;Contains index into enemy data tables.
;				$6B03

;-------------------------------------[ Intro sprite defines ]---------------------------------------

.alias IntroStarSprite00	$6E00	;thru $6E9F
.alias IntroStarSprite01	$6E04	;
.alias IntroStarSprite02	$6E08	;
.alias IntroStarSprite03	$6E0C	;
.alias IntroStarSprite04	$6E10	;
.alias IntroStarSprite05	$6E14	;
.alias IntroStarSprite06	$6E18	;
.alias IntroStarSprite07	$6E1C	;
.alias IntroStarSprite08	$6E20	;
.alias IntroStarSprite09	$6E24	;
.alias IntroStarSprite0A	$6E28	;
.alias IntroStarSprite0B	$6E2C	;
.alias IntroStarSprite0C	$6E30	;
.alias IntroStarSprite0D	$6E34	;
.alias IntroStarSprite0E	$6E38	;
.alias IntroStarSprite0F	$6E3C	;
.alias IntroStarSprite10	$6E40	;
.alias IntroStarSprite11	$6E44	;
.alias IntroStarSprite12	$6E48	;
.alias IntroStarSprite13	$6E4C	;
.alias IntroStarSprite14	$6E50	;RAM used for storing intro star sprite data.
.alias IntroStarSprite15	$6E54	;
.alias IntroStarSprite16	$6E58	;
.alias IntroStarSprite17	$6E5C	;
.alias IntroStarSprite18	$6E60	;
.alias IntroStarSprite19	$6E64	;
.alias IntroStarSprite1A	$6E68	;
.alias IntroStarSprite1B	$6E6C	;
.alias IntroStarSprite1C	$6E70	;
.alias IntroStarSprite1D	$6E74	;
.alias IntroStarSprite1E	$6E78	;
.alias IntroStarSprite1F	$6E7C	;
.alias IntroStarSprite20	$6E80	;
.alias IntroStarSprite21	$6E84	;
.alias IntroStarSprite22	$6E88	;
.alias IntroStarSprite23	$6E8C	;
.alias IntroStarSprite24	$6E90	;
.alias IntroStarSprite25	$6E94	;
.alias IntroStarSprite26	$6E98	;
.alias IntroStarSprite27	$6E9C	;

;Intro sprite 0 and sparkle sprite.
.alias IntroSpr0YCoord		$6EA0	;Loaded into byte 0 of sprite RAM(Y position).
.alias IntroSpr0PattTbl		$6EA1	;Loaded into byte 1 of sprite RAM(Pattern table index).
.alias IntroSpr0Cntrl		$6EA2	;Loaded into byte 2 of sprite RAM(Control byte).
.alias IntroSpr0XCoord		$6EA3	;Loaded into byte 3 of sprite RAM(X position).
.alias IntroSpr0Index		$6EA4	;Index to next sparkle sprite data byte.
.alias IntroSpr0NextCntr	$6EA5	;Decrements each frame. When 0, load new sparkle sprite data.
.alias SparkleSpr0YChange	$6EA6	;Sparkle sprite y coordinate change.
.alias IntroSpr0XChange		$6EA6	;Intro sprite x total movement distance.
.alias SparkleSpr0XChange	$6EA7	;Sparkle sprite x coordinate change.
.alias IntroSpr0YChange		$6EA7	;Intro sprite y total movement distance.
.alias IntroSpr0ChngCntr	$6EA8	;decrements each frame from #$20. At 0, change sparkle sprite.
.alias IntroSpr0ByteType	$6EA9	;#$00 or #$01. When #$01, next sparkle data byte uses all 8-->
					;bits for x coord change. if #$00, next data byte contains-->
					;4 bits for x coord change and 4 bits for y coord change.
.alias IntroSpr0Complete	$6EAA	;#$01=sprite has completed its task, #$00 if not complete.
.alias IntroSpr0SpareB		$6EAB	;Not used.
.alias IntroSpr0XRun		$6EAC	;x displacement of sprite movement(run).
.alias IntroSpr0YRise		$6EAD	;y displacement of sprite movement(rise).
.alias IntroSpr0XDir		$6EAE	;MSB set=decrease sprite x pos, else increase sprite  x pos.
.alias IntroSpr0YDir		$6EAF	;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 1 and sparkle sprite.
.alias IntroSpr1YCoord		$6EB0	;Loaded into byte 0 of sprite RAM(Y position).
.alias IntroSpr1PattTbl		$6EB1	;Loaded into byte 1 of sprite RAM(Pattern table index).
.alias IntroSpr1Cntrl		$6EB2	;Loaded into byte 2 of sprite RAM(Control byte).
.alias IntroSpr1XCoord		$6EB3	;Loaded into byte 3 of sprite RAM(X position).
.alias IntroSpr1Index		$6EB4	;Index to next sparkle sprite data byte.
.alias IntroSpr1NextCntr	$6EB5	;Decrements each frame. When 0, load new sparkle sprite data.
.alias SparkleSpr1YChange	$6EB6	;Sparkle sprite y coordinate change.
.alias IntroSpr1XChange		$6EB6	;Intro sprite x total movement distance.
.alias SparkleSpr1XChange	$6EB7	;Sparkle sprite x coordinate change.
.alias IntroSpr1YChange		$6EB7	;Intro sprite y total movement distance.
.alias IntroSpr1ChngCntr	$6EB8	;decrements each frame from #$20. At 0, change sparkle sprite.
.alias IntroSpr1ByteType	$6EB9	;#$00 or #$01. When #$01, next sparkle data byte uses all 8-->
					;bits for x coord change. if #$00, next data byte contains-->
					;4 bits for x coord change and 4 bits for y coord change.
.alias IntroSpr1Complete	$6EBA	;#$01=sprite has completed its task, #$00 if not complete.
.alias IntroSpr1SpareB		$6EBB	;Not used.
.alias IntroSpr1XRun		$6EBC	;x displacement of sprite movement(run).
.alias IntroSpr1YRise		$6EBD	;y displacement of sprite movement(rise).
.alias IntroSpr1XDir		$6EBE	;MSB set=decrease sprite x pos, else increase sprite  x pos.
.alias IntroSpr1YDir		$6EBF	;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 2.
.alias IntroSpr2YCoord		$6EC0	;Loaded into byte 0 of sprite RAM(Y position).
.alias IntroSpr2PattTbl		$6EC1	;Loaded into byte 1 of sprite RAM(Pattern table index).
.alias IntroSpr2Cntrl		$6EC2	;Loaded into byte 2 of sprite RAM(Control byte).
.alias IntroSpr2XCoord		$6EC3	;Loaded into byte 3 of sprite RAM(X position).
.alias IntroSpr2Spare5		$6EC4	;Not used.
.alias IntroSpr2Spare6		$6EC5	;Not used.
.alias IntroSpr2XChange		$6EC6	;Intro sprite x total movement distance.
.alias IntroSpr2YChange		$6EC7	;Intro sprite y total movement distance.
.alias IntroSpr2Spare8		$6EC8	;Not used.
.alias IntroSpr2Spare9		$6EC9	;Not used.
.alias IntroSpr2Complete	$6ECA	;#$01=sprite has completed its task, #$00 if not complete.
.alias IntroSpr2SpareB		$6ECB	;Not used.
.alias IntroSpr2XRun		$6ECC	;x displacement of sprite movement(run).
.alias IntroSpr2YRise		$6ECD	;y displacement of sprite movement(rise).
.alias IntroSpr2XDir		$6ECE	;MSB set=decrease sprite x pos, else increase sprite  x pos.
.alias IntroSpr2YDir		$6ECF	;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 3.
.alias IntroSpr3YCoord		$6ED0	;Loaded into byte 0 of sprite RAM(Y position).
.alias IntroSpr3PattTbl		$6ED1	;Loaded into byte 1 of sprite RAM(Pattern table index).
.alias IntroSpr3Cntrl		$6ED2	;Loaded into byte 2 of sprite RAM(Control byte).
.alias IntroSpr3XCoord		$6ED3	;Loaded into byte 3 of sprite RAM(X position).
.alias IntroSpr3Spare5		$6ED4	;Not used.
.alias IntroSpr3Spare6		$6ED5	;Not used.
.alias IntroSpr3XChange		$6ED6	;Intro sprite x total movement distance.
.alias IntroSpr3YChange		$6ED7	;Intro sprite y total movement distance.
.alias IntroSpr3Spare8		$6ED8	;Not used.
.alias IntroSpr3Spare9		$6ED9	;Not used.
.alias IntroSpr3Complete	$6EDA	;#$01=sprite has completed its task, #$00 if not complete.
.alias IntroSpr3SpareB		$6EDB	;Not used.
.alias IntroSpr3XRun		$6EDC	;x displacement of sprite movement(run).
.alias IntroSpr3YRise		$6EDD	;y displacement of sprite movement(rise).
.alias IntroSpr3XDir		$6EDE	;MSB set=decrease sprite x pos, else increase sprite  x pos.
.alias IntroSpr3YDir		$6EDF	;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 4.
.alias IntroSpr4YCoord		$6EE0	;Loaded into byte 0 of sprite RAM(Y position).
.alias IntroSpr4PattTbl		$6EE1	;Loaded into byte 1 of sprite RAM(Pattern table index).
.alias IntroSpr4Cntrl		$6EE2	;Loaded into byte 2 of sprite RAM(Control byte).
.alias IntroSpr4XCoord		$6EE3	;Loaded into byte 3 of sprite RAM(X position).
.alias IntroSpr4Spare5		$6EE4	;Not used.
.alias IntroSpr4Spare6		$6EE5	;Not used.
.alias IntroSpr4XChange		$6EE6	;Intro sprite x total movement distance.
.alias IntroSpr4YChange		$6EE7	;Intro sprite y total movement distance.
.alias IntroSpr4Spare8		$6EE8	;Not used.
.alias IntroSpr4Spare9		$6EE9	;Not used.
.alias IntroSpr4Complete	$6EEA	;#$01=sprite has completed its task, #$00 if not complete.
.alias IntroSpr4SpareB		$6EEB	;Not used.
.alias IntroSpr4XRun		$6EEC	;x displacement of sprite movement(run).
.alias IntroSpr4YRise		$6EED	;y displacement of sprite movement(rise).
.alias IntroSpr4XDir		$6EEE	;MSB set=decrease sprite x pos, else increase sprite  x pos.
.alias IntroSpr4YDir		$6EEF	;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 5.
.alias IntroSpr5YCoord		$6EF0	;Loaded into byte 0 of sprite RAM(Y position).
.alias IntroSpr5PattTbl		$6EF1	;Loaded into byte 1 of sprite RAM(Pattern table index).
.alias IntroSpr5Cntrl		$6EF2	;Loaded into byte 2 of sprite RAM(Control byte).
.alias IntroSpr5XCoord		$6EF3	;Loaded into byte 3 of sprite RAM(X position).
.alias IntroSpr5Spare5		$6EF4	;Not used.
.alias IntroSpr5Spare6		$6EF5	;Not used.
.alias IntroSpr5XChange		$6EF6	;Intro sprite x total movement distance.
.alias IntroSpr5YChange		$6EF7	;Intro sprite y total movement distance.
.alias IntroSpr5Spare8		$6EF8	;Not used.
.alias IntroSpr5Spare9		$6EF9	;Not used.
.alias IntroSpr5Complete	$6EFA	;#$01=sprite has completed its task, #$00 if not complete.
.alias IntroSpr5SpareB		$6EFB	;Not used.
.alias IntroSpr5XRun		$6EFC	;x displacement of sprite movement(run).
.alias IntroSpr5YRise		$6EFD	;y displacement of sprite movement(rise).
.alias IntroSpr5XDir		$6EFE	;MSB set=decrease sprite x pos, else increase sprite  x pos.
.alias IntroSpr5YDir		$6EFF	;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 6.
.alias IntroSpr6YCoord		$6F00	;Loaded into byte 0 of sprite RAM(Y position).
.alias IntroSpr6PattTbl		$6F01	;Loaded into byte 1 of sprite RAM(Pattern table index).
.alias IntroSpr6Cntrl		$6F02	;Loaded into byte 2 of sprite RAM(Control byte).
.alias IntroSpr6XCoord		$6F03	;Loaded into byte 3 of sprite RAM(X position).
.alias IntroSpr6Spare5		$6F04	;Not used.
.alias IntroSpr6Spare6		$6F05	;Not used.
.alias IntroSpr6XChange		$6F06	;Intro sprite x total movement distance.
.alias IntroSpr6YChange		$6F07	;Intro sprite y total movement distance.
.alias IntroSpr6Spare8		$6F08	;Not used.
.alias IntroSpr6Spare9		$6F09	;Not used.
.alias IntroSpr6Complete	$6F0A	;#$01=sprite has completed its task, #$00 if not complete.
.alias IntroSpr6SpareB		$6F0B	;Not used.
.alias IntroSpr6XRun		$6F0C	;x displacement of sprite movement(run).
.alias IntroSpr6YRise		$6F0D	;y displacement of sprite movement(rise).
.alias IntroSpr6XDir		$6F0E	;MSB set=decrease sprite x pos, else increase sprite  x pos.
.alias IntroSpr6YDir		$6F0F	;MSB set=decrease sprite y pos, else increase sprite  y pos.

;Intro sprite 7.
.alias IntroSpr7YCoord		$6F10	;Loaded into byte 0 of sprite RAM(Y position).
.alias IntroSpr7PattTbl		$6F11	;Loaded into byte 1 of sprite RAM(Pattern table index).
.alias IntroSpr7Cntrl		$6F12	;Loaded into byte 2 of sprite RAM(Control byte).
.alias IntroSpr7XCoord		$6F13	;Loaded into byte 3 of sprite RAM(X position).
.alias IntroSpr7Spare5		$6F14	;Not used.
.alias IntroSpr7Spare6		$6F15	;Not used.
.alias IntroSpr7XChange		$6F16	;Intro sprite x total movement distance.
.alias IntroSpr7YChange		$6F17	;Intro sprite y total movement distance.
.alias IntroSpr7Spare8		$6F18	;Not used.
.alias IntroSpr7Spare9		$6F19	;Not used.
.alias IntroSpr7Complete	$6F1A	;#$01=sprite has completed its task, #$00 if not complete.
.alias IntroSpr7SpareB		$6F1B	;Not used.
.alias IntroSpr7XRun		$6F1C	;x displacement of sprite movement(run).
.alias IntroSpr7YRise		$6F1D	;y displacement of sprite movement(rise).
.alias IntroSpr7XDir		$6F1E	;MSB set=decrease sprite x pos, else increase sprite  x pos.
.alias IntroSpr7YDir		$6F1F	;MSB set=decrease sprite y pos, else increase sprite  y pos.

;----------------------------------------------------------------------------------------------------

.alias WorldMapRAM		$7000	;Thru $73FF. The map is 1Kb in size (1024 bytes).

.alias SamusData		$77FE	;Thru $782D. Samus saved game data (not used).

.alias MMC1Reg0			$8000	;Writing to any of these addresses or any--> 
.alias MMC1Reg1			$A000	;address in between will write configuration-->
.alias MMC1Reg2			$C000	;bits to the MMC chip.
.alias MMC1Reg3			$E000	;

;------------------------------------------[ Misc. defines ]-----------------------------------------

.alias modeTitle		1

;Bitmask defs used for SamusGear.
.alias gr_BOMBS			%00000001
.alias gr_HIGHJUMP		%00000010
.alias gr_LONGBEAM		%00000100
.alias gr_SCREWATTACK		%00001000
.alias gr_MARUMARI		%00010000
.alias gr_VARIA			%00100000
.alias gr_WAVEBEAM		%01000000
.alias gr_ICEBEAM		%10000000

;Samus action handlers.
.alias sa_Stand			0
.alias sa_Run			1	;Also run and jump.
.alias sa_Jump			2
.alias sa_Roll			3
.alias sa_PntUp			4
.alias sa_Door			5
.alias sa_PntJump		6
.alias sa_Dead			7
.alias sa_Dead2			8
.alias sa_Elevator		9
.alias sa_FadeIn0		20
.alias sa_FadeIn1		21
.alias sa_FadeIn2		22
.alias sa_FadeIn3		23
.alias sa_FadeIn4		24
.alias sa_Begin			255

;Animations
.alias an_SamusRun		$00
.alias an_SamusFront		$04
.alias an_SamusStand		$07
.alias an_SamusJump		$0C
.alias an_SamusSalto		$0E
.alias an_SamusRunJump		$13
.alias an_SamusRoll		$16
.alias an_Bullet		$1B
.alias an_SamusFireJump		$20
.alias an_SamusFireRun		$22
.alias an_SamusPntUp		$27
.alias an_Explode		$32
.alias an_SamusJumpPntUp	$35
.alias an_SamusRunPntUp		$37
.alias an_WaveBeam		$7D
.alias an_BombTick		$7F
.alias an_BombExplode		$82
.alias an_MissileLeft		$8B
.alias an_MissileRight		$8D
.alias an_MissileExplode	$91

;Weapon action handlers.
.alias wa_RegularBeam		1
.alias wa_WaveBeam		2
.alias wa_IceBeam		3
.alias wa_BulletExplode		4
.alias wa_LayBomb		8
.alias wa_BombCount		9
.alias wa_BombExplode		10
.alias wa_Missile		11