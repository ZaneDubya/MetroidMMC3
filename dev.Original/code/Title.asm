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
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Disassembled using TRaCER.
;Can be reassembled using Ophis.
;Last updated: 3/9/2010

;Title/end (memory page 0)

.org $8000

.include "Defines.asm"

;-------------------------------------[ Forward declarations ]--------------------------------------

.alias startup			$C01A
.alias NMI			$C0D9
.alias ClearNameTables		$C158
.alias ClearNameTable0		$C16D
.alias EraseAllSprites		$C1A3
.alias RemoveIntroSprites	$C1BC
.alias ClearRAM_33_DF		$C1D4
.alias PreparePPUProcess_	$C20E
.alias ChooseRoutine		$C27C
.alias AddYToPtr02		$C2B3
.alias Adiv16			$C2BF
.alias Adiv8			$C2C0
.alias Amul16			$C2C5
.alias Amul8			$C2C6
.alias ProcessPPUString		$C30C
.alias EraseTile		$C328
.alias WritePPUByte		$C36B
.alias PrepPPUPaletteString	$C37E
.alias TwosCompliment		$C3D4
.alias WaitNMIPass		$C42C
.alias ScreenOff		$C439
.alias WaitNMIPass_		$C43F
.alias ScreenOn			$C447
.alias ExitSub			$C45C
.alias ScreenNmiOff		$C45D
.alias VBOffAndHorzWrite	$C47D
.alias NmiOn			$C487
.alias SetTimer			$C4AA
.alias ClearSamusStats		$C578
.alias InitEndGFX		$C5D0
.alias LoadSamusGFX		$C5DC
.alias InitGFX7			$C6D6
.alias BankTable		$CA30
.alias ChooseEnding		$CAF5
.alias SilenceMusic		$CB8E

;-----------------------------------------[ Start of code ]------------------------------------------

L8000:	lda TitleRoutine		;
L8002:	cmp #$15			;If intro routines not running, branch.
L8004:	bcs ++				;
L8006:	lda Joy1Change			;
L8008:	and #$10			;if start has not been pressed, branch.
L800A:	beq +				;
L800C:	ldy #$00			;
L800E:	sty SpareMemD1			;Not accessed by game.
L8010:	sty SpareMemBB			;Not accessed by game.
L8012:	sty SpareMemB7			;Accessed by unused routine.
L8014:	sty SpareMemB8			;Accessed by unused routine.
L8016:	lda PPUCNT0ZP			;	
L8018:	and #$FC			;Set name table to name table 0.
L801A:	sta PPUCNT0ZP			;
L801C:	lda #$1B			;If start pressed, load START/CONTINUE screen.
L801E:	sta TitleRoutine		;
L8020:	bne ++				;Branch always.
L8022:*	jsr RemoveIntroSprites		;($C1BC)Remove sparkle and crosshair sprites from screen.
L8025:	lda TitleRoutine		;
L8027:*	jsr ChooseRoutine		;($C27C)Jump to proper routine below.

L802A:	.word InitializeAfterReset	;($8071)First routine after reset.
L802C:	.word DrawIntroBackground	;($80D0)Draws ground on intro screen.
L802E:	.word FadeInDelay		;($80F9)Sets up METROID fade in delay.
L8030:	.word METROIDFadeIn		;($812C)Fade METROID onto screen.
L8032:	.word LoadFlashTimer		;($8142)Load timer for METROID flash.
L8034:	.word FlashEffect		;($8109)Makes METROID flash.
L8036:	.word METROIDSparkle		;($814D)Top and bottom "sparkles" on METROID.
L8038:	.word METROIDFadeOut		;($8163)Fades METROID off the screen.
L803A:	.word Crosshairs		;($8182)Displays "crosshairs" effect on screen.
L803C:	.word MoreCrosshairs		;($81D1)Continue "crosshairs" effect.
L803E:	.word IncTitleRoutine		;($806E)Increment TitleRoutine.
L8040:	.word IncTitleRoutine		;($806E)Increment TitleRoutine.
L8042:	.word ChangeIntroNameTable	;($822E)Change from name table 0 to name table 1.
L8044:	.word MessageFadeIn		;($8243)Fade in intro sequence message.
L8046:	.word MessageFadeOut		;($8263)Fade out intro sequence message.
L8048:	.word DelayIntroReplay		;($8283)Set Delay time before intro sequence restarts.
L804A:	.word ClearSpareMem		;($8068)clears some memory addresses not used by game.
L804C:	.word PrepIntroRestart		;($82A3)Prepare to restart intro routines.
L804E:	.word TitleScreenOff		;($82ED)Turn screen off.
L8050:	.word TitleRoutineReturn	;($82F3)Rts.
L8052:	.word TitleRoutineReturn	;($82F3)Rts.
L8054:	.word StartContinueScreen	;($90BA)Displays START/Continue screen.
L8056:	.word ChooseStartContinue	;($90D7)player chooses between START and CONTINUE.
L8058:	.word LoadPasswordScreen	;($911A)Loads password entry screen.
L805A:	.word EnterPassword		;($9147)User enters password.
L805C:	.word DisplayPassword		;($9359)After game over, display password on screen.
L805E:	.word WaitForSTART		;($9394)Wait for START when showing password.
L8060:	.word StartContinueScreen	;($90BA)Displays START/Continue screen.
L8062:	.word GameOver			;($939E)Displays "GAME OVER".
L8064:	.word EndGame			;($9AA7)Show ending of the game.
L8066:	.word SetTimer			;($C4AA)Set delay timer.

;----------------------------------------[ Intro routines ]------------------------------------------

ClearSpareMem:
L8068:	lda #$00			;
L806A:	sta SpareMemCB			;Clears two memory addresses not used by the game.
L806C:	sta SpareMemC9			;

IncTitleRoutine:
L806E:	inc TitleRoutine		;Increment to next title routine.
L8070:	rts				;

InitializeAfterReset:
L8071:	ldy #$02			;Y=2.
L8073:	sty SpareMemCF			;Not accessed by game.
L8075:	sty SpareMemCC			;Not accessed by game.
L8077:	dey				;Y=1.
L8078:	sty SpareMemCE			;Not accessed by game.
L807A:	sty SpareMemD1			;Not accessed by game.
L807C:	dey				;Y=0.
L807D:	sty SpareMemD0			;Not accessed by game.
L807F:	sty SpareMemCD			;Not accessed by game.
L8081:	sty SpareMemD3			;Not accessed by game.
L8083:	sty NARPASSWORD			;Set NARPASSWORD not active.	
L8086:	sty SpareMemCB			;Not accessed by game.
L8088:	sty SpareMemC9			;Not accessed by game.
L808A:	lda #$02			;A=2.
L808C:	sta IntroMusicRestart		;Title rountines cycle twice before restart of music.
L808E:	sty SpareMemB7			;Accessed by unused routine.
L8090:	sty SpareMemB8			;Accessed by unused routine.
L8092:	sty PalDataIndex		;Reset index to palette data.
L8094:	sty ScreenFlashPalIndex		;Reset index into screen flash palette data.
L8096:	sty IntroStarOffset		;Reset index into IntroStarPntr table.
L8098:	sty FadeDataIndex		;Reset index into fade out palette data.
L809A:	sty $00				;
L809C:	ldx #$60			;Set $0000 to point to address $6000.

L809E:*	stx $01				;
L80A0:	txa				;
L80A1:	and #$03			;
L80A3:	asl				;
L80A4:	tay				;The following loop Loads the -->
L80A5:	sty $02				;RAM with the following values: -->
L80A7:	lda RamValueTbl, y		;$6000 thru $62FF = #$00.
L80AA:	ldy #$00			;$6300 thru $633F = #$C0.
L80AC:*	sta ($00), y			;$6340 thru $63FF = #$C4.
L80AE:	iny				;$6400 thru $66FF = #$00.
L80AF:	beq +				;$6700 thru $673F = #$C0.
L80B1:	cpy #$40			;$6740 thru $67FF = #$C4.
L80B3:	bne -				;
L80B5:	ldy $02				;
L80B7:	lda RamValueTbl+1, y		;
L80BA:	ldy #$40			;
L80BC:	bpl -				;
L80BE:*	inx				;
L80BF:	cpx #$68			;
L80C1:	bne ---				;

L80C3:	inc TitleRoutine		;Draw intro background next.			
L80C5:	jmp LoadStarSprites		;($98AE)Loads stars on intro screen.		

;The following table is used by the code above for writing values to RAM.

RamValueTbl:
L80C8:	.byte $00, $00, $00, $00, $00, $00, $C0, $C4

DrawIntroBackground:
L80D0:	LDA #$10			;Intro music flag.
L80D2:	STA ABStatus			;Never accessed by game.
L80D4:	STA MultiSFXFlag		;Initiates intro music.
L80D7:	JSR ScreenOff			;($C439)Turn screen off.
L80DA:	JSR ClearNameTables		;($C158)Erase name table data.
L80DD:	LDX #$F4			;Lower address of PPU information.
L80DF:	LDY #$82			;Upper address of PPU information.
L80E1:	JSR PreparePPUProcess_		;($C20E) Writes background of intro screen to name tables.
L80E4:	LDA #$01			;
L80E6:	STA PalDataPending		;Prepare to load palette data.
L80E8:	STA SpareMemC5			;Not accessed by game.
L80EA:	LDA PPUCNT0ZP			;
L80EC:	AND #$FC			;Switch to name table 0
L80EE:	STA PPUCNT0ZP			;
L80F0:	INC TitleRoutine		;Next routine sets up METROID fade in delay.
L80F2:	LDA #$00			;
L80F4:	STA SpareMemD7			;Not accessed by game.
L80F6:	JMP ScreenOn			;($C447)Turn screen on.

FadeInDelay:
L80F9:	LDA PPUCNT0ZP			;
L80FB:	AND #$FE			;Switch to name table 0 or 2.
L80FD:	STA PPUCNT0ZP			;
L80FF:	LDA #$08			;Loads Timer3 with #$08. Delays Fade in routine.-->
L8101:	STA Timer3			;Delays fade in by 80 frames (1.3 seconds).
L8103:	LSR				;
L8104:	STA PalDataIndex		;Loads PalDataIndex with #$04
L8106:	INC TitleRoutine		;Increment to next routine.
L8108:	RTS				;
 
FlashEffect:
L8109:	LDA FrameCount			;Every third frame, run change palette-->
L810B:	AND #$03			;Creates METROID flash effect.
L810D:	BNE +				;
L810F:	LDA PalDataIndex		;Uses only the first three palette-->
L8111:	AND #$03			;data sets in the flash routine.
L8113:	STA PalDataIndex		;
L8115:	JSR LoadPalData			;
L8118:	LDA Timer3			;If Timer 3 has not expired, branch-->
L811A:	BNE +				;so routine will keep running.
L811C:	LDA PalDataIndex		;
L811E:	CMP #$04			;Ensures the palette index is back at 0.
L8120:	BNE +				;
L8122:	INC TitleRoutine		;Increment to next routine.
L8124:	JSR LoadSparkleData		;($87AB) Loads data for next routine.
L8127:	LDA #$18			;Sets Timer 3 for a delay of 240 frames-->
L8129:	STA Timer3			;(4 seconds).
L812B:*	RTS				;

METROIDFadeIn:
L812C:	LDA Timer3			;
L812E:	BNE +				;
L8130:	LDA FrameCount			;Every 16th FrameCount, Change palette.-->
L8132:	AND #$0F			;Causes the fade in effect.
L8134:	BNE +				;
L8136:	JSR LoadPalData			;($8A8C)Load data into Palettes.
L8139:	BNE +				;
L813B:	LDA #$20			;Set timer delay for METROID flash effect.-->
L813D:	STA Timer3			;Delays flash by 320 frames (5.3 seconds).
L813F:	INC TitleRoutine		;
L8141:*	RTS				;

LoadFlashTimer:
L8142:	LDA Timer3			;If 320 frames have not passed, exit
L8144:	BNE -				;
L8146:	LDA #$08			;
L8148:	STA Timer3			;Stores a value of 80 frames in Timer3-->
L814A:	INC TitleRoutine		;(1.3 seconds).
L814C:	RTS				;

METROIDSparkle:
L814D:	LDA Timer3			;Wait until 3 seconds have passed since-->
L814F:	BNE ++				;last routine before continuing.
L8151:	LDA IntroSpr0Complete		;Check if sparkle sprites are done moving.
L8154:	AND IntroSpr1Complete		;
L8157:	CMP #$01			;Is sparkle routine finished? If so,-->
L8159:	BNE +				;go to next title routine, else continue-->
L815B:	INC TitleRoutine		;with sparkle routine.
L815D:	BNE ++				;
L815F:*	JSR UpdateSparkleSprites	;($87CF)Update sparkle sprites on the screen.
L8162:*	RTS				;

METROIDFadeOut:
L8163:	LDA FrameCount			;Wait until the frame count is a multiple-->
L8165:	AND #$07			;of eight before proceeding.  
L8167:	BNE ++				;
L8169:	LDA FadeDataIndex		;If FadeDataIndex is less than #$04, keep-->
L816B:	CMP #$04			;doing the palette changing routine.
L816D:	BNE +				;
L816F:	JSR LoadInitialSpriteData	;($8897)Load initial sprite values for crosshair routine.
L8172:	LDA #$08			;
L8174:	STA Timer3			;Load Timer3 with a delay of 80 frames(1.3 seconds).
L8176:	STA First4SlowCntr		;Set counter for slow sprite movement for 8 frames,
L8178:	LDA #$00			;
L817A:	STA SecondCrosshairSprites	;Set SecondCrosshairSprites = #$00
L817C:	INC TitleRoutine		;Move to next routine
L817E:*	JSR DoFadeOut			;($8B5F)Fades METROID off the screen.
L8181:*	RTS				;

Crosshairs:
L8182:	LDA FlashScreen			;Is it time to flash the screen white?-->
L8184:	BEQ +				;If not, branch.
L8186:	JSR FlashIntroScreen		;($8AA7)Flash screen white.
L8189:*	LDA Timer3			;Wait 80 frames from last routine-->
L818B:	BNE ++++			;before running this one.
L818D:	LDA IntroSpr0Complete		;
L8190:	AND IntroSpr1Complete		;Check if first 4 sprites have completed-->
L8193:	AND IntroSpr2Complete		;their movements.  If not, branch.
L8196:	AND IntroSpr3Complete		;
L8199:	BEQ ++				;
L819B:	LDA #$01			;Prepare to flash screen and draw cross.
L819D:	CMP SecondCrosshairSprites	;Branch if second crosshair sprites are already--> 
L819F:	BEQ +				;active.
L81A1:	INC SecondCrosshairSprites	;Indicates second crosshair sprites are active.
L81A3:	STA DrawCross			;Draw cross animation on screen.
L81A5:	STA FlashScreen			;Flash screen white.
L81A7:	LDA #$00			;
L81A9:	STA CrossDataIndex		;Reset index to cross sprite data.
L81AB:*	AND IntroSpr4Complete		;
L81AE:	AND IntroSpr5Complete		;Check if second 4 sprites have completed--> 
L81AF:	AND IntroSpr6Complete		;their movements.  If not, branch.
L81B4:	AND IntroSpr7Complete		;
L81B7:	BEQ +				;
L81B9:	LDA #$01			;Prepare to flash screen and draw cross.
L81BB:	STA DrawCross			;Draw cross animation on screen.
L81BD:	STA FlashScreen			;Flash screen white.
L81BF:	JSR LoadStarSprites		;($98AE)Loads stars on intro screen.
L81C2:	LDA #$00			;
L81C4:	STA CrossDataIndex		;Reset index to cross sprite data.
L81C6:	INC TitleRoutine		;Do MoreCrosshairs next frame.
L81C8:	BNE ++				;Branch always.
L81CA:*	JSR DrawCrosshairsSprites	;($88FE)Draw sprites that converge in center of screen.
L81CD:*	JSR DrawCrossSprites		;($8976)Draw cross sprites in middle of the screen.
L81D0:*	RTS				;

MoreCrosshairs:
L81D1:	LDA FlashScreen			;Is it time to flash the screen white?-->
L81D3:	BEQ +				;If not, branch.
L81D5:	JSR DrawCrossSprites		;($8976)Draw cross sprites in middle of the screen.
L81D8:	JMP FlashIntroScreen		;($8AA7)Flash screen white.
L81DB:*	INC TitleRoutine		;ChangeIntroNameTable is next routine to run.
L81DD:	LDA #$60			;
L81DF:	STA ObjectY			;
L81E2:	LDA #$7C			;These values are written into memory, but they are-->
L81E4:	STA ObjectX			;not used later in the title routine.  This is the-->
L81E7:	LDA AnimResetIndex		;remnants of some abandoned code.
L81EA:	STA AnimIndex			;
L81ED:	RTS				;

UnusedIntroRoutine1:
L81EE:	LDA #$01			;
L81F0:	STA SpareMemBB			;
L81F2:	LDA #$04			;
L81F4:	STA SpritePagePos		;
L81F6:	STA Joy1Change			;
L81F8:	STA Joy1Status			;Unused intro routine.
L81FA:	STA Joy1Retrig			;
L81FC:	LDA #$03			;
L81FE:	STA ObjAction			;
L8201:	STA ScrollDir			;
L8203:	INC TitleRoutine		;
L8205:	RTS				;

UnusedIntroRoutine2:
L8206:	LDA ObjAction			;
L8209:	CMP #$04			;
L820B:	BNE +				;
L820D:	LDA #$00			;
L820F:	STA ObjAction			;
L8212:	LDA #$0B			;Unused intro routine. It looks like this routine-->
L8214:	STA AnimResetIndex		;was going to be used to manipulate sprite objects.
L8217:	LDA #$0C			;
L8219:	STA AnimIndex			;
L821C:	LDA #$07			;
L821E:	STA AnimFrame			;
L8221:	LDA #$08			;
L8223:	STA Timer3			;
L8225:	LDA #$00			;
L8227:	STA SpareMemC9			;Not accessed by game.
L8229:	STA SpareMemCB			;Not accessed by game.
L822B:	INC TitleRoutine		;
L822D:*	RTS				;

ChangeIntroNameTable:
L822E:	LDA PPUCNT0ZP			;
L8230:	ORA #$01			;Change to name table 1.
L8232:	STA PPUCNT0ZP			;
L8234:	INC TitleRoutine		;Next routine to run is MessageFadeIn.
L8236:	LDA #$08			;
L8238:	STA Timer3			;Set Timer3 for 80 frames(1.33 seconds).
L823A:	LDA #$06			;Index to FadeInPalData.
L823C:	STA FadeDataIndex		;
L823E:	LDA #$00			;
L8240:	STA SpareMemC9			;Not accessed by game.
L8242:	RTS				;

MessageFadeIn:
L8243:	LDA Timer3			;Check if delay timer has expired.  If not, branch-->
L8245:	BNE ++				;to exit, else run this rouine.
L8247:	LDA FrameCount			;
L8249:	AND #$07			;Perform next step of fade every 8th frame.
L824B:	BNE ++				;
L824D:	LDA FadeDataIndex		;
L824F:	CMP #$0B			;Has end of fade in palette data been reached?-->
L8251:	BNE +				;If not, branch.
L8253:	LDA #$00			;
L8255:	STA FadeDataIndex		;Clear FadeDataIndex.
L8257:	LDA #$30			;
L8259:	STA Timer3			;Set Timer3 to 480 frames(8 seconds).
L825B:	INC TitleRoutine		;Next routine is MessageFadeOut.
L825D:	BNE ++				;Branch always.
L825F:*	JSR DoFadeOut			;($8B5F)Fade message onto screen.
L8262:*	RTS				;

MessageFadeOut:
L8263:	LDA Timer3			;Check if delay timer has expired.  If not, branch-->
L8265:	BNE ++				;to exit, else run this rouine.
L8267:	LDA FrameCount			;
L8269:	AND #$07			;Perform next step of fade every 8th frame.
L826B:	BNE ++				;
L826D:	LDA FadeDataIndex		;
L826F:	CMP #$05			;Has end of fade out palette data been reached?-->
L8271:	BNE +				;If not, branch.
L8273:	LDA #$06			;
L8275:	STA FadeDataIndex		;Set index to start of fade in data.
L8277:	LDA #$00			;
L8279:	STA SpareMemCB			;Not accessed by game.
L827B:	INC TitleRoutine		;Next routine is DelayIntroReplay.
L827D:	BNE ++				;Branch always.
L827F:*	JSR DoFadeOut			;($8B5F)Fade message off of screen.
L8282:*	RTS				;

DelayIntroReplay:
L8283:	INC TitleRoutine		;Increment to next routine.
L8285:	LDA #$10			;
L8287:	STA Timer3			;Set Timer3 for a delay of 160 frames(2.6 seconds).
L8289:	RTS				;

UnusedIntroRoutine3:
L828A:	LDA Timer3			;
L828C:	BNE +				;
L828E:	LDA SpareMemB7			;
L8290:	BNE +				;
L8292:	LDA SpareMemB8			;
L8294:	AND #$0F			;Unused intro routine.
L8296:	BNE +				;
L8298:	LDA #$01			;
L829A:	STA SpareMemD2			;
L829C:	LDA #$10			;
L829E:	STA Timer3			;
L82A0:	INC TitleRoutine		;
L82A2:*	RTS				;

PrepIntroRestart:
L82A3:	LDA Timer3			;Check if delay timer has expired.  If not, branch-->
L82A5:	BNE ++				;to exit, else run this rouine.
L82A7:	STA SpareMemD2			;Not accessed by game.
L82A9:	STA SpareMemBB			;Not accessed by game.
L82AB:	STA IsSamus			;Clear IsSamus memory address.
L82AD:	LDY #$1F			;
L82AF:*	STA ObjAction,Y			;
L82B2:	DEY				;Clear RAM $0300 thru $031F.
L82B3:	BPL -				;
L82B5:	LDA PPUCNT0ZP			;Change to name table 0.
L82B7:	AND #$FC			;
L82B9:	STA PPUCNT0ZP			;
L82BB:	INY				;Y=0.
L82BC:	STY SpareMemB7			;Accessed by unused routine.
L82BE:	STY SpareMemB8			;Accessed by unused routine.
L82C0:	STY PalDataIndex		;
L82C2:	STY ScreenFlashPalIndex		;Clear all index values from these addresses.
L82C4:	STY IntroStarOffset		;
L82C6:	STY FadeDataIndex		;
L82C8:	STY SpareMemCD			;Not accessed by game.
L82CA:	STY Joy1Change			;
L82CC:	STY Joy1Status			;Clear addresses that were going to be written to by an-->
L82CE:	STY Joy1Retrig			;unused intro routine.
L82D0:	STY SpareMemD7			;Not accessed by game.
L82D2:	INY				;Y=1.
L82D3:	STY SpareMemCE			;Not accessed by game.
L82D5:	INY				;Y=2.
L82D6:	STY SpareMemCC			;Not accessed by game.
L82D8:	STY SpareMemCF			;Not accessed by game.
L82DA:	STY TitleRoutine		;Next routine sets up METROID fade in delay.
L82DC:	LDA IntroMusicRestart		;Check to see if intro music needs to be restarted.-->
L82DE:	BNE ++				;Branch if not.
L82E0:	LDA #$10			;
L82E2:	STA MultiSFXFlag		;Restart intro music.
L82E5:	LDA #$02			;Set restart of intro music after another two cycles-->
L82E7:	STA IntroMusicRestart		;of the title routines.
L82E9:*	RTS				;
 
L82EA:*	DEC IntroMusicRestart		;One title routine cycle complete. Decrement intro-->
L82EC:	RTS				;music restart counter.

TitleScreenOff:
L82ED:	JSR ScreenOff			;($C439)Turn screen off.
L82F0:	INC TitleRoutine		;Next routine is TitleRoutineReturn.
L82F2:	RTS				;This routine should not be reached.

TitleRoutineReturn:
L82F3:	RTS				;Last title routine function. Should not be reached.

;The following data fills name table 0 with the intro screen background graphics.

;Information to be stored in attribute table 0.
L82F4:	.byte $23			;PPU address high byte.
L82F5:	.byte $C0			;PPU address low byte.
L82F6:	.byte $20			;PPU string length.
L82F7:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF 
L8307:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

L8317:	.byte $23			;PPU address high byte.
L8318:	.byte $E0			;PPU address low byte.
L8319:	.byte $20			;PPU string length.
L831A:	.byte $FF, $FF, $BF, $AF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L832A:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;Writes row $22E0 (24th row from top).
L833A:	.byte $22			;PPU address high byte.
L833B:	.byte $E0			;PPU address low byte.
L833C:	.byte $20			;PPU string length.
L833D:	.byte $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF
L834D:	.byte $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF

;Writes row $2300 (25th row from top).
L835D:	.byte $23			;PPU address high byte.
L835E:	.byte $00			;PPU address low byte.
L835F:	.byte $20			;PPU string length.
L8360:	.byte $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81
L8370:	.byte $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81

;Writes row $2320 (26th row from top).
L8380:	.byte $23			;PPU address high byte.
L8381:	.byte $20			;PPU address low byte.
L8382:	.byte $20			;PPU string length.
L8383:	.byte $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83
L8393:	.byte $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83

;Writes row $2340 (27th row from top).
L83A3:	.byte $23			;PPU address high byte.
L83A4:	.byte $40			;PPU address low byte.
L83A5:	.byte $20			;PPU string length.
L83A6:	.byte $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85
L83B6:	.byte $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85

;Writes row $2360 (28th row from top).
L83C6:	.byte $23			;PPU address high byte.
L83C7:	.byte $60			;PPU address low byte.
L83C8:	.byte $20			;PPU string length.
L83C9:	.byte $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87
L83D9:	.byte $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87

;Writes row $2380 (29th row from top).
L83E9:	.byte $23			;PPU address high byte.
L83EA:	.byte $80			;PPU address low byte.
L83EB:	.byte $20			;PPU string length.
L83EC:	.byte $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89
L83FC:	.byte $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89

;Writes row $23A0 (Bottom row).
L840C:	.byte $23			;PPU address high byte.
L840D:	.byte $A0			;PPU address low byte.
L840E:	.byte $20			;PPU string length.
L840F:	.byte $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B
L841F:	.byte $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B

;Writes some blank spaces in row $20A0 (6th row from top).
L842F:	.byte $20 			;PPU address high byte.
L8430:	.byte $A8			;PPU address low byte.
L8431:	.byte $4F			;PPU string length.
L8432:	.byte $FF			;Since RLE bit set, repeat 16 blanks starting at $20A8.

;Writes METROID graphics in row $2100 (9th row from top).
L8433:	.byte $21			;PPU address high byte.
L8434:	.byte $03			;PPU address low byte.
L8435:	.byte $1C			;PPU string length.
L8436:	.byte $40, $5D, $56, $5D, $43, $40, $5D, $43, $40, $5D, $5D, $43, $40, $5D, $5D, $63
L8446:	.byte $62, $5D, $5D, $63, $40, $43, $40, $5D, $5D, $63, $1D, $16

;Writes METROID graphics in row $2120 (10th row from top).
L8452:	.byte $21			;PPU address high byte.
L8453:	.byte $23			;PPU address low byte.
L8454:	.byte $1A			;PPU string length.
L8455:	.byte $44, $50, $50, $50, $47, $44, $57, $58, $74, $75, $76, $77, $44, $57, $69, $47
L8465:	.byte $44, $57, $69, $47, $44, $47, $44, $68, $69, $47

;Writes METROID graphics in row $2140 (11th row from top).
L846F:	.byte $21 			;PPU address high byte.
L8470:	.byte $43			;PPU address low byte.
L8471:	.byte $1A			;PPU string length.
L8472:	.byte $44, $41, $7E, $49, $47, $44, $59, $5A, $78, $79, $7A, $7B, $44, $59, $6D, $70
L8482:	.byte $44, $73, $72, $47, $44, $47, $44, $73, $72, $47

;Writes METROID graphics in row $2160 (12th row from top).
L848C:	.byte $21			;PPU address high byte.
L848D:	.byte $63			;PPU address low byte.
L848E:	.byte $1A			;PPU string length.
L848F:	.byte $44, $42, $7F, $4A, $47, $44, $5B, $5C, $FF, $44, $47, $FF, $44, $5B, $6F, $71
L849F:	.byte $44, $45, $46, $47, $44, $47, $44, $45, $46, $47

;Writes METROID graphics in row $2180 (13th row from top).
L84A9:	.byte $21			;PPU address high byte.
L84AA:	.byte $83			;PPU address low byte.
L84AB:	.byte $1A			;PPU string length.
L84AC:	.byte $44, $47, $FF, $44, $47, $44, $5F, $60, $FF, $44, $47, $FF, $44, $7D, $7C, $47
L84BC:	.byte $44, $6A, $6B, $47, $44, $47, $44, $6A, $6B, $47

;Writes METROID graphics in row $21A0 (14th row from top).
L84C6:	.byte $21			;PPU address high byte.
L84C7:	.byte $A3			;PPU address low byte.
L84C8:	.byte $1A			;PPU string length.
L84C9:	.byte $4C, $4F, $FF, $4C, $4F, $4C, $5E, $4F, $FF, $4C, $4F, $FF, $4C, $4D, $4E, $4F
L84D9:	.byte $66, $5E, $5E, $64, $4C, $4F, $4C, $5E, $5E, $64

;Writes METROID graphics in row $21C0 (15th row from top).
L84E3:	.byte $21			;PPU address high byte.
L84E4:	.byte $C3			;PPU address low byte.
L84E5:	.byte $1A			;PPU string length.
L84E6:	.byte $51, $52, $FF, $51, $52, $51, $61, $52, $FF, $51, $52, $FF, $51, $53, $54, $52
L84F6:	.byte $67, $61, $61, $65, $51, $52, $51, $61, $61, $65

;Writes PUSH START BUTTON in row $2220 (18th row from top).
L8500:	.byte $22			;PPU address high byte.
L8501:	.byte $27			;PPU address low byte.
L8502:	.byte $15			;PPU string length.
;             '_    P    U    S    H    _    S    T    A    R    T    _    B    U    T    T
L8503:	.byte $FF, $19, $1E, $1C, $11, $FF, $1C, $1D, $0A, $1B, $1D, $FF, $0B, $1E, $1D, $1D
;	       O    N    _    _    _'
L8513:	.byte $18, $17, $FF, $FF, $FF

;Writes C 1986 NINTENDO in row $2260 (20th row from top).
L8518:	.byte $22			;PPU memory high byte.
L8519:	.byte $69			;PPU memory low byte.
L851A:	.byte $12			;PPU string length.
;             'C    _    1    9    8    6    _    N    I    N    T    E    N    D    O    _
L851B:	.byte $8F, $FF, $01, $09, $08, $06, $FF, $17, $12, $17, $1D, $0E, $17, $0D, $18, $FF
;	       _    _'
L852B:	.byte $FF, $FF

;The following data fills name table 1 with the intro screen background graphics.

;Information to be stored in attribute table 1.
L852D:	.byte $27			;PPU memory high byte.
L852E:	.byte $C0			;PPU memory low byte.
L852F:	.byte $20			;PPU string length.
L8530:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L8540:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

;Writes row $27E0 (24th row from top).
L8550:	.byte $27			;PPU memory high byte.
L8551:	.byte $E0			;PPU memory low byte.
L8552:	.byte $20			;PPU string length.
L8553:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
L8563:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

;Writes row $26E0 (24th row from top).
L8573:	.byte $26			;PPU memory high byte.
L8574:	.byte $E0			;PPU memory low byte.
L8575:	.byte $20			;PPU string length.
L8576:	.byte $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF
L8586:	.byte $FF, $FF, $FF, $FF, $FF, $8C, $FF, $FF, $FF, $FF, $FF, $8D, $FF, $FF, $8E, $FF

;Writes row $2700 (25th row from top).
L8595:	.byte $27			;PPU memory high byte.
L8597:	.byte $00			;PPU memory low byte.
L8598:	.byte $20			;PPU string length.
L8599:	.byte $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81
L85A9:	.byte $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81

;Writes row $2720 (26th row from top).
L85B9:	.byte $27			;PPU memory high byte.
L85BA:	.byte $20			;PPU memory low byte.
L85BB:	.byte $20			;PPU string length.
L85BC:	.byte $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83
L85CC:	.byte $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83, $82, $83

;Writes row $2740 (27th row from top).
L85DC:	.byte $27			;PPU memory high byte.
L85DD:	.byte $40			;PPU memory low byte.
L85DE:	.byte $20			;PPU string length.
L85DF:	.byte $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85
L85EF:	.byte $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85, $84, $85

;Writes row $2760 (28th row from top).
L85FF:	.byte $27			;PPU memory high byte.
L8600:	.byte $60			;PPU memory low byte.
L8601:	.byte $20			;PPU string length.
L8602:	.byte $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87
L8612:	.byte $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87, $86, $87

;Writes row $2780 (29th row from top).
L8622:	.byte $27			;PPU memory high byte.
L8623:	.byte $80			;PPU memory low byte.
L8624:	.byte $20			;PPU string length.
L8625:	.byte $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89
L8635:	.byte $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89, $88, $89

;Writes row $27A0 (bottom row).
L8645:	.byte $27			;PPU memory high byte.
L8646:	.byte $A0			;PPU memory low byte.
L8647:	.byte $20			;PPU string length.
L8648:	.byte $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B
L8658:	.byte $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B, $8A, $8B

;Writes row $2480 (5th row from top).
L8668:	.byte $24			;PPU memory high byte.
L8669:	.byte $88			;PPU memory low byte.
L866A:	.byte $0F			;PPU string length.
;             'E    M    E    R    G    E    N    C    Y    _    O    R    D    E    R'
L866B:	.byte $0E, $16, $0E, $1B, $10, $0E, $17, $0C, $22, $FF, $18, $1B, $0D, $0E, $1B

;Writes row $2500 (9th row from top).
L867A:	.byte $25			;PPU memory high byte.
L867B:	.byte $04			;PPU memory low byte.
L867C:	.byte $1C			;PPU string length.
;             'D    E    F    E    A    T    _    T    H    E    _    M    E    T    R    0
L867D:	.byte $0D, $0E, $0F, $0E, $0A, $1D, $FF, $1D, $11, $0E, $FF, $16, $0E, $1D, $1B, $18
;	       I    D    _    O    F    _    _    _    _    _    _    _'
L868D:	.byte $12, $0D, $FF, $18, $0F, $FF, $FF, $FF, $FF, $FF, $FF, $FF

;Writes row $2540 (11th row from top).
L8699:	.byte $25			;PPU memory high byte.
L869A:	.byte $44			;PPU memory low byte.
L869B:	.byte $1A			;PPU string length.
;             'T    H    E    _    P    L    A    N    E    T    _    Z    E    B    E    T
L869C:	.byte $1D, $11, $0E, $FF, $19, $15, $0A, $17, $0E, $1D, $FF, $23, $0E, $0B, $0E, $1D
;	       H    _    A    N    D    _    _    _    _    _'
L86AC:	.byte $11, $FF, $0A, $17, $0D, $FF, $FF, $FF, $FF, $FF

;Writes row $2580 (13th row from top).
L86B6:	.byte $25			;PPU memory high byte.
L86B7:	.byte $84			;PPU memory low byte.
L86B8:	.byte $1A			;PPU string length.
;             'D    E    S    T    R    O    Y    _    T    H    E    _    M    O    T    H
L86B9:	.byte $0D, $0E, $1C, $1D, $1B, $18, $22, $FF, $1D, $11, $0E, $FF, $16, $18, $1D, $11
;	       E    R    _    B    R    A    I    N    _    _'
L86C9:	.byte $0E, $1B, $FF, $0B, $1B, $0A, $12, $17, $FF, $FF

;Writes row $25C0 (15th row from top).
L86D3:	.byte $25			;PPU memory high byte.
L86D4:	.byte $C4			;PPU memory low byte.
L86D5:	.byte $1A			;PPU string length.
;             'T    H    E    _    M    E    C    H    A    N    I    C    A    L    _    L
L86D6:	.byte $1D, $11, $0E, $FF, $16, $0E, $0C, $11, $0A, $17, $12, $0C, $0A, $15, $FF, $15
;	       I    F    E    _    V    E    I    N    _    _'
L86E9:	.byte $12, $0F, $0E, $FF, $1F, $0E, $12, $17, $FF, $FF

;Writes row $2620 (18th row from top).
L86F0:	.byte $26			;PPU memory high byte.
L86F1:	.byte $27			;PPU memory low byte.
L86F2:	.byte $15			;PPU string length.
;             'G    A    L    A    X    Y    _    F    E    D    E    R    A    L    _    P
L86F3:	.byte $10, $0A, $15, $0A, $21, $22, $FF, $0F, $0E, $0D, $0E, $1B, $0A, $15, $FF, $19
;	       O    L    I    C    E'
L8703:	.byte $18, $15, $12, $0C, $0E

;Writes row $2660 (20th row from top).
L8708:	.byte $26			;PPU memory high byte.
L8709:	.byte $69			;PPU memory low byte.
L870A:	.byte $12			;PPU string length.
;             '_    _    _    _    _    _    _    _    _    _    _    _    _    _    M    5
L870B:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $16, $05
;	       1    0'
L871B:	.byte $01, $00

L871D:	.byte $00			;End PPU string write.

;The following data does not appear to be used.
L871E:	.byte $46, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
L872E:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $20, $00, $00, $00, $00, $00, $00
L873E:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L874E:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 

;The following error message is diplayed if the player enters an incorrect password.
;             'E    R    R    O    R    _    T    R    Y    _    A    G    A    I    N'
L8759:	.byte $0E, $1B, $1B, $18, $1B, $FF, $1D, $1B, $22, $FF, $0A, $10, $0A, $12, $17

;If the error message above is not being displayed on the password 
;screen, the following fifteen blanks spaces are used to cover it up.
;             '_    _    _    _    _    _    _    _    _    _    _    _    _    _    _'
L8768:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF

;Not used.
L8777:	.byte $79, $87, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $02, $00
L8787:	.byte $00, $03, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00, $00, $02, $00
L8797:	.byte $00, $03, $A1, $87, $A2, $87, $A5, $87, $A8, $87, $00, $18, $CC, $00, $18, $CD
L87A7:	.byte $00, $18, $CE, $00 

LoadSparkleData:
L87AB:	LDX #$0A			;
L87AD:*	LDA InitSparkleDataTbl,X	;
L87B0:	STA IntroSpr0YCoord,X		;Loads $6EA0 thru $6EAA with the table below.
L87B3:	STA IntroSpr1YCoord,X		;Loads $6EB0 thru $6EBA with the table below.
L87B6:	DEX				;
L87B7:	BPL -				;Loop until all values from table below are loaded.
L87B9:	LDA #$6B			;
L87BB:	STA IntroSpr1YCoord		;$6EA0 thru $6EAA = #$3C, #$C6, #$01, #$18, #$00,-->
L87BE:	LDA #$DC			;#$00, #$00, #$00, #$20, #$00, #$00, initial.
L87C0:	STA IntroSpr1XCoord		;$6EB0 thru $6EBA = #$6B, #$C6, #$01, #$DC, #$00,-->
L87C3:	RTS				;#$00, #$00, #$00, #$20, #$00, #$00, initial.

;Used by above routine to load Metroid initial sparkle data into $6EA0
;thru $6EAA and $6EB0 thru $6EBA.

InitSparkleDataTbl:
L87C4:	.byte $3C, $C6, $01, $18, $00, $00, $00, $00, $20, $00, $00

UpdateSparkleSprites:
L87CF:	LDX #$00			;
L87D1:	JSR DoOneSparkleUpdate		;($87D6)Performs calculations on top sparkle sprite.
L87D4:	LDX #$10			;Performs calculations on bottom sparkle sprite.

DoOneSparkleUpdate:
L87D6:	JSR SparkleUpdate		;($87D9)Update sparkle sprite data.

SparkleUpdate:
L87D9:	LDA IntroSpr0NextCntr,X		;If $6EA5 has not reached #$00, skip next routine.
L87DC:	BNE +				;
L87DE:	JSR DoSparkleSpriteCoord	;($881A)Update sparkle sprite screen position.
L87E1:*	LDA IntroSpr0Complete,X		;
L87E4:	BNE ++				;If sprite is already done, skip routine.
L87E6:	DEC IntroSpr0NextCntr,X		;

L87E9:	LDA SparkleSpr0YChange,X	;
L87EC:	CLC 				;
L87ED:	ADC IntroSpr0YCoord,X		;Updates sparkle sprite Y coord.
L87F0:	STA IntroSpr0YCoord,X		;

L87F3:	LDA SparkleSpr0XChange,X	;			
L87F6:	CLC 				;
L87F7:	ADC IntroSpr0XCoord,X		;Updates sparkle sprite X coord.
L87FA:	STA IntroSpr0XCoord,X		;

L87FD:	DEC IntroSpr0ChngCntr,X		;Decrement IntroSpr0ChngCntr. If 0, time to change-->
L8800:	BNE +				;sprite graphic.
L8802:	LDA IntroSpr0PattTbl,X		;
L8805:	EOR #$03			;If IntroSpr0ChngCntr=$00, the sparkle sprite graphic is-->
L8807:	STA IntroSpr0PattTbl,X		;changed back and forth between pattern table-->
L880A:	LDA #$20			;graphic $C6 and $C7.  IntroSpr0ChngCntr is reset to #$20.
L880C:	STA IntroSpr0ChngCntr,X		;
L880F:	ASL				;
L8810:	EOR IntroSpr0Cntrl,X		;Flips pattern at $C5 in pattern table--> 
L8813:	STA IntroSpr0Cntrl,X		;horizontally when displayed.
L8816:*	JMP WriteIntroSprite		;($887B)Transfer sprite info into sprite RAM.
L8819:*	RTS				;

DoSparkleSpriteCoord:
L881A:	TXA				;
L881B:	JSR Adiv8			;($C2C0)Y=0 when working with top sparkle sprite-->
L881E:	TAY 				;and y=2 when working with bottom sparkle sprite.
L881F:	LDA SparkleAddressTbl,Y		;Base is $89AF.
L8822:	STA $00				;When working with top sparkle sprite, E1,E0=$89B3-->
L8824:	LDA SparkleAddressTbl+1,Y	;and when botton sparkle sprite, E1,E0=$89E9.
L8827:	STA $01				;
L8829:	LDY IntroSpr0Index,X		;Loads index for finding sparkle data (x=$00 or $10).
L882C:	LDA ($00),Y			;
L882E:	BPL +				;If data byte MSB is set, set $6EA9 to #$01 and move to-->
L8830:	LDA #$01			;next index for sparkle sprite data.
L8832:	STA IntroSpr0ByteType,X		;
L8835:*	BNE +				;
L8837:	LDA #$01			;If value is equal to zero, sparkle sprite-->
L8839:	STA IntroSpr0Complete,X		;processing is complete.
L883C:*	STA IntroSpr0NextCntr,X		;
L883F:	INY				;
L8840:	LDA ($00),y			;Get x/y position byte.
L8842:	DEC IntroSpr0ByteType,X		;If MSB of second byte is set, branch.
L8845:	BMI +				;
L8847:	LDA #$00			;This code is run when the MSB of the first byte-->
L8849:	STA SparkleSpr0YChange,X	;is set.  This allows the sprite to change X coord-->
L884C:	LDA ($00),Y			;by more than 7.  Ensures Y coord does not change.
L884E:	BMI ++				;
L8850:*	PHA				;Store value twice so X and Y-->
L8851:	PHA				;coordinates can be extracted.
L8852:	LDA #$00			;
L8854:	STA IntroSpr0ByteType,X		;Set IntroSpr0ByteType to #$00 after processing.
L8857:	PLA				;
L8858:	JSR Adiv16			;($C2BF)Move upper 4 bits to lower 4 bits.
L885B:	JSR NibbleSubtract		;($8871)Check if nibble to be converted to twos compliment.
L885E:	STA SparkleSpr0YChange,X	;Twos compliment stored if Y coord decreasing.
L8861:	PLA				;
L8862:	AND #$0F			;Discard upper 4 bits.
L8864:	JSR NibbleSubtract		;($8871)Check if nibble to be converted to twos compliment.
L8867:*	STA SparkleSpr0XChange,X	;Store amount to move spite in x direction.
L886A:	INC IntroSpr0Index,X		;
L886D:	INC IntroSpr0Index,X		;Add two to find index for next data byte.
L8870:	RTS				;

NibbleSubtract:
L8871:	CMP #$08			;If bit 3 is set, nibble is a negative number-->
L8873:	BCC +				;and lower three bits are converted to twos-->
L8875:	AND #$07			;compliment for subtraction, else exit.
L8877:	JSR TwosCompliment		;($C3D4)Prepare for subtraction with twos compliment.
L887A:*	RTS				;

WriteIntroSprite:
L887B:	LDA IntroSpr0YCoord,X		;
L887E:	SEC				;Subtract #$01 from first byte to get proper y coordinate.
L887F:	SBC #$01			;
L8881:	STA Sprite04RAM,X		;
L8884:	LDA IntroSpr0PattTbl,X		;
L8887:	STA Sprite04RAM+1,X		;Load the four bytes for the-->
L888A:	LDA IntroSpr0Cntrl,X		;intro sprites into sprite RAM.
L888D:	STA Sprite04RAM+2,X		;
L8890:	LDA IntroSpr0XCoord,X		;
L8893:	STA Sprite04RAM+3,X		;
L8896:	RTS				;
 
LoadInitialSpriteData:
L8897:	LDA #$20			;
L8899:	STA Second4Delay		;Set delay for second 4 sprites to 32 frames.
L889B:	LDX #$3F			;Prepare to loop 64 times.

L889D:*	LDA Sprite0and4InitTbl,X	;Load data from tables below.
L88A0:	CMP $FF				;If #$FF, skip loading that byte and move to next item.
L88A2:	BEQ +				;
L88A4:	STA IntroSpr0YCoord,X		;Store initial values for sprites 0 thru 3.
L88A7:	STA IntroSpr4YCoord,X		;Store initial values for sprites 4 thru 7.
L88AA:*	DEX				;
L88AB:	BPL --				;Loop until all data is loaded.

L88AD:	LDA #$B8			;Special case for sprite 6 and 7.
L88AF:	STA IntroSpr6YCoord		;
L88B2:	STA IntroSpr7YCoord		;Change sprite 6 and 7 initial y position.
L88B5:	LDA #$16			;
L88B7:	STA IntroSpr6YRise		;Change sprite 6 and 7 y displacement. The combination-->
L88BA:	STA IntroSpr7YRise		;of these two changes the slope of the sprite movement.
L88BD:	RTS				;
 
;The following tables are loaded into RAM as initial sprite control values for the crosshair sprites.

Sprite0and4InitTbl:
L88BE:	.byte $20			;Initial starting y screen position.
L88BF:	.byte $C5			;Sprite pattern table index.
L88C0:	.byte $80			;Sprite control byte.
L88C1:	.byte $00			;Initial starting x screen position.
L88C2:	.byte $FF			;Not used.
L88C3:	.byte $FF			;Not used.
L88C4:	.byte $74			;Intro sprite x total movement distance.
L88C5:	.byte $58			;Intro sprite y total movement distance.
L88C6:	.byte $FF			;Not used.
L88C7:	.byte $FF			;Not used.
L88C8:	.byte $00			;Sprite task complete idicator.
L88C9:	.byte $FF			;Not used.
L88CA:	.byte $1D			;x displacement of sprite movement(run).
L88CB:	.byte $0E			;y displacement of sprite movement(rise).
L88CC:	.byte $01			;Change sprite x coord in positive direction.
L88CD:	.byte $01			;Change sprite y coord in positive direction.

Sprite1and5InitTbl:
L88CE:	.byte $20			;Initial starting y screen position.
L88CF:	.byte $C5			;Sprite pattern table index.
L88D0:	.byte $C0			;Sprite control byte.
L88D1:	.byte $F8			;Initial starting x screen position.
L88D2:	.byte $FF			;Not used.
L88D3:	.byte $FF			;Not used.
L88D4:	.byte $7C			;Intro sprite x total movement distance.
L88D5:	.byte $58			;Intro sprite y total movement distance.
L88D6:	.byte $FF			;Not used.
L88D7:	.byte $FF			;Not used.
L88D8:	.byte $00			;Sprite task complete idicator.
L88D9:	.byte $FF			;Not used.
L88DA:	.byte $1F			;x displacement of sprite movement(run).
L88DB:	.byte $0E			;y displacement of sprite movement(rise).
L88DC:	.byte $80			;Change sprite x coord in negative direction.
L88DD:	.byte $01			;Change sprite y coord in positive direction.

Sprite2and6InitTbl:
L88DE:	.byte $C8			;Initial starting y screen position.
L88DF:	.byte $C5			;Sprite pattern table index.
L88E0:	.byte $00			;Sprite control byte.
L88E1:	.byte $00			;Initial starting x screen position.
L88E2:	.byte $FF			;Not used.
L88E3:	.byte $FF			;Not used.
L88E4:	.byte $74			;Intro sprite x total movement distance.
L88E5:	.byte $60			;Intro sprite y total movement distance.
L88E6:	.byte $FF			;Not used.
L88E7:	.byte $FF			;Not used.
L88E8:	.byte $00			;Sprite task complete idicator.
L88E9:	.byte $FF			;Not used.
L88EA:	.byte $1D			;x displacement of sprite movement(run).
L88EB:	.byte $1A			;y displacement of sprite movement(rise).
L88EC:	.byte $01			;Change sprite x coord in positive direction.
L88ED:	.byte $80			;Change sprite y coord in negative direction.

Sprite3and7InitTbl:
L88EE:	.byte $C8			;Initial starting y screen position.
L88EF:	.byte $C5			;Sprite pattern table index.
L88F0:	.byte $40			;Sprite control byte.
L88F1:	.byte $F8			;Initial starting x screen position.
L88F2:	.byte $FF			;Not used.
L88F3:	.byte $FF			;Not used.
L88F4:	.byte $7C			;Intro sprite x total movement distance.
L88F5:	.byte $60			;Intro sprite y total movement distance.
L88F6:	.byte $FF			;Not used.
L88F7:	.byte $FF			;Not used.
L88F8:	.byte $00			;Sprite task complete idicator.
L88F9:	.byte $FF			;Not used.
L88FA:	.byte $1F			;x displacement of sprite movement(run).
L88FB:	.byte $1A			;y displacement of sprite movement(rise).
L88FC:	.byte $80			;Change sprite x coord in negative direction.
L88FD:	.byte $80			;Change sprite y coord in negative direction.

DrawCrosshairsSprites:
L88FE:	LDA First4SlowCntr		;
L8900:	BEQ +				;Has First4SlowCntr already hit 0? If so, branch.
L8902:	DEC First4SlowCntr		;
L8904:	BNE +				;Is First4SlowCntr now equal to 0? if not, branch.
L8906:	ASL IntroSpr0XRun		;
L8909:	ASL IntroSpr0YRise		;
L890C:	ASL IntroSpr1XRun		;
L890F:	ASL IntroSpr1YRise		;
L8912:	ASL IntroSpr2XRun		;
L8915:	ASL IntroSpr2YRise		;
L8918:	ASL IntroSpr3XRun		;Multiply the rise and run of the 8 sprites by 2.-->
L891B:	ASL IntroSpr3YRise		;This doubles their speed.
L891E:	ASL IntroSpr4XRun		;
L8921:	ASL IntroSpr4YRise		;
L8924:	ASL IntroSpr5XRun		;
L8927:	ASL IntroSpr5YRise		;
L892A:	ASL IntroSpr6XRun		;
L892D:	ASL IntroSpr6YRise		;
L8930:	ASL IntroSpr7XRun		;
L8933:	ASL IntroSpr7YRise		;
L8936:*	LDX #$00			;
L8938:	JSR DoSpriteMovement		;($8963)Move sprite 0.
L893B:	LDX #$10			;
L893D:	JSR DoSpriteMovement		;($8963)Move sprite 1.
L8940:	LDX #$20			;
L8942:	JSR DoSpriteMovement		;($8963)Move sprite 2.
L8945:	LDX #$30			;
L8947:	LDA Second4Delay		;Check to see if the delay to start movement of the second-->
L8949:	BEQ +				;4 sprites has ended.  If so, start drawing those sprites.
L894B:	DEC Second4Delay		;
L894D:	BNE ++				;
L894F:*	JSR DoSpriteMovement		;($8963)Move sprite 3.
L8952:	LDX #$40			;
L8954:	JSR DoSpriteMovement		;($8963)Move sprite 4.
L8957:	LDX #$50			;
L8959:	JSR DoSpriteMovement		;($8963)Move sprite 5.
L895C:	LDX #$60			;
L895E:	JSR DoSpriteMovement		;($8963)Move sprite 6.
L8961:	LDX #$70			;($8963)Move sprite 7.

DoSpriteMovement:
L8963:*	LDA IntroSpr0Complete,X		;If the current sprite has finished-->
L8966:	BNE ++				;its movements, exit this routine.
L8968:	JSR UpdateSpriteCoords		;($981E)Calculate new sprite position.
L896B:	BCS +				;If sprite not at final position, branch to move next frame.
L896D:	LDA #$01			;Sprite movement complete.
L896F:	STA IntroSpr0Complete,X		;
L8972:*	JMP WriteIntroSprite		;($887B)Write sprite data to sprite RAM.
L8975:*	RTS				;

DrawCrossSprites:
L8976:	LDA DrawCross			;If not ready to draw crosshairs,-->
L8978:	BEQ ++++			;branch to exit.
L897A:	LDY CrossDataIndex		;
L897C:	CPY #$04			;Check to see if at last index in table.  If so, branch-->
L897E:	BCC +				;to draw cross sprites.
L8980:	BNE ++++			;If beyond last index, branch to exit.
L8982:	LDA #$00			;
L8984:	STA DrawCross			;If at last index, clear indicaor to draw cross sprites.
L8986:*	LDA CrossSpriteIndexTbl,Y	;
L8989:	STA $00				;
L898B:	LDY #$00			;Reset index into CrossSpriteDataTbl

L898D:*	LDX CrossSpriteDataTbl,Y	;Get offet into sprite RAM to load sprite.
L8990:	INY				;
L8991:*	LDA CrossSpriteDataTbl,Y	;Get sprite data byte.
L8994:	STA Sprite00RAM,X		;Store byte in sprite RAM.
L8997:	INX				;Move to next sprite RAM address.
L8998:	INY				;Move to next data byte in table.
L8999:	TXA				;
L899A:	AND #$03			;Is new sprite position reached?-->
L899C:	BNE -				;if not, branch to load next sprite data byte.
L899E:	CPY $00				;Has all the sprites been loaded for cross graphic?-->
L89A0:	BNE --				;If not, branch to load next set of sprite data.

L89A2:	LDA FrameCount			;
L89A4:	LSR				;Increment index into CrossSpriteIndexTbl every-->
L89A5:	BCC +				;other frame.  This updates the cross sprites-->
L89A7:	INC CrossDataIndex		;every two frames.
L89A9:*	RTS				;

;The following table tells the routine above how many data bytes to load from CrossSpriteDataTbl.
;The more data that is loaded, the bigger the cross that is drawn on the screen.  The table below
;starts the cross out small, it then grows bigger and gets small again.

CrossSpriteIndexTbl:
L89AA: .byte $05, $19, $41, $19, $05 

;The following table is used to find the data for the sparkle routine in the table below:

SparkleAddressTbl:
L89AF:	.word TopSparkleDataTbl		;($89B3)Table for top sparkle data.
L89B1:	.word BottomSparkleDataTbl	;($89E9)Table for bottom sparkle data.

;The following two tables are the data tables for controlling the movement of the sparkle sprites
;in the title routine.  Here's how thw data in the tables work: The first byte is a counter byte.
;It is loaded into a memory address and decremented every frame. Whilt that value is not 0, the
;second byte is used to change the sprite's x and y coordinates in the screen.  The upper 4 bits
;of the second byte are amount to change the y coordinates every frame.  If bit 7 is set, the
;y coordinates of the sprite are reduced every frame by the amount stored in bits 4,5 and 6. The
;lower 4 bits of the second byte are used to change the x coordinates of the sprite in the same
;manner.  If bit 3 is set, the x coordinates of the sprite are reduced every frame by the amount
;stored in bits 0, 1 and 2.
;Special case: If MSB of the first byte is set(in the case of this data, the first byte is #$FF),
;The counter byte is set to only 1 frame and the second byte contains only x coordinates to move
;the sprite.  The y coordinates do not change.  This allows 8 bytes to move the x coordinate
;instead of only 4.  This allows the sprite to "jump" across the edges of the letters. If the MSB
;of the second byte is set, the x coordinate of the sprite is decreased by the amount stored in
;the other seven bytes.

TopSparkleDataTbl:
L89B3:	.byte $01, $00
L89B5:	.byte $01, $00
L89B7:	.byte $01, $01
L89B9:	.byte $06, $00
L89BB:	.byte $07, $01
L89BD:	.byte $10, $01
L89BF:	.byte $03, $01
L89C1:	.byte $01, $00
L89C3:	.byte $01, $01
L89C5:	.byte $01, $00
L89C7:	.byte $01, $01
L89C9:	.byte $01, $00
L89CB:	.byte $09, $01
L89CD:	.byte $04, $00
L89CF:	.byte $27, $01
L89D1:	.byte $01, $00
L89D3:	.byte $01, $00
L89D5:	.byte $06, $01
L89D7:	.byte $01, $00
L89D9:	.byte $15, $01
L89DB:	.byte $06, $00
L89DD:	.byte $01, $01
L89DF:	.byte $08, $01
L89E1:	.byte $0E, $02
L89E3:	.byte $02, $03
L89E5:	.byte $06, $04
L89E7:	.byte $00, $00

BottomSparkleDataTbl:
L89E9:	.byte $01, $00
L89EB:	.byte $08, $09
L89ED:	.byte $01, $99
L89EF:	.byte $01, $09
L89F1:	.byte $01, $99
L89F3:	.byte $01, $09
L89F5:	.byte $01, $99
L89F7:	.byte $01, $09
L89F9:	.byte $01, $99
L89FB:	.byte $01, $09
L89FD:	.byte $01, $99
L89FF:	.byte $01, $09
L8A01:	.byte $01, $99
L8A03:	.byte $01, $09
L8A05:	.byte $01, $99
L8A07:	.byte $01, $09
L8A09:	.byte $01, $99
L8A0B:	.byte $01, $09
L8A0D:	.byte $01, $99
L8A0F:	.byte $01, $09
L8A11:	.byte $01, $99
L8A13:	.byte $01, $19
L8A15:	.byte $01, $11
L8A17:	.byte $01, $10
L8A19:	.byte $01, $11
L8A1B:	.byte $01, $10
L8A1D:	.byte $01, $11
L8A1F:	.byte $01, $10
L8A21:	.byte $01, $11
L8A23:	.byte $01, $10
L8A25:	.byte $01, $11
L8A27:	.byte $01, $10
L8A29:	.byte $01, $11
L8A2B:	.byte $01, $10
L8A2D:	.byte $01, $11
L8A2F:	.byte $01, $10
L8A31:	.byte $02, $11
L8A33:	.byte $01, $10
L8A35:	.byte $01, $11 
L8A37:	.byte $10, $09
L8A39:	.byte $FF, $EF			;MSB of first byte set. move sprite x pos -17 pixles.
L8A3B:	.byte $11, $09
L8A3D:	.byte $FF, $F3			;MSB of first byte set. move sprite x pos -13 pixles.
L8A3F:	.byte $1F, $09
L8A41:	.byte $FF, $EC			;MSB of first byte set. move sprite x pos -20 pixles.
L8A43:	.byte $0F, $09
L8A45:	.byte $FF, $ED			;MSB of first byte set. move sprite x pos -19 pixles. 
L8A47:	.byte $16, $09
L8A49:	.byte $00, $00

;The following table is used by the DrawCrossSprites routine to draw the sprites on the screen that
;make up the cross that appears during the Crosshairs routine.  The single byte is the index into
;the sprite RAM where the sprite data is to be written.  The 4 bytes that follow it are the actual
;sprite data bytes.

CrossSpriteDataTbl:
L8A4B:	.byte $10			;Load following sprite data into Sprite04RAM.
L8A4C:	.byte $5A, $C0, $00, $79	;Sprite data.
L8A50:	.byte $14			;Load following sprite data into Sprite05RAM.
L8A51:	.byte $52, $C8, $00, $79	;Sprite data.
L8A55:	.byte $18			;Load following sprite data into Sprite06RAM.
L8A56:	.byte $5A, $C2, $40, $71	;Sprite data.
L8A5A:	.byte $1C			;Load following sprite data into Sprite07RAM.
L8A5B:	.byte $5A, $C2, $00, $81	;Sprite data.
L8A5F:	.byte $20			;Load following sprite data into Sprite08RAM.
L8A60:	.byte $62, $C8, $80, $79	;Sprite data.
L8A64:	.byte $14			;Load following sprite data into Sprite05RAM.
L8A65:	.byte $52, $C9, $00, $79	;Sprite data.
L8A69:	.byte $18			;Load following sprite data into Sprite06RAM.
L8A6A:	.byte $5A, $C1, $00, $71	;Sprite data.
L8A6E:	.byte $1C			;Load following sprite data into Sprite07RAM.
L8A6F:	.byte $5A, $C1, $00, $81	;Sprite data.
L8A73:	.byte $20			;Load following sprite data into Sprite08RAM.
L8A74:	.byte $62, $C9, $00, $79	;Sprite data.
L8A78:	.byte $24			;Load following sprite data into Sprite09RAM.
L8A79:	.byte $4A, $C8, $00, $79	;Sprite data.
L8A7D:	.byte $28			;Load following sprite data into Sprite0ARAM.
L8A7E:	.byte $5A, $C2, $40, $69	;Sprite data.
L8A82:	.byte $2C			;Load following sprite data into Sprite0BRAM.
L8A83:	.byte $5A, $C2, $00, $89	;Sprite data.
L8A87:	.byte $30			;Load following sprite data into Sprite0CRAM.
L8A88:	.byte $6A, $C8, $80, $79 	;Sprite data.

LoadPalData:
L8A8C:	lDY PalDataIndex		;
L8A8E:	LDA PalSelectTbl,Y		;Chooses which set of palette data-->
L8A91:	CMP #$FF			;to load from the table below.
L8A93:	BEQ +				;
L8A95:	STA PalDataPending		;Prepare to write palette data.
L8A97:	INC PalDataIndex		;
L8A99:*	RTS 				;

;The table below is used by above routine to pick the proper palette.

PalSelectTbl:
L8A9A:	.byte $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0C, $FF

FlashIntroScreen:
L8AA7:	LDY ScreenFlashPalIndex		;Load index into table below.
L8AA9:	LDA ScreenFlashPalTbl,Y		;Load palette data byte.
L8AAC:	CMP #$FF			;Has the end of the table been reached?-->
L8AAE:	BNE +				;If not, branch.
L8AB0:	LDA #$00			;
L8AB2:	STA ScreenFlashPalIndex		;Clear screen flash palette index and reset-->
L8AB4:	STA FlashScreen			;screen flash control address.
L8AB6:	BEQ ++				;Branch always.
L8AB8:*	STA PalDataPending		;Store palette change data.
L8ABA:	INC ScreenFlashPalIndex		;Increment index into table below.
L8ABC:*	RTS				;

ScreenFlashPalTbl:
L8ABD:	.byte $11, $01, $11, $01, $11, $11, $01, $11, $01, $FF

;----------------------------------[ Intro star palette routines ]-----------------------------------

StarPalSwitch:
L8AC7:	LDA FrameCount			;
L8AC9:	AND #$0F			;Change star palette every 16th frame.
L8ACB:	BNE +				;
L8ACD:	LDA PPUStrIndex			;
L8AD0:	BEQ ++				;Is any other PPU data waiting? If so, exit.
L8AD2:*	RTS				;

L8AD3:*	LDA #$19			;
L8AD5:	STA $00				;Prepare to write to the sprite palette-->
L8AD7:	LDA #$3F			;starting at address $3F19.
L8AD9:	STA $01				;
L8ADB:	LDA IntroStarOffset		;Use only first 3 bits of byte since the pointer-->
L8ADD:	AND #$07			;table only has 8 entries.
L8ADF:	ASL				;*2 to find entry in IntroStarPntr table.
L8AE0:	TAY				; 
L8AE1:	LDA IntroStarPntr,Y		;Stores starting address of palette data to write-->
L8AE4:	STA $02				;into $02 and $03 from IntroStarPntr table.
L8AE6:	LDA IntroStarPntr+1,Y		;
L8AE9:	STA $03				;
L8AEB:	INC IntroStarOffset		;Increment index for next palette change.
L8AED:	JSR PrepPPUPaletteString	;($C37E)Prepare and write new palette data.
L8AF0:	LDA #$1D			;
L8AF2:	STA $00				;
L8AF4:	LDA #$3F			;Prepare another write to the sprite palette.-->
L8AF6:	STA $01				;This tie starting at address $3F1D.
L8AF8:	INY 				;
L8AF9:	JSR AddYToPtr02			;($C2B3)Find new data base of palette data.
L8AFC:	JMP PrepPPUPaletteString	;($C37E)Prepare and write new palette data.

;The following table is a list of pointers into the table below. It contains
;the palette data for the twinkling stars in the intro scene.  The palette data
;is changed every 16 frames by the above routine.

IntroStarPntr:
L8AFF:	.word $8B0F, $8B19, $8B23, $8B2D, $8B37, $8B41, $8B4B, $8B55

;The following table contains the platette data that is changed in the intro
;scene to give the stars a twinkling effect. All entries in the table are
;non-repeating. 

IntroStarPal:
L8B0F:	.byte $03, $0F, $02, $13, $00, $03, $00, $34, $0F, $00
L8B10:	.byte $03, $06, $01, $23, $00, $03, $0F, $34, $09, $00
L8B23:	.byte $03, $16, $0F, $23, $00, $03, $0F, $24, $1A, $00
L8B2D:	.byte $03, $17, $0F, $13, $00, $03, $00, $04, $28, $00
L8B37:	.byte $03, $17, $01, $14, $00, $03, $10, $0F, $28, $00
L8B41:	.byte $03, $16, $02, $0F, $00, $03, $30, $0F, $1A, $00
L8B4B:	.byte $03, $06, $12, $0F, $00, $03, $30, $04, $09, $00
L8B55:	.byte $03, $0F, $12, $14, $00, $03, $10, $24, $0F, $00

;----------------------------------------------------------------------------------------------------

DoFadeOut:
L8B5F:	LDY FadeDataIndex		;Load palette data from table below.
L8B61:	LDA FadeOutPalData,Y		;
L8B64:	CMP #$FF			;If palette data = #$FF, exit.
L8B66:	BEQ +				;
L8B68:	STA PalDataPending		;Store new palette data.
L8B6A:	INC FadeDataIndex		;
L8B6C:*	RTS				;

FadeOutPalData:
L8B6D:	.byte $0D, $0E, $0F, $10, $01, $FF

FadeInPalData:
L8B73:	.Byte $01, $10, $0F, $0E, $0D, $FF

;----------------------------------------[ Password routines ]---------------------------------------

ProcessUniqueItems:
L8B79:	LDA NumberOfUniqueItems		;
L8B7C:	STA $03				;Store NumberOfUniqueItems at $03.
L8B7E:	LDY #$00			;
L8B80:	STY $04				;Set $04 to #$00.
L8B82:*	LDY $04				;Use $04 at index into unique itme list.			
L8B84:	INY				;
L8B85:	LDA UniqueItemHistory-1,Y	;
L8B88:	STA $00				;Load the two bytes representing the aquired-->
L8B8A:	INY 				;Unique item and store them in $00 and $01.
L8B8B:	LDA UniqueItemHistory-1,Y	;
L8B8E:	STA $01				;
L8B90:	STY $04				;Increment $04 by two (load unique item complete).
L8B92:	JSR UniqueItemSearch		;($8B9C)Find unique item.
L8B95:	LDY $04				;
L8B97:	CPY $03				;If all unique items processed, return, else-->
L8B99:	BCC -				;branch to process next unique item.
L8B9B:	RTS				;

UniqueItemSearch:
L8B9C:	LDX #$00			;
L8B9E:*	TXA				;Transfer X to A(Item number).
L8B9F:	ASL				;Multiply by 2.
L8BA0:	TAY				;Store multiplied value in y.
L8BA1:	LDA ItemData,Y			;Load unique item reference starting at $9029(2 bytes).
L8BA4:	CMP $00				;
L8BA6:	BNE +				;
L8BA8:	LDA ItemData+1,Y		;Get next byte of unique item.
L8BAB:	CMP $01				;
L8BAD:	BEQ ++				;If unique item found, branch to UniqueItemFound.
L8BAF:*	INX				;
L8BB0:	CPX #$3C			;If the unque item is a Zeebetite, return-->
L8BB2:	BCC --				;else branch to find next unique item.
L8BB4:	RTS				;

;The following routine sets the item bits for aquired items in addresses $6988 thru $698E.-->
;Items 1 thru 7 masked in $6988, 8 thru 15 in $6989, etc.

UniqueItemFound:
L8BB5:*	TXA				;
L8BB6:	JSR Adiv8			;($C2C0)Divide by 8.
L8BB9:	STA $05				;Shifts 5 MSBs to LSBs of item # and saves results in $05.
L8BBB:	JSR Amul8			;($C2C6)Multiply by 8.
L8BBE:	STA $02				;Restores 5 MSBs of item # and drops 3 LSBs; saves in $02.
L8BC0:	TXA				;
L8BC1:	SEC				;
L8BC2:	SBC $02				;
L8BC4:	STA $06				;Remove 5 MSBs and stores 3 LSBs in $06.
L8BC6:	LDX $05				;
L8BC8:	LDA PasswordByte00,X		;
L8BCB:	LDY $06				;
L8BCD:	ORA PasswordBitmaskTbl,Y	;
L8BD0:	STA PasswordByte00,X		;Masks each unique item in the proper item address-->
L8BD3:	RTS				;(addresses $6988 thru $698E).
 
LoadUniqueItems:
L8BD4:	LDA #$00			;
L8BD6:	STA NumberOfUniqueItems		;
L8BD9:	STA $05				;$05 offset of password byte currently processing(0 thru 7).
L8BDB:	STA $06				;$06 bit of password byte currently processing(0 thru 7).
L8BDD:	LDA #$3B			;
L8BDF:	STA $07				;Maximum number of unique items(59 or #$3B).
L8BE1:	LDY $05				;
L8BE3:	LDA PasswordByte00,Y		;
L8BE6:	STA $08				;$08 stores contents of password byte currently processing.
L8BE8:	LDX #$00			;
L8BEA:	STX $09				;Stores number of unique items processed(#$0 thru #$3B).
L8BEC:	LDX $06				;
L8BEE:	BEQ ++				;If start of new byte, branch.

L8BF0:	LDX #$01			;
L8BF2:	STX $02				;
L8BF4:	CLC 				;
L8BF5:*	ROR 				;
L8BF6:	STA $08				;This code does not appear to ever be executed.
L8BF8:	LDX $02				;
L8BFA:	CPX $06				;
L8BFC:	BEQ +				;
L8BFE:	INC $02				;
L8C00:	JMP -				;

ProcessNextItem:
L8C03:	LDY $05				;Locates next password byte to process-->
L8C05:	LDA PasswordByte00,Y		;and loads it into $08.
L8C08:	STA $08				;

ProcessNewItemByte:
L8C0A:*	LDA $08				;
L8C0C:	ROR				;Rotates next bit to be processed to the carry flag.
L8C0D:	STA $08				;
L8C0F:	BCC +				;
L8C11:	JSR SamusHasItem		;($8C39)Store item in unique item history.
L8C14:*	LDY $06				;If last bit of item byte has been--> 
L8C16:	CPY #$07			;checked, move to next byte.
L8C18:	BCS +				;
L8C1A:	INC $06				;
L8C1C:	INC $09				;
L8C1E:	LDX $09				;If all 59 unique items have been--> 
L8C20:	CPX $07				;searched through, exit.
L8C22:	BCS ++				;
L8C24:	JMP ProcessNewItemByte		;($8C0A)Repeat routine for next item byte.
L8C27:*	LDY #$00			;
L8C29:	STY $06				;
L8C2B:	INC $05				;
L8C2D:	INC $09				;
L8C2F:	LDX $09				;If all 59 unique items have been--> 
L8C31:	CPX $07				;searched through, exit.
L8C33:	BCS +				;
L8C35:	JMP ProcessNextItem		;($8C03)Process next item.
L8C38:*	RTS				;
 
SamusHasItem:
L8C39:	LDA $05				;$05 becomes the upper part of the item offset-->
L8C3B:	JSR Amul8			;while $06 becomes the lower part of the item offset.
L8C3E:	CLC				;
L8C3F:	ADC $06				;
L8C41:	ASL				;* 2. Each item is two bytes in length.
L8C42:	TAY				;
L8C43:	LDA ItemData+1,Y		;
L8C46:	STA $01				;$00 and $01 store the two bytes of--> 
L8C48:	LDA ItemData,Y			;the unique item to process.
L8C4B:	STA $00				;
L8C4D:	LDY NumberOfUniqueItems		;
L8C50:	STA UniqueItemHistory,Y		;Store the two bytes of the unique item-->
L8C53:	LDA $01				;in RAM in the unique item history.
L8C55:	INY				; 
L8C56:	STA UniqueItemHistory,Y		;
L8C59:	INY				;
L8C5A:	STY NumberOfUniqueItems		;Keeps a running total of unique items.
L8C5D:	RTS				;

CheckPassword:
L8C5E:	JSR ConsolidatePassword		;($8F60)Convert password characters to password bytes.
L8C61:	JSR ValidatePassword		;($8DDE)Verify password is correct.
L8C64:	BCS +				;Branch if incorrect password.
L8C66:	JMP InitializeGame		;($92D4)Preliminary housekeeping before game starts.
L8C69:*	LDA MultiSFXFlag		;
L8C6C:	ORA #$01			;Set IncorrectPassword SFX flag.
L8C6E:	STA MultiSFXFlag		;
L8C71:	LDA #$0C			;
L8C73:	STA Timer3			;Set Timer3 time for 120 frames (2 seconds).
L8C75:	LDA #$18			;
L8C77:	STA TitleRoutine		;Run EnterPassword routine.
L8C79:	RTS				;

CalculatePassword:
L8C7A:	LDA #$00			;
L8C7C:	LDY #$0F			;Clears values at addresses -->
L8C7E:*	STA PasswordByte00,Y		;$6988 thru $6997 and -->
L8C81:	STA PasswordChar00,Y		;$699A thru $69A9.
L8C84:	DEY				;
L8C85:	BPL -				;
L8C87:	JSR ProcessUniqueItems		;($8B79)Determine what items Samus has collected.
L8C8A:	LDA PasswordByte07		;
L8C8D:	AND #$04			;Check to see if mother brain has been defeated,-->
L8C8F:	BEQ +				;If so, restore mother brain, zeebetites and-->
L8C91:	LDA #$00			;all missile doors in Tourian as punishment for-->
L8C93:	STA PasswordByte07		;dying after mother brain defeated. Only reset in the-->
L8C96:	LDA PasswordByte06		;password.  Continuing without resetting will not-->
L8C99:	AND #$03			;restore those items.
L8C9B:	STA PasswordByte06		;
L8C9E:*	LDA InArea			;Store InArea in bits 0 thru 5 in-->
L8CA0:	AND #$3F			;address $6990.
L8CA2:	LDY JustInBailey		;
L8CA5:	BEQ +				;
L8CA7:	ORA #$80			;Sets MSB of $6990 is Samus is suitless.
L8CA9:*	STA PasswordByte08		;
L8CAC:	LDA SamusGear			;
L8CAF:	STA PasswordByte09		;SamusGear stored in $6991.
L8CB2:	LDA MissileCount		;
L8CB5:	STA PasswordByte0A		;MissileCount stored in $6992.
L8CB8:	LDA #$00			;
L8CBA:	STA $00				;
L8CBC:	LDA KraidStatueStatus		;
L8CBF:	AND #$80			;
L8CC1:	BEQ +				;If statue not up, branch.
L8CC3:	LDA $00				;
L8CC5:	ORA #$80			;Set bit 7 of $00--> 
L8CC7:	STA $00				;if Kraid statue up.
L8CC9:*	LDA KraidStatueStatus		;
L8CCC:	AND #$01			;
L8CCE:	BEQ +				;Branch if Kraid not yet defeated.
L8CD0:	LDA $00				;
L8CD2:	ORA #$40			;Set bit 6 of $00-->
L8CD4:	STA $00				;If Kraid defeated.
L8CD6:*	LDA RidleyStatueStatus		;
L8CD9:	AND #$80			;
L8CDB:	BEQ +				;Branch if Ridley statue not up.
L8CDD:	LDA $00				;
L8CDF:	ORA #$20			;Set bit 5 of $00-->
L8CE1:	STA $00				;if Ridley statue up.
L8CE3:*	LDA RidleyStatueStatus		;
L8CE6:	AND #$02			;
L8CE8:	BEQ +				;Branch if Ridley not yet defeated.
L8CEA:	LDA $00				;
L8CEC:	ORA #$10			;Set bit 4 of $00-->
L8CEE:	STA $00				;if Ridley defeated.
L8CF0:*	LDA $00				;
L8CF2:	STA PasswordByte0F		;Stores statue statuses in 4 MSB at $6997.
L8CF5:	LDY #$03			;
L8CF7:*	LDA SamusAge,Y			;Store SamusAge in $6993,-->
L8CFA:	STA PasswordByte0B,Y		;SamusAge+1 in $6994 and-->
L8CFD:	DEY 				;SamusAe+2 in $6995.
L8CFE:	BPL -				;
L8D00:*	JSR $C000			;
L8D03:	LDA RandomNumber1		;
L8D05:	AND #$0F			;Store the value of $2E at $6998-->
L8D07:	BEQ -				;When any of the 4 LSB are set. (Does not-->
L8D09:	STA PasswordByte10		;allow RandomNumber1 to be a multiple of 16).
L8D0C:	JSR PasswordChecksumAndScramble	;($8E17)Calculate checksum and scramble password.
L8D0F:	JMP LoadPasswordChar		;($8E6C)Calculate password characters.

LoadPasswordData:
L8D12:	LDA NARPASSWORD			;If invincible Samus active, skip-->
L8D15:	BNE +++				;further password processing.
L8D17:	JSR LoadUniqueItems		;($8BD4)Load unique items from password.
L8D1A:	JSR LoadTanksAndMissiles	;($8D3D)Calculate number of missiles from password.
L8D1D:	LDY #$00			;
L8D1F:	LDA PasswordByte08		;If MSB in PasswordByte08 is set,-->
L8D22:	AND #$80			;Samus is not wearing her suit.
L8D24:	BEQ +				;			
L8D26:	INY 				;
L8D27:*	STY JustInBailey		;
L8D2A:	LDA PasswordByte08		;Extract first 5 bits from PasswordByte08-->
L8D2D:	AND #$3F			;and use it to determine starting area.
L8D2F:	STA InArea			;
L8D31:	LDY #$03			;
L8D33:*	LDA PasswordByte0B,Y		;Load Samus' age.
L8D36:	STA SamusAge,Y			;
L8D39:	DEY				;
L8D3A:	BPL -				;Loop to load all 3 age bytes.
L8D3C:*	RTS				;
 
LoadTanksAndMissiles:
L8D3D:	LDA PasswordByte09		;Loads Samus gear.
L8D40:	STA SamusGear			;Save Samus gear.
L8D43:	LDA PasswordByte0A		;Loads current number of missiles.
L8D46:	STA MissileCount		;Save missile count.
L8D49:	LDA #$00			;
L8D4B:	STA $00				;
L8D4D:	STA $02				;
L8D4F:	LDA PasswordByte0F		;
L8D52:	AND #$80			;If MSB is set, Kraid statue is up.
L8D54:	BEQ +				;
L8D56:	LDA $00				;
L8D58:	ORA #$80			;If Kraid statue is up, set MSB in $00.
L8D5A:	STA $00				;
L8D5C:*	LDA PasswordByte0F		;
L8D5F:	AND #$40			;If bit 6 is set, Kraid is defeated.
L8D61:	BEQ +				;
L8D63:	LDA $00				;
L8D65:	ORA #$01			;If Kraid is defeated, set LSB in $00.
L8D67:	STA $00				;
L8D69:*	LDA $00				;
L8D6B:	STA KraidStatueStatus		;Store Kraid status.
L8D6E:	LDA PasswordByte0F		;
L8D71:	AND #$20			;If bit 5 is set, Ridley statue is up.
L8D73:	BEQ +				;
L8D75:	LDA $02				;
L8D77:	ORA #$80			;If Ridley statue is up, set MSB in $02.
L8D79:	STA $02				;
L8D7B:*	LDA PasswordByte0F		;
L8D7E:	AND #$10			;If bit 4 is set, Ridley is defeated.
L8D80:	BEQ +				;
L8D82:	LDA $02				;
L8D84:	ORA #$02			;If Ridley is defeated, set bit 1 of $02.
L8D86:	STA $02				;
L8D88:*	LDA $02				;
L8D8A:	STA RidleyStatueStatus		;Store Ridley status.
L8D8D:	LDA #$00			;
L8D8F:	STA $00				;
L8D91:	STA $02				;
L8D93:	LDY #$00			;
L8D95:*	LDA UniqueItemHistory+1,Y	;Load second byte of item and compare-->
L8D98:	AND #$FC			;the 6 MSBs to #$20. If it matches,-->  
L8D9A:	CMP #$20			;an energy tank has been found.
L8D9C:	BNE +				;
L8D9E:	INC $00				;Increment number of energy tanks found.
L8DA0:	JMP IncrementToNextItem		;
L8DA3:*	CMP #$24			;Load second byte of item and compare the 6 MSBs to-->
L8DA5:	BNE +				;#$24. If it matches, missiles have been found.
L8DA7:	INC $02				;Increment number of missiles found.

IncrementToNextItem:
L8DA9:*	INY				;
L8DAA:	INY				;Increment twice. Each item is 2 bytes.
L8DAB:	CPY #$84			;7 extra item slots in unique item history.
L8DAD:	BCC ---				;Loop until all unique item history checked.
L8DAF:	LDA $00				;
L8DB1:	CMP #$06			;Ensure the Tank Count does not exceed 6-->
L8DB3:	BCC +				;tanks. Then stores the number of-->
L8DB5:	LDA #$06			;energy tanks found in TankCount.
L8DB7:*	STA TankCount			;
L8DBA:	LDA #$00			;
L8DBC:	LDY $02				;
L8DBE:	BEQ ++				;Branch if no missiles found.
L8DC0:	CLC				;
L8DC1:*	ADC #$05			;
L8DC3:	DEY 				;For every missile item found, this-->
L8DC4:	BNE -				;loop adds 5 missiles to MaxMissiles.
L8DC6:*	LDY KraidStatueStatus		;
L8DC9:	BEQ +				;
L8DCB:	ADC #$4B			;75 missiles are added to MaxMissiles-->
L8DCD:	BCS ++				;if Kraid has been defeated and another-->
L8DCF:*	LDY RidleyStatueStatus		;75 missiles are added if the ridley--> 
L8DD2:	BEQ ++				;has been defeated.
L8DD4:	ADC #$4B			;
L8DD6:	BCC ++				;
L8DD8:*	LDA #$FF			;If number of missiles exceeds 255, it stays at 255.
L8DDA:*	STA MaxMissiles			;
L8DDD:	RTS				;

ValidatePassword:
L8DDE:	LDA NARPASSWORD			;
L8DE1:	BNE ++				;If invincible Samus already active, branch.
L8DE3:	LDY #$0F			;
L8DE5:*	LDA PasswordChar00,Y		;
L8DE8:	CMP NARPASSWORDTbl,Y		;If NARPASSWORD was entered at the-->
L8DEB:	BNE +				;password screen, activate invincible-->
L8DED:	DEY 				;Samus, else continue to process password.
L8DEE:	BPL -				;
L8DF0:	LDA #$01			;
L8DF2:	STA NARPASSWORD			;
L8DF5:	BNE ++				;
L8DF7:*	JSR UnscramblePassword		;($8E4E)Unscramble password.
L8DFA:	JSR PasswordChecksum		;($8E21)Calculate password checksum.
L8DFD:	CMP PasswordByte11		;Verify proper checksum.
L8E00:	BEQ +				;
L8E02:	SEC				;If password is invalid, sets carry flag.
L8E03:	BCS ++				;
L8E05:*	CLC				;If password is valid, clears carry flag.
L8E06:*	RTS				;

;The table below is used by the code above. It checks to see if NARPASSWORD has been entered.
;NOTE: any characters after the 16th character will be ignored if the first 16 characters
;match the values below.

NARPASSWORDTbl:
L8E07:	.byte $17			;N
L8E08:	.byte $0A			;A
L8E09:	.byte $1B			;R
L8E0A:	.byte $19			;P
L8E0B:	.byte $0A			;A
L8E0C:	.byte $1C			;S
L8E0D:	.byte $1C			;S
L8E0E:	.byte $20			;W
L8E0F:	.byte $18			;O
L8E10:	.byte $1B			;R
L8E11:	.byte $0D			;D
L8E12:	.byte $00			;0(or no entry).
L8E13:	.byte $00			;0(or no entry).
L8E14:	.byte $00			;0(or no entry).
L8E15:	.byte $00			;0(or no entry).
L8E16:	.byte $00			;0(or no entry).

PasswordChecksumAndScramble:
L8E17:	JSR PasswordChecksum		;($8E21)Store the combined added value of-->
L8E1A:	STA PasswordByte11		;addresses $6988 thu $6998 in $6999.
L8E1D:	JSR PasswordScramble		;($8E2D)Scramble password.
L8E20:	RTS				;
 
PasswordChecksum:
L8E21:	LDY #$10			;
L8E23:	LDA #$00			;
L8E25:*	CLC 				;Add the values at addresses-->
L8E26:	ADC PasswordByte00,Y		;$6988 thru $6998 together.
L8E29:	DEY 				;
L8E2A:	BPL -				;
L8E2C:	RTS				;
 
PasswordScramble:
L8E2D:	LDA PasswordByte10		;
L8E30:	STA $02				;
L8E32:*	LDA PasswordByte00		;Store contents of $6988 in $00 for-->
L8E35:	STA $00				;further processing after rotation.
L8E37:	LDX #$00			;
L8E39:	LDY #$0F			;
L8E3B:*	ROR PasswordByte00,X		;Rotate right, including carry, all values in-->
L8E3E:	INX 				;addresses $6988 thru $6997.
L8E3F:	DEY 				;
L8E40:	BPL -				;
L8E42:	ROR $00				;Rotate right $6988 to ensure the LSB-->
L8E44:	LDA $00				;from address $6997 is rotated to the-->
L8E46:	STA PasswordByte00		;MSB of $6988.
L8E49:	DEC $02				;
L8E4B:	BNE --				;Continue rotating until $02 = 0.
L8E4D:	RTS				;

UnscramblePassword:
L8E4E:	LDA PasswordByte10		;Stores random number used to scramble the password.
L8E51:	STA $02				;
L8E53:*	LDA PasswordByte0F		;Preserve MSB that may have been rolled from $6988.
L8E56:	STA $00				;
L8E58:	LDX #$0F			;
L8E5A:*	ROL PasswordByte00,X		;The following loop rolls left the first 16 bytes-->
L8E5D:	DEX 				;of the password one time.
L8E5E:	BPL -				;
L8E60:	ROL $00				;Rolls byte in $6997 to ensure MSB from $6988 is not lost.
L8E62:	LDA $00				;
L8E64:	STA PasswordByte0F		;
L8E67:	DEC $02				;
L8E69:	BNE --				;Loop repeats the number of times decided by the random-->
L8E6B:	RTS 				;number in $6998 to properly unscramble the password.

;The following code takes the 18 password bytes and converts them into 24 characters
;to be displayed to the player as the password.  NOTE: the two MSBs will always be 0.

LoadPasswordChar:
L8E6C:	LDY #$00			;Password byte #$00.
L8E6E:	JSR SixUpperBits		;($8F2D)
L8E71:	STA PasswordChar00		;Store results.
L8E74:	LDY #$00			;Password bytes #$00 and #$01.
L8E76:	JSR TwoLowerAndFourUpper	;($8F33)
L8E79:	STA PasswordChar01		;Store results.
L8E7C:	LDY #$01			;Password bytes #$01 and #$02.
L8E7E:	JSR FourLowerAndTwoUpper	;($8F46)
L8E81:	STA PasswordChar02		;Store results.
L8E84:	LDY #$02			;Password byte #$02.
L8E86:	JSR SixLowerBits		;($8F5A)
L8E89:	STA PasswordChar03		;Store results.
L8E8C:	LDY #$03			;Password byte #$03.
L8E8E:	JSR SixUpperBits		;($8F2D)
L8E91:	STA PasswordChar04		;Store results.
L8E94:	LDY #$03			;Password bytes #$03 and #$04.
L8E96:	JSR TwoLowerAndFourUpper	;($8F33)
L8E99:	STA PasswordChar05		;Store results.
L8E9C:	LDY #$04			;Password bytes #$04 and #$05.
L8E9E:	JSR FourLowerAndTwoUpper	;($8F46)
L8EA1:	STA PasswordChar06		;Store results.
L8EA4:	LDY #$05			;Password byte #$05.
L8EA6:	JSR SixLowerBits		;($8F5A)
L8EA9:	STA PasswordChar07		;Store results.
L8EAC:	LDY #$06			;Password byte #$06.
L8EAE:	JSR SixUpperBits		;($8F2D)
L8EB1:	STA PasswordChar08		;Store results.
L8EB4:	LDY #$06			;Password bytes #$06 and #$07.
L8EB6:	JSR TwoLowerAndFourUpper	;($8F33)
L8EB9:	STA PasswordChar09		;Store results.
L8EBC:	LDY #$07			;Password bytes #$07 and #$08.
L8EBE:	JSR FourLowerAndTwoUpper	;($8F46)
L8EC1:	STA PasswordChar0A		;Store results.
L8EC4:	LDY #$08			;Password byte #$08.
L8EC6:	JSR SixLowerBits		;($8F5A)
L8EC9:	STA PasswordChar0B		;Store results.
L8ECC:	LDY #$09			;Password byte #$09.
L8ECE:	JSR SixUpperBits		;($8F2D)
L8ED1:	STA PasswordChar0C		;Store results.
L8ED4:	LDY #$09			;Password bytes #$09 and #$0A.
L8ED6:	JSR TwoLowerAndFourUpper	;($8F33)
L8ED9:	STA PasswordChar0D		;Store results.
L8EDC:	LDY #$0A			;Password bytes #$0A and #$0B.
L8EDE:	JSR FourLowerAndTwoUpper	;($8F46)
L8EE1:	STA PasswordChar0E		;Store results.
L8EE4:	LDY #$0B			;Password byte #$0B.
L8EE6:	JSR SixLowerBits		;($8F5A)
L8EE9:	STA PasswordChar0F		;Store results.
L8EEC:	LDY #$0C			;Password byte #$0C.
L8EEE:	JSR SixUpperBits		;($8F2D)
L8EF1:	STA PasswordChar10		;Store results.
L8EF4:	LDY #$0C			;Password bytes #$0C and #$0D.
L8EF6:	JSR TwoLowerAndFourUpper	;($8F33)
L8EF9:	STA PasswordChar11		;Store results.
L8EFC:	LDY #$0D			;Password bytes #$0D and #$0E.
L8EFE:	JSR FourLowerAndTwoUpper	;($8F46)
L8F01:	STA PasswordChar12		;Store results.
L8F04:	LDY #$0E			;Password byte #$0E.
L8F06:	JSR SixLowerBits		;($8F5A)
L8F09:	STA PasswordChar13		;Store results.
L8F0C:	LDY #$0F			;Password byte #$0F.
L8F0E:	JSR SixUpperBits		;($8F2D)
L8F11:	STA PasswordChar14		;Store results.
L8F14:	LDY #$0F			;Password bytes #$0F and #$10.
L8F16:	JSR TwoLowerAndFourUpper	;($8F33)
L8F19:	STA PasswordChar15		;Store results.
L8F1C:	LDY #$10			;Password bytes #$10 and #$11.
L8F1E:	JSR FourLowerAndTwoUpper	;($8F46)
L8F21:	STA PasswordChar16		;Store results.
L8F24:	LDY #$11			;Password byte #$11.
L8F26:	JSR SixLowerBits		;($8F5A)
L8F29:	STA PasswordChar17		;Store results.
L8F2C:	RTS				;

SixUpperBits:
L8F2D:	LDA PasswordByte00,Y		;Uses six upper bits to create a new byte.-->
L8F30:	LSR				;Bits are right shifted twice and two lower-->
L8F31:	LSR				;bits are discarded.
L8F32:	RTS				;
 
TwoLowerAndFourUpper:
L8F33:	LDA PasswordByte00,Y		;
L8F36:	AND #$03			;Saves two lower bits and stores them-->
L8F38:	JSR Amul16			;($C2C5)in bits 4 and 5.
L8F3B:	STA $00				;
L8F3D:	LDA PasswordByte01,Y		;Saves upper 4 bits and stores them-->
L8F40:	JSR Adiv16			;($C2BF)bits 0, 1, 2 and 3.
L8F43:	ORA $00				;Add two sets of bits together to make a byte-->
L8F45:	RTS				;where bits 6 and 7 = 0.
 
FourLowerAndTwoUpper:
L8F46:	LDA PasswordByte00,Y		;
L8F49:	AND #$0F			;Keep lower 4 bits.
L8F4B:	ASL				;Move lower 4 bits to bits 5, 4, 3 and 2.
L8F4C:	ASL				;
L8F4D:	STA $00				;
L8F4F:	LDA PasswordByte01,Y		;Move upper two bits-->
L8F52:	ROL				;to bits 1 and 0.
L8F53:	ROL				;
L8F54:	ROL				;
L8F55:	AND #$03			;Add two sets of bits together to make a byte-->	
L8F57:	ORA $00				;where bits 6 and 7 = 0.
L8F59:	RTS				;

SixLowerBits:
L8F5A:	LDA PasswordByte00,Y		;Discard bits 6 and 7.
L8F5D:	AND #$3F			;
L8F5F:	RTS 

;The following routine converts the 24 user entered password characters into the 18 password
;bytes used by the program to store Samus' stats and unique item history.

ConsolidatePassword:
L8F60:	LDY #$00			;Password characters #$00 and #$01.
L8F62:	JSR SixLowerAndTwoUpper		;($8FF1)
L8F65:	STA PasswordByte00		;Store results.
L8F68:	LDY #$01			;Password characters #$01 and #$02.
L8F6A:	JSR FourLowerAndFiveThruTwo	;($9001)
L8F6D:	STA PasswordByte01		;Store results.
L8F70:	LDY #$02			;Password characters #$02 and #$03.
L8F72:	JSR TwoLowerAndSixLower		;($9011)
L8F75:	STA PasswordByte02		;Store results.
L8F78:	LDY #$04			;Password characters #$04 and #$05.
L8F7A:	JSR SixLowerAndTwoUpper		;($8FF1)
L8F7D:	STA PasswordByte03		;Store results.
L8F80:	LDY #$05			;Password characters #$05 and #$05.
L8F82:	JSR FourLowerAndFiveThruTwo	;($9001)
L8F85:	STA PasswordByte04		;Store results.
L8F88:	LDY #$06			;Password characters #$06 and #$07.
L8F8A:	JSR TwoLowerAndSixLower		;($9011)
L8F8D:	STA PasswordByte05		;Store results.
L8F90:	LDY #$08			;Password characters #$08 and #$09.
L8F92:	JSR SixLowerAndTwoUpper		;($8FF1)
L8F95:	STA PasswordByte06		;Store results.
L8F98:	LDY #$09			;Password characters #$09 and #$0A.
L8F9A:	JSR FourLowerAndFiveThruTwo	;($9001)
L8F9D:	STA PasswordByte07		;Store results.
L8FA0:	LDY #$0A			;Password characters #$0A and #$0B.
L8FA2:	JSR TwoLowerAndSixLower		;($9011)
L8FA5:	STA PasswordByte08		;Store results.
L8FA8:	LDY #$0C			;Password characters #$0C and #$0D.
L8FAA:	JSR SixLowerAndTwoUpper		;($8FF1)
L8FAD:	STA PasswordByte09		;Store results.
L8FB0:	LDY #$0D			;Password characters #$0D and #$0E.
L8FB2:	JSR FourLowerAndFiveThruTwo	;($9001)
L8FB5:	STA PasswordByte0A		;Store results.
L8FB8:	LDY #$0E			;Password characters #$0E and #$0F.
L8FBA:	JSR TwoLowerAndSixLower		;($9011)
L8FBD:	STA PasswordByte0B		;Store results.
L8FC0:	LDY #$10			;Password characters #$10 and #$11.
L8FC2:	JSR SixLowerAndTwoUpper		;($8FF1)
L8FC5:	STA PasswordByte0C		;Store results.
L8FC8:	LDY #$11			;Password characters #$11 and #$12.
L8FCA:	JSR FourLowerAndFiveThruTwo	;($9001)
L8FCD:	STA PasswordByte0D		;Store results.
L8FD0:	LDY #$12			;Password characters #$12 and #$13.
L8FD2:	JSR TwoLowerAndSixLower		;($9011)
L8FD5:	STA PasswordByte0E		;Store results.
L8FD8:	LDY #$14			;Password characters #$15 and #$15.
L8FDA:	JSR SixLowerAndTwoUpper		;($8FF1)
L8FDD:	STA PasswordByte0F		;Store results.
L8FE0:	LDY #$15			;Password characters #$15 and #$16.
L8FE2:	JSR FourLowerAndFiveThruTwo	;($9001)
L8FE5:	STA PasswordByte10		;Store results.
L8FE8:	LDY #$16			;Password characters #$16 and #$17.
L8FEA:	JSR TwoLowerAndSixLower		;($9011)
L8FED:	STA PasswordByte11		;Store results.
L8FF0:	RTS				;

SixLowerAndTwoUpper:
L8FF1:	LDA PasswordChar00,Y		;Remove upper two bits and transfer-->
L8FF4:	ASL				;lower six bits to upper six bits.
L8FF5:	ASL				;
L8FF6:	STA $00				;
L8FF8:	LDA PasswordChar01,Y		;Move bits 4and 5 to lower two-->
L8FFB:	JSR Adiv16			;($C2BF)bits and discard the rest.
L8FFE:	ORA $00				;Combine the two bytes together.
L9000:	RTS				;

FourLowerAndFiveThruTwo:
L9001:	LDA PasswordChar00,Y		;Take four lower bits and transfer-->
L9004:	JSR Amul16			;($C2C5)them to upper four bits. Discard the rest.
L9007:	STA $00				;
L9009:	LDA PasswordChar01,Y		;Remove two lower bits and transfer-->
L900C:	LSR				;bits 5 thru 2 to lower four bits. 
L900D:	LSR				;
L900E:	ORA $00				;Combine the two bytes together.
L9010:	RTS				;
 
TwoLowerAndSixLower:
L9011:	LDA PasswordChar00,Y		;Shifts two lower bits to two higest bits-->
L9014:	ROR 				;and discards the rest
L9015:	ROR 				;
L9016:	ROR 				;
L9017:	AND #$C0			;
L9019:	STA $00				;
L901B:	LDA PasswordChar01,Y		;Add six lower bits to previous results.
L901E:	ORA $00				;
L9020:	RTS				;

PasswordBitmaskTbl:
L9021:	.byte $01, $02, $04, $08, $10, $20, $40, $80

;The following table contains the unique items in the game.  The two bytes can be deciphered
;as follows:IIIIIIXX XXXYYYYY. I = item type, X = X coordinate on world map, Y = Y coordinate
;on world map.  The items have the following values of IIIIII:
;High jump     = 000001
;Long beam     = 000010 (Not considered a unique item).
;Screw attack  = 000011
;Maru Mari     = 000100
;Varia suit    = 000101
;Wave beam     = 000110 (Not considered a unique item).
;Ice beam      = 000111 (Not considered a unique item).
;Energy tank   = 001000
;Missiles      = 001001
;Missile door  = 001010
;Bombs         = 001100
;Mother brain  = 001110
;1st Zeebetite = 001111
;2nd Zeebetite = 010000
;3rd Zeebetite = 010001
;4th Zeebetite = 010010
;5th Zeebetite = 010011

ItemData:
L9029:	.word $104E			;Maru Mari at coord 02,0E                    (Item 0)
L902B:	.word $264B			;Missiles at coord 12,0B                     (Item 1)
L902D:	.word $28E5			;Red door to long beam at coord 07,05        (Item 2)
L902F:	.word $2882			;Red door to Tourian elevator at coord 05,02 (Item 3)
L9031:	.word $2327			;Energy tank at coord 19,07                  (Item 4)
L9033:	.word $2B25			;Red door to bombs at coord 1A,05            (Item 5)
L9035:	.word $0325			;Bombs at coord 19,05                        (Item 6)
L9037:	.word $2A69			;Red door to ice beam at coord 13,09         (Item 7)
L9039:	.word $2703			;Missiles at coord 18,03                     (Item 8)
L903B:	.word $2363			;Energy tank at coord 1B,03                  (Item 9)
L903D:	.word $29E2			;Red door to varia suit at coord 0F,02       (Item 10)
L903F:	.word $15E2			;Varia suit at coord 0F,02                   (Item 11)
L9041:	.word $212E			;Energy tank at coord 09,0E                  (Item 12)
L9043:	.word $264E			;Missiles at coord 12,0E                     (Item 13)
L9045:	.word $262F			;Missiles at coord 11,0F                     (Item 14)
L9047:	.word $2B4C			;Red door to ice beam at coord 1B,0C         (Item 15)
L9049:	.word $276A			;Missiles at coord 1B,0A                     (Item 16)
L904B:	.word $278A			;Missiles at coord 1C,0A                     (Item 17)
L904D:	.word $278B			;Missiles at coord 1C,0B                     (Item 18)
L904F:	.word $276B			;Missiles at coord 1B,0B                     (Item 19)
L9051:	.word $274B			;Missiles at coord 1A,0B                     (Item 20)
L9053:	.word $268F			;Missiles at coord 14,0F                     (Item 21)
L9055:	.word $266F			;Missiles at coord 13,0F                     (Item 22)
L9057:	.word $2B71			;Red door to high jump at coord 1C,11        (Item 23)
L9059:	.word $0771			;High jump at coord 1B,11                    (Item 24)
L905B:	.word $29F0			;Red door to screw attack at coord 0E,10     (Item 25)
L905D:	.word $0DF0			;Screw attack at coord 0D,1D                 (Item 26)
L905F:	.word $2676			;Missiles at coord 13,16                     (Item 27)
L9061:	.word $2696			;Misslies at coord 14,16                     (Item 28)
L9063:	.word $2A55			;Red door to wave beam at coord 1C,15        (Item 29)
L9065:	.word $2353			;Energy tank at coord 1A,13                  (Item 30)
L9067:	.word $2794			;Missiles at coord 1C,14                     (Item 31)
L9069:	.word $28F5			;Red door at coord 07,15                     (Item 32)
L906B:	.word $2535			;Missiles at coord 09,15                     (Item 33)
L906D:	.word $2495			;Missiles at coord 04,15                     (Item 34)
L906F:	.word $28F6			;Red door at coord 07,16                     (Item 35)
L9071:	.word $2156			;Energy tank at coord 0A,16                  (Item 36)
L9073:	.word $28F8			;Red door at coord 07,18                     (Item 37)
L9075:	.word $287B			;Red door at coord 03,1B                     (Item 38)
L9077:	.word $24BB			;Missiles at coord 05,1B                     (Item 39)
L9079:	.word $2559			;Missiles at coord 0A,19                     (Item 40)
L907B:	.word $291D			;Red door to Kraid at coord 08,1D            (Item 41)
L907D:	.word $211D			;Energy tank at coord 08,1D(Kraid's room)    (Item 42)
L907F:	.word $2658			;Missiles at coord 12,18                     (Item 43)
L9081:	.word $2A39			;Red door at coord 11,19                     (Item 44)
L9083:	.word $2239			;Energy tank at coord 11,19                  (Item 45)
L9085:	.word $269E			;Missiles at coord 14,1E                     (Item 46)
L9087:	.word $2A1D			;purple door at coord 10,1D(Ridley's room)   (Item 47)
L9089:	.word $21FD			;Energy tank at coord 0F,1D                  (Item 48)
L908B:	.word $271B			;Missile at coord 18,1B                      (Item 49)
L908D:	.word $2867			;Orange door at coord 03,07                  (Item 50)
L908F:	.word $2927			;Red door at coord 09,07                     (Item 51)
L9091:	.word $292B			;Red door at coord 0A,0B                     (Item 52)
L9093:	.word $3C00			;1st Zeebetite in mother brain room          (Item 53)
L9095:	.word $4000			;2nd Zeebetite in mother brain room          (Item 54)
L9097:	.word $4400			;3rd Zeebetite in mother brain room          (Item 55)
L9099:	.word $4800			;4th Zeebetite in mother brain room          (Item 56)
L909B:	.word $4C00			;5th Zeebetite in mother brain room          (Item 57)
L909D:	.word $3800			;Mother brain                                (Item 58)

ClearAll:
L909F:	jsr ScreenOff			;($C439)Turn screen off.
L90A2:	jsr ClearNameTables		;Turn off screen, clear sprites and name tables.
L90A5:	jsr EraseAllSprites		;
L90A8:	lda PPUCNT0ZP			;Set Name table address to $2000.
L90AA:	and #$FC			;
L90AC:	sta PPUCNT0ZP			;
L90AE:	lda #$00			;
L90B0:	sta ScrollY			;Reset scroll offsets.
L90B2:	sta ScrollX			;
L90B4:	jsr WaitNMIPass			;($C42C)Wait for NMI to end.
L90B7:	jmp VBOffAndHorzWrite		;($C47D)Set PPU for horizontal write and turn off VBlank.

StartContinueScreen:
L90BA:	jsr ClearAll			;($909F)Turn off screen, erase sprites and nametables.
L90BD:	ldx #$84			;Low address for PPU write.
L90BF:	ldy #$99			;High address for PPU write.
L90C1:	jsr PreparePPUProcess		;($9449)Clears screen and writes "START CONTINUE".
L90C4:	LDY #$00			;
L90C6:	STY StartContinue		;Set selection sprite at START.
L90C9:	LDA #$0D			;
L90CB:	STA PalDataPending		;Change palette and title routine.
L90CD:	LDA #$16			;Next routine is ChooseStartContinue.
L90CF:	STA TitleRoutine		;

TurnOnDisplay:
L90D1:	JSR NMIOn			;($C487)Turn on the nonmaskable interrupt.
L90D4:	JMP ScreenOn			;($C447)Turn screen on.

ChooseStartContinue:
L90D7:	LDA Joy1Change			;
L90D9:	AND #$30			;Checks both select and start buttons.
L90DB:	CMP #$10			;Check if START has been pressed.
L90DD:	BNE ++				;Branch if START not pressed.
L90DF:	LDY StartContinue		;
L90E2:	BNE +				;if CONTINUE selected, branch.
L90E4:	JMP InitializeStats		;($932B)Zero out all stats.
L90E7:*	LDY #$17			;Next routine is LoadPasswordScreen.
L90E9:	STY TitleRoutine		;
L90EB:*	CMP #$20			;check if SELECT has been pressed.
L90ED:	BNE +				;Branch if SELECT not pressed.
L90EF:	LDA StartContinue		;
L90F2:	EOR #$01			;Chooses between START and CONTINUE-->
L90F4:	STA StartContinue		;on game select screen.
L90F7:	LDA TriangleSFXFlag		;
L90FA:	ORA #$08			;Set SFX flag for select being pressed.-->
L90FC:	STA TriangleSFXFlag		;Uses triangle channel.
L90FF:*	LDY StartContinue		;
L9102:	LDA StartContTbl,Y		;Get y pos of selection sprite.
L9105:	STA Sprite00RAM			;
L9108:	LDA #$6E			;Load sprite info for square selection sprite.
L910A:	STA Sprite00RAM+1		;
L910D:	LDA #$03			;
L910F:	STA Sprite00RAM+2		;
L9112:	LDA #$50			;Set data for selection sprite.
L9114:	STA Sprite00RAM+3		;
L9117:	RTS				;

StartContTbl:
L9118:	.byte $60			;Y sprite position for START.
L9119:	.byte $78			;Y sprite position for CONTINUE.

LoadPasswordScreen:
L911A:	JSR ClearAll			;($909F)Turn off screen, erase sprites and nametables.
L911D:	LDX #$E3			;Loads PPU with info to display-->
L911F:	LDY #$99			;PASS WORD PLEASE.
L9121:	JSR PreparePPUProcess		;($9449)Load "PASSWORD PLEASE" on screen.
L9124:	JSR InitGFX7			;($C6D6)Loads the font for the password.
L9127:	JSR DisplayInputCharacters	;($940B)Write password character to screen.
L912A:	LDA #$13			;
L912C:	STA PalDataPending		;Change palette.
L912E:	LDA #$00			;
L9130:	STA InputRow			;Sets character select cursor to-->
L9133:	STA InputColumn			;upper left character (0).
L9136:	STA Timer3			;
L9138:	LDA #$00			;
L913A:	STA PasswordCursor		;Sets password cursor to password character 0.
L913D:	LDY #$00			;
L913F:	STY PasswordStat00		;Appears to have no function.
L9142:	INC TitleRoutine		;
L9144:	JMP TurnOnDisplay		;($90D1)Turn on screen and NMI.

EnterPassword:
L9147:	JSR EraseAllSprites		;($C1A3)Remove sprites from screen.
L914A:	LDA Joy1Change			;
L914C:	AND #$10			;Check to see if START has been pressed.
L914E:	BEQ +				;If not, branch.
L9150:	JMP CheckPassword		;($8C5E)Check if password is correct.
L9153:*	LDX #$01			;
L9155:	STX PPUDataPending		;Prepare to write the password screen data to PPU.
L9157:	LDX PPUStrIndex			;
L915A:	LDA #$21			;Upper byte of PPU string.
L915C:	JSR WritePPUByte		;($C36B)Write byte to PPU.
L915F:	LDA #$A8			;Lower byte of PPU string.
L9161:	JSR WritePPUByte		;($C36B)Write byte to PPU.
L9164:	LDA #$0F			;PPU string length.
L9166:	JSR WritePPUByte		;($C36B)Write byte to PPU.
L9169:	LDA Timer3			;
L916B:	BEQ +				;
L916D:	LDA #$59			;
L916F:	STA $02				;Writes 'ERROR TRY AGAIN' on the screen-->
L9171:	LDA #$87			;if Timer3 is anything but #$00.
L9173:	STA $03				;
L9175:	JMP ++				;
L9178:*	LDA #$68			;
L917A:	STA $02				;
L917C:	LDA #$87			;
L917E:	STA $03				;Writes the blank lines that cover-->
L9180:*	LDY #$00			;the message 'ERROR TRY AGAIN'.
L9182:*	LDA ($02),Y			;
L9184:	JSR WritePPUByte		;
L9187:	INY 				;
L9188:	CPY #$0F			;
L918A:	BNE -				;
L918C:	LDA Joy1Change			;If button A pressed, branch.
L918E:	BMI +				;
L9190:	JMP CheckBackspace		;($91FB)Check if backspace pressed.
L9193:*	LDA TriangleSFXFlag		;Initiate BombLaunch SFX if a character-->
L9196:	ORA #$01			;has been written to the screen.
L9198:	STA TriangleSFXFlag		;
L919B:	LDA PasswordCursor		;
L919E:	CMP #$12			;Check to see if password cursor is on-->
L91A0:	BCC +				;character 19 thru 24.  If not, branch.
L91A2:	CLC				;
L91A3:	ADC #$3E			;Will equal #$50 thru #$55.
L91A5:	JMP LoadRowAndColumn		;($91BF)
L91A8:*	CMP #$0C			;Check to see if password cursor is on-->
L91AA:	BCC +				;character 13 thru 18.  If not, branch.
L91AC:	CLC				;
L91AD:	ADC #$3D			;Will equal #$49 thru #$4E.
L91AF:	JMP LoadRowAndColumn		;($91BF)
L91B2:*	CMP #$06			;Check to see if password cursor is on-->
L91B4:	BCC +				;character 7 thru 12.  If not, branch.
L91B6:	CLC				;
L91B7:	ADC #$0A			;Will equal #$10 thru #$15.
L91B9:	JMP LoadRowAndColumn		;($91BF)
L91BC:*	CLC				;
L91BD:	ADC #$09			;Will equal #$09 thru #$0E.

LoadRowAndColumn:
L91BF:*	STA $06				;
L91C1:	LDA InputRow			;
L91C4:	ASL				;*2. address pointer is two bytes.
L91C5:	TAY				;
L91C6:	LDA PasswordRowTbl,Y		;Store lower byte of row pointer.
L91C9:	STA $00				;
L91CB:	LDA PasswordRowTbl+1,Y		;Store upper byte of row pointer.
L91CE:	STA $01				;
L91D0:	LDY InputColumn			;Uses InputColumn value to find proper index-->		
L91D3:	LDA ($00),Y			;of current character selected.
L91D5:	PHA				;Temp storage of A.
L91D6:	STA TileInfo0			;Store value of current character slected.
L91D9:	LDA #$11			;
L91DB:	STA TileSize			;
L91DE:	LDX $06				;Replace password character tile with-->
L91E0:	LDY #$21			;the one selected by the player.
L91E2:	JSR PrepareEraseTiles		;($9450)
L91E5:	LDX PasswordCursor		;
L91E8:	PLA 				;Store the currently selected password character-->
L91E9:	STA PasswordChar00,X		;in the proper PasswordChar RAM location.
L91EC:	LDA PasswordCursor		;
L91EF:	CLC				;
L91F0:	ADC #$01			;
L91F2:	CMP #$18			;
L91F4:	BCC +				;Increment PasswordCursor.  If at last character,-->
L91F6:	LDA #$00			;loop back to the first character.
L91F8:*	STA PasswordCursor		;

CheckBackspace:
L91FB:	LDA Joy1Change			;
L91FD:	AND #$40			;If button B (backspace) has not-->
L91FF:	BEQ ++				;been pressed, branch.
L9201:	LDA PasswordCursor		;
L9204:	SEC				;Subtract 1 from PasswordCursor.  If-->
L9205:	SBC #$01			;PasswordCursor is negative, load-->
L9207:	BCS +				;PasswordCursor with #$17 (last character).
L9209:	LDA #$17			;
L920B:*	STA PasswordCursor		;
L920E:*	LDY PasswordStat00		;Appears to have no function.
L9211:	LDA FrameCount			;
L9213:	AND #$08			;If FrameCount bit 3 not set, branch.
L9215:	BEQ +++				;
L9217:	LDA #$3F			;
L9219:	LDX PasswordCursor		;Load A with #$3F if PasswordCursor is on-->
L921C:	CPX #$0C			;character 0 thru 11, else load it with #$4F.
L921E:	BCC +				;
L9220:	LDA #$4F			;
L9222:*	STA Sprite01RAM			;Set Y-coord of password cursor sprite.
L9225:	LDA #$6E			;
L9227:	STA Sprite01RAM+1		;Set pattern for password cursor sprite.
L922A:	LDA #$20			;
L922C:	STA Sprite01RAM+2		;Set attributes for password cursor sprite.
L922F:	LDA PasswordCursor		;If the password cursor is at the 12th-->
L9232:	CMP #$0C			;character or less, branch.
L9234:	BCC +				;
L9236:	SBC #$0C			;Calculate how many characters the password cursor-->
L9238:*	TAX 				;is from the left if on the second row of password.
L9239:	LDA CursorPosTbl,X		;Load X position of PasswordCursor.
L923C:	STA Sprite01RAM+3		;
L923F:*	LDX InputRow			;Load X and Y with row and column-->
L9242:	LDY InputColumn			;of current character selected.
L9245:	LDA Joy1Retrig			;
L9247:	AND #$0F			;If no directional buttons are in-->
L9249:	BEQ ++++++++++			;retrigger mode, branch.
L924B:	PHA				;Temp storage of A.
L924C:	LDA TriangleSFXFlag		;Initiate BeepSFX when the player pushes-->
L924F:	ORA #$08			;a button on the directional pad.
L9251:	STA TriangleSFXFlag		;
L9254:	PLA				;Restore A.
L9255:	LSR				;Put status of right directional button in carry bit.
L9256:	BCC +++				;Branch if right button has not been pressed.
L9258:	INY				;
L9259:	CPY #$0D			;Increment Y(column).  If Y is greater than #$0C,-->
L925B:	BNE ++				;increment X(Row).  If X is greater than #$04,-->
L925D:	INX 				;set X to #$00(start back at top row) and store-->
L925E:	CPX #$05			;new row in InputRow.
L9260:	BNE +				;
L9262:	LDX #$00			;
L9264:*	STX InputRow			;
L9267:	LDY #$00			;Store new column in InputColumn.
L9269:*	STY InputColumn			;
L926C:*	LSR				;Put status of left directional button in carry bit.
L926D:	BCC +++				;Branch if left button has not been pressed.
L926F:	DEY				;
L9270:	BPL ++				;Decrement Y(column).  If Y is less than #$00,-->
L9272:	DEX				;Decrement X(row).  If X is less than #$00,-->
L9273:	BPL +				;set X to #$04(last row) and store new row-->
L9275:	LDX #$04			;in InputRow.
L9277:*	STX InputRow			;
L927A:	LDY #$0C			;Store new column in InputColumn.
L927C:*	STY InputColumn			;
L927F:*	LSR				;Put status of down directional button in carry bit.
L9280:	BCC ++				;Branch if down button has not been pressed.
L9282:	INX				;
L9283:	CPX #$05			;Increment X(row).  if X is greater than #$04,-->
L9285:	BNE +				;set X to #$00(first row) and store new-->
L9287:	LDX #$00			;row in InputRow.
L9289:*	STX InputRow			;
L928C:*	LSR				;Put status of up directional button in carry bit.
L928D:	BCC ++				;Branch if up button has not been pressed.
L928F:	DEX				;
L9290:	BPL +				;Decrement X(row).  if X is less than #$00,-->
L9292:	LDX #$04			;set X to #$04(last row) and store new-->
L9294:*	STX InputRow			;row in InputRow.
L9297:*	LDA FrameCount			;
L9299:	AND #$08			;If FrameCount bit 3 not set, branch.
L929B:	BEQ +				;
L929D:	LDA CharSelectYTbl,X		;Set Y-coord of character selection sprite.
L92A0:	STA Sprite02RAM			;
L92A3:	LDA #$6E			;Set pattern for character selection sprite.
L92A5:	STA Sprite02RAM+1		;
L92A8:	LDA #$20			;Set attributes for character selection sprite.
L92AA:	STA Sprite02RAM+2		;
L92AD:	LDA CharSelectXTbl,Y		;Set x-Coord of character selection sprite.
L92B0:	STA Sprite02RAM+3		;
L92B3:*	RTS				;

;The following data does not appear to be used in the program.
L92B4:	.byte $21, $20

;The following table is used to determine the proper Y position of the character
;selection sprite on password entry screen.

CharSelectYTbl: 
L92B6:	.byte $77, $87, $97, $A7, $B7

;The following table is used to determine the proper X position of the character
;selection sprite on password entry screen.

CharSelectXTbl:
L92BB:	.byte $20, $30, $40, $50, $60, $70, $80, $90, $A0, $B0, $C0, $D0, $E0

;When the PasswordCursor is on the second row of the password, the following table is used
;to determine the proper x position of the password cursor sprite(password characters 12-23).

CursorPosTbl:
L92C8:	.byte $48, $50, $58, $60, $68, $70, $80, $88, $90, $98, $A0, $A8

InitializeGame:
L92D4:	JSR ClearRAM_33_DF		;($C1D4)Clear RAM.
L92D7:	JSR ClearSamusStats		;($C578)Reset Samus stats for a new game.
L92DA:	JSR LoadPasswordData		;($8D12)Load data from password.
L92DD:	LDY #$00			;
L92DF:	STY SpritePagePos		;
L92E1:	STY PageIndex			;Clear object data.
L92E3:	STY ObjectCntrl			;
L92E5:	STY ObjectHi			;
L92E8:	JSR SilenceMusic		;($CB8E)Turn off music.
L92EB:	LDA #$5A			;
L92ED:	STA AnimFrame			;Set animframe index. changed by initializing routines. 
L92F0:	LDX #$01			;x is the index into the position tables below.
L92F2:	LDA InArea			;Load starting area.
L92F4:	AND #$0F			;
L92F6:	BNE +				;If in area other than Brinstar, get second item in tables.
L92F8:	DEX				;Starting in Brinstar. Get forst item in each table.
L92F9:*	LDA RestartYPosTbl,X		;
L92FC:	STA ObjectY			;Set Samus restart y position on screen.
L92FF:	LDA RestartXPosTbl,X		;
L9302:	STA ObjectX			;Set Samus restart x position on screen.
L9305:	INC SamusStat02			;The combination of SamusStat02 and 03 keep track of how-->
L9308:	BNE +				;many times Samus has died and beaten the game as they are-->
L930A:	INC SamusStat03			;incremented every time this routine is run, but they are-->
L930D:*	LDA #$01			;not accessed anywhere else.
L930F:	STA MainRoutine			;Initialize starting area.
L9311:	JSR ScreenNmiOff		;($C45D)Turn off screen.
L9314:	JSR LoadSamusGFX		;($C5DC)Load Samus GFX into pattern table.
L9317:	JSR NmiOn			;($C487)Turn on the non-maskable interrupt.
L931A:	LDA InArea			;Load area Samus is to start in.
L931C:	AND #$0F			;
L931E:	TAY				;
L931F:	LDA BankTable,Y			;Change to proper memory page.
L9322:	STA SwitchPending		;
L9324:	RTS 

;The following two tables are used to find Samus y and x positions on the screen after the game
;restarts.  The third entry in each table are not used.

RestartYPosTbl:
L9325:	.byte $64			;Brinstar
L9326:	.byte $8C			;All other areas.
L9327:	.byte $5C			;Not used.

RestartXPosTbl:
L9328:	.byte $78			;Brinstar
L9329:	.byte $78			;All other areas.
L932A:	.byte $5C			;Not used.

InitializeStats:
L932B:	LDA #$00			;
L932D:	STA SamusStat00			;
L9330:	STA TankCount			;
L9333:	STA SamusGear			;
L9336:	STA MissileCount		;
L9339:	STA MaxMissiles			;
L933C:	STA KraidStatueStatus		;Set all of Samus' stats to 0 when starting new game.
L933F:	STA RidleyStatueStatus		;
L9342:	STA SamusAge			;
L9345:	STA SamusAge+1			;
L9348:	STA SamusAge+2			;
L934B:	STA SamusStat01			;
L934E:	STA AtEnding			;
L9351:	STA JustInBailey		;
L9354:	LDA #$02			;
L9356:	STA SwitchPending		;Prepare to switch to Brinstar memory page.
L9358:	RTS				;

DisplayPassword:
L9359:	LDA Timer3			;Wait for "GAME OVER" to be displayed-->
L935B:	BNE $9324			;for 160 frames (2.6 seconds).
L935D:	JSR ClearAll			;($909F)Turn off screen, erase sprites and nametables.
L9360:	LDX #$7F			;Low byte of start of PPU data.
L9362:	LDY #$93			;High byte of start of PPU data.
L9364:	JSR PreparePPUProcess		;($9449)Clears screen and writes "PASS WORD".
L9367:	JSR InitGFX7			;($C6D6)Loads the font for the password.
L936A:	JSR CalculatePassword		;($8C7A)Calculates the password.
L936D:	JSR NmiOn			;($C487)Turn on the nonmaskable interrupt.
L9370:	JSR PasswordToScreen		;($93C6)Displays password on screen.
L9373:	JSR WaitNMIPass			;($C42C)Wait for NMI to end.
L9376:	LDA #$13			;
L9378:	STA PalDataPending		;Change palette.
L937A:	INC TitleRoutine		;
L937C:	JMP ScreenOn			;($C447)Turn screen on.

;Information below is for above routine to display "PASS WORD" on the screen.
L937F:	.byte $21			;PPU memory high byte.
L9380:	.byte $4B			;PPU memory low byte.
L9381:	.byte $09			;PPU string length.
;             'P    A    S    S    _    W    O    R    D'
L9382:	.byte $19, $0A, $1C, $1C, $FF, $20, $18, $1B, $0D

;Information to be stored in attribute table 0.
L938B:	.byte $23			;PPU memory high byte.
L938C:	.byte $D0			;PPU memory low byte.
L938D:	.byte $48			;RLE bit set, repeat entry 8 times.
L938E:	.byte $00			;Clears line below "PASS WORD".

L938F:	.byte $23			;PPU memory high byte.
L9390:	.byte $D8			;PPU memory low byte.
L9391:	.byte $60			;RLE bit set, repeat entry 32 times. 
L9392:	.byte $55			;Turn color on to display password characters.

L9393:	.byte $00			;End PPU string write.

WaitForSTART:
L9394:	LDA Joy1Change			;Waits for START to be ressed proceed-->
L9396:	AND #$10			;past the GAME OVER screen.
L9398:	BEQ +				;If start not pressed, branch.
L939A:	JMP CheckPassword		;($8C5E)Check if password is correct.
L939D:*	RTS				;

GameOver:
L939E:	JSR ClearAll			;($909F)Turn off screen, erase sprites and nametables.
L93A1:	LDX #$B9			;Low byte of start of PPU data.
L93A3:	LDY #$93			;High byte of start of PPU data.
L93A5:	JSR PreparePPUProcess		;($9449)Clears screen and writes "GAME OVER".
L93A8:	JSR InitGFX7			;($C6D6)Loads the font for the password.
L93AB:	JSR NmiOn			;($C487)Turn on the nonmaskable interrupt.
L93AE:	LDA #$10			;Load Timer3 with a delay of 160 frames-->
L93B0:	STA Timer3			;(2.6 seconds) for displaying "GAME OVER".
L93B2:	LDA #$19			;Loads TitleRoutine with -->
L93B4:	STA TitleRoutine		;DisplayPassword.
L93B6:	JMP ScreenOn			;($C447)Turn screen on.

;Information below is for above routine to display "GAME OVER" on the screen.
L93B9:	.byte $21			;PPU memory high byte.
L93BA:	.byte $8C			;PPU memory low byte.
L93BB:	.byte $09			;PPU string length.
;             'G    A    M    E    _    O    V    E    R'
L93BC:	.byte $10, $0A, $16, $0E, $FF, $18, $1F, $0E, $1B

L93C4:	.byte $00			;End PPU string write.

PasswordToScreen:
L93C6:	JSR WaitNMIPass			;($C42C)Wait for NMI to end.
L93C9:	LDY #$05			;Index to find password characters(base=$699A).
L93CB:	JSR LoadPasswordTiles		;($93F9)Load tiles on screen.
L93CE:	LDX #$A9			;PPU low address byte.
L93D0:	LDY #$21			;PPU high address byte.
L93D2:	JSR PrepareEraseTiles		;($9450)Erase tiles on screen.
L93D5:	LDY #$0B			;Index to find password characters(base=$699A).
L93D7:	JSR LoadPasswordTiles		;($93F9)Load tiles on screen.
L93DA:	LDX #$B0			;PPU low address byte.
L93DC:	LDY #$21			;PPU high address byte.
L93DE:	JSR PrepareEraseTiles		;($9450)Erase tiles on screen.
L93E1:	LDY #$11			;Index to find password characters(base=$699A).
L93E3:	JSR LoadPasswordTiles		;($93F9)Load tiles on screen.
L93E6:	LDX #$E9			;PPU low address byte.
L93E8:	LDY #$21			;PPU high address byte.
L93EA:	JSR PrepareEraseTiles		;($9450)Erase tiles on screen.
L93ED:	LDY #$17			;Index to find password characters(base=$699A).
L93EF:	JSR LoadPasswordTiles		;($93F9)Load tiles on screen.
L93F2:	LDX #$F0			;PPU low address byte.
L93F4:	LDY #$21			;PPU high address byte.
L93F6:	JMP PrepareEraseTiles		;($9450)Erase tiles on screen.

LoadPasswordTiles:
L93F9:	LDA #$16			;Tiles to replace are one block-->
L93FB:	STA TileSize			;high and 6 blocks long.
L93FE:	LDX #$05			;
L9400:*	LDA PasswordChar00,Y		;
L9403:	STA TileInfo0,X			;
L9406:	DEY				;Transfer password characters to-->
L9407:	DEX				;TileInfo addresses.
L9408:	BPL-				;
L940A:	RTS				;

DisplayInputCharacters:
L940B:	LDA PPUStatus			;Clear address latches.
L940E:	LDY #$00			;
L9410:	TYA 				;Initially sets $00 an $01.
L9411:	STA $00				;to #$00.
L9413:	STA $01				;Also, initialy sets x and y to #$00.
L9415:*	ASL				;
L9416:	TAX				;
L9417:	LDA PasswordRowsTbl,X		;
L941A:	STA PPUAddress			;
L941D:	LDA PasswordRowsTbl+1,X		;Displays the list of characters -->
L9420:	sTA PPUAddress			;to choose from on the password--> 
L9423:	LDX #$00			;entry screen.
L9425:*	LDA PasswordRow0,Y		;Base is $99A2.
L9428:	STA PPUIOReg			;
L942B:	LDA #$FF			;Blank tile.
L942D:	STA PPUIOReg			;
L9430:	INY				;
L9431:	INX				;
L9432:	CPX #$0D			;13 characters in current row?
L9434:	BNE -				;if not, add another character.
L9436:	INC $01				;
L9438:	LDA $01				;
L943A:	CMP #$05			;5 rows?
L943C:	BNE --				;If not, go to next row.
L943E:	RTS				;

;The table below is used by the code above to determine the positions
;of the five character rows on the password entry screen.

PasswordRowsTbl:
L943F:	.byte $21, $E4			;
L9441:	.byte $22, $24			;The two entries in each row are the upper and lower address-->
L9443:	.byte $22, $64			;bytes to start writing to the name table, respectively.
L9445:	.byte $22, $A4			;
L9447:	.byte $22, $E4			;


PreparePPUProcess:
L9449:	stx $00				;Lower byte of pointer to PPU string
L944B:	sty $01				;Upper byte of pointer to PPU string
L944D:	jmp ProcessPPUString		;($C30C)

PrepareEraseTiles:
L9450:	STX $00				;PPU low address byte
L9452:	STY $01				;PPU high address byte
L9454:	LDX #$80			;
L9456:	LDY #$07			;
L9458:	STX $02				;Address of byte where tile size-->  
L945A:	STY $03				;of tile to be erased is stored.
L945C:	JMP EraseTile			;($C328)Erase the selected tiles.

;---------------------------------------[ Unused intro routines ]------------------------------------

;The following routines are intro routines that are not used in this version of the game.  It
;appears that the intro routine was originally going to be more complex with a more advanced
;sprite control mechanism and name table writing routines. The intro routines are a mess! In
;addition to unused routines, there are several unused memory addresses that are written to but
;never read.

UnusedIntroRoutine4:
L945F:	STX PPUStrIndex			;
L9462:	LDA #$00			;
L9464:	STA PPUDataString,X		;The following unused routine writes something to the-->
L9467:	LDA #$01			;PPU string and prepares for a PPU write.
L9469:	STA PPUDataPending		;
L946B:	RTS				;

UnusedIntroRoutine5:
L946C:	STA $05				;
L946E:	AND #$F0			;
L9470:	LSR				;
L9471:	LSR				;
L9472:	LSR				;
L9473:	LSR				;
L9474:	JSR +				;
L9477:	LDA $05				;Unused intro routine. It looks like originally the-->
L9479:	AND #$0F			;title routines were going to write data to the name-->
L947B:*	STA PPUDataString,X		;tables in the middle of the title sequences.
L947E:	INX				;
L947F:	TXA				;
L9480:	CMP #$55			;
L9482:	BCC ++				;
L9484:	LDX PPUStrIndex			;
L9487:*	LDA #$00			;
L9489:	STA PPUDataString,X		;
L948C:	BEQ -				;
L948E:*	RTS				;

UnusedIntroRoutine6:
L948F:	TYA				;
L9490:	PHA				;
L9491:	JSR Amul16			;($C2C5)Multiply by 16.
L9494:	TAY				;
L9495:	LDA $684B,Y			;
L9498:	STA $0B				;
L949A:	LDA $684A,Y			;
L949D:	STA $0A				;
L949F:	JSR UnusedIntroRoutine8		;($94DA)
L94A2:	LDA $06				;
L94A4:	STA $683D,X			;Another unused intro routine.
L94A7:	LDA $07				;
L94A9:	STA $683C,X			;
L94AC:	PLA				;
L94AD:	TAY				;
L94AE:	RTS				;

UnusedIntroRoutine7:
L94AF:	TYA				;
L94B0:	PHA				;
L94B1:	JSR Amul16			;($C2C5)Multiply by 16.
L94B4:	TAY				;
L94B5:	LDA $684D,Y			;
L94B8:	STA $0B				;
L94BA:	LDA $684C,Y			;
L94BD:	STA $0A				;
L94BF:	JSR UnusedIntroRoutine8		;($94DA)
L94C2:	LDA $06				;
L94C4:	STA $6834,X			;
L94C7:	LDA $07				;
L94C9:	STA $6833,X			;
L94CC:	LDA $6842,Y			;Another unused intro routine.
L94CF:	PHA				;
L94D0:	TXA				;
L94D1:	LSR				;
L94D2:	TAY				;
L94D3:	PLA				;
L94D4:	STA $6839,Y			;
L94D7:	PLA				;
L94D8:	TAY				;
L94D9:	RTS				;

UnusedIntroRoutine8:
L94DA:	LDA #$FF			;
L94DC:	STA $01				;
L94DE:	STA $02				;
L94E0:	STA $03				;
L94E2:	SEC				;
L94E3:*	LDA $0A				;
L94E5:	SBC #$E8			;
L94E7:	STA $0A				;
L94E9:	LDA $0B				;
L94EB:	SBC #$03			;
L94ED:	STA $0B				;
L94EF:	INC $03				;
L94F1:	BCS -				;
L94F3:	LDA $0A				;
L94F5:	ADC #$E8			;
L94F7:	STA $0A				;
L94F9:	LDA $0B				;
L94FB:	ADC #$03			;
L94FD:	STA $0B				;
L94FF:	LDA $0A				;
L9501:*	SEC				;Unused intro routine. Looks like the intro routines may-->
L9502:*	SBC #$64			;have had more complicated sprite control routines-->
L9504:	INC $02				;that it does now.
L9506:	BCS -				;
L9508:	DEC $0B				;
L950A:	BPL --				;
L950C:	ADC #$64			;
L950E:	SEC				;
L950F:*	SBC #$0A			;
L9511:	INC $01				;
L9513:	BCS -				;
L9515:	ADC #$0A			;
L9517:	STA $06				;
L9519:	LDA $01				;
L951B:	JSR Amul16			;($C2C5)Multiply by 16.
L951E:	ORA $06				;
L9520:	STA $06				;
L9522:	LDA $03				;
L9524:	JSR Amul16			;($C2C5)Multiply by 16.
L9527:	ORA $02				;
L9529:	STA $07				;
L952B:	RTS				;

;Not used.
L952C:	.byte $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF
L953C:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00
L954C:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
L955C:	.byte $00, $00, $00, $00

;--------------------------------------[ Palette data ]---------------------------------------------

;The following table points to the palette data
;used in the intro and ending portions of the game.

PaletteColorsPointerTable:
L9560:	.word Palette00			;($9586)
L9562:	.word Palette01			;($95AA)
L9564:	.word Palette02			;($95CE)
L9566:	.word Palette03			;($95F2)
L9568:	.word Palette04			;($9616)
L956A:	.word Palette05			;($963A)
L956C:	.word Palette06			;($965E)
L956E:	.word Palette07			;($9682)
L9570:	.word Palette08			;($96A6)
L9572:	.word Palette09			;($96CA)
L9574:	.word Palette0A			;($96EE)
L9576:	.word Palette0B			;($9712)
L9578:	.word Palette0C			;($9736)
L957A:	.word Palette0D			;($975A)
L957C:	.word Palette0E			;($977E)
L957E:	.word Palette0F			;($97A2)
L9580:	.word Palette10			;($97C6)
L9582:	.word Palette11			;($97EA)
L9584:	.word Palette12			;($97F2)

Palette00:
L9586:	.byte $3F			;Upper byte of PPU palette adress.
L9587:	.byte $00			;Lower byte of PPU palette adress.
L9588:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L9589:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
;The following values are written to the sprite palette:
L9599:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L95A9:	.byte $00			;End Palette01 info.

Palette01:
L95AA:	.byte $3F			;Upper byte of PPU palette adress.
L95AB:	.byte $00			;Lower byte of PPU palette adress.
L96AC:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L95AD:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $35, $35, $04, $0F, $35, $14, $04
;The following values are written to the sprite palette:
L95BD:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L95CD:	.byte $00			;End Palette02 info.

Palette02:
L95CE:	.byte $3F			;Upper byte of PPU palette adress.
L95CF:	.byte $00			;Lower byte of PPU palette adress.
L95D0:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L95D1:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $39, $39, $09, $0F, $39, $29, $09
;The following values are written to the sprite palette:
L95E1:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L95F1:	.byte $00			;End Palette03 info.

Palette03:
L95F2:	.byte $3F			;Upper byte of PPU palette adress.
L95F3:	.byte $00			;Lower byte of PPU palette adress.
L95F4:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L95F5:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $36, $36, $06, $0F, $36, $15, $06
;The following values are written to the sprite palette:
L9605:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L9615:	.byte $00			;End Palette04 info.

Palette04:
L9616:	.byte $3F			;Upper byte of PPU palette adress.
L9617:	.byte $00			;Lower byte of PPU palette adress.
L9618:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L9619:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $27, $27, $12, $0F, $27, $21, $12
;The following values are written to the sprite palette:
L9629:	.byte $0F, $16, $1A, $27, $0F, $31, $20, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L9639:	.byte $00			;End Palette05 info.

Palette05:
L963A:	.byte $3F			;Upper byte of PPU palette adress.
L963B:	.byte $00			;Lower byte of PPU palette adress.
L963C:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L963D:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $0F, $0F
;The following values are written to the sprite palette:
L964D:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L965D:	.byte $00			;End Palette06 info.

Palette06:
L965E:	.byte $3F			;Upper byte of PPU palette adress.
L965F:	.byte $00			;Lower byte of PPU palette adress.
L9660:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L9661:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $01, $0F
;The following values are written to the sprite palette:
L9671:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L9681:	.byte $00			;End Palette07 info.

Palette07:
L9682:	.byte $3F			;Upper byte of PPU palette adress.
L9683:	.byte $00			;Lower byte of PPU palette adress.
L9684:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L9685:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $01, $0F, $02, $02, $01
;The following values are written to the sprite palette:
L9695:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L96A5:	.byte $00			;End Palette08 info.

Palette08:
L96A6:	.byte $3F			;Upper byte of PPU palette adress.
L96A7:	.byte $00			;Lower byte of PPU palette adress.
L96A8:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L96A9:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $01, $0F, $02, $01, $01
;The following values are written to the sprite palette:
L96B9:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L96C9:	.byte $00			;End Palette09 info.

Palette09:
L96CA:	.byte $3F			;Upper byte of PPU palette adress.
L96CB:	.byte $00			;Lower byte of PPU palette adress.
L96CC:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L96CD:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $12, $12, $02, $0F, $12, $12, $02
;The following values are written to the sprite palette:
L96DD:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L96ED:	.byte $00			;End Palette0A info.

Palette0A:
L96EE:	.byte $3F			;Upper byte of PPU palette adress.
L96EF:	.byte $00			;Lower byte of PPU palette adress.
L96F0:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L96F1:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $11, $11, $02, $0F, $11, $02, $02
;The following values are written to the sprite palette:
L9701:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L9711:	.byte $00			;End Palette0B info.

Palette0B:
L9712:	.byte $3F			;Upper byte of PPU palette adress.
L9713:	.byte $00			;Lower byte of PPU palette adress.
L9714:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L9715:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $31, $31, $01, $0F, $31, $11, $01
;The following values are written to the sprite palette:
L9716:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L9735:	.byte $00			;End Palette0C info.

Palette0C:
L9736:	.byte $3F			;Upper byte of PPU palette adress.
L9737:	.byte $00			;Lower byte of PPU palette adress.
L9738:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L9739:	.byte $0F, $28, $18, $08, $0F, $12, $30, $21, $0F, $27, $28, $29, $0F, $31, $31, $01
;The following values are written to the sprite palette:
L9749:	.byte $0F, $16, $2A, $27, $0F, $12, $30, $21, $0F, $27, $24, $2C, $0F, $15, $21, $38

L9759:	.byte $00			;End Palette0D info.

Palette0D:
L975A:	.byte $3F			;Upper byte of PPU palette adress.
L975B:	.byte $00			;Lower byte of PPU palette adress.
L975C:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L975D:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $12, $12, $01, $0F, $12, $02, $01
;The following values are written to the sprite palette:
L975E:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L977D:	.byte $00			;End Palette0E info.

Palette0E:
L977E:	.byte $3F			;Upper byte of PPU palette adress.
L977F:	.byte $00			;Lower byte of PPU palette adress.
L9780:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L9781:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $02, $02, $0F, $0F, $02, $01, $0F
;The following values are written to the sprite palette:
L9791:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L97A1:	.byte $00			;End Palette0F info.

Palette0F:
L97A2:	.byte $3F			;Upper byte of PPU palette adress.
L97A3:	.byte $00			;Lower byte of PPU palette adress.
L97A4:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L97A5:	.byte $0F, $28, $18, $08, $0F, $29, $1B, $1A, $0F, $01, $01, $0F, $0F, $01, $0F, $0F
;The following values are written to the sprite palette:
L97B5:	.byte $0F, $16, $1A, $27, $0F, $37, $3A, $1B, $0F, $17, $31, $37, $0F, $32, $22, $12

L97C5:	.byte $00			;End Palette10 info.

Palette10:
L97C6:	.byte $3F			;Upper byte of PPU palette adress.
L97C7:	.byte $00			;Lower byte of PPU palette adress.
L97C8:	.byte $20			;Palette data length.
;The following values are written to the background palette:
L97C9:	.byte $30, $28, $18, $08, $30, $29, $1B, $1A, $30, $30, $30, $30, $30, $30, $30, $30
;The following values are written to the sprite palette:
L97D9:	.byte $30, $16, $1A, $27, $30, $37, $3A, $1B, $30, $17, $31, $37, $30, $32, $22, $12

L97E9:	.byte $00			;End Palette11 info.

Palette11:
L97EA:	.byte $3F			;Upper byte of PPU palette adress.
L97EB:	.byte $00			;Lower byte of PPU palette adress.
L97EC:	.byte $04			;Palette data length.
;The following values are written to the background palette:
L97ED:	.byte $0F, $30, $30, $21

L98F1:	.byte $00			;End Palette12 info.

Palette12:
L97F2:	.byte $3F			;Upper byte of PPU palette adress.
L97F3:	.byte $00			;Lower byte of PPU palette adress.
L97F4:	.byte $10			;Palette data length.
;The following values are written to the background palette:
L97F5:	.byte $0F, $30, $30, $0F, $0F, $2A, $2A, $21, $0F, $31, $31, $0F, $0F, $2A, $2A, $21

L9805:	.byte $00			;End Palette13 data.

EndGamePal0B:
L9806:	.byte $3F			;Upper byte of PPU palette adress.
L9807:	.byte $00			;Lower byte of PPU palette adress.
L9808:	.byte $10			;Palette data length.
;The following values are written to the background palette:
L9809:	.byte $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C, $0F, $2C, $2C, $2C

EndGamePal0C:
L9819:	.byte $3F			;Upper byte of PPU palette adress.
L981A:	.byte $10			;Lower byte of PPU palette adress.
L981B:	.byte $50			;Palette data length.
L981C:	.byte $0F			;Repeat bit set. Fill sprite palette with #$0F.

L981D:	.byte $00			;End EndGamePal0C data.

UpdateSpriteCoords:
L981E:	LDA IntroSpr0XRun,X		;Load sprite run(sprite x component).
L9821:	JSR CalcDisplacement		;($9871)Calculate sprite displacement in x direction.
L9824:	LDY IntroSpr0XDir,X		;Get byte describing if sprite increasing or decreasing pos.
L9827:	BPL +				;

L9829:	EOR #$FF			;If MSB is set, sprite is decreasing position. convert-->
L982B:	CLC				;value in A (result from CalcDisplacement) to twos compliment.
L982C:	ADC #$01			;

L982E:*	CLC				;
L982F:	ADC IntroSpr0XCoord,X		;Add change to sprite x coord. 
L9832:	STA IntroSpr0XCoord,X		;
L9835:	SEC				;
L9836:	SBC IntroSpr0XChange,X		;Subtract total sprite movemnt value from current sprite x pos.
L9839:	PHP				;Transfer processor status to A.
L983A:	PLA				;
L983B:	EOR IntroSpr0XDir,X		;Eor carry bit with direction byte to see if sprite has-->	 
L983E:	LSR				;reached its end point.
L983F:	BCC++				;Branch if sprite has reached the end of x movement.

L9841:	LDA IntroSpr0YRise,X		;Load sprite rise(sprite y component).
L9844:	JSR CalcDisplacement		;($9871)Calculate sprite displacement in y direction.
L9847:	LDY IntroSpr0YDir,X		;Get byte describing if sprite increasing or decreasing pos.
L984A:	BPL +				;

L984C:	EOR #$FF			;If MSB is set, sprite is decreasing position. convert-->
L984E:	CLC				;value in A (result from CalcDisplacement) to twos compliment.
L984F:	ADC #$01			;

L9851:*	CLC				;
L9852:	ADC IntroSpr0YCoord,X		;Add change to sprite y coord. 
L9855:	STA IntroSpr0YCoord,X		;
L9858:	SEC				;
L9859:	SBC IntroSpr0YChange,X		;Subtract total sprite movemnt value from current sprite y pos.
L985C:	PHP				;Transfer processor status to A.
L985D:	PLA				;
L985E:	EOR IntroSpr0YDir,X		;Eor carry bit with direction byte to see if sprite has-->
L9861:	LSR				;reached its end point.
L9862:	BCS ++				;Branch if sprite has not reached the end of y movement.

L9864:*	LDA IntroSpr0YChange,X		;After sprite has reached its final position, this code-->
L9867:	STA IntroSpr0YCoord,X		;explicitly writes final the x and y coords to to sprite-->
L986A:	LDA IntroSpr0XChange,X		;position addresses to make sure the sprites don't-->
L986D:	STA IntroSpr0XCoord,X		;overshoot their mark.
L9870:*	RTS				;

CalcDisplacement:
L9871:	STA $04				;
L9873:	LDA #$08			;Time division. The higher the number, the slower the sprite.
L9875:	STA $00				;
L9877:*	LSR $04				;
L9879:	BCC +				;
L987B:	LDA FrameCount			;
L987D:	AND $00				;Calculate the change in the sprite position by taking the-->
L987F:	BNE +				;value in a and dividing it by the time division. The time-->
L9881:	INC $04				;time division in this case is #$08.
L9883:*	LSR $00				;
L9885:	BNE --				;
L9887:	LDA $04				;
L9889:	RTS				;Return A/time.

;This function decrements the y coordinate of the 40 intro star sprites.

DecSpriteYCoord:
L988A:	LDA TitleRoutine		;
L988C:	CMP #$1D			;
L988E:	BCS ++				;If the end game is playing, branch to exit.
L9890:	LDA SpriteLoadPending		;		
L9892:	BEQ ++				;If no sprite load is pending, branch to exit.
L9894:	LDA FrameCount			;
L9896:	LSR				;
L9897:	BCS ++				;If not on an odd numbered frame, branch to exit.
L9899:	LDX #$9F			;
L989B:*	DEC IntroStarSprite00,X		;Decrement y coord of the intro star sprites.
L989E:	DEC Sprite18RAM,X		;Decrement y coord of 40 sprites.
L98A1:	DEX				;
L98A2:	DEX				;
L98A3:	DEX				;Move to next sprite.
L98A4:	DEX				;
L98A5:	CPX #$FF			;
L98A7:	BNE -				;Loop 40 times.
L98A9:	LDA #$00			;
L98AB:	STA SpriteLoadPending		;Sprite RAM load complete.
L98AD:*	RTS				;

LoadStarSprites:
L98AE:	LDY #$9F			;
L98B0:*	LDA IntroStarSprite00,Y		;
L98B3:	STA Sprite18RAM,Y		;Store RAM contents of $6E00 thru $6E9F -->
L98B6:	DEY 				;in sprite RAM at locations $0260 thru $02FF. 
L98B7:	CPY #$FF			;
L98B9:	BNE -				;
L98BB:	LDA #$00			;				
L98BD:	STA SpriteLoadPending		;Set $C8 to #$00.
L98BF:	RTS 				;

;The following values are loaded into RAM $6E00 thru $6E9F in InitBank0
;routine.  These values are then loaded into sprite RAM at $0260 thru $02FF
;in above routine.  They are the stars in the title screen.

IntroStarsData:
L98C0:	.byte $73, $CC, $22, $F2, $48, $CD, $63, $EE, $2A, $CE, $A2, $DC, $36, $CF, $E2, $C6
L98D0:	.byte $11, $CC, $23, $B7, $53, $CD, $63, $A0, $BB, $CE, $A2, $9A, $0F, $CF, $E2, $8B
L98E0:	.byte $85, $CC, $E2, $70, $9D, $CD, $A3, $6B, $A0, $CE, $63, $58, $63, $CF, $23, $4F
L98F0:	.byte $0A, $CC, $22, $39, $1F, $CD, $23, $2A, $7F, $CE, $A3, $1F, $56, $CF, $A2, $03
L9900:	.byte $4D, $CC, $E3, $AF, $3E, $CD, $63, $2B, $61, $CE, $E2, $4F, $29, $CF, $62, $6F
L9910:	.byte $8A, $CC, $23, $82, $98, $CD, $A3, $07, $AE, $CE, $E2, $CA, $B6, $CF, $63, $E3
L9920:	.byte $0F, $CC, $62, $18, $1F, $CD, $22, $38, $22, $CE, $A3, $5F, $53, $CF, $E2, $78
L9930:	.byte $48, $CC, $E3, $94, $37, $CD, $A3, $B3, $6F, $CE, $A3, $DC, $78, $CF, $22, $FE 
L9940:	.byte $83, $CC, $62, $0B, $9F, $CD, $23, $26, $A0, $CE, $62, $39, $BD, $CF, $A2, $1C
L9950:	.byte $07, $CC, $E3, $A4, $87, $CD, $63, $5D, $5A, $CE, $62, $4F, $38, $CF, $23, $85

;Not used.
L9960:	.byte $3F, $00, $20, $02, $20, $1B, $3A, $02, $20, $21, $01, $02, $2C, $30, $27, $02
L9970:	.byte $26, $31, $17, $02, $16, $19, $27, $02, $16, $20, $27, $02, $16, $20, $11, $02
L9980:	.byte $01, $20, $21, $00

L9984:	.byte $21			;PPU address high byte.
L9985:	.byte $8C			;PPU address low byte.
L9986:	.byte $05			;PPU string length.
;             'S    T    A    R    T'
L9987:	.byte $1C, $1D, $0A, $1B, $1D 					

L998C:	.byte $21			;PPU address high byte.
L998D:	.byte $EC			;PPU address low byte.
L998E:	.byte $08			;PPU string length.
;             'C    O    N    T    I    N    U    E'
L998F:	.byte $0C, $18, $17, $1D, $12, $17, $1E, $0E

L9997:	.byte $00		;End PPU string write 

;The following pointer table is used to find the start
;of each row on the password screen in the data below.

PasswordRowTbl:
L9998:	.word PasswordRow0		;($99A2)
L999A:	.word PasswordRow1		;($99AF)
L999C:	.word PasswordRow2		;($99BC)
L999E:	.word PasswordRow3		;($99C9)
L99A0:	.word PasswordRow4		;($99D6)

;The following data is used to load the name table With the password characters:
PasswordRow0:
L99A2:	.byte $00			;0
L99A3:	.byte $01			;1
L99A4:	.byte $02			;2
L99A5:	.byte $03			;3
L99A6:	.byte $04			;4
L99A7:	.byte $05			;5
L99A8:	.byte $06			;6
L99A9:	.byte $07			;7
L99AA:	.byte $08			;8
L99AB:	.byte $09			;9
L99AC:	.byte $0A			;A
L99AD:	.byte $0B			;B
L99AE:	.byte $0C			;C

PasswordRow1:
L99AF:	.byte $0D			;D
L99B0:	.byte $0E			;E
L99B1:	.byte $0F			;F
L99B2:	.byte $10			;G
L99B3:	.byte $11			;H
L99B4:	.byte $12			;I
L99B5:	.byte $13			;J
L99B6:	.byte $14			;K
L99B7:	.byte $15			;L
L99B8:	.byte $16			;M
L99B9:	.byte $17			;N
L99BA:	.byte $18			;O
L99BB:	.byte $19			;P

PasswordRow2:
L99BC:	.byte $1A			;Q
L99BD:	.byte $1B			;R
L99BE:	.byte $1C			;S
L99BF:	.byte $1D			;T
L99C0:	.byte $1E			;U
L99C1:	.byte $1F			;V
L99C2:	.byte $20			;W
L99C3:	.byte $21			;X
L99C4:	.byte $22			;Y
L99C5:	.byte $23			;Z
L99C6:	.byte $24			;a
L99C7:	.byte $25			;b
L99C8:	.byte $26			;c

PasswordRow3:
L99C9:	.byte $27			;d
L99CA:	.byte $28			;e
L99CB:	.byte $29			;f
L99CC:	.byte $2A			;g
L99CD:	.byte $2B			;h
L99CE:	.byte $2C			;i
L99CF:	.byte $2D			;j
L99D0:	.byte $2E			;k
L99D1:	.byte $2F			;l
L99D2:	.byte $30			;m
L99D3:	.byte $31			;n
L99D4:	.byte $32			;o
L99D5:	.byte $33			;p

PasswordRow4:
L99D6:	.byte $34			;q
L99D7:	.byte $35			;r
L99D8:	.byte $36			;s
L99D9:	.byte $37			;t
L99DA:	.byte $38			;u
L99DB:	.byte $39			;v
L99DC:	.byte $3A			;w
L99DD:	.byte $3B			;x
L99DE:	.byte $3C			;y
L99DF:	.byte $3D			;z
L99E0:	.byte $3E			;?
L99E1:	.byte $3F			;-
L99E2:	.byte $FF			;Space

;Writes 'PASSWORD PLEASE' on name table 0 in row $2080 (5th row from top).
L99E3:	.byte $20			;PPU address high byte.
L99E4:	.byte $88			;PPU address low byte.
L99E5:	.byte $10			;PPU string length.
;             'P    A    S    S    _    W    O    R    D    _    P    L    E    A    S    E'
L99E6:	.byte $19, $0A, $1C, $1C, $FF, $20, $18, $1B, $0D, $FF, $19, $15, $0E, $0A, $1C, $0E

;Clears attribute table 0 starting at address $23C0.
L99F6:	.byte $23			;PPU address high byte.
L99F7:	.byte $C0			;PPU address low byte.
L99F8:	.byte $50			;PPU string length.
L99F9:	.byte $00			;Repeat bit set. Repeats entry 16 times.

;Writes to attribute table 0 starting at address $23D0.
L99FA:	.byte $23			;PPU address high byte.
L99FB:	.byte $D0			;PPU address low byte.
L99FC:	.byte $48			;PPU string length.
L99FD:	.byte $55			;Repeat bit set. Repeats entry 8 times.

;Writes to attribute table 0 starting at address $23D8.
L99FE:	.byte $23			;PPU address high byte.
L99FF:	.byte $D8			;PPU address low byte.
L9A00:	.byte $60			;PPU string length.
L9A01:	.byte $FF			;Repeat bit set. Repeats entry 32 times.

;Writes to attribute table 0 starting at address $23DA.
L9A02:	.byte $23			;PPU address high byte.
L9A03:	.byte $DA			;PPU address low byte.
L9A04:	.byte $44			;PPU string length.
L9A05:	.byte $F0			;Repeat bit set. Repeats entry 4 times.

L9A06:	.byte $00			;End PPU string write. 

;----------------------------------------[ Ending routines ]-----------------------------------------

;The following routine is accessed via the NMI routine every frame.
NMIScreenWrite:
L9A07:	LDA TitleRoutine		;
L9A09:	CMP #$1D			;If titleRoutine not at end game, exit.
L9A0B:	BCC Exit100			;
L9A0D:	JSR LoadCredits			;($9C45)Display end credits on screen.
L9A10:	LDA EndMsgWrite			;
L9A12:	BEQ +				;If not time to write end message, branch
L9A14:	CMP #$05			;
L9A16:	BCS +				;If end message is finished being written, branch
L9A18:	ASL				;
L9A19:	TAY				;
L9A1A:	LDX EndMessageStringTbl0-2,Y	;Writes the end message on name table 0
L9A1D:	LDA EndMessageStringTbl0-1,Y	;
L9A20:	TAY				;
L9A21:	JSR PreparePPUProcess_		;($C20E)Prepare to write to PPU.
L9A24:*	LDA HideShowEndMsg		;
L9A26:	BEQ Exit100			;If not time to erase end message, branch
L9A28:	CMP #$05			;
L9A2A:	BCS Exit100			;If end message is finished being erased, branch
L9A2C:	ASL				;
L9A2D:	TAY				;
L9A2E:	LDX EndMessageStringTbl1-2,Y	;Erases the end message on name table 0
L9A31:	LDA EndMessageStringTbl1-1,Y	;
L9A34:	TAY 				;
L9A35:	JMP PreparePPUProcess_		;($C20E)Prepare to write to PPU.

Exit100:
L9A38:	RTS				;Exit from above and below routines.
 
Restart:
L9A39:	LDA Joy1Status			;
L9A3B:	AND #$10			;If start has not been pressed, branch to exit.
L9A3D:	BEQ Exit100			;
L9A3F:	LDY #$11			;
L9A41:	LDA #$00			;
L9A43:*	STA PasswordByte00,Y		;Erase PasswordByte00 thru PasswordByte11.
L9A46:	DEY				;
L9A47:	BPL -				;
L9A49:	INY				;Y = #$00.
L9A4A:*	STA UniqueItemHistory,Y		;
L9A4D:	INY				;Erase Unique item history.
L9A4E:	BNE -				;
L9A50:	LDA SamusGear			;
L9A53:	AND #$10			;
L9A55:	BEQ +				;If Samus does not have Maru Mari, branch.-->
L9A57:	LDA #$01			;Else load Maru Mari data into PasswordByte00.
L9A59:	STA PasswordByte00		;
L9A5C:*	LDA SamusGear			;
L9A5F:	AND #$01			;
L9A61:	BEQ +				;If Samus does not have bombs, branch.-->
L9A63:	LDA PasswordByte00		;Else load bomb data into PasswordByte00.
L9A66:	ORA #$40			;
L9A68:	STA PasswordByte00		;
L9A6B:*	LDA SamusGear			;
L9A6E:	AND #$20			;
L9A70:	BEQ +				;If Samus does not have varia suit, branch.-->
L9A72:	LDA #$08			;Else load varia suit data into PasswordByte01.
L9A74:	STA PasswordByte01		;
L9A77:*	LDA SamusGear			;
L9A7A:	AND #$02			;
L9A7C:	BEQ +				;If Samus does not have high jump, branch.-->
L9A7E:	LDA #$01			;Else load high jump data into PasswordByte03.
L9A80:	STA PasswordByte03		;
L9A83:*	LDA SamusGear			;
L9A86:	AND #$10			;If Samus does not have Maru Mari, branch.-->
L9A88:	BEQ +				;Else load screw attack data into PasswordByte03.-->
L9A8A:	LDA PasswordByte03		;A programmer error?  Should check for screw-->
L9A8D:	ORA #$04			;attack data.
L9A8F:	STA PasswordByte03		;
L9A92:*	LDA SamusGear			;
L9A95:	STA PasswordByte09		;Store Samus gear data in PasswordByte09.
L9A98:	LDA #$00			;
L9A9A:	LDY JustInBailey		;
L9A9D:	BEQ +				;If Samus is wearing suit, branch.  Else-->
L9A9F:	LDA #$80			;load suitless Samus data into PasswordByte08.
L9AA1:*	STA PasswordByte08		;
L9AA4:	JMP InitializeGame		;($92D4)Clear RAM to restart game at beginning.

EndGame:
L9AA7:	JSR LoadEndStarSprites		;($9EAA)Load stars in end scene onto screen.
L9AAA:	LDA IsCredits			;Skips palette change when rolling credits.
L9AAC:	BNE +				;
L9AAE:	LDA FrameCount			;
L9AB0:	AND #$0F			;Changes star palettes every 16th frame.
L9AB2:	BNE +				;
L9AB4:	INC PalDataPending		;
L9AB6:	LDA PalDataPending		;Reset palette data to #$01 after it-->
L9AB8:	CMP #$09			;reaches #$09.
L9ABA:	BNE +				;
L9ABC:	LDA #$01			;
L9ABE:	STA PalDataPending		;
L9AC0:*	LDA RoomPtr			;RoomPtr used in end of game to determine-->
L9AC2:	JSR ChooseRoutine		;($C27C)which subroutine to run below.

L9AC5:	.word LoadEndGFX		;($9AD5)Load end GFX to pattern tables.
L9AC7:	.word ShowEndSamus		;($9B1C)Show Samus and end message.
L9AC9:	.word EndSamusFlash		;($9B34)Samus flashes and changes.
L9ACB:	.word SamusWave			;($9B93)Samus waving in ending if suitless.
L9ACD:	.word EndFadeOut		;($9BCD)Fade out Samus in ending.
L9ACF:	.word RollCredits		;($9BFC)Rolls ending credits.
L9AD1:	.word Restart			;($9A39)Starts at beginning after game completed.
L9AD3:	.word ExitSub			;($C45C)Rts.

LoadEndGFX:
L9AD5:	JSR ClearAll			;($909F)Turn off screen, erase sprites and nametables.
L9AD8:	JSR InitEndGFX			;($C5D0)Prepare to load end GFX.
L9ADB:	LDA #$04			;
L9ADD:	LDY JustInBailey		;Checks if game was played as suitless-->
L9AE0:	BNE +				;Samus.  If so, branch.
L9AE2:	LDA #$00			;Loads SpritePointerIndex with #$00(suit on).
L9AE4:*	STA EndingType			;
L9AE7:	ASL				;Loads SpritePointerIndex with #$08(suitless).
L9AE8:	STA SpritePointerIndex		;
L9AEA:	LDX #$52			;Loads the screen where Samus stands on-->
L9AEC:	LDY #$A0			;the surface of the planet in end of game.
L9AEE:	JSR PreparePPUProcess_		;($C20E)Prepare to write to PPU.
L9AF1:	JSR NmiOn			;($C487)Turn on non-maskable interrupt.
L9AF4:	LDA #$20			;Initiate end game music.
L9AF6:	STA MultiSFXFlag		;
L9AF9:	LDA #$60			;Loads Timer3 with a delay of 960 frames-->
L9AFB:	STA Timer3			;(16 seconds).
L9AFD:	LDA #$36			;#$36/#$03 = #$12.  Number of sprites-->
L9AFF:	STA SpriteByteCounter		;used to draw end graphic of Samus.
L9B01:	LDA #$00			;
L9B03:	STA SpriteAttribByte		;
L9B05:	STA ColorCntIndex		;
L9B07:	STA IsCredits			;The following values are-->
L9B09:	STA EndMsgWrite			;initialized to #$00.
L9B0B:	STA HideShowEndMsg		;
L9B0D:	STA CreditPageNumber		;
L9B0F:	LDA #$01			;
L9B11:	STA PalDataPending		;Change palette.
L9B13:	LDA #$08			;
L9B15:	STA ClrChangeCounter		;Initialize ClrChangeCounter with #$08.
L9B17:	INC RoomPtr			;
L9B19:	JMP ScreenOn			;($C447)Turn screen on.

ShowEndSamus:
L9B1C:	JSR LoadEndSamusSprites		;($9C9A)Load end image of Samus.
L9B1F:	LDA Timer3			;Once 960 frames (16 seconds) have expired,-->
L9B21:	BNE +				;Move to EndSamusFlash routine.
L9B23:	INC RoomPtr			;
L9B25:	RTS				;

L9B26:*	CMP #$50			;After 160 frames have past-->
L9B28:	BNE +				;(2.6 seconds), write end message.
L9B2A:	INC EndMsgWrite			;
L9B2C:	RTS				;
L9B2D:*	CMP #$01			;After 950 frames have past-->
L9B2F:	BNE +				;(15.8 seconds), erase end message.
L9B31:	INC HideShowEndMsg		;
L9B33:*	RTS				;

EndSamusFlash:
L9B34:	LDA FrameCount			;If FrameCount not divisible by 32, branch.
L9B36:	AND #$1F			;
L9B38:	BNE +++				;
L9B3A:	INC ColorCntIndex		;Every 32 frame, increment the ColorCntInex-->
L9B3C:	LDA ColorCntIndex		;value.  Flashing Samus lasts for 512-->
L9B3E:	CMP #$08			;frames (8.5 seconds).
L9B40:	BNE +				;
L9B42:	JSR ChooseEnding		;($CAF5)Choose which Samus ending to show.
L9B45:	JSR CalculatePassword		;($8C7A)Calculate game password.
L9B48:	LDA EndingType			;
L9B4B:	ASL				;When EndSamusFlash routine is half way-->
L9B4C:	STA SpritePointerIndex		;done, this code will calculate the-->
L9B4E:	LDA #$36			;password and choose the proper ending.
L9B50:	STA SpriteByteCounter		;
L9B52:*	CMP #$10			;
L9B54:	BNE ++				;Once flashing Samus is compete, set Timer3-->
L9B56:	STA Timer3			;for a 160 frame(2.6 seconds) delay.
L9B58:	LDY #$00			;
L9B5A:	LDA EndingType			;
L9B5D:	CMP #$04			;If one of the suitless Samus endings,-->
L9B5F:	BCC +				;increment sprite color for proper-->
L9B61:	INY				;color to be displayed and increment-->
L9B62:*	STY SpriteAttribByte		;RoomPtr and erase the sprites.
L9B64:	INC RoomPtr			;
L9B66:	JMP EraseAllSprites		;($C1A3)Clear all sprites off the screen.
L9B69:*	DEC ClrChangeCounter		;Decrement ClrChangeCounter.
L9B6B:	BNE +				;
L9B6D:	LDY ColorCntIndex		;
L9B6F:	LDA PalChangeTable,Y		;When ClrChangeCounter=#$00, fetch new-->
L9B72:	STA ClrChangeCounter		;ClrChangeCounter value. and increment-->
L9B74:	INC SpriteAttribByte		;sprite color.  
L9B76:	LDA SpriteAttribByte		;
L9B78:	CMP #$03			;
L9B7A:	BNE +				;	
L9B7C:	LDA #$00			;If sprite color=#$03, set sprite-->
L9B7E:	STA SpriteAttribByte		;color to #$00.
L9B80:*	JMP LoadEndSamusSprites		;($9C9A)Load end image of Samus.

;The following table is used by the above routine to load ClrChangeCounter.  ClrChangeCounter
;decrements every frame, When ClrChangeCounter reaches zero, the sprite colors for Samus
;changes.  This has the effect of making Samus flash.  The flashing starts slow, speeds up,
;then slows down again.
PalChangeTable:
L9B83:	.byte $08, $07, $06, $05, $04, $03, $02, $01, $01, $02, $03, $04, $05, $06, $07, $08
 
SamusWave:
L9B93:	LDA Timer3			;If 160 frame timer from previous routine-->
L9B95:	BNE +				;has not expired, branch(waves for 2.6 seconds).
L9B97:	LDA #$10			;
L9B99:	STA Timer3			;Load Timer3 with 160 frame delay-->
L9B9B:	LDA #$08			;(2.6 seconds).
L9B9D:	STA PalDataPending		;Change palette
L9B9F:	INC RoomPtr			;Increment RoomPtr
L9BA1:	RTS				;

L9BA2:*	LDA EndingType			;If suitless Samus-->
L9BA5:	CMP #$04			;ending, branch.
L9BA7:	BCS +				;
L9BA9:	JMP LoadEndSamusSprites		;($9C9A)
L9BAC:*	SBC #$04			;If jumpsuit Samus ending,-->
L9BAE:	ASL				;WaveSpritePointer=#$00, if bikini-->
L9BAF:	ASL				;Samus ending, WaveSpritePointer=#$04.
L9BB0:	STA WaveSpritePointer		;
L9BB2:	LDA FrameCount			;
L9BB4:	AND #$08			;Every eigth frame count, change wave sprite data.
L9BB6:	BNE +				;
L9BB8:	LDY #$10			;Load WaveSpriteCounter with #$10(16 bytes of-->
L9BBA:	STY WaveSpriteCounter		;sprite data to be loaded).
L9BBC:	BNE ++				;Branch always.
L9BBE:*	INC WaveSpritePointer		;
L9BC0:	INC WaveSpritePointer		;When bit 3 of FrameCount is not set,-->
L9BC2:	LDY #$10			;Samus' waving hand is down.
L9BC4:	STY WaveSpriteCounter		;
L9BC6:*	LDA #$2D			;Load SpriteByteCounter in preparation for-->
L9BC8:	STA SpriteByteCounter		;refreshing Samus sprite bytes.
L9BCA:	JMP LoadWaveSprites		;($9C7F)Load sprites for waving Samus.

EndFadeOut:
L9BCD:	LDA Timer3			;If 160 frame delay from last routine has not-->
L9BCF:	BNE ++				;yet expired, branch.
L9BD1:	LDA IsCredits			;
L9BD3:	BNE +				;Branch always.

L9BD5:	LDA #$08			;*This code does not appear to be used.
L9BD7:	STA PalDataPending		;*Change palette.
L9BD9:	INC IsCredits			;*Increment IsCredits.

L9BDB:*	LDA FrameCount			;
L9BDD:	AND #$07			;Every seventh frame, increment the palette info-->
L9BDF:	BNE +				;If PalDataPending is not equal to #$0C, keep--> 
L9BE1:	INC PalDataPending		;incrementing every seventh frame until it does.-->
L9BE3:	LDA PalDataPending		;This creates the fade out effect.
L9BE5:	CMP #$0C			;
L9BE7:	BNE +				;
L9BE9:	LDA #$10			;After fadeout complete, load Timer3 with 160 frame-->
L9BEB:	STA Timer3			;delay(2.6 seconds) and increment RoomPtr.
L9BED:	INC RoomPtr			;
L9BEF:*	LDA EndingType			;
L9BF2:	CMP #$04			;If suitless Samus ending, load hand wave sprites,-->
L9BF4:	BCS +				;else just load regular Samus sprites
L9BF6:	JMP LoadEndSamusSprites		;($9C9A)Load end image of Samus.
L9BF9:*	JMP LoadWaveSprites		;($9C7F)Load sprites for waving Samus.

RollCredits:
L9BFC:	LDA Timer3			;If 160 frame timer delay from previous-->
L9BFE:	BEQ +				;routine has expired, branch.
L9C00:	CMP #$02			;If not 20 frames left in Timer3, branch to exit.
L9C02:	BNE ++++			;
L9C04:	JSR ScreenOff			;($C439)When 20 frames left in Timer3,-->
L9C07:	JSR ClearNameTable0		;($C16D)clear name table 0 and sprites.-->
L9C0A:	JSR EraseAllSprites		;($C1A3)prepares screen for credits.
L9C0D:	LDA #$0D			;
L9C0F:	STA PalDataPending		;Change to proper palette for credits.
L9C11:	JSR ScreenOn			;($C447)Turn screen on.
L9C14:	JMP WaitNMIPass_		;($C43F)Wait for NMI to end.
L9C17:*	LDA CreditPageNumber		;If first page of credits has not started to-->
L9C19:	BNE +				;roll, start it now, else branch.
L9C1B:	INC CreditPageNumber		;
L9C1D:*	CMP #$06			;If not at last page of credits, branch.
L9C1F:	BNE +				;
L9C21:	LDA ScrollY			;
L9C23:	CMP #$88			;If last page of credits is not finished-->
L9C25:	BCC +				;scrolling, branch.  Else increment to next-->
L9C27:	INC RoomPtr			;routine.
L9C29:	RTS				;

L9C2A:*	LDA FrameCount			;credits scroll up one position every 3 frames.
L9C2C:	AND #$03			;
L9C2E:	BNE +				;Ready to scroll? If not, branch.
L9C30:	INC ScrollY			;
L9C32:	LDA ScrollY			;Load ScrollY and check it to see if its-->
L9C34:	CMP #$F0			;position is at the very bottom on name table.-->
L9C36:	BNE +				;if not, branch.
L9C38:	INC CreditPageNumber		;
L9C3A:	LDA #$00			;
L9C3C:	STA ScrollY			;When Scrolly is at bottom of the name table,-->
L9C3E:	LDA PPUCNT0ZP			;Swap to next name table(0 or 2) and increment-->
L9C40:	EOR #$02			;CreditPageNumber.
L9C42:	STA PPUCNT0ZP			;
L9C44:*	RTS

;The following routine is checked every frame and is accessed via the NMIScreenWrite routine.
;The LoadCredits routine works like this: The Y scroll position is checked every frame.  When
;it is in the first four positions of the current name table (0, 1, 2 or 3), or the four
;positions right after 127 (128, 129, 130 and 131), the routine will then load the ending
;credits into the positions on the name table that were just scrolled over.  For example, If
;the scroll window is currently half way down name table 0, the LoadCredits routine will load
;the contents of the upper half of name table 0.  Also, name table 0 contains odd numbered
;pages and name table 2 contains even numbered pages.

LoadCredits:
L9C45:	LDY CreditPageNumber		;
L9C47:	BEQ ++++			;If credits are not being displayed, exit.
L9C49:	CPY #$07			;
L9C4B:	BCS ++++			;If CreditPageNumber is higher than #$06, exit.
L9C4D:	LDX #$00			;
L9C4F:	LDA ScrollY			;If ScrollY is less than #$80 (128), branch.
L9C51:	BPL +				;
L9C53:	INX				;Load X with sign bit (#$01) and remove-->
L9C54:	SEC				;sign bit from A.
L9C55:	SBC #$80			;
L9C57:*	CMP #$04			;
L9C59:	BCS +++				;If ScrollY is not #$04, branch to exit.
L9C5B:	STA $01				;Store #$00, #$01, #$02 or #$03 in address $01.
L9C5D:	DEY				;Y now contains CreditPageNumber - 1.
L9C5E:	TXA				;
L9C5F:	BNE +				;If ScrollY is #$80 (128) or greater, branch.
L9C61:	DEY				;Y now contains CreditPageNumber - 2.
L9C62:	BMI +++				;If on Credit page less than two , branch to exit.
L9C64:	TYA				;
L9C65:	ASL				;Start with CreditPageNumber - 2-->
L9C66:	ASL				;* 8 + 4 + $01 * 2.
L9C67:	ASL				;This formula is used when ScrollY = 0, 1, 2 and 3.
L9C68:	ADC #$04			;Result is index to find proper credits to load.
L9C6A:	BNE ++				;Branch always.
L9C6C:*	TYA				;
L9C6D:	ASL				;Start with CreditPageNumber - 1-->
L9C6E:	ASL				;* 8 + $01 * 2.
L9C6F:	ASL				;This formula is used when ScrollY = 128,-->
L9C70:*	ADC $01				;129, 130 and 131.
L9C72:	ASL				;Result is index to find proper credits to load.
L9C73:	TAY 				;
L9C74:	LDX CreditsPointerTbl,Y		;Base is $A291. Lower byte of pointer to PPU string.
L9C77:	LDA CreditsPointerTbl+1,Y	;Upper byte of pointer to PPU string.
L9C7A:	TAY 				;
L9C7B:	JMP PreparePPUProcess_		;($C20E)Prepare to write to PPU.
L9C7E:*	RTS				;
 
LoadWaveSprites:
L9C7F:	LDX WaveSpritePointer		;
L9C81:	LDA WavePointerTable,X		;
L9C84:	STA $00				;Load pointer to wave sprite data-->
L9C86:	LDA WavePointerTable+1,X	;into addresses $00 and $01.
L9C89:	STA $01				;
L9C8B:	LDX #$20			;Offset for sprite RAM load.
L9C8D:	LDY #$00			;
L9C8F:*	LDA ($00),Y			;
L9C91:	STA Sprite00RAM,X		;Load wave sprites into sprite RAM starting at-->
L9C94:	INX				;location $220 (Sprite08RAM).
L9C95:	INY				;
L9C96:	CPY WaveSpriteCounter		;Check to see if sprite RAM load complete.-->
L9C98:	BNE -				;If not, branch and load another byte.

LoadEndSamusSprites:
L9C9A:	LDX #$30			;Index for loading Samus sprite data into sprite RAM.
L9C9C:	LDY SpritePointerIndex		;
L9C9E:	LDA EndSamusAddrTbl,Y		;Base is $9D5A.
L9CA1:	STA $00				;Load $00 and $01 with pointer to the sprite-->
L9CA3:	LDA EndSamusAddrTbl+1,Y		;data that shows Samus at the end of the game.
L9CA6:	STA $01				;
L9CA8:	LDY #$00			;
L9CAA:*	LDA ($00),Y			;Load sprite data starting at Sprite0CRAM.
L9CAC:	STA Sprite00RAM,X		;Load sprite Y-coord.
L9CAF:	INX				;
L9CB0:	INY				;Increment X and Y.
L9CB1:	LDA ($00),Y			;
L9CB3:	BPL +				;If sprite pattern byte MSB cleared, branch.
L9CB5:	AND #$7F			;
L9CB7:	STA Sprite00RAM,X		;Remove MSB and write sprite pattern data-->
L9CBA:	LDA SpriteAttribByte		;to sprite RAM.
L9CBC:	EOR #$40			;
L9CBE:	BNE ++				;
L9CC0:*	STA Sprite00RAM,X		;Writes sprite pattern byte to--> 
L9CC3:	LDA SpriteAttribByte		;sprite RAM if its MSB is not set.
L9CC5:*	INX				;
L9CC6:	STA Sprite00RAM,X		;Writes sprite attribute byte to sprite RAM.
L9CC9:	INY				;
L9CCA:	INX 				;Increment X and Y.
L9CCB:	LDA ($00),Y			;
L9CCD:	STA Sprite00RAM,X		;Load sprite X-coord.
L9CD0:	INY				;
L9CD1:	INX				;Increment X and Y.
L9CD2:	CPY SpriteByteCounter		;
L9CD4:	BNE ---				;Repeat until sprite load is complete.
L9CD6:	LDA RoomPtr			;
L9CD8:	CMP #$02			;If not running the EndSamusFlash routine, branch.
L9CDA:	BCC ++				;
L9CDC:	LDA ColorCntIndex		;
L9CDE:	CMP #$08			;If EndSamusFlash routine is more than half-->
L9CE0:	BCC ++				;way done, Check ending type for the Samus helmet-->
L9CE2:	LDA EndingType			;off ending.  If not helmet off ending, branch.
L9CE5:	CMP #$03			;
L9CE7:	BNE ++				;
L9CE9:	LDY #$00			;
L9CEB:	LDX #$00			;
L9CED:*	LDA SamusHeadSpriteTble,Y	;The following code loads the sprite graphics-->
L9CF0:	STA Sprite00RAM,X		;when the helmet off ending is playing.  The-->
L9CF3:	INY 				;sprites below keep Samus head from flashing-->
L9CF4:	INX 				;while the rest of her body does.
L9CF5:	CPY #$18			;
L9CF7:	BNE -				;
L9CF9:*	RTS				;
 
;The following table is used by the routine above to keep Samus'
;head from flashing during the helmet off ending.

SamusHeadSpriteTble:
L9CFA:	.byte $93, $36, $01, $70	;Sprite00RAM
L9CFE:	.byte $93, $37, $01, $78	;Sprite01RAM
L9D02:	.byte $93, $38, $01, $80	;Sprite02RAM
L9D06:	.byte $9B, $46, $01, $70	;Sprite03RAM
L9D0A:	.byte $9B, $47, $01, $78	;Sprite04RAM
L9D0E:	.byte $9B, $48, $01, $80	;Sprite05RAM

;The following table is a pointer table to the sprites that makes Samus wave in the end
;of the game when she is suitless.  The top two pointers are for when she is in the jumpsuit
;and the bottom two pointers are for when she is in the bikini.

WavePointerTable:
L9D12:	.word $9D1A			;Jumpsuit Samus hand up.
L9D14:	.word $9D2A			;Jumpsuit Samus hand down.
L9D16:	.word $9D3A			;Bikini Samus hand up.
L9D18:	.word $9D4A			;Bikini Samus hand down.

;Sprite data table used when Samus is in jumpsuit and her waving hand is up.
JsHandUpTable:
L9D1A:	.byte $9B, $1F, $01, $80, $A3, $2F, $01, $80, $AB, $3F, $01, $80, $F4, $3F, $01, $80

;Sprite data table used when Samus is in jumpsuit and her waving hand is down.
JsHandDownTable:
L9D2A:	.byte $9B, $2A, $01, $80, $9B, $2B, $01, $88, $A3, $3A, $01, $80, $AB, $3F, $01, $80

;Sprite data table used when Samus is in bikini and her waving hand is up.
BkHandUpTable:
L9D3A:	.byte $9B, $0C, $01, $80, $A3, $1C, $01, $80, $AB, $3F, $01, $80, $F4, $3F, $01, $80

;Sprite data table used when Samus is in bikini and her waving hand is down.
BkHandDownTable:
L9D4A:	.byte $9B, $4A, $01, $80, $9B, $4B, $01, $88, $A3, $4D, $01, $80, $AB, $3F, $01, $80

EndSamusAddrTbl:
L9D5A:	.word NormalSamus		;($9D66)Pointer to end graphic of Samus wearing suit.
L9D5C:	.word BackTurnedSamus		;($9D9C)Pointer to end graphic of back turned Samus.
L9D5E:	.word FistRaisedSamus		;($9DD2)Pointer to end graphic of fist raised Samus.
L9D60:	.word HelmetOffSamus		;($9E08)Pointer to end graphic of helmet off Samus.
L9D62:	.word JumpsuitSamus		;($9E3E)Pointer to end graphic of jumpsuit Samus.
L9D64:	.word BikiniSamus		;($9E74)Pointer to end graphic of bikini Samus.

;The following three bytes are loaded into sprite RAM.  The third byte (attribute byte) is
;not included.  Instead, if the MSB of the second byte (pattern byte) is set, the pattern
;byte is flipped horizontally (mirror image).  If pattern byte MSB is not set, the attribute
;byte is stored as #$00.  This is done so the code can generate the flashing Samus effect at
;the end of the game.

NormalSamus:
L9D66:	.byte $93, $00, $70
L9D69:	.byte $93, $01, $78
L9D6C:	.byte $93, $80, $80		;Mirrored pattern at pattern table location $00.
L9D6F:	.byte $9B, $10, $70
L9D72:	.byte $9B, $11, $78
L9D75:	.byte $9B, $90, $80		;Mirrored pattern at pattern table location $10.
L9D78:	.byte $A3, $20, $70
L9D7B:	.byte $A3, $21, $78
L9D7E:	.byte $A3, $22, $80
L9D81:	.byte $AB, $30, $70
L9D84:	.byte $AB, $31, $78
L9D87:	.byte $AB, $32, $80
L9D8A:	.byte $B3, $40, $70
L9D8D:	.byte $B3, $41, $78
L9D90:	.byte $B3, $C0, $80
L9D93:	.byte $BB, $50, $70
L9D96:	.byte $BB, $49, $78
L9D99:	.byte $BB, $D0, $80		;Mirrored pattern at pattern table location $50.

BackTurnedSamus:
L9D9C:	.byte $93, $02, $70
L9D9F:	.byte $93, $03, $78
L9DA2:	.byte $93, $04, $80
L9DA5:	.byte $9B, $12, $70
L9DA8:	.byte $9B, $13, $78
L9DAB:	.byte $9B, $14, $80
L9DAE:	.byte $A3, $05, $70
L9DB1:	.byte $A3, $06, $78
L9DB4:	.byte $A3, $07, $80
L9DB7:	.byte $AB, $15, $70
L9DBA:	.byte $AB, $16, $78
L9DBD:	.byte $AB, $17, $80
L9DC0:	.byte $B3, $08, $70
L9DC3:	.byte $B3, $09, $78
L9DC6:	.byte $B3, $88, $80		;Mirrored pattern at pattern table location $08.
L9DC9:	.byte $BB, $18, $70
L9DCC:	.byte $BB, $19, $78
L9DDF:	.byte $BB, $98, $80		;Mirrored pattern at pattern table location $18.

FistRaisedSamus:
L9DD2:	.byte $93, $00, $70
L9DD5:	.byte $93, $01, $78
L9DD8:	.byte $93, $34, $80
L9DDB:	.byte $9B, $10, $70
L9DDE:	.byte $9B, $11, $78
L9DE1:	.byte $9B, $44, $80
L9DE4:	.byte $A3, $20, $70
L9DE7:	.byte $A3, $21, $78
L9DEA:	.byte $A3, $33, $80
L9DED:	.byte $AB, $30, $70
L9DF0:	.byte $AB, $31, $78
L9DF3:	.byte $AB, $43, $80
L9DF6:	.byte $B3, $40, $70
L9DF9:	.byte $B3, $41, $78
L9DFC:	.byte $B3, $C0, $80		;Mirrored pattern at pattern table location $40.
L9DFF:	.byte $BB, $50, $70
L9E02:	.byte $BB, $49, $78
L9E05:	.byte $BB, $D0, $80		;Mirrored pattern at pattern table location $50.

HelmetOffSamus:
L9E08:	.byte $93, $0D, $70
L9E0B:	.byte $93, $0E, $78
L9E0E:	.byte $93, $0F, $80
L9E11:	.byte $9B, $35, $70
L9E14:	.byte $9B, $27, $78
L9E17:	.byte $9B, $28, $80
L9E1A:	.byte $A3, $20, $70
L9E1D:	.byte $A3, $21, $78
L9E20:	.byte $A3, $22, $80
L9E23:	.byte $AB, $30, $70
L9E26:	.byte $AB, $31, $78
L9E29:	.byte $AB, $32, $80
L9E2C:	.byte $B3, $40, $70
L9E2F:	.byte $B3, $41, $78
L9E32:	.byte $B3, $C0, $80		;Mirrored pattern at pattern table location $40.
L9E35:	.byte $BB, $50, $70
L9E38:	.byte $BB, $49, $78
L9E3B:	.byte $BB, $D0, $80		;Mirrored pattern at pattern table location $50.

JumpsuitSamus:
L9E3E:	.byte $93, $0D, $70
L9E41:	.byte $93, $0E, $78
L9E44:	.byte $93, $0F, $80
L9E47:	.byte $9B, $1D, $70
L9E4A:	.byte $9B, $1E, $78
L9E4D:	.byte $A3, $2D, $70
L9E50:	.byte $A3, $2E, $78
L9E53:	.byte $AB, $3D, $70
L9E56:	.byte $AB, $3E, $78
L9E59:	.byte $B3, $08, $70
L9E5C:	.byte $B3, $4E, $78
L9E5F:	.byte $B3, $4F, $80
L9E62:	.byte $BB, $45, $70
L9E65:	.byte $BB, $3B, $78
L9E68:	.byte $BB, $51, $80
L9E6B:	.byte $9B, $29, $80
L9E6E:	.byte $A3, $39, $80
L9E71:	.byte $AB, $4C, $80 

BikiniSamus:
L9E74:	.byte $93, $0D, $70
L9E77:	.byte $93, $0E, $78
L9E7A:	.byte $93, $0F, $80
L9E7D:	.byte $9B, $0A, $70
L9E80:	.byte $9B, $0B, $78
L9E83:	.byte $A3, $1A, $70
L9E86:	.byte $A3, $1B, $78
L9E89:	.byte $AB, $3D, $70
L9E8C:	.byte $AB, $3E, $78
L9E8F:	.byte $B3, $08, $70
L9E92:	.byte $B3, $4E, $78
L9E95:	.byte $B3, $4F, $80
L9E98:	.byte $BB, $45, $70
L9E9B:	.byte $BB, $3B, $78
L9E9E:	.byte $BB, $51, $80
L9EA1:	.byte $9B, $2C, $80
L9EA4:	.byte $A3, $3C, $80
L9EA7:	.byte $AB, $4C, $80 

LoadEndStarSprites:
L9EAA:	LDY #$00			;
L9EAC:*	LDA EndStarDataTable,Y		;
L9EAF:	STA Sprite1CRAM,Y		;Load the table below into sprite RAM-->
L9EB2:	INY 				;starting at address $0270.
L9EB3:	CPY #$9C			;
L9EB5:	BNE -				;
L9EB7:	RTS 

;Loaded into sprite RAM by routine above. Displays stars at the end of the game.

EndStarDataTable:
L9EB8:	.byte $08, $23, $22, $10
L9EBC:	.byte $68, $23, $23, $60
L9EC0:	.byte $00, $23, $22, $60
L9EC4:	.byte $7F, $23, $23, $6A
L9EC8:	.byte $7F, $23, $22, $D4
L9ECC:	.byte $33, $23, $23, $B2
L9ED0:	.byte $93, $23, $22, $47
L9ED4:	.byte $B3, $23, $23, $95
L9ED8:	.byte $0B, $23, $22, $E2
L9EDC:	.byte $1C, $23, $23, $34
L9EE0:	.byte $84, $23, $22, $18
L9EE4:	.byte $B2, $23, $23, $EE
L9EE8:	.byte $40, $23, $22, $22
L9EEC:	.byte $5A, $23, $23, $68
L9EF0:	.byte $1A, $23, $22, $90
L9EF4:	.byte $AA, $23, $23, $22
L9EF8:	.byte $81, $24, $22, $88
L9EFC:	.byte $6A, $24, $23, $D0
L9F00:	.byte $A8, $24, $22, $A0
L9F04:	.byte $10, $24, $23, $70
L9F08:	.byte $15, $25, $22, $42
L9F0C:	.byte $4A, $25, $23, $7D
L9F10:	.byte $30, $25, $22, $50
L9F14:	.byte $5A, $25, $23, $49
L9F18:	.byte $50, $25, $22, $B9
L9F1C:	.byte $91, $25, $23, $B0
L9F20:	.byte $19, $25, $22, $C0
L9F24:	.byte $53, $25, $23, $BA
L9F28:	.byte $A4, $25, $22, $D6
L9F2C:	.byte $98, $25, $23, $1A
L9F30:	.byte $68, $25, $22, $0C
L9F34:	.byte $97, $25, $23, $EA
L9F38:	.byte $33, $25, $22, $92
L9F3C:	.byte $43, $25, $23, $65
L9F40:	.byte $AC, $25, $22, $4A
L9F44:	.byte $2A, $25, $23, $71
L9F48:	.byte $7C, $26, $22, $B2
L9F4C:	.byte $73, $26, $23, $E7
L9F50:	.byte $0C, $26, $22, $AA

EndGamePalWrite:
L9F54:	LDA PalDataPending		;If no palette data pending, branch to exit.
L9F56:	BEQ ++				;
L9F58:	CMP #$0C			;If PalDataPending has loaded last palette,-->
L9F5A:	BEQ ++				;branch to exit.
L9F5C:	CMP #$0D			;Once end palettes have been cycled through,-->
L9F5E:	BNE +				;start over.
L9F60:	LDY #$00			;
L9F62:	STY PalDataPending		;
L9F64:*	ASL				;* 2, pointer is two bytes.
L9F65:	TAY				;
L9F66:	LDA EndGamePalPntrTbl-1,Y	;High byte of PPU data pointer.
L9F69:	LDX EndGamePalPntrTbl-2,Y	;Low byte of PPU data pointer.
L9F6C:	TAY				;
L9F6D:	JSR PreparePPUProcess_		;($C20E)Prepare to write data string to PPU.
L9F70:	LDA #$3F			;
L9F72:	STA PPUAddress			;
L9F75:	LDA #$00			;
L9F77:	STA PPUAddress			;Set PPU address to $3F00.
L9F7A:	STA PPUAddress			;
L9F7D:	STA PPUAddress			;Set PPU address to $0000.
L9F80:*	RTS				;

;The following pointer table is used by the routine above to
;find the proper palette data during the EndGame routine.

EndGamePalPntrTbl:
L9F81:	.word EndGamePal00		;($9F9B)
L9F83:	.word EndGamePal01		;($9FBF)
L9F85:	.word EndGamePal02		;($9FCB)
L9F87:	.word EndGamePal03		;($9FD7)
L9F89:	.word EndGamePal04		;($9FE3)
L9F8B:	.word EndGamePal05		;($9FEF)
L9F8D:	.word EndGamePal06		;($9FFB)
L9F8F:	.word EndGamePal07		;($A007)
L9F91:	.word EndGamePal08		;($A013)
L9F93:	.word EndGamePal09		;($A02E)
L9F95:	.word EndGamePal0A		;($A049)
L9F97:	.word EndGamePal0A		;($A049)
L9F99:	.word EndGamePal0B		;($9806)

EndGamePal00:
L9F9B:	.byte $3F			;PPU address high byte.
L9F9C:	.byte $00			;PPU address low byte.
L9F9D:	.byte $20			;PPU string length.
;The following values are written to the background palette:
L9F9E:	.byte $0F, $21, $11, $02, $0F, $29, $1B, $1A, $0F, $27, $28, $29, $0F, $28, $18, $08
;The following values are written to the sprite palette:
L9FAE:	.byte $0F, $16, $19, $27, $0F, $36, $15, $17, $0F, $12, $21, $20, $0F, $35, $12, $16 

L9FBE:	.byte $00			;End EndGamePal00 data.

EndGamePal01:
L9FBF:	.byte $3F			;PPU address high byte.
L9FC0:	.byte $18			;PPU address low byte.
L9FC1:	.byte $08			;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
L9FC2:	.byte $0F, $10, $20, $30, $0F, $0F, $0F, $0F

L9FCA:	.byte $00			;End EndGamePal01 data.

EndGamePal02:
L9FCB:	.byte $3F			;PPU address high byte.
L9FCC:	.byte $18			;PPU address low byte.
L9FCD:	.byte $08			;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
L9FCE:	.byte $0F, $12, $22, $32, $0F, $0B, $1B, $2B

L9FD6:	.byte $00			;End EndGamePal02 data.

EndGamePal03:
L9FD7:	.byte $3F			;PPU address high byte.
L9FD8:	.byte $18			;PPU address low byte.
L9FD9:	.byte $08			;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
L9FDA:	.byte $0F, $14, $24, $34, $0F, $09, $19, $29 

L9FE2:	.byte $00			;End EndGamePal03 data.

EndGamePal04:
L9FE3:	.byte $3F			;PPU address high byte.
L9FE4:	.byte $18			;PPU address low byte.
L9FE5:	.byte $08			;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
L9FE6:	.byte $0F, $16, $26, $36, $0F, $07, $17, $27

L9FEE:	.byte $00			;End EndGamePal04 data.

EndGamePal05:
L9FEF:	.byte $3F			;PPU address high byte.
L9FF0:	.byte $18			;PPU address low byte.
L9FF1:	.byte $08			;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
L9FF2:	.byte $0F, $18, $28, $38, $0F, $05, $15, $25 

L9FFA:	.byte $00			;End EndGamePal05 data.

EndGamePal06:
L9FFB:	.byte $3F			;PPU address high byte.
L9FFC:	.byte $18			;PPU address low byte.
L9FFD:	.byte $08			;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
L9FFE:	.byte $0F, $1A, $2A, $3A, $0F, $03, $13, $13

LA006:	.byte $00			;End EndGamePal06 data.

EndGamePal07:
LA007:	.byte $3F			;PPU address high byte.
LA008:	.byte $18			;PPU address low byte.
LA009:	.byte $08			;PPU string length.
;The following values are written to the sprite palette starting at $3F18:
LA00A:	.byte $0F, $1C, $2C, $3C, $0F, $01, $11, $21 

LA012:	.byte $00			;End EndGamePal07 data.

EndGamePal08:
LA013:	.byte $3F			;PPU address high byte.
LA014:	.byte $0C			;PPU address low byte.
LA015:	.byte $04			;PPU string length.
;The following values are written to the background palette starting at $3F0C:
LA016:	.byte $0F, $18, $08, $07

LA01A:	.byte $3F			;PPU address high byte.
LA01B:	.byte $10			;PPU address low byte.
LA01C:	.byte $10			;PPU string length.
;The following values are written to the sprite palette:
LA01D:	.byte $0F, $26, $05, $07, $0F, $26, $05, $07, $0F, $01, $01, $05, $0F, $13, $1C, $0C

LA02D:	.byte $00			;End EndGamePal08 data.

EndGamePal09:
LA02E:	.byte $3F			;PPU address high byte.
LA02F:	.byte $0C			;PPU address low byte.
LA030:	.byte $04			;PPU string length.
;The following values are written to the background palette starting at $3F0C:
LA031:	.byte $0F, $08, $07, $0F

LA035:	.byte $3F			;PPU address high byte.
LA036:	.byte $10			;PPU address low byte.
LA037:	.byte $10			;PPU string length.
;The following values are written to the sprite palette:
LA038:	.byte $0F, $06, $08, $0F, $0F, $06, $08, $0F, $0F, $00, $10, $0F, $0F, $01, $0C, $0F

LA048:	.byte $00			;End EndGamePal09 data.

EndGamePal0A:
LA049:	.byte $3F			;PPU address high byte.
LA04A:	.byte $0C			;PPU address low byte.
LA04B:	.byte $44			;PPU string length.
LA04C:	.byte $0F			;Repeat bit set. Fill background palette with #$0F-->
					;starting at $0C.
LA04D:	.byte $3F			;PPU address high byte.
LA04E:	.byte $10			;PPU address low byte.
LA04F:	.byte $50			;PPU string length.
LA050:	.byte $0F			;Repeat bit set. Fill sprite palette with #$0F.

LA051:	.byte $00			;End EndGamePal0A data.

;The following data writes the end game backgroud graphics.

;Writes ground graphics on name table 0 in row $2300 (25th row from top).
LA052:	.byte $23			;PPU address high byte.
LA053:	.byte $00			;PPU address low byte.
LA054:	.byte $20			;PPU string length.
LA055:	.byte $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31
LA065:	.byte $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31, $30, $31

;Writes ground graphics on name table 0 in row $2320 (26th row from top).
LA075:	.byte $23			;PPU address high byte.
LA076:	.byte $20			;PPU address low byte.
LA077:	.byte $20			;PPU string length.
LA078:	.byte $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33
LA088:	.byte $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33, $32, $33

;Writes ground graphics on name table 0 in row $2340 (27th row from top).
LA098:	.byte $23			;PPU address high byte.
LA099:	.byte $40			;PPU address low byte.
LA09A:	.byte $20			;PPU string length.
LA09B:	.byte $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35
LA0AB:	.byte $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35, $34, $35

;Writes ground graphics on name table 0 in row $2360 (28th row from top).
LA0BB:	.byte $23			;PPU address high byte.
LA0BC:	.byte $60			;PPU address low byte.
LA0BD:	.byte $20			;PPU string length.
LA0BE:	.byte $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37
LA0CE:	.byte $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37, $36, $37

;Writes ground graphics on name table 0 in row $2380 (29th row from top).
LA0DE:	.byte $23			;PPU address high byte.
LA0DF:	.byte $80			;PPU address low byte.
LA0E0:	.byte $20			;PPU string length.
LA0E1:	.byte $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39
LA0F1:	.byte $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39, $38, $39

;Writes ground graphics on name table 0 in row $23A0 (bottom row).
LA101:	.byte $23			;PPU address high byte.
LA102:	.byte $A0			;PPU address low byte.
LA103:	.byte $20			;PPU string length.
LA104:	.byte $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B
LA114:	.byte $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B, $3A, $3B

;Sets all color bits in attribute table 0 starting at $23F0.
LA124:	.byte $23			;PPU address high byte.
LA125:	.byte $F0			;PPU address low byte.
LA126:	.byte $50			;PPU string length.
LA127:	.byte $FF			;Repeat bit set. Repeats entry 16 times.

;Writes credits on name table 2 in row $2820 (2nd row from top).
LA128:	.byte $28			;PPU address high byte.
LA129:	.byte $2E			;PPU address low byte.
LA12A:	.byte $05			;PPU string length.
;             'S    T    A    F    F'
LA12B:	.byte $1C, $1D, $0A, $0F, $0F

;Writes credits on name table 2 in row $28A0 (6th row from top).
LA130:	.byte $28			;PPU address high byte.
LA131:	.byte $A8			;PPU address low byte.
LA132:	.byte $13			;PPU string length.
;             'S    C    E    N    A    R    I    O    _    W    R    I    T    T    E    N'
LA133:	.byte $1C, $0C, $0E, $17, $0A, $1B, $12, $18, $FF, $20, $1B, $12, $1D, $1D, $0E, $17
;             '_    B    Y'
LA143:	.byte $FF, $0B, $22

;Writes credits on name table 2 in row $28E0 (8th row from top).
LA146:	.byte $28			;PPU address high byte.
LA147:	.byte $EE			;PPU address low byte.
LA148:	.byte $05			;PPU string length.
;             'K    A    N    O    H'
LA149:	.byte $14, $0A, $17, $18, $11

;Writes credits on name table 2 in row $2960 (12th row from top).
LA14E:	.byte $29			;PPU address high byte.
LA14F:	.byte $66			;PPU address low byte.
LA150:	.byte $15			;PPU string length.
;             'C    H    A    R    A    C    T    E    R    _    D    E    S    I    G    N'
LA151:	.byte $0C, $11, $0A, $1B, $0A, $0C, $1D, $0E, $1B, $FF, $0D, $0E, $1C, $12, $10, $17
;             'E    D    _    B    Y'
LA161:	.byte $0E, $0D, $FF, $0B, $22

;Writes credits on name table 2 in row $29A0 (14th row from top).
LA166:	.byte $29			;PPU address high byte.
LA167:	.byte $AC			;PPU address low byte.
LA168:	.byte $08			;PPU string length.
;             'K    I    Y    O    T    A    K    E'
LA169:	.byte $14, $12, $22, $18, $1D, $0A, $14, $0E

;Writes credits on name table 2 in row $2A20 (18th row from top).
LA16A:	.byte $2A			;PPU address high byte.
LA16B:	.byte $2B			;PPU address low byte.
LA173:	.byte $0C			;PPU string length.
;             'N    E    W    _    M    A    T    S    U    O    K    A'
LA174:	.byte $17, $0E, $20, $FF, $16, $0A, $1D, $1C, $1E, $18, $14, $0A

;Writes credits on name table 2 in row $2A60 (20th row from top).
LA180:	.byte $2A			;PPU address high byte.
LA181:	.byte $6C			;PPU address low byte.
LA182:	.byte $09			;PPU string length.
;             'S    H    I    K    A    M    O    T    O'
LA183:	.byte $1C, $11, $12, $14, $0A, $16, $18, $1D, $18

;Writes credits on name table 2 in row $2AE0 (24th row from top).
LA18C:	.byte $2A			;PPU address high byte.
LA18D:	.byte $EC			;PPU address low byte.
LA18E:	.byte $08			;PPU string length.
;             'M    U    S    I    C    _    B    Y'
LA18F:	.byte $16, $1E, $1C, $12, $0C, $FF, $0B, $22

;Writes credits on name table 2 in row $2B20 (26th row from top)
LA197:	.byte $2B			;PPU address high byte.
LA198:	.byte $2B			;PPU address low byte.
LA199:	.byte $0A			;PPU string length.
;             'H    I    P    _    T    A    N    A    K    A'
LA19A:	.byte $11, $12, $19, $FF, $1D, $0A, $17, $0A, $14, $0A

;Writes credits on name table 2 in row $2BA0 (bottom row).
LA1A4:	.byte $2B			;PPU address high byte.
LA1A5:	.byte $A7			;PPU address low byte.
LA1A6:	.byte $12			;PPU string length.
;             '_    M    A    I    N    _    P    R    O    G    R    A    M    M    E    R'
LA1A7:	.byte $FF, $16, $0A, $12, $17, $FF, $19, $1B, $18, $10, $1B, $0A, $16, $16, $0E, $1B
;             'S    _'
LA1B7:	.byte $1C, $FF

LA1B9:	.byte $00			;End PPU string write.

;The following pointer table is accessed by the NMIScreenWrite routine. 
;It is used to locate the start of the PPU strings below.

EndMessageStringTbl0:
LA1BA:	.word $A1C2, $A1EB, $A20F, $A240

;Writes end message on name table 0 in row $2060 (4th row from top).
LA1C2:	.byte $20			;PPU address high byte.
LA1C3:	.byte $6D			;PPU address low byte.
LA1C4:	.byte $08			;PPU string length.
;             'G    R    E    A    T    _    !    !'
LA1C5:	.byte $10, $1B, $0E, $0A, $1D, $FF, $3F, $3F

;Writes end message on name table 0 in row $20C0 (7th row from top).
LA1CD:	.byte $20			;PPU address high byte.
LA1CE:	.byte $C3			;PPU address low byte.
LA1CF:	.byte $1A			;PPU string length.
;             'Y    O    U    _    F    U    L    F    I    L    E    D    _    Y    O    U'
LA1D0:	.byte $22, $18, $1E, $FF, $0F, $1E, $15, $0F, $12, $15, $0E, $0D, $FF, $22, $18, $1E
;             'R    _    M    I    S    S    I    O    N    .'
LA1E0:	.byte $1B, $FF, $16, $12, $1C, $1C, $12, $18, $17, $07

LA1EA:	.byte $00			;End PPU string write.

;Writes end message on name table 0 in row $2100 (9th row from top).
LA1EB:	.byte $21			;PPU address high byte.
LA1EC:	.byte $03			;PPU address low byte.
LA1ED:	.byte $17			;PPU string length.
;             'I    T    _    W    I    L    L    _    R    E    V    I    V    E    _    P'
LA1EE:	.byte $12, $1D, $FF, $20, $12, $15, $15, $FF, $1B, $0E, $1F, $12, $1F, $0E, $FF, $19
;             'E    A    C    E    _    I    N'
LA1FE:	.byte $0E, $0A, $0C, $0E, $FF, $12, $17

;Writes end message on name table 0 in row $2140 (11th row from top).
LA205:	.byte $21			;PPU address high byte.
LA206:	.byte $42			;PPU address low byte.
LA207:	.byte $06			;PPU string length.
;             'S    P    A    C    E    .'
LA208:	.byte $1C, $19, $0A, $0C, $0E, $07

LA209:	.byte $00			;End PPU string write.

;Writes end message on name table 0 in row $2180 (13th row from top).
LA20F:	.byte $21			;PPU address high byte.
LA210:	.byte $83			;PPU address low byte.
LA211:	.byte $18			;PPU string length.
;             'B    U    T    ,    I    T    _    M    A    Y    _    B    E    _    I    N'
LA212:	.byte $0B, $1E, $1D, $00, $12, $1D, $FF, $16, $0A, $22, $FF, $0B, $0E, $FF, $12, $17
;             'V    A    D    E    D    _    B    Y'
LA222:	.byte $1F, $0A, $0D, $0E, $0D, $FF, $0B, $22

;Writes end message on name table 0 in row $21C0 (15th row from top).
LA22A:	.byte $21			;PPU address high byte.
LA22B:	.byte $C2			;PPU address low byte.
LA22C:	.byte $12			;PPU string length.
;             'T    H    E    _    O    T    H    E    R    _    M    E    T    R    O    I'
LA22D:	.byte $1D, $11, $0E, $FF, $18, $1D, $11, $0E, $1B, $FF, $16, $0E, $1D, $1B, $18, $12
;             'D    .'
LA23D:	.byte $0D, $07

LA23F:	.byte $00			;End PPU string write.

;Writes end message on name table 0 in row $2200 (18th row from top).
LA240:	.byte $22			;PPU address high byte.
LA241:	.byte $03			;PPU address low byte.
LA242:	.byte $18			;PPU string length.
;             'P    R    A    Y    _    F    O    R    _    A    _    T    R    U    E    _'
LA243:	.byte $19, $1B, $0A, $22, $FF, $0F, $18, $1B, $FF, $0A, $FF, $1D, $1B, $1E, $0E, $FF
;             'P    E    A    C    E    _    I    N'
LA253:	.byte $19, $0E, $0A, $0C, $0E, $FF, $12, $17

;Writes end message on name table 0 in row $2240 (19th row from top).
LA25B:	.byte $22			;PPU address high byte.
LA25C:	.byte $42			;PPU address low byte.
LA25D:	.byte $06			;PPU string length.
;             'S    P    A    C    E    !'
LA25E:	.byte $1C, $19, $0A, $0C, $0E, $3F 

LA25F:	.byte $00			;End PPU string write.

;The following pointer table is accessed by the NMIScreenWrite routine.
;It is used to locate the start of the PPU strings below.

EndMessageStringTbl1:
LA265:	.word $A26D, $A276, $A27F, $A288

;Erases end message on name table 0 in row $2060 (4th row from top).
LA26D:	.byte $20			;PPU address high byte.
LA26E:	.byte $6D			;PPU address low byte.
LA26F:	.byte $48			;PPU string length.
LA270:	.byte $FF			;Repeat bit set. Repeats entry 8 times.

;Erases end message on name table 0 in row $20C0 (7th row from top).
LA271:	.byte $20			;PPU address high byte.
LA272:	.byte $C3			;PPU address low byte.
LA273:	.byte $5A			;PPU string length.
LA274:	.byte $FF			;Repeat bit set. Repeats entry 26 times.

LA275:	.byte $00			;End PPU string write.

;Erases end message on name table 0 in row $2100 (9th row from top).
LA276:	.byte $21			;PPU address high byte.
LA277:	.byte $03			;PPU address low byte.
LA278:	.byte $57			;PPU string length.
LA279:	.byte $FF			;Repeat bit set. Repeats entry 23 times.

;Erases end message on name table 0 in row $2140 (11th row from top).
LA27A:	.byte $21			;PPU address high byte.
LA27B:	.byte $42			;PPU address low byte.
LA27C:	.byte $4A			;PPU string length.
LA27D:	.byte $FF			;Repeat bit set. Repeats entry 10 times.

LA27E:	.byte $00			;End PPU string write.

;Erases end message on name table 0 in row $2180 (13th row from top).
LA27F:	.byte $21			;PPU address high byte.
LA280:	.byte $83			;PPU address low byte.
LA281:	.byte $58			;PPU string length.
LA282:	.byte $FF			;Repeat bit set. Repeats entry 24 times.

;Erases end message on name table 0 in row $21C0 (15th row from top).
LA283:	.byte $21			;PPU address high byte.
LA284:	.byte $C2			;PPU address low byte.
LA285:	.byte $52			;PPU string length.
LA286:	.byte $FF			;Repeat bit set. Repeats entry 12 times.

LA287:	.byte $00			;End PPU string write.

;Erases end message on name table 0 in row $2200 (18th row from top).
LA288:	.byte $22			;PPU address high byte.
LA289:	.byte $03			;PPU address low byte.
LA28A:	.byte $58			;PPU string length.
LA28B:	.byte $FF			;Repeat bit set. Repeats entry 24 times.


;Erases end message on name table 0 in row $2240 (19th row from top).
LA28C:	.byte $22			;PPU address high byte.
LA28D:	.byte $42			;PPU address low byte.
LA28E:	.byte $4A			;PPU string length.
LA28F:	.byte $FF			;Repeat bit set. Repeats entry 10 times.

LA290:	.byte $00			;End PPU string write

;The following table is used by the LoadCredits routine to load the end credits on the screen.

CreditsPointerTbl:
LA291:	.word $A2E9, $A2FB, $A31A, $A31B, $A32D, $A339, $A34F, $A362, $A375, $A384, $A39F, $A3AA
LA2A9:	.word $A3C8, $A3D8, $A3F1, $A412, $A417, $A426, $A442, $A46B, $A470, $A493, $A49C, $A4AD
LA2C1:	.word $A4BD, $A4CD, $A4D2, $A4D7, $A4DC, $A4E1, $A4E6, $A4EB, $A4EF, $A4F0, $A508, $A51A
LA2D9:	.word $A51F, $A524, $A51F, $A524, $A538, $A53D, $A538, $A53D

;Writes credits on name table 0 in row $2020 (2nd row from top).
LA2E9:	.byte $20			;PPU address high byte.
LA2EA:	.byte $2C			;PPU address low byte.
LA2EB:	.byte $0A			;PPU string length.
;             'H    A    I    _    Y    U    K    A    M    I'
LA2EC:	.byte $11, $0A, $12, $FF, $22, $1E, $14, $0A, $16, $12

;Clears attribute table 0 starting at $23C0.
LA2F6:	.byte $23			;PPU address high byte.
LA2F7:	.byte $C0			;PPU address low byte.
LA2F8:	.byte $60			;PPU string length.
LA2F9:	.byte $00			;Repeat bit set. Repeats entry 32 times.

LA2FA:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2060 (4th row from top)
LA2FB:	.byte $20			;PPU address high byte.
LA2FC:	.byte $6A			;PPU address low byte.
LA2FD:	.byte $0D			;PPU string length.
;             'Z    A    R    U    _    S    O    B    A    J    I    M    A'
LA2FE:	.byte $23, $0A, $1B, $1E, $FF, $1C, $18, $0B, $0A, $13, $12, $16, $0A

;Writes credits on name table 0 in row $20A0 (6th row from top).
LA30B:	.byte $20			;PPU address high byte.
LA30C:	.byte $AB			;PPU address low byte.
LA30D:	.byte $0B			;PPU string length.
;             'G    P    Z    _    S    E    N    G    O    K    U'
LA30E:	.byte $10, $19, $23, $FF, $1C, $0E, $17, $10, $18, $14, $1E

LA319:	.byte $00			;End PPU string write.
LA31A:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2160 (12th row from top).
LA31B:	.byte $21			;PPU address high byte.
LA31C:	.byte $6A			;PPU address low byte.
LA31D:	.byte $0A			;PPU string length.
;             'N    .    S    H    I    O    T    A    N    I'
LA31E:	.byte $17, $07, $1C, $11, $12, $18, $1D, $0A, $17, $12 

;Clears attribute table 0 starting at $23E0
LA328:	.byte $23			;PPU address high byte.
LA329:	.byte $E0			;PPU address low byte.
LA32A:	.byte $60			;PPU string length.
LA32B:	.byte $00			;Repeat bit set. Repeats entry 32 times.

LA32C:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $21E0 (16th row from top).
LA32D:	.byte $21			;PPU address high byte.
LA32E:	.byte $EB			;PPU address low byte.
LA32F:	.byte $08			;PPU string length.
;             'M    .    H    O    U    D    A    I'
LA330:	.byte $16, $07, $11, $18, $1E, $0D, $0A, $12

LA338:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $22A0 (22nd row from top).
LA339:	.byte $22			;PPU address high byte.
LA33A:	.byte $A7			;PPU address low byte.
LA33B:	.byte $12			;PPU string length.
;             'S    P    E    C    I    A    L    _    T    H    A    N    K    S    _    _ '
LA33C:	.byte $1C, $19, $0E, $0C, $12, $0A, $15, $FF, $1D, $11, $0A, $17, $14, $1C, $FF, $FF
;             'T    O'
LA34C:	.byte $1D, $18 

LA34E:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $22E0 (24nd row from top).
LA34F:	.byte $22			;PPU address high byte.
LA350:	.byte $EC			;PPU address low byte.
LA351:	.byte $08			;PPU string length.
;             'K    E    N    _    Z    U    R    I'
LA352:	.byte $14, $0E, $17, $FF, $23, $1E, $1B, $12

;Writes credits on name table 0 in row $2320 (26nd row from top).
LA35A:	.byte $23			;PPU address high byte.
LA35B:	.byte $2E			;PPU address low byte.
LA35C:	.byte $04			;PPU string length.
;             'S    U    M    I'
LA35D:	.byte $1C, $1E, $16, $12

LA361:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2360 (28nd row from top).
LA362:	.byte $23			;PPU address high byte.
LA363:	.byte $6C			;PPU address low byte.
LA364:	.byte $07			;PPU string length.
;             'I    N    U    S    A    W    A'
LA365:	.byte $12, $17, $1E, $1C, $0A, $20, $0A

;Writes credits on name table 0 in row $23A0 (bottom row).
LA36C:	.byte $23			;PPU address high byte.
LA36D:	.byte $AD			;PPU address low byte.
LA36E:	.byte $05			;PPU string length.
;             'K    A    C    H    O'
LA36F:	.byte $14, $0A, $0C, $11, $18

LA374:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2820 (2nd row from top).
LA375:	.byte $28			;PPU address high byte.
LA376:	.byte $28			;PPU address low byte.
LA377:	.byte $4E			;PPU string length.
LA378:	.byte $FF			;Repeat bit set. Repeats entry 14 times.

;Writes credits on name table 2 in row $2860 (4th row from top).
LA379:	.byte $28			;PPU address high byte.
LA37A:	.byte $6C			;PPU address low byte.
LA37B:	.byte $07			;PPU string length.
;             'H    Y    A    K    K    A    N'
LA37C:	.byte $11, $22, $0A, $14, $14, $0A, $17

LA383:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $28A0 (6th row from top).
LA384:	.byte $28			;PPU address high byte.
LA385:	.byte $A8			;PPU address low byte.
LA386:	.byte $13			;PPU string length.
;             '_    _    _    _    _    G    O    Y    A    K    E    _    _    _    _    _'
LA387:	.byte $FF, $FF, $FF, $FF, $FF, $10, $18, $22, $0A, $14, $0E, $FF, $FF, $FF, $FF, $FF
;             '_    _    _'
LA397:	.byte $FF, $FF, $FF

;Writes credits on name table 2 in row $28E0 (8th row from top).
LA39A:	.byte $28			;PPU address high byte.
LA39B:	.byte $E8			;PPU address low byte.
LA39C:	.byte $4F			;PPU string length.
LA39D:	.byte $FF			;Repeat bit set. Repeats entry 15 times.

LA39E:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2920 (10th row from top).
LA39F:	.byte $29			;PPU address high byte.
LA3A0:	.byte $2C			;PPU address low byte.
LA3A1:	.byte $07			;PPU string length.
;             'H    A    R    A    D    A    _'
LA3A2:	.byte $11, $0A, $1B, $0A, $0D, $0A, $FF

LA3A9:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2960 (12th row from top).
LA3AA:	.byte $29			;PPU address high byte.
LA3AB:	.byte $66			;PPU address low byte.
LA3AC:	.byte $16			;PPU string length.
;             '_    _    _    _    _    _    _    P    E    N    P    E    N    _    _    _'
LA3AD:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $19, $0E, $17, $19, $0E, $17, $FF, $FF, $FF
;             '_    _    _    _    _    _'
LA3BD:	.byte $FF, $FF, $FF, $FF, $FF, $FF

;Writes credits on name table 2 in row $29A0 (14th row from top).
LA3C3:	.byte $29			;PPU address high byte.
LA3C4:	.byte $A8			;PPU address low byte.
LA3C5:	.byte $4F			;PPU string length.
LA3C6:	.byte $FF			;Repeat bit set. Repeats entry 15 times.

LA3C7:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $29E0 (16th row from top).
LA3C8:	.byte $29			;PPU address high byte.
LA3C9:	.byte $EA			;PPU address low byte.
LA3CA:	.byte $0C			;PPU string length.
;             'C    O    N    V    E    R    T    E    D    _    B    Y'
LA3CB:	.byte $0C, $18, $17, $1F, $0E, $1B, $1D, $0E, $0D, $FF, $0B, $22

LA3D7:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2A20 (18th row from top).
LA3D8:	.byte $2A			;PPU address high byte.
LA3D9:	.byte $26			;PPU address low byte.
LA3DA:	.byte $11			;PPU string length.
;             '_    _    _    _    _    T    .    N    A    R    I    H    I    R    O    _'
LA3DB:	.byte $FF, $FF, $FF, $FF, $FF, $1D, $07, $17, $0A, $1B, $12, $11, $12, $1B, $18, $FF
;             '_'
LA3EB:	.byte $FF

;Writes credits on name table 2 in row $2A60 (20th row from top).
LA3EC:	.byte $2A			;PPU address high byte.
LA3ED:	.byte $67			;PPU address low byte.
LA3EE:	.byte $51			;PPU string length.
LA3EF:	.byte $FF			;Repeat bit set. Repeats entry 17 times.

LA3F0:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2AE0 (24th row from top).
LA3F1:	.byte $2A			;PPU address high byte.
LA3F2:	.byte $EB			;PPU address low byte.
LA3F3:	.byte $0B			;PPU string length.
;             'A    S    S    I    S    T    E    D    _    B    Y'
LA3F4:	.byte $0A, $1C, $1C, $12, $1C, $1D, $0E, $0D, $FF, $0B, $22

;Writes credits on name table 2 in row $2B20 (26th row from top).
LA3FF:	.byte $2B			;PPU address high byte.
LA400:	.byte $28			;PPU address low byte.
LA401:	.byte $0F			;PPU string length.
;             '_    _    _    M    A    K    O    T    O    _    K    A    N    O    H'
LA402:	.byte $FF, $FF, $FF, $16, $0A, $14, $18, $1D, $18, $FF, $14, $0A, $17, $18, $11

LA411:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2BA0 (bottom row).
LA412:	.byte $2B			;PPU address high byte.
LA413:	.byte $A6			;PPU address low byte.
LA414:	.byte $53			;PPU string length.
LA415:	.byte $FF			;Repeat bit set. Repeats entry 19 times.

LA416:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2020 (2nd row from the top).
LA417:	.byte $20			;PPU address high byte.
LA418:	.byte $2B			;PPU address low byte.
LA419:	.byte $0B			;PPU string length.
;             'D    I    R    E    C    T    E    D    _    B    Y'
LA41A:	.byte $0D, $12, $1B, $0E, $0C, $1D, $0E, $0D, $FF, $0B, $22

LA425:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2060 (4th row from the top).
LA426:	.byte $20			;PPU address high byte.
LA427:	.byte $67			;PPU address low byte.
LA428:	.byte $14			;PPU string length.
;             '_    _    _    _    _    Y    A    M    A    M    O    T    O    _    _    _'
LA429:	.byte $FF, $FF, $FF, $FF, $FF, $22, $0A, $16, $0A, $16, $18, $1D, $18, $FF, $FF, $FF
;             '_    _    _    _'
LA439:	.byte $FF, $FF, $FF, $FF

;Writes credits on name table 0 in row $20A0 (6th row from the top).
LA43D:	.byte $20			;PPU address high byte.
LA43E:	.byte $AA			;PPU address low byte.
LA43F:	.byte $4E			;PPU string length.
LA440:	.byte $FF			;Repeat bit set. Repeats entry 14 times.

LA441:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2120 (10th row from the top).
LA442:	.byte $21			;PPU address high byte.
LA443:	.byte $27			;PPU address low byte.
LA444:	.byte $11			;PPU string length.
;             '_    _    C    H    I    E    F    _    D    I    R    E    C    T    O    R'
LA445:	.byte $FF, $FF, $0C, $11, $12, $0E, $0F, $FF, $0D, $12, $1B, $0E, $0C, $1D, $18, $1B
;             '_'
LA455:	.byte $FF

;Writes credits on name table 0 in row $2160 (12th row from the top).
LA456:	.byte $21			;PPU address high byte.
LA457:	.byte $68			;PPU address low byte.
LA458:	.byte $11			;PPU string length.
;             '_    _    S    A    T    O    R    U    _    O    K    A    D    A    _    _'
LA459:	.byte $FF, $FF, $1C, $0A, $1D, $18, $1B, $1E, $FF, $18, $14, $0A, $0D, $0A, $FF, $FF
;             '_'
LA469:	.byte $FF

LA46A:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $21E0 (16th row from the top).
LA46B:	.byte $21			;PPU address high byte.
LA46C:	.byte $E6			;PPU address low byte.
LA46D:	.byte $58			;PPU string length.
LA46E:	.byte $FF			;Repeat bit set. Repeats entry 24 times.

LA46F:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2220 (18th row from the top).
LA470:	.byte $22			;PPU address high byte.
LA471:	.byte $2B			;PPU address low byte.
LA472:	.byte $10			;PPU string length.
;             'P    R    O    D    U    C    E    D    _    B    Y    _    _    _    _    _'
LA473:	.byte $19, $1B, $18, $0D, $1E, $0C, $0E, $0D, $FF, $0B, $22, $FF, $FF, $FF, $FF, $FF

;Writes credits on name table 0 in row $2260 (20th row from the top).
LA483:	.byte $22			;PPU address high byte.
LA484:	.byte $6A			;PPU address low byte.
LA485:	.byte $0C			;PPU string length.
;             'G    U    N    P    E    I    _    Y    O    K    O    I'
LA486:	.byte $10, $1E, $17, $19, $0E, $12, $FF, $22, $18, $14, $18, $12

LA492:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $22A0 (22nd row from the top).
LA493:	.byte $22			;PPU address high byte.
LA494:	.byte $A6			;PPU address low byte.
LA495:	.byte $53			;PPU string length.
LA496:	.byte $FF			;Repeat bit set. Repeats entry 19 times.

;Writes credits on name table 0 in row $22E0 (24th row from the top).
LA497:	.byte $22			;PPU address high byte.
LA498:	.byte $E8			;PPU address low byte.
LA499:	.byte $4F			;PPU string length.
LA49A:	.byte $FF			;Repeat bit set. Repeats entry 15 times.

LA49B:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2320 (26th row from the top).
LA49C:	.byte $23			;PPU address high byte.
LA49D:	.byte $29			;PPU address low byte.
LA49E:	.byte $4D			;PPU string length.
LA49F:	.byte $FF			;Repeat bit set. Repeats entry 13 times.

;Writes credits on name table 0 in row $2340 (27th row from the top).
LA4A0:	.byte $23			;PPU address high byte.
LA4A1:	.byte $4B			;PPU address low byte.
LA4A2:	.byte $09			;PPU string length.
;             'C    O    P    Y    R    I    G    H    T'
LA4A3:	.byte $0C, $18, $19, $22, $1B, $12, $10, $11, $1D

LA4AC:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2360 (28th row from the top).
LA4AD:	.byte $23			;PPU address high byte.
LA4AE:	.byte $6B			;PPU address low byte.
LA4AF:	.byte $4A			;PPU string length.
LA4B0:	.byte $FF			;Repeat bit set. Repeats entry 10 times.

;Writes credits on name table 0 in row $2380 (29th row from the top).
LA4B1:	.byte $23			;PPU address high byte.
LA4B2:	.byte $8E			;PPU address low byte.
LA4B3:	.byte $04			;PPU string length.
;             '1    9    8    6'
LA4B4:	.byte $01, $09, $08, $06 

;Writes credits on name table 0 in row $23A0 (bottom row).
LA4B8:	.byte $23			;PPU address high byte.
LA4B9:	.byte $A8			;PPU address low byte.
LA4BA:	.byte $4F			;PPU string length.
LA4BB:	.byte $FF			;Repeat bit set. Repeats entry 10 times.

LA4BC:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2800 (top row)
LA4BD:	.byte $28			;PPU address high byte.
LA4BE:	.byte $0C			;PPU address low byte.
LA4BF:	.byte $08			;PPU string length.
;             'N    I    N    T    E    N    D    O'
LA4C0:	.byte $17, $12, $17, $1D, $0E, $17, $0D, $18

;Writes credits on name table 2 in row $2860 (4th row from top).
LA4C8:	.byte $28			;PPU address high byte.
LA4C9:	.byte $66			;PPU address low byte.
LA4CA:	.byte $51			;PPU string length.
LA4CB:	.byte $FF			;Repeat bit set. Repeats entry 17 times.

LA4CC:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $28A0 (6th row from top).
LA4CD:	.byte $28			;PPU address high byte.
LA4CE:	.byte $AA			;PPU address low byte.
LA4CF:	.byte $4C			;PPU string length.
LA4D0:	.byte $FF			;Repeat bit set. Repeats entry 12 times.

LA4D1:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2920 (10th row from top).
LA4D2:	.byte $29			;PPU address high byte.
LA4D3:	.byte $26			;PPU address low byte.
LA4D4:	.byte $5B			;PPU string length.
LA4D5:	.byte $FF			;Repeat bit set. Repeats entry 27 times.

LA4D6:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2960 (12th row from top).
LA4D7:	.byte $29			;PPU address high byte.
LA4D8:	.byte $67			;PPU address low byte.
LA4D9:	.byte $52			;PPU string length.
LA4DA:	.byte $FF			;Repeat bit set. Repeats entry 18 times.

LA4DB:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $29E0 (16th row from top).
LA4DC:	.byte $29			;PPU address high byte.
LA4DD:	.byte $E6			;PPU address low byte.
LA4DE:	.byte $54			;PPU string length.
LA4DF:	.byte $FF			;Repeat bit set. Repeats entry 20 times.

LA4E0:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2A20 (18th row from top).
LA4E1:	.byte $2A			;PPU address high byte.
LA4E2:	.byte $28			;PPU address low byte.
LA4E3:	.byte $55			;PPU string length.
LA4E4:	.byte $FF			;Repeat bit set. Repeats entry 21 times.

LA4E5:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2AE0 (24th row from top).
LA4E6:	.byte $2A			;PPU address high byte.
LA4E7:	.byte $E6			;PPU address low byte.
LA4E8:	.byte $50			;PPU string length.
LA4E9:	.byte $FF			;Repeat bit set. Repeats entry 16 times.

LA4EA:	.byte $00			;End PPU string write.

;Writes credits on name table 2 in row $2B20 (26th row from top).
LA4EB:	.byte $2B			;PPU address high byte.
LA4EC:	.byte $29			;PPU address low byte.
LA4ED:	.byte $4E			;PPU string length.
LA4EE:	.byte $FF			;Repeat bit set. Repeats entry 14 times.

LA4EF:	.byte $00			;End PPU string write.

;Writes the top half of 'The End' on name table 0 in row $2020 (2nd row from top).
LA4F0:	.byte $20			;PPU address high byte.
LA4F1:	.byte $26			;PPU address low byte.
LA4F2:	.byte $14			;PPU string length.
LA4F3:	.byte $FF, $FF, $FF, $FF, $FF, $24, $25, $26, $27, $FF, $FF, $2C, $2D, $2E, $2F, $FF
LA503:	.byte $FF, $FF, $FF, $FF

LA507:	.byte $00			;End PPU string write.

;Writes the bottom half of 'The End' on name table 0 in row $2040 (3rd row from top).
LA508:	.byte $20			;PPU address high byte.
LA509:	.byte $4B			;PPU address low byte.
LA50A:	.byte $0A			;PPU string length.
LA50B:	.byte $28, $29, $2A, $2B, $FF, $FF, $02, $03, $04, $05

;Writes credits on name table 0 in row $2060 (4th row from top).
LA515:	.byte $20			;PPU address high byte.
LA516:	.byte $6A			;PPU address low byte.
LA517:	.byte $4C			;PPU string length.
LA518:	.byte $FF			;Repeat bit set. Repeats entry 12 times.

LA519:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2120 (10th row from top).
LA51A:	.byte $21			;PPU address high byte.
LA51B:	.byte $26			;PPU address low byte.
LA51C:	.byte $53			;PPU string length.
LA51D:	.byte $FF			;Repeat bit set. Repeats entry 19 times.

LA51E:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2160 (12th row from top).
LA51F:	.byte $21			;PPU address high byte.
LA520:	.byte $6A			;PPU address low byte.
LA521:	.byte $4C			;PPU string length.
LA522:	.byte $FF			;Repeat bit set. Repeats entry 12 times.

LA523:	.byte $00			;End PPU string write.

;Writes credits on name table 0 in row $2180 (13th row from top).
LA524:	.byte $21			;PPU address high byte.
LA525:	.byte $88			;PPU address low byte.
LA526:	.byte $11			;PPU string length.
;             '_    _    _    _    _    _    _    _    _    _    _    _    _    _    _    _'
LA527:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
;             '_'
LA537:	.byte $FF

;Writes credits on name table 0 in row $2220 (18th row from top).
LA538:	.byte $22			;PPU address high byte.
LA539:	.byte $26			;PPU address low byte.
LA53A:	.byte $4B			;PPU string length.
LA53B:	.byte $FF			;Repeat bit set. Repeats entry 11 times.

LA53C:	.byte $00			;End PPU string write.

LA53D:	.byte $00			;End PPU block write.

;-------------------------------------------[ World map ]--------------------------------------------

WorldMap:
LA53E:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA54E:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA55E:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF, $08, $FF, $FF
LA56E:	.byte $FF, $FF, $FF, $FF, $08, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA57E:	.byte $FF, $FF, $FF, $2C, $2B, $27, $15, $15, $16, $14, $13, $04, $FF, $06, $08, $0A
LA58E:	.byte $1A, $29, $29, $28, $2E, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF
LA59E:	.byte $FF, $0E, $FF, $01, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $03, $1F, $23
LA5AE:	.byte $25, $24, $26, $20, $1E, $1F, $21, $21, $07, $22, $1D, $1B, $21, $20, $04, $FF
LA5BE:	.byte $FF, $10, $FF, $0E, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $06, $FF, $FF
LA5CE:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $02, $FF
LA5DE:	.byte $FF, $10, $FF, $0B, $FF, $FF, $08, $0A, $1A, $29, $28, $04, $FF, $06, $FF, $FF
LA5EE:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $0A, $1A, $29, $29, $28, $04, $FF
LA5FE:	.byte $FF, $10, $FF, $0B, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $06, $FF, $FF
LA60E:	.byte $FF, $FF, $08, $FF, $FF, $FF, $08, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF
LA61E:	.byte $FF, $10, $FF, $0F, $11, $13, $14, $14, $13, $12, $0D, $03, $00, $05, $0C, $0E
LA62E:	.byte $0E, $0D, $10, $0C, $0F, $0D, $10, $0C, $0E, $1B, $0F, $0E, $0F, $0D, $04, $FF
LA63E:	.byte $FF, $10, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0C, $06, $FF, $06, $FF, $FF
LA64E:	.byte $FF, $FF, $11, $FF, $FF, $FF, $06, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF
LA65E:	.byte $FF, $10, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0C, $06, $FF, $06, $FF, $FF
LA66E:	.byte $FF, $FF, $11, $0A, $1A, $28, $04, $FF, $06, $FF, $FF, $FF, $FF, $FF, $06, $FF
LA67E:	.byte $FF, $10, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0C, $06, $FF, $06, $FF, $FF
LA68E:	.byte $FF, $FF, $08, $FF, $FF, $FF, $08, $FF, $08, $1B, $06, $19, $19, $2A, $0B, $FF
LA69E:	.byte $FF, $0F, $04, $03, $02, $05, $06, $07, $08, $09, $0A, $06, $FF, $03, $12, $14
LA6AE:	.byte $15, $14, $07, $16, $15, $13, $0B, $FF, $0C, $07, $19, $19, $19, $2A, $0E, $FF
LA6BE:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $08, $FF, $FF
LA6CE:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $01, $FF, $0A, $1B, $04, $0F, $06, $2A, $0E, $FF
LA6DE:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $06, $FF, $FF
LA6EE:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $02, $FF, $06, $FF, $FF, $FF, $FF, $FF, $09, $FF
LA6FE:	.byte $FF, $08, $17, $09, $14, $13, $18, $12, $14, $19, $13, $04, $FF, $08, $1D, $1F
LA70E:	.byte $06, $1F, $19, $1E, $1E, $1C, $03, $28, $29, $29, $29, $2B, $29, $2A, $0E, $FF
LA71E:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $FF, $FF, $FF, $08, $FF, $08, $1D, $1F
LA72E:	.byte $1E, $19, $07, $19, $19, $2C, $06, $06, $2B, $2B, $1A, $1A, $1A, $2A, $0B, $FF
LA73E:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $0B, $FF, $FF, $0B, $FF, $06, $07, $04
LA74E:	.byte $0F, $10, $0B, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $09, $FF
LA75E:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $06, $FF, $07, $17, $18, $0C, $FF, $08, $21, $25
LA76E:	.byte $25, $22, $03, $21, $25, $20, $00, $27, $2C, $2C, $06, $04, $0F, $10, $0E, $FF
LA77E:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $03, $1C, $07, $17, $18, $0C, $FF, $0A, $21, $23
LA78E:	.byte $25, $22, $03, $21, $24, $24, $24, $23, $23, $06, $24, $25, $22, $11, $2D, $FF
LA79E:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $08, $01, $07, $17, $18, $0C, $FF, $09, $FF, $FF
LA7AE:	.byte $FF, $06, $06, $FF, $FF, $FF, $FF, $FF, $FF, $07, $26, $25, $22, $0B, $2D, $FF
LA7BE:	.byte $FF, $0B, $FF, $FF, $FF, $FF, $FF, $02, $0B, $FF, $FF, $08, $FF, $0A, $12, $14
LA7CE:	.byte $13, $03, $12, $15, $13, $0D, $12, $14, $06, $14, $18, $15, $19, $07, $09, $FF
LA7DE:	.byte $FF, $09, $17, $1C, $10, $19, $18, $03, $13, $10, $18, $0C, $FF, $06, $FF, $FF
LA7EE:	.byte $FF, $09, $04, $0F, $10, $0B, $FF, $FF, $08, $12, $16, $16, $16, $13, $0E, $FF
LA7FE:	.byte $FF, $0A, $17, $1C, $1C, $1C, $18, $03, $13, $19, $12, $0B, $FF, $00, $FF, $FF
LA80E:	.byte $0B, $08, $12, $19, $19, $07, $FF, $FF, $08, $05, $FF, $FF, $FF, $FF, $06, $FF
LA81E:	.byte $FF, $05, $FF, $FF, $0B, $FF, $FF, $08, $FF, $FF, $FF, $FF, $0B, $FF, $FF, $FF
LA82E:	.byte $FF, $06, $FF, $FF, $FF, $FF, $FF, $05, $06, $01, $FF, $FF, $FF, $FF, $0B, $FF
LA83E:	.byte $FF, $05, $FF, $FF, $07, $17, $18, $04, $13, $14, $14, $16, $0C, $FF, $05, $FF
LA84E:	.byte $FF, $05, $0F, $18, $17, $18, $19, $29, $05, $02, $FF, $FF, $FF, $FF, $05, $FF
LA85E:	.byte $FF, $05, $FF, $FF, $08, $FF, $FF, $05, $FF, $0B, $10, $18, $0D, $FF, $0A, $20
LA86E:	.byte $22, $0D, $25, $26, $26, $26, $1D, $0E, $0E, $03, $23, $24, $24, $15, $07, $FF
LA87E:	.byte $FF, $05, $FF, $FF, $23, $17, $18, $06, $22, $0C, $FF, $0B, $0E, $FF, $0B, $FF
LA88E:	.byte $FF, $04, $FF, $FF, $FF, $FF, $05, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF
LA89E:	.byte $FF, $23, $22, $1A, $13, $10, $14, $1C, $16, $06, $21, $0C, $0E, $FF, $0A, $1C
LA8AE:	.byte $1D, $03, $20, $21, $21, $22, $06, $23, $0F, $28, $27, $27, $27, $19, $07, $FF
LA8BE:	.byte $FF, $0B, $FF, $1E, $1F, $20, $20, $20, $0F, $15, $21, $24, $0E, $FF, $04, $FF
LA8CE:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $04, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $08, $FF
LA8DE:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $1D, $1B, $17, $18, $0C, $FF, $04, $11
LA8EE:	.byte $10, $12, $13, $14, $14, $15, $03, $1C, $1E, $1E, $1F, $1F, $1F, $1D, $07, $FF
LA8FE:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $0B, $FF, $0C, $16
LA90E:	.byte $18, $17, $18, $17, $0F, $17, $17, $1A, $1A, $17, $1B, $1B, $17, $19, $09, $FF
LA91E: 	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LA91F:	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
 
CopyMap:
LA93E:	LDA #$3E			;
LA940:	STA $00				;
LA942:	LDA #$A5			;
LA944:	STA $01				;
LA946:	LDA #$00			;
LA948:	STA $02				;
LA94A:	LDA #$70			;Loads contents of world map into -->
LA94C:	STA $03				;RAM at addresses $7000 thru $73FF.
LA94E:	LDX #$04			;
LA950:*	LDY #$00			;
LA952:*	LDA ($00),Y			;
LA954:	STA ($02),Y			;
LA956:	INY 				;
LA957:	BNE -				;
LA959:	INC $01				;
LA95B:	INC $03				;
LA95D:	DEX 				;
LA95E:	BNE --				;
LA960:	RTS				;
 
;Unused tile patterns.
LA961:	.byte $00, $40, $90, $D0, $08, $5C, $0C, $00, $00, $C0, $70, $F8, $FC, $F4, $FC, $10
LA962:	.byte $22, $56, $03, $2B, $74, $37, $0D, $3F, $5F, $7D, $7F, $7F, $5F, $3F, $0F, $68
LA981:	.byte $F6, $BC, $5E, $3C, $DE, $7C, $F0, $FC, $DE, $FE, $FE, $FE, $FE, $FC, $F0, $00
LA991:	.byte $00, $7F, $80, $80, $FF, $7F, $00, $00, $7F, $80, $7F, $FF, $FF, $7F, $00, $00
LA9A1:	.byte $00, $FC, $01, $03, $FF, $FE, $00, $00, $FE, $03, $FF, $FF, $FF, $FE, $00, $00
LA9B1:	.byte $10, $20, $20, $00, $20, $00, $00, $3C, $42, $81, $81, $81, $81, $42, $3C, $7F
LA9C1:	.byte $7F, $3F, $1F, $80, $0F, $08, $88, $12, $80, $C0, $E0, $E0, $EF, $E8, $E8, $FC
LA9D1:	.byte $FC, $FC, $F8, $1C, $DC, $58, $5C, $48, $04, $0C, $18, $1C, $DC, $18, $1C, $0F
LA9E1:	.byte $00, $9F, $3F, $7F, $DB, $00, $00, $E0, $E0, $FF, $FF, $FF, $DB, $00, $00, $DC
LA9F1:	.byte $18, $EC, $F4, $F8, $6C, $00, $00, $1C, $18, $FC, $FC, $FC, $6C, $00, $00, $FF
LAA01:	.byte $FF, $C0, $C0, $CF, $CB, $CC, $CC, $00, $00, $1F, $3F, $3F, $38, $3B, $3B, $FC
LAA11:	.byte $FC, $0C, $0C, $CC, $4C, $CC, $CC, $00, $04, $EC, $FC, $FC, $3C, $BC, $BC, $CB
LAA21:	.byte $CF, $C0, $C0, $FF, $FF, $00, $00, $3B, $30, $3F, $1F, $7F, $FF, $00, $00, $4C
LAA31:	.byte $CC, $0C, $0C, $FC, $FC, $00, $00, $3C, $3C, $FC, $EC, $FC, $FC, $00, $00, $FE
LAA41:	.byte $82, $82, $82, $82, $FE, $00, $00, $00, $7E, $56, $56, $7E, $FE, $00, $00, $20
LAA51:	.byte $00, $00, $18, $20, $00, $00, $18, $1C, $F7, $3C, $18, $1C, $F7, $3C, $18, $E2
LAA61:	.byte $80, $10, $20, $00, $00, $80, $00, $E2, $98, $2C, $5E, $7E, $3C, $98, $00, $7E
LAA71:	.byte $00, $7E, $00, $7E, $00, $7E, $00, $6E, $00, $6E, $00, $6E, $00, $6E, $00, $10
LAA81:	.byte $F4, $08, $04, $C5, $24, $23, $05, $E8, $F8, $0E, $E6, $F7, $37, $2E, $FD, $00
LAA91:	.byte $5F, $20, $48, $D7, $88, $18, $80, $3F, $3F, $E0, $C7, $CF, $B8, $98, $7F, $F8
LAAA1:	.byte $10, $10, $10, $D7, $08, $00, $EF, $F8, $10, $30, $B7, $F7, $30, $DF, $EF, $FF
LAAB1:	.byte $00, $08, $08, $EF, $08, $10, $EF, $FF, $00, $18, $DB, $FF, $38, $F7, $EF, $FF
LAAC1:	.byte $7F, $3F, $5F, $4F, $07, $03, $01, $00, $B0, $C0, $E0, $F0, $F8, $FC, $FE, $FE
LAAD1:	.byte $FE, $FE, $FA, $FA, $FE, $FE, $FE, $00, $1A, $06, $0A, $1A, $3E, $7E, $FE, $01
LAAE1:	.byte $03, $07, $4F, $5F, $27, $7F, $00, $FF, $FF, $FF, $FF, $FF, $E7, $FF, $00, $7E
LAAF1:	.byte $BE, $DA, $EA, $F6, $CA, $FC, $00, $FE, $FE, $FA, $FA, $FE, $CE, $FE, $00, $CF
LAB01:	.byte $BF, $70, $60, $C4, $C8, $C0, $C0, $47, $BF, $70, $27, $4B, $57, $5F, $DF, $CC
LAB11:	.byte $F4, $38, $18, $0C, $0C, $0C, $0C, $CC, $F4, $38, $98, $CC, $EC, $EC, $EC, $C0
LAB21:	.byte $C0, $60, $70, $BF, $CF, $00, $00, $DF, $CF, $67, $70, $BF, $4F, $00, $00, $0C
LAB31:	.byte $0C, $18, $38, $F4, $CC, $00, $00, $EC, $CC, $98, $38, $F4, $CC, $00, $00, $FF
LAB41:	.byte $FF, $C0, $DF, $D0, $D0, $DF, $C0, $00, $00, $3F, $3F, $35, $35, $20, $3F, $FC
LAB51:	.byte $FC, $0C, $EC, $2C, $2C, $EC, $0C, $00, $04, $FC, $FC, $5C, $5C, $1C, $FC, $FF
LAB61:	.byte $00, $00, $E4, $00, $CF, $00, $00, $7F, $00, $00, $E3, $00, $BF, $00, $00, $FC
LAB71:	.byte $00, $00, $F9, $00, $87, $00, $00, $FC, $00, $00, $F7, $00, $67, $00, $00, $FE
LAB81:	.byte $02, $02, $02, $FE, $00, $00, $7F, $00, $FE, $0E, $FE, $FE, $00, $00, $00, $7F
LAB91:	.byte $40, $40, $40, $7F, $00, $00, $FE, $00, $3F, $30, $3F, $7F, $00, $00, $00, $40
LABA1:	.byte $40, $40, $7F, $00, $00, $00, $FF, $3F, $30, $3F, $7F, $00, $00, $FF, $FF, $02
LABB1:	.byte $02, $02, $FE, $00, $00, $00, $FF, $FE, $0E, $FE, $FE, $00, $00, $FF, $FF, $FF
LABC1:	.byte $FF, $C0, $D0, $C0, $C0, $C0, $C0, $00, $00, $3F, $27, $3F, $3F, $3F, $3F, $FC
LABD1:	.byte $FC, $0C, $4C, $0C, $0C, $0C, $0C, $00, $04, $FC, $9C, $FC, $FC, $FC, $FC, $C0
LABE1:	.byte $C0, $D0, $C0, $FF, $FF, $00, $00, $3F, $3F, $27, $3F, $3F, $7F, $00, $00, $0C
LABF1:	.byte $0C, $4C, $0C, $FC, $FC, $00, $00, $FC, $FC, $9C, $FC, $FC, $FC, $00, $00

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

EndSQ1Data:
LAC00:	.byte $C2			;
LAC01:	.byte $B4			;7/8 seconds	+
LAc02:	.byte $2A			;A3		|
LAC03:	.byte $30			;C4		| Repeat 2 times.
LAC04:	.byte $2E			;B3		|
LAC05:	.byte $2C			;A#3		+
LAC06:	.byte $FF			;
LAC07:	.byte $2A			;A3
LAC08:	.byte $2A			;A3
LAC09:	.byte $C2			;
LAC0A:	.byte $B0			;1/4 seconds	+
LAC0B:	.byte $3C			;F#4		|
LAC0C:	.byte $42			;A4		|
LAC0D:	.byte $4C			;D5		|
LAC0E:	.byte $54			;F#5		|
LAC0F:	.byte $B2			;7/32 seconds	|
LAC10:	.byte $5A			;A5		|
LAC11:	.byte $56			;G5		|
LAC12:	.byte $54			;F#5		|
LAC13:	.byte $B4			;7/8 seconds	|
LAC14:	.byte $4C			;D5		|
LAC15:	.byte $B0			;1/4 seconds	|
LAC16:	.byte $38			;E4		| Repeat 2 times.
LAC17:	.byte $3C			;F#4		|
LAC18:	.byte $3E			;G4		|
LAC19:	.byte $42			;A4		|
LAC1A:	.byte $B2			;7/32 seconds	|
LAC1B:	.byte $4C			;D5		|
LAC1C:	.byte $42			;A4		|
LAC1D:	.byte $B0			;1/4 seconds	|
LAC1E:	.byte $56			;G5		|
LAC1F:	.byte $54			;F#5		|
LAC20:	.byte $4C			;D5		|
LAC21:	.byte $42			;A4		|
LAC22:	.byte $B3			;7/16 seconds	|
LAC23:	.byte $3E			;G4		|
LAC24:	.byte $4C			;D5		+
LAC25:	.byte $FF			;
LAC26:	.byte $C2			;
LAC27:	.byte $B3			;7/16 seconds	+
LAC28:	.byte $4A			;C#5		|
LAC29:	.byte $B2			;7/32 seconds	|
LAC2A:	.byte $4C			;D5		|
LAC2B:	.byte $42			;A4		|
LAC2C:	.byte $54			;F#5		|
LAC2D:	.byte $50			;E5		|
LAC2E:	.byte $56			;G5		|
LAC2F:	.byte $54			;F#5		|
LAC30:	.byte $B1			;7/64 seconds	|
LAC31:	.byte $50			;E5		|
LAC32:	.byte $4C			;D5		| Repeat 2 times.
LAC33:	.byte $44			;A#4		|
LAC34:	.byte $3E			;G4		|
LAC35:	.byte $B2			;7/32 seconds	|
LAC36:	.byte $3C			;F#4		|
LAC37:	.byte $4C			;D5		|
LAC38:	.byte $B1			;7/64 seconds	|
LAC39:	.byte $40			;Ab4		|
LAC3A:	.byte $46			;B4		|
LAC3B:	.byte $B2			;7/32 seconds	|
LAC3C:	.byte $50			;E5		|
LAC3D:	.byte $4C			;D5		|
LAC3E:	.byte $50			;E5		+
LAC3F:	.byte $FF			;
LAC40:	.byte $C4			;
LAC41:	.byte $B3			;7/16 seconds	+
LAC42:	.byte $2A			;A3		|
LAC43:	.byte $30			;C4		| Repeat 4 times.
LAC44:	.byte $2E			;B3		|
LAC45:	.byte $2C			;A#3		+
LAC46:	.byte $FF			;
LAC47:	.byte $B4			;7/8 seconds
LAC48:	.byte $34			;D4
LAC49:	.byte $B3			;7/16 seconds
LAC4A:	.byte $38			;E4
LAC4B:	.byte $3E			;G4
LAC4C:	.byte $B4			;7/8 seconds
LAC4D:	.byte $3C			;F#4
LAC4E:	.byte $B3			;7/16 seconds
LAC4F:	.byte $3E			;G4
LAC50:	.byte $44			;A#4
LAC51:	.byte $B5			;1 13/16 seconds
LAC52:	.byte $34			;D4
LAC53:	.byte $B1			;7/64 seconds
LAC54:	.byte $2A			;A3
LAC55:	.byte $B6			;21/32 seconds
LAC56:	.byte $1C			;D3
LAC57:	.byte $B2			;7/32 seconds
LAC58:	.byte $02			;No sound
LAC59:	.byte $B5			;1 13/16 seconds
LAC5A:	.byte $26			;G3
LAC5B:	.byte $B1			;7/64 seconds
LAC5C:	.byte $24			;F#3
LAC5D:	.byte $B8			;21/64 seconds
LAC5E:	.byte $06			;D2
LAC5F:	.byte $12			;A2
LAC60:	.byte $1C			;D3
LAC61:	.byte $B9			;9/32 seconds
LAC62:	.byte $02			;No sound
LAC63:	.byte $B8			;21/64 seconds
LAC64:	.byte $24			;F#3
LAC65:	.byte $2A			;A3
LAC66:	.byte $34			;D4
LAC67:	.byte $B9			;9/32 seconds
LAC68:	.byte $02			;No sound
LAC69:	.byte $B5			;1 13/16 seconds
LAC6A:	.byte $38			;E4
LAC6B:	.byte $B1			;7/64 seconds
LAC6C:	.byte $2C			;A#3
LAC6D:	.byte $B3			;7/16 seconds
LAC6E:	.byte $26			;G3
LAC6F:	.byte $2A			;A3
LAC70:	.byte $B5			;1 13/16 seconds
LAC71:	.byte $2A			;A3
LAC72:	.byte $B1			;7/64 seconds
LAC73:	.byte $02			;No sound
LAC74:	.byte $B8			;21/64 seconds
LAC75:	.byte $26			;G3
LAC76:	.byte $24			;F#3
LAC77:	.byte $1C			;D3
LAC78:	.byte $B9			;9/32 seconds
LAC79:	.byte $02			;No sound
LAC7A:	.byte $B8			;21/64 seconds
LAC7B:	.byte $20			;E3
LAC7C:	.byte $1C			;D3
LAC7D:	.byte $20			;E3
LAC7E:	.byte $B9			;9/32 seconds
LAC7F:	.byte $02			;No sound
LAC80:	.byte $B4			;7/8 seconds
LAC81:	.byte $1C			;D3
LAC82:	.byte $B8			;21/64 seconds
LAC83:	.byte $26			;G3
LAC84:	.byte $2C			;A#3
LAC85:	.byte $34			;D4
LAC86:	.byte $B9			;9/32 seconds
LAC87:	.byte $02			;No sound
LAC88:	.byte $B8			;21/64 seconds
LAC89:	.byte $3E			;G4
LAC8A:	.byte $44			;A#4
LAC8B:	.byte $4C			;D5
LAC8C:	.byte $B9			;9/32 seconds
LAC8D:	.byte $02			;No sound
LAC8E:	.byte $C8			;
LAC8F:	.byte $B0			;1/4 seconds	+
LAC90:	.byte $3C			;F#4		|
LAC91:	.byte $42			;A4		|
LAC92:	.byte $3C			;F#4		|
LAC93:	.byte $42			;A4		|
LAC94:	.byte $42			;A4		|
LAC95:	.byte $46			;B4		|
LAC96:	.byte $42			;A4		|
LAC97:	.byte $46			;B4		| Repeat 8 times.
LAC98:	.byte $4C			;D5		|
LAC99:	.byte $50			;E5		|
LAC9A:	.byte $4C			;D5		|
LAC9B:	.byte $50			;E5		|
LAC9C:	.byte $50			;E5		|
LAC9D:	.byte $54			;F#5		|
LAC9E:	.byte $50			;E5		|
LAC9F:	.byte $54			;F#5		+
LACA0:	.byte $FF			;
LACA1:	.byte $C2			;
LACA2:	.byte $B4			;7/8 seconds	+
LACA3:	.byte $2A			;A3		|
LACA4:	.byte $B3			;7/16 seconds	|
LACA5:	.byte $34			;D4		|
LACA6:	.byte $B5			;1 13/16 seconds|
LACA7:	.byte $32			;C#4		|
LACA8:	.byte $B1			;7/64 seconds	|
LACA9:	.byte $2E			;B3		| Repeat 2 times.
LACAA:	.byte $B4			;7/8 seconds	|
LACAB:	.byte $2A			;A3		|
LACAC:	.byte $B3			;7/16 seconds	|
LACAD:	.byte $1C			;D3		|
LACAE:	.byte $B5			;1 13/16 seconds|
LACAF:	.byte $26			;G3		|
LACB0:	.byte $B1			;7/64 seconds	|
LACB1:	.byte $24			;F#3		+
LACB2:	.byte $FF			;
LACB3:	.byte $B4			;7/8 seconds
LACB4:	.byte $2A			;A3
LACB5:	.byte $B8			;21/64 seconds
LACB6:	.byte $18			;C3
LACB7:	.byte $26			;G3
LACB8:	.byte $30			;C4
LACB9:	.byte $B9			;9/32 seconds
LACBA:	.byte $02			;No sound
LACBB:	.byte $B8			;21/64 seconds
LACBC:	.byte $1C			;D3
LACBD:	.byte $26			;G3
LACBE:	.byte $30			;C4
LACBF:	.byte $B9			;9/32 seconds
LACC0:	.byte $02			;No sound
LACC1:	.byte $B4			;7/8 seconds
LACC2:	.byte $34			;D4
LACC3:	.byte $B8			;21/64 seconds
LACC4:	.byte $3A			;F4
LACC5:	.byte $30			;C4
LAcc6:	.byte $26			;G3
LACC7:	.byte $B9			;9/32 seconds
LACC8:	.byte $02			;No sound
LACC9:	.byte $B8			;21/64 seconds
LACCA:	.byte $3E			;G4
LACCB:	.byte $38			;E4
LACCC:	.byte $30			;C4
LACCD:	.byte $B9			;9/32 seconds
LACCE:	.byte $02			;No sound
LACCF:	.byte $B4			;7/8 seconds
LACD0:	.byte $34			;D4
LACD1:	.byte $B2			;7/32 seconds
LACD2:	.byte $1C			;D3
LACD3:	.byte $2A			;A3
LACD4:	.byte $26			;G3
LACD5:	.byte $30			;C4
LACD6:	.byte $C2			;
LACD7:	.byte $B0			;1/4 seconds	+
LACD8:	.byte $38			;E4		|
LACD9:	.byte $38			;E4		|
LACDA:	.byte $38			;E4		|
LACDB:	.byte $02			;No sound	|
LACDC:	.byte $02			;No sound	|
LACDD:	.byte $02			;No sound	|
LACDE:	.byte $38			;E4		|
LACDF:	.byte $38			;E4		| Repeat 2 times.
LACE0:	.byte $38			;E4		|
LACE1:	.byte $02			;No sound	|
LACE2:	.byte $38			;E4		|
LACE3:	.byte $38			;E4		|
LACE4:	.byte $38			;E4		|
LACE5:	.byte $38			;E4		|
LACE6:	.byte $38			;E4		|
LACE7:	.byte $02			;No sound	+
LACE8:	.byte $FF			;
LACE9:	.byte $B4			;7/8 seconds
LACEA:	.byte $38			;E4
LACEB:	.byte $B2			;7/32 seconds
LACEC:	.byte $02			;No sound
LACED:	.byte $B0			;1/4 seconds
LACEE:	.byte $1C			;D3
LACEF:	.byte $02			;No sound
LACF0:	.byte $1C			;D3
LACF1:	.byte $1C			;D3
LACF2:	.byte $B2			;7/32 seconds
LACF3:	.byte $06			;D2
LACF4:	.byte $00			;End of end music.

EndTriangleData:
LACF5:	.byte $CA			;
LACF6:	.byte $B0			;1/4 seconds	+
LACF7:	.byte $2A			;A3		|
LACF8:	.byte $2A			;A3		|
LACF9:	.byte $2A			;A3		|
LACFA:	.byte $02			;No sound	|
LACFB:	.byte $02			;No sound	|
LACFC:	.byte $02			;No sound	|
LACFD:	.byte $2A			;A3		| Repeat 10 times.
LACFE:	.byte $2A			;A3		|
LACFF:	.byte $2A			;A3		|
LAD00:	.byte $02			;No sound	|
LAD01:	.byte $2A			;A3		|
LAD02:	.byte $2A			;A3		|
LAD03:	.byte $2A			;A3		|
LAD04:	.byte $2A			;A3		|
LAD05:	.byte $2A			;A3		|
LAD06:	.byte $02			;No sound	+
LAD07:	.byte $FF			;
LAD08:	.byte $C2			;
LAD09:	.byte $B2			;7/32 seconds	+
LAD0A:	.byte $34			;D4		|
LAD0B:	.byte $34			;D4		|
LAD0C:	.byte $32			;C#4		|
LAD0D:	.byte $32			;C#4		|
LAD0E:	.byte $2E			;B3		|
LAD0f:	.byte $2E			;B3		|
LAD10:	.byte $2A			;A3		|
LAD11:	.byte $2A			;A3		| Repeat 2 times.
LAD12:	.byte $26			;G3		|
LAD13:	.byte $26			;G3		|
LAD14:	.byte $24			;F#3		|
LAD15:	.byte $24			;F#3		|
LAD16:	.byte $20			;E3		|
LAD17:	.byte $20			;E3		|
LAD18:	.byte $2A			;A3		|
LAD19:	.byte $2A			;A3		+
LAD1A:	.byte $FF			;
LAD1B:	.byte $C2			;
LAD1C:	.byte $26			;G3		+
LAD1D:	.byte $26			;G3		|
LAD1E:	.byte $24			;F#3		|
LAD1F:	.byte $24			;F#3		|
LAD20:	.byte $30			;C4		|
LAD21:	.byte $30			;C4		|
LAD22:	.byte $2E			;B3		|
LAD23:	.byte $2E			;B3		| Repeat 2 times.
LAD24:	.byte $2C			;A#3		|
LAD25:	.byte $2C			;A#3		|
LAD26:	.byte $2A			;A3		|
LAD27:	.byte $2A			;A3		|
LAD28:	.byte $28			;Ab3		|
LAD29:	.byte $28			;Ab3		|
LAD2A:	.byte $2A			;A3		|
LAD2B:	.byte $2A			;A3		+
LAD2C:	.byte $FF			;
LAD2D:	.byte $C8			;
LAD2E:	.byte $B0			;1/4 seconds	+
LAD2F:	.byte $1C			;D3		|
LAD30:	.byte $1C			;D3		|
LAD31:	.byte $1C			;D3		|
LAD32:	.byte $02			;No sound	|
LAD33:	.byte $02			;No sound	|
LAD34:	.byte $02			;No sound	|
LAD35:	.byte $1C			;D3		| Repeat 8 times.
LAD36:	.byte $1C			;D3		|
LAD37:	.byte $1C			;D3		|
LAD38:	.byte $02			;No sound	|
LAD39:	.byte $1C			;D3		|
LAD3A:	.byte $1C			;D3		|
LAD3B:	.byte $1C			;D3		|
LAD3C:	.byte $1C			;D3		|
LAD3D:	.byte $1C			;D3		|
LAD3E:	.byte $02			;No sound	+
LAD3F:	.byte $FF			;
LAD40:	.byte $D8			;
LAD41:	.byte $BA			;1/32 seconds	+
LAD42:	.byte $64			;D6		|
LAD43:	.byte $02			;No sound	|
LAD44:	.byte $64			;D6		|
LAD45:	.byte $02			;No sound	|
LAD46:	.byte $B9			;9/32 seconds	|
LAD47:	.byte $02			;No sound	|
LAD48:	.byte $BA			;1/32 Seconds	|
LAD49:	.byte $72			;A6		|
LAD4A:	.byte $02			;No sound	|
LAD4B:	.byte $72			;A6		|
LAD4C:	.byte $02			;No sound	|
LAD4D:	.byte $B9			;9/32 seconds	| Repeat 24 times.
LAD4E:	.byte $02			;No sound	|
LAD4F:	.byte $BA			;1/32 seconds	|
LAD50:	.byte $7C			;D7		|
LAD51:	.byte $02			;No sound	|
LAD52:	.byte $7C			;D7		|
LAD53:	.byte $02			;No sound	|
LAD54:	.byte $B9			;9/32 seconds	|
LAD55:	.byte $02			;No sound	|
LAD56:	.byte $BA			;1/32 seconds	|
LAD57:	.byte $72			;A6		|
LAD58:	.byte $02			;No sound	|
LAD59:	.byte $72			;A6		|
LAD5A:	.byte $02			;No sound	|
LAD5B:	.byte $B9			;9/32 seconds	|
LAD5C:	.byte $02			;No sound	+
LAD5D:	.byte $FF			;
LAD5E:	.byte $C4			;
LAD5F:	.byte $B1			;7/64 seconds	+
LAD60:	.byte $34			;D4		|
LAD61:	.byte $34			;D4		|
LAD62:	.byte $34			;D4		|
LAD63:	.byte $34			;D4		|
LAD64:	.byte $02			;No sound	|
LAD65:	.byte $24			;F#3		|
LAD66:	.byte $24			;F#3		|
LAD67:	.byte $24			;F#3		|
LAD68:	.byte $20			;E3		|
LAD69:	.byte $20			;E3		|
LAD6A:	.byte $20			;E3		|
LAD6B:	.byte $20			;E3		|
LAD6C:	.byte $2A			;A3		|
LAD6D:	.byte $2A			;A3		|
LAD6E:	.byte $2A			;A3		|
LAD6F:	.byte $2A			;A3		| Repeat 4 times.
LAD70:	.byte $02			;No sound	|
LAD71:	.byte $24			;F#3		|
LAD72:	.byte $24			;F#3		|
LAD73:	.byte $24			;F#3		|
LAD74:	.byte $24			;F#3		|
LAD75:	.byte $24			;F#3		|
LAD76:	.byte $24			;F#3		|
LAD77:	.byte $24			;F#3		|
LAD78:	.byte $B8			;21/64 seconds	|
LAD79:	.byte $26			;G3		|
LAD7A:	.byte $1C			;D3		|
LAD7B:	.byte $20			;E3		|
LAD7C:	.byte $B9			;9/32 seconds	|
LAD7D:	.byte $02			;No sound	|
LAD7E:	.byte $B8			;21/64 seconds	|
LAD7F:	.byte $2C			;A#3		|
LAD80:	.byte $2A			;A3		|
LAD81:	.byte $26			;G3		|
LAD82:	.byte $B9			;9/32 seconds	|
LAD83:	.byte $02			;No sound	+
LAD84:	.byte $FF			;
LAD85:	.byte $C3			;
LAD86:	.byte $B0			;1/4 seconds	+
LAD87:	.byte $34			;D4		|
LAD88:	.byte $34			;D4		|
LAD89:	.byte $34			;D4		|
LAD8A:	.byte $02			;No sound	|
LAD8B:	.byte $02			;No sound	|
LAD8C:	.byte $02			;No sound	|
LAD8D:	.byte $34			;D4		|
LAD8E:	.byte $34			;D4		|
LAD8F:	.byte $34			;D4		|
LAD90:	.byte $02			;No sound	|
LAD91:	.byte $34			;D4		|
LAD92:	.byte $34			;D4		|
LAD93:	.byte $34			;D4		|
LAD94:	.byte $34			;D4		| Repeat 3 times.
LAD95:	.byte $34			;D4		|
LAD96:	.byte $02			;No sound	|
LAD97:	.byte $2C			;A#3		|
LAD98:	.byte $2C			;A#3		|
LAD99:	.byte $2C			;A#3		|
LAD9A:	.byte $02			;No sound	|
LAD9B:	.byte $02			;No sound	|
LAD9C:	.byte $02			;No sound	|
LAD9D:	.byte $2C			;A#3		|
LAD9E:	.byte $2C			;A#3		|
LAD9F:	.byte $30			;C4		|
LADA0:	.byte $02			;No sound	|
LADA1:	.byte $30			;C4		|
LADA2:	.byte $30			;C4		|
LADA3:	.byte $30			;C4		|
LADA4:	.byte $30			;C4		|
LADA5:	.byte $30			;C4		|
LADA6:	.byte $02			;No sound	+
LADA7:	.byte $FF			;
LADA8:	.byte $C2			;
LADA9:	.byte $1C			;D3		+
LADAA:	.byte $1C			;D3		|
LADAB:	.byte $1C			;D3		|
LADAC:	.byte $02			;No sound	|
LADAD:	.byte $02			;No sound	|
LADAE:	.byte $02			;No sound	|
LADAF:	.byte $1C			;D3		| Repeat 2 times.
LADB0:	.byte $1C			;D3		|
LADB1:	.byte $1C			;D3		|
LADB2:	.byte $02			;No sound	|
LADB3:	.byte $1C			;D3		|
LADB4:	.byte $1C			;D3		|
LADB5:	.byte $1C			;D3		|
LADB6:	.byte $1C			;D3		|
LADB7:	.byte $1C			;D3		|
LADB8:	.byte $02			;No sound	+
LADB9:	.byte $FF			;
LADBA:	.byte $B4			;7/8 seconds
LADBB:	.byte $1C			;D3
LADBC:	.byte $B2			;7/32 seconds
LADBD:	.byte $02			;No sound
LADBE:	.byte $B0			;1/4 seconds
LADBF:	.byte $1C			;D3
LADC0:	.byte $02			;No sound
LADC1:	.byte $1C			;D3
LADC2:	.byte $1C			;D3
LADC3:	.byte $B2			;7/32 seconds
LADC4:	.byte $1C			;D3

EndSQ2Data:
LADC5:	.byte $C2			;
LADC6:	.byte $B4			;7/8 seconds	+
LADC7:	.byte $20			;E3		|
LADC8:	.byte $2A			;A3		| Repeat 2 times.
LADC9:	.byte $28			;Ab3		|
LADCA:	.byte $26			;G3		+
LADCB:	.byte $FF			;
LADCC:	.byte $20			;E3
LADCD:	.byte $20			;E3
LADCE:	.byte $C2			;
LADCF:	.byte $B0			;1/4 seconds	+
LADD0:	.byte $34			;D4		|
LADD1:	.byte $3C			;F#4		|
LADD2:	.byte $42			;A4		|
LADD3:	.byte $4C			;D5		|
LADD4:	.byte $B2			;7/32 seconds	|
LADD5:	.byte $54			;F#5		|
LADD6:	.byte $50			;E5		|
LADD7:	.byte $4C			;D5		|
LADD8:	.byte $B3			;7/16 seconds	|
LADD9:	.byte $42			;A4		| Repeat 2 times.
LADDA:	.byte $3C			;F#4		|
LADDB:	.byte $B3			;7/16 seconds	|
LADDC:	.byte $46			;B4		|
LADDD:	.byte $B2			;7/32 seconds	|
LADDE:	.byte $34			;D4		|
LADDF:	.byte $B1			;7/64 seconds	|
LADE0:	.byte $4C			;D5		|
LADE1:	.byte $B0			;1/4 seconds	|
LADE2:	.byte $42			;A4		|
LADE3:	.byte $3C			;F#4		|
LADE4:	.byte $B3			;7/16 seconds	|
LADE5:	.byte $38			;E4		|
LADE6:	.byte $46			;B4		+
LADE7:	.byte $FF			;
LADE8:	.byte $C2			;
LADE9:	.byte $B3			;7/16 seconds	+
LADEA:	.byte $38			;E4		|
LADEB:	.byte $B2			;7/32 seconds	|
LADEC:	.byte $3C			;F#4		|
LADED:	.byte $34			;D4		|
LADEE:	.byte $34			;D4		|
LADEF:	.byte $30			;C4		|
LADF0:	.byte $38			;E4		|
LADF1:	.byte $34			;D4		|
LADF2:	.byte $44			;A#4		| Repeat 2 times.
LADF3:	.byte $38			;E4		|
LADF4:	.byte $34			;D4		|
LADF5:	.byte $42			;A4		|
LADF6:	.byte $B1			;7/64 seconds	|
LADF7:	.byte $3A			;F4		|
LADF8:	.byte $40			;Ab4		|
LADF9:	.byte $B2			;7/32 seconds	|
LADFA:	.byte $46			;B4		|
LADFB:	.byte $3E			;G4		|
LADFC:	.byte $3E			;G4		+
LADFD:	.byte $FF			;
LADFE:	.byte $C4			;
LADFF:	.byte $B2			;7/32 seconds	+
LAE00:	.byte $3C			;F#4		|
LAE01:	.byte $42			;A4		|
LAE02:	.byte $4C			;D5		|
LAE03:	.byte $42			;A4		| Repeat 4 times.
LAE04:	.byte $3E			;G4		|
LAE05:	.byte $42			;A4		|
LAE06:	.byte $4C			;D5		|
LAE07:	.byte $3E			;G4		+
LAE08:	.byte $FF			;
LAE09:	.byte $C2			;
LAE0A:	.byte $72			;A6		+
LAE0B:	.byte $6E			;G6		|
LAE0C:	.byte $6C			;F#6		|
LAE0D:	.byte $68			;E6		|
LAE0E:	.byte $6E			;G6		|
LAE0F:	.byte $6C			;F#6		|
LAE10:	.byte $64			;D6		|
LAE11:	.byte $68			;E6		+
LAE12:	.byte $FF			;
LAE13:	.byte $B4			;7/8 seconds
LAE14:	.byte $4C			;D5
LAE15:	.byte $B3			;7/16 seconds
LAE16:	.byte $56			;G5
LAE17:	.byte $50			;E5
LAE18:	.byte $B4			;7/8 seconds
LAE19:	.byte $54			;F#5
LAE1A:	.byte $B3			;7/16 seconds
LAE1B:	.byte $56			;G5
LAE1C:	.byte $5C			;A#5
LAE1D:	.byte $B4			;7/8 seconds
LAE1E:	.byte $4C			;D5
LAE1F:	.byte $B3			;7/16 seconds
LAE20:	.byte $50			;E5
LAE21:	.byte $56			;G5
LAE22:	.byte $B4			;7/8 seconds
LAE23:	.byte $54			;F#5
LAE24:	.byte $B3			;7/16 seconds
LAE25:	.byte $56			;G5
LAE26:	.byte $5C			;A#5
LAE27:	.byte $C4			;
LAE28:	.byte $B1			;7/64 seconds	+
LAE29:	.byte $5A			;A5		|
LAE2A:	.byte $42			;A4		|
LAE2B:	.byte $56			;G5		|
LAE2C:	.byte $42			;A4		|
LAE2D:	.byte $54			;F#5		|
LAE2E:	.byte $42			;A4		|
LAE2F:	.byte $50			;E5		| Repeat 4 times.
LAE30:	.byte $42			;A4		|
LAE31:	.byte $56			;G5		|
LAE32:	.byte $3E			;G4		|
LAE33:	.byte $54			;F#5		|
LAE34:	.byte $3E			;G4		|
LAE35:	.byte $4C			;D5		|
LAE36:	.byte $3E			;G4		|
LAE37:	.byte $50			;E5		|
LAE38:	.byte $3E			;G4		+
LAE39:	.byte $FF			;
LAE3A:	.byte $C8			;
LAE3B:	.byte $B0			;1/4 seconds	+
LAE3C:	.byte $3C			;F#4		|
LAE3D:	.byte $3E			;G4		|
LAE3E:	.byte $3C			;F#4		|
LAE3F:	.byte $3E			;G4		|
LAE40:	.byte $42			;A4		|
LAE41:	.byte $46			;B4		|
LAE42:	.byte $42			;A4		| Repeat 8 times.
LAE43:	.byte $46			;B4		|
LAE44:	.byte $4C			;D5		|
LAE45:	.byte $50			;E5		|
LAE46:	.byte $4C			;D5		|
LAE47:	.byte $50			;E5		|
LAE48:	.byte $50			;E5		|
LAE49:	.byte $54			;F#5		|
LAE4A:	.byte $50			;E5		|
LAE4B:	.byte $54			;F#5		+
LAE4C:	.byte $FF			;
LAE4D:	.byte $C3			;
LAE4E:	.byte $B0			;1/4 seconds	+
LAE4F:	.byte $42			;A4		|
LAE50:	.byte $42			;A4		|
LAE51:	.byte $42			;A4		|
LAE52:	.byte $02			;No sound	|
LAE53:	.byte $02			;No sound	|
LAE54:	.byte $02			;No sound	|
LAE55:	.byte $42			;A4		|
LAE56:	.byte $42			;A4		|
LAE57:	.byte $42			;A4		|
LAE58:	.byte $02			;No sound	|
LAE59:	.byte $42			;A4		|
LAE5A:	.byte $42			;A4		|
LAE5B:	.byte $42			;A4		|
LAE5C:	.byte $42			;A4		|
LAE5D:	.byte $42			;A4		| Repeat 3 times.
LAE5E:	.byte $02			;No sound	|
LAE5F:	.byte $3A			;F4		|
LAE60:	.byte $3A			;F4		|
LAE61:	.byte $3A			;F4		|
LAE62:	.byte $02			;No sound	|
LAE63:	.byte $02			;No sound	|
LAE64:	.byte $02			;No sound	|
LAE65:	.byte $3A			;F4		|
LAE66:	.byte $3A			;F4		|
LAE67:	.byte $3E			;G4		|
LAE68:	.byte $02			;No sound	|
LAE69:	.byte $3E			;G4		|
LAE6A:	.byte $3E			;G4		|
LAE6B:	.byte $3E			;G4		|
LAE6C:	.byte $3E			;G4		|
LAE6D:	.byte $3E			;G4		|
LAE6E:	.byte $02			;No sound	+
LAE6F:	.byte $FF			;
LAE70:	.byte $C2			;
LAE71:	.byte $42			;A4		+
LAE72:	.byte $42			;A4		|
LAE73:	.byte $42			;A4		|
LAE74:	.byte $02			;No sound	|
LAE75:	.byte $02			;No sound	|
LAE76:	.byte $02			;No sound	|
LAE77:	.byte $42			;A4		|
LAE78:	.byte $42			;A4		| Repeat 2 times.
LAE79:	.byte $42			;A4		|
LAE7A:	.byte $02			;No sound	|
LAE7B:	.byte $42			;A4		|
LAE7C:	.byte $42			;A4		|
LAE7D:	.byte $42			;A4		|
LAE7E:	.byte $42			;A4		|
LAE7F:	.byte $42			;A4		|
LAE80:	.byte $02			;No sound	+
LAE81:	.byte $FF			;
LAE82:	.byte $B4			;7/8 seconds
LAE83:	.byte $2A			;A3
LAE84:	.byte $B2			;7/32 seconds
LAE85:	.byte $02			;No sound
LAE86:	.byte $B0			;1/4 seconds
LAE87:	.byte $2A			;A3
LAE88:	.byte $02			;No sound
LAE89:	.byte $2A			;A3
LAE8A:	.byte $2A			;A3
LAE8B:	.byte $B2			;7/32 seconds
LAE8C:	.byte $2A			;A3
LAE8D:	.byte $00			;End of end music.

EndNoiseData:
LAE8E:	.byte $CA			;
LAE8F:	.byte $B0			;1/4 seconds	+
LAE90:	.byte $04			;Drumbeat 01	|
LAE91:	.byte $04			;Drumbeat 01	|
LAE92:	.byte $04			;Drumbeat 01	|
LAE93:	.byte $01			;Drumbeat 00	|
LAE94:	.byte $01			;Drumbeat 00	|
LAE95:	.byte $01			;Drumbeat 00	|
LAE96:	.byte $04			;Drumbeat 01	|
LAE97:	.byte $04			;Drumbeat 01	| Repeat 10 times.
LAE98:	.byte $04			;Drumbeat 01	|
LAE99:	.byte $01			;Drumbeat 00	|
LAE9A:	.byte $04			;Drumbeat 01	|
LAE9B:	.byte $04			;Drumbeat 01	|
LAE9C:	.byte $04			;Drumbeat 01	|
LAE9D:	.byte $04			;Drumbeat 01	|
LAE9E:	.byte $04			;Drumbeat 01	|
LAE9F:	.byte $01			;Drumbeat 00	+
LAEA0:	.byte $FF			;
LAEA1:	.byte $D8			;
LAEA2:	.byte $B2			;7/32 seconds	+
LAEA3:	.byte $04			;Drumbeat 01	| Repeat 24 times.
LAEA4:	.byte $07			;Drumbeat 02	+
LAEA5:	.byte $FF			;
LAEA6:	.byte $C4			;
LAEA7:	.byte $B0			;1/4 seconds	+
LAEA8:	.byte $04			;Drumbeat 01	|
LAEA9:	.byte $04			;Drumbeat 01	|
LAEAA:	.byte $04			;Drumbeat 01	|
LAEAB:	.byte $01			;Drumbeat 00	|
LAEAC:	.byte $01			;Drumbeat 00	|
LAEAD:	.byte $01			;Drumbeat 00	|
LAEAE:	.byte $04			;Drumbeat 01	| Repeat 4 times.
LAEAF:	.byte $04			;Drumbeat 01	|
LAEB0:	.byte $04			;Drumbeat 01	|
LAEB1:	.byte $01			;Drumbeat 00	|
LAEB2:	.byte $04			;Drumbeat 01	|
LAEB3:	.byte $04			;Drumbeat 01	|
LAEB4:	.byte $04			;Drumbeat 01	|
LAEB5:	.byte $04			;Drumbeat 01	|
LAEB6:	.byte $04			;Drumbeat 01	|
LAEB7:	.byte $01			;Drumbeat 00	+
LAEB8:	.byte $FF			;
LAEB9:	.byte $C8			;
LAEBA:	.byte $B1			;7/64 seconds	+
LAEBB:	.byte $04			;Drumbeat 01	|
LAEBC:	.byte $B0			;1/4 seconds	|
LAEBD:	.byte $04			;Drumbeat 01	|
LAEBE:	.byte $04			;Drumbeat 01	|
LAEBF:	.byte $B1			;7/64 seconds	|
LAEC0:	.byte $04			;Drumbeat 01	|
LAEC1:	.byte $B0			;1/4 seconds	|
LAEC2:	.byte $04			;Drumbeat 01	|
LAEC3:	.byte $04			;Drumbeat 01	| Repeat 8 times.
LAEC4:	.byte $B1			;7/64 seconds	|
LAEC5:	.byte $04			;Drumbeat 01	|
LAEC6:	.byte $B0			;1/4 seconds	|
LAEC7:	.byte $04			;Drumbeat 01	|
LAEC8:	.byte $04			;Drumbeat 01	|
LAEC9:	.byte $B1			;7/64 seconds	|
LAECA:	.byte $07			;Drumbeat 02	|
LAECB:	.byte $B0			;1/4 seconds	|
LAECC:	.byte $04			;Drumbeat 01	|
LAECD:	.byte $04			;Drumbeat 01	+
LAECE:	.byte $FF			;
LAECF:	.byte $D0			;
LAED0:	.byte $B2			;7/32 seconds	+ Repeat 16 times.
LAED1:	.byte $04			;Drumbeat01	+
LAED2:	.byte $FF			;
LAED3:	.byte $E0			;
LAED4:	.byte $B1			;7/64 seconds	+
LAED5:	.byte $04			;Drumbeat 01	| Repeat 32 times.
LAED6:	.byte $04			;Drumbeat 01	+
LAED7:	.byte $FF			;
LAED8:	.byte $E0			;
LAED9:	.byte $B0			;1/4 seconds	+
LAEDA:	.byte $04			;Drumbeat 01	|
LAEDB:	.byte $04			;Drumbeat 01	|
LAEDC:	.byte $B1			;7/64 seconds	|
LAEDD:	.byte $07			;Drumbeat 02	| Repeat 32 times.
LAEDE:	.byte $B0			;1/4 seconds	|
LAEDF:	.byte $0A			;Drumbeat 03	|
LAEE0:	.byte $04			;Drumbeat 01	|
LAEE1:	.byte $B1			;7/64 seconds	|
LAEE2:	.byte $07			;Drumbeat 02	+
LAEE3:	.byte $FF			;
LAEE4:	.byte $C8			;
LAEE5:	.byte $B0			;1/4 seconds	+
LAEE6:	.byte $04			;Drumbeat 01	|
LAEE7:	.byte $04			;Drumbeat 01	|
LAEE8:	.byte $04			;Drumbeat 01	|
LAEE9:	.byte $01			;Drumbeat 00	|
LAEEA:	.byte $01			;Drumbeat 00	|
LAEEB:	.byte $01			;Drumbeat 00	|
LAEEC:	.byte $04			;Drumbeat 01	| Repeat 8 times.
LAEED:	.byte $04			;Drumbeat 01	|
LAEEE:	.byte $04			;Drumbeat 01	|
LAEEF:	.byte $01			;Drumbeat 00	|
LAEF0:	.byte $04			;Drumbeat 01	|
LAEF1:	.byte $04			;Drumbeat 01	|
LAEF2:	.byte $04			;Drumbeat 01	|
LAEF3:	.byte $04			;Drumbeat 01	|
LAEF4:	.byte $04			;Drumbeat 01	|
LAEF5:	.byte $01			;Drumbeat 00	+
LAEF6:	.byte $FF			;
LAEF7:	.byte $B4			;7/8 seconds
LAEF8:	.byte $07			;Drumbeat 02
LAEF9:	.byte $B2			;7/32 seconds
LAEFA:	.byte $01			;Drumbeat 00
LAEFB:	.byte $B0			;1/4 seconds
LAEFC:	.byte $07			;Drumbeat 02
LAEFD:	.byte $01			;Drumbeat 00
LAEFE:	.byte $07			;Drumbeat 02
LAEFF:	.byte $07			;Drumbeat 02
LAF00:	.byte $B2			;7/32 seconds
LAF01:	.byte $07			;Drumbeat 02
LAF02:	.byte $00			;End of end music.

;Unused tile patterns.
LAF03:	.byte $80, $40, $20, $10, $88, $00, $00, $00, $00, $00, $00, $00, $80, $04, $00, $02
LAF13:	.byte $02, $00, $00, $00, $00, $07, $03, $03, $03, $01, $00, $00, $00, $84, $C4, $42
LAF23:	.byte $62, $21, $31, $11, $11, $80, $C0, $C0, $E0, $E0, $F0, $F0, $F0, $00, $00, $00
LAF33:	.byte $00, $00, $00, $00, $01, $00, $00, $00, $00, $01, $01, $03, $03, $11, $11, $31
LAF43:	.byte $21, $63, $62, $C4, $84, $F0, $F0, $F0, $E0, $E0, $E0, $C0, $80, $01, $13, $16
LAF53:	.byte $2C, $78, $B3, $EC, $F0, $07, $1F, $1E, $3C, $78, $F0, $E0, $00, $08, $10, $20
LAF63:	.byte $40, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $82, $CC, $4E
LAF73:	.byte $4C, $40, $4C, $4C, $4C, $82, $CC, $CE, $CC, $C0, $CC, $CC, $CC, $00, $00, $00
LAF83:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LAF93:	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LAFA3:	.byte $01, $03, $06, $0C, $18, $00, $00, $00, $00, $00, $01, $03, $07, $0F, $3C, $E0
LAFB3:	.byte $84, $08, $30, $60, $E0, $00, $02, $1F, $7A, $F4, $C8, $98, $10, $19, $31, $33
LABC3:	.byte $63, $63, $67, $E7, $E7, $06, $0E, $0C, $1C, $1C, $18, $18, $18, $C0, $C0, $80
LAFD3:	.byte $80, $80, $00, $00, $00, $30, $30, $60, $60, $60, $E0, $E0, $E0, $C7, $C7, $C7
LAFE3:	.byte $C7, $C7, $C7, $C7, $C7, $38, $38, $38, $38, $38, $38, $38, $38, $20, $20, $20
LAFF3:	.byte $20, $20, $20, $20, $20, $C0, $C0, $C0, $C0, $C0, $C0, $C0, $C0 

IntroSQ2Data:
LB000:	.byte $C2			;
LB001:	.byte $B4			;7/8 seconds	+
LB002:	.byte $64			;D6		|
LB003:	.byte $74			;A#6		|
LB004:	.byte $6A			;F6		|
LB005:	.byte $02			;No sound	| Repeat 2 times.
LB006:	.byte $64			;D6		|
LB007:	.byte $78			;C7		|
LB008:	.byte $74			;A#6		|
LB009:	.byte $02			;No sound	+
LB00A:	.byte $FF			;
LB00B:	.byte $C2			;
LB00C:	.byte $B2			;7/32 seconds	+
LB00D:	.byte $72			;A6		|
LB00E:	.byte $5A			;A5		|
LB00F:	.byte $6E			;G6		|
LB010:	.byte $56			;G5		|
LB011:	.byte $6C			;F#6		|
LB012:	.byte $54			;F#5		|
LB013:	.byte $68			;E6		| Repeat 2 times.
LB014:	.byte $50			;E5		|
LB015:	.byte $6E			;G6		|
LB016:	.byte $56			;G5		|
LB017:	.byte $6C			;F#6		|
LB018:	.byte $54			;F#5		|
LB019:	.byte $68			;E6		|
LB01A:	.byte $50			;E5		|
LB01B:	.byte $64			;D6		|
LB01C:	.byte $4C			;D5		+
LB01D:	.byte $FF			;
LB01E:	.byte $C4			;
LB01F:	.byte $72			;A6		+
LB020:	.byte $5A			;A5		|
LB021:	.byte $6E			;G6		|
LB022:	.byte $5A			;A5		|
LB023:	.byte $6C			;F#6		|
LB024:	.byte $5A			;A5		|
LB025:	.byte $68			;E6		|
LB026:	.byte $5A			;A5		| Repeat 4 times.
LB027:	.byte $6E			;G6		|
LB028:	.byte $56			;G5		|
LB029:	.byte $6C			;F#6		|
LB02A:	.byte $56			;G5		|
LB02B:	.byte $68			;E6		|
LB02C:	.byte $56			;G5		|
LB02D:	.byte $64			;D6		|
LB02E:	.byte $56			;G5		+
LB02F:	.byte $FF			;
LB030:	.byte $B2			;7/32 seconds
LB031:	.byte $5A			;A5
LB032:	.byte $B1			;7/64 seconds
LB033:	.byte $42			;A4
LB034:	.byte $B2			;7/32 seconds
LB035:	.byte $56			;G5
LB036:	.byte $B1			;7/64 seconds
LB037:	.byte $42			;A4
LB038:	.byte $B2			;7/32 seconds
LB039:	.byte $54			;F#5
LB03A:	.byte $B1			;7/64 seconds
LB03B:	.byte $42			;A4
LB03C:	.byte $B2			;7/32 seconds
LB03D:	.byte $50			;E5
LB03E:	.byte $B1			;7/64 seconds
LB03F:	.byte $42			;A4
LB040:	.byte $B2			;7/32 seconds
LB041:	.byte $5A			;A5
LB042:	.byte $B1			;7/64 seconds
LB043:	.byte $42			;A4
LB044:	.byte $B2			;7/32 seconds
LB045:	.byte $56			;G5
LB046:	.byte $B1			;7/64 seconds
LB047:	.byte $42			;A4
LB048:	.byte $B2			;7/32 seconds
LB049:	.byte $52			;F5
LB04A:	.byte $B1			;7/64 seconds
LB04B:	.byte $42			;A4
LB04C:	.byte $B2			;7/32 seconds
LB04D:	.byte $50			;E5
LB04E:	.byte $B1			;7/64 seconds
LB04F:	.byte $42			;A4
LB050:	.byte $B2			;7/32 seconds
LB051:	.byte $5A			;A5
LB052:	.byte $B1			;7/64 seconds
LB053:	.byte $44			;A#4
LB054:	.byte $B2			;7/32 seconds
LB055:	.byte $56			;G5
LB056:	.byte $B1			;7/64 seconds
LB057:	.byte $44			;A#4
LB058:	.byte $B2			;7/32 seconds
LB059:	.byte $52			;F5
LB05A:	.byte $B1			;7/64 seconds
LB05B:	.byte $44			;A#4
LB05C:	.byte $B2			;7/32 seconds
LB05D:	.byte $56			;G5
LB05E:	.byte $B1			;7/64 seconds
LB05F:	.byte $44			;A#4
LB060:	.byte $C4			;
LB061:	.byte $5A			;A5		+
LB062:	.byte $50			;E5		| Repeat 4 times.
LB063:	.byte $46			;B4		+
LB064:	.byte $FF			;
LB065:	.byte $C3			;
LB066:	.byte $58			;Ab5		+
LB067:	.byte $50			;E5		| Repeat 3 times.
LB068:	.byte $46			;B4		+
LB069:	.byte $FF			;
LB06A:	.byte $58			;Ab5
LB06B:	.byte $50			;E5
LB06C:	.byte $B0			;1/4 seconds
LB06D:	.byte $46			;B4
LB06E:	.byte $02			;No sound
LB06F:	.byte $E0			;
LB070:	.byte $B6			;21/32 seconds	+
LB071:	.byte $1C			;D3		| Repeat 32 times.
LB072:	.byte $B2			;7/32 seconds	|
LB073:	.byte $02			;No sound	+
LB074:	.byte $FF			;
LB075:	.byte $00			;End intro music.

IntroTriangleData:
LB076:	.byte $D0
LB077:	.byte $B6			;21/32 seconds	+
LB078:	.byte $2A			;A3		|
LB079:	.byte $B1			;7/64 seconds	| Repeat 16 times.
LB07A:	.byte $2A			;A3		|
LB07B:	.byte $B1			;7/64 seconds	|
LB07C:	.byte $02			;No sound	+
LB07D:	.byte $FF			;
LB07E:	.byte $B4			;7/8 seconds
LB07F:	.byte $4C			;D5
LB080:	.byte $60			;C6
LB081:	.byte $5E			;B5
LB082:	.byte $5C			;A#5
LB083:	.byte $54			;F#5
LB084:	.byte $60			;C6
LB085:	.byte $5C			;A#5
LB086:	.byte $56			;G5
LB087:	.byte $C2			;
LB088:	.byte $34			;D4		+
LB089:	.byte $48			;C5		|
LB08A:	.byte $46			;B4		|
LB08B:	.byte $44			;A#4		| Repeat 2 times.
LB08C:	.byte $3C			;F#4		|
LB08D:	.byte $48			;C5		|
LB08E:	.byte $44			;A#4		|
LB08F:	.byte $3E			;G4		+
LB090:	.byte $FF			;
LB091:	.byte $C2			;
LB092:	.byte $B2			;7/32 seconds	+
LB093:	.byte $34			;D4		|
LB094:	.byte $B1			;7/64 seconds	| Repeat 2 times.
LB095:	.byte $42			;A4		|
LB096:	.byte $B5			;1 13/16 seconds|
LB097:	.byte $4C			;D5		+
LB098:	.byte $FF			;
LB099:	.byte $C2			;
LB09A:	.byte $B2			;7/32 seconds	+
LB09B:	.byte $2C			;A#3		|
LB09C:	.byte $B1			;7/64 seconds	| Repeat 2 times.
LB09D:	.byte $3A			;F4		|
LB09E:	.byte $B5			;1 13/16 seconds|
LB09F:	.byte $48			;C5		+
LB0A0:	.byte $FF			;
LB0A1:	.byte $C2			;
LB0A2:	.byte $B2			;7/32 seconds	+
LB0A3:	.byte $1E			;D#3		|
LB0A4:	.byte $B1			;7/64 seconds	| Repeat 2 times.
LB0A5:	.byte $2C			;A#3		|
LB0A6:	.byte $B5			;1 13/16 seconds|
LB0A7:	.byte $36			;D#4		+
LB0A8:	.byte $FF			;
LB0A9:	.byte $C4			;
LB0AA:	.byte $B2			;7/32 seconds	+
LB0AB:	.byte $20			;E3		|
LB0AC:	.byte $B1			;7/64 seconds	| Repeat 4 times.
LB0AD:	.byte $2E			;B3		|
LB0AE:	.byte $B5			;1 13/16 seconds|
LB0AF:	.byte $38			;E4		+
LB0B0:	.byte $FF			;
LB0B1:	.byte $E0			;
LB0B2:	.byte $B6			;21/32 seconds	+
LB0B3:	.byte $2A			;A3		|
LB0B4:	.byte $B1			;7/64 seconds	| Repeat 32 times.
LB0B5:	.byte $2A			;A3		|
LB0B6:	.byte $B1			;7/64 seconds	|
LB0B7:	.byte $02			;No sound	+
LB0B8:	.byte $FF			;

IntroSQ1Data:
LB0B9:	.byte $D0			;
LB0BA:	.byte $B6			;21/32 seconds	+
LB0BB:	.byte $06			;D2		| Repeat 16 times.
LB0BC:	.byte $B2			;7/32 seconds	|
LB0BD:	.byte $02			;No sound	+
LB0BE:	.byte $FF			;
LB0BF:	.byte $C8			;
LB0C0:	.byte $B4			;7/8 seconds	+ Repeat 8 times.
LB0C1:	.byte $02			;No sound	+
LB0C2:	.byte $FF			;
LB0C3:	.byte $B2			;7/32 seconds
LB0C4:	.byte $24			;F#3
LB0C5:	.byte $26			;G3
LB0C6:	.byte $2A			;A3
LB0C7:	.byte $2E			;B3
LB0C8:	.byte $34			;D4
LB0C9:	.byte $38			;E4
LB0CA:	.byte $3C			;F#4
LB0CB:	.byte $3E			;G4
LB0CC:	.byte $B6			;21/32 seconds
LB0CD:	.byte $42			;A4
LB0CE:	.byte $B1			;7/64 seconds
LB0CF:	.byte $3E			;G4
LB0D0:	.byte $3C			;F#4
LB0D1:	.byte $B6			;21/32 seconds
LB0D2:	.byte $3E			;G4
LB0D3:	.byte $B1			;7/64 seconds
LB0D4:	.byte $3C			;F#4
LB0D5:	.byte $38			;E4
LB0D6:	.byte $B6			;21/32 seconds
LB0D7:	.byte $34			;D4
LB0D8:	.byte $B2			;7/32 seconds
LB0D9:	.byte $42			;A4
LB0DA:	.byte $B4			;7/8 seconds
LB0DB:	.byte $4C			;D5
LB0DC:	.byte $B3			;7/16 seconds
LB0DD:	.byte $44			;A#4
LB0DE:	.byte $42			;A4
LB0DF:	.byte $3E			;G4
LB0E0:	.byte $3C			;F#4
LB0E1:	.byte $B6			;21/32 seconds
LB0E2:	.byte $38			;E4
LB0E3:	.byte $B2			;7/32 seconds
LB0E4:	.byte $3C			;F#4
LB0E5:	.byte $B6			;21/32 seconds
LB0E6:	.byte $42			;A4
LB0E7:	.byte $B2			;7/32 seconds
LB0E8:	.byte $4C			;D5
LB0E9:	.byte $B6			;21/32 seconds
LB0EA:	.byte $38			;E4
LB0EB:	.byte $B2			;7/32 seconds
LB0EC:	.byte $3C			;F#4
LB0ED:	.byte $B4			;7/8 seconds
LB0EE:	.byte $34			;D4
LB0EF:	.byte $B3			;7/16 seconds
LB0F0:	.byte $2A			;A3
LB0F1:	.byte $2E			;B3
LB0F2:	.byte $34			;D4
LB0F3:	.byte $38			;E4
LB0F4:	.byte $B6			;21/32 seconds
LB0F5:	.byte $34			;D4
LB0F6:	.byte $B2			;7/32 seconds
LB0F7:	.byte $2C			;A#3
LB0F8:	.byte $B4			;7/8 seconds
LB0F9:	.byte $26			;G3
LB0FA:	.byte $B5			;1 13/16 seconds
LB0FB:	.byte $38			;E4
LB0FC:	.byte $3C			;F#4
LB0FD:	.byte $42			;A4
LB0FE:	.byte $4C			;D5
LB0FF:	.byte $34			;D4
LB100:	.byte $3A			;F4
LB101:	.byte $48			;C5
LB102:	.byte $42			;A4
LB103:	.byte $36			;D#4
LB104:	.byte $3E			;G4
LB105:	.byte $4C			;D5
LB106:	.byte $44			;A#4
LB107:	.byte $42			;A4
LB108:	.byte $38			;E4
LB109:	.byte $2E			;B3
LB10A:	.byte $38			;E4
LB10B:	.byte $40			;Ab4
LB10C:	.byte $38			;E4
LB10D:	.byte $2E			;B3
LB10E:	.byte $38			;E4
LB10F:	.byte $E0			;
LB110:	.byte $B6			;21/32 seconds	+
LB111:	.byte $06			;D2		| Repeat 32 times.
LB112:	.byte $B2			;7/32 seconds	|
LB113:	.byte $02			;No sound	+
LB114:	.byte $FF			;

IntroNoiseIndexData:
LB115:	.byte $D0			;
LB116:	.byte $B4			;7/8 Seconds	+ Repeat 16 times.
LB117:	.byte $04			;Drumbeat 01	+
LB118:	.byte $FF			;
LB119:	.byte $CC			;
LB11A:	.byte $B2			;7/32 Seconds	+
LB11B:	.byte $04			;Drumbeat 01	|
LB11C:	.byte $04			;Drumbeat 01	|
LB11D:	.byte $B5			;1 13/16 Seconds|
LB11E:	.byte $07			;Drumbeat 02	|
LB11F:	.byte $B0			;1/4 Seconds	|
LB120:	.byte $04			;Drumbeat 01	| Repeat 12 times.
LB121:	.byte $04			;Drumbeat 01	|
LB122:	.byte $B6			;21/32 Seconds	|
LB123:	.byte $04			;Drumbeat 01	|
LB124:	.byte $B1			;7/64 Seconds	|
LB125:	.byte $04			;Drumbeat 01	|
LB126:	.byte $04			;Drumbeat 01	+
LB127:	.byte $FF			;
LB128:	.byte $CA			;
LB129:	.byte $B1			;7/64 Seconds	+
LB12A:	.byte $04			;Drumbeat 01	|
LB12B:	.byte $04			;Drumbeat 01	|
LB12C:	.byte $04			;Drumbeat 01	| Repeat 10 times.
LB12D:	.byte $07			;Drumbeat 02	|
LB12E:	.byte $04			;Drumbeat 01	|
LB12F:	.byte $04			;Drumbeat 01	+
LB130:	.byte $FF			;
LB131:	.byte $E0			;
LB132:	.byte $B4			;7/8 Seconds	+ Repeat 32 times.
LB133:	.byte $04			;Drumbeat 01	+
LB134:	.byte $FF			;

;Unused tile patterns.
LB135:	.byte $E0, $E0, $F0, $00, $00, $00, $00, $00, $00, $00, $00, $21, $80, $40, $02, $05
LB145:	.byte $26, $52, $63, $00, $00, $00, $06, $07, $67, $73, $73, $FF, $AF, $2F, $07, $0B
LB155:	.byte $8D, $A7, $B1, $00, $00, $00, $00, $00, $80, $80, $80, $F8, $B8, $F8, $F8, $F0
LB165:	.byte $F0, $F8, $FC, $00, $00, $00, $00, $00, $00, $00, $00, $07, $07, $07, $07, $07
LB175:	.byte $03, $03, $01, $00, $00, $00, $00, $00, $00, $00, $80, $FF, $C7, $83, $03, $C7
LB185:	.byte $CF, $FE, $EC, $00, $30, $78, $F8, $30, $00, $01, $12, $F5, $EA, $FB, $FD, $F9
LB195:	.byte $1E, $0E, $44, $07, $03, $03, $01, $01, $E0, $10, $48, $2B, $3B, $1B, $5A, $D0
LB1A5:	.byte $D1, $C3, $C3, $3B, $3B, $9B, $DA, $D0, $D0, $C0, $C0, $2C, $23, $20, $20, $30
LB1B5:	.byte $98, $CF, $C7, $00, $00, $00, $00, $00, $00, $00, $30, $1F, $80, $C0, $C0, $60
LB1C5:	.byte $70, $FC, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $00
LB1D5:	.byte $00, $00, $00, $80, $80, $C0, $78, $4C, $C7, $80, $80, $C4, $A5, $45, $0B, $1B
LB1E5:	.byte $03, $03, $00, $3A, $13, $31, $63, $C3, $83, $03, $04, $E6, $E6, $C4, $8E, $1C
LB1F5:	.byte $3C, $18, $30, $E8, $E8, $C8, $90, $60, $00, $00, $00

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
;1st  SFX cycle $E0=#$BB,$E1=#$B2,$E2=#$22,$E3=#$B3.  Base address=$B289
;2nd  SFX cycle $E0=#$CB,$E1=#$B2,$E2=#$EE,$E3=#$B4.  Base address=$B28E
;3rd  SFX cycle $E0=#$06,$E1=#$BC,$E2=#$5C,$E3=#$B3.  Base address=$B2A7
;4th  SFX cycle $E0=#$16,$E1=#$BC,$E2=#$64,$E3=#$B3.  Base address=$B2AC
;5th  SFX cycle $E0=#$DB,$E1=#$B2,$E2=#$30,$E3=#$B3.  Base address=$B293
;6th  SFX cycle $E0=#$EB,$E1=#$B2,$E2=#$EE,$E3=#$B4.  Base address=$B298
;7th  SFX cycle $E0=#$FB,$E1=#$B2,$E2=#$44,$E3=#$B3.  Base address=$B29D
;8th  SFX cycle $E0=#$0B,$E1=#$B3,$E2=#$EE,$E3=#$B4.  Base address=$B2A2
;9th  SFX cycle $E0=#$26,$E1=#$BC,$E2=#$3D,$E3=#$BC.  Base address=$B2B6
;10th SFX cycle $E0=#$26,$E1=#$BC,$E2=#$4B,$E3=#$BC.  Base address=$B2B1

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

;The following table is used by the below routine to load SQ1Cntrl2 data in the
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

;The following continue routine is used by the metal, out of hole,
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

;Kraid area music(not used this memory page).
LBD58:	.byte $00, $FF, $F0, $00, $00
LBD5D:	.word $0100, $0300, $0500, $0000

;Item room music.
LBD65:	.byte $0B, $FF, $03, $00, $00
LBD6A:	.word $BDDA, $BDDC, $BDCD, $0000

;Ridley area music(not used this memory page).
LBD72:	.byte $0B, $FF, $F0, $01, $01
LBD77:	.word $0100, $0300, $0500, $0000

;End game music
LBD7F:	.byte $17, $00, $00, $02, $01
LBD84:	.word $AC00, $ADC5, $ACF5, $AE8E

;Intro music
LBD8C:	.byte $17, $00, $F0, $02, $05
LBD91:	.word $B0B9, $B000, $B076, $B115

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

;Not used.
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

;Not used.
LBFD5: 	.byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00, $00, $00
LBFE5: 	.byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
LBFF5:	.byte $00, $00, $00, $00, $00

;----------------------------------------[ Interrupt vectors ]--------------------------------------

LBFFA: 	.word NMI			;($C0D9)NMI vector.
LBFFC:	.word RESET			;($FFB0)Reset vector.
LBFFE: 	.word RESET			;($FFB0)IRQ vector.