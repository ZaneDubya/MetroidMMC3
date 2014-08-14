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
; Disassembled, reconstructed and commented
; by SnowBro [Kent Hansen] <kentmhan@online.no>
; Continued by Dirty McDingus (nmikstas@yahoo.com)
; Can be reassembled using Ophis.
; A work in progress.
;Last updated: 3/9/2010

;Game engine (memory page 7)

.org $C000

.include "Defines.asm"

;-------------------------------------[ Forward declarations ]--------------------------------------

.alias ObjectAnimIndexTbl	$8572
.alias FramePtrTable		$860B
.alias PlacePtrTable		$86DF
.alias StarPalSwitch		$8AC7
.alias SamusEnterDoor		$8B13
.alias AreaPointers		$9598
.alias AreaRoutine		$95C3
.alias EnemyHitPointTbl		$962B
.alias EnemyInitDelayTbl	$96BB
.alias DecSpriteYCoord		$988A
.alias NMIScreenWrite		$9A07
.alias EndGamePalWrite		$9F54
.alias SpecItmsTable		$9598
.alias CopyMap			$A93E
.alias SoundEngine		$B3B4

;----------------------------------------[ Start of code ]------------------------------------------

;This routine generates pseudo random numbers and updates those numbers
;every frame. The random numbers are used for several purposes including
;password scrambling and determinig what items, if any, an enemy leaves
;behind after it is killed.

RandomNumbers:
LC000:	txa				;		
LC001:	pha				;
LC002:	ldx #$05			;
LC004:*	lda RandomNumber1		;
LC006:	clc				;
LC007:	adc #$05			;
LC009:	sta RandomNumber1		;2E is increased by #$19 every frame and-->
LC00B:	lda RandomNumber2		;2F is increased by #$5F every frame.			
LC00D:	clc				;
LC00E:	adc #$13			;
LC010:	sta RandomNumber2		;
LC012:	dex				;
LC013:	bne -				;
LC015:	pla				;
LC016:	tax				;
LC017:	lda RandomNumber1		;
LC019:	rts				;

;------------------------------------------[ Startup ]----------------------------------------------

Startup:
LC01A:	lda #$00			;
LC01C:	sta MMC1Reg1 			;Clear bit 0. MMC1 is serial controlled
LC01F:	sta MMC1Reg1			;Clear bit 1
LC022:	sta MMC1Reg1			;Clear bit 2
LC024:	sta MMC1Reg1			;Clear bit 3
LC027:	sta MMC1Reg1			;Clear bit 4 
LC02B:	sta MMC1Reg2			;Clear bit 0
LC02E:	sta MMC1Reg2			;Clear bit 1
LC031:	sta MMC1Reg2			;Clear bit 2
LC034:	sta MMC1Reg2			;Clear bit 3
LC037:	sta MMC1Reg2			;Clear bit 4 
LC03A:	jsr MMCWriteReg3		;($C4FA)Swap to PRG bank #0 at $8000
LC03D:	dex				;X = $FF
LC03E:	txs				;S points to end of stack page

;Clear RAM at $000-$7FF.
LC03F:	ldy #$07			;High byte of start address.
LC041:	sty $01				;
LC043:	ldy #$00      			;Low byte of start address.
LC045:	sty $00       			;$0000 = #$0700
LC047:	tya	    			;A = 0
LC048:*	sta ($00),y    			;clear address
LC04A:	iny				;
LC04B:	bne -	  			;Repeat for entire page.
LC04D:	dec $01       			;Decrement high byte of address.
LC04F:	bmi +	 			;If $01 < 0, all pages are cleared.
LC051:	ldx $01				;
LC053:	cpx #$01			;Keep looping until ram is cleared.
LC055:	bne -				;

;Clear cartridge RAM at $6000-$7FFF.
LC057:*	ldy #$7F			;High byte of start address.
LC059:	sty $01				;
LC05B:	ldy #$00			;Low byte of start address.
LC05D:	sty $00				;$0000 points to $7F00
LC05F:	tya	   			;A = 0
LC060:*	sta ($00),y			;
LC062:	iny				;Clears 256 bytes of memory before decrementing to next-->
LC063:	bne -				;256 bytes.
LC065:	dec $01				;
LC067:	ldx $01				;Is address < $6000?-->
LC069:	cpx #$60     			;If not, do another page.
LC06B:	bcs -      			; 

LC06D:	lda #%00001110			;Verticle mirroring.
					;H/V mirroring (As opposed to one-screen mirroring).
					;Switch low PRGROM area during a page switch.
					;16KB PRGROM switching enabled.
					;8KB CHRROM switching enabled.
LC06F:	sta MMCReg0Cntrl		;

LC071:	lda #$00			;Clear bits 3 and 4 of MMC1 register 3.
LC073:	sta SwitchUpperBits		;

LC075:	ldy #$00			;
LC077:	sty ScrollX			;ScrollX = 0
LC079:	sty ScrollY     		;ScrollY = 0
LC07B:	sty PPUScroll			;Clear hardware scroll x
LC07E:	sty PPUScroll			;Clear hardware scroll y
LC081:	iny				;Y = #$01
LC082:	sty GameMode			;Title screen mode
LC084:	jsr ClearNameTables		;($C158)
LC087:	jsr EraseAllSprites		;($C1A3)

LC08A:	lda #%10010000			;NMI = enabled
					;Sprite size = 8x8
					;BG pattern table address = $1000
					;SPR pattern table address = $0000
					;PPU address increment = 1
					;Name table address = $2000
LC08C:	sta PPUControl0			;
LC08F:	sta PPUCNT0ZP			;

LC091:	lda #%00000010			;Sprites visible = no
					;Background visible = no
					;Sprite clipping = yes
					;Background clipping = no
					;Display type = color
LC093:	sta PPUCNT1ZP			;

LC095:	lda #$47			;
LC097:	sta MirrorCntrl			;Prepare to set PPU to vertical mirroring.
LC099:	jsr PrepVertMirror		;($C4B2)

LC09C:	lda #$00			;
LC09E:	sta DMCCntrl1			;PCM volume = 0 - disables DMC channel
LC0A1:	lda #$0F			;
LC0A3:	sta APUCommonCntrl0		;Enable sound channel 0,1,2,3

LC0A6:	ldy #$00			;
LC0A8:	sty TitleRoutine		;Set title routine and and main routine function-->
LC0AA:	sty MainRoutine			;pointers equal to 0.
LC0AC:	lda #$11			;
LC0AE:	sta RandomNumber1		;Initialize RandomNumber1 to #$11
LC0B0:	lda #$FF			;
LC0B2:	sta RandomNumber2		;Initialize RandomNumber2 to #$FF

LC0B4:	iny				;Y = 1
LC0B5:	sty SwitchPending		;Prepare to switch page 0 into lower PRGROM.
LC0B7:	jsr CheckSwitch			;($C4DE)
LC0BA:	bne WaitNMIEnd			;Branch always

;-----------------------------------------[ Main loop ]----------------------------------------------

;The main loop runs all the routines that take place outside of the NMI.

MainLoop:
LC0BC:	jsr CheckSwitch			;($C4DE)Check to see if memory page needs to be switched.
LC0BF:	jsr UpdateTimer			;($C266)Update Timers 1, 2 and 3.
LC0C2:	jsr GoMainRoutine		;($C114)Go to main routine for updating game.
LC0C5:	inc FrameCount			;Increment frame counter.
LC0C7:	lda #$00			;
LC0C9:	sta NMIStatus			;Wait for next NMI to end.

WaitNMIEnd:
LC0CB:	tay				;
LC0CC:	lda NMIStatus			;
LC0CE:	bne +				;If nonzero, NMI has ended. Else keep waiting.
LC0D0:	jmp WaitNMIEnd			;

LC0D3:*	jsr RandomNumbers		;($C000)Update pseudo random numbers.
LC0D6:	jmp MainLoop			;($C0BC)Jump to top of subroutine.

;-------------------------------------[ Non-Maskable Interrupt ]-------------------------------------

;The NMI is called 60 times a second by the VBlank signal from the PPU. When the
;NMI routine is called, the game should already be waiting for it in the main 
;loop routine in the WaitNMIEnd loop.  It is possible that the main loop routine
;will not be waiting as it is bogged down with excess calculations. This causes
;the game to slow down.

NMI:
LC0D9:	php				;Save processor status, A, X and Y on stack.
LC0DA:	pha				;Save A.
LC0DB:	txa				;
LC0DC:	pha				;Save X.
LC0DD:	tya				;
LC0DE:	pha				;Save Y.
LC0DF:	lda #$00			;
LC0E1:	sta SPRAddress			;Sprite RAM address = 0.
LC0E4:	lda #$02			;
LC0E6:	sta SPRDMAReg			;Transfer page 2 ($200-$2FF) to Sprite RAM.
LC0E9:	lda NMIStatus			;
LC0EB:	bne ++				;Skip if the frame couldn't finish in time.
LC0ED:	lda GameMode			;
LC0EF:	beq +				;Branch if mode=Play.
LC0F1:	jsr NMIScreenWrite		;($9A07)Write end message on screen(If appropriate).
LC0F4:*	jsr CheckPalWrite		;($C1E0)Check if palette data pending.
LC0F7:	jsr CheckPPUWrite		;($C2CA)check if data needs to be written to PPU.
LC0FA:	jsr WritePPUCtrl		;($C44D)Update $2000 & $2001.
LC0FD:	jsr WriteScroll			;($C29A)Update h/v scroll reg.
LC100:	jsr ReadJoyPads			;($C215)Read both joypads.
LC103:* jsr SoundEngine			;($B3B4)Update music and SFX.
LC106:	jsr UpdateAge			;($C97E)Update Samus' age.
LC109:	ldy #$01			; NMI = finished.
LC10B:	sty NMIStatus			;
LC10D:	pla				;Restore Y.
LC10E:	tay				;
LC10F:	pla				;Restore X.
LC110:	tax				;
LC111:	pla				;restore A.
LC112:	plp				;Restore processor status flags.
LC113:	rti				;Return from NMI.

;----------------------------------------[ GoMainRoutine ]-------------------------------------------

;This is where the real code of each frame is executed.
;MainRoutine or TitleRoutine (Depending on the value of GameMode)
;is used as an index into a code pointer table, and this routine
;is executed.

GoMainRoutine:
LC114:	lda GameMode			;0 if game is running, 1 if at intro screen.
LC116:	beq +				;Branch if mode=Play.
LC118:	jmp $8000			;Jump to $8000, where a routine similar to the one-->
					;below is executed, only using TitleRoutine instead
					;of MainRoutine as index into a jump table.
LC11B:*	lda Joy1Change			;
LC11D:	and #$10			;Has START been pressed?-->
LC11F:	beq +++				;if not, execute current routine as normal.

LC121:	lda MainRoutine			;
LC123:	cmp #$03			;Is game engine running?-->
LC125:	beq +				;If yes, check for routine #5 (pause game).
LC127:	cmp #$05			;Is game paused?-->
LC129:	bne +++				;If not routine #5 either, don't care about START being pressed.
LC12B:	lda #$03			;Otherwise, switch to routine #3 (game engine).
LC12D:	bne ++				;Branch always.
LC12F:*	lda #$05			;Switch to pause routine.
LC131:*	sta MainRoutine			;(MainRoutine = 5 if game paused, 3 if game engine running).
LC133:	lda GamePaused			;
LC135:	eor #$01			;Toggle game paused.
LC137:	sta GamePaused			;
LC139:	jsr PauseMusic			;($CB92)Silences music while game paused.

LC13c:*	lda MainRoutine			;
LC13E:	jsr ChooseRoutine		;($C27C)Use MainRoutine as index into routine table below.

;Pointer table to code.

LC141:	.word AreaInit			;($C801)Area init.
LC143:	.word MoreInit			;($C81D)More area init.
LC145:	.word SamusInit			;($C8D1)Samus init.
LC147:	.word GameEngine  		;($C92B)Game engine.
LC149:	.word GameOver			;($C9A6)Display GAME OVER.
LC14B:	.word PauseMode   		;($C9B1)Pause game.
LC14D:	.word GoPassword		;($C9C4)Display password.
LC14F:	.word IncrementRoutine		;($C155)Just advances to next routine in table.
LC151:	.word SamusIntro  		;($C9D7)Intro.
LC153:	.word WaitTimer   		;($C494)Delay.

IncrementRoutine:
LC155:	inc MainRoutine			;Increment to next routine in above table.
LC157:	rts				;

;-------------------------------------[ Clear name tables ]------------------------------------------

ClearNameTables:
LC158:	jsr ClearNameTable0		;($C16D)Always clear name table 0 first.
LC15B:	lda GameMode			;
LC15D:	beq +				;Branch if mode = Play.
LC15F:	lda TitleRoutine		;
LC161:	cmp #$1D			;If running the end game routine, clear-->
LC163:	beq ++				;name table 2, else clear name table 1.
LC165:*	lda #$02			;Name table to clear + 1 (name table 1).
LC167:	bne +++				;Branch always.
LC169:*	lda #$03			;Name table to clear + 1 (name table 2).
LC16B:	bne ++				;Branch always.

ClearNameTable0:
LC16D:*	lda #$01			;Name table to clear + 1 (name table 0).
LC16F:*	sta $01				;Stores name table to clear.
LC171:	lda #$FF			;
LC173:	sta $00				;Value to fill with.

ClearNameTable:
LC175:	ldx PPUStatus			;Reset PPU address latch.
LC178:	lda PPUCNT0ZP			;
LC17A:	and #$FB			;PPU increment = 1.
LC17C:	sta PPUCNT0ZP			;
LC17E:	sta PPUControl0			;Store control bits in PPU.
LC181:	ldx $01				;
LC183:	dex				;Name table = X - 1.
LC184:	lda HiPPUTable,x		;get high PPU address.  pointer table at $C19F.
LC187:	sta PPUAddress			;
LC18A:	lda #$00			;Set PPU start address (High byte first).
LC18C:	sta PPUAddress			;
LC18F:	ldx #$04			;Prepare to loop 4 times.
LC191:	ldy #$00			;Inner loop value.
LC193:	lda $00				;Fill-value.
LC195:*	sta PPUIOReg			;
LC198:	dey				;
LC199:	bne -				;Loops until the desired name table is cleared.-->
LC19B:	dex				;It also clears the associated attribute table.
LC19C:	bne -				;
LC19E:	rts				;

;The following table is used by the above routine for finding
;the high byte of the proper name table to clear.

HiPPUTable:
LC19F: 	.byte $20			;Name table 0.
LC1A0:	.byte $24			;Name table 1.
LC1A1:	.byte $28			;Name table 2.
LC1A2:	.byte $2C			;Name table 3.

;-------------------------------------[ Erase all sprites ]------------------------------------------

EraseAllSprites:
LC1A3:	ldy #$02			;
LC1A5:	sty $01				;Loads locations $00 and $01 with -->
LC1A7:	ldy #$00			;#$00 and #$02 respectively
LC1A9:	sty $00				;
LC1AB:	ldy #$00			;
LC1AD:	lda #$F0			;
LC1AF:*	sta ($00),y			;Stores #$F0 in memory addresses $0200 thru $02FF.
LC1B1:	iny				; 
LC1B2:	bne -				;Loop while more sprite RAM to clear.
LC1B4:	lda GameMode			;
LC1B6:	beq Exit101			;Exit subroutine if GameMode=Play(#$00)
LC1B8:	jmp DecSpriteYCoord		;($988A)Find proper y coord of sprites.

Exit101:
LC1BB:	rts				;Return used by subroutines above and below.

;---------------------------------------[ Remove intro sprites ]-------------------------------------

;The following routine is used in the Intro to remove the sparkle sprites and the crosshairs
;sprites every frame.  It does this by loading the sprite values with #$F4 which moves the 
;sprite to the bottom right of the screen and uses a blank graphic for the sprite.

RemoveIntroSprites:
LC1BC:	ldy #$02			;Start at address $200.
LC1BE:	sty $01				;
LC1C0:	ldy #$00			;
LC1C2:	sty $00				;($00) = $0200 (sprite page)
LC1C4:	ldy #$5F			;Prepare to clear RAM $0200-$025F
LC1C6:	lda #$F4			;
LC1C8:*	sta ($00),y			;
LC1CA:	dey				;Loop unitl $200 thru $25F is filled with #$F4.
LC1CB:	bpl -				;
LC1CD:	lda GameMode			;
LC1CF:	beq Exit101			; branch if mode = Play.
LC1D1:	jmp DecSpriteYCoord		;($988A)Find proper y coord of sprites.

;-------------------------------------[Clear RAM $33 thru $DF]---------------------------------------

;The routine below clears RAM associated with rooms and enemies.

ClearRAM_33_DF:
LC1D4:	ldx #$33			;
LC1D6:	lda #$00			;
LC1D8:*	sta $00,x			;Clear RAM addresses $33 through $DF.
LC1DA:	inx				;
LC1DB:	cpx #$E0			;
LC1DD:	bcc -				;Loop until all desired addresses are cleared.
LC1DF:	rts				;

;--------------------------------[ Check and prepare palette write ]---------------------------------

CheckPalWrite:
LC1E0:	lda GameMode			;
LC1E2:	beq +				;Is game being played? If so, branch to exit.
LC1E4:	lda TitleRoutine		;
LC1E6:	cmp #$1D			;Is Game at ending sequence? If not, branch
LC1E8:	bcc +				;
LC1EA:	jmp EndGamePalWrite		;($9F54)Write palette data for ending.
LC1ED:*	ldy PalDataPending		;
LC1EF:	bne ++				;Is palette data pending? If so, branch.
LC1F1:	lda GameMode			;
LC1F3:	beq +	   			;Is game being played? If so, branch to exit.
LC1F5:	lda TitleRoutine		;
LC1F7:	cmp #$15			;Is intro playing? If not, branch.
LC1F9:	bcs +				;
LC1FB:	jmp StarPalSwitch		;($8AC7)Cycles palettes for intro stars twinkle.
LC1FE:*	rts				;Exit when no palette data pending.

;Prepare to write palette data to PPU.

LC1FF:*	dey				;Palette # = PalDataPending - 1.
LC200:	tya				;
LC201:	asl				;* 2, each pal data ptr is 2 bytes (16-bit).
LC202:	tay				;
LC203:	ldx $9560,y			;X = low byte of PPU data pointer.
LC206:	lda $9561,y			;
LC209:	tay				;Y = high byte of PPU data pointer.
LC20A:	lda #$00			;Clear A.
LC20C:	sta PalDataPending		;Reset palette data pending byte.

PreparePPUProcess_:
LC20E:	stx $00				;Lower byte of pointer to PPU string.
LC210:	sty $01				;Upper byte of pointer to PPU string.
LC212:	jmp ProcessPPUString		;($C30C)Write data string to PPU.

;----------------------------------------[Read joy pad status ]--------------------------------------

;The following routine reads the status of both joypads

ReadJoyPads:
LC215:	ldx #$00			;Load x with #$00. Used to read status of joypad 1.
LC217:	stx $01				;
LC219:	jsr ReadOnePad			;
LC21C:	inx				;Load x with #$01. Used to read status of joypad 2.
LC21D:	inc $01				;

ReadOnePad:
LC21F:	ldy #$01			;These lines strobe the -->       
LC221:	sty CPUJoyPad1   		;joystick to enable the -->
LC224:	dey				;program to read the -->
LC225:	sty CPUJoyPad1  		;buttons pressed.
	
LC228:	ldy #$08			;Do 8 buttons.
LC22A:*	pha				;Store A.
LC22B:	lda CPUJoyPad1,x		;Read button status. Joypad 1 or 2.
LC22E:	sta $00				;Store button press at location $00.
LC230:	lsr				;Move button push to carry bit.
LC231:	ora $00				;If joystick not connected, -->
LC233:	lsr				;fills Joy1Status with all 1s.
LC234:	pla				;Restore A.
LC235:	rol				;Add button press status to A.
LC236:	dey     			;Loop 8 times to get -->
LC237:	bne -				;status of all 8 buttons.

LC239:	ldx $01				;Joypad #(0 or 1).
LC23B:	ldy Joy1Status,x		;Get joypad status of previous refresh.
LC23D:	sty $00				;Store at $00.
LC23F:	sta Joy1Status,x		;Store current joypad status.
LC241:	eor $00				;
LC243:	beq +	   			;Branch if no buttons changed.
LC245:	lda $00				;			
LC247:	and #$BF			;Remove the previous status of the B button.
LC249:	sta $00				;
LC24B:	eor Joy1Status,x		;
LC24D:*	and Joy1Status,x		;Save any button changes from the current frame-->
LC24F:	sta Joy1Change,x		;and the last frame to the joy change addresses.
LC251:	sta Joy1Retrig,x		;Store any changed buttons in JoyRetrig address.
LC253:	ldy #$20			;
LC255:	lda Joy1Status,x		;Checks to see if same buttons are being-->
LC257:	cmp $00				;pressed this frame as last frame.-->
LC259:	bne +				;If none, branch.
LC25B:	dec RetrigDelay1,x		;Decrement RetrigDelay if same buttons pressed.
LC25D:	bne ++				;		
LC25F:	sta Joy1Retrig,x		;Once RetrigDelay=#$00, store buttons to retrigger.
LC261:	ldy #$08			;
LC263:*	sty RetrigDelay1,x		;Reset retrigger delay to #$20(32 frames)-->
LC265:*	rts				;or #$08(8 frames) if already retriggering.

;-------------------------------------------[ Update timer ]-----------------------------------------

;This routine is used for timing - or for waiting around, rather.
;TimerDelay is decremented every frame. When it hits zero, $2A, $2B and $2C are
;decremented if they aren't already zero. The program can then check
;these variables (it usually just checks $2C) to determine when it's time
;to "move on". This is used for the various sequences of the intro screen,
;when the game is started, when Samus takes a special item, and when GAME
;OVER is displayed, to mention a few examples.

UpdateTimer:
LC266:	ldx #$01			;First timer to decrement is Timer2.
LC268:	dec TimerDelay			;
LC26A:	bpl DecTimer			;
LC26C:	lda #$09			;TimerDelay hits #$00 every 10th frame.
LC26E:	sta TimerDelay			;Reset TimerDelay after it hits #$00.
LC270:	ldx #$02			;Decrement Timer3 every 10 frames.

DecTimer:
LC272:	lda Timer1,x			;
LC274:	beq +				;Don't decrease if timer is already zero.
LC276:	dec Timer1,x			;
LC278:*	dex				;Timer1 and Timer2 decremented every frame.
LC279:	bpl DecTimer			;
LC27B:	rts				;

;-----------------------------------------[ Choose routine ]-----------------------------------------

;This is an indirect jump routine. A is used as an index into a code
;pointer table, and the routine at that position is executed. The programmers
;always put the pointer table itself directly after the JSR to ChooseRoutine,
;meaning that its address can be popped from the stack.

ChooseRoutine:
LC27C:	asl				;* 2, each ptr is 2 bytes (16-bit).
LC27D:	sty TempY			;Temp storage.
LC27F:	stx TempX			;Temp storage.
LC281:	tay				;
LC282:	iny				;
LC283:	pla				;Low byte of ptr table address.
LC284:	sta CodePtr			;
LC286:	pla				;High byte of ptr table address.
LC287:	sta CodePtr+1			;
LC289:	lda (CodePtr),y			;Low byte of code ptr.
LC28B:	tax				;
LC28C:	iny				;
LC28D:	lda (CodePtr),y			;High byte of code ptr.
LC28F:	sta CodePtr+1			;
LC291:	stx CodePtr			;
LC293:	ldx TempX			;Restore X.
LC295:	ldy TempY			;Restore Y.
LC297:	jmp (CodePtr)			;

;--------------------------------------[ Write to scroll registers ]---------------------------------

WriteScroll:
LC29A:	lda PPUStatus			;Reset scroll register flip/flop
LC29D:	lda ScrollX			;
LC29F:	sta PPUScroll			;
LC2A2:	lda ScrollY			;X and Y scroll offsets are loaded serially.
LC2A4:	sta PPUScroll			;
LC2A7:	rts				;

;----------------------------------[ Add y index to stored addresses ]-------------------------------

;Add Y to pointer at $0000. 

AddYToPtr00:
LC2A8:	tya				;
LC2A9:	clc				;Add value stored in Y to lower address-->
LC2AA:	adc $00				;byte stored in $00.
LC2AC:	sta $00				;
LC2AE:	bcc +				;Increment $01(upper address byte) if carry-->
LC2B0:	inc $01				;has occurred.
LC2B2:*	rts				;

;Add Y to pointer at $0002

AddYToPtr02:
LC2B3:	tya				;
LC2B4:	clc				;Add value stored in Y to lower address-->
LC2B5:	adc $02				;byte stored in $02.
LC2B7:	sta $02				;
LC2B9:	bcc +				;Increment $01(upper address byte) if carry-->
LC2BB:	inc $03				;has occurred.
LC2BD:*	rts				;

;--------------------------------[ Simple divide and multiply routines ]-----------------------------

Adiv32: 
LC2BE:	lsr				;Divide by 32.

Adiv16: 
LC2BF:	lsr				;Divide by 16.

Adiv8:  
LC2C0:	lsr				;Divide by 8.
LC2C1:	lsr				;
LC2C2:	lsr				;Divide by shifting A right.
LC2C3:	rts				;

Amul32: 
LC2C4:	asl				;Multiply by 32.

Amul16: 
LC2C5:	asl				;Multiply by 16.

Amul8:
LC2C6:	asl				;Multiply by 8.
LC2C7:	asl				;
LC2C8:	asl				;Multiply by shifting A left.
LC2C9:	rts				;

;-------------------------------------[ PPU writing routines ]---------------------------------------

;Checks if any data is waiting to be written to the PPU.
;RLE data is one tile that repeats several times in a row.  RLE-Repeat Last Entry

CheckPPUWrite:
LC2CA:	lda PPUDataPending		;
LC2CC:	beq +	   			;If zero no PPU data to write, branch to exit.
LC2CE:	lda #$A1			;			
LC2D0:	sta $00				;Sets up PPU writer to start at address $07A1.
LC2D2:	lda #$07			;
LC2D4:	sta $01	 			;$0000 = ptr to PPU data string ($07A1).
LC2D6:	jsr ProcessPPUString    	;($C30C)write it to PPU.
LC2D9:	lda #$00			;
LC2DB:	sta PPUStrIndex			;PPU data string has been written so the data-->
LC2DE:	sta PPUDataString		;stored for the write is now erased.
LC2E1:	sta PPUDataPending		;
LC2E3:*	rts				;

PPUWrite:
LC2E4:	sta PPUAddress			;Set high PPU address.
LC2E7:	iny				;
LC2E8:	lda ($00),y			;
LC2EA:	sta PPUAddress			;Set low PPU address.
LC2ED:	iny				;
LC2EE:	lda ($00),y			;Get data byte containing rep length & RLE status.
LC2F0:	asl				;Carry Flag = PPU address increment (0 = 1, 1 = 32).
LC2F1:	jsr SetPPUInc			;($C318)Update PPUCtrl0 according to Carry Flag.
LC2F4:	asl				;Carry Flag = bit 6 of byte at ($00),y (1 = RLE).
LC2F5:	lda ($00),y			;Get data byte again.
LC2F7:	and #$3F			;Keep lower 6 bits as loop counter.
LC2F9:	tax				;
LC2FA:	bcc PPUWriteLoop		;If Carry Flag not set, the data is not RLE.
LC2FC:	iny				;Data is RLE, advance to data byte.

PPUWriteLoop:
LC2FD:	bcs +				;
LC2FF:	iny				;Only inc Y if data is not RLE.
LC300:*	lda ($00),y			;Get data byte.
LC302:	sta PPUIOReg			;Write to PPU.
LC305:	dex				;Decrease loop counter.
LC306:	bne PPUWriteLoop		;Keep going until X=0.
LC308:	iny				;
LC309:	jsr AddYToPtr00			;($C2A8)Point to next data chunk.

;Write data string at ($00) to PPU.

ProcessPPUString:
LC30C:	ldx PPUStatus			;Reset PPU address flip/flop.
LC30F:	ldy #$00			;
LC311:	lda ($00),y			;
LC313:	bne PPUWrite			;If A is non-zero, PPU data string follows,-->
LC315:	jmp WriteScroll			;($C29A)Otherwise we're done.

;In: CF = desired PPU address increment (0 = 1, 1 = 32).
;Out: PPU control #0 ($2000) updated accordingly.

SetPPUInc:
LC318:	pha				;Preserve A.
LC319:	lda PPUCNT0ZP			;
LC31B:	ora #$04			;
LC31D:	bcs +				;PPU increment = 32 only if Carry Flag set,-->
LC31F:	and #$FB			;else PPU increment = 1.
LC321:*	sta PPUControl0			;
LC323:	sta PPUCNT0ZP			;
LC326:	pla				;Restore A.
LC327:	rts				;

;Erase blasted tile on nametable.  Each screen is 16 tiles across and 15 tiles down.
EraseTile:
LC328:	ldy #$01			;
LC32A:	sty PPUDataPending		;data pending = YES.
LC32C:	dey				;
LC32D:	lda ($02),y			;
LC32F:	and #$0F			;
LC331:	sta $05				;# of tiles horizontally.
LC333:	lda ($02),y			;
LC335:	jsr Adiv16			;($C2BF)/ 16.
LC338:	sta $04				;# of tiles vertically.
LC33A:	ldx PPUStrIndex			;
LC33D:*	lda $01				;
LC33F:	jsr WritePPUByte		;($C36B)write PPU high address to $07A1,PPUStrIndex.
LC342:	lda $00				;
LC344:	jsr WritePPUByte		;($C36B)write PPU low address to $07A1,PPUStrIndex.
LC347:	lda $05				;data length.
LC349:	sta $06				;
LC34B:	jsr WritePPUByte		;($C36B)write PPU string length to $07A1,PPUStrIndex.
LC34E:*	iny				;
LC34F:	lda ($02),y			;Get new tile to replace old tile.
LC351:	jsr WritePPUByte		;($C36B)Write it to $07A1,PPUStrIndex, inc x.
LC354:	dec $06				;
LC356:	bne -				;Branch if more horizontal tiles to replace.
LC358:	stx PPUStrIndex			;
LC35B:	sty $06				;
LC35D:	ldy #$20			;
LC35F:	jsr AddYToPtr00			;($C2A8)Move to next name table line.
LC362:	ldy $06				;Store index to find next tile info.
LC364:	dec $04				;
LC366:	bne --				;Branch if more lines need to be changed on name table.
LC368:	jsr EndPPUString		;($c376)Finish writing PPU string and exit.

WritePPUByte:
LC36B:	sta PPUDataString,x		;Store data byte at end of PPUDataString.

NextPPUByte:
LC36E:	inx				;PPUDataString has increased in size by 1 byte.
LC36F:	cpx #$4F			;PPU byte writer can only write a maximum of #$4F bytes
LC371:	bcc +				;If PPU string not full, branch to get more data.
LC373:	ldx PPUStrIndex			;

EndPPUString:
LC376:	lda #$00			;If PPU string is already full, or all PPU bytes loaded,-->
LC378:	sta PPUDataString,x		;add #$00 as last byte to the PPU byte string.
LC37B:	pla				;
LC37C:	pla				;Remove last return address from stack and jump out of-->
LC37D:*	rts				;PPU writing routines.

;The following routine is only used by the intro routine to load the sprite 
;palette data for the twinkling stars. The following memory addresses are used:
;$00-$01 Destination address for PPU write, $02-$03 Source address for PPU data,
;$04 Temp storage for PPU data byte, $05 PPU data string counter byte,
;$06 Temp storage for index byte.

PrepPPUPaletteString:
LC37E:	ldy #$01			;
LC380:	sty PPUDataPending		;Indicate data waiting to be written to PPU.
LC382:	dey				;
LC383:	beq ++++			;Branch always

LC385:*	sta $04				;$04 now contains next data byte to be put into the PPU string.
LC387:	lda $01				;High byte of staring address to write PPU data 
LC389:	jsr WritePPUByte		;($C36B)Put data byte into PPUDataString.
LC38c:	lda $00				;Low byte of starting address to write PPU data.
LC38E:	jsr WritePPUByte		;($C36B)Put data byte into PPUDataString.
LC391:	lda $04				;A now contains next data byte to be put into the PPU string.
LC393:	jsr SeparateControlBits		;($C3C6)Break control byte into two bytes.

LC396:	bit $04				;Check to see if RLE bit is set in control byte.-->
LC398:	bvc WritePaletteStringByte	;If not set, branch to load byte. Else increment index-->
LC39A:	iny				;to find repeating data byte.

WritePaletteStringByte:
LC39B:	bit $04				;Check if RLE bit is set (again). if set, load same-->
LC39D:	bvs +				;byte over and over again until counter = #$00.
LC39F:	iny				;Non-repeating data byte. Increment for next byte.
LC3A0:*	lda ($02),y			;
LC3A2:	jsr WritePPUByte		;($C36B)Put data byte into PPUDataString.
LC3A5:	sty $06				;Temporarily store data index.
LC3A7:	ldy #$01			;PPU address increment = 1.
LC3A9:	bit $04				;If MSB set in control bit, it looks like this routine might-->
LC3AB:	bpl +				;have been used for a software control verticle mirror, but
					;the starting address has already been written to the PPU-->
					;string so this section has no effect whether the MSB is set-->
					;or not. The PPU is always incremented by 1.
LC3AD:	ldy #$20			;PPU address increment = 32.
LC3AF:*	jsr AddYToPtr00			;($C2A8)Set next PPU write address.(Does nothing, already set).
LC3B2:	ldy $06				;Restore data index to Y.
LC3B4:	dec $05				;Decrement counter byte.
LC3B6:	bne WritePaletteStringByte	;If more bytes to write, branch to write another byte.
LC3B8:	stx PPUStrIndex			;Store total length, in bytes, of PPUDataString.
LC3BB:	iny				;Move to next data byte(should be #$00).

LC3BC:*	ldx PPUStrIndex			;X now contains current length of PPU data string.
LC3BF:	lda ($02),y			;
LC3C1:	bne ----			;Is PPU string done loading (#$00)? If so exit,-->
LC3C3:	jsr EndPPUString		;($C376)else branch to process PPU byte.

SeparateControlBits:
LC3C6:	sta $04				;Store current byte 
LC3C8:	and #$BF			;
LC3CA:	sta PPUDataString,x		;Remove RLE bit and save control bit in PPUDataString.
LC3CD:	and #$3F			;
LC3CF:	sta $05				;Extract counter bits and save them for use above.
LC3D1:	jmp NextPPUByte			;($C36E)

;----------------------------------------[ Math routines ]-------------------------------------------

TwosCompliment:
LC3D4:	eor #$FF			;
LC3D6:	clc				;Generate twos compliment of value stored in A.
LC3D7:	adc #$01			;
LC3D9:	rts				;

;The following two routines add a Binary coded decimal (BCD) number to another BCD number.
;A base number is stored in $03 and the number in A is added/subtracted from $03.  $01 and $02 
;contain the lower and upper digits of the value in A respectively.  If an overflow happens after
;the addition/subtraction, the carry bit is set before the routine returns.

Base10Add:
LC3DA:	jsr ExtractNibbles		;($C41D)Separate upper 4 bits and lower 4 bits.
LC3DD:	adc $01				;Add lower nibble to number.
LC3DF:	cmp #$0A			;
LC3E1:	bcc +				;If result is greater than 9, add 5 to create-->
LC3E3:	adc #$05			;valid result(skip #$0A thru #$0F).
LC3E5:*	clc				;
LC3E6:	adc $02				;Add upper nibble to number.
LC3E8:	sta $02				;
LC3EA:	lda $03				;
LC3EC:	and #$F0			;Keep upper 4 bits of HealthLo/HealthHi in A.
LC3EE:	adc $02				;
LC3F0:	bcc ++				;
LC3F2:*	adc #$5F			;If upper result caused a carry, add #$5F to create-->
LC3F4:	sec				;valid result. Set carry indicating carry to next digit.
LC3F5:	rts				;
LC3F6:*	cmp #$A0			;If result of upper nibble add is greater than #$90,-->
LC3F8:	bcs --				;Branch to add #$5F to create valid result.
LC3FA:	rts				;

Base10Subtract:
LC3FB:	jsr ExtractNibbles		;($C41D)Separate upper 4 bits and lower 4 bits.
LC3FE:	sbc $01				;Subtract lower nibble from number.
LC400:	sta $01				;
LC402:	bcs +				;If result is less than zero, add 10 to create-->
LC404:	adc #$0A			;valid result.
LC406:	sta $01				;
LC408:	lda $02				;
LC40A:	adc #$0F			;Adjust $02 to account for borrowing.
LC40C:	sta $02				;
LC40E:*	lda $03				;Keep upper 4 bits of HealthLo/HealthHi in A.
LC410:	and #$F0			;
LC412:	sec				;
LC413:	sbc $02				;If result is greater than zero, branch to finish.
LC415:	bcs +				;
LC417:	adc #$A0			;Add 10 to create valid result.
LC419:	clc				;
LC41A:*	ora $01				;Combine A and $01 to create final value.
LC41C:	rts				;

ExtractNibbles:
LC41D:	pha				;
LC41E:	and #$0F			;Lower 4 bits of value to change HealthLo/HealthHi by.
LC420:	sta $01				;
LC422:	pla				;
LC423:	and #$F0			;Upper 4 bits of value to change HealthLo/HealthHi by.
LC425:	sta $02				;
LC427:	lda $03				;
LC429:	and #$0F			;Keep lower 4 bits of HealthLo/HealthHi in A.
LC42B:	rts				;

;---------------------------[ NMI and PPU control routines ]--------------------------------

; Wait for the NMI to end.

WaitNMIPass:    
LC42C:	jsr ClearNMIStat		;($C434)Indicate currently in NMI.
LC42F:*	lda NMIStatus			;
LC431:	beq -				;Wait for NMI to end.
LC433:	rts				;

ClearNMIStat:
LC434:	lda #$00			;Clear NMI byte to indicate the game is-->
LC436:	sta NMIStatus			;currently running NMI routines.
LC438:	rts				;

ScreenOff:
LC439:	lda PPUCNT1ZP			;
LC43B:	and #$E7			; BG & SPR visibility = off

WriteAndWait:
LC43D:*	sta PPUCNT1ZP			;Update value to be loaded into PPU control register.

WaitNMIPass_:
LC43F:	jsr ClearNMIStat		;($C434)Indicate currently in NMI.
LC442:*	lda NMIStatus			;
LC444:	beq -				;Wait for NMI to end before continuing.
LC446:	rts				;

ScreenOn:
LC447:	lda PPUCNT1ZP			;
LC449:	ora #$1E			;BG & SPR visibility = on
LC44B:	bne --				;Branch always

;Update the actual PPU control registers.

WritePPUCtrl:
LC44D:	lda PPUCNT0ZP			;
LC44F:	sta PPUControl0			;
LC452:	lda PPUCNT1ZP			;Update PPU control registers.
LC454:	sta PPUControl1			;
LC457:	lda MirrorCntrl			;
LC459:	jsr PrepPPUMirror		;($C4D9)Setup vertical or horizontal mirroring.

ExitSub:
LC45C:	rts				;Exit subroutines.

;Turn off both screen and NMI.

ScreenNmiOff:
LC45D:	lda PPUCNT1ZP			;
LC45F:	and #$E7			;BG & SPR visibility = off
LC461:	jsr WriteAndWait		;($C43D)Wait for end of NMI.
LC464:	lda PPUCNT0ZP			;Prepare to turn off NMI in PPU.
LC466:	and #$7F			;NMI = off
LC468:	sta PPUCNT0ZP			;
LC46A:	sta PPUControl0			;Actually load PPU register with NMI off value.
LC46D:	rts				;

;The following routine does not appear to be used.

LC46E:	lda PPUCNT0ZP			;Enable VBlank.
LC470:	ora #$80			;
LC472:	sta PPUCNT0ZP			;Write PPU control register 0 and PPU status byte.
LC474:	sta PPUControl0			;
LC477:	lda PPUCNT1ZP			;Turn sprites and screen on.
LC479:	ora #$1E			;
LC47B:	bne --				;Branch always.

VBOffAndHorzWrite: 
LC47D:	lda PPUCNT0ZP			;
LC47F:	and #$7B			;Horizontal write, disable VBlank. 
LC481:*	sta PPUControl0			;Save new values in the PPU control register-->
LC484:	sta PPUCNT0ZP			;and PPU status byte.
LC486:	rts				;

NmiOn:
LC487:*	lda PPUStatus			;
LC48A:	and #$80			;Wait for end of VBlank.
LC48C:	bne -				;
LC48E:	lda PPUCNT0ZP			;
LC490:	ora #$80			;Enable VBlank interrupts.
LC492:	bne --				;Branch always.

;--------------------------------------[ Timer routines ]--------------------------------------------

;The following routines set the timer and decrement it. The timer is set after Samus dies and
;before the GAME OVER message is dispayed.  The timer is also set while the item pickup music
;is playing.

WaitTimer:
LC494:	lda Timer3			;Exit if timer hasn't hit zero yet
LC496:	bne +				;
LC498:	lda NextRoutine			;Set GameOver as next routine.
LC49A:	cmp #$04			;
LC49C:	beq SetMainRoutine		;Set GoPassword as main routine.
LC49E:	cmp #$06			;
LC4A0:	beq SetMainRoutine		;
LC4A2:	jsr StartMusic			;($D92C)Assume power up was picked up and GameEngine-->
LC4A5:	lda NextRoutine			;is next routine. Start area music before exiting.

SetMainRoutine:
LC4A7:	sta MainRoutine			;Set next routine to run.
LC4A9:*	rts				;

SetTimer:
LC4AA:	sta Timer3			;Set Timer3. Frames to wait is value stored in A*10.
LC4AC:	stx NextRoutine			;Save routine to jump to after Timer3 expires.
LC4AE:	lda #$09			;Next routine to run is WaitTimer.
LC4B0:	bne SetMainRoutine		;Branch always.

;-----------------------------------[ PPU mirroring routines ]---------------------------------------

PrepVertMirror:
LC4B2:	nop				;
LC4B3:	nop				;Prepare to set PPU for vertical mirroring (again).
LC4B4:	lda #$47			;

SetPPUMirror:
LC4B6:	lsr				;
LC4B7:	lsr				;Move bit 3 to bit 0 position.
LC4B8:	lsr				;
LC4B9:	and #$01			;Remove all other bits.
LC4BB:	sta $00				;Store at address $00.
LC4BD:	lda MMCReg0Cntrl		;
LC4BF:	and #$FE			;Load MMCReg0Cntrl and remove bit 0.
LC4C1:	ora $00				;Replace bit 0 with stored bit at $00.
LC4C3:	sta MMCReg0Cntrl		;
LC4C5:	sta MMC1Reg0			;
LC4C8:	lsr				;
LC4C9:	sta MMC1Reg0			;
LC4Cc:	lsr				;
LC4CD:	sta MMC1Reg0			;
LC4D0:	lsr				;Load new configuration data serially-->
LC4D1:	sta MMC1Reg0			;into MMC1Reg0.
LC4D4:	lsr				;
LC4D5:	sta MMC1Reg0			;
LC4D8:	rts				;

PrepPPUMirror:
LC4D9:	lda MirrorCntrl			;Load MirrorCntrl into A.
LC4DB:	jmp SetPPUMirror		;($C4B6)Set mirroring through MMC1 chip.

;-----------------------------[ Switch bank and init bank routines ]---------------------------------

;This is how the bank switching works... Every frame, the routine below
;is executed. First, it checks the value of SwitchPending. If it is zero,
;the routine will simply exit. If it is non-zero, it means that a bank
;switch has been issued, and must be performed. SwitchPending then contains
;the bank to switch to, plus one.

CheckSwitch:
LC4DE:	ldy SwitchPending		;
LC4E0:	beq +				;Exit if zero(no bank switch issued). else Y contains bank#+1.
LC4E2:	jsr SwitchOK			;($C4E8)Perform bank switch.
LC4E5:	jmp GoBankInit			;($C510)Initialize bank switch data.

SwitchOK:
LC4E8:	lda #$00			;Reset(so that the bank switch won't be performed-->
LC4EA:	sta SwitchPending		;every succeeding frame too).
LC4EC:	dey				;Y now contains the bank to switch to.
LC4ED:	sty CurrentBank			;

ROMSwitch:
LC4EF:	tya				;
LC4F0:	sta $00				;Bank to switch to is stored at location $00.
LC4F2:	lda SwitchUpperBits		;Load upper two bits for Reg 3 (they should always be 0).
LC4F4:	and #$18			;Extract bits 3 and 4 and add them to the current-->
LC4F6:	ora $00				;bank to switch to.
LC4F8:	sta SwitchUpperBits		;Store any new bits set in 3 or 4(there should be none).

;Loads the lower memory page with the bank specified in A.

MMCWriteReg3:
LC4FA:	sta MMC1Reg3			;Write bit 0 of ROM bank #.
LC4FD:	lsr				;
LC4FE:	sta MMC1Reg3			;Write bit 1 of ROM bank #.
LC501:	lsr				;
LC502:	sta MMC1Reg3			;Write bit 2 of ROM bank #.
LC505:	lsr				;
LC506:	sta MMC1Reg3			;Write bit 3 of ROM bank #.
LC509:	lsr				;
LC50A:	sta MMC1Reg3			;Write bit 4 of ROM bank #.
LC50D:	lda $00				;Restore A with current bank number before exiting.
LC50F:*	rts				;

;Calls the proper routine according to the bank number in A.

GoBankInit:
LC510:	asl				;*2 For proper table offset below.
LC511:	tay				;
LC512:	lda BankInitTable,y		;
LC515:	sta $0A				;Load appropriate subroutine address into $0A and $0B.
LC517:	lda BankInitTable+1,y		;
LC51A:	sta $0B				;
LC51C:	jmp ($000A)			;Jump to appropriate initialization routine.

BankInitTable:
LC51F:	.word InitBank0			;($C531)Initialize bank 0.
LC521:	.word InitBank1			;($C552)Initialize bank 1.
LC523:	.word InitBank2			;($C583)Initialize bank 2.
LC525:	.word InitBank3			;($C590)Initialize bank 3.
LC527:	.word InitBank4			;($C5B6)Initialize bank 4.
LC529:	.word InitBank5			;($C5C3)Initialize bank 5.
LC52B:	.word ExitSub			;($C45C)Rts
LC52D:	.word ExitSub			;($C45C)Rts
LC52F:	.word ExitSub			;($C45C)Rts

;Title screen memory page.

InitBank0:
LC531:	ldy #$00			;
LC533:	sty GamePaused			;Ensure game is not paused.
LC535:	iny				;Y=1.
LC536:	sty GameMode			;Game is at title routines.
LC538:	jsr ScreenNmiOff		;($C45D)Waits for NMI to end then turns it off.
LC53B:	jsr CopyMap			;($A93E)Copy game map from ROM to cartridge RAM $7000-$73FF
LC53E:	jsr ClearNameTables		;($C158)Erase name table data.

LC541:	ldy #$A0			;
LC543:*	lda $98BF,y			;
LC546:	sta $6DFF,y			;Loads sprite info for stars into RAM $6E00 thru 6E9F.
LC549:	dey				;
LC54A:	bne -				;

LC54C:	jsr InitTitleGFX		;($C5D7)Load title GFX.
LC54F:	jmp NmiOn			;($C487)Turn on VBlank interrupts.

;Brinstar memory page.

InitBank1:
LC552:	lda #$00			;
LC554:	sta GameMode			;GameMode = play.
LC556:	jsr ScreenNmiOff		;($C45D)Disable screen and Vblank.
LC559:	lda MainRoutine			;
LC55B:	cmp #$03			;Is game engine running? if so, branch.-->
LC55D:	beq +				;Else do some housekeeping first.
LC55F:	lda #$00			;
LC561:	sta MainRoutine			;Run InitArea routine next.
LC563:	sta InArea			;Start in Brinstar.
LC565:	sta GamePaused			;Make sure game is not paused.
LC567:	jsr ClearRAM_33_DF		;($C1D4)Clear game engine memory addresses.
LC56A:	jsr ClearSamusStats		;($C578)Clear Samus' stats memory addresses.
LC56D:*	ldy #$00			;
LC56F:	jsr ROMSwitch			;($C4EF)Load Brinstar memory page into lower 16Kb memory.
LC572:	jsr InitBrinstarGFX		;($C604)Load Brinstar GFX.
LC575:	jmp NmiOn			;($C487)Turn on VBlank interrupts.

ClearSamusStats:
LC578:	ldy #$0F			;
LC57A:	lda #$00			;Clears Samus stats(Health, full tanks, game timer, etc.).
LC57C:*	sta $0100,y			;Load $100 thru $10F with #$00.
LC57F:	dey				;
LC580:	bpl -				;Loop 16 times.
LC582:	rts				;

;Norfair memory page.

InitBank2:
LC583:	lda #$00			;GameMode = play.
LC585:	sta GameMode			;
LC587:	jsr ScreenNmiOff		;($C45D)Disable screen and Vblank.
LC58A:	jsr InitNorfairGFX		;($C622)Load Norfair GFX.
LC58D:	jmp NmiOn			;($C487)Turn on VBlank interrupts.

;Tourian memory page.

InitBank3:
LC590:	lda #$00			;GameMode = play.
LC592:	sta GameMode			;
LC594:	jsr ScreenNmiOff		;($C45D)Disable screen and Vblank.
LC597:	ldy #$0D			;
LC599:*	lda MetroidData,y		;Load info from table below into-->
LC59C:	sta $77F0,y			;$77F0 thru $77FD.
LC59F:	dey				;
LC5A0:	bpl -				;
LC5A2:	jsr InitTourianGFX		;($C645)Load Tourian GFX.
LC5A5:	jmp NmiOn			;($C487)Turn on VBlank interrupts.

;Table used by above subroutine and loads the initial data used to describe
;metroid's behavior in the Tourian section of the game.

MetroidData:
LC5A8:	.byte $F8, $08, $30, $D0, $60, $A0, $02, $04, $00, $00, $00, $00, $00, $00

;Kraid memory page.

InitBank4:
LC5B6:	lda #$00			;GameMode = play.
LC5B8:	sta GameMode			;
LC5BA:	jsr ScreenNmiOff		;($C45D)Disable screen and Vblank.
LC5BD:	jsr InitKraidGFX		;($C677)Load Kraid GFX.
LC5C0:	jmp NmiOn			;($C487)Turn on VBlank interrupts.

;Ridley memory page.

InitBank5:
LC5C3:	lda #$00			;GameMode = play.
LC5C5:	sta GameMode			;
LC5C7:	jsr ScreenNmiOff		;($C45D)Disable screen and Vblank.
LC5CA:	jsr InitRidleyGFX		;($C69F)Loag Ridley GFX.
LC5CD:	jmp NmiOn			;($C487)Turn on VBlank interrupts.

InitEndGFX:
LC5D0:	lda #$01			;
LC5D2:	sta GameMode			;Game is at title/end game.
LC5D4:	jmp InitGFX6			;($C6C2)Load end game GFX.

InitTitleGFX:
LC5D7:	ldy #$15			;Entry 21 in GFXInfo table.
LC5D9:	jsr LoadGFX			;($C7AB)Load pattern table GFX.

LoadSamusGFX:
LC5DC:	ldy #$00			;Entry 0 in GFXInfo table.
LC5DE:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC5E1:	lda JustInBailey		;
LC5E4:	beq +				;Branch if wearing suit
LC5E6:	ldy #$1B			;Entry 27 in GFXInfo table.
LC5E8:	jsr LoadGFX			;($C7AB)Switch to girl gfx
LC5EB:*	ldy #$14			;Entry 20 in GFXInfo table.
LC5ED:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC5F0:	ldy #$17			;Entry 23 in GFXInfo table.
LC5F2:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC5F5:	ldy #$18			;Entry 24 in GFXInfo table.
LC5F7:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC5FA:	ldy #$19			;Entry 25 in GFXInfo table.
LC5FC:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC5FF:	ldy #$16			;Entry 22 in GFXInfo table.
LC601:	jmp LoadGFX			;($C7AB)Load pattern table GFX.

InitBrinstarGFX:
LC604:	ldy #$03			;Entry 3 in GFXInfo table.
LC606:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
Lc609:	ldy #$04			;Entry 4 in GFXInfo table.
LC60B:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC60E:	ldy #$05			;Entry 5 in GFXInfo table.
LC610:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC613:	ldy #$06			;Entry 6 in GFXInfo table.
LC615:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC618:	ldy #$19			;Entry 25 in GFXInfo table.
LC61A:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC61D:	ldy #$16			;Entry 22 in GFXInfo table.
LC61F:	jmp LoadGFX			;($C7AB)Load pattern table GFX.

InitNorfairGFX:
LC622:	ldy #$04			;Entry 4 in GFXInfo table.
LC624:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC627:	ldy #$05			;Entry 5 in GFXInfo table.
LC629:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC62C:	ldy #$07			;Entry 7 in GFXInfo table.
LC62E:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC631:	ldy #$08			;Entry 8 in GFXInfo table.
LC633:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC636:	ldy #$09			;Entry 9 in GFXInfo table.
LC638:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC63B:	ldy #$19			;Entry 25 in GFXInfo table.
LC63D:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC640:	ldy #$16			;Entry 22 in GFXInfo table.
LC642:	jmp LoadGFX			;($C7AB)Load pattern table GFX.

InitTourianGFX:
LC645:	ldy #$05			;Entry 5 in GFXInfo table.
LC647:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC64A:	ldy #$0A			;Entry 10 in GFXInfo table.
LC64C:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC64F:	ldy #$0B			;Entry 11 in GFXInfo table.
LC651:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC654:	ldy #$0C			;Entry 12 in GFXInfo table.
LC656:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC659:	ldy #$0D			;Entry 13 in GFXInfo table.
LC65B:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC65E:	ldy #$0E			;Entry 14 in GFXInfo table.
LC660:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC663:	ldy #$1A			;Entry 26 in GFXInfo table.
LC665:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC668:	ldy #$1C			;Entry 28 in GFXInfo table.
LC66A:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC66D:	ldy #$19			;Entry 25 in GFXInfo table.
LC66F:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC672:	ldy #$16			;Entry 22 in GFXInfo table.
LC674:	jmp LoadGFX			;($C7AB)Load pattern table GFX.

InitKraidGFX:
LC677:	ldy #$04			;Entry 4 in GFXInfo table.
LC679:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC67C:	ldy #$05			;Entry 5 in GFXInfo table.
LC67E:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC681:	ldy #$0A			;Entry 10 in GFXInfo table.
LC683:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC686:	ldy #$0F			;Entry 15 in GFXInfo table.
LC688:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC68B:	ldy #$10			;Entry 16 in GFXInfo table.
LC68D:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC690:	ldy #$11			;Entry 17 in GFXInfo table.
LC692:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC695:	ldy #$19			;Entry 25 in GFXInfo table.
LC697:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC69A:	ldy #$16			;Entry 22 in GFXInfo table.
LC69C:	jmp LoadGFX			;($C7AB)Load pattern table GFX.

InitRidleyGFX:
LC69F:	ldy #$04			;Entry 4 in GFXInfo table.
LC6A1:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC6A4:	ldy #$05			;Entry 5 in GFXInfo table.
LC6A6:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC6A9:	ldy #$0A			;Entry 10 in GFXInfo table.
LC6AB:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC6AE:	ldy #$12			;Entry 18 in GFXInfo table.
LC6B0:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC6B3:	ldy #$13			;Entry 19 in GFXInfo table.
LC6B5:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC6B8:	ldy #$19			;Entry 25 in GFXInfo table.
LC6BA:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC6BD:	ldy #$16			;Entry 22 in GFXInfo table.
LC6BF:	jmp LoadGFX			;($C7AB)Load pattern table GFX.

InitGFX6:
LC6C2:	ldy #$01			;Entry 1 in GFXInfo table.
LC6C4:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC6C7:	ldy #$02			;Entry 2 in GFXInfo table.
LC6C9:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC6CC:	ldy #$19			;Entry 25 in GFXInfo table.
LC6CE:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC6D1:	ldy #$16			;Entry 22 in GFXInfo table.
LC6D3:	jmp LoadGFX			;($C7AB)Load pattern table GFX.

InitGFX7:
LC6D6:	ldy #$17			;Entry 23 in GFXInfo table.
LC6D8:	jsr LoadGFX			;($C7AB)Load pattern table GFX.
LC6DB:	ldy #$16			;Entry 22 in GFXInfo table.
LC6DD:	jmp LoadGFX			;($C7AB)Load pattern table GFX.

;The table below contains info for each tile data block in the ROM.
;Each entry is 7 bytes long. The format is as follows:
;byte 0: ROM bank where GFX data is located.
;byte 1-2: 16-bit ROM start address (src).
;byte 3-4: 16-bit PPU start address (dest).
;byte 5-6: data length (16-bit).

GFXInfo:
LC6E0:	.byte $06			;[SPR]Samus, items.		Entry 0.
LC6E1:	.word $8000, $0000, $09A0
LC6E7:	.byte $04			;[SPR]Samus in ending.		Entry 1.
LC6E8:	.word $8D60, $0000, $0520
LC6EE:	.byte $01			;[BGR]Partial font, "The End".	Entry 2.
LC6EF:	.word $8D60, $1000, $0400
LC6F5:	.byte $06			;[BGR]Brinstar rooms.		Entry 3.
LC6F6:	.word $9DA0, $1000, $0150
LC6FC:	.byte $05			;[BGR]Misc. objects.		Entry 4.
LC6FD:	.word $8D60, $1200, $0450
LC703:	.byte $06			;[BGR]More Brinstar rooms.	Entry 5.
LC704:	.word $9EF0, $1800, $0800
LC70A:	.byte $01			;[SPR]Brinstar enemies.		Entry 6.
LC70B:	.word $9160, $0C00, $0400
LC711:	.byte $06			;[BGR]Norfair rooms.		Entry 7.
LC712:	.word $A6F0, $1000, $0260
LC718:	.byte $06			;[BGR]More Norfair rooms.	Entry 8.
LC719:	.word $A950, $1700, $0070
LC71F:	.byte $02			;[SPR]Norfair enemies.		Entry 9.
LC720:	.word $8D60, $0C00, $0400
LC726:	.byte $06			;[BGR]Tourian rooms.		Entry 10.
LC727:	.word $A9C0, $1000, $02E0
LC72D:	.byte $06			;[BGR]More Tourian rooms.	Entry 11.
LC72E:	.word $ACA0, $1200, $0600
LC734:	.byte $06			;[BGR]Mother Brain room.	Entry 12.
LC735:	.word $B2A0, $1900, $0090
LC73B:	.byte $05			;[BGR]Misc. object.		Entry 13.
LC73C:	.word $91B0, $1D00, $0300
LC742:	.byte $02			;[SPR]Tourian enemies.		Entry 14.
LC743:	.word $9160, $0C00, $0400
LC749:	.byte $06			;[BGR]More Tourian rooms.	Entry 15.
LC74A:	.word $B330, $1700, $00C0
LC750:	.byte $04			;[BGR]Misc. object and fonts.	Entry 16.
LC751:	.word $9360, $1E00, $0200
LC757:	.byte $03			;[SPR]Miniboss I enemies.	Entry 17.
LC758:	.word $8D60, $0C00, $0400
LC75E:	.byte $06			;[BGR]More Tourian Rooms.	Entry 18.
LC75F:	.word $B3F0, $1700, $00C0
LC765:	.byte $03			;[SPR]Miniboss II enemies.	Entry 19.
LC766:	.word $9160, $0C00, $0400
LC76C:	.byte $06			;[SPR]Inrto/End sprites.	Entry 20.
LC76D:	.word $89A0, $0C00, $0100
LC773:	.byte $06			;[BGR]Title.			Entry 21.
LC774:	.word $8BE0, $1400, $0500
LC77A:	.byte $06			;[BGR]Solid tiles.		Entry 22.
LC77B:	.word $9980, $1FC0, $0040
LC781:	.byte $06			;[BGR]Complete font.		Entry 23.
LC782:	.word $B4C0, $1000, $0400
LC788:	.byte $06			;[BGR]Complete font.		Entry 24.
LC789:	.word $B4C0, $0A00, $00A0
LC78F:	.byte $06			;[BGR]Solid tiles.		Entry 25.
LC790:	.word $9980, $0FC0, $0040
LC796:	.byte $06			;[BGR]Complete font.		Entry 26.
LC797:	.word $B4C0, $1D00, $02A0
LC79D:	.byte $06			;[SPR]Suitless Samus.		Entry 27.
LC79E:	.word $90E0, $0000, $07B0
LC7A4:	.byte $06			;[BGR]Exclaimation point.	Entry 28.
LC7A5:	.word $9890, $1F40, $0010

;--------------------------------[ Pattern table loading routines ]---------------------------------

;Y contains the GFX header to fetch from the table above, GFXInfo.

LoadGFX:
LC7AB:	lda #$FF			;
LC7AD:*	clc				;Every time y decrements, the entry into the table-->
LC7AE:	adc #$07			;is increased by 7.  When y is less than 0, A points-->
LC7B0:	dey				;to the last byte of the entry in the table.
LC7B1:	bpl -				;
LC7B3:	tay				;Transfer offset into table to Y.

LC7B4:	ldx #$06			;
LC7B6:*	lda GFXInfo,y			;
LC7B9:	sta $00,x			;Copy entries from GFXInfo to $00-$06.
LC7BB:	dey				;
LC7BC:	dex				;
LC7BD:	bpl -				;

LC7BF:	ldy $00				;ROM bank containing the GFX data.
LC7C1:	jsr ROMSwitch			;($C4EF)Switch to that bank.
LC7C4:	lda PPUCNT0ZP			;
LC7C6:	and #$FB			;
LC7C8:	sta PPUCNT0ZP			;Set the PPU to increment by 1.
LC7CA:	sta PPUControl0			;
LC7CD:	jsr CopyGFXBlock		;($C7D5)Copy graphics into pattern tables.
LC7D0:	ldy CurrentBank			;
LC7D2:	jmp ROMSwitch			;($C4FE)Switch back to the "old" bank.

;Writes tile data from ROM to VRAM, according to the gfx header data
;contained in $00-$06.

CopyGFXBlock:
LC7D5:	lda $05				;
LC7D7:	bne GFXCopyLoop			;If $05 is #$00, decrement $06 before beginning.
LC7D9:	dec $06				;

GFXCopyLoop:
LC7DB:	lda $04				;
LC7DD:	sta PPUAddress			;Set PPU to proper address for GFX block write.
LC7E0:	lda $03				;
LC7E2:	sta PPUAddress			;
LC7E5:	ldy #$00			;Set offset for GFX data to 0.
LC7E7:*	lda ($01),y			;
LC7E9:	sta PPUIOReg			;Copy GFX data byte from ROM to Pattern table.
LC7EC:	dec $05				;Decrement low byte of data length.
LC7EE:	bne +				;Branch if high byte does not need decrementing.
LC7F0:	lda $06				;
LC7F2:	beq ++				;If copying complete, branch to exit.
LC7F4:	dec $06				;Decrement when low byte has reached 0.
LC7F6:*	iny				;Increment to next byte to copy.
LC7F7:	bne --				;
LC7F9:	inc $02				;After 256 bytes loaded, increment upper bits of-->
LC7FB:	inc $04				;Source and destination addresses.
LC7FD:	jmp GFXCopyLoop			;(&C7DB)Repeat copy routine.
LC800:*	rts				;

;-------------------------------------------[ AreaInit ]---------------------------------------------

AreaInit:
LC801:	lda #$00			;
LC803:	sta ScrollX     		;Clear ScrollX.
LC805:	sta ScrollY     		;Clear ScrollY.
LC807:	lda PPUCNT0ZP			;	
LC809:	and #$FC			;Sets nametable address = $2000.
LC80B:	sta PPUCNT0ZP			;
LC80D:	inc MainRoutine			;Increment MainRoutine to MoreInit.
LC80F:	lda Joy1Status			;
LC811:	and #$C0			;Stores status of both the A and B buttons.
LC813:	sta ABStatus	 		;Appears to never be accessed.
LC815:	jsr EraseAllSprites		;($C1A3)Clear all sprite info.
LC818:	lda #$10			;Prepare to load Brinstar memory page.
LC81A:	jsr IsEngineRunning		;($CA18)Check to see if ok to switch lower memory page.

;------------------------------------------[ MoreInit ]---------------------------------------------

MoreInit:
LC81D:	ldy #$01			;
LC81F:	sty PalDataPending		;Palette data pending = yes.
LC821:	ldx #$FF			;
LC823:	stx SpareMem75			;$75 Not referenced ever again in the game.
LC825:	inx				;X=0.
LC826:	stx AtEnding			;Not playing ending scenes.
LC829:	stx DoorStatus			;Samus not in door.
LC82B:	stx SamusDoorData		;Samus is not inside a door.
LC82D:	stx UpdatingProjectile		;No projectiles need to be updated.
LC82F:	txa				;A=0.

LC830:*	cpx #$65			;Check to see if more RAM to clear in $7A thru $DE.
LC832:	bcs +				;
LC834:	sta $7A,x			;Clear RAM $7A thru $DE.
LC836:*	cpx #$FF			;Check to see if more RAM to clear in $300 thru $3FE.
LC838:	bcs +				;
LC83A:	sta ObjAction,x			;Clear RAM $300 thru $3FE.
LC83D:*	inx				;
LC83E:	bne ---				;Loop until all required RAM is cleared.

LC840:	jsr ScreenOff			;($C439)Turn off Background and visibility.
LC843:	jsr ClearNameTables		;($C158)Clear screen data.
LC846:	jsr EraseAllSprites		;($C1A3)Erase all sprites from sprite RAM.
LC849:	jsr DestroyEnemies		;($C8BB)

	stx DoorOnNameTable3		;Clear data about doors on the name tables.
	stx DoorOnNameTable0		;
	inx				;X=1.
	stx SpareMem30			;Not accessed by game.
	inx				;X=2.
LC854:	stx ScrollDir			;Set initial scroll direction as left.

	lda $95D7			;Get Samus start x pos on map.
	sta MapPosX			;
	lda $95D8			;Get Samus start y pos on map.
	sta MapPosY			;

LC860:	lda $95DA       ; Get ??? Something to do with palette switch
	sta PalToggle
	lda #$FF
	sta RoomNumber			;Room number = $FF(undefined room).
LC869:	jsr CopyPtrs    ; copy pointers from ROM to RAM 
LC86C:	jsr GetRoomNum			;($E720)Put room number at current map pos in $5A.
*       jsr SetupRoom			;($EA2B)
	ldy RoomNumber  ; load room number
	iny
	bne -

	ldy CartRAMPtr+1
	sty $01
	ldy CartRAMPtr
	sty $00
	lda PPUCNT0ZP
	and #$FB	; PPU increment = 1
	sta PPUCNT0ZP
	sta PPUControl0
	ldy PPUStatus   ; reset PPU addr flip/flop

; Copy room RAM #0 ($6000) to PPU Name Table #0 ($2000)

	ldy #$20
	sty PPUAddress
	ldy #$00
	sty PPUAddress
	ldx #$04	; prepare to write 4 pages
*       lda ($00),y
	sta PPUIOReg
	iny
	bne -
	inc $01
	dex
	bne -

	stx $91
	inx	     ; X = 1
	stx PalDataPending
	stx SpareMem30			;Not accessed by game.
	inc MainRoutine			;SamusInit is next routine to run.
	jmp ScreenOn

; CopyPtrs
; ========
; Copy 7 16-bit pointers from $959A thru $95A7 to $3B thru $48.

CopyPtrs:
	ldx #$0D
*       lda AreaPointers+2,x
	sta RoomPtrTable,x
	dex
	bpl -
	rts

; DestroyEnemies
; ==============

DestroyEnemies:
LC8BB:	lda #$00
	tax
*       cpx #$48
	bcs +
	sta $97,x
*       sta EnStatus,x
	pha
	pla
	inx
	bne --
	stx MetroidOnSamus		;Samus had no Metroid stuck to her.
	jmp $95AB

; SamusInit
; =========
; Code that sets up Samus, when the game is first started.

SamusInit:
LC8D1:	lda #$08			;
LC8D3:  sta MainRoutine			;SamusIntro will be executed next frame.
LC8D5:	lda #$2C			;440 frames to fade in Samus(7.3 seconds).
LC8D7:	sta Timer3			;
LC8D9:	jsr IntroMusic			;($CBFD)Start the intro music.
LC8DC:	ldy #sa_FadeIn0			;
	sty ObjAction			;Set Samus status as fading onto screen.
	ldx #$00
	stx SamusBlink
	dex				;X = $FF
	stx $0728
	stx $0730
	stx $0732
	stx $0738
	stx EndTimerLo			;Set end timer bytes to #$FF as-->
	stx EndTimerHi			;escape timer not currently active.
	stx $8B
	stx $8E
	ldy #$27
	lda InArea
	and #$0F
	beq +				;Branch if Samus starting in Brinstar.
	lsr ScrollDir			;If not in Brinstar, change scroll direction from left-->
	ldy #$2F			;to down. and set PPU for horizontal mirroring.
*       sty MirrorCntrl			;
	sty MaxMissilePickup
	sty MaxEnergyPickup
	lda $95D9			;Samus' initial vertical position
	sta ObjectY			;
	lda #$80			;Samus' initial horizontal position
	sta ObjectX			;
	lda PPUCNT0ZP			;
	and #$01			;Set Samus' name table position to current name table-->
	sta ObjectHi			;active in PPU.
	lda #$00			;
	sta HealthLo			;Starting health is-->
	lda #$03			;set to 30 units.
	sta HealthHi			;
*       rts				;

;------------------------------------[ Main game engine ]--------------------------------------------

GameEngine:
LC92B:	jsr ScrollDoor			;($E1F1)Scroll doors, if needed. 2 routine calls scrolls-->
LC92E:	jsr ScrollDoor			;($E1F1)twice as fast as 1 routine call.

LC931:	lda NARPASSWORD			;
LC934:	beq +				;
LC936:	lda #$03			;The following code is only accessed if -->
LC938:	sta HealthHi			;NARPASSWORD has been entered at the -->
LC93B:	lda #$FF			;password screen. Gives you new health,-->
LC93D:	sta SamusGear			;missiles and every power-up every frame.
LC940:	lda #$05			;
LC942:	sta MissileCount		;

LC945:*	jsr UpdateWorld			;($CB29)Update Samus, enemies and room tiles.
LC948:	lda MiniBossKillDelay		;
LC94B:	ora PowerUpDelay		;Check if mini boss was just killed or powerup aquired.-->
LC94E:	beq +				;If not, branch.

LC950:	lda #$00			;
LC952:	sta MiniBossKillDelay		;Reset delay indicators.
LC955:	sta PowerUpDelay		;
LC958:	lda #$18			;Set timer for 240 frames(4 seconds).
LC95A:	ldx #$03			;GameEngine routine to run after delay expires
LC95C:	jsr SetTimer			;($C4AA)Set delay timer and game engine routine.

LC95F:*	lda ObjAction			;Check is Samus is dead.
LC962:	cmp #sa_Dead2   		;Is Samus dead?-->
LC964:	bne ---	   			;exit if not.
LC966:	lda AnimDelay			;Is Samus still exploding?-->
LC969:	bne ---				;Exit if still exploding.
LC96B:	jsr SilenceMusic		;Turn off music.
LC96E:	lda MotherBrainStatus		;
LC970:	cmp #$0A			;Is mother brain already dead? If so, branch.
LC972:	beq +				;
LC974:	lda #$04			;Set timer for 40 frames (.667 seconds).
LC976:	ldx #$04			;GameOver routine to run after delay expires.
LC978:	jmp SetTimer			;($C4AA)Set delay timer and run game over routine.

LC97B:*	inc MainRoutine			;Next routine to run is GameOver.
LC97D:	rts				;

;----------------------------------------[ Update age ]----------------------------------------------

;This is the routine which keeps track of Samus' age. It is called in the
;NMI. Basically, this routine just increments a 24-bit variable every
;256th frame. (Except it's not really 24-bit, because the lowest age byte
;overflows at $D0.)

UpdateAge:
LC97E:	lda GameMode			;
LC980:	bne ++				;Exit if at title/password screen.
LC982:	lda MainRoutine			;
LC984:	cmp #$03			;Is game engine running?
LC986:	bne ++				;If not, don't update age.
LC988:	ldx FrameCount			;Only update age when FrameCount is zero-->
LC98A:	bne ++				;(which is approx. every 4.266666666667 seconds).
LC98C:	inc SamusAge,x			;Minor Age = Minor Age + 1.
LC98F:	lda SamusAge			;
LC992:	cmp #$D0			;Has Minor Age reached $D0?-->
LC994:	bcc ++				;If not, we're done.-->
LC996:	lda #$00			;Else reset minor age.
LC998:	sta SamusAge			;
LC99B:*	cpx #$03			;
LC99D:	bcs +				;Loop to update middle age and possibly major age.
LC99F:	inx				;
LC9A0:	inc SamusAge,x			;
LC9A3:	beq -	   			;Branch if middle age overflowed, need to increment--> 
LC9A5:*	rts				;major age too. Else exit.

;-------------------------------------------[ Game over ]--------------------------------------------

GameOver:
LC9A6:	lda #$1C			;GameOver is the next routine to run.
LC9A8:	sta TitleRoutine		;
LC9AA:	lda #$01			;
LC9AC:	sta SwitchPending		;Prepare to switch to title memory page.
LC9AE:	jmp ScreenOff			;($C439)Turn screen off.

;------------------------------------------[ Pause mode ]--------------------------------------------

PauseMode:
LC9B1:	lda Joy2Status			;Load buttons currently being pressed on joypad 2.
LC9B3:	and #$88			;
LC9B5:	eor #$88			;both A & UP pressed?-->
LC9B7:	bne Exit14			;Exit if not.
LC9B9:	ldy EndTimerHi			;
LC9BC:	iny				;Is escape timer active?-->
LC9BD:	bne Exit14			;Sorry, can't quit if this is during escape scence.
LC9BF:	sta GamePaused			;Clear pause game indicator.
LC9C1:	inc MainRoutine			;Display password is the next routine to run.

Exit14:
LC9C3:	rts				;Exit for routines above and below.

;------------------------------------------[ GoPassword ]--------------------------------------------

GoPassword:
LC9C4:	lda #$19			;DisplayPassword is next routine to run.
LC9C6:	sta TitleRoutine		;
LC9C8:	lda #$01			;
LC9CA:	sta SwitchPending		;Prepare to switch to intro memory page.
LC9CC:	lda NoiseSFXFlag		;
LC9CF:	ora #$01			;Silence music.
LC9D1:	sta NoiseSFXFlag		;
LC9D4:	jmp ScreenOff			;($C439)Turn off screen.

;-----------------------------------------[ Samus intro ]--------------------------------------------

SamusIntro:
LC9D7:	jsr EraseAllSprites		;($C1A3)Clear all sprites off screen.
LC9DA:	ldy ObjAction			;Load Samus' fade in status.
LC9DD:	lda Timer3			;
LC9E0:	bne +				;Branch if Intro still playing.
	
;Fade in complete.
LC9E2:	sta ItemRoomMusicStatus		;Make sure item room music is not playing.
LC9E4:	lda #sa_Begin			;Samus facing forward and can't be hurt.
LC9E6:	sta ObjAction			;
LC9E8:	jsr StartMusic			;($D92C)Start main music.
LC9EB:	jsr SelectSamusPal		;($CB73)Select proper Samus palette.
LC9EE:	lda #$03			;
LC9F0:	sta MainRoutine			;Game engine will be called next frame.

;Still fading in.
LC9F2:*	cmp #$1F			;When 310 frames left of intro, display Samus.
LC9F4:	bcs Exit14			;Branch if not time to start drawing Samus.
LC9F6:	cmp SamusFadeInTimeTbl-20,y	;sa_FadeIn0 is beginning of table.
LC9F9:	bne +				;Every time Timer3 equals one of the entries in the table-->
LC9FB:	inc ObjAction			;below, change the palette used to color Samus.
LC9FE:	sty PalDataPending		;
LCA00:*	lda FrameCount			;Is game currently on an odd frame?-->
LCA02:	lsr				;If not, branch to exit.
LCA03:	bcc Exit14			;Only display Samus on odd frames [the blink effect].
LCA05:	lda #an_SamusFront		;Samus front animation is animation to display.-->
LCA07:	jsr SetSamusAnim		;($CF6B)while fading in.
LCA0A:	lda #$00			;
LCA0C:	sta SpritePagePos		;Samus sprites start at Sprite00RAM.
LCA0E:	sta PageIndex			;Samus RAM is first set of RAM.
LCA10:	jmp AnimDrawObject		;($DE47)Draw Samus on screen.

;The following table marks the time remaining in Timer3 when a palette change should occur during
;the Samus fade-in sequence. This creates the fade-in effect.

SamusFadeInTimeTbl:
LCA13:	.byte $1E,$14,$0B,$04,$FF

;---------------------------------[ Check if game engine running ]-----------------------------------

IsEngineRunning:
LCA18:	ldy MainRoutine			;If Samus is fading in or the wait timer is-->
LCA1A:	cpy #$07			;active, return from routine.
LCA1C:	beq +				;
LCA1E:	cpy #$03			;Is game engine running?
LCA20:	beq ++				;If yes, branch to SwitchBank.
LCA22:*	rts				;Exit if can't switch bank.

;-----------------------------------------[ Switch bank ]--------------------------------------------

;Switch to appropriate area bank

SwitchBank:
LCA23:*	sta InArea			;Save current area Samus is in.
LCA25:	and #$0F			;
LCA27:	tay				;Use 4 LSB to load switch pending offset from BankTable table.
LCA28:	lda BankTable,y			;Base is $CA30.
LCA2B:	sta SwitchPending		;Store switch data.
LCA2D:	jmp CheckSwitch			;($C4DE)Switch lower 16KB to appropriate memory page.

;Table used by above subroutine.
;Each value is the area bank number plus one.

BankTable:
LCA30:	.byte $02			;Brinstar.
LCA31:	.byte $03			;Norfair.
LCA32:	.byte $05			;Kraid hideout.
LCA33:	.byte $04			;Tourian.
LCA34:	.byte $06			;Ridley hideout.

;----------------------------------[ Saved game routines (not used) ]--------------------------------

AccessSavedGame:
LCA35:	pha				;Save two copies of A. Why? Who knows. This code is-->
LCA36:	pha				;Never implemented. A contains data slot to work on.
LCA37:	jsr GetGameDataIndex		;($CA96)Get index to this save game Samus data info.
LCA3A:	lda EraseGame			;
LCA3D:	bpl +				;Is MSB set? If so, erase saved game data. Else branch.
LCA3F:	and #$01			;
LCA41:	sta EraseGame			;Clear MSB so saved game data is not erased again.
LCA44:	jsr EraseAllGameData		;($CAA1)Erase selected saved game data.
LCA47:	lda #$01			;Indicate this saved game has been erased.-->
LCA49:	sta $7800,y			;Saved game 0=$780C, saved game 1=$781C, saved game 2=$782C. 
LCA4C:*	lda MainRoutine			;
LCA4E:	cmp #$01			;If initializing the area at the start of the game, branch-->
LCA50:	beq +++				;to load Samus' saved game info.

SaveGameData:
LCA52:	lda InArea			;Save game based on current area Samus is in. Don't know why.
LCA54:	jsr SavedDataBaseAddr		;($CAC6)Find index to unique item history for this saved game.
LCA57:	ldy #$3F			;Prepare to save unique item history which is 64 bytes in length.
LCA59:*	lda NumberOfUniqueItems,y	;
LCA5C:	sta ($00),y			;Save unique item history in appropriate saved game slot.
LCA5E:	dey				;
LCA5F:	bpl -				;Loop until unique item history transfer complete.
LCA61:	ldy SamusDataIndex		;Prepare to save Samus' data.
LCA64:	ldx #$00			;
LCA66:*	lda SamusStat00,x		;
LCA69:	sta SamusData,y			;Save Samus' data in appropriate saved game slot.
LCA6C:	iny				;
LCA6D:	inx				;
LCA6E:	cpx #$10			;
LCA70:	bne -				;Loop until Samus' data transfer complete.

LoadGameData:
LCA72:*	pla				;Restore A to find appropriate saved game to load.
LCA73:	jsr SavedDataBaseAddr		;($CAC6)Find index to unique item history for this saved game.
LCA76:	ldy #$3F			;Prepare to load unique item history which is 64 bytes in length.
LCA78:*	lda ($00),y			;
LCA7A:	sta NumberOfUniqueItems,y	;Loop until unique item history is loaded.
LCA7D:	dey				;
LCA7E:	bpl -				;
LCA80:	bmi +				;Branch always.
LCA82:	pha				;
LCA83:*	ldy SamusDataIndex		;Prepare to load Samus' data.
LCA86:	ldx #$00			;
LCA88:*	lda SamusData,y			;
LCA8B:	sta SamusStat00,x		;Load Samus' data from appropriate saved game slot.
LCA8E:	iny				;
LCA8F:	inx				;
LCA90:	cpx #$10			;
LCA92:	bne -				;Loop until Samus' data transfer complete.
LCA94:	pla				;
LCA95:	rts				;

GetGameDataIndex:
LCA96:	lda DataSlot			;
LCA99:	asl				;A contains the save game slot to work on (0 1 or 2).-->
LCA9A:	asl				;This number is transferred to the upper four bits to-->
LCA9B:	asl				;find the offset for Samus' data for this particular-->
LCA9C:	asl				;saved game (#$00, #$10 or #$20).
LCA9D:	sta SamusDataIndex		;
LCAA0:	rts				;

EraseAllGameData:
LCAA1:	lda #$00			;Always start at saved game 0. Erase all 3 saved games.
LCAA3:	jsr SavedDataBaseAddr		;($CAC6)Find index to unique item history for this saved game.
LCAA6:	inc $03				;Prepare to erase saved game info at $6A00 and above.						
LCAA8:	ldy #$00			;Fill saved game data with #$00.
LCAAA:	tya				;
LCAAB:*	sta ($00),y			;Erase unique item histories from $69B4 to $69FF. 
LCAAD:	cpy #$40			;
LCAAF:	bcs +				;IF 64 bytes alrady erased, no need to erase any more-->
LCAB1:	sta ($02),y			;in the $6A00 and above range.
LCAB3:*	iny				;
LCAB4:	bne --				;Lop until all saved game data is erased.
LCAB6:	ldy SamusDataIndex		;Load proper index to desired Samus data to erase.
LCAB9:	ldx #$00			;
LCABB:	txa				;
LCABC:*	sta SamusData,y			;Erase Samus' data.
LCABF:	iny				;
LCAC0:	inx				;
LCAC1:	cpx #$0C			;
LCAC3:	bne -				;Loop until all data is erased.
LCAC5:	rts				;

;This routine finds the base address of the unique item history for the desired saved game (0, 1 or 2).
;The memory set aside for each unique item history is 64 bytes and occupies memory addresses $69B4 thru
;$6A73.

SavedDataBaseAddr:
LCAC6:	pha				;Save contents of A.
LCAC7:	lda DataSlot			;Load saved game data slot to load.
LCACA:	asl				;*2. Table values below are two bytes.
LCACB:	tax				;
LCACC:	lda SavedDataTable,x		;
LCACF:	sta $00				;Load $0000 and $0002 with base addresses from-->
LCAD1:	sta $02				;table below($69B4).
LCAD3:	lda SavedDataTable+1,x		;
LCAD6:	sta $01				;
LCAD8:	sta $03				;
LCADA:	pla				;Restore A.
LCADB:	and #$0F			;Discard upper four bits in A.
LCADD:	tax				;X used for counting loop.
LCADE:	beq +++				;Exit if at saved game 0.  No further calculations required.
LCAE0:*	lda $00				;
LCAE2:	clc				;
LCAE3:	adc #$40			;
LCAE5:	sta $00				;Loop to add #$40 to base address of $69B4 in order to find-->
LCAE7:	bcc +				;the proper base address for this saved game data. (save-->
LCAE9:	inc $01				;slot 0 = $69B4, save slot 1 = $69F4, save slot 2 = $6A34).
LCAEB:*	dex				;
LCAEC:	bne --				;
LCAEE:*	rts				;

;Table used by above subroutine to find base address to load saved game data from. The slot 0
;starts at $69B4, slot 1 starts at $69F4 and slot 2 starts at $6A34.

SavedDataTable:
LCAEF:	.word ItmeHistory		;($69B4)Base for save game slot 0.
LCAF1:	.word ItmeHistory		;($69B4)Base for save game slot 1.
LCAF3:	.word ItmeHistory		;($69B4)Base for save game slot 2.

;----------------------------------------[ Choose ending ]-------------------------------------------

;Determine what type of ending is to be shown, based on Samus' age
ChooseEnding:
LCAF5:	ldy #$01			;
LCAF7:*	lda SamusAge+2			;If SamusAge+2 anything but #$00, load worst-->
LCAFA:	bne +				;ending(more than 37 hours of gameplay).
LCAFC:	lda SamusAge+1			;
LCAFF:	cmp AgeTable-1,y		;Loop four times to determine-->
LCB02:	bcs +				;ending type from table below.
LCB04:	iny				;
LCB05:	cpy #$05			;
LCB07:	bne -				;
LCB09:*	sty EndingType			;Store the ending # (1..5), 5=best ending
LCB0C:	lda #$00			;
LCB0E:	cpy #$04			;Was the best or 2nd best ending achieved?
LCB10:	bcc +				;Branch if not (suit stays on)
LCB12:	lda #$01			;
LCB14:*	sta JustInBailey		;Suit OFF, baby!
LCB17:	rts				;

;Table used by above subroutine to determine ending type.
AgeTable:
LCB18:	.byte $7A			;Max. 37 hours
LCB19:	.byte $16			;Max. 6.7 hours
LCB1A:	.byte $0A			;Max. 3.0 hours
LCB1B:	.byte $04			;Best ending. Max. 1.2 hours

;--------------------------------[ Clear screen data (not used) ]------------------------------------

ClearScreenData:
LCB1C:	jsr ScreenOff			;($C439)Turn off screen.
LCB1F:	lda #$FF			;
LCB21:	sta $00				;Prepare to fill nametable with #$FF.
LCB23:	jsr ClearNameTable		;($C175)Clear selected nametable.
LCD26:	jmp EraseAllSprites		;($C1A3)Clear sprite data.

;----------------------------------------------------------------------------------------------------

; ===== THE REAL GUTS OF THE GAME ENGINE! =====

UpdateWorld:
LCB29:	ldx #$00			;Set start of sprite RAM to $0200.
LCB2B:	stx SpritePagePos		;

LCB2D:	jsr UpdateEnemies		;($F345)Display of enemies.
LCB30:	jsr UpdateProjectiles		;($D4BF)Display of bullets/missiles/bombs.
LCB33:	jsr UpdateSamus			;($CC0D)Display/movement of Samus.
LCB36:	jsr AreaRoutine			;($95C3)Area specific routine.
LCB39:	jsr UpdateElevator		;($D7B3)Display of elevators.
LCB3C:	jsr UpdateStatues		;($D9D4)Display of Ridley & Kraid statues.
LCB3F:	jsr $FA9D       ; destruction of enemies
LCB42:	jsr LFC65       ; update of Mellow/Memu enemies
LCB45:	jsr LF93B
LCB48:	jsr LFBDD       ; destruction of green spinners
LCB4B:	jsr SamusEnterDoor		;($8B13)Check if Samus entered a door.
LCB4E:	jsr $8B79       ; display of doors
LCB51:	jsr UpdateTiles ; tile de/regeneration
LCB54:	jsr LF034       ; Samus <--> enemies crash detection
LCB57:	jsr DisplayBar			;($E0C1)Display of status bar.
	jsr LFAF2
	jsr CheckMissileToggle
	jsr UpdateItems ; display of special items
	jsr LFDE3

;Clear remaining sprite RAM
	ldx SpritePagePos
	lda #$F4
*       sta Sprite00RAM,x
	jsr Xplus4       ; X = X + 4
	bne -
	rts

; SelectSamusPal
; ==============
; Select the proper palette for Samus based on:
; - Is Samus wearing Varia (protective suit)?
; - Is Samus firing missiles or regular bullets?
; - Is Samus with or without suit?

SelectSamusPal:
	tya
	pha
	lda SamusGear
	asl
	asl
	asl				;CF contains Varia status (1 = Samus has it)
	lda MissileToggle		;A = 1 if Samus is firing missiles, else 0
	rol				;Bit 0 of A = 1 if Samus is wearing Varia
	adc #$02
	ldy JustInBailey		;In suit?
	beq +				;Branch if yes
	clc
	adc #$17			;Add #$17 to the pal # to reach "no suit"-palettes
*       sta PalDataPending		;Palette will be written next NMI
	pla
	tay
	rts

;----------------------------------[ Initiate SFX and music routines ]-------------------------------

;Initiate sound effects.

SilenceMusic:				;The sound flags are stored in memory-->
LCB8E:	lda #$01			;starting at $0680. The following is a-->
LCB90:	bne SFX_SetX0			;list of sound effects played when the-->
					;flags are set:
PauseMusic:				;
LCB92:	lda #$02   	     		;$0680: These SFX use noise channel.
LCB94:	bne SFX_SetX0			;Bit 7 - No sound.
					;Bit 6 - ScrewAttack.
SFX_SamusWalk:				;Bit 5 - MissileLaunch.
LCB96:	lda #$08			;Bit 4 - BombExplode.
LCB98:	bne SFX_SetX0			;Bit 3 - SamusWalk.
					;Bit 2 - SpitFlame.
SFX_BombExplode:			;Bit 1 - No sound.
LCB9A:	lda #$10			;Bit 0 - No sound.
LCB9C:	bne SFX_SetX0			;
					;$0681: These SFX use sq1 channel.
SFX_MissileLaunch:			;Bit 7 - MissilePickup.
LCB9E:	lda #$20			;Bit 6 - EnergyPickup.
					;Bit 5 - Metal.
SFX_SetX0:				;Bit 4 - BulletFire.
LCBA0:	ldx #$00			;Bit 3 - OutOfHole.
LCBA2:	beq SFX_SetSoundFlag		;Bit 2 - EnemyHit.
					;Bit 1 - SamusJump.
SFX_OutOfHole:				;Bit 0 - WaveFire.
LCBA4:	lda #$08			;
LCBA6:	bne SFX_SetX1			;$0682: Not used.
					;
SFX_BombLaunch:				;$0683: These SFX use tri channel.
LCBA8:	lda #$01			;Bit 7 - SamusDie.
LCBAA:	bne SFX_SetX3			;Bit 6 - DoorOpenClose.
					;Bit 5 - MetroidHit.
SFX_SamusJump:				;Bit 4 - StatueRaise.
LCBAC:	lda #$02			;Bit 3 - Beep.
LCBAE:	bne SFX_SetX1			;Bit 2 - BigEnemyHit.
					;Bit 1 - SamusBall.
SFX_EnemyHit:				;Bit 0 - BombLaunch.
LCBB0:	lda #$04			;
LCBB2:	bne SFX_SetX1			;$0684: These SFX use multi channels.
					;Bit 7 - FadeInMusic		(music).
SFX_BulletFire:				;Bit 6 - PowerUpMusic		(music).
LCBB4:	lda #$10			;Bit 5 - EndMusic  (Page 0 only)(music).
LCBB6:	bne SFX_SetX1			;Bit 4 - IntroMusic(Page 0 only)(music).
					;Bit 3 - not used		(SFX).
SFX_Metal:				;Bit 2 - SamusHit		(SFX).
LCBB8:	lda #$20			;Bit 1 - BossHit		(SFX).
LCBBA:	bne SFX_SetX1			;Bit 0 - IncorrectPassword	(SFX).
					;
SFX_EnergyPickup:			;$0685: Music flags. The music flags start different-->
LCBBC:	lda #$40			;music depending on what memory page is loaded. The-->
LCBBD:	bne SFX_SetX1			;following lists what bits start what music for each-->
					;memory page.
SFX_MissilePickup:			;
LCBC0:	lda #$80			;Page 0: Intro/ending.
					;Bit 7 - Not used.
SFX_SetX1:				;Bit 6 - TourianMusic.
LCBC2:	ldx #$01			;Bit 5 - ItemRoomMusic.
LCBC4:	bne SFX_SetSoundFlag		;Bit 4 - Not used.
					;Bit 3 - Not used.
SFX_WaveFire:				;Bit 2 - Not used.
LCBC6:	lda #$01			;Bit 1 - Not used.
LCBC8:	bne SFX_SetX1			;Bit 0 - Not used.
					;
SFX_ScrewAttack:			;Page 1: Brinstar.
LCBCA:	lda #$40			;Bit 7 - Not used.
LCBCC:	bne SFX_SetX0			;Bit 6 - TourianMusic.
					;Bit 5 - ItemRoomMusic.
SFX_BigEnemyHit:			;Bit 4 - Not used.
LCBCE:	lda #$04			;Bit 3 - Not used.
LCBD0:	bne SFX_SetX3			;Bit 2 - Not used.
					;Bit 1 - Not used.
SFX_MetroidHit:				;Bit 0 - BrinstarMusic.
LCBD2:	lda #$20			;
LCBD4:	bne SFX_SetX3			;Page 2: Norfair.
					;Bit 7 - Not used.
SFX_BossHit:				;Bit 6 - TourianMusic.
LCBD6:	lda #$02			;Bit 5 - ItemRoomMusic.
LCBD8:	bne SFX_SetX4			;Bit 4 - Not used.
					;Bit 3 - NorfairMusic.
SFX_Door:				;Bit 2 - Not used.
LCBDA:	lda #$40			;Bit 1 - Not used.
LCBDC:	bne SFX_SetX3			;Bit 0 - Not used.
					;
SFX_SamusHit:				;Page 3: Tourian.
LCBDE:	lda #$04			;Bit 7 - Not used.
LCBE0:	bne SFX_SetX4			;Bit 6 - TourianMusic
					;Bit 5 - ItemRoomMusic.
SFX_SamusDie:				;Bit 4 - Not used.
LCBE2:	lda #$80			;Bit 3 - Not used.
LCBE4:	bne SFX_SetX3			;Bit 2 - EscapeMusic.
					;Bit 1 - MotherBrainMusic
SFX_SetX2:				;Bit 0 - Not used.
LCBE6:	ldx #$02			;
					;Page 4: Kraid.
SFX_SetSoundFlag:			;Bit 7 - RidleyAreaMusic.
LCBE8:	ora $0680,x			;Bit 6 - TourianMusic.
LCBEB:	sta $0680,x			;Bit 5 - ItemRoomMusic.
LCBEE:	rts				;Bit 4 - KraidAreaMusic.
					;Bit 3 - Not used.
SFX_SamusBall:				;Bit 2 - Not used.
LCBEF:	lda #$02			;Bit 1 - Not used.
LCBF1:	bne SFX_SetX3			;Bit 0 - Not used.
					;
SFX_Beep:				;Page 5: Ridley.
LCBF3:	lda #$08			;Bit 7 - RidleyAreaMusic.
					;Bit 6 - TourianMusic.
SFX_SetX3:				;Bit 5 - ItemRoomMusic.
LCBF5:	ldx #$03			;Bit 4 - KraidAreaMusic.
LCBF7:	bne SFX_SetSoundFlag		;Bit 3 - Not used.
					;Bit 2 - Not used.
;Initiate music				;Bit 1 - Not used.
					;Bit 0 - Not used.
PowerUpMusic:				;
LCBF9:	lda #$40			;
LCBFB:	bne SFX_SetX4			;
					;
IntroMusic:				;
LCBFD:	lda #$80			;
					;
SFX_SetX4:				;
LCBFF:	ldx #$04			;
LCC01:	bne SFX_SetSoundFlag		;
					;
MotherBrainMusic:			;
LCC03:	lda #$02			;
LCC05:	bne SFX_SetX5			;
					;
TourianMusic:				;
LCC07:	lda #$40			;
					;
SFX_SetX5:				;
LCC09:	ldx #$05			;
LCC0B:	bne SFX_SetSoundFlag		;

;--------------------------------------[ Update Samus ]----------------------------------------------

UpdateSamus:
LCC0D:	ldx #$00			;Samus data is located at index #$00.
LCC0F:	stx PageIndex			;
LCC11:	inx				;x=1.
LCC12:	stx IsSamus			;Indicate Samus is the object being updated.
LCC14:	jsr GoSamusHandler		;($CC1A)Find proper Samus handler routine.
LCC17:	dec IsSamus			;Update of Samus complete.
LCC19:	rts				;

GoSamusHandler:
LCC1A:	lda ObjAction			;
LCC1D:	bmi SamusStand			;Branch if Samus is standing.
LCC1F:	jsr ChooseRoutine		;($C27C)Goto proper Samus handler routine.

;Pointer table for Samus' action handlers.

LCC22:	.word SamusStand		;($CC36)Standing.
LCC24:	.word SamusRun			;($CCC2)Running.
LCC26:	.word SamusJump			;($D002)Jumping.
LCC28:	.word SamusRoll			;($D0E1)Rolling.
LCC2A:	.word SamusPntUp		;($D198)Pointing up.
LCC2C:	.word SamusDoor			;($D3A8)Inside door while screen scrolling.
LCC2E:	.word SamusJump			;($D002)Jumping while pointing up.
LCC30:	.word SamusDead			;($D41A)Dead.
LCC32:	.word SamusDead2		;($D41F)More dead.
LCC34:	.word SamusElevator		;($D423)Samus on elevator.

;---------------------------------------[ Samus standing ]-------------------------------------------

SamusStand:
LCC36:	lda Joy1Status			;Status of joypad 1.
LCC38:	and #$CF			;Remove SELECT & START status bits.
LCC3A:	beq +				;Branch if no buttons pressed.
LCC3C:	jsr ClearHorzMvmtAnimData	;($CF5D)Set no horiontal movement and single frame animation.
LCC3F:	lda Joy1Status			;
LCC41:*	and #$07			;Keep status of DOWN/LEFT/RIGHT.
LCC43:	bne +				;Branch if any are pressed.
LCC45:	lda Joy1Change			;
LCC47:	and #$08     			;Check if UP was pressed last frame.-->
LCC49:	beq +++				;If not, branch.
LCC4B:*	jsr BitScan			;($E1E1)Find which directional button is pressed.
LCC4E:	cmp #$02			;Is down pressed?-->
LCC50:	bcs +				;If so, branch.
LCC52:	sta SamusDir			;1=left, 0=right.
LCC54:*	tax				;
LCC55:	lda ActionTable,x		;Load proper Samus status from table below.
LCC58:	sta ObjAction			;Save Samus status.
LCC5B:*	lda Joy1Change			;
LCC5D:	ora Joy1Retrig			;Check if fire was just pressed or needs to retrigger.
LCC5F:	asl				;
LCC60:	bpl +				;Branch if FIRE not pressed.
LCC62:	jsr FireWeapon			;($D1EE)Shoot left/right.
LCC65:*	bit Joy1Change			;Check if jump was just pressed.
LCC67:	bpl +				;Branch if JUMP not pressed.
LCC69:	lda #sa_Jump			;
LCC6B:	sta ObjAction			;Set Samus status as jumping.
LCC6E:*	lda #$04			;Prepare to set animation delay to 4 frames.
LCC70:	jsr SetSamusData		;($CD6D)Set Samus control data and animation.
LCC73:	lda ObjAction			;
LCC76:	cmp #sa_Door			;Is Samus inside a door, dead or pointing up and jumping?-->
LCC78:	bcs +				;If so, branch to exit.
LCC7A:	jsr ChooseRoutine		;Select routine below.

;Pointer table to code.

LCC7D:	.word ExitSub			;($C45C)Rts.
LCC7F:	.word SetSamusRun		;($CC98)Samus is running.
LCC81:	.word SetSamusJump		;($CFC3)Samus is jumping.
LCC83:	.word SetSamusRoll		;($D0B5)Samus is in a ball.
LCC85:	.word SetSamusPntUp		;($CF77)Samus is pointing up.

;Table used by above subroutine.

ActionTable:
LCC87:	.byte sa_Run			;Run right.
LCC88:	.byte sa_Run			;Run left.
LCC89:	.byte sa_Roll
LCC8A:	.byte sa_PntUp

;----------------------------------------------------------------------------------------------------

SetSamusExplode:
LCC8B:  lda #$50
	sta SamusJumpDsplcmnt
	lda #an_Explode
	jsr SetSamusAnim
	sta ObjectCounter
*       rts

SetSamusRun:
LCC98:  lda #$09
	sta WalkSoundDelay
	ldx #$00
	lda AnimResetIndex
	cmp #an_SamusStand
	beq +
	inx
	cmp #$27
	beq +
	lda #$04
	jsr SetSamusNextAnim
*       lda RunAnimationTbl,x
	sta AnimResetIndex
	ldx SamusDir
LCCB7:  lda RunAccelerationTbl,x
	sta SamusHorzAccel
	rts

RunAnimationTbl:
LCCBE:  .byte an_SamusRun
	.byte an_SamusRunPntUp

RunAccelerationTbl:
LCCC0:  .byte $30			;Accelerate right.
	.byte $D0			;Accelerate left.

; SamusRun
; ========

SamusRun:
	ldx SamusDir
	lda SamusGravity
	beq +++++++
	ldy SamusJumpDsplcmnt
	bit ObjVertSpeed
	bmi +
	cpy #$18
	bcs ++++
	lda #an_SamusJump
	sta AnimResetIndex
	bcc ++++	  ; branch always
*       cpy #$18
	bcc +++
	lda AnimResetIndex
	cmp #an_SamusFireJump
	beq +
	lda #an_SamusSalto
	sta AnimResetIndex
*       cpy #$20
	bcc ++
	lda Joy1Status
	and #$08
	beq +
	lda #an_SamusJumpPntUp
	sta AnimResetIndex
*       bit Joy1Status
	bmi +
	jsr StopVertMovement		;($D147)
*	lda #an_SamusRun
	cmp AnimResetIndex
	bne +
	lda #an_SamusJump
	sta AnimResetIndex
*       lda SamusInLava
	beq +
	lda Joy1Change
	bmi LCD40       ; branch if JUMP pressed
*       jsr LCF88
	jsr LD09C
	jsr LCF2E
	lda #$02
	bne SetSamusData       ; branch always
*	lda SamusOnElevator
	bne +
	jsr LCCB7
*       jsr LCDBF
	dec WalkSoundDelay  ; time to play walk sound?
	bne +	       ; branch if not
	lda #$09
	sta WalkSoundDelay  ; # of frames till next walk sound trigger
	jsr SFX_SamusWalk
*       jsr LCF2E
	lda Joy1Change
	bpl +	   ; branch if JUMP not pressed
LCD40:  jsr LCFC3
	lda #$12
	sta SamusHorzSpeedMax
	jmp LCD6B

*       ora Joy1Retrig
	asl
	bpl +	   ; branch if FIRE not pressed
	jsr LCDD7
*       lda Joy1Status
	and #$03
	bne +
	jsr LCF55
	jmp LCD6B

*       jsr BitScan			;($E1E1)
	cmp SamusDir
	beq LCD6B
	sta SamusDir
	jsr LCC98
LCD6B:  lda #$03

;---------------------------------------[ Set Samus data ]-------------------------------------------

;The following function sets various animation and control data bytes for Samus.

SetSamusData:
LCD6D:  jsr UpdateObjAnim		;($DC8F)Update animation if needed.
LCD70:	jsr IsScrewAttackActive		;($CD9C)Check if screw attack active to change palette.
LCD73:	bcs +				;If screw attack not active, branch to skip palette change.
LCD75:	lda FrameCount			;
LCD77:	lsr				;
LCD78:	and #$03			;Every other frame, change Samus palette while screw-->
LCD7A:	ora #$A0			;Attack is active.
LCD7C:	sta ObjectCntrl			;
LCD7E:*	jsr CheckHealthStatus		;($CDFA)Check if Samus hit, blinking or Health low.
LCD81:	jsr LavaAndMoveCheck		;($E269)Check if Samus is in lava or moving.
LCD84:	lda MetroidOnSamus		;Is a Metroid stuck to Samus?-->
LCD86:	beq +				;If not, branch.
LCD88:	lda #$A1			;Metroid on Samus. Turn Samus blue.
LCD8A:	sta ObjectCntrl			;
LCD8C:*	jsr SetmirrorCntrlBit		;($CD92)Mirror Samus, if necessary.
LCD8F:	jmp DrawFrame			;($DE4A)Display Samus.

;---------------------------------[ Set mirror control bit ]-----------------------------------------

SetmirrorCntrlBit:
LCD92:  lda SamusDir			;Facing left=#$01, facing right=#$00.
LCD94:	jsr Amul16			;($C2C5)*16. Move bit 0 to bit 4 position.
LCD97:	ora ObjectCntrl			;
LCD99:	sta ObjectCntrl			;Use SamusDir bit to set mirror bit.
LCD9B:	rts				;

;------------------------------[ Check if screw attack is active ]-----------------------------------

IsScrewAttackActive:
LCD9C:  sec				;Assume screw attack is not active.
LCD9D:	ldy ObjAction			;
LCDA0:	dey				;Is Samus running?-->
LCDA1:	bne ++				;If not, branch to exit.
LCDA3:	lda SamusGear			;
LCDA6:	and #gr_SCREWATTACK		;Does Samus have screw attack?-->
LCDA8:	beq ++				;If not, branch to exit.
LCDAA:	lda AnimResetIndex		;
LCDAD:	cmp #an_SamusSalto		;Is Samus summersaulting?-->
LCDAF:	beq +				;If so, branch to clear carry(screw attack active).
LCDB1:	cmp #an_SamusJump		;
LCDB3:	sec				;Is Samus jumping?-->
LCDB4:	bne ++				;If not, branch to exit.
LCDB6:	bit ObjVertSpeed		;If Samus is jumping and still moving upwards, screw--> 
LCDB9:	bpl ++				;attack is active.
LCDBB:*	cmp AnimIndex			;Screw attack will still be active if not spinning, but-->
LCDBE:*	rts				;jumping while running and still moving upwards.

;----------------------------------------------------------------------------------------------------

LCDBF:  lda Joy1Status
	and #$08
	lsr
	lsr
	lsr
	tax
	lda LCCBE,x
	cmp AnimResetIndex
	beq -
	jsr SetSamusAnim
	pla
	pla
	jmp LCD6B

LCDD7:  jsr FireWeapon			;($D1EE)Shoot left/right.
	lda Joy1Status
	and #$08
	bne +
	lda #an_SamusFireRun
	sta AnimIndex
	rts

*       lda AnimIndex
	sec
	sbc AnimResetIndex
	and #$03
	tax
	lda Table05,x
	jmp SetSamusNextAnim

; Table used by above subroutine

Table05:
	.byte $3F
	.byte $3B
	.byte $3D
	.byte $3F

CheckHealthStatus:
LCDFA:  lda SamusHit			;
	and #$20			;Has Samus been hit?-->
	beq +++				;If not, branch to check if still blinking from recent hit.
	lda #$32			;
	sta SamusBlink			;Samus has been hit. Set blink for 32 frames.
	lda #$FF
	sta DamagePushDirection
	lda $73
	sta $77
	beq ++
	bpl +
	jsr SFX_SamusHit
*       lda SamusHit
	and #$08
	lsr
	lsr
	lsr
	sta DamagePushDirection
*	lda #$FD
	sta ObjVertSpeed
	lda #$38			;Samus is hit. Store Samus hit gravity.
	sta SamusGravity		;
	jsr IsSamusDead
	bne +
	jmp CheckHealthBeep

*	lda SamusBlink
	beq CheckHealthBeep
	dec SamusBlink
	ldx DamagePushDirection
	inx
	beq +++
	jsr Adiv16       ; / 16
	cmp #$03
	bcs +
	ldy SamusHorzAccel
	bne +++
	jsr LCF4E
*       dex
	bne +
	jsr TwosCompliment		;($C3D4)
*       sta ObjHorzSpeed
*	lda $77
	bpl CheckHealthBeep
	lda FrameCount
	and #$01
	bne CheckHealthBeep
	tay
	sty AnimDelay
	ldy #$F7
	sty AnimFrame

CheckHealthBeep:
	ldy HealthHi
	dey
	bmi +
	bne ++
	lda HealthLo
	cmp #$70
	bcs ++
; health < 17
*       lda FrameCount
	and #$0F
	bne +				;Only beep every 16th frame.
	jsr SFX_Beep
*	lda #$00
	sta SamusHit
LCE83:	rts

;----------------------------------------[ Is Samus dead ]-------------------------------------------

IsSamusDead:
LCE84:	lda ObjAction			;
LCE87:	cmp #sa_Dead			;
LCE89:	beq Exit3			;Samus is dead. Zero flag is set.
LCE8B:	cmp #sa_Dead2			;
LCE8D:	beq Exit3			;
LCE8F:	cmp #$FF			;Samus not dead. Clear zero flag.

Exit3:  
LCE91:	rts				;Exit for routines above and below.

;----------------------------------------[ Subtract health ]-----------------------------------------

SubtractHealth:
LCE92:	lda HealthLoChange		;Check to see if health needs to be changed.-->
LCE94:	ora HealthHiChange		;If not, branch to exit.
LCE96:	beq Exit3			;
LCE98:	jsr IsSamusDead			;($CE84)Check if Samus is already dead.
LCE9B:	beq ClearDamage			;Samus is dead. Branch to clear damage values.
LCE9D:	ldy EndTimerHi			;If end escape timer is running, Samus cannot be hurt.
LCEA0:	iny				;
LCEA1:	beq +				;Branch if end escape timer not active.

ClearDamage:
LCEA3:	jmp ClearHealthChange		;($F323)Clear health change values.

LCEA6:*	lda MotherBrainStatus		;If mother brain is in the process of dying, receive-->
LCEA8:	cmp #$03			;no damage.
LCEAA:	bcs ClearDamage			;

LCEAC:	lda SamusGear			;
LCEAF:	and #gr_VARIA			;Check is Samus has Varia.
LCEB1:	beq +				;
LCEB3:	lsr HealthLoChange		;If Samus has Varia, divide damage by 2.
LCEB5:	lsr HealthHiChange		;
LCEB7:	bcc +				;If HealthHi moved a bit into the carry flag while-->
LCEB9:	lda #$4F			;dividing, add #$4F to HealthLo for proper-->
LCEBB:	adc HealthLoChange		;division results.
LCEBD:	sta HealthLoChange		;

LCEBF:*	lda HealthLo			;Prepare to subtract from HealthLo.
LCEC2:	sta $03				;
LCEC4:	lda HealthLoChange		;Amount to subtract from HealthLo.
LCEC6:	sec				;
LCEC7:	jsr Base10Subtract		;($C3FB)Perform base 10 subtraction.
LCECA:	sta HealthLo			;Save results.

LCECD:   lda HealthHi			;Prepare to subtract from HealthHi.
LCED0:	sta $03				;
LCED2:	lda HealthHiChange		;Amount to subtract from HealthHi.
LCED4:	jsr Base10Subtract		;($C3FB)Perform base 10 subtraction.
LCED7:	sta HealthHi			;Save Results.

LCEDA:	lda HealthLo			;
LCEDD:	and #$F0			;Is Samus health at 0?  If so, branch to-->
LCEDF:	ora HealthHi			;begin death routine.
LCEE2:	beq +				;
LCEE4:	bcs ++				;Samus not dead. Branch to exit.

LCEE6:*	lda #$00			;Samus is dead.
LCEE8:	sta HealthLo			;
LCEEB:	sta HealthHi			;Set health to #$00.
LCEEE:	lda #sa_Dead			;
LCEF0:	sta ObjAction			;Death handler.
LCEF3:	jsr SFX_SamusDie		;($CBE2)Start Samus die SFX.
LCEF6:	jmp SetSamusExplode		;($CC8B)Set Samus exlpode routine.

;----------------------------------------[ Add health ]----------------------------------------------

AddHealth:
LCEF9:	lda HealthLo			;Prepare to add to HealthLo.
LCEFC:	sta $03				;
LCEFE:	lda HealthLoChange		;Amount to add to HealthLo.
LCF00:	clc				;
LCF01:	jsr Base10Add			;($C3DA)Perform base 10 addition.
LCF04:	sta HealthLo			;Save results.

LCF07:	lda HealthHi			;Prepare to add to HealthHi.
LCF0A:	sta $03				;
LCF0C:	lda HealthHiChange		;Amount to add to HealthHi.
LCF0E:	jsr Base10Add			;($C3DA)Perform base 10 addition.
LCF11:	sta HealthHi			;Save results.

LCF14:	lda TankCount			;
LCF17:	jsr Amul16			;($C2C5)*16. Move tank count to upper 4 bits.
LCF1A:	ora #$0F			;Set lower 4 bits.
LCF1C:	cmp HealthHi			;
LCF1F:	bcs +				;Is life less than max? if so, branch.
LCF21:	and #$F9			;Life is more than max amount. 
LCF23:	sta HealthHi			;
LCF26:	lda #$99			;Set life to max amount.
LCF28:	sta HealthLo			;
LCF2B:*	jmp ClearHealthChange		;($F323)

;----------------------------------------------------------------------------------------------------

LCF2E:	lda SamusHit
LCF31:	lsr
	and #$02
	beq +++
	bcs +
	lda SamusHorzAccel
	bmi +++
	bpl ++
*       lda SamusHorzAccel
	bmi +
	bne ++
*	jsr TwosCompliment		;($C3D4)
	sta SamusHorzAccel

ClearHorzMvmntData:
LCF4C:  ldy #$00			;
LCF4E:  sty ObjHorzSpeed		;Set Samus Horizontal speed and horizontal-->
	sty HorzCntrLinear		;linear counter to #$00.
*	rts				;

StopHorzMovement:
LCF55:  lda SamusHorzAccel		;Is Samus moving horizontally?-->
	bne ClearHorzMvmtAnimData	;If so, branch to stop movement.
	jsr SFX_SamusWalk		;($CB96)Play walk SFX.

ClearHorzMvmtAnimData:
LCF5D:  jsr NoHorzMoveNoDelay		;($CF81)Clear horizontal movement and animation delay data.
	sty ObjAction			;Samus is standing.
	lda Joy1Status			;
	and #$08			;Is The up button being pressed?-->
	bne +				;If so, branch.
	lda #an_SamusStand		;Set Samus animation for standing.

SetSamusAnim:
LCF6B:	sta AnimResetIndex		;Set new animation reset index.

SetSamusNextAnim:
	sta AnimIndex			;Set new animation data index.
	lda #$00			;
	sta AnimDelay			;New animation to take effect immediately.
	rts				;

SetSamusPntUp:
LCF77:*	lda #sa_PntUp			;
	sta ObjAction			;Samus is pointing up.
	lda #an_SamusPntUp		;
	jsr SetSamusAnim		;($CF6B)Set new animation values.

NoHorzMoveNoDelay:
LCF81:  jsr ClearHorzData		;($CFB7)Clear all horizontal movement data.
	sty AnimDelay			;Clear animation delay data.
	rts				;

LCF88:  lda Joy1Status
	and #$03
	beq +
	jsr BitScan			;($E1E1)
	tax
	jsr LCCB7
	lda SamusGravity
	bmi ++
	lda AnimResetIndex
	cmp #an_SamusSalto
	beq ++
	stx SamusDir
	lda Table06+1,x
	jmp SetSamusAnim

*       lda SamusGravity
	bmi +
	beq +
	lda AnimResetIndex
	cmp #an_SamusJump
	bne +

ClearHorzData:
LCFB7:  jsr ClearHorzMvmntData		;($CF4C)Clear horizontal speed and linear counter.
	sty SamusHorzAccel		;Clear horizontal acceleration data.
*	rts				;

LCFBE:  ldy #an_SamusJumpPntUp
	jmp +

SetSamusJump:
LCFC3:  ldy #an_SamusJump
*       sty AnimResetIndex
	dey
	sty AnimIndex
	lda #$04
	sta AnimDelay
	lda #$00
	sta SamusJumpDsplcmnt
	lda #$FC
	sta ObjVertSpeed
	ldx ObjAction
	dex
	bne +	   ; branch if Samus is standing still
	lda SamusGear
	and #gr_SCREWATTACK
	beq +	   ; branch if Samus doesn't have Screw Attack
	lda #$00
	sta $0686
	jsr SFX_ScrewAttack
*       jsr SFX_SamusJump
LCFF3:  ldy #$18	; gravity (high value -> low jump)
	lda SamusGear
	and #gr_HIGHJUMP
	beq +	   ; branch if Samus doesn't have High Jump
	ldy #$12	; lower gravity value -> high jump!
*       sty SamusGravity
	rts

SamusJump:
	lda SamusJumpDsplcmnt
	bit ObjVertSpeed
	bpl +	   ; branch if falling down
	cmp #$20
	bcc +	   ; branch if jumped less than 32 pixels upwards
	bit Joy1Status
	bmi +	   ; branch if JUMP button still pressed
	jsr StopVertMovement		;($D147)Stop jump (start falling).
*       jsr LD055
	jsr LCF2E
	lda Joy1Status
	and #$08     ; UP pressed?
	beq +	   ; branch if not
	lda #an_SamusJumpPntUp
	sta AnimResetIndex
	lda #sa_PntJump      ; "jumping & pointing up" handler
	sta ObjAction
*       jsr LD09C
	lda SamusInLava
	beq +
	lda Joy1Change
	bpl +	   ; branch if JUMP not pressed
	jsr LCFC3
	jmp LCD6B

*       lda SamusGravity
	bne ++
	lda ObjAction
	cmp #sa_PntJump
	bne +
	jsr LCF77
	bne ++
*       jsr LCF55
*	lda #$03
	jmp SetSamusData		;($CD6D)Set Samus control data and animation.

LD055:  ldx #$01
	ldy #$00
	lda Joy1Status
	lsr
	bcs +	   ; branch if RIGHT pressed
	dex
	lsr
	bcc ++++       ; branch if LEFT not pressed
	dex
	iny
*       cpy SamusDir
	beq +++
	lda ObjAction
	cmp #sa_PntJump
	bne +
	lda AnimResetIndex
	cmp Table04,y
	bne ++
	lda Table04+1,y
	jmp ++

*       lda AnimResetIndex
	cmp Table06,y
	bne +
	lda Table06+1,y
*	jsr SetSamusAnim
	lda #$08
	sta AnimDelay
	sty SamusDir
*	stx ObjHorzSpeed
*       rts

; Table used by above subroutine

Table06:
	.byte $0C
	.byte $0C
	.byte $0C
Table04:
	.byte $35
	.byte $35
	.byte $35

LD09C:  lda Joy1Change
	ora Joy1Retrig
	asl
	bpl -	   ; exit if FIRE not pressed
	lda AnimResetIndex
	cmp #an_SamusJumpPntUp
	bne +
	jmp LD275

*       jsr LD210
	lda #an_SamusFireJump
	jmp SetSamusAnim

SetSamusRoll:
LD0B5:  lda SamusGear
	and #gr_MARUMARI
	beq +	   ; branch if Samus doesn't have Maru Mari
	lda SamusGravity
	bne +

;Turn Samus into ball
	ldx SamusDir
	lda #an_SamusRoll
	sta AnimResetIndex
	lda #an_SamusRunJump
	sta AnimIndex
	lda LCCC0,x
	sta SamusHorzAccel
	lda #$01
	sta $0686
	jmp SFX_SamusBall

*       lda #sa_Stand
	sta ObjAction
	rts

; SamusRoll
; =========

	SamusRoll:
	lda Joy1Change
	and #$08     ; UP pressed?
	bne +	   ; branch if yes
	bit Joy1Change	; JUMP pressed?
	bpl ++	  ; branch if no
*       lda Joy1Status
	and #$04	   ; DOWN pressed?
	bne +	  ; branch if yes
;break out of "ball mode"
	lda ObjRadY
	clc
	adc #$08
	sta ObjRadY
	jsr CheckMoveUp
	bcc +	  ; branch if not possible to stand up
	ldx #$00
	jsr LE8BE
	stx $05
	lda #$F5
	sta $04
	jsr LFD8F
	jsr LD638
	jsr LCF55
	dec AnimIndex
	jsr StopVertMovement		;($D147)
	lda #$04
	jmp LD144

*	lda Joy1Change
	jsr BitScan			;($E1E1)
	cmp #$02
	bcs +
	sta SamusDir
	lda #an_SamusRoll
	jsr SetSamusAnim
*       ldx SamusDir
	jsr LCCB7
	jsr LCF2E
	jsr CheckBombLaunch
	lda Joy1Status
	and #$03
	bne +
	jsr LCFB7
*       lda #$02
LD144:  jmp SetSamusData		;($CD6D)Set Samus control data and animation.

StopVertMovement:
LD147:  ldy #$00
	sty ObjVertSpeed
	sty VertCntrLinear
	rts

; CheckBombLaunch
; ===============
; This routine is called only when Samus is rolled into a ball.
; It does the following:
; - Checks if Samus has bombs
; - If so, checks if the FIRE button has been pressed
; - If so, checks if there are any object "slots" available
;   (only 3 bullets/bombs can be active at the same time)
; - If so, a bomb is launched.

	CheckBombLaunch:
	lda SamusGear
	lsr
	bcc ++	  ; exit if Samus doesn't have Bombs
	lda Joy1Change
	ora Joy1Retrig
	asl		; bit 7 = status of FIRE button
	bpl ++	  ; exit if FIRE not pressed
	lda ObjVertSpeed
	ora SamusOnElevator
	bne ++
	ldx #$D0	; try object slot D
	lda ObjAction,x
	beq +	   ; launch bomb if slot available
	ldx #$E0	; try object slot E
	lda ObjAction,x
	beq +	   ; launch bomb if slot available
	ldx #$F0	; try object slot F
	lda ObjAction,x
	bne ++	  ; no bomb slots available, exit
; launch bomb... give it same coords as Samus
*       lda ObjectHi
	sta ObjectHi,x
	lda ObjectX
	sta ObjectX,x
	lda ObjectY
	clc
	adc #$04	; 4 pixels further down than Samus' center
	sta ObjectY,x
	lda #wa_LayBomb
	sta ObjAction,x
	jsr SFX_BombLaunch
*	rts

	SamusPntUp:
	lda Joy1Status
	and #$08     ; UP still pressed?
	bne +	   ; branch if yes
	lda #sa_Stand   ; stand handler
	sta ObjAction
*       lda Joy1Status
	and #$07	; DOWN, LEFT, RIGHT pressed?
	beq ++	  ; branch if no
	jsr BitScan			;($E1E1)
	cmp #$02
	bcs +
	sta SamusDir
*       tax
	lda Table07,x
	sta ObjAction
*	lda Joy1Change
	ora Joy1Retrig
	asl
	bpl +	   ; branch if FIRE not pressed
	jsr FireWeapon			;($D1EE)Shoot up.
*       bit Joy1Change
	bpl +	   ; branch if JUMP not pressed
	lda #sa_PntJump
	sta ObjAction
*       lda #$04
	jsr SetSamusData		;($CD6D)Set Samus control data and animation.
	lda ObjAction
	jsr ChooseRoutine

; Pointer table to code

	.word $CF55
	.word $CC98
	.word ExitSub       ;($C45C)rts
	.word $D0B5
	.word ExitSub       ;($C45C)rts
	.word ExitSub       ;($C45C)rts
	.word $CFBE
	.word ExitSub       ;($C45C)rts
	.word ExitSub       ;($C45C)rts
	.word ExitSub       ;($C45C)rts

; Table used by above subroutine

Table07:
	.byte sa_Run
	.byte sa_Run
	.byte sa_Roll

FireWeapon:
LD1EE:  lda Joy1Status
	and #$08
	beq LD210
	jmp LD275

LD1F7:  ldy #$D0
*       lda ObjAction,y
	beq +
	jsr Yplus16
	bne -
	iny
	rts

*       sta $030A,y
	lda MissileToggle
	beq +
	cpy #$D0
*       rts

LD210:  lda MetroidOnSamus
	bne +
	jsr LD1F7
	bne +
	jsr LD2EB
	jsr LD359
	jsr LD38E
	lda #$0C
	sta $030F,y
	ldx SamusDir
	lda Table99,x   ; get bullet speed
	sta ObjHorzSpeed,y     ; -4 or 4, depending on Samus' direction
	lda #$00
	sta ObjVertSpeed,y
	lda #$01
	sta ObjectOnScreen,y
	jsr CheckMissileLaunch
	lda ObjAction,y
	asl
	ora SamusDir
	and #$03
	tax
	lda Table08,x
	sta $05
	lda #$FA
	sta $04
	jsr LD306
	lda SamusGear
	and #gr_LONGBEAM
	lsr
	lsr
	lsr
	ror
	ora $061F
	sta $061F
	ldx ObjAction,y
	dex
	bne +
	jsr SFX_BulletFire
*       ldy #$09
LD26B:  tya
	jmp SetSamusNextAnim

Table08:
	.byte $0C
	.byte $F4
	.byte $08
	.byte $F8

Table99:
	.byte $04
	.byte $FC

LD275:  lda MetroidOnSamus
	bne +
	jsr LD1F7
	bne +
	jsr LD2EB
	jsr LD38A
	jsr LD38E
	lda #$0C
	sta $030F,y
	lda #$FC
	sta ObjVertSpeed,y
	lda #$00
	sta ObjHorzSpeed,y
	lda #$01
	sta ObjectOnScreen,y
	jsr LD340
	ldx SamusDir
	lda Table09+4,x
	sta $05
	lda ObjAction,y
	and #$01
	tax
	lda Table09+6,x
	sta $04
	jsr LD306
	lda SamusGear
	and #gr_LONGBEAM
	lsr
	lsr
	lsr
	ror
	ora $061F
	sta $061F
	lda ObjAction,y
	cmp #$01
	bne +
	jsr SFX_BulletFire
*       ldx SamusDir
	ldy Table09,x
	lda SamusGravity
	beq +
	ldy Table09+2,x
*       lda ObjAction
	cmp #$01
	beq +
	jmp LD26B

; Table used by above subroutine

Table09:
	.byte $26
	.byte $26
	.byte $34
	.byte $34
	.byte $01
	.byte $FF
	.byte $EC
	.byte $F0

LD2EB:  tya
	tax
	inc ObjAction,x
	lda #$02
	sta ObjRadY,y
	sta ObjRadX,y
	lda #an_Bullet

SetProjectileAnim:
LD2FA:	sta AnimResetIndex,x
	sta AnimIndex,x
	lda #$00
	sta AnimDelay,x
*       rts

LD306:  ldx #$00
	jsr LE8BE
	tya
	tax
	jsr LFD8F
	txa
	tay
	jmp LD638

CheckMissileLaunch:
	lda MissileToggle
	beq Exit4       ; exit if Samus not in "missile fire" mode
	cpy #$D0
	bne Exit4
	ldx SamusDir
	lda MissileAnims,x
*       jsr SetBulletAnim
	jsr SFX_MissileLaunch
	lda #wa_Missile	; missile handler
	sta ObjAction,y
	lda #$FF
	sta $030F,y     ; # of frames projectile should last
	dec MissileCount
	bne Exit4       ; exit if not the last missile
; Samus has no more missiles left
	dec MissileToggle       ; put Samus in "regular fire" mode
	jmp SelectSamusPal      ; update Samus' palette to reflect this

MissileAnims:
	.byte an_MissileRight
	.byte an_MissileLeft

LD340:  lda MissileToggle
	beq Exit4
	cpy #$D0
	bne Exit4
	lda #$8F
	bne -

SetBulletAnim:
	sta AnimIndex,y
	sta AnimResetIndex,y
	lda #$00
	sta AnimDelay,y
Exit4:  rts

LD359:  lda SamusDir
*       sta $0502,y
	bit SamusGear
	bvc Exit4       ; branch if Samus doesn't have Wave Beam
	lda MissileToggle
	bne Exit4
	lda #$00
	sta $0501,y
	sta $0304,y
	tya
	jsr Adiv32      ; / 32
	lda #$00
	bcs +
	lda #$0C
*       sta $0500,y
	lda #wa_WaveBeam
	sta ObjAction,y
	lda #an_WaveBeam
	jsr SetBulletAnim
	jmp SFX_WaveFire

LD38A:  lda #$02
	bne --
LD38E:  lda MissileToggle
	bne Exit4
	lda SamusGear
	bpl Exit4       ; branch if Samus doesn't have Ice Beam
	lda #wa_IceBeam
	sta ObjAction,y
	lda $061F
	ora #$01
	sta $061F
	jmp SFX_BulletFire

; SamusDoor
; =========

SamusDoor:
	lda DoorStatus
	cmp #$05
	bcc +++++++
    ; move Samus out of door, how far depends on initial value of DoorDelay
	dec DoorDelay
	bne MoveOutDoor
    ; done moving
	asl
	bcc +
	lsr
	sta DoorStatus
	bne +++++++
*       jsr LD48C
	jsr LED65
	jsr $95AB
	lda ItemRoomMusicStatus
	beq ++
	pha
	jsr LD92C       ; start music
	pla
	bpl ++
	lda #$00
	sta ItemRoomMusicStatus
	beq ++
*       lda #$80
	sta ItemRoomMusicStatus
*       lda KraidRidleyPresent
	beq +
	jsr LCC07
	lda #$00
	sta KraidRidleyPresent
	beq --	   ; branch always
*       lda SamusDoorData
	and #$0F
	sta ObjAction
	lda #$00
	sta SamusDoorData
	sta DoorStatus
	jsr StopVertMovement		;($D147)

MoveOutDoor:
	lda SamusDoorDir
	beq ++	  ; branch if door leads to the right
	ldy ObjectX
	bne +
	jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
*       dec ObjectX
	jmp ++

*	inc ObjectX
	bne +
	jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
*	jsr CheckHealthStatus		;($CDFA)Check if Samus hit, blinking or Health low.
	jsr SetmirrorCntrlBit
	jmp DrawFrame       ; display Samus

SamusDead:
D41A:	lda #$01
	jmp SetSamusData		;($CD6D)Set Samus control data and animation.

SamusDead2:
	dec AnimDelay
	rts

; SamusElevator
; =============

SamusElevator:
	lda ElevatorStatus
	cmp #$03
	beq +
	cmp #$08
	bne +++++++
*       lda $032F
	bmi +++
	lda ObjectY
	sec
	sbc ScrollY     ; A = Samus' Y position on the visual screen
	cmp #$84
	bcc +	   ; if ScreenY < $84, don't scroll
	jsr ScrollDown  ; otherwise, attempt to scroll
*       ldy ObjectY
	cpy #239	; wrap-around required?
	bne +
	jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
	ldy #$FF	; ObjectY will now be 0
*       iny
	sty ObjectY
	jmp LD47E

*	lda ObjectY
	sec
	sbc ScrollY     ; A = Samus' Y position on the visual screen
	cmp #$64
	bcs +	   ; if ScreenY >= $64, don't scroll
	jsr ScrollUp    ; otherwise, attempt to scroll
*       ldy ObjectY
	bne +	   ; wraparound required? (branch if not)
	jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
	ldy #240	; ObjectY will now be 239
*       dey
	sty ObjectY
	jmp LD47E

*	ldy #$00
	sty ObjVertSpeed
	cmp #$05
	beq +
	cmp #$07
	beq +
LD47E:  lda FrameCount
	lsr
	bcc ++
*       jsr SetmirrorCntrlBit		;($CD92)Mirror Samus, if necessary.
	lda #$01
	jmp AnimDrawObject
*	rts

LD48C:  ldx #$60
	sec
*       jsr LD4B4
	txa
	sbc #$20
	tax
	bpl -
	jsr GetNameTable		;($EB85)
	tay
	ldx #$18
*       jsr LD4A8
	txa
	sec
	sbc #$08
	tax
	bne -
LD4A8:  tya
	cmp $072C,x
	bne +
	lda #$FF
	sta $0728,x
*       rts

LD4B4:	lda $0405,x
LD4B7:	and #$02
LD4B9:	bne +
LD4BB:	sta EnStatus,x
LD4BE:*	rts

; UpdateProjectiles
; =================

UpdateProjectiles:
	ldx #$D0
jsr DoOneProjectile
	ldx #$E0
jsr DoOneProjectile
	ldx #$F0
DoOneProjectile:
	stx PageIndex
	lda ObjAction,x
LD4D0:	jsr ChooseRoutine

LD4D3:	.word ExitSub     ;($C45C) rts
LD4D5:	.word UpdateBullet ; regular beam
	.word UpdateWaveBullet      ; wave beam
	.word UpdateIceBullet       ; ice beam
	.word BulletExplode    ; bullet/missile explode
	.word $D65E       ; lay bomb
	.word $D670       ; lay bomb
	.word $D691       ; lay bomb
	.word $D65E       ; lay bomb
	.word $D670       ; bomb countdown
	.word $D691       ; bomb explode
	.word UpdateBullet  ; missile

UpdateBullet:
	lda #$01
	sta UpdatingProjectile
	jsr LD5FC
	jsr LD5DA
	jsr LD609
CheckBulletStat:
	ldx PageIndex
	bcc +
	lda SamusGear
	and #gr_LONGBEAM
	bne DrawBullet  ; branch if Samus has Long Beam
	dec $030F,x     ; decrement bullet timer
	bne DrawBullet
	lda #$00	; timer hit 0, kill bullet
	sta ObjAction,x
	beq DrawBullet  ; branch always
*       lda ObjAction,x
	beq +
	jsr LD5E4
DrawBullet:
	lda #$01
	jsr AnimDrawObject
*       dec UpdatingProjectile
	rts

*       inc $0500,x
LD522:  inc $0500,x
	lda #$00
	sta $0501,x
	beq +	   ; branch always

UpdateWaveBullet:
	lda #$01
	sta UpdatingProjectile
	jsr LD5FC
	jsr LD5DA
	lda $0502,x
	and #$FE
	tay
	lda Table0A,y
	sta $0A
	lda Table0A+1,y
	sta $0B
*       ldy $0500,x
	lda ($0A),y
	cmp #$FF
	bne +
	sta $0500,x
	jmp LD522

*       cmp $0501,x
	beq ---
	inc $0501,x
	iny
	lda ($0A),y
	jsr $8296
	ldx PageIndex
	sta ObjVertSpeed,x
	lda ($0A),y
	jsr $832F
	ldx PageIndex
	sta ObjHorzSpeed,x
	tay
	lda $0502,x
	lsr
	bcc +
	tya
	jsr TwosCompliment		;($C3D4)
	sta ObjHorzSpeed,x
*       jsr LD609
	bcs +
	jsr LD624
*       jmp CheckBulletStat

Table0A:
	.word Table0C     ; pointer to table #1 below
	.word Table0D     ; pointer to table #2 below

; Table #1 (size: 25 bytes)

Table0C:
	.byte $01
	.byte $F3
	.byte $01
	.byte $D3
	.byte $01
	.byte $93
	.byte $01
	.byte $13
	.byte $01
	.byte $53
	.byte $01
	.byte $73
	.byte $01
	.byte $73
	.byte $01
	.byte $53
	.byte $01
	.byte $13
	.byte $01
	.byte $93
	.byte $01
	.byte $D3
	.byte $01
	.byte $F3
	.byte $FF

; Table #2 (size: 25 bytes)

Table0D:
	.byte $01
	.byte $B7
	.byte $01
	.byte $B5
	.byte $01
	.byte $B1
	.byte $01
	.byte $B9
	.byte $01
	.byte $BD
	.byte $01
	.byte $BF
	.byte $01
	.byte $BF
	.byte $01
	.byte $BD
	.byte $01
	.byte $B9
	.byte $01
	.byte $B1
	.byte $01
	.byte $B5
	.byte $01
	.byte $B7
	.byte $FF

; UpdateIceBullet
; ===============

	UpdateIceBullet:
	lda #$81
	sta ObjectCntrl
	jmp UpdateBullet

; BulletExplode
; =============
; bullet/missile explode

	BulletExplode:
	lda #$01
	sta UpdatingProjectile
	lda $0303,x
	sec
	sbc #$F7
	bne +
	sta ObjAction,x	 ; kill bullet
*       jmp DrawBullet

LD5DA:  lda $030A,x
	beq Exit5
	lda #$00
	sta $030A,x
LD5E4:  lda #$1D
	ldy ObjAction,x
	cpy #wa_BulletExplode
	beq Exit5
	cpy #wa_Missile
	bne +
	lda #an_MissileExplode
*       jsr SetProjectileAnim
	lda #wa_BulletExplode
*       sta ObjAction,x
Exit5:  rts

LD5FC:  lda ObjectOnScreen,x
	lsr
	bcs Exit5
*	lda #$00
	beq --	 ; branch always
*       jmp LE81E

; bullet <--> background crash detection

LD609:  jsr GetObjCoords
	ldy #$00
	lda ($04),y     ; get tile # that bullet touches
	cmp #$A0
	bcs LD624
	jsr $95C0
	cmp #$4E
	beq -
	jsr LD651
	bcc ++
	clc
	jmp IsBlastTile

LD624:  ldx PageIndex
	lda ObjHorzSpeed,x
	sta $05
	lda ObjVertSpeed,x
	sta $04
	jsr LE8BE
	jsr LFD8F
	bcc --
LD638:  lda $08
	sta ObjectY,x
	lda $09
	sta ObjectX,x
	lda $0B
	and #$01
	bpl +	   ; branch always
	ToggleObjectHi:
	lda ObjectHi,x
	eor #$01
*       sta ObjectHi,x
*	rts

LD651:  ldy InArea
	cpy #$10
	beq +
	cmp #$70
	bcs ++
*       cmp #$80
*	rts

LD65E:  lda #an_BombTick
	jsr SetProjectileAnim
	lda #$18	; fuse length :-)
	sta $030F,x
	inc ObjAction,x       ; bomb update handler
	DrawBomb:
	lda #$03
	jmp AnimDrawObject

LD670:  lda FrameCount
	lsr
	bcc ++	  ; only update counter on odd frames
	dec $030F,x
	bne ++
	lda #$37
	ldy ObjAction,x
	cpy #$09
	bne +
	lda #an_BombExplode
*       jsr SetProjectileAnim
	inc ObjAction,x
	jsr SFX_BombExplode
*	jmp DrawBomb

LD691:  inc $030F,x
	jsr LD6A7
	ldx PageIndex
	lda $0303,x
	sec
	sbc #$F7
	bne +
	sta ObjAction,x     ; kill bomb
*       jmp DrawBomb

LD6A7:  jsr GetObjCoords
	lda $04
	sta $0A
	lda $05
	sta $0B
	ldx PageIndex
	ldy $030F,x
	dey
	beq ++
	dey
	bne +++
	lda #$40
	jsr LD78B
	txa
	bne +
	lda $04
	and #$20
	beq Exit6
*       lda $05
	and #$03
	cmp #$03
	bne +
	lda $04
	cmp #$C0
	bcc +
	lda ScrollDir
	and #$02
	bne Exit6
	lda #$80
	jsr LD78B
*	jsr LD76A
Exit6:  rts

*	dey
	bne +++
	lda #$40
	jsr LD77F
	txa
	bne +
	lda $04
	and #$20
	bne Exit6
*       lda $05
	and #$03
	cmp #$03
	bne +
	lda $04
	cmp #$C0
	bcc +
	lda ScrollDir
	and #$02
	bne Exit6
	lda #$80
	jsr LD77F
*       jmp LD76A

*	dey
	bne +++
	lda #$02
	jsr LD78B
	txa
	bne +
	lda $04
	lsr
	bcc Exit7
*       lda $04
	and #$1F
	cmp #$1E
	bcc +
	lda ScrollDir
	and #$02
	beq Exit7
	lda #$1E
	jsr LD77F
	lda $05
	eor #$04
	sta $05
*       jmp LD76A

*	dey
	bne Exit7
	lda #$02
	jsr LD77F
	txa
	bne +
	lda $04
	lsr
	bcs Exit7
*       lda $04
	and #$1F
	cmp #$02
	bcs LD76A
	lda ScrollDir
	and #$02
	beq Exit7
	lda #$1E
	jsr LD78B
	lda $05
	eor #$04
	sta $05
LD76A:  txa
	pha
	ldy #$00
	lda ($04),y
	jsr LD651
	bcc +
	cmp #$A0
	bcs +
	jsr LE9C2
*       pla
	tax
Exit7:  rts

LD77F:  clc
	adc $0A
	sta $04
	lda $0B
	adc #$00
	jmp LD798

LD78B:  sta $00
	lda $0A
	sec
	sbc $00
	sta $04
	lda $0B
	sbc #$00
LD798:  and #$07
	ora #$60
	sta $05
*       rts

	GetObjCoords:
	ldx PageIndex
	lda ObjectY,x
	sta $02
	lda ObjectX,x
	sta $03
	lda ObjectHi,x
	sta $0B
	jmp MakeWRAMPtr

	UpdateElevator:
	ldx #$20
	stx PageIndex
	lda ObjAction,x
	jsr ChooseRoutine

; Pointer table to elevator handlers

	.word ExitSub       ;($C45C) rts
	.word ElevatorIdle
	.word $D80E
	.word ElevatorMove
	.word ElevatorScroll
	.word $D8A3
	.word $D8BF
	.word $D8A3
	.word ElevatorMove
	.word ElevatorStop

	ElevatorIdle:
	lda SamusOnElevator
	beq ShowElevator
	lda #$04
	bit $032F       ; elevator direction in bit 7 (1 = up)
	bpl +
	asl		; btn_UP
*       and Joy1Status
	beq ShowElevator
    ; start elevator!
	jsr StopVertMovement		;($D147)
	sty AnimDelay
	sty SamusGravity
	tya
	sta ObjVertSpeed,x
	inc ObjAction,x
	lda #sa_Elevator
	sta ObjAction
	lda #an_SamusFront
	jsr SetSamusAnim
	lda #128
	sta ObjectX     ; center
	lda #112
	sta ObjectY     ; center
	ShowElevator:
	lda FrameCount
	lsr
	bcc --	  ; only display elevator at odd frames
	jmp DrawFrame       ; display elevator

LD80E:  lda ScrollX
	bne +
	lda MirrorCntrl
	ora #$08
	sta MirrorCntrl
	lda ScrollDir
	and #$01
	sta ScrollDir
	inc ObjAction,x
	jmp ShowElevator

*       lda #$80
	sta ObjectX
	lda ObjectX,x
	sec
	sbc ScrollX
	bmi +
	jsr ScrollLeft
	jmp ShowElevator

*       jsr ScrollRight
	jmp ShowElevator

	ElevatorMove:
	lda $030F,x
	bpl ++	  ; branch if elevator going down
    ; move elevator up one pixel
	ldy ObjectY,x
	bne +
	jsr ToggleObjectHi
	ldy #240
*       dey
	tya
	sta ObjectY,x
	jmp ++

    ; move elevator down one pixel
*	inc ObjectY,x
	lda ObjectY,x
	cmp #240
	bne +
	jsr ToggleObjectHi
	lda #$00
	sta ObjectY,x
*	cmp #$83
	bne +	   ; move until Y coord = $83
	inc ObjAction,x
*       jmp ShowElevator

	ElevatorScroll:
	lda ScrollY
	bne ElevScrollRoom  ; scroll until ScrollY = 0
	lda #$4E
	sta AnimResetIndex
	lda #$41
	sta AnimIndex
	lda #$5D
	sta AnimResetIndex,x
	lda #$50
	sta AnimIndex,x
	inc ObjAction,x
	lda #$40
	sta Timer1
	jmp ShowElevator

	ElevScrollRoom:
	lda $030F,x
	bpl +	   ; branch if elevator going down
	jsr ScrollUp
	jmp ShowElevator

*       jsr ScrollDown
	jmp ShowElevator

LD8A3:  inc ObjAction,x
	lda ObjAction,x
	cmp #$08	; ElevatorMove
	bne +
	lda #$23
	sta $0303,x
	lda #an_SamusFront
	jsr SetSamusAnim
	jmp ShowElevator

*       lda #$01
	jmp AnimDrawObject

LD8BF:  lda $030F,x
	tay
	cmp #$8F	; Leads-To-Ending elevator?
	bne +
    ; Samus made it! YAY!
	lda #$07
	sta MainRoutine
	inc AtEnding
	ldy #$00
	sty $33
	iny
	sty SwitchPending   ; switch to bank 0
	lda #$1D	; ending
	sta TitleRoutine
	rts

*       tya
	bpl ++
	ldy #$00
	cmp #$84
	bne +
	iny
*       tya
*	ora #$10
	jsr LCA18
	lda PalToggle
	eor #$07
	sta PalToggle
	ldy InArea
	cpy #$12
	bcc +
	lda #$01
*       sta PalDataPending
	jsr WaitNMIPass_
	jsr SelectSamusPal
	jsr StartMusic			;($LD92C)Start music.
	jsr ScreenOn
	jsr CopyPtrs
	jsr DestroyEnemies
	ldx #$20
	stx PageIndex
	lda #$6B
	sta AnimResetIndex
	lda #$5F
	sta AnimIndex
	lda #$7A
	sta AnimResetIndex,x
	lda #$6E
	sta AnimIndex,x
	inc ObjAction,x
	lda #$40
	sta Timer1
	rts

StartMusic:
LD92C:	lda ElevatorStatus
	cmp #$06
	bne +
	lda $032F
	bmi ++
*       lda $95CD			;Load proper bit flag for area music.
	ldy ItemRoomMusicStatus
	bmi ++
	beq ++
*	lda #$81
	sta ItemRoomMusicStatus
	lda #$20			;Set flag to play item room music.

*	ora MusicInitFlag		;
	sta MusicInitFlag		;Store music flag info.
	rts				;

ElevatorStop:
	lda ScrollY
	bne ++	  ; scroll until ScrollY = 0
	lda #sa_Stand
	sta ObjAction
	jsr LCF55
	ldx PageIndex   ; #$20
	lda #$01	; ElevatorIdle
	sta ObjAction,x
	lda $030F,x
	eor #$80	; switch elevator direction
	sta $030F,x
	bmi +
	jsr ToggleScroll
	sta MirrorCntrl
*       jmp ShowElevator
*	jmp ElevScrollRoom

SamusOnElevatorOrEnemy:
LD976:  lda #$00			;
	sta SamusOnElevator		;Assume Samus is not on an elevator or on a frozen enemy.
	sta OnFrozenEnemy		;
	tay
	ldx #$50
	jsr LF186
*       lda EnStatus,x
	cmp #$04
	bne +
	jsr LF152
	jsr LF1BF
	jsr LF1FA
	bcs +
	jsr LD9BA
	bne +
D99A:	inc OnFrozenEnemy		;Samus is standing on a frozen enemy.
	bne ++
*       jsr Xminus16
	bpl --
*	lda ElevatorStatus
	beq +
	ldy #$00
	ldx #$20
	jsr LDC82
	bcs +
	jsr LD9BA
	bne +
	inc SamusOnElevator		;Samus is standing on elevator.
*       rts

LD9BA:  lda $10
	and #$02
	bne +
	ldy $11
	iny
	cpy $04
	beq Exit8
*       lda SamusHit
	and #$38
	ora $10
	ora #$40
	sta SamusHit
Exit8:  rts

; UpdateStatues
; =============

	UpdateStatues:
	lda #$60
	sta PageIndex
	ldy $0360
	beq Exit8	   ; exit if no statue present
	dey
	bne +
	jsr LDAB0
	ldy #$01
	jsr LDAB0
	bcs +
	inc $0360
*       ldy $0360
	cpy #$02
	bne +++
	lda KraidStatueStatus
	bpl +
	ldy #$02
	jsr LDAB0
*       lda $687C
	bpl +
	ldy #$03
	jsr LDAB0
*       bcs +
	inc $0360
*	ldx #$60
	jsr LDA1A
	ldx #$61
	jsr LDA1A
	jmp LDADA

LDA1A:  jsr LDA3D
	jsr LDA7C
	txa
	and #$01
	tay
	lda LDA3B,y
	sta $0363
	lda $681B,x
	beq +
	bmi +
	lda FrameCount
	lsr
	bcc ++	  ; only display statue at odd frames
*       jmp DrawFrame       ; display statue

LDA39:  .byte $88
	.byte $68
LDA3B:  .byte $65
	.byte $66

LDA3D:  lda $0304,x
	bmi +
	lda #$01
	sta $0304,x
	lda $030F,x
	and #$0F
	beq +
	inc $0304,x
	dec $030F,x
	lda $030F,x
	and #$0F
	bne +
	lda $0304,x
	ora #$80
	sta $0304,x
	sta $681B,x
	inc $0304,x
	txa
	pha
	and #$01
	pha
	tay
	jsr LDAB0
	pla
	tay
	iny
	iny
	jsr LDAB0
	pla
	tax
*	rts

LDA7C:  lda $030F,x
	sta $036D
	txa
	and #$01
	tay
	lda LDA39,y
	sta $036E
	lda $681B,x
	beq +
	bmi +
	lda $0304,x
	cmp #$01
	bne +
	lda $0306,x
	beq +
	dec $030F,x
	lda $0683
	ora #$10
	sta $0683
*       lda #$00
	sta $0306,x
	rts

LDAB0:  lda Table0E,y
	sta $05C8
	lda $036C
	asl
	asl
	ora Table1B,y
	sta $05C9
	lda #$09
	sta $05C3
	lda #$C0
	sta PageIndex
	jsr DrawTileBlast
	lda #$60
	sta PageIndex
	rts

; Table used by above subroutine

Table0E:
	.byte $30
	.byte $AC
	.byte $F0
	.byte $6C
Table1B:
	.byte $61
	.byte $60
	.byte $60
	.byte $60

LDADA:  lda $54
	bmi Exit0
	lda DoorStatus
	bne Exit0
	lda KraidStatueStatus
	and $687C
	bpl Exit0
	sta $54
	ldx #$70
	ldy #$08
*       lda #$03
	sta $0500,x
	tya
	asl
	sta $0507,x
	lda #$04
	sta TileType,x
	lda $036C
	asl
	asl
	ora #$62
	sta TileWRAMHi,x
	tya
	asl
	adc #$08
	sta TileWRAMLo,x
	jsr Xminus16
	dey
	bne -
Exit0:  rts

; CheckMissileToggle
; ==================
; Toggles between bullets/missiles (if Samus has any missiles).

	CheckMissileToggle:
	lda MissileCount
	beq Exit0       ; exit if Samus has no missiles
	lda Joy1Change
	ora Joy1Retrig
	and #$20	
	beq Exit0       ; exit if SELECT not pressed
	lda MissileToggle
	eor #$01	; 0 = fire bullets, 1 = fire missiles
	sta MissileToggle
	jmp SelectSamusPal

; MakeBitMask
; ===========
; in: Y = bit index
; out: A = bit Y set, other 7 bits zero

	MakeBitMask:
	sec
	lda #$00
*       rol
	dey
	bpl -
*       rts

; UpdateItems
; ===========

UpdateItems:
	lda #$40
	sta PageIndex
	ldx #$00			;Check first item slot.
	jsr CheckOneItem		;($DB42)Check current item slot.
	ldx #$08			;Check second item slot.

CheckOneItem:
LDB42:	stx ItemIndex			;First or second item slot index(#$00 or #$08).
	ldy PowerUpType,x		;
	iny				;Is no item present in item slot(#$FF)?-->
	beq -				;If so, branch to exit.

	lda PowerUpYCoord,x
	sta $034D
	lda PowerUpXCoord,x
	sta $034E
	lda PowerUpNameTable,x
	sta $034C
	jsr GetObjCoords
	ldx ItemIndex
	ldy #$00
	lda ($04),y
	cmp #$A0
	bcc -
	lda PowerUpType,x
	and #$0F
	ora #$50
	sta $0343
	lda FrameCount
	lsr
	and #$03
	ora #$80
	sta ObjectCntrl
	lda SpritePagePos
	pha
	lda $074F,x
	jsr DrawFrame       ; display special item
	pla
	cmp SpritePagePos
	beq Exit9
	tax
	ldy ItemIndex
	lda PowerUpType,y
	ldy #$01
	cmp #$07
	beq +
	dey
	cmp #$06
	beq +
	cmp #$02
	bne ++
*       tya
	sta Sprite01RAM+2,x
	lda #$FF
*	pha
	ldx #$00
	ldy #$40
	jsr LDC7F
	pla
	bcs Exit9
	tay
	jsr PowerUpMusic
	ldx ItemIndex
	iny
	beq +
	lda PowerUpNameTable,x
	sta $08
	lda PowerUpType,x
	sta $09
	jsr LDC1C
*       lda PowerUpType,x
	tay
	cpy #$08
	bcs ++++
	cpy #$06
	bcc +
	lda SamusGear
	and #$3F
	sta SamusGear
*       jsr MakeBitMask
	ora SamusGear
	sta SamusGear
*       lda #$FF
	sta PowerUpDelay
	sta PowerUpType,x
	ldy ItemRoomMusicStatus
	beq +
	ldy #$01
*       sty ItemRoomMusicStatus
	jmp SelectSamusPal
Exit9:  rts

*	beq +
	lda #5
	jsr AddToMaxMissiles
	bne ---	   ; branch always
*       lda TankCount
	cmp #$06	; has Samus got 6 energy tanks?
	beq +	   ; then she can't have any more
	inc TankCount   ; otherwise give her a new tank
*       lda TankCount
	jsr Amul16      ; shift into upper nibble
	ora #$09
	sta HealthHi
	lda #$99
	sta HealthLo    ; health is now FULL!
	bne -----	   ; branch always

LDC1C:  lda MapPosX
	sta $07
	lda MapPosY
	sta $06
	lda ScrollDir
	lsr
	php
	beq +
	bcc ++
	lda ScrollX
	beq ++
	dec $07
	bcs ++
*	bcc +
	lda ScrollY
	beq +
	dec $06
*       lda PPUCNT0ZP
	eor $08
	and #$01
	plp
	clc
	beq +
	adc $07
	sta $07
	jmp LDC51

*       adc $06
	sta $06
LDC51:  jsr CreateItemID		;($DC67)
LDC54:  ldy NumberOfUniqueItems
	lda $06
	sta UniqueItemHistory,y
	lda $07
	sta UniqueItemHistory+1,y
	iny
	iny
	sty NumberOfUniqueItems
	rts

;------------------------------------------[ Create item ID ]-----------------------------------------

;The following routine creates a unique two byte item ID number for that item.  The description
;of the format of the item ID number is as follows:
;
;IIIIIIXX XXXYYYYY. I = item type, X = X coordinate on world map, Y = Y coordinate
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
;
;The results are stored in $06(upper byte) and $07(lower byte).

CreateItemID:
LDC67:	lda $07				;Load x map position of item.
LDC69:	jsr Amul32			;($C2C$)*32. Move lower 3 bytes to upper 3 bytes.
LDC6C:	ora $06				;combine Y coordinates into data byte.
LDC6E:	sta $06				;Lower data byte complete. Save in $06.
LDC70:	lsr $07				;
LDC72:	lsr $07				;Move upper two bits of X coordinate to LSBs.
LDC74:	lsr $07				;
LDC76:	lda $09				;Load item type bits.
LDC78:	asl				;Move the 6 bits of item type to upper 6 bits of byte.
LDC79:	asl				;
LDC7A:	ora $07				;Add upper two bits of X coordinate to byte.
LDC7C:	sta $07				;Upper data byte complete. Save in #$06.
LDC7E:	rts				;

;-----------------------------------------------------------------------------------------------------

LDC7F:  jsr LF186
LDC82:  jsr LF172
LDC85:	jsr LF1A7
LDC88:	jmp LF1FA

;The following table is used to rotate the sprites of both Samus and enemies when they explode.

ExplodeRotationTbl:
LDC8B:	.byte $00			;No sprite flipping.
LDC8C:	.byte $80			;Flip sprite vertically.
LDC8D:	.byte $C0			;Flip sprite vertically and horizontally.
LDC8E:	.byte $40			;Flip sprite horizontally.

; UpdateObjAnim
; =============
; Advance to object's next frame of animation

UpdateObjAnim:
LDC8F:	ldx PageIndex
	ldy AnimDelay,x
	beq +	   ; is it time to advance to the next anim frame?
	dec AnimDelay,x     ; nope
	bne +++	  ; exit if still not zero (don't update animation)
*       sta AnimDelay,x     ; set initial anim countdown value
	ldy AnimIndex,x
*       lda ObjectAnimIndexTbl,y		;($8572)Load frame number.
	cmp #$FF	; has end of anim been reached?
	beq ++
	sta AnimFrame,x     ; store frame number
	iny	     ; inc anim index
	tya
	sta AnimIndex,x     ; store anim index
*	rts

*       ldy AnimResetIndex,x     ; reset anim frame index
	jmp ---	   ; do first frame of animation

LDCB7:  pha
	lda #$00
	sta $06
	pla
	bpl +
	dec $06
*       clc
	rts

;--------------------------------[ Get sprite control byte ]-----------------------------------------

;The sprite control byte extracted from the frame data has the following format: AABBXXXX.
;Where AA are the two bits used to control the horizontal and verticle mirroring of the
;sprite and BB are the two bits used control the sprite colors. XXXX is the entry number
;in the PlacePtrTbl used to place the sprite on the screen.

GetSpriteCntrlData:
LDCC3:  ldy #$00			;
LDCC5:	sty $0F				;Clear index into placement data.
LDCC7:	lda ($00),y			;Load control byte from frame pointer data.
LDCC9:	sta $04				;Store value in $04 for processing below.
LDCCB:	tax				;Keep a copy of the value in x as well.
LDCCC:	jsr Adiv16			;($C2BF)Move upper 4 bits to lower 4 bits.
LDCCF:	and #$03			;
LDCD1:	sta $05				;The following lines take the upper 4 bits in the-->
LDCD3:	txa				;control byte and transfer bits 4 and 5 into $05 bits 0-->
LDCD4:	and #$C0			;and 1(sprite color bits).  Bits 6 and 7 are-->
LDCD6:	ora #$20			;transferred into $05 bits 6 and 7(sprite flip bits).-->
LDCD8:	ora $05				;bit 5 is then set(sprite always drawn behind background).
LDCDA:	sta $05				;
LDCDC:	lda ObjectCntrl			;Extract bit from control byte that controls the
LDCDE:	and #$10			;object mirroring.
LDCE0:	asl				;
LDCE1:	asl				;
LDCE2:	eor $04				;Move it to the bit 6 position and use it to flip the-->
LDCE4:	sta $04				;horizontal mirroring of the sprite if set.
LDCE6:	lda ObjectCntrl			;
LDCE8:	bpl +				;If MSB is set in ObjectCntrl, use its flip bits(6 and 7).
LDCEA:	asl ObjectCntrl			;
LDCEC:	jsr SpriteFlipBitsOveride	;($E038)Use object flip bits as priority over sprite flip bits. 
LDCEF:*	txa				;Discard upper nibble so only entry number into-->
LDCF0:	and #$0F			;PlacePtrTbl remains.
LDCF2:	asl				;*2. pointers in PlacePntrTbl are 2 bytes in size.
LDCF3:	tax				;Transfer to X to use as an index to find proper-->
LDCF4:	rts				;placement data segment.

;-----------------------------------------------------------------------------------------------------

LDCF5:  jsr ClearObjectCntrl		;($DF2D)Clear object control byte.
	pla
	pla
	ldx PageIndex
LDCFC:  lda InArea
	cmp #$13
	bne +
	lda EnDataIndex,x
	cmp #$04
	beq +++++
	cmp #$02
	beq +++++
*       lda $040C,x
	asl
	bmi LDD75
	jsr LF74B
	sta $00
	jsr $80B0
	and #$20
	sta EnDataIndex,x
	lda #$05
	sta EnStatus,x
	lda #$60
	sta $040D,x
	lda RandomNumber1
	cmp #$10
	bcc LDD5B
*	and #$07
	tay
	lda ItemDropTbl,y
	sta EnAnimFrame,x
	cmp #$80
	bne ++
	ldy MaxMissilePickup
	cpy CurrentMissilePickups
	beq LDD5B
	lda MaxMissiles
	beq LDD5B
	inc CurrentMissilePickups
*       rts

*       ldy MaxEnergyPickup
	cpy CurrentEnergyPickups
	beq LDD5B
	inc CurrentEnergyPickups
	cmp #$89
	bne --
	lsr $00
	bcs --

LDD5B:  ldx PageIndex
	lda InArea
	cmp #$13
	beq ++
*	jmp KillObject			;($FA18)Free enemy data slot.

*       lda RandomNumber1
	ldy #$00
	sty CurrentEnergyPickups
	sty CurrentMissilePickups
	iny
	sty MaxMissilePickup
	sty MaxEnergyPickup
	bne -----

LDD75:  jsr PowerUpMusic
	lda InArea
	and #$0F
	sta MiniBossKillDelay
	lsr
	tay
	sta MaxMissiles,y
	lda #75
	jsr AddToMaxMissiles
	bne LDD5B

LDD8B:  ldx PageIndex
	lda EnAnimFrame,x
	cmp #$F7
	bne +++
	jmp ClearObjectCntrl		;($DF2D)Clear object control byte.

; AddToMaxMissiles
; ================
; Adds A to both MissileCount & MaxMissiles, storing the new count
; (255 if it overflows)

AddToMaxMissiles:
	pha				;Temp storage of # of missiles to add.
	clc
	adc MissileCount
	bcc +
	lda #$FF
*       sta MissileCount
	pla
	clc
	adc MaxMissiles
	bcc +
	lda #$FF
*       sta MaxMissiles
	rts

*	lda EnYRoomPos,x
	sta $0A	 ; Y coord
	lda EnXRoomPos,x
	sta $0B	 ; X coord
	lda EnNameTable,x
	sta $06	 ; hi coord
	lda EnAnimFrame,x
	asl
	tay
	lda ($41),y
	bcc +
	lda ($43),y
*       sta $00
	iny
	lda ($41),y
	bcc +
	lda ($43),y
*       sta $01
	jsr GetSpriteCntrlData		;($DCC3)Get place pointer index and sprite control data.
	tay
	lda ($45),y
	sta $02
	iny
	lda ($45),y
	sta $03
	ldy #$00
	cpx #$02
	bne +
	ldx PageIndex
	inc EnCounter,x
	lda EnCounter,x
	pha
	and #$03
	tax
	lda $05
	and #$3F
	ora ExplodeRotationTbl,x
	sta $05
	pla
	cmp #$19
	bne +
	jmp LDCF5

*       ldx PageIndex
	iny
	lda ($00),y
	sta EnRadY,x
	jsr ReduceYRadius		;($DE3D)Reduce temp y radius by #$10.
	iny
	lda ($00),y
	sta EnRadX,x
	sta $09
	iny
	sty $11
	jsr IsObjectVisible		;($DFDF)Determine if object is within screen boundaries.
	txa
	asl
	sta $08
	ldx PageIndex
	lda $0405,x
	and #$FD
	ora $08
	sta $0405,x
	lda $08
	beq ++
	jmp LDEDE

;----------------------------------------[ Item drop table ]-----------------------------------------

;The following table determines what, if any, items an enemy will drop when it is killed.

ItemDropTbl:
LDE35:	.byte $80			;Missile.
LDE36:	.byte $81			;Energy.
LDE37:	.byte $89			;No item.
LDE38:	.byte $80			;Missile.
LDE39:	.byte $81			;Energy.
LDE3A:	.byte $89			;No item.
LDE3B:	.byte $81			;Energy.
LDE3C:	.byte $89			;No item.

;------------------------------------[ Object drawing routines ]-------------------------------------

;The following function effectively sets an object's temporary y radius to #$00 if the object
;is 4 tiles tall or less.  If it is taller, #$10 is subtracted from the temporary y radius.

ReduceYRadius:
LDE3D:	sec				;
LDE3E:	sbc #$10			;Subtract #$10 from object y radius.
LDE40:	bcs +				;If number is still a positive number, branch to store value.
LDE42:	lda #$00			;Number is negative.  Set Y radius to #$00.
LDE44:*	sta $08				;Store result and return.
LDE46:	rts				;

AnimDrawObject:
LDE47:	jsr UpdateObjAnim		;($DC8F)Update animation if needed.

DrawFrame:
LDE4A:	ldx PageIndex			;Get index to proper object to work with.
LDE4C:	lda AnimFrame,x			;
LDE4F:	cmp #$F7			;Is the frame valid?-->
LDE51:	bne ++				;Branch if yes.
LDE53:*	jmp ClearObjectCntrl		;($DF2D)Clear object control byte.
LDE56:*	cmp #$07			;Is the animation of Samus facing forward?-->
LDE58:	bne +				;If not, branch.

LDE5A:	lda ObjectCntrl			;Ensure object mirroring bit is clear so Samus'-->
LDE5C:	and #$EF			;sprite appears properly when going up and down-->
LDE5E:	sta ObjectCntrl			;elevators.

LDE60:*	lda ObjectY,x			;
LDE63:	sta $0A				;
LDE65:	lda ObjectX,x			;Copy object y and x room position and name table-->
LDE68:	sta $0B				;data into $0A, $0B and $06 respectively.
LDE6A:	lda ObjectHi,x			;
LDE6D:	sta $06				;
LDE6F:	lda AnimFrame,x			;Load A with index into FramePtrTable.
LDE72:	asl				;*2. Frame pointers are two bytes.
LDE73:	tax				;X is now the index into the FramePtrTable.
LDE74:	lda FramePtrTable,x		;
LDE77:	sta $00				;
LDE79:	lda FramePtrTable+1,x		;Entry from FramePtrTable is stored in $0000.
LDE7C:	sta $01				;
LDE7E:	jsr GetSpriteCntrlData		;($DCC3)Get place pointer index and sprite control data.
LDE81:	lda PlacePtrTable,x		;
LDE84:	sta $02				;
LDE86:	lda PlacePtrTable+1,x		;Store pointer from PlacePtrTbl in $0002.
LDE89:	sta $03				;
LDE8B:	lda IsSamus			;Is Samus the object being drawn?-->
LDE8D:	beq +				;If not, branch.

;Special case for Samus exploding.
LDE8F:	cpx #$0E			;Is Samus exploding?-->
LDE91:	bne +				;If not, branch to skip this section of code.
LDE93:	ldx PageIndex			;X=0.
LDE95:	inc ObjectCounter		;Incremented every frame during explode sequence.-->
LDE97:	lda ObjectCounter		;Bottom two bits used for index into ExplodeRotationTbl.
LDE99:	pha				;Save value of A.
LDE9A:	and #$03			;Use 2 LSBs for index into ExplodeRotationTbl.
LDE9C:	tax				;
LDE9D:	lda $05				;Drop mirror control bits from sprite control byte.
LDE9F:	and #$3F			;
LDEA1:	ora ExplodeRotationTbl,x	;Use mirror control bytes from table(Base is $DC8B).
LDEA4:	sta $05				;Save modified sprite control byte.
LDEA6:	pla				;Restore A
LDEA7:	cmp #$19			;After 25 frames, Move on to second part of death--> 
LDEA9:	bne +				;handler, else branch to skip the rest of this code.
LDEAB:	ldx PageIndex			;X=0.
LDEAD:	lda #sa_Dead2			;
LDEAF:	sta ObjAction,x			;Move to next part of the death handler.
LDEB2:	lda #$28			;
LDEB4:	sta AnimDelay,x			;Set animation delay for 40 frames(.667 seconds).
LDEB7:	pla				;Pull last return address off of the stack.
LDEB8:	pla				;
LDEB9:	jmp ClearObjectCntrl		;($DF2D)Clear object control byte.

LDEBC:*	ldx PageIndex			;
LDEBE:	iny				;Increment to second frame data byte.
LDEBF:	lda ($00),y			;
LDEC1:	sta ObjRadY,x			;Get verticle radius in pixles of object.
LDEC3:	jsr ReduceYRadius		;($DE3D)Reduce temp y radius by #$10.
LDEC6:	iny				;Increment to third frame data byte.
LDEC7:	lda ($00),y			;Get horizontal radius in pixels of object.
LDEC9:	sta ObjRadX,x			;
LDECB:	sta $09				;Temp storage for object x radius.
LDECD:	iny				;Set index to 4th byte of frame data.
LDECE:	sty $11				;Store current index into frame data.
LDED0:	jsr IsObjectVisible		;($DFDF)Determine if object is within the screen boundaries.
LDED3:	txa				;
LDED4:	ldx PageIndex			;Get index to object.
LDED6:	sta ObjectOnScreen,x		;Store visibility status of object.
LDEDB:	tax				;
LDEDC:	beq +				;Branch if object is not within the screen boundaries.
LDEDE:  ldx SpritePagePos		;Load index into next unused sprite RAM segment.
LDEE0:	jmp DrawSpriteObject		;($DF19)Start drawing object.

LDEE3:*	jmp ClearObjectCntrl		;($DF2D)Clear object control byte then exit.

WriteSpriteRAM:
LDEE6:*	ldy $0F				;Load index for placement data.
LDEE8:	jsr YDisplacement		;($DF6B)Get displacement for y direction.
LDEEB:	adc $10				;Add initial Y position.
LDEED:	sta Sprite00RAM,x		;Store sprite Y coord.
LDEF0:	dec Sprite00RAM,x		;Because PPU uses Y + 1 as real Y coord.
LDEF3:	inc $0F				;Increment index to next byte of placement data.
LDEF5:	ldy $11				;Get index to frame data.
LDEF7:	lda ($00),y			;Tile value.
LDEF9:	sta Sprite00RAM+1,x		;Store tile value in sprite RAM.
LDEFC:	lda ObjectCntrl			;
LDEFE:	asl				;Move horizontal mirror control byte to bit 6 and-->
LDEFF:	asl				;discard all other bits.
LDF00:	and #$40			;
LDF02:	eor $05				;Use it to override sprite horz mirror bit.
LDF04:	sta Sprite00RAM+2,x		;Store sprite control byte in sprite RAM.
LDF07:	inc $11				;Increment to next byte of frame data.
LDF09:	ldy $0F				;Load index for placement data.
LDF0B:	jsr XDisplacement		;($DFA3)Get displacement for x direction.
LDF0E:	adc $0E				;Add initial X pos
LDF10:	sta Sprite00RAM+3,x		;Store sprite X coord
LDF13:	inc $0F				;Increment to next placement data byte.
LDF15:	inx				;
LDF16:	inx				;
LDF17:	inx				;Advance to next sprite.
LDF18:	inx				;

DrawSpriteObject:
LDF19:  ldy $11				;Get index into frame data.

GetNextFrameByte:
LDF1B:  lda ($00),y			;Get next frame data byte.
LDF1D:	cmp #$FC			;If byte < #$FC, byte is tile data. If >= #$FC, byte is--> 
LDF1F:	bcc WriteSpriteRAM		;frame data control info. Branch to draw sprite.
LDF21:	beq OffsetObjectPosition	;#$FC changes object's x and y position.
LDF23:	cmp #$FD			;
LDF25:	beq GetNewControlByte		;#$FD sets new control byte information for the next sprites.
LDF27:	cmp #$FE			;#$FE skips next sprite placement x and y bytes.
LDF29:	beq SkipPlacementData		;
LDF2B:	stx SpritePagePos		;Keep track of current position in sprite RAM.

ClearObjectCntrl:
LDF2D:  lda #$00			;
LDF2F:	sta ObjectCntrl			;Clear object control byte.
LDF31:	rts				;

SkipPlacementData:
LDF32:*	inc $0F				;Skip next y and x placement data bytes.
LDF34:	inc $0F				;
LDF36:	inc $11				;Increment to next data item in frame data.
LDF38:	jmp DrawSpriteObject		;($DF19)Draw next sprite.

GetNewControlByte:
LDF3B:*	iny				;Increment index to next byte of frame data.
LDF3C:	asl ObjectCntrl			;If MSB of ObjectCntrl is not set, no overriding of-->
LDF3E:	bcc +				;flip bits needs to be performed.
LDF40:	jsr SpriteFlipBitsOveride	;($E038)Use object flip bits as priority over sprite flip bits.
LDF43:	bne ++				;Branch always.
LDF45:*	lsr ObjectCntrl			;Restore MSB of ObjectCntrl.
LDF47:	lda ($00),y			;
LDF49:	sta $05				;Save new sprite control byte.
LDF4B:*	iny				;Increment past sprite control byte.
LDF4C:	sty $11				;Save index of frame data.
LDF4E:	jmp GetNextFrameByte		;($DF1B)Load next frame data byte.

OffsetObjectPosition:
LDF51:*	iny				;Increment index to next byte of frame data.
LDF52:	lda ($00),y			;This data byte is used to offset the object from-->
LDF54:	clc				;its current y positon.
LDF55:	adc $10				;
LDF57:	sta $10				;Add offset amount to object y screen position.
LDF59:	inc $11				;
LDF5B:	inc $11				;Increment past control byte and y offset byte.
LDF5D:	ldy $11				;
LDF5F:	lda ($00),y			;Load x offset data byte.
LDF61:	clc				;
LDF62:	adc $0E				;Add offset amount to object x screen position.
LDF64:	sta $0E				;
LDF66:	inc $11				;Increment past x offset byte.
LDF68:	jmp DrawSpriteObject		;($DF19)Draw next sprite.

;----------------------------------[ Sprite placement routines ]-------------------------------------

YDisplacement:
LDF6B:  lda ($02),y			;Load placement data byte.
LDF6D:	tay				;
LDF6E:	and #$F0			;Check to see if this is placement data for the object-->
LDF70:	cmp #$80			;exploding.  If so, branch.
LDF72:	beq ++				;
LDF74:	tya				;Restore placement data byte to A.
LDF75:*	bit $04				;
LDF77:	bmi NegativeDisplacement	;Branch if MSB in $04 is set(Flips object).
LDF79:	clc				;Clear carry before returning.
LDF7A:	rts				;

ExplodeYDisplace:
LDF7B:*	tya				;Transfer placement byte back into A.
LDF7C:	and #$0E			;Discard bits 7,6,5,4 and 0.
LDF7E:	lsr				;/2.
LDF7F:	tay				;
LDF80:	lda ExplodeIndexTbl,y		;Index into ExplodePlacementTbl.
LDF83:	ldy IsSamus			;
LDF85:	bne +				;Is Samus the object exploding? if so, branch.
LDF87:	ldy PageIndex			;Load index to proper enemy data.
LDF89:	adc EnCounter,y			;Increment every frame enemy is exploding. Initial=#$01.
LDF8C:	jmp ++				;Jump to load explode placement data.


;Special case for Samus exploding.
LDF8F:*	adc ObjectCounter		;Increments every frame Samus is exploding. Initial=#$01.
LDF91:*	tay				;
LDF92:	lda ExplodeIndexTbl+2,y		;Get data from ExplodePlacementTbl.
LDF95:	pha				;Save data on stack.
LDF96:	lda $0F				;Load placement data index.
LDF98:	clc				;
LDF99:	adc #$0C			;Move index forward by 12 bytes. to find y-->
LDF9B:	tay				;placement data.
LDF9C:	pla				;Restore A with ExplodePlacementTbl data.
LDF9D:	clc				;
LDF9E:	adc ($02),y			;Add table displacements with sprite placement data.
LDFA0:	jmp ----			;Branch to add y placement values to sprite coords.

XDisplacement:
LDFA3:  lda ($02),y			;Load placement data byte.
LDFA5:	tay				;
LDFA6:	and #$F0			;Check to see if this is placement data for the object-->
LDFA8:	cmp #$80			;exploding.  If so, branch.
LDFAA:	beq +++				;
LDFAC:	tya				;Restore placement data byte to A.
LDFAD:*	bit $04				;
LDFAF:	bvc +				;Branch if bit 6 cleared, else data is negative displacement.

NegativeDisplacement:
LDFB1:  eor #$FF			;
LDFB3:	sec				;NOTE:Setting carry makes solution 1 higher than expected.
LDFB4:	adc #$F8			;If flip bit is set in $04, this function flips the-->
LDFB6:*	clc				;object by using two compliment minus 8(Each sprite is-->
LDFB7:	rts				;8x8 pixels).

ExplodeXDisplace:
LDFB8:*	ldy PageIndex			;Load index to proper enemy slot.
LDFBA:	lda EnCounter,y			;Load counter value.
LDFBD:	ldy IsSamus			;Is Samus the one exploding?-->
LDFBF:	beq +				;If not, branch.
LDFC1:	lda ObjectCounter		;Load object counter if it is Samus who is exploding.
LDFC3:*	asl				;*2. Move sprite in x direction 2 pixels every frame.
LDFC4:	pha				;Store value on stack.
LDFC5:	ldy $0F				;
LDFC7:	lda ($02),y			;Load placement data byte.
LDFC9:	lsr				;
LDFCA:	bcs +				;Check if LSB is set. If not, the byte stored on stack-->
LDFCC:	pla				;Will be twos complimented and used to move sprite in-->
LDFCD:	eor #$FF			;the negative x direction.
LDFCF:	adc #$01			;
LDFD1:	pha				;
LDFD2:*	lda $0F				;Load placement data index.
LDFD4:	clc				;
LDFD5:	adc #$0C			;Move index forward by 12 bytes. to find x-->
LDFD7:	tay				;placement data.
LDFD8:	pla				;Restore A with x displacement data.
LDFD9:	clc				;
LDFDA:	adc ($02),y			;Add x displacement with sprite placement data.
LDFDC:	jmp -----			;Branch to add x placement values to sprite coords.

;---------------------------------[ Check if object is on screen ]----------------------------------

;The following set of functions determine if an object is visible on the screen.  If the object
;is visible, X-1 when the function returns, X=0 if the object is not within the boundaries of the
;current screen.  The function needs to know what nametable is currently in the PPU, what nametable
;the object is on and what the scroll offsets are. 

IsObjectVisible:
LDFDF:  ldx #$01			;Assume object is visible on screen.
LDFE1:	lda $0A				;Object Y position in room.
LDFE3:	tay				;
LDFE4:	sec				;Subtract y scroll to find sprite's y position on screen.
LDFE5:	sbc ScrollY			;
LDFE7:	sta $10				;Store result in $10.
LDFE9:	lda $0B				;Object X position in room.
LDFEB:	sec				;
LDFEC:	sbc ScrollX			;Subtract x scroll to find sprite's x position on screen.
LDFEE:	sta $0E				;Store result in $0E.
LDFF0:	lda ScrollDir			;
LDFF2:	and #$02			;Is Samus scrolling left or right?-->
LDFF4:	bne HorzScrollCheck		;($E01C)If so, branch.

VertScrollCheck:
LDFF6:	cpy ScrollY			;If object room pos is >= scrollY, set carry.
LDFF8:	lda $06				;Check if object is on different name table as current-->
LDFFA:	eor PPUCNT0ZP			;name table active in PPU.-->
LDFFC:	and #$01			;If not, branch.
LDFFE:	beq +				;
LE000:	bcs ++				;If carry is still set, sprite is not in screen boundaries.
LE002:	lda $10				;
LE004:	sbc #$0F			;Move sprite y position up 15 pixles.
LE006:	sta $10				;
LE008:	lda $09				;
LE00A:	clc				;If a portion of the object is outside the sceen-->
LE00B:	adc $10				;boundaries, treat object as if the whole thing is-->
LE00D:	cmp #$F0			;not visible.
LE00F:	bcc +++				;
LE011:	clc				;Causes next statement to branch always.
LE012:*	bcc +				;
LE014:	lda $09				;If object is on same name table as the current one in-->
LE016:	cmp $10				;the PPU, check if part of object is out of screen--> 
LE018:	bcc ++				;boundaries.  If so, branch.
LE01A:*	dex				;Sprite is not within screen boundaries. Decrement X.
LE01B:*	rts				;

HorzScrollCheck:
LE01C:  lda $06				;
LE01E:	eor PPUCNT0ZP			;Check if object is on different name table as current-->
LE020:	and #$01			;name table active in PPU.-->
LE022:	beq +				;If not, branch.
LE024:	bcs ++				;If carry is still set, sprite is not in screen boundaries.
LE026:	lda $09				;
LE028:	clc				;If a portion of the object is outside the sceen-->
LE029:	adc $0E				;boundaries, treat object as if the whole thing is-->
LE02B:	bcc +++				;not visible.
LE02D:	clc				;Causes next statement to branch always.
LE02E:*	bcc +				;
LE030:	lda $09				;If object is on same name table as the current one in-->
LE032:	cmp $0E				;the PPU, check if part of object is out of screen--> 
LE034:	bcc ++				;boundaries.  If so, branch.
LE036:*	dex				;Sprite is not within screen boundaries. Decrement X.
LE037:*	rts				;

;------------------------[ Override sprite flip bits with object flip bits ]-------------------------

;If the MSB is set in ObjectCntrl, its two upper bits that control sprite flipping take priority
;over the sprite control bits.  This function modifies the sprite control byte with any flipping
;bits found in ObjectCntrl.

SpriteFlipBitsOveride:
LE038:	lsr ObjectCntrl			;Restore MSB.
LE03A:	lda ($00),y			;Reload frame data control byte into A.
LE03C:	and #$C0			;Extract the two sprite flip bytes from theoriginal-->
LE03E:	ora ObjectCntrl			;control byte and set any additional bits from ObjectCntrl.
LE040:	sta $05				;Store modified byte to load in sprite control byte later.
LE042:	lda ObjectCntrl			;
LE044:	ora #$80			;
LE046:	sta ObjectCntrl			;Ensure MSB of object control byte remains set.
LE048:	rts				;

;--------------------------------[ Explosion placement data ]---------------------------------------

;The following table has the index values into the table after it for finding the placement data
;for an exploding object.

ExplodeIndexTbl:
LE049:	.byte $00, $18, $30

;The following table is used to produce the arcing motion of exploding objects.  It is displacement
;data for the y directions only.  The x displacement is constant.

ExplodePlacementTbl:

;Bottom sprites.
LE04C:	.byte $FC, $F8, $F4, $F0, $EE, $EC, $EA, $E8, $E7, $E6, $E6, $E5, $E5, $E4, $E4, $E3
LE05C:	.byte $E5, $E7, $E9, $EB, $EF, $F3, $F7, $FB

;Middle sprites.
LE064:	.byte $FE, $FC, $FA, $F8, $F6, $F4, $F2, $F0, $EE, $ED, $EB, $EA, $E9, $E8, $E7, $E6
LE074:	.byte $E6, $E6, $E6, $E6, $E8, $EA, $EC, $EE

;Top sprites.
LE07C:	.byte $FE, $FC, $FA, $F8, $F7, $F6, $F5, $F4, $F3, $F2, $F1, $F1, $F0, $F0, $EF, $EF
LE08C:	.byte $EF, $EF, $EF, $EF, $F0, $F0, $F1, $F2

;--------------------------------------[ Update enemy animation ]-----------------------------------

;Advance to next frame of enemy's animation. Basically the same as UpdateObjAnim, only for enemies.

UpdateEnemyAnim:
LE094:	ldx PageIndex			;Load index to desired enemy.
LE096:	ldy EnStatus,x			;
LE099:	cpy #$05			;Is enemy in the process of dying?-->
LE09B:	beq +++				;If so, branch to exit.
LE09D:	ldy EnAnimDelay,x		;
LE0A0:	beq +				;Check if current anumation frame is ready to be updated.
LE0A2:	dec EnAnimDelay,x		;Not ready to update. decrement delay timer and-->
LE0A5:	bne +++				;branch to exit.
LE0A7:*	sta EnAnimDelay,x		;Save new animation delay value.
LE0AA:	ldy EnAnimIndex,x		;Load enemy animation index.
LE0AD:*	lda (EnemyAnimPtr),y		;Get animation data.
LE0AF:	cmp #$FF			;End of animation?
LE0B1:	beq ++				;If so, branch to reset animation.
LE0B3:	sta EnAnimFrame,x		;Store current animation frame data.
LE0B6:	iny				;Increment to next animation data index.
LE0B7:	tya				;
LE0B8:	sta EnAnimIndex,x		;Save new animation index.
LE0BB:*	rts				;

LE0BC:*	ldy EnResetAnimIndex,x		;reset animation index.
LE0BF:	bcs ---				;Branch always.

;---------------------------------------[ Display status bar ]---------------------------------------

;Displays Samus' status bar components.

DisplayBar:
LE0C1:	ldy #$00			;Reset data index.
LE0C3:	lda SpritePagePos		;Load current sprite index.
LE0C5:	pha				;save sprite page pos.
LE0C6:	tax				;
LE0C7:*	lda DataDisplayTbl,y		;
LE0CA:	sta Sprite00RAM,x		;Stor contents of DataDisplayTbl in sprite RAM.
LE0CD:	inx				;
LE0CE:	iny				;
LE0CF:	cpy #$28			;10*4. At end of DataDisplayTbl? If not, loop to-->
LE0D1:	bne -				;load next byte from table.

;Display 2-digit health count.
LE0D3:	stx SpritePagePos		;Save new location in sprite RAM.
LE0D5:	pla				;Restore initial sprite page pos.
LE0D6:	tax				;
LE0D7:	lda HealthHi			;
LE0DA:	and #$0F			;Extract upper health digit.
LE0DC:	jsr SPRWriteDigit		;($E173)Display digit on screen.
LE0DF:	lda HealthLo			;
LE0E2:	jsr Adiv16			;($C2BF)Move lower health digit to 4 LSBs.
LE0E5:	jsr SPRWriteDigit		;($E173)Display digit on screen.
LE0E8:	ldy EndTimerHi			;
LE0EB:	iny				;Is Samus in escape sequence?-->
LE0EC:	bne ++				;If so, branch.
LE0EE:	ldy MaxMissiles			;
LE0F1:	beq +				;Don't show missile count if Samus has no missile containers.

;Display 3-digit missile count.
LE0F3:	lda MissileCount		;
LE0F6:	jsr HexToDec			;($E198)Convert missile hex count to decimal cout.
LE0F9:	lda $02				;Upper digit.
LE0FB:	jsr SPRWriteDigit		;($E173)Display digit on screen.
LE0FE:	lda $01				;Middle digit.
LE100:	jsr SPRWriteDigit		;($E173)Display digit on screen.
LE103:	lda $00				;Lower digit.
LE105:	jsr SPRWriteDigit		;($E173)Display digit on screen.
LE108:	bne +++				;Branch always.

;Samus has no missiles, erase missile sprite.
LE10A:*	lda #$FF			;"Blank" tile.
LE10C:	cpx #$F4			;If at last 3 sprites, branch to skip.
LE10E:	bcs ++				;
LE110:	sta Sprite03RAM+1,x		;Erase left half of missile.
LE113:	cpx #$F0			;If at last 4 sprites, branch to skip.
LE115:	bcs ++				;
LE117:	sta Sprite04RAM+1,x		;Erase right half of missile.
LE11A:	bne ++				;Branch always.

;Display 3-digit end sequence timer.
LE11C:*	lda EndTimerHi			;
LE11F:	jsr Adiv16			;($C2BF)Upper timer digit.
LE122:	jsr SPRWriteDigit		;($E173)Display digit on screen.
LE125:	lda EndTimerHi			;
LE128:	and #$0F			;Middle timer digit.
LE12A:	jsr SPRWriteDigit		;($E173)Display digit on screen.
LE12D:	lda EndTimerLo			;
LE130:	jsr Adiv16			;($C2BF)Lower timer digit.
LE133:	jsr SPRWriteDigit		;($E173)Display digit on screen.
LE136:	lda #$58			;"TI" sprite(left half of "TIME").
LE138:	sta Sprite00RAM+1,x		;
LE13B:	inc Sprite00RAM+2,x		;Change color of sprite.
LE13E:	cpx #$FC			;If at last sprite, branch to skip.
LE140:	bcs +				;
LE142:	lda #$59			;"ME" sprite(right half of "TIME").
LE144:	sta Sprite01RAM+1,x		;
LE147:	inc Sprite01RAM+2,x		;Change color of sprite.

LE14A:*	ldx SpritePagePos		;Restore initial sprite page pos.
LE14C:	lda TankCount			;
LE14F:	beq ++				;Branch to exit if Samus has no energy tanks.

;Display full/empty energy tanks.
LE151:	sta $03				;Temp store tank count.
LE153:	lda #$40			;X coord of right-most energy tank.
LE155:	sta $00				;Energy tanks are drawn from right to left.
LE157:	ldy #$6F			;"Full energy tank" tile.
LE159:	lda HealthHi			;
LE15C:	jsr Adiv16			;($C2BF)/16. A contains # of full energy tanks.
LE15F:	sta $01				;Storage of full tanks.
LE161:	bne AddTanks			;Branch if at least 1 tank is full.
LE163:	dey				;Else switch to "empty energy tank" tile.

AddTanks:
LE164:	jsr AddOneTank			;($E17B)Add energy tank to display.
LE167:	dec $01				;Any more full energy tanks left?-->
LE169:	bne +				;If so, then branch.-->
LE16B:	dey				;Otherwise, switch to "empty energy tank" tile.
LE16C:*	dec $03				;done all tanks?-->
LE16E:	bne AddTanks			;if not, loop to do another.

LE170:	stx SpritePagePos		;Store new sprite page position.
LE172:*	rts				;

;----------------------------------------[Sprite write digit ]---------------------------------------

;A=value in range 0..9. #$A0 is added to A(the number sprites begin at $A0), and the result is stored
;as the tile # for the sprite indexed by X.

SPRWriteDigit:
LE173:	ora #$A0			;#$A0 is index into pattern table for numbers.
LE175:	sta Sprite00RAM+1,x		;Store proper nametable pattern in sprite RAM.
LE178:	jmp Xplus4			;Find next sprite pattern table byte.

;----------------------------------[ Add energy tank to display ]------------------------------------

;Add energy tank to Samus' data display.

AddOneTank:
LE17B:	lda #$17			;Y coord-1.
LE17D:	sta Sprite00RAM,x		;
LE180:	tya				;Tile value.
LE181:	sta Sprite00RAM+1,x		;
LE184:	lda #$01			;Palette #.
LE186:	sta Sprite00RAM+2,x		;
LE189:	lda $00				;X coord.
LE18B:	sta Sprite00RAM+3,x		;
LE18E:	sec				;
LE18F:	sbc #$0A			;Find x coord of next energy tank.
LE191:	sta $00				;

;-----------------------------------------[ Add 4 to x ]---------------------------------------------

Xplus4:
LE193:	inx				;
LE194:	inx				;
LE195:	inx				;Add 4 to value stored in X.
LE196:	inx				;
LE197:	rts				;

;------------------------------------[ Convert hex to decimal ]--------------------------------------

;Convert 8-bit value in A to 3 decimal digits. Upper digit put in $02, middle in $01 and lower in $00.

HexToDec:
LE198:	ldy #100			;Find upper digit.
LE19A:	sty $0A				;
LE19C:	jsr GetDigit			;($E1AD)Extract hundreds digit.
LE19F:	sty $02				;Store upper digit in $02.
LE1A1:	ldy #10				;Find middle digit.
LE1A3:	sty $0A				;
LE1A5:	jsr GetDigit			;($E1AD)Extract tens digit.
LE1A8:	sty $01				;Store middle digit in $01.
LE1AA:	sta $00				;Store lower digit in $00
LE1AC:	rts				;

GetDigit:
LE1AD:	ldy #$00			;
LE1AF:	sec				;
LE1B0:*	iny				;
LE1B1:	sbc $0A				;Loop and subtract value in $0A from A until carry flag-->
LE1B3:	bcs -				;is not set.  The resulting number of loops is the decimal-->
LE1B5:	dey				;number extracted and A is the remainder.
LE1B6:	adc $0A				;
LE1B8:	rts				;

;-------------------------------------[ Status bar sprite data ]-------------------------------------

;Sprite data for Samus' data display

DataDisplayTbl:
LE1B9:	.byte $21,$A0,$01,$30		;Upper health digit.
LE1BD:	.byte $21,$A0,$01,$38		;Lower health digit.
LE1C1:	.byte $2B,$FF,$01,$28		;Upper missile digit.
LE1C5:	.byte $2B,$FF,$01,$30		;Middle missile digit.
LE1C9:	.byte $2B,$FF,$01,$38		;Lower missile digit.
LE1CD:	.byte $2B,$5E,$00,$18		;Left half of missile.
LE1D1:	.byte $2B,$5F,$00,$20		;Right half of missile.
LE1D5:	.byte $21,$76,$01,$18		;E
LE1D9:	.byte $21,$7F,$01,$20		;N
LE1DD:	.byte $21,$3A,$00,$28		;..

;-------------------------------------------[ Bit scan ]---------------------------------------------

;This function takes the value stored in A and right shifts it until a set bit is encountered.
;Once a set bit is encountered, the function exits and returns the bit number of the set bit.
;The returned value is stored in A. 

BitScan:
LE1E1:	stx $0E				;Save X.
LE1E3:	ldx #$00			;First bit is bit 0.
LE1E5:*	lsr				;Transfer bit to carry flag.
LE1E6:	bcs +				;If the shifted bit was 1, Branch out of loop.
LE1E8:	inx				;Increment X to keep of # of bits checked.
LE1E9:	cpx #$08			;Have all 8 bit been tested?-->
LE1EB:	bne -				;If not, branch to check the next bit.
LE1ED:*	txa				;Return which bit number was set.
LE1EE:	ldx $0E				;Restore X.
LE1F0:*	rts				;

;------------------------------------------[ Scroll door ]-------------------------------------------

;Scrolls the screen if Samus is inside a door.

ScrollDoor:
LE1F1:	ldx DoorStatus			;
LE1F3:	beq -				;Exit if Samus isn't in a door.
LE1F5:	dex				;
LE1F6:	bne +				;Not in right door. branch to check left door.
LE1F8:	jsr ScrollRight			;($E6D2)DoorStatus=1, scroll 1 pixel right.
LE1FB:	jmp ++				;Jump to check if door scroll is finished.

LE1FE:*	dex				;Check if in left door.
LE1FF:	bne ++				;
LE201:	jsr ScrollLeft			;($E6A7)DoorStatus=2, scroll 1 pixel left.
LE204:*	ldx ScrollX			;Has x scroll offset reached 0?-->
LE206:	bne Exit15			;If not, branch to exit.

;Scrolled one full screen, time to exit door.
LE208:	ldx #$05			;Samus is exiting the door.
LE20A:	bne DoOneDoorScroll		;Branch always.

LE20C:*	dex				;
LE20D:	bne +				;Check if need to scroll down to center door.
LE20F:	jsr ScrollDown			;($E519)DoorStatus=3, scroll 1 pixel down.
LE212:	jmp ++				;Jump to check y scrolling value.
LE215:*	dex				;
LE216:	bne Exit15			;Check if need to scroll up to center door.
LE218:	jsr ScrollUp			;($E4F1)DoorStatus=4, scroll 1 pixel up.

VerticalRoomCentered:
LE21B:*	ldx ScrollY			;Has room been centered on screen?-->
LE21D:	bne Exit15			;If not, branch to exit.
LE21F:	stx DoorOnNameTable3		;
LE221:	stx DoorOnNameTable0		;Erase door nametable data.
LE223:	inx				;X=1.
LE224:	lda ObjectX			;Did Samus enter in the right hand door?-->
LE227:	bmi ++				;If so, branch.
LE229:	inx				;X=2. Samus is in left door.
LE22A:	bne ++				;Branch always.

;This function is called once after door scrolling is complete.

DoOneDoorScroll:
LE22C:	lda #$20			;Set DoorDelay to 32 frames(comming out of door).
LE22E:	sta DoorDelay			;
LE230:	lda SamusDoorData		;Check if scrolling should be toggled.
LE232:	jsr Amul8			;($C2C6)*8. Is door not to toggle scrolling(item room,-->
LE235:	bcs +				;bridge room, etc.)? If so, branch to NOT toggle scrolling.
LE237:	ldy DoorScrollStatus		;If comming from vertical shaft, skip ToggleScroll because-->
LE239:	cpy #$03			;the scroll was already toggled after room was centered-->
LE23B:	bcc ++				;by the routine just above.
LE23D:*	lda #$47			;Set mirroring for vertical mirroring(horz scrolling).
LE23F:	bne ++				;Branch always.

LE241:*	jsr ToggleScroll		;($E252)Toggle scrolling and mirroring.
LE244:*	sta MirrorCntrl			;Store new mirror control data.
LE246:	stx DoorStatus			;DoorStatus=5. Done with door scrolling.

Exit15:
LE248:	rts				;Exit for several routines above.

;------------------------------------[ Toggle Samus nametable ]--------------------------------------

ToggleSamusHi:
LE249:	lda ObjectHi			;
LE24C:	eor #$01			;Change Samus' current nametable from one to the other.
LE24E:	sta ObjectHi			;
LE251:	rts				;

;-------------------------------------------[ Toggle scroll ]----------------------------------------

;Toggles both mirroring and scroll direction when Samus has moved from
;a horizontal shaft to a vertical shaft or vice versa.

ToggleScroll:
LE252:	lda ScrollDir			;
LE254:	eor #$03			;Toggle scroll direction.
LE256:	sta ScrollDir			;
LE258:	lda MirrorCntrl			;Toggle mirroring.
LE25A:	eor #$08			;
LE25C:	rts				;

;----------------------------------------[ Is Samus in lava ]----------------------------------------

;The following function checks to see if Samus is in lava.  If she is, the carry bit is cleared,
;if she is not, the carry bit is set. Samus can only be in lava if in a horizontally scrolling
;room. If Samus is 24 pixels or less away from the bottom of the screen, she is considered to be
;in lava whether its actually there or not.

IsSamusInLava:
LE25D:  lda #$01			;
LE25F:	cmp ScrollDir			;Set carry bit(and exit) if scrolling up or down.
LE261:	bcs +				;
LE263:	lda #$D8			;If Samus is Scrolling left or right and within 24 pixels-->
LE265:	cmp ObjectY			;of the bottom of the screen, she is in lava. Clear carry bit.
LE268:*	rts				;

;----------------------------------[ Check lava and movement routines ]------------------------------

LavaAndMoveCheck:
LE269:  lda ObjAction			;
LE26C:	cmp #sa_Elevator		;Is Samus on elevator?-->
LE26E:	beq +				;If so, branch.
LE270:	cmp #sa_Dead			;Is Samus Dead-->
LE272:	bcs -				;If so, branch to exit.
LE274:*	jsr IsSamusInLava		;($E25D)Clear carry flag if Samus is in lava.
LE277:	ldy #$FF			;Assume Samus not in lava.
LE279:	bcs ++++			;Samus not in lava so branch.

;Samus is in lava.
LE27B:	sty DamagePushDirection		;Don't push Samus from lava damage.
LE27D:	jsr ClearHealthChange		;($F323)Clear any pending health changes to Samus.
LE280:	lda #$32			;
LE282:	sta SamusBlink			;Make Samus blink.
LE284:	lda FrameCount			;
LE286:	and #$03			;Start the jump SFX every 4th frame while in lava.
LE288:	bne +				;
LE28A:	jsr SFX_SamusJump		;($CBAC)Initiate jump SFX.
LE28D:*	lda FrameCount			;
LE28F:	lsr				;This portion of the code causes Samus to be damaged by-->
LE290:	and #$03			;lava twice every 8 frames if she does not have the varia-->
LE292:	bne ++				;but only once every 8 frames if she does.
LE294:	lda SamusGear			;
LE297:	and #gr_VARIA			;Does Samus have the Varia?-->
LE299:	beq +				;If not, branch.
LE29B:	bcc ++				;Samus has varia. Carry set every other frame. Half damage.
LE29D:*	lda #$07			;
LE29F:	sta HealthLoChange		;Samus takes lava damage.
LE2A1:	jsr SubtractHealth		;($CE92)
LE2A4:*	ldy #$00			;Prepare to indicate Samus is in lava.
LE2A6:*	iny				;Set Samus lava status.
LE2A7:	sty SamusInLava			;

SamusMoveVertically:
LE2A9:	jsr VertAccelerate		;($E37A)Calculate vertical acceleration.
LE2AC:	lda ObjectY			;
LE2AF:	sec				;
LE2B0:	sbc ScrollY			;Calculate Samus' screen y position.
LE2B2:	sta SamusScrY			;
LE2B4:	lda $00				;Load temp copy of vertical speed.
LE2B6:	bpl ++++			;If Samus is moving downwards, branch.

LE2B8:	jsr TwosCompliment		;($C3D4)Get twos compliment of vertical speed.
LE2BB:	ldy SamusInLava			;Is Samus in lava?
LE2BD:	beq +				;If not, branch,-->
LE2BF:	lsr				;else cut vertical speed in half.
LE2C0:	beq SamusMoveHorizontally	;($E31A)Branch if no vertical mvmnt to Check left/right mvmnt.

;Samus is moving upwards.
LE2C2:*	sta ObjectCounter		;Store number of pixels to move Samus this frame.
LE2C4:*	jsr MoveSamusUp			;($E457)Attempt to move Samus up 1 pixel.
LE2C7:	bcs +				;Branch if Samus successfully moved up 1 pixel.

LE2C9:	sec				;Samus blocked upwards. Divide her speed by 2 and set the
LE2CA:	ror ObjVertSpeed		;MSB to reverse her direction of travel.
LE2CD:	ror VertCntrLinear		;
LE2D0:	jmp SamusMoveHorizontally	;($E31A)Attempt to move Samus left/right.

LE2D3:*	dec ObjectCounter		;1 pixel movement is complete.
LE2D5:	bne --				;Branch if Samus needs to be moved another pixel.

;Samus is moving downwards.
LE2D7:*	beq SamusMoveHorizontally	;($E31A)Branch if no vertical mvmnt to Check left/right mvmnt.
LE2D9:	ldy SamusInLava			;Is Samus in lava?
LE2DB:	beq +				;If not, branch,-->
LE2DD:	lsr				;Else reduce Samus speed by 75%(divide by 4).
LE2DE:	lsr				;
LE2DF:	beq SamusMoveHorizontally	;($E31A)Attempt to move Samus left/right.

LE2E1:*	sta ObjectCounter		;Store number of pixels to move Samus this frame.
LE2E3:*	jsr MoveSamusDown		;($E4A3)Attempt to move Samus 1 pixel down.
LE2E6:	bcs +++				;Branch if Samus successfully moved down 1 pixel.

;Samus bounce after hitting the ground in ball form.
LE2E8:	lda ObjAction			;
LE2EB:	cmp #sa_Roll			;Is Samus rolled into a ball?-->
LE2ED:	bne +				;If not, branch.
LE2EF:	lsr ObjVertSpeed		;Divide verticle speed by 2.
LE2F2:	beq ++				;Speed not fast enough to bounce. branch to skip.
LE2F4:	ror VertCntrLinear		;Move carry bit into MSB to reverse Linear counter.
LE2F7:	lda #$00			;
LE2F9:	sec				;
LE2FA:	sbc VertCntrLinear		;Subtract linear counter from 0 and save the results.-->
LE2FD:	sta VertCntrLinear		;Carry will be cleared.
LE300:	lda #$00			;
LE302:	sbc ObjVertSpeed		;Subtract vertical speed from 0. this will reverse the-->
LE305:	sta ObjVertSpeed		;vertical direction of travel(bounce up).
LE308:	jmp SamusMoveHorizontally	;($E31A)Attempt to move Samus left/right.

;Samus has hit the ground after moving downwards. 
LE30B:*	jsr SFX_SamusWalk		;($CB96)Play walk SFX.
LE30E:*	jsr StopVertMovement		;($D147)Clear vertical movement data.
LE311:	sty SamusGravity		;Clear Samus gravity value.
LE314:	beq SamusMoveHorizontally	;($E31A)Attempt to move Samus left/right.

LE316:*	dec ObjectCounter		;1 pixel movement is complete.
LE318:	bne ----			;Branch if Samus needs to be moved another pixel.

SamusMoveHorizontally:
LE31A:  jsr HorzAccelerate		;($E3E5)Horizontally accelerate Samus.
LE31D:	lda ObjectX			;
LE320:	sec				;Calculate Samus' x position on screen.
LE321:	sbc ScrollX			;
LE323:	sta SamusScrX			;Save Samus' x position.
LE325:	lda $00				;Load Samus' current horizontal speed.
LE327:	bpl +++				;Branch if moving right.

;Samus is moving left.
LE329:	jsr TwosCompliment		;($C3D4)Get twos compliment of horizontal speed.
LE32C:	ldy SamusInLava			;Is Samus in lava?-->
LE32E:	beq +				;If not, branch,-->
LE330:	lsr				;else cut horizontal speed in half.
LE331:	beq Exit10			;Branch to exit if Samus not going to move this frame.

LE333:*	sta ObjectCounter		;Store number of pixels to move Samus this frame.
LE335:*	jsr MoveSamusLeft		;($E626)Attempt to move Samus 1 pixel to the left.
LE338:	jsr CheckStopHorzMvmt		;($E365)Check if horizontal movement needs to be stopped.
LE33B:	dec ObjectCounter		;1 pixel movement is complete.
LE33D:	bne -				;Branch if Samus needs to be moved another pixel.

LE33F:	lda SamusDoorData		;Has Samus entered a door?-->
LE341:	beq Exit10			;If not, branch to exit.
LE343:	lda #$01			;Door leads to the left.
LE345:	bne ++++			;Branch always.

;Samus is moving right.
LE347:*	beq Exit10			;Branch to exit if Samus not moving horizontally.
LE349:	ldy SamusInLava			;Is Samus in lava?-->
LE34B:	beq +				;If not, branch,-->
LE34D:	lsr				;else cut horizontal speed in half.
LE34E:	beq Exit10			;Branch to exit if Samus not going to move this frame.

LE350:*	sta ObjectCounter		;Store number of pixels to move Samus this frame.
LE352:*	jsr MoveSamusRight		;($E668)Attempt to move Samus 1 pixel to the right.
LE355:	jsr CheckStopHorzMvmt		;($E365)Check if horizontal movement needs to be stopped.
LE358:	dec ObjectCounter		;1 pixel movement is complete.
LE35A:	bne -				;Branch if Samus needs to be moved another pixel.

LE35C:	lda SamusDoorData		;Has Samus entered a door?-->
LE35E:	beq Exit10			;If not, branch to exit.
LE360:	lda #$00			;
LE362:*	sta SamusDoorDir		;Door leads to the right.

Exit10:
LE364:	rts				;Exit for routines above and below.

CheckStopHorzMvmt:
LE365:  bcs Exit10			;Samus moved successfully. Branch to exit.
LE367:	lda #$01			;Load counter with #$01 so this function will not be-->
LE369:	sta ObjectCounter		;called again.
LE36C:	lda SamusGravity		;Is Samus on the ground?-->
LE36E:	bne Exit10			;If not, branch to exit.
LE370:	lda ObjAction			;
LE373:	cmp #sa_Roll			;Is Samus rolled into a ball?-->
LE375:	beq Exit10			;If so, branch to exit.
LE377:	jmp StopHorzMovement		;($CF55)Stop horizontal movement or play walk SFX if stopped.

;-------------------------------------[ Samus vertical acceleration ]--------------------------------

;The following code accelerates/decelerates Samus vertically.  There are 4 possible values for
;gravity used in the acceleration calculation. The higher the number, the more intense the gravity.
;The possible values for gravity are as follows:
;#$38-When Samus has been hit by an enemy.
;#$1A-When Samus is falling.
;#$18-Jump without high jump boots.
;#$12-Jump with high jump boots.

VertAccelerate:
LE37A:  lda SamusGravity		;Is Samus rising or falling?-->
LE37D:	bne ++				;Branch if yes.
LE37F:	lda #$18			;
LE381:	sta SamusHorzSpeedMax		;Set Samus maximum running speed.
LE384:	lda ObjectY			;
LE387:	clc				;
LE388:	adc ObjRadY			;Check is Samus is obstructed downwards on y room-->
LE38B:	and #$07			;positions divisible by 8(every 8th pixel).
LE38D:	bne +				;
LE38F:	jsr CheckMoveDown		;($E7AD)Is Samus obstructed downwards?-->
LE392:	bcc ++				;Branch if yes.
LE394:*	jsr SamusOnElevatorOrEnemy	;($D976)Calculate if Samus standing on elevator or enemy.
LE397:	lda SamusOnElevator		;Is Samus on an elevator?-->
LE39A:	bne +				;Branch if yes.
LE39C:	lda OnFrozenEnemy		;Is Samus standing on a frozen enemy?-->
LE39E:	bne +				;Branch if yes.
LE3A0:	lda #$1A			;Samus is falling. Store falling gravity value.
LE3A2:	sta SamusGravity		;

LE3A5:*	ldx #$05			;Load X with maximum downward speed.
LE3A7:	lda VertCntrLinear		;
LE3AA:	clc				;The higher the gravity, the faster this addition overflows-->
LE3AB:	adc SamusGravity		;and the faster ObjVertSpeed is incremented.
LE3AE:	sta VertCntrLinear		;
LE3B1:	lda ObjVertSpeed		;Every time above addition sets carry bit, ObjVertSpeed is-->
LE3B4:	adc #$00			;incremented. This has the effect of speeding up a fall-->
LE3B6:	sta ObjVertSpeed		;and slowing down a jump.
LE3B9:	bpl +				;Branch if Samus is moving downwards.

;Check if maximum upward speed has been exceeded. If so, prepare to set maximum speed.
LE3BB:	lda #$00			;
LE3BD:	cmp VertCntrLinear		;Sets carry bit.
LE3C0:	sbc ObjVertSpeed		;Subtract ObjVertSpeed to see if maximum speed has-->
LE3C3:	cmp #$06			;been exceeded.
LE3C5:	ldx #$FA			;Load X with maximum upward speed.
LE3C7:	bne ++				;Branch always.

;Check if maximum downward speed has been reached. If so, prepare to set maximum speed.
LE3C9:*	cmp #$05			;Has maximum downward speed been reached?-->
LE3CB:*	bcc +				;If not, branch.

;Max verticle speed reached or exceeded. Adjust Samus verticle speed to max.
LE3CD:	jsr StopVertMovement		;($D147)Clear verticle movement data.
LE3D0:	stx ObjVertSpeed		;Set Samus vertical speed to max.

;This portion of the function creates an exponential increase/decrease in verticle speed. This is the
;part of the function that does all the work to make Samus' jump seem natural.
LE3D3:*	lda VertCntrNonLinear		;
LE3D6:	clc				;This function adds itself plus the linear verticle counter-->
LE3D7:	adc VertCntrLinear		;onto itself every frame.  This causes the non-linear-->
LE3DA:	sta VertCntrNonLinear		;counter to increase exponentially.  This function will-->
LE3DD:	lda #$00			;cause Samus to reach maximum speed first in most-->
LE3DF:	adc ObjVertSpeed		;situations before the linear counter.
LE3E2:	sta $00				;$00 stores temp copy of current verticle speed.
LE3E4:	rts				;

;----------------------------------------------------------------------------------------------------

HorzAccelerate:
LE3E5:  lda SamusHorzSpeedMax
	jsr Amul16       ; * 16
	sta $00
	sta $02
	lda SamusHorzSpeedMax
	jsr Adiv16       ; / 16
	sta $01
	sta $03

	lda HorzCntrLinear
	clc
	adc SamusHorzAccel
	sta HorzCntrLinear
	tax
	lda #$00
	bit SamusHorzAccel
	bpl +				;Branch if Samus accelerating to the right.

	lda #$FF

*       adc ObjHorzSpeed
	sta ObjHorzSpeed
	tay
	bpl +				;Branch if Samus accelerating to the right.

	lda #$00
	sec
	sbc HorzCntrLinear
	tax
	lda #$00
	sbc ObjHorzSpeed
	tay
	jsr LE449

*       cpx $02
	tya
	sbc $03
	bcc +
	lda $00
	sta HorzCntrLinear
	lda $01
	sta ObjHorzSpeed
*       lda HorzCntrNonLinear
	clc
	adc HorzCntrLinear
	sta HorzCntrNonLinear
	lda #$00
	adc ObjHorzSpeed
	sta $00				;$00 stores temp copy of current horizontal speed.
	rts				;

LE449:  lda #$00
	sec
	sbc $00
	sta $00
	lda #$00
	sbc $01
	sta $01
	rts

;----------------------------------------------------------------------------------------------------

;Attempt to move Samus one pixel up.

MoveSamusUp:
LE457:	lda ObjectY			;Get Samus' y position in room.
	sec				;
	sbc ObjRadY			;Subtract Samus' vertical radius.
LE45E:	and #$07			;Check if result is a multiple of 8. If so, branch to-->
LE460:	bne +				;Only call crash detection every 8th pixel.
LE462:	jsr CheckMoveUp			;($E7A2)Check if Samus obstructed UPWARDS.-->
	bcc +++++++			;If so, branch to exit(can't move any further).
*       lda ObjAction			;
	cmp #sa_Elevator		;Is Samus riding elevator?-->
	beq +				;If so, branch.
	jsr SamusOnElevatorOrEnemy	;($D976)Calculate if Samus standing on elevator or enemy.
	lda SamusHit
	and #$42
	cmp #$42
	clc
	beq ++++++
*       lda SamusScrY
	cmp #$66	; reached up scroll limit?
	bcs +	   ; branch if not
	jsr ScrollUp
	bcc ++
*       dec SamusScrY
*	lda ObjectY
	bne ++
	lda ScrollDir
	and #$02
	bne +
	jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
*       lda #240
	sta ObjectY
*	dec ObjectY
	inc SamusJumpDsplcmnt
	sec
*	rts

; attempt to move Samus one pixel down

MoveSamusDown:
	lda ObjectY
	clc
	adc ObjRadY
	and #$07
	bne +		   ; only call crash detection every 8th pixel
	jsr CheckMoveDown       ; check if Samus obstructed DOWNWARDS
	bcc +++++++	 ; exit if yes
*       lda ObjAction
	cmp #sa_Elevator	; is Samus in elevator?
	beq +
	jsr LD976
	lda SamusOnElevator
	clc
	bne ++++++
	lda OnFrozenEnemy
	bne ++++++
*       lda SamusScrY
	cmp #$84	; reached down scroll limit?
	bcc +	   ; branch if not
	jsr ScrollDown
	bcc ++
*       inc SamusScrY
*	lda ObjectY
	cmp #239
	bne ++
	lda ScrollDir
	and #$02
	bne +
	jsr ToggleSamusHi       ; toggle 9th bit of Samus' Y coord
*       lda #$FF
	sta ObjectY
*	inc ObjectY
	dec SamusJumpDsplcmnt
	sec
*	rts

; Attempt to scroll UP

	ScrollUp:
	lda ScrollDir
	beq +
	cmp #$01
	bne ++++
	dec ScrollDir
	lda ScrollY
	beq +
	dec MapPosY
*       ldx ScrollY
	bne +
	dec MapPosY     ; decrement MapY
	jsr GetRoomNum  ; put room # at current map pos in $5A
	bcs ++   ; if function returns CF = 1, moving up is not possible
	jsr LE9B7       ; switch to the opposite Name Table
	ldx #240	; new Y coord
*	dex
	jmp LE53F

*	inc MapPosY
*	sec
	rts

; Attempt to scroll DOWN

	ScrollDown:
	ldx ScrollDir
	dex
	beq +
	bpl +++++
	inc ScrollDir
	lda ScrollY
	beq +
	inc MapPosY
*       lda ScrollY
	bne +
	inc MapPosY     ; increment MapY
	jsr GetRoomNum  ; put room # at current map pos in $5A
	bcs +++   ; if function returns CF = 1, moving down is not possible
*       ldx ScrollY
	cpx #239
	bne +
	jsr LE9B7       ; switch to the opposite Name Table
	ldx #$FF
*       inx
LE53F:  stx ScrollY
	jsr LE54A       ; check if it's time to update Name Table
	clc
	rts

*	dec MapPosY
*	sec
*       rts

LE54A:  jsr SetupRoom
	ldx RoomNumber
	inx
	bne -
	lda ScrollDir
	and #$02
	bne +
	jmp LE571
*       jmp LE701

; Table

Table11:
	.byte $07
	.byte $00

;---------------------------------[ Get PPU and RoomRAM addresses ]----------------------------------

PPUAddrs:
LE560:	.byte $20			;High byte of nametable #0(PPU).
LE561:	.byte $2C			;High byte of nametable #3(PPU)

WRAMAddrs:
LE562:	.byte $60			;High byte of RoomRAMA(cart RAM).
LE563:	.byte $64			;High byte of RoomRAMB(cart RAM).

GetNameAddrs:
LE564:	jsr GetNameTable		;($EB85)Get current name table number.
LE567:	and #$01			;Update name table 0 or 3.
LE569:	tay				;
LE56A:	lda PPUAddrs,y			;Get high PPU addr of nametable(dest).
LE56D:	ldx WRAMAddrs,y			;Get high cart RAM addr of nametable(src).
LE570:	rts				;

;----------------------------------------------------------------------------------------------------

; check if it's time to update nametable (when scrolling is VERTICAL)

LE571:  ldx ScrollDir
	lda ScrollY
	and #$07	; compare value = 0 if ScrollDir = down, else 7
	cmp Table11,x
	bne --	   ; exit if not equal (no nametable update)

LE57C:  ldx ScrollDir			;
	cpx TempScrollDir		;Still scrolling same direction when room was loaded?-->
	bne --				;If not, branch to exit.
	lda ScrollY
	and #$F8	; keep upper 5 bits
	sta $00
	lda #$00
	asl $00
	rol
	asl $00
	rol

LE590:  sta $01	 ; $0001 = (ScrollY & 0xF8) << 2 = row offset
	jsr GetNameAddrs
	ora $01
	sta $03
	txa
	ora $01
	sta $01
	lda $00
	sta $02
	lda ScrollDir
	lsr		; A = 0 if vertical scrolling, 1 if horizontal
	tax
	lda Table01,x
	sta $04
	ldy #$01
	sty PPUDataPending      ; data pending = YES
	dey
	ldx PPUStrIndex
	lda $03
	jsr WritePPUByte		;($C36B)Put data byte into PPUDataString.
	lda $02
	jsr WritePPUByte
	lda $04
	jsr SeparateControlBits		;($C3C6)
*       lda ($00),y
	jsr WritePPUByte
	sty $06
	ldy #$01	; WRAM pointer increment = 1...
	bit $04	 ; ... if bit 7 (PPU inc) of $04 clear
	bpl +
	ldy #$20	; else ptr inc = 32
*       jsr AddYToPtr00			;($C2A8)
	ldy $06
	dec $05
	bne --
	stx PPUStrIndex
	jsr EndPPUString

Table01:
	.byte $20			;Horizontal write. PPU inc = 1, length = 32 tiles.
	.byte $9E			;Vertical write... PPU inc = 32, length = 30 tiles.

;---------------------------------[Write PPU attribute table data ]----------------------------------

WritePPUAttribTbl:
LE5E2:  ldx #$C0			;Low byte of First row of attribute table.
LE5E4:	lda RoomNumber			;
LE5E6:	cmp #$F2			;Is this the second pass through the routine?-->
LE5E8:	beq +				;If so, branch.
LE5EA:	ldx #$E0			;Low byte of second row of attribute table.
LE5EC:*	stx $00				;$0000=RoomRAM atrrib table starting address.
LE5EE:	stx $02				;$0002=PPU attrib table starting address.
LE5F0:	jsr GetNameAddrs		;($E564)Get name table addr and corresponding RoomRAM addr.
LE5F3:	ora #$03			;#$23 for attrib table 0, #$2F for attrib table 3.
LE5F5:	sta $03				;Store results.
LE5F7:	txa				;move high byte of RoomRAM to A.
LE5F8:	ora #$03			;#$63 for RoomRAMA, #$67 for RoomRAMB(Attrib tables).
LE5FA:	sta $01				;Store results.
LE5FC:	lda #$01			;
LE5FE:	sta PPUDataPending		;Data pending = YES.
LE600:	ldx PPUStrIndex			;Load current index into PPU strng to append data.
LE603:	lda $03				;Store high byte of starting address(attrib table).
LE605:	jsr WritePPUByte		;($C36B)Put data byte into PPUDataString.
LE608:	lda $02				;Store low byte of starting address(attrib table).
LE60A:	jsr WritePPUByte		;($C36B)Put data byte into PPUDataString.
LE60D:	lda #$20			;Length of data to write(1 row of attrib data).
LE60F:	sta $04				;
LE611:	jsr WritePPUByte		;($C36B)Write control byte. Horizontal write.
LE614:	ldy #$00			;Reset index into data string.
LE616:*	lda ($00),y			;Get data byte.
LE618:	jsr WritePPUByte		;($C36B)Put data byte into PPUDataString.
LE61B:	iny				;Increment to next attrib data byte.
LE61C:	dec $04				;
LE61E:	bne -				;Loop until all attrib data loaded into PPU.
LE620:	stx PPUStrIndex			;Store updated PPU string index.
LE623:	jsr EndPPUString		;($C376)Append end marker(#$00) and exit writing routines.

;----------------------------------------------------------------------------------------------------

; attempt to move Samus one pixel left

MoveSamusLeft:
LE626:	lda ObjectX
	sec
	sbc ObjRadX
	and #$07
	bne +		   ; only call crash detection every 8th pixel
	jsr CheckMoveLeft       ; check if player is obstructed to the LEFT
	bcc +++++	 ; branch if yes! (CF = 0)
*       jsr LD976
	lda SamusHit
	and #$41
	cmp #$41
	clc
	beq ++++
	lda SamusScrX
	cmp #$71	; reached left scroll limit?
	bcs +	   ; branch if not
	jsr ScrollLeft
	bcc ++
*       dec SamusScrX
*	lda ObjectX
	bne +
	lda ScrollDir
	and #$02
	beq +
	jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
*       dec ObjectX
	sec
	rts

; crash with object on the left

*	lda #$00
	sta SamusDoorData
	rts

; attempt to move Samus one pixel right

MoveSamusRight:
	lda ObjectX
	clc
	adc ObjRadX
	and #$07
	bne +		   ; only call crash detection every 8th pixel
	jsr CheckMoveRight      ; check if Samus is obstructed to the RIGHT
	bcc +++++       ; branch if yes! (CF = 0)
*       jsr LD976
	lda SamusHit
	and #$41
	cmp #$40
	clc
	beq ++++
	lda SamusScrX
	cmp #$8F	; reached right scroll limit?
	bcc +	   ; branch if not
	jsr ScrollRight
	bcc ++
*       inc SamusScrX
*	inc ObjectX      ; go right, Samus!
	bne +
	lda ScrollDir
	and #$02
	beq +
	jsr ToggleSamusHi       ; toggle 9th bit of Samus' X coord
*       sec
	rts

; crash with object on the right

*	lda #$00
	sta SamusDoorData
	rts

; Attempt to scroll LEFT

	ScrollLeft:
	lda ScrollDir
	cmp #$02
	beq +
	cmp #$03
	bne ++++
	dec ScrollDir
	lda ScrollX
	beq +
	dec MapPosX
*       lda ScrollX
	bne +
	dec MapPosX     ; decrement MapX
	jsr GetRoomNum  ; put room # at current map pos in $5A
	bcs ++  ; if function returns CF=1, scrolling left is not possible
	jsr LE9B7       ; switch to the opposite Name Table
*       dec ScrollX
	jsr LE54A       ; check if it's time to update Name Table
	clc
	rts

*	inc MapPosX
*	sec
	rts

; Attempt to scroll RIGHT

ScrollRight:
	lda ScrollDir
	cmp #$03
	beq +
	cmp #$02
	bne +++++
	inc ScrollDir
	lda ScrollX
	beq +
	inc MapPosX
*       lda ScrollX
	bne +
	inc MapPosX
	jsr GetRoomNum  ; put room # at current map pos in $5A
	bcs +++   ; if function returns CF=1, scrolling right is not possible
*       inc ScrollX
	bne +
	jsr LE9B7       ; switch to the opposite Name Table
*       jsr LE54A       ; check if it's time to update Name Table
	clc
	rts

*	dec MapPosX
*	sec
*       rts

Table02:
	.byte $07,$00

; check if it's time to update nametable (when scrolling is HORIZONTAL)

LE701:  ldx ScrollDir
	lda ScrollX
	and #$07	; keep lower 3 bits
	cmp Table02-2,x ; compare value = 0 if ScrollDir = right, else 7
	bne -	   ; exit if not equal (no nametable update)

LE70C:  ldx ScrollDir
	cpx TempScrollDir
	bne -
	lda ScrollX
	and #$F8	; keep upper five bits
	jsr Adiv8       ; / 8 (make 'em lower five)
	sta $00
	lda #$00
	jmp LE590

;---------------------------------------[ Get room number ]-------------------------------------------

;Gets room number at current map position. Sets carry flag if room # at map position is FF.
;If valid room number, the room number is stored in $5A.

GetRoomNum:
LE720:	lda ScrollDir			;
LE722:	lsr				;Branch if scrolling vertical.
LE723:	beq +				;

LE725:	rol				;Restore value of a
LE726:	adc #$FF			;A=#$01 if scrolling left, A=#$02 if scrolling right.
LE728:	pha				;Save A.
LE729:	jsr OnNameTable0		;($EC93)Y=1 if name table=0, Y=0 if name table=3.
LE72C:	pla				;Restore A.
LE72D:	and $006C,y			;
LE730:	sec				;
LE731:	bne +++++			;Can't load room, a door is in the way. This has the-->
					;effect of stopping the scrolling until Samus walks-->
					;through the door(horizontal scrolling only).

LE733:*	lda MapPosY			;Map pos y.
LE735:	jsr Amul16			;($C2C5)Multiply by 16.
LE738:	sta $00				;Store multiplied value in $00.
LE73A:	lda #$00			;
LE73C:	rol				;Save carry, if any.
LE73D:	rol $00				;Multiply value in $00 by 2.
LE73F:	rol				;Save carry, if any.
LE740:	sta $01				;
LE742:	lda $00				;
LE744:	adc MapPosX			;Add map pos X to A.
LE746:	sta $00				;Store result.
LE748:	lda $01				;
LE74A:	adc #$70			;Add #$7000 to result.
LE74C:	sta $01				;$0000 = (MapY*32)+MapX+#$7000.
LE74E:	ldy #$00			;
LE750:	lda ($00),y			;Load room number.
LE752:	cmp #$FF			;Is it unused?-->
LE754:	beq ++++			;If so, branch to exit with carry flag set.

LE756:	sta RoomNumber			;Store room number.

LE758:*	cmp $95D0,y			;Is it a special room?-->
LE75B:	beq +				;If so, branch to set flag to play item room music.
LE75D:	iny				;
LE75E:	cpy #$07			;
LE760:	bne -				;Loop until all special room numbers are checked.

LE762:	lda ItemRoomMusicStatus		;Load item room music status.
LE764:	beq ++				;Branch if not in special room.
LE766:	lda #$80			;Ptop playing item room music after next music start.
LE768:	bne ++				;Branch always.

LE76A:*	lda #$01			;Start item room music on next music start.
LE76C:*	sta ItemRoomMusicStatus		;
LE76E:	clc				;Clear carry flag. was able to get room number.
LE76F:*	rts				;

;-----------------------------------------------------------------------------------------------------

LE770:	ldx PageIndex
	lda EnRadY,x
	clc
	adc #$08
	jmp LE783

LE77B:  ldx PageIndex
	lda #$00
	sec
	sbc EnRadY,x
LE783:  sta $02
	lda #$08
	sta $04
	jsr LE792
	lda EnRadX,x
	jmp LE7BD

LE792:  lda EnXRoomPos,x
	sta $09     ; X coord
	lda EnYRoomPos,x
	sta $08     ; Y coord
	lda EnNameTable,x
	sta $0B     ; hi coord
	rts

CheckMoveUp:
LE7A2:	ldx PageIndex
	lda ObjRadY,x
	clc
	adc #$08
	jmp +

CheckMoveDown:
	ldx PageIndex
	lda #$00
	sec
	sbc ObjRadY,x
*       sta $02
	jsr LE8BE
	lda ObjRadX,x
LE7BD:  bne +
	sec
	rts

*       sta $03
	tay
	ldx #$00
	lda $09
	sec
	sbc $03
	and #$07
	beq +
	inx
*       jsr LE8CE
	sta $04
	jsr LE90F
	ldx #$00
	ldy #$08
	lda $00
LE7DE:  bne +++
	stx $06
	sty $07
	ldx $04

; object<-->background crash detection

LE7E6:  jsr MakeWRAMPtr ; set up ptr in $0004
	ldy #$00
	lda ($04),y     ; get tile value
	cmp #$4E
	beq LE81E
	jsr $95C0
	jsr LD651
	bcc Exit16      ; CF = 0 if tile # < $80 (solid tile)... CRASH!!!
	cmp #$A0	; is tile >= A0h? (walkable tile)
	bcs IsWalkableTile
	jmp IsBlastTile  ; tile is $80-$9F (blastable tiles)

IsWalkableTile:
	ldy IsSamus
	beq ++
    ; special case for Samus
	dey	     ; = 0
	sty SamusDoorData
	cmp #$A0	; crash with tile #$A0? (scroll toggling door)
	beq +
	cmp #$A1	; crash with tile #$A1? (horizontal scrolling door)
	bne ++
	inc SamusDoorData
*       inc SamusDoorData
*	dex
	beq +
	jsr LE98E
	jmp LE7E6

*	sec	     ; no crash
	Exit16:
	rts

LE81E:  ldx UpdatingProjectile
	beq ClcExit
	ldx #$06
*       lda $05
	eor $5D,x
	and #$04
	bne +++
	lda $04
	eor $5C,x
	and #$1F
	bne +++
	txa
	jsr Amul8       ; * 8
	ora #$80
	tay
	lda ObjAction,y
	beq +++
	lda $0307,y
	lsr
	bcs ++
	ldx PageIndex
	lda ObjAction,x
	eor #$0B
	beq +
	lda ObjAction,x
	eor #$04
	bne PlaySnd4
	lda AnimResetIndex,x
	eor #$91
	bne PlaySnd4
*       lda $0683
	ora #$02
	sta $0683
*	lda #$04
	sta $030A,y
	bne ClcExit
*	dex
	dex
	bpl ----
	lda $04
	jsr Adiv8       ; / 8
	and #$01
	tax
	inc $0366,x
	ClcExit:
	clc
	rts

PlaySnd4:
	jmp SFX_Metal

CheckMoveLeft:
	ldx PageIndex
	lda ObjRadX,x
	clc
	adc #$08
	jmp +

CheckMoveRight:
	ldx PageIndex
	lda #$00
	sec
	sbc ObjRadX,x
*       sta $03
	jsr LE8BE
	ldy ObjRadY,x
LE89B:  bne +
	sec
	rts

*       sty $02
	ldx #$00
	lda $08
	sec
	sbc $02
	and #$07
	beq +
	inx
*       jsr LE8CE
	sta $04
	jsr LE90F
	ldx #$08
	ldy #$00
	lda $01
	jmp LE7DE

LE8BE:  lda ObjectHi,x
	sta $0B
	lda ObjectY,x
	sta $08
	lda ObjectX,x
	sta $09
	rts

LE8CE:  eor #$FF
	clc
	adc #$01
	and #$07
	sta $04
	tya
	asl
	sec
	sbc $04
	bcs +
	adc #$08
*       tay
	lsr
	lsr
	lsr
	sta $04
	tya
	and #$07
	beq +
	inx
*       txa
	clc
	adc $04
	rts

LE8F1:  ldx PageIndex
	lda EnRadX,x
	clc
	adc #$08
	jmp LE904

LE8FC:  ldx PageIndex
	lda #$00
	sec
	sbc EnRadX,x
LE904:  sta $03
	jsr LE792
	ldy EnRadY,x
	jmp LE89B

LE90F:  lda $02
	bpl ++
	jsr LE95F
	bcs +
	cpx #$F0
	bcc +++
*       txa
	adc #$0F
	jmp LE934

*	jsr LE95F
	lda $08
	sec
	sbc $02
	tax
	and #$07
	sta $00
	bcs +
	txa
	sbc #$0F
LE934:  tax
	lda ScrollDir
	and #$02
	bne +
	inc $0B
*	stx $02
	ldx #$00
	lda $03
	bmi +
	dex
*       lda $09
	sec
	sbc $03
	sta $03
	and #$07
	sta $01
	txa
	adc #$00
	beq +
	lda ScrollDir
	and #$02
	beq +
	inc $0B
*       rts

LE95F:  lda $08
	sec
	sbc $02
	tax
	and #$07
	sta $00
	rts

; MakeWRAMPtr
; ===========
; Makes pointer to WRAM nametable based on object's coordinates.
; In: $02 = ObjectY, $03 = ObjectX, $0B = ObjectHi
; Out: $04 = WRAM pointer

	MakeWRAMPtr:
	lda #$18
	sta $05
	lda $02	 ; ObjectY
	and #$F8	; keep upper 5 bits
	asl
	rol $05
	asl
	rol $05
	sta $04
	lda $03	 ; ObjectX
	lsr
	lsr
	lsr	   ; A = ObjectX / 8
	ora $04
	sta $04
	lda $0B	 ; ObjectYHi
	asl
	asl	   ; A = ObjectYHi * 4
	and #$04
	ora $05
	sta $05
	rts

LE98E:  lda $02
	clc
	adc $06
	sta $02
	cmp #$F0
	bcc +
	adc #$0F
	sta $02
	lda ScrollDir
	and #$02
	bne +
	inc $0B
*       lda $03
	clc
	adc $07
	sta $03
	bcc +
	lda ScrollDir
	and #$02
	beq +
	inc $0B
*       rts

LE9B7:  lda PPUCNT0ZP
	eor #$03
	sta PPUCNT0ZP
	rts

IsBlastTile:
	ldy UpdatingProjectile
	beq Exit18
LE9C2:  tay
	jsr $95BD
	cpy #$98
	bcs +++++
; attempt to find a vacant tile slot
	ldx #$C0
*       lda TileRoutine,x
	beq +	   ; 0 = free slot
	jsr Xminus16
	bne -
	lda TileRoutine,x
	bne ++++	 ; no more slots, can't blast tile
*       inc TileRoutine,x
	lda $04
	and #$DE
	sta TileWRAMLo,x
	lda $05
	sta TileWRAMHi,x
	lda InArea
	cmp #$11
	bne +
	cpy #$76
	bne +
	lda #$04
	bne ++
*       tya
	clc
	adc #$10
	and #$3C
	lsr
*	lsr
	sta TileType,x
*	clc
Exit18: rts

;------------------------------------------[ Select room RAM ]---------------------------------------

SelectRoomRAM:
LEA05:	jsr GetNameTable		;($EB85)Find name table to draw room on.
LEA08:	asl				;
LEA09:	asl				;
LEA0A:	ora #$60			;A=#$64 for name table 3, A=#$60 for name table 0.
LEA0C:	sta CartRAMPtr+1		;
LEA0E:	lda #$00			;
LEA10:	sta CartRAMPtr			;Save two byte pointer to start of proper room RAM.
LEA12:	rts				;

;------------------------------------[ write attribute table data ]----------------------------------

AttribTableWrite:
LEA13:*	lda RoomNumber			;
LEA15:	and #$0F			;Determine what row of PPU attribute table data, if any,-->
LEA17:	inc RoomNumber			;to load from RoomRAM into PPU.
LEA19:	jsr ChooseRoutine		;

;The following table is used by the code above to determine when to write to the PPU attribute table.

LEA1c:	.word ExitSub			;($C45C)Rts.
LEA1E:	.word WritePPUAttribTbl		;($E5E2)Write first row of PPU attrib data.
LEA20:	.word ExitSub			;($C45C)Rts.
LEA22:	.word WritePPUAttribTbl		;($E5E2)Write second row of PPU attrib data.
LEA24:	.word RoomFinished		;($EA26)Finished writing attribute table data.

;-----------------------------------[ Finished writing room data ]-----------------------------------

RoomFinished:
LEA26:  lda #$FF			;No more tasks to perform on current room.-->
LEA28:	sta RoomNumber			;Set RoomNumber to #$FF.
LEA2A:*	rts				;

;------------------------------------------[ Setup room ]--------------------------------------------

SetupRoom:
LEA2B:	lda RoomNumber			;Room number.
LEA2D:	cmp #$FF			;
LEA2F:	beq -				;Branch to exit if room is undefined.
LEA31:	cmp #$FE			;
LEA33:	beq +				;Branch if empty place holder byte found in room data.
LEA35:	cmp #$F0			;
LEA37:	bcs --				;Branch if time to write PPU attribute table data.
LEA39:	jsr UpdateRoomSpriteInfo	;($EC9B)Update which sprite belongs on which name table.

LEA3C:	jsr ScanForItems		;($ED98)Set up any special items.
LEA3F:	lda RoomNumber			;Room number to load.
LEA41:	asl				;*2(for loading address of room pointer).
LEA42:	tay				;
LEA43:	lda (RoomPtrTable),y		;Low byte of 16-bit room pointer.-->
LEA45:	sta RoomPtr			;Base copied from $959A to $3B.
LEA47:	iny				;
LEA48:	lda (RoomPtrTable),y		;High byte of 16-bit room pointer.-->
LEA4A:	sta RoomPtr+1			;Base copied from $959B to $3C.
LEA4C:	ldy #$00			;
LEA4E:	lda (RoomPtr),y			;First byte of room data.
LEA50:	sta RoomPal			;store initial palette # to fill attrib table with.
LEA52:	lda #$01			;
LEA54:	jsr AddToRoomPtr		;($EAC0)Increment room data pointer.
LEA57:	jsr SelectRoomRAM		;($EA05)Determine where to draw room in RAM, $6000 or $6400.
LEA5A:	jsr InitTables			;($EFF8)clear Name Table & do initial Attrib table setup.
LEA5D:*	jmp DrawRoom			;($EAAA)Load room contents into room RAM.

;---------------------------------------[ Draw room object ]-----------------------------------------

DrawObject:
LEA60:	sta $0E				;Store object position byte(%yyyyxxxx).
LEA62:	lda CartRAMPtr			;
LEA64:	sta CartRAMWorkPtr		;Set the working pointer equal to the room pointer-->
LEA66:	lda CartRAMPtr+1		;(start at beginning of the room).
LEA68:	sta CartRAMWorkPtr+1		;
LEA6A:	lda $0E				;Reload object position byte.
LEA6C:	jsr Adiv16			;($C2BF)/16. Lower nibble contains object y position.-->
LEA6F:	tax				;Transfer it to X, prepare for loop.
LEA70:	beq +++				;Skip y position calculation loop as y position=0 and-->
					;does not need to be calculated.
LEA72:*	lda CartRAMWorkPtr		;LoW byte of pointer working in room RAM.
LEA74:	clc				;
LEA75:	adc #$40			;Advance two rows in room RAM(one y unit).
LEA77:	sta CartRAMWorkPtr		;
LEA79:	bcc +				;If carry occurred, increment high byte of pointer-->
LEA7B:	inc CartRAMWorkPtr+1		;in room RAM.
LEA7D:*	dex				;
LEA7E:	bne --				;Repeat until at desired y position(X=0).

LEA80:*	lda $0E				;Reload object position byte.
LEA82:	and #$0F			;Remove y position upper nibble.
LEA84:	asl				;Each x unit is 2 tiles.
LEA85:	adc CartRAMWorkPtr		;
LEA87:	sta CartRAMWorkPtr		;Add x position to room RAM work pointer.
LEA89:	bcc +				;If carry occurred, increment high byte of room RAM work-->
LEA8B:	inc CartRAMWorkPtr+1		;pointer, else branch to draw object.

;CartRAMWorkPtr now points to the object's starting location (upper left corner)
;on the room RAM which will eventually be loaded into a name table.

LEA8D:*	iny				;Move to the next byte of room data which is-->
LEA8E:	lda (RoomPtr),y			;the index into the structure pointer table.
LEA90:	tax				;Transfer structure pointer index into X.
LEA91:	iny				;Move to the next byte of room data which is-->
LEA92:	lda (RoomPtr),y			;the attrib table info for the structure.
LEA94:	sta ObjectPal			;Save attribute table info.
LEA96:	txa				;Restore structure pointer to A.
LEA97:	asl				;*2. Structure pointers are two bytes in size.
LEA98:	tay				;
LEA99:	lda (StructPtrTable),y		;Low byte of 16-bit structure ptr.
LEA9B:	sta StructPtr			;
LEA9D:	iny				;
LEA9E:	lda (StructPtrTable),y		;High byte of 16-bit structure ptr.
LEAA0:	sta StructPtr+1			;
LEAA2:	jsr DrawStruct			;($EF8C)Draw one structure.
LEAA5:	lda #$03			;Move to next set of structure data.
LEAA7:	jsr AddToRoomPtr		;($EAC0)Add A to room data pointer.

;-------------------------------------------[ Draw room ]--------------------------------------------

;The following function draws a room in the room RAM which is eventually loaded into a name table.

DrawRoom:
LEAAA:	ldy #$00			;Zero index.
LEAAC:	lda (RoomPtr),y			;Load byte of room data.-->
LEAAE:	cmp #$FF			;Is it #$FF(end-of-room)?-->
LEAB0:	beq EndOfRoom			;If so, branch to exit.
LEAB2:	cmp #$FE			;Place holder for empty room objects(not used).
LEAB4:	beq +				;
LEAB6:	cmp #$FD			;is A=#$FD(end-of-objects)?-->
LEAB8:	bne DrawObject			;If not, branch to draw room object.-->
LEABA:	beq EndOfObjs			;Else branch to set up enemies/doors.
LEABC:*	sta RoomNumber			;Store #$FE if room object is empty.
LEABE:	lda #$01			;Prepare to increment RoomPtr.

;-------------------------------------[ Add A to room pointer ]--------------------------------------

AddToRoomPtr:
LEAC0:	clc				;Prepare to add index in A to room pointer.
LEAC1:	adc RoomPtr			;
LEAC3:	sta RoomPtr			;
LEAC5:	bcc +				;Did carry occur? If not branch to exit.
LEAC7:	inc RoomPtr+1			;Increment high byte of room pointer if carry occured.
LEAC9:*	rts				;

;----------------------------------------------------------------------------------------------------

EndOfObjs:
LEACA:	lda RoomPtr			;
LEACC:	sta $00				;Store room pointer in $0000.
LEACE:	lda RoomPtr+1			;
LEAD0:	sta $01				;
LEAD2:	lda #$01			;Prepare to increment to enemy/door data.

EnemyLoop:
LEAD4:	jsr AddToPtr00			;($EF09)Add A to pointer at $0000.
LEAD7:	ldy #$00			;
LEAD9:	lda ($00),y			;Get first byte of enemy/door data.
LEADB:	cmp #$FF			;End of enemy/door data?-->
LEADD:	beq EndOfRoom			;If so, branch to finish room setup.
LEADF:	and #$0F			;Discard upper four bits of data.
LEAE1:	jsr ChooseRoutine		;Jump to proper enemy/door handling routine.

;Pointer table to code.

LEAE4:	.word ExitSub			;($C45C)Rts.
LEAE6:	.word LoadEnemy			;($EB06)Room enemies.
LEAE8:	.word LoadDoor			;($EB8C)Room doors.
LEAEA:	.word ExitSub			;($C45C)Rts.
LEAEC:	.word LoadElevator		;($EC04)Elevator.
LEAEE:	.word ExitSub			;($C45C)Rts.
LEAF0:	.word LoadStatues		;($EC2F)Kraid & Ridley statues.
LEAF2:	.word ZebHole			;($EC57)Regenerating enemies(such as Zeb).

EndOfRoom:
LEAF4:	ldx #$F0			;Prepare for PPU attribute table write.
	stx RoomNumber			;
	lda ScrollDir			;
	sta TempScrollDir		;Make temp copy of ScrollDir.
	and #$02			;Check if scrolling left or right.
	bne +				;
	jmp LE57C
*       jmp LE70C

LoadEnemy:
LEB06:	jsr GetEnemyData		;($EB0C)Get enemy data from room data.
LEB09:	jmp EnemyLoop			;($EAD4)Do next room object.

GetEnemyData:
LEB0C:	lda ($00),y			;Get 1st byte again.
	and #$F0			;Get object slot that enemy will occupy.
	tax				;
	jsr IsSlotTaken			;($EB7A)Check if object slot is already in use.
	bne ++				;Exit if object slot taken.
	iny				;
	lda ($00),y			;Get enemy type.
	jsr GetEnemyType		;($EB28)Load data about enemy.
	ldy #$02			;
	lda ($00),y			;Get enemy initial position(%yyyyxxxx).
	jsr LEB4D
	pha
*       pla
*       lda #$03			;Number of bytes to add to ptr to find next room item.
	rts				;

GetEnemyType:
LEB28:	pha				;Store enemy type.
	and #$C0			;If MSB is set, the "tough" version of the enemy  
	sta EnSpecialAttribs,x		;is to be loaded(more hit points, except rippers).
	asl				;
	bpl ++				;If bit 6 is set, the enemy is either Kraid or Ridley.
	lda InArea			;Load current area Samus is in(to check if Kraid or-->
	and #$06			;Ridley is alive or dead).
	lsr				;Use InArea to find status of Kraid/Ridley statue.
	tay				;
	lda MaxMissiles,y		;Load status of Kraid/Ridley statue.
	beq +				;Branch if Kraid or Ridley needs to be loaded.
	pla				;
	pla				;Mini boss is dead so pull enemy info and last address off-->
	jmp --				;stack so next enemy/door item can be loaded.

*       lda #$01			;Samus is in Kraid or Ridley's room and the-->
	sta KraidRidleyPresent		;mini boss is alive and needs to be loaded.

*	pla				;Restore enemy type data.
	and #$3F			;Keep 6 lower bits to use as index for enemy data tables.
	sta EnDataIndex,x		;Store index byte.
	rts				;

LEB4D:  tay				;Save enemy position data in Y.
	and #$F0			;Extract Enemy y position.
	ora #$08			;Add 8 pixels to y position so enemy is always on screen. 
	sta EnYRoomPos,x		;Store enemy y position.
	tya				;Restore enemy position data.
	jsr Amul16			;*16 to extract enemy x position.
	ora #$0C			;Add 12 pixels to x position so enemy is always on screen.
	sta EnXRoomPos,x		;Store enemy x position.
	lda #$01			;
	sta EnStatus,x			;Indicate object slot is taken.
	lda #$00
	sta $0404,x
	jsr GetNameTable		;($EB85)Get name table to place enemy on.
	sta EnNameTable,x		;Store name table.
	ldy EnDataIndex,x		;Load A with index to enemy data.
	asl $0405,x			;*2
	jsr LFB7B
	jmp LF85A

IsSlotTaken:
LEB7A:	lda EnStatus,x
	beq +
	lda $0405,x
	and #$02
*       rts

;------------------------------------------[ Get name table ]----------------------------------------

;The following routine is small but is called by several other routines so it is important and
;requires some explaining to understand its function.  First of all, as Samus moves from one room
;to the next, she is also moving from one name table to the next.  Samus does not move from one
;name table to the next as one might think. Samus moves diagonally through the name tables. To
;understand this concept, one must first know how the name tables are arranged.  They are arranged
;like so:
;
; +-----+-----+							 +-----+-----+
; |     |     | The following is an incorrect example of how	 |     |     |
; |  2  |  3  | Samus goes from one name table to the next-----> |  2  |  3  |
; |     |     |							 |     |     |
; +-----+-----+							 +-----+-----+
; |     |     |							 |     |     |
; |  0  |  1  |				      INCORRECT!------>  |  0<-|->1  |
; |     |     |							 |     |     |
; +-----+-----+							 +-----+-----+
;
;The following are examples of how the name tables are properly traversed while walking through rooms:
;
;	   +-----+-----+				     +-----+-----+
;	   |     |     |				     |     |     |
;	   |  2  | ->3 |				     |  2  |  3<-|-+
;	   |     |/    |				     |     |     | |
;	   +-----+-----+     <--------CORRECT!-------->      +-----+-----+ |
;	   |    /|     |				     |     |     | |
;	   | 0<- |  1  |				   +-|->0  |  1  | |
;	   |     |     |				   | |     |     | |
;	   +-----+-----+				   | +-----+-----+ |
;							   +---------------+
;
;The same diagonal traversal of the name tables illustrated above applies to vetricle traversal as
;well. Since Samus can only travel between 2 name tables and not 4, the name table placement for
;objects is simplified.  The following code determines which name table to use next:

GetNameTable:
LEB85:	lda PPUCNT0ZP			;
LEB87:	eor ScrollDir			;Store #$01 if object should be loaded onto name table 3-->
LEB89:	and #$01			;store #$00 if it should be loaded onto name table 0.
LEB8B:	rts				;

;----------------------------------------------------------------------------------------------------

; LoadDoor
; ========

	LoadDoor:
	jsr LEB92
*       jmp EnemyLoop    ; do next room object

LEB92:  iny
	lda ($00),y     ; door info byte
	pha
	jsr Amul16      ; CF = door side (0=right, 1=left)
	php
	lda MapPosX
	clc
	adc MapPosY
	plp
	rol
	and #$03
	tay
	ldx $EC00,y
	pla	     ; retrieve door info
	and #$03
	sta $0307,x     ; door palette
	tya
	pha
	lda $0307,x
	cmp #$01
	beq ++
	cmp #$03
	beq ++
	lda #$0A
	sta $09
	ldy MapPosX
	txa
	jsr Amul16       ; * 16
	bcc +
	dey
*       tya
	jsr LEE41
	jsr LEE4A
	bcs ++
*	lda #$01
	sta ObjAction,x
*       pla
	and #$01	; A = door side (0=right, 1=left)
	tay
	jsr GetNameTable		;($EB85)
	sta ObjectHi,x
	lda DoorXs,y    ; get door's X coordinate
	sta ObjectX,x
	lda #$68	; door Y coord is always #$68
	sta ObjectY,x
	lda LEBFE,y
	tay
	jsr GetNameTable		;($EB85)
	eor #$01
	tax
	tya
	ora DoorOnNameTable3,x
	sta DoorOnNameTable3,x
	lda #$02
	rts

DoorXs:
	.byte $F0	 ; X coord of RIGHT door
	.byte $10	 ; X coord of LEFT door
LEBFE:  .byte $02
	.byte $01
LEC00:  .byte $80
	.byte $B0
	.byte $A0
	.byte $90

; LoadElevator
; ============

	LoadElevator:
	jsr LEC09
	bne ----	   ; branch always

LEC09:  lda ElevatorStatus
	bne +	   ; exit if elevator already present
	iny
	lda ($00),y
	sta $032F
	ldy #$83
	sty $032D       ; elevator Y coord
	lda #$80
	sta $032E       ; elevator X coord
	jsr GetNameTable		;($EB85)
	sta $032C       ; high Y coord
	lda #$23
	sta $0323       ; elevator frame
	inc ElevatorStatus		;1
*       lda #$02
	rts

; LoadStatues
; ===========

	LoadStatues:
	jsr GetNameTable		;($EB85)
	sta $036C
	lda #$40
	ldx RidleyStatueStatus
	bpl +	   ; branch if Ridley statue not hit
	lda #$30
*       sta $0370
	lda #$60
	ldx KraidStatueStatus
	bpl +	   ; branch if Kraid statue not hit
	lda #$50
*       sta $036F
	sty $54
	lda #$01
	sta $0360
*	jmp EnemyLoop   ; do next room object

ZebHole:
LEC57:  ldx #$20
*       txa
	sec
	sbc #$08
	bmi +
	tax
	ldy $0728,x
	iny
	bne -
	ldy #$00
	lda ($00),y
	and #$F0
	sta $0729,x
	iny
	lda ($00),y
	sta $0728,x
	iny
	lda ($00),y
	tay
	and #$F0
	ora #$08
	sta $072A,x
	tya
	jsr Amul16       ; * 16
	ora #$00
	sta $072B,x
	jsr GetNameTable		;($EB85)
	sta $072C,x
*       lda #$03
	bne ---

OnNameTable0:
LEC93:	lda PPUCNT0ZP			;
	eor #$01			;If currently on name table 0,-->
	and #$01			;return #$01. Else return #$00.
	tay				;
	rts				;

UpdateRoomSpriteInfo:
LEC9B:	ldx ScrollDir
	dex
	ldy #$00
	jsr UpdateDoorData		;($ED51)Update name table 0 door data.
	iny
	jsr UpdateDoorData		;($ED51)Update name table 3 door data.
	ldx #$50
	jsr GetNameTable		;($EB85)
	tay
*       tya
	eor EnNameTable,x
	lsr
	bcs +
	lda $0405,x
	and #$02
	bne +
	sta EnStatus,x
*       jsr Xminus16
	bpl --
	ldx #$18
*       tya
	eor $B3,x
	lsr
	bcs +
	lda #$00
	sta $B0,x
*       txa
	sec
	sbc #$08
	tax
	bpl --
	jsr LED65
	jsr LED5B
	jsr GetNameTable		;(EB85)
	asl
	asl
	tay
	ldx #$C0
*       tya
	eor TileWRAMHi,x
	and #$04
	bne +
	sta $0500,x
*       jsr Xminus16
	cmp #$F0
	bne --
	tya
	lsr
	lsr
	tay
	ldx #$D0
	jsr LED7A
	ldx #$E0
	jsr LED7A
	ldx #$F0
	jsr LED7A
	tya
	sec
	sbc $032C
	bne +
	sta ElevatorStatus
*       ldx #$1E
*       lda $0704,x
	bne +
	lda #$FF
	sta $0700,x
*       txa
	sec
	sbc #$06
	tax
	bpl --
	cpy $036C
	bne +
	lda #$00
	sta $0360
*       ldx #$18
*       tya
	cmp $072C,x
	bne +
	lda #$FF
	sta $0728,x
*       txa
	sec
	sbc #$08
	tax
	bpl --
	ldx #$00
	jsr LED8C
	ldx #$08
	jsr LED8C
	jmp $95AE

UpdateDoorData:
LED51:	txa				;
LED52:	eor #$03			;
LED54:	and $006C,y			;Moves door info from one name table to the next-->
LED57:*	sta $006C,y			;when the room is transferred across name tables.
LED5A:	rts				;

LED5B:  jsr GetNameTable		;($EB85)
	eor #$01
	tay
	lda #$00
	beq -
LED65:  ldx #$B0
*       lda ObjAction,x
	beq +
	lda ObjectOnScreen,x
	bne +
	sta ObjAction,x
*       jsr Xminus16
	bmi --
	rts

LED7A:  lda ObjAction,x
	cmp #$05
	bcc +
	tya
	eor ObjectHi,x
	lsr
	bcs +
	sta ObjAction,x
*       rts

LED8C:  tya
	cmp PowerUpNameTable,x
	bne Exit11
	lda #$FF
	sta PowerUpType,x
Exit11: rts

;---------------------------------------[ Setup special items ]--------------------------------------

;The following routines look for special items on the game map and jump to
;the appropriate routine to handle those items.

ScanForItems:
LED98:	lda SpecItmsTable		;Low byte of ptr to 1st item data.
LED9B:	sta $00				;
LED9D:	lda SpecItmsTable+1		;High byte of ptr to 1st item data.

ScanOneItem:
LEDA0:	sta $01				;
LEDA2:	ldy #$00			;Index starts at #$00.
LEDA4:	lda ($00),y			;Load map Ypos of item.-->
LEDA6:	cmp MapPosY			;Does it equal Samus' Ypos on map?-->
LEDA8:	beq +				;If yes, check Xpos too.

LEDAA:	bcs Exit11			;Exit if item Y pos >  Samus Y Pos.
LEDAC:	iny				;
LEDAD:	lda ($00),y			;Low byte of ptr to next item data.
LEDAF:	tax				;
LEDB0:	iny				;
LEDB1:	and ($00),y			;AND with hi byte of item ptr.
LEDB3:	cmp #$FF			;if result is FFh, then this was the last item-->
LEDB5:	beq Exit11			;(item ptr = FFFF). Branch to exit.

LEDB7:	lda ($00),y			;High byte of ptr to next item data.
LEDB9:	stx $00				;Write low byte for next item.
LEDBB:	jmp ScanOneItem			;Process next item.

LEDBE:*	lda #$03			;Get ready to look at byte containing X pos.
LEDC0:	jsr AddToPtr00			;($EF09)Add 3 to pointer at $0000.

ScanItemX:
LEDC3:	ldy #$00			;
LEDC5:	lda ($00),y			;Load map Xpos of object.-->
LEDC7:	cmp MapPosX			;Does it equal Samus' Xpos on map?-->
LEDC9:	beq +				;If so, then load object.
LEDCB:	bcs Exit11			;Exit if item pos X > Samus Pos X.

LEDCD:	iny				;
LEDCE:	jsr AnotherItem			;($EF00)Check for another item on same Y pos.
LEDD1:	jmp ScanItemX			;Try next X coord.

LEDD4:*	lda #$02			;Move ahead two bytes to find item data.

ChooseHandlerRoutine:
LEDD6:	jsr AddToPtr00			;($EF09)Add A to pointer at $0000.
LEDD9:	ldy #$00			;
LEDDB:	lda ($00),y			;Object type
LEDDD:	and #$0F			;Object handling routine index stored in 4 LSBs.
LEDDF:	jsr ChooseRoutine		;($C27C)Load proper handling routine from table below.

;Handler routines jumped to by above code.

LEDE2:	.word ExitSub			;($C45C)rts.
LEDE4:	.word SqueeptHandler		;($EDF8)Some squeepts.
LEDE6:	.word PowerUpHandler		;($EDFE)power-ups.
LEDE8:	.word SpecEnemyHandler		;($EE63)Special enemies(Mellows, Melias and Memus).
LEDEA:	.word ElevatorHandler		;($EEA1)Elevators.
LEDEC:	.word CannonHandler		;($EEA6)Mother brain room cannons.
LEDEE:	.word MotherBrainHandler	;($EEAE)Mother brain.
LEDF0:	.word ZeebetiteHandler		;($EECA)Zeebetites.
LEDF2:	.word RinkaHandler		;($EEEE)Rinkas.
LEDF4:	.word DoorHandler		;($EEF4)Some doors.
LEDF6:	.word PaletteHandler		;($EEFA)Background palette change.

;---------------------------------------[ Squeept handler ]------------------------------------------

SqueeptHandler:
LEDF8:	jsr GetEnemyData		;($EB0C)Load Squeept data.
LEDFB:*	jmp ChooseHandlerRoutine	;($EDD6)Exit handler routines.

;--------------------------------------[ Power-up Handler ]------------------------------------------

PowerUpHandler:
LEDFE:	iny				;Prepare to store item type.
LEDFF:	ldx #$00			;
LEE01:	lda #$FF			;
LEE03:	cmp PowerUpType			;Is first power-up item slot available?-->
LEE06:	beq +				;if yes, branch to load item.

LEE08:	ldx #$08			;Prepare to check second power-up item slot.
LEE0A:	cmp PowerUpBType		;Is second power-up item slot available?-->			
LEE0D:	bne ++				;If not, branch to exit.
LEE0F:*	lda ($00),y			;Power-up item type.
LEE11:	jsr PrepareItemID		;($EE3D)Get unique item ID.
LEE14:	jsr CheckForItem		;($EE4A)Check if Samus already has item.
LEE17:	bcs +				;Samus already has item. do not load it.

LEE19:	ldy #$02			;Prepare to load item coordinates.
LEE1B:	lda $09				;
LEE1D:	sta PowerUpType,x		;Store power-up type in available item slot.
LEE20:	lda ($00),y			;Load x and y screen positions of item.
LEE22:	tay				;Save position data for later processing.
LEE23:	and #$F0			;Extract Y coordinate.
LEE25:	ora #$08			;+ 8 to find  Y coordinate center.
LEE27:	sta PowerUpYCoord,x		;Store center Y coord
LEE2A:	tya				;Reload position data.
LEE2B:	jsr Amul16			;($C2C5)*16. Move lower 4 bits to upper 4 bits.
LEE2E:	ora #$08			;+ 8 to find X coordinate center.
LEE30:	sta PowerUpXCoord,x		;Store center X coord
LEE33:	jsr GetNameTable		;($EB85)Get name table to place item on.
LEE36:	sta PowerUpNameTable,x		;Store name table Item is located on.

LEE39:*	lda #$03			;Get next data byte(Always #$00).
LEE3B:	bne ---				;Branch always to exit handler routines.
	
PrepareItemID:
LEE3D:	sta $09				;Store item type.
LEE3E:	lda MapPosX			;

LEE41:	sta $07				;Store item X coordinate.
LEE42:	lda MapPosY			;
LEE45:	sta $06				;Store item Y coordinate.
LEE47:	jmp CreateItemID		;($DC67)Get unique item ID.

CheckForItem:
LEE4A:	ldy NumberOfUniqueItems		;
LEE4D:	beq +++				;Samus has no unique items. Load item and exit.
LEE4F:*	lda $07				;
LEE51:	cmp NumberOfUniqueItems,y	;Look for lower byte of unique item.
LEE54:	bne +				;
LEE56:	lda $06				;Look for upper byte of unique item.
LEE58:	cmp DataSlot,y			;
LEE5B:	beq +++				;Samus already has item. Branch to exit.
LEE5D:*	dey				;
LEE5E:	dey				;
LEE5F:	bne --				;Loop until all Samus' unique items are checked.
LEE61:*	clc				;Samus does not have the item. It will be placed on screen.
LEE62:*	rts				;

;-----------------------------------------------------------------------------------------------------

SpecEnemyHandler:
LEE63:  ldx #$18
	lda RandomNumber1
	adc FrameCount
	sta $8A
*       jsr LEE86
	txa
	sec
	sbc #$08
	tax
	bpl -
	lda $95E4
	sta $6BE9
	sta $6BEA
	lda #$01
	sta $6BE4
*       jmp ChooseHandlerRoutine	;($EDD6)Exit handler routines.

LEE86:  lda $B0,x
	bne +
	txa
	adc $8A
	and #$7F
	sta $B1,x
	adc RandomNumber2
	sta $B2,x
	jsr GetNameTable		;($EB85)
	sta $B3,x
	lda #$01
	sta $B0,x
	rol $8A
*       rts

ElevatorHandler:
LEEA1:  jsr LEC09
	bne --				;Branch always.

CannonHandler:
LEEA6:  jsr $95B1
	lda #$02
*       jmp ChooseHandlerRoutine	;($EDD6)Exit handler routines.

MotherBrainHandler:
LEEAE:  jsr $95B4
	lda #$38
	sta $07
	lda #$00
	sta $06
	jsr LEE4A
	bcc LEEC6
	lda #$08
	sta MotherBrainStatus
	lda #$00
	sta MotherBrainHits
LEEC6:  lda #$01
	bne -

ZeebetiteHandler:
LEECA:  jsr $95B7
	txa
	lsr
	adc #$3C
	sta $07
	lda #$00
	sta $06
	jsr LEE4A
	bcc +
	lda #$81
	sta $0758,x
	lda #$01
	sta $075D,x
	lda #$07
	sta $075B,x
*       jmp LEEC6

RinkaHandler:
LEEEE:  jsr $95BA
	jmp LEEC6

DoorHandler:
LEEF4:  jsr LEB92
	jmp ChooseHandlerRoutine	;($EDD6)Exit handler routines.

PaletteHandler:
LEEFA:  lda ScrollDir
	sta $91
	bne LEEC6

AnotherItem:
LEF00:	lda ($00),y			;Is there another item with same Y pos?-->
	cmp #$FF			;If so, A is amount to add to ptr. to find X pos.
	bne AddToPtr00			;($EF09)
	pla				;
	pla				;No more items to check. Pull last subroutine-->
	rts				;off stack and exit.

AddToPtr00:
LEF09:	clc				;
	adc $00				;
	sta $00				;A is added to the 16 bit address stored in $0000.
	bcc +				;
	inc $01				;
*       rts				;

;----------------------------------[ Draw structure routines ]----------------------------------------

;Draws one row of the structure.
;A = number of 2x2 tile macros to draw horizontally.

DrawStructRow:
LEF13:	and #$0F			;Row length(in macros). Range #$00 thru #$0F.
LEF15:	bne +				;
LEF17:	lda #$10			;#$00 in row length=16.
LEF19:*	sta $0E				;Store horizontal macro count.
LEF1B:	lda (StructPtr),y		;Get length byte again.
LEF1D:	jsr Adiv16			;($C2BF)/16. Upper nibble contains x coord offset(if any).
LEF20:	asl				;*2, because a macro is 2 tiles wide.
LEF21:	adc CartRAMWorkPtr		;Add x coord offset to CartRAMWorkPtr and save in $00.
LEF23:	sta $00				;
LEF25:	lda #$00			;
LEF27:	adc CartRAMWorkPtr+1		;Save high byte of work pointer in $01.
LEF29:	sta $01				;$0000 = work pointer.

DrawMacro:
LEF2B:	lda $01				;High byte of current location in room RAM.
LEF2D:	cmp #$63			;Check high byte of room RAM address for both room RAMs-->
LEF2F:	beq +				;to see if the attribute table data for the room RAM has-->
LEF31:	cmp #$67			;been reached.  If so, branch to check lower byte as well.
LEF33:	bcc ++				;If not at end of room RAM, branch to draw macro.
LEF35:	beq +				;
LEF37:	rts				;Return if have gone past room RAM(should never happen).

LEF38:*	lda $00				;Low byte of current nametable address.
LEF3A:	cmp #$A0			;Reached attrib table?-->
LEF3C:	bcc +				;If not, branch to draw the macro.
LEF3E:	rts				;Can't draw any more of the structure, exit.

LEF3F:*	inc $10				;Increase struct data index.
LEF41:	ldy $10				;Load struct data index into Y.
LEF43:	lda (StructPtr),y		;Get macro number.
LEF45:	asl				;
LEF46:	asl				;A=macro number * 4. Each macro is 4 bytes long.
LEF47:	sta $11				;Store macro index.
LEF49:	ldx #$03			;Prepare to copy four tile numbers.
LEF4B:*	ldy $11				;Macro index loaded into Y.
LEF4D:	lda (MacroPtr),y		;Get tile number.
LEF4F:	inc $11				;Increase macro index
LEF51:	ldy TilePosTable,x		;get tile position in macro.
LEF54:	sta ($00),y			;Write tile number to room RAM.
LEF56:	dex				;Done four tiles yet?-->
LEF57:	bpl -				;If not, loop to do another.
LEF59:	jsr UpdateAttrib		;($EF9E)Update attribute table if necessary
LEF5C:	ldy #$02			;Macro width(in tiles).
LEF5E:	jsr AddYToPtr00			;($C2A8)Add 2 to pointer to move to next macro.
LEF61:	lda $00				;Low byte of current room RAM work pointer.
LEF63:	and #$1F			;Still room left in current row?-->
LEF65:	bne +				;If yes, branch to do another macro.

;End structure row early to prevent it from wrapping on to the next row..
LEF67:	lda $10				;Struct index.
LEF69:	clc				;
LEF6A:	adc $0E				;Add number of macros remaining in current row.
LEF6C:	sec				;
LEF6D:	sbc #$01			;-1 from macros remaining in current row.
LEF6F:	jmp AdvanceRow			;($EF78)Move to next row of structure.

LEF72:*	dec $0E				;Have all macros been drawn on this row?-->
LEF74:	bne DrawMacro			;If not, branch to draw another macro.
LEF76:	lda $10				;Load struct index.

AdvanceRow:
LEF78:	sec				;Since carry bit is set,-->
LEF79:	adc StructPtr			;addition will be one more than expected.
LEF7B:	sta StructPtr			;Update the struct pointer.
LEF7D:	bcc +				;
LEF7F:	inc StructPtr+1			;Update high byte of struct pointer if carry occured.
LEF81:*	lda #$40			;
LEF83:	clc				;
LEF84:	adc CartRAMWorkPtr		;Advance to next macro row in room RAM(two tile rows).
LEF86:	sta CartRAMWorkPtr		;
LEF88:	bcc DrawStruct			;Begin drawing next structure row.
LEF8A:	inc CartRAMWorkPtr+1		;Increment high byte of pointer if necessary.

DrawStruct:
LEF8C:	ldy #$00			;Reset struct index.
LEF8E:	sty $10				;
LEF90:	lda (StructPtr),y		;Load data byte.
LEF92:	cmp #$FF			;End-of-struct?-->
LEF94:	beq +				;If so, branch to exit.
LEF96:	jmp DrawStructRow		;($EF13)Draw a row of macros.
LEF99:*	rts				;

;The following table is used to draw macros in room RAM. Each macro is 2 x 2 tiles.
;The following table contains the offsets required to place the tiles in each macro.

TilePosTable:
LEF9A:	.byte $21			;Lower right tile.
LEF9B:	.byte $20			;Lower left tile.
LEF9C:	.byte $01			;Upper right tile.
LEF9D:	.byte $00			;Upper left tile.

;---------------------------------[ Update attribute table bits ]------------------------------------

;The following routine updates attribute bits for one 2x2 tile section on the screen.

UpdateAttrib:
LEF9E:	lda ObjectPal			;Load attribute data of structure.
LEFA0:	cmp RoomPal			;Is it the same as the room's default attribute data?-->
LEFA2:	beq +++++			;If so, no need to modify the attribute table, exit.

;Figure out cart RAM address of the byte containing the relevant bits.

LEFA4:	lda $00				;
LEFA6:	sta $02				;
LEFA8:	lda $01				;
LEFAA:	lsr				;
LEFAB:	ror $02				;
LEFAD:	lsr				;
LEFAE:	ror $02				;
LEFB0:	lda $02				;The following section of code calculates the-->
LEFB2:	and #$07			;proper attribute byte that corresponds to the-->
LEFB4:	sta $03				;macro that has just been placed in the room RAM.
LEFB6:	lda $02				;
LEFB8:	lsr				;
LEFB9:	lsr				;
LEFBA:	and #$38			;
LEFBC:	ora $03				;
LEFBE:	ora #$C0			;
LEFC0:	sta $02				;
LEFC2:	lda #$63			;
LEFC4:	sta $03				;$0002 contains pointer to attribute byte.

LEFC6:	ldx #$00			;
LEFC8:	bit $00				;
LEFCA:	bvc +				;
LEFCC:	ldx #$02			;The following section of code figures out which-->
LEFCE:*	lda $00				;pair of bits to modify in the attribute table byte-->
LEFD0:	and #$02			;for the macro that has just been placed in the-->
LEFD2:	beq +				;room RAM.
LEFD4:	inx				;

;X now contains which macro attribute table bits to modify:
;+---+---+
;| 0 | 1 |
;+---+---+
;| 2 | 3 |
;+---+---+
;Where each box represents a macro(2x2 tiles).

;The following code clears the old attribute table bits and sets the new ones.
LEFD5:*	lda $01				;Load high byte of work pointer in room RAM.
LEFD7:	and #$04			;
LEFD9:	ora $03				;Choose proper attribute table associated with the-->
LEFDB:	sta $03				;current room RAM.
LEFDD:	lda AttribMaskTable,x		;Choose appropriate attribute table bit mask from table below.
LEFE0:	ldy #$00			;
LEFE2:	and ($02),y			;clear the old attribute table bits.
LEFE4:	sta ($02),y			;
LEFE6:	lda ObjectPal			;Load new attribute table data(#$00 thru #$03).
LEFE8:*	dex				;
LEFE9:	bmi +				;
LEFEB:	asl				;
LEFEC:	asl				;Attribute table bits shifted one step left
LEFED:	bcc -				;Loop until attribute table bits are in the proper location.
LEFEF:*	ora ($02),y			;
LEFF1:	sta ($02),y			;Set attribute table bits.
LEFF3:*	rts				;

AttribMaskTable:
LEFF4:	.byte %11111100			;Upper left macro.
LEFF5:	.byte %11110011			;Upper right macro.
LEFF6:	.byte %11001111			;Lower left macro.
LEFF7:	.byte %00111111			;Lower right macro.

;------------------------[ Initialize room RAM and associated attribute table ]-----------------------

InitTables:
LEFF8:	lda CartRAMPtr+1		;#$60 or #$64.
LEFFA:	tay				;
LEFFB:	tax				;Save value to create counter later.
LEFFC:	iny				;
LEFFD:	iny				;High byte of address to fill to ($63 or $67).
LEFFE:	iny				;
LEFFF:	lda #$FF			;Value to fill room RAM with.
LF001:	jsr FillRoomRAM			;($F01C)Fill entire RAM for designated room with #$FF.

LF004:	ldx $01				;#$5F or #$63 depening on which room RAM was initialized.
LF006:	jsr Xplus4			;($E193)X = X + 4.
LF009:	stx $01				;Set high byte for attribute table write(#$63 or #$67).
LF00B:	ldx RoomPal			;Index into table below (Lowest 2 bits).
LF00D:	lda ATDataTable,x		;Load attribute table data from table below.
LF010:	ldy #$C0			;Low byte of start of all attribute tables.
LF012:*	sta ($00),y			;Fill attribute table.
LF014:	iny				;
LF015:	bne -				;Loop until entire attribute table is filled.
LF017:	rts				;

ATDataTable:       
LF018:	.byte %00000000			;
LF019:	.byte %01010101			;Data to fill attribute tables with.
LF01A:	.byte %10101010			;
LF01B:	.byte %11111111			;

FillRoomRAM:
LF01C:	pha				;Temporarily store A.
LF01D:	txa				;
LF01E:	sty $01				;Calculate value to store in X to use as upper byte-->
LF020:	clc				;counter for initilaizing room RAM(X=#$FC).-->
LF021:	sbc $01				;Since carry bit is cleared, result is one less than expected.
LF023:	tax				;
LF024:	pla				;Restore value to fill room RAM with(#$FF).
LF025:	ldy #$00			;Lower address byte to start at.
LF027:	sty $00				;
LF029:*	sta ($00),y			;
LF02B:	dey				;
LF02C:	bne -				;
LF02E:	dec $01				;Loop until all the room RAM is filled with #$FF(black).
LF030:	inx				;
LF031:	bne -				;
LF033:	rts				;

;----------------------------------------------------------------------------------------------------

; Crash detection
; ===============

LF034:  lda #$FF
	sta $73
	sta $010F
; check for crash with Memus
	ldx #$18
*      lda $B0,x
	beq +++++	    ; branch if no Memu in slot
	cmp #$03
	beq +++++
	jsr LF19A
	jsr IsSamusDead
	beq +
	lda SamusBlink
	bne +
	ldy #$00
	jsr LF149
	jsr LF2B4
    ; check for crash with bullets
*       ldy #$D0
*       lda ObjAction,y       ; projectile active?
	beq ++		  ; try next one if not
	cmp #wa_BulletExplode
	bcc +
	cmp #$07
	beq +
	cmp #wa_BombExplode
	beq +
	cmp #wa_Missile
	bne ++
*       jsr LF149
	jsr LF32A
*      jsr Yplus16
	bne ---
*	txa
	sec
	sbc #$08		; each Memu occupies 8 bytes
	tax
	bpl ------

	ldx #$B0
*       lda ObjAction,x
	cmp #$02
	bne +
	ldy #$00
	jsr IsSamusDead
	beq ++
	jsr LDC7F
	jsr LF277
*       jsr Xminus16
	bmi --
; enemy <--> bullet/missile/bomb detection
*	ldx #$50		; start with enemy slot #5
LF09F:  lda EnStatus,x	     ; slot active?
	beq +		   ; branch if not
	cmp #$03
*       beq NextEnemy	   ; next slot
	jsr LF152
	lda EnStatus,x
	cmp #$05
	beq ++++
	ldy #$D0		; first projectile slot
*       lda ObjAction,y	 ; is it active?
	beq ++		  ; branch if not
	cmp #wa_BulletExplode
	bcc +
	cmp #$07
	beq +
	cmp #wa_BombExplode
	beq +
	cmp #wa_Missile
	bne ++
; check if enemy is actually hit
*       jsr LF140
	jsr LF2CA
*	jsr Yplus16	     ; next projectile slot
	bne ---
*	ldy #$00
	lda SamusBlink
	bne NextEnemy
	jsr IsSamusDead
	beq NextEnemy
	jsr LF140
	jsr LF282
	NextEnemy:
	jsr Xminus16
	bmi +
	jmp LF09F

*       ldx #$00
	jsr LF172
	ldy #$60
*       lda EnStatus,y
	beq +
	cmp #$05
	beq +
	lda SamusBlink
	bne +
	jsr IsSamusDead
	beq +
	jsr LF1B3
	jsr LF162
	jsr LF1FA
	jsr LF2ED
*       jsr Yplus16
	cmp #$C0
	bne --
	ldy #$00
	jsr IsSamusDead
	beq ++++
	jsr LF186
	ldx #$F0
*       lda ObjAction,x
	cmp #$07
	beq +
	cmp #$0A
	bne ++
*       jsr LDC82
	jsr LF311
*	jsr Xminus16
	cmp #$C0
	bne ---			
*	jmp SubtractHealth		;($CE92)

LF140:  jsr LF1BF
	jsr LF186
	jmp LF1FA

LF149:  jsr LF186
	jsr LF1D2
	jmp LF1FA

LF152:  lda EnYRoomPos,x
	sta $07	 ; Y coord
	lda EnXRoomPos,x
	sta $09	 ; X coord
	lda EnNameTable,x     ; hi coord
	jmp LF17F

LF162:  lda EnYRoomPos,y     ; Y coord
	sta $06
	lda EnXRoomPos,y     ; X coord
	sta $08
	lda EnNameTable,y     ; hi coord
	jmp LF193

LF172:  lda ObjectY,x
	sta $07
	lda ObjectX,x
	sta $09
	lda ObjectHi,x
LF17F:  eor PPUCNT0ZP
	and #$01
	sta $0B
	rts

LF186:  lda ObjectY,y
	sta $06
	lda ObjectX,y
	sta $08
	lda ObjectHi,y
LF193:  eor PPUCNT0ZP
	and #$01
	sta $0A
	rts

LF19A:  lda $B1,x
	sta $07
	lda $B2,x
	sta $09
	lda $B3,x
	jmp LF17F

LF1A7:  lda ObjRadY,x
	jsr LF1E0
	lda ObjRadX,x
	jmp LF1D9

LF1B3:  lda ObjRadY,x
	jsr LF1E7
	lda ObjRadX,x
	jmp LF1CB

LF1BF:  lda EnRadY,x
	jsr LF1E0
	lda EnRadX,x
	jmp LF1D9

LF1CB:  clc
	adc EnRadX,y
	sta $05
	rts

LF1D2:  lda #$04
	jsr LF1E0
	lda #$08
LF1D9:  clc
	adc ObjRadX,y
	sta $05
	rts

LF1E0:  clc
	adc ObjRadY,y
	sta $04
	rts

LF1E7:  clc
	adc EnRadY,y
	sta $04
	rts

; Y = Y + 16

	Yplus16:
	tya
	clc
	adc #$10
	tay
	rts

; X = X - 16

	Xminus16:
	txa
	sec
	sbc #$10
	tax
	rts

LF1FA:  lda #$02
	sta $10
	and ScrollDir
	sta $03
	lda $07
	sec
	sbc $06     ; Y
	sta $00
	lda $03
	bne ++
	lda $0B
	eor $0A
	beq ++
	jsr LF262
	lda $00
	sec
	sbc #$10
	sta $00
	bcs +
	dec $01
*       jmp LF22B

*      lda #$00
	sbc #$00
	jsr LF266
LF22B:  sec
	lda $01
	bne ++
	lda $00
	sta $11
	cmp $04
	bcs ++
	asl $10
	lda $09
	sec
	sbc $08
	sta $00
	lda $03
	beq +
	lda $0B
	eor $0A
	beq +
	jsr LF262
	jmp LF256

*       sbc #$00
	jsr LF266
LF256:  sec
	lda $01
	bne +
	lda $00
	sta $0F
	cmp $05
*      rts

LF262:  lda $0B
	sbc $0A
LF266:  sta $01
	bpl +
	jsr LE449
	inc $10
*       rts

LF270:  ora $030A,x
	sta $030A,x
	rts

LF277:  bcs Exit17
LF279:  lda $10
LF27B:  ora $030A,y
	sta $030A,y
	Exit17:
	rts

LF282:  bcs Exit17
	jsr LF2E8
	jsr IsScrewAttackActive		;($CD9C)Check if screw attack active.
	ldy #$00
	bcc +++
	lda EnStatus,x
	cmp #$04
	bcs Exit17
	lda EnDataIndex,x
*       sta $010F
	tay
	bmi +
	lda $968B,y
	and #$10
	bne Exit17
*       ldy #$00
	jsr LF338
	jmp LF306

*	lda #$81
	sta $040E,x
	bne ++
LF2B4:  bcs +
	jsr IsScrewAttackActive		;($CD9C)Check if screw attack active.
	ldy #$00
	lda #$C0
	bcs ---
LF2BF:  lda $B6,x
	and #$F8
	ora $10
	eor #$03
	sta $B6,x
*       rts

LF2CA:  bcs +++
	lda ObjAction,y
	sta $040E,x
	jsr LF279
*	jsr LF332
*       ora $0404,x
	sta $0404,x
*       rts

LF2DF:  lda $10
	ora $0404,y
	sta $0404,y
	rts

LF2E8:  jsr LF340
	bne --
LF2ED:  bcs +
	jsr LF2DF
	tya
	pha
	jsr IsScrewAttackActive		;($CD9C)Check if screw attack active.
	pla
	tay
	bcc +
	lda #$80
	sta $010F
	jsr LF332
	jsr LF270
LF306:  lda $95CE
	sta HealthLoChange
	lda $95CF
	sta HealthHiChange
*       rts

LF311:  bcs Exit22
	lda #$E0
	sta $010F
	jsr LF338
	lda $0F
	beq +
	lda #$01
*       sta $73

ClearHealthChange:
LF323:	lda #$00
LF325:	sta HealthLoChange
LF327:	sta HealthHiChange

Exit22: 
LF329:	rts				;Return for routine above and below.

LF32A:  bcs Exit22
	jsr LF279
	jmp LF2BF

LF332:  jsr LF340
	jmp Amul8       ; * 8

LF338:  lda $10
	asl
	asl
	asl
	jmp LF27B

LF340:  lda $10
	eor #$03
	rts

; UpdateEnemies
; =============

UpdateEnemies:
LF345:	ldx #$50		;Load x with #$50
*       jsr DoOneEnemy			;($F351)
	ldx PageIndex
	jsr Xminus16
	bne -
DoOneEnemy:
LF351:	stx PageIndex		;PageIndex starts at $50 and is subtracted by $F each iteration.
				;There is a max of 6 enemies at a time.
	ldy EnStatus,x
	beq +
	cpy #$03
	bcs +
	jsr LF37F
*       jsr LF3AA
	lda EnStatus,x
	sta $81
	cmp #$07
	bcs +
	jsr ChooseRoutine

; Pointer table to code

	.word ExitSub       ;($C45C) rts
	.word $F3BE
	.word $F3E6
	.word $F40D
	.word $F43E
	.word $F483
	.word $F4EE

*       jmp KillObject			;($FA18)Free enemy data slot.

LF37F:  lda $0405,x
	and #$02
	bne +
	lda EnYRoomPos,x     ; Y coord
	sta $0A
	lda EnXRoomPos,x     ; X coord
	sta $0B
	lda EnNameTable,x     ; hi coord
	sta $06
	lda EnRadY,x
	sta $08
	lda EnRadX,x
	sta $09
	jsr IsObjectVisible		;($DFDF)Determine if object is within the screen boundaries.
	txa
	bne +
	pla
	pla
*       ldx PageIndex
	rts

LF3AA:  lda $0405,x
	asl
	rol
	tay
	txa
	jsr Adiv16			;($C2BF)/16.
	eor FrameCount
	lsr
	tya
	ror
	ror
	sta $0405,x
	rts

LF3BE:  lda $0405,x
	asl
	bmi +
	lda #$00
	sta $6B01,x
	sta EnCounter,x
	sta $040A,x
	jsr LF6B9
	jsr LF75B
	jsr LF682
	jsr LF676
	lda EnDelay,x
	beq +
	jsr LF7BA
*       jmp ++

LF3E6:  lda $0405,x
	asl
	bmi ++
	lda $0405,x
	and #$20
	beq +
	ldy EnDataIndex,x
	lda EnemyInitDelayTbl,y		;($96BB)
	sta EnDelay,x
	dec EnStatus,x
	bne ++
*       jsr LF6B9
	jsr LF75B
	jsr LF51E
LF40A:*	jsr LF536
	jmp $95E5

LF410:	jsr UpdateEnemyAnim
	jsr $8058
LF416:  ldx PageIndex
	lda EnSpecialAttribs,x
	bpl +
	lda ObjectCntrl
	bmi +
	lda #$A3
LF423:  sta ObjectCntrl
*       lda EnStatus,x
	beq LF42D
	jsr LDD8B
LF42D:  ldx PageIndex
	lda #$00
	sta $0404,x
	sta $040E,x
	rts

LF438:  jsr UpdateEnemyAnim
LF43B:  jmp LF416

LF43E:  jsr LF536
	lda EnStatus,x
	cmp #$03
	beq LF410
	bit ObjectCntrl
	bmi +
	lda #$A1
	sta ObjectCntrl
*       lda FrameCount
	and #$07
	bne +
	dec $040D,x
	bne +
	lda EnStatus,x
	cmp #$03
	beq +
	lda $040C,x
	sta EnStatus,x
	ldy EnDataIndex,x
	lda $969B,y
	sta $040D,x
*       lda $040D,x
	cmp #$0B
	bcs +
	lda FrameCount
	and #$02
	beq +
	asl ObjectCntrl
*       jmp LF416

LF483:  lda $0404,x
	and #$24
	beq ++++++
	jsr KillObject			;($FA18)Free enemy data slot.
	ldy EnAnimFrame,x
	cpy #$80
	beq PickupMissile
	tya
	pha
	lda EnDataIndex,x
	pha
	ldy #$00
	ldx #$03
	pla
	bne ++
	dex
	pla
	cmp #$81
	bne +
	ldx #$00			;Increase HealthHi by 0.
	ldy #$50			;Increase HealthLo by 5.
*       pha
*	pla				
	sty HealthLoChange
	stx HealthHiChange
	jsr AddHealth			;($CEF9)Add health to Samus.
	jmp SFX_EnergyPickup

PickupMissile:
	lda #$02
	ldy EnDataIndex,x
	beq +
	lda #$1E
*       clc
	adc MissileCount
	bcs +		   ; can't have more than 255 missiles
	cmp MaxMissiles	 ; can Samus hold this many missiles?
	bcc ++		  ; branch if yes
*       lda MaxMissiles	 ; set to max. # of missiles allowed
*	sta MissileCount
	jmp SFX_MissilePickup

*	lda FrameCount
	and #$03
	bne +
	dec $040D,x
	bne +
	jsr KillObject			;($FA18)Free enemy data slot.
*	lda FrameCount
	and #$02
	lsr
	ora #$A0
	sta ObjectCntrl
	jmp LF416

LF4EE:  dec EnSpecialAttribs,x
	bne ++
	lda $040C,x
	tay
	and #$C0
	sta EnSpecialAttribs,x
	tya
	and #$3F
	sta EnStatus,x
	pha
	jsr $80B0
	and #$20
	beq +
	pla
	jsr LF515
	pha
*       pla
*	lda #$A0
	jmp LF423

LF515:  sta $040C,x
LF518:  lda #$04
	sta EnStatus,x
	rts

LF51E:  lda ScrollDir
	ldx PageIndex
	cmp #$02
	bcc ++
	lda EnYRoomPos,x     ; Y coord
	cmp #$EC
	bcc ++
	jmp KillObject			;($FA18)Free enemy data slot.

*       jsr SFX_MetroidHit
	jmp GetPageIndex

LF536:  lda EnSpecialAttribs,x
	sta $0A
	lda $0404,x
	and #$20
	beq +
	lda $040E,x
	cmp #$03
	bne +++
	bit $0A
	bvs +++
	lda EnStatus,x
	cmp #$04
	beq +++
	jsr LF515
	lda #$40
	sta $040D,x
	jsr $80B0
	and #$20
	beq +
	lda #$05
	sta EnHitPoints,x
	jmp $95A8
*       rts

*	jsr $80B0
	and #$20
	bne ---
	jsr SFX_Metal
	jmp LF42D

*	lda EnHitPoints,x
	cmp #$FF
	beq --
	bit $0A
	bvc +
	jsr SFX_BossHit
	bne ++
*	jsr LF74B
	and #$0C
	beq PlaySnd1
	cmp #$04
	beq PlaySnd2
	cmp #$08
	beq PlaySnd3
	jsr SFX_MetroidHit
	bne +       ; branch always
PlaySnd1:
	jsr SFX_EnemyHit
	bne +       ; branch always
PlaySnd2:
	jsr SFX_EnemyHit
	bne +       ; branch always
PlaySnd3:
	jsr SFX_BigEnemyHit		;($CBCE)
*	ldx PageIndex
	jsr $80B0
	and #$20
	beq +
	lda $040E,x
	cmp #$0B
	bne ----
*       lda EnStatus,x
	cmp #$04
	bne +
	lda $040C,x
*       ora $0A
	sta $040C,x
	asl
	bmi +
	jsr $80B0
	and #$20
	bne +
	ldy $040E,x
	cpy #$0B
	beq +++++
	cpy #$81
	beq +++++
*       lda #$06
	sta EnStatus,x
	lda #$0A
	bit $0A
	bvc +
	lda #$03
*       sta EnSpecialAttribs,x
	cpy #$02
	beq +
	bit $0A
	bvc ++
	ldy $040E,x
	cpy #$0B
	bne ++
	dec EnHitPoints,x
	beq +++
	dec EnHitPoints,x
	beq +++
*       dec EnHitPoints,x
	beq ++
*	dec EnHitPoints,x
	bne GetPageIndex
*	lda #$03
	sta EnStatus,x
	bit $0A
	bvs +
	lda $040E,x
	cmp #$02
	bcs +
	lda #$00
	jsr LDCFC
	ldx PageIndex
*       jsr LF844
	lda $960B,y
	jsr LF68D
	sta EnCounter,x
	ldx #$C0
*       lda EnStatus,x
	beq +
	txa
	clc
	adc #$08
	tax
	cmp #$E0
	bne -
	beq GetPageIndex
*       lda $95DD
	jsr LF68D
	lda #$0A
	sta EnCounter,x
	inc EnStatus,x
	lda #$00
	bit $0A
	bvc +
	lda #$03
*       sta $0407,x
	ldy PageIndex
	lda EnYRoomPos,y
	sta EnYRoomPos,x
	lda EnXRoomPos,y
	sta EnXRoomPos,x
	lda EnNameTable,y
	sta EnNameTable,x
	GetPageIndex:
	ldx PageIndex
	rts

LF676:  jsr $80B0
	asl
	asl
	asl
	and #$C0
	sta $6B03,x
	rts

LF682:  jsr LF844
	lda $963B,y
	cmp EnResetAnimIndex,x
	beq +
LF68D:  sta EnResetAnimIndex,x
LF690:  sta EnAnimIndex,x
LF693:  lda #$00
	sta EnAnimDelay,x
*       rts

LF699:  jsr LF844
	lda $965B,y
	cmp EnResetAnimIndex,x
	beq Exit12
	jsr LF68D
	ldy EnDataIndex,x
	lda $967B,y
	and #$7F
	beq Exit12
	tay
*       dec EnAnimIndex,x
	dey
	bne -
Exit12: rts

LF6B9:  lda #$00
	sta $82
	jsr LF74B
	tay
	lda EnStatus,x
	cmp #$02
	bne +
	tya
	and #$02
	beq Exit12
*       tya
	dec $040D,x
	bne Exit12
	pha
	ldy EnDataIndex,x
	lda $969B,y
	sta $040D,x
	pla
	bpl ++++
	lda #$FE
	jsr LF7B3
	lda ScrollDir
	cmp #$02
	bcc +
	jsr LF752
	bcc +
	tya
	eor PPUCNT0ZP
	bcs +++
*       lda EnXRoomPos,x
	cmp ObjectX
	bne +
	inc $82
*       rol
*	and #$01
	jsr LF744
	lsr
	ror
	eor $0403,x
	bpl +
	jsr $81DA
*	lda #$FB
	jsr LF7B3
	lda ScrollDir
	cmp #$02
	bcs +
	jsr LF752
	bcc +
	tya
	eor PPUCNT0ZP
	bcs +++
*	lda EnYRoomPos,x
	cmp ObjectY
	bne +
	inc $82
	inc $82
*	rol
*	and #$01
	asl
	asl
	jsr LF744
	lsr
	lsr
	lsr
	ror
	eor $0402,x
	bpl +
	jmp $820F

LF744:  ora $0405,x
	sta $0405,x
*       rts

LF74B:  ldy EnDataIndex,x
	lda $968B,y
	rts

LF752:  lda EnNameTable,x
	tay
	eor ObjectHi
	lsr
	rts

LF75B:  lda #$E7
	sta $06
	lda #$18
	jsr LF744
	ldy EnDataIndex,x
	lda $96AB,y
	beq +++++
	tay
	lda $0405,x
	and #$02
	beq ++++
	tya
	ldy #$F7
	asl
	bcs +
	ldy #$EF
*       lsr
	sta $02
	sty $06
	lda ObjectY
	sta $00
	ldy EnYRoomPos,x
	lda $0405,x
	bmi +
	ldy ObjectX
	sty $00
	ldy EnXRoomPos,x
*       lda ObjectHi
	lsr
	ror $00
	lda EnNameTable,x
	lsr
	tya
	ror
	sec
	sbc $00
	bpl +
	jsr TwosCompliment		;($C3D4)
*       lsr
	lsr
	lsr
	cmp $02
	bcc ++
*	lda $06
LF7B3:  and $0405,x
	sta $0405,x
*	rts

LF7BA:  dec EnDelay,x
	bne +
	lda $0405,x
	and #$08
	bne ++
	inc EnDelay,x
*       rts

*	lda EnDataIndex,x
	cmp #$07
	bne +
	jsr SFX_OutOfHole
	ldx PageIndex
*	inc EnStatus,x
	jsr LF699
	ldy EnDataIndex,x
	lda $96CB,y
	clc
	adc #$D1
	sta $00
	lda #$00
	adc #$97
	sta $01
	lda FrameCount
	eor RandomNumber1
	ldy #$00
	and ($00),y
	tay
	iny
	lda ($00),y
	sta $0408,x
	jsr $80B0
	bpl ++
	lda #$00
	sta EnCounter,x
	sta $0407,x
	ldy $0408,x
	lda $972B,y
	sta $6AFE,x
	lda $973F,y
	sta $6AFF,x
	lda $9753,y
	sta $0402,x
	lda $9767,y
	sta $0403,x
	lda $0405,x
	bmi +
	lsr
	bcc ++
	jsr $81D1
	jmp ++

*       and #$04
	beq +
	jsr $8206
*	lda #$DF
	jmp LF7B3

LF83E:  lda $0405,x
LF841:  jmp +

LF844:  lda $0405,x
	bpl +
	lsr
	lsr
*	lsr
	lda EnDataIndex,x
	rol
	tay
	rts

LF852:  txa
	lsr
	lsr
	lsr
	adc FrameCount
	lsr
	rts

LF85A:  ldy EnDataIndex,x
	lda $969B,y
	sta $040D,x
	lda EnemyHitPointTbl,y		;($962B)
	ldy EnSpecialAttribs,x
	bpl +
	asl
*       sta EnHitPoints,x
*       rts

LF870:  lda $0405,x
	and #$10
	beq -
	lda $87
	and EnStatus,x
	beq -
	lda $87
	bpl +
	ldy $6B01,x
	bne -
*       jsr LF8E8
	bcs ++
	sta $0404,y
	jsr LF92C
	lda $0405,x
	lsr
	lda $85
	pha
	rol
	tax
	lda $978B,x
	pha
	tya
	tax
	pla
	jsr LF68D
	ldx PageIndex
	lda #$01
	sta EnStatus,y
	and $0405,x
	tax
	lda Table15,x
	sta $0403,y
	lda #$00
	sta $0402,y
	ldx PageIndex
	jsr LF8F8
	lda $0405,x
	lsr
	pla
	tax
	lda $97A3,x
	sta $04
	txa
	rol
	tax
	lda $979B,x
	sta $05
	jsr LF91D
	ldx PageIndex
	bit $87
	bvc ++
	lda $0405,x
	and #$01
	tay
	lda $0083,y
	jmp LF690

LF8E8:  ldy #$60
	clc
*       lda EnStatus,y
	beq +
	jsr Yplus16
	cmp #$C0
	bne -
*       rts

LF8F8:  lda $85
	cmp #$02
	bcc +
	ldx PageIndex
	lda $0405,x
	lsr
	lda $88
	rol
	and #$07
	sta $040A,y
	lda #$02
	sta EnStatus,y
	lda #$00
	sta EnDelay,y
	sta EnAnimDelay,y
	sta $0408,y
*       rts

LF91D:  ldx PageIndex
	jsr LE792
	tya
	tax
	jsr LFD8F
	jmp LFA49

; Table used by above subroutine

Table15:
	.byte $02
	.byte $FE

LF92C:  lda #$02
	sta EnRadY,y
	sta EnRadX,y
	ora $0405,y
	sta $0405,y
	rts

LF93B:  ldx #$B0
*       jsr LF949
	ldx PageIndex
	jsr Xminus16
	cmp #$60
	bne -
LF949:  stx PageIndex
	lda $0405,x
	and #$02
	bne +
	jsr KillObject			;($FA18)Free enemy data slot.
*       lda EnStatus,x
	beq Exit19
	jsr ChooseRoutine

; Pointer table to code

	.word ExitSub     ;($C45C) rts
	.word $F96A
	.word LF991       ; spit dragon's fireball
	.word ExitSub     ;($C45C) rts
	.word $FA6B
	.word $FA91

Exit19: rts

LF96A:  jsr LFA5B
	jsr LFA1E
	ldx PageIndex
	bcs LF97C
	lda EnStatus,x
	beq Exit19
	jsr LFA60
LF97C:  lda #$01
LF97E:  jsr UpdateEnemyAnim
	jmp LDD8B

*       inc $0408,x
LF987:  inc $0408,x
	lda #$00
	sta EnDelay,x
	beq +
LF991:  jsr LFA5B
	lda $040A,x
	and #$FE
	tay
	lda $97A7,y
	sta $0A
	lda $97A8,y
	sta $0B
*       ldy $0408,x
	lda ($0A),y
	cmp #$FF
	bne +
	sta $0408,x
	jmp LF987

*       cmp EnDelay,x
	beq ---
	inc EnDelay,x
	iny
	lda ($0A),y
	jsr $8296
	ldx PageIndex
	sta $0402,x
	lda ($0A),y
	jsr $832F
	ldx PageIndex
	sta $0403,x
	tay
	lda $040A,x
	lsr
	php
	bcc +
	tya
	jsr TwosCompliment		;($C3D4)
	sta $0403,x
*       plp
	bne +
	lda $0402,x
	beq +
	bmi +
	ldy $040A,x
	lda $95E0,y
	sta EnResetAnimIndex,x
*       jsr LFA1E
	ldx PageIndex
	bcs ++
	lda EnStatus,x
	beq Exit20
	ldy #$00
	lda $040A,x
	lsr
	beq +
	iny
*       lda $95E2,y
	jsr LF68D
	jsr LF518
	lda #$0A
	sta EnDelay,x
*       jmp LF97C

KillObject:
LFA18:	lda #$00			;
LFA1A:	sta EnStatus,x			;Store #$00 as enemy status(enemy slot is open).
LFA1D:	rts				;

; enemy<-->background crash detection

LFA1E:  lda InArea
	cmp #$11
	bne +
	lda EnStatus,x
	lsr
	bcc ++
*       jsr LFA7D
	ldy #$00
	lda ($04),y
	cmp #$A0
	bcc ++
	ldx PageIndex
*       lda $0403,x
	sta $05
	lda $0402,x
	sta $04
LFA41:  jsr LE792
	jsr LFD8F
	bcc KillObject			;($FA18)Free enemy data slot.
LFA49:  lda $08
	sta EnYRoomPos,x
	lda $09
	sta EnXRoomPos,x
	lda $0B
	and #$01
	sta EnNameTable,x
*       rts

LFA5B:  lda $0404,x
	beq Exit20
LFA60:  lda #$00
	sta $0404,x
	lda #$05
	sta EnStatus,x
Exit20: rts

LFA6B:  lda EnAnimFrame,x
	cmp #$F7
	beq +
	dec EnDelay,x
	bne ++
*       jsr KillObject			;($FA18)Free enemy data slot.
*       jmp LF97C

LFA7D:  ldx PageIndex
	lda EnYRoomPos,x
	sta $02
	lda EnXRoomPos,x
	sta $03
	lda EnNameTable,x
	sta $0B
	jmp MakeWRAMPtr

LFA91:  jsr KillObject			;($FA18)Free enemy data slot.
	lda $95DC
	jsr LF68D
	jmp LF97C

LFA9D:  ldx #$C0
*       stx PageIndex
	lda EnStatus,x
	beq +
	jsr LFAB4
*       lda PageIndex
	clc
	adc #$08
	tax
	cmp #$E0
	bne --
*      rts

LFAB4:  dec EnCounter,x
	bne ++
	lda #$0C
	sta EnCounter,x
	dec $0407,x
	bmi +
	bne ++
*       jsr KillObject			;($FA18)Free enemy data slot.
*	lda EnCounter,x
	cmp #$09
	bne +
	lda $0407,x
	asl
	tay
	lda Table16,y
	sta $04
	lda Table16+1,y
	sta $05
	jsr LFA41
*       lda #$80
	sta ObjectCntrl
	lda #$03
	jmp LF97E

; Table used by above subroutine

Table16:
	.byte $00
	.byte $00
	.byte $0C
	.byte $1C
	.byte $10
	.byte $F0
	.byte $F0
	.byte $08

LFAF2:  ldy #$18
*       jsr LFAFF
	lda PageIndex
	sec
	sbc #$08
	tay
	bne -

LFAFF:  sty PageIndex
	ldx $0728,y
	inx
	beq -----
	ldx $0729,y
	lda EnStatus,x
	beq +
	lda $0405,x
	and #$02
	bne Exit13
*       sta $0404,x
	lda #$FF
	cmp EnDataIndex,x
	bne +
	dec EnDelay,x
	bne Exit13
	lda $0728,y
	jsr LEB28
	ldy PageIndex
	lda $072A,y
	sta EnYRoomPos,x
	lda $072B,y
	sta EnXRoomPos,x
	lda $072C,y
	sta EnNameTable,x
	lda #$18
	sta EnRadX,x
	lda #$0C
	sta EnRadY,x
	ldy #$00
	jsr LF186
	jsr LF152
	jsr LF1BF
	jsr LF1FA
	bcc Exit13
	lda #$01
	sta EnDelay,x
	sta EnStatus,x
	and ScrollDir
	asl
	sta $0405,x
	ldy EnDataIndex,x
	jsr LFB7B
	jmp LF85A

*       sta EnDataIndex,x
	lda #$01
	sta EnDelay,x
	jmp KillObject			;($FA18)Free enemy data slot.

LFB7B:  jsr $80B0
	ror $0405,x
	lda EnemyInitDelayTbl,y		;($96BB)Load initial delay for enemy movement.
	sta EnDelay,x		;

Exit13: 
	rts				;Exit from multiple routines.

LFB88:  ldx PageIndex
	jsr LF844
	lda $6B01,x
	inc $6B03,x
	dec $6B03,x
	bne +
	pha
	pla
*       bpl +
	jsr TwosCompliment		;($C3D4)
*       cmp #$08
	bcc +
	cmp #$10
	bcs Exit13
	tya
	and #$01
	tay
	lda $0085,y
	cmp EnResetAnimIndex,x
	beq Exit13
	sta EnAnimIndex,x
	dec EnAnimIndex,x
	sta EnResetAnimIndex,x
	jmp LF693

*       lda $963B,y
	cmp EnResetAnimIndex,x
	beq Exit13
	jmp LF68D

LFBCA:  ldx PageIndex
	jsr LF844
	lda $965B,y
	cmp EnResetAnimIndex,x
	beq Exit13
	sta EnResetAnimIndex,x
	jmp LF690

LFBDD:  lda #$40
	sta PageIndex
	ldx #$0C
*       jsr LFBEC
	dex
	dex
	dex
	dex
	bne -
LFBEC:  lda $A0,x
	beq ++
	dec $A0,x
	txa
	lsr
	tay
	lda Table17,y
	sta $04
	lda Table17+1,y
	sta $05
	lda $A1,x
	sta $08
	lda $A2,x
	sta $09
	lda $A3,x
	sta $0B
	jsr LFD8F
	bcc +++
	lda $08
	sta $A1,x
	sta $034D
	lda $09
	sta $A2,x
	sta $034E
	lda $0B
	and #$01
	sta $A3,x
	sta $034C
	lda $A3,x
	sta $034C
	lda #$5A
	sta $0343
	txa
	pha
	jsr DrawFrame
	lda SamusBlink
	bne +
	ldy #$00
	ldx #$40
	jsr LDC7F
	bcs +
	jsr IsScrewAttackActive		;($CD9C)Check if screw attack active.
	ldy #$00
	bcc +
	clc
	jsr LF311
	lda #$50
	sta HealthLoChange
	jsr SubtractHealth		;($CE92)
*       pla
	tax
*      rts

*     lda #$00
	sta $A0,x
	rts

; Table used by above subroutine

Table17:
	.byte $00
	.byte $FB
	.byte $FB
	.byte $FE
	.byte $FB
	.byte $02
	.byte $00
	.byte $05

LFC65:  lda $6BE4
	beq ++
	ldx #$F0
	stx PageIndex
	lda $6BE9
	cmp $95E4
	bne +++
	lda #$03
	jsr UpdateEnemyAnim
	lda RandomNumber1
	sta $8A
	lda #$18
*       pha
	tax
	jsr LFC98
	pla
	tax
	lda $B6,x
	and #$F8
	sta $B6,x
	txa
	sec
	sbc #$08
	bpl -
*       rts

*      jmp KillObject			;($FA18)Free enemy data slot.

LFC98:  lda $B0,x
	jsr ChooseRoutine

; Pointer table to code

	.word ExitSub       ;($C45C) rts
	.word $FCA5
	.word $FCB1
	.word $FCBA

LFCA5:  jsr LFD84
	jsr LFD08
	jsr LFD25
	jmp LDD8B

LFCB1:  jsr LFD84
	jsr LFCC1
	jmp LDD8B

LFCBA:  lda #$00
	sta $B0,x
	jmp SFX_EnemyHit

LFCC1:  jsr LFD5F
	lda $B4,x
	cmp #$02
	bcs +
	ldy $08
	cpy ObjectY
	bcc +
	ora #$02
	sta $B4,x
*       ldy #$01
	lda $B4,x
	lsr
	bcc +
	ldy #$FF
*       sty $05
	ldy #$04
	lsr
	lda $B5,x
	bcc +
	ldy #$FD
*       sty $04
	inc $B5,x
	jsr LFD8F
	bcs +
	lda $B4,x
	ora #$02
	sta $B4,x
*       bcc +
	jsr LFD6C
*       lda $B5,x
	cmp #$50
	bcc +
	lda #$01
	sta $B0,x
*       rts

LFD08:  lda #$00
	sta $B5,x
	tay
	lda ObjectX
	sec
	sbc $B2,x
	bpl +
	iny
	jsr TwosCompliment		;($C3D4)
*       cmp #$10
	bcs +
	tya
	sta $B4,x
	lda #$02
	sta $B0,x
*       rts

LFD25:  txa
	lsr
	lsr
	lsr
	adc $8A
	sta $8A
	lsr $8A
	and #$03
	tay
	lda Table18,y
	sta $04
	lda Table18+1,y
	sta $05
	jsr LFD5F
	lda $08
	sec
	sbc ScrollY
	tay
	lda #$02
	cpy #$20
	bcc +
	jsr TwosCompliment		;($C3D4)
	cpy #$80
	bcc ++
*       sta $04
*      jsr LFD8F
	jmp LFD6C

; Table used by above subroutine

Table18:
	.byte $02
	.byte $FE
	.byte $01
	.byte $FF
	.byte $02

LFD5F:  lda $B3,x
	sta $0B
	lda $B1,x
	sta $08
	lda $B2,x
	sta $09
	rts

LFD6C:  lda $08
	sta $B1,x
	sta $04F0
	lda $09
	sta $B2,x
	sta $04F1
	lda $0B
	and #$01
	sta $B3,x
	sta $6BEB
	rts

LFD84:  lda $B6,x
	and #$04
	beq +
	lda #$03
	sta $B0,x
*       rts

LFD8F:  lda ScrollDir
	and #$02
	sta $02
	lda $04
	clc
	bmi +++
	beq LFDBF
	adc $08
	bcs +
	cmp #$F0
	bcc ++
*       adc #$0F
	ldy $02
	bne ClcExit2
	inc $0B
*       sta $08
	jmp LFDBF

*      adc $08
	bcs +
	sbc #$0F
	ldy $02
	bne ClcExit2
	inc $0B
*       sta $08
LFDBF:  lda $05
	clc
	bmi ++
	beq SecExit
	adc $09
	bcc +
	ldy $02
	beq ClcExit2
	inc $0B
*       jmp ++

*       adc $09
	bcs +
	ldy $02
	beq ClcExit2
	inc $0B
*       sta $09
	SecExit:
	sec
	rts

	ClcExit2:
	clc
*      rts

LFDE3:  lda EndTimerHi
	cmp #$99
	bne +
	clc
	sbc EndTimerLo  ; A = zero if timer just started
	bne +	   ; branch if not
	sta $06
	lda #$38
	sta $07
	jsr LDC54
*       ldx #$20
*       jsr LFE05
	txa
	sec
	sbc #$08
	tax
	bne -

LFE05:  lda $0758,x
	sec
	sbc #$02
	bne ---
	sta $06
	inc $0758,x
	txa
	lsr
	adc #$3C
	sta $07
	jmp LDC54

; Tile degenerate/regenerate

	UpdateTiles:
	ldx #$C0
*       jsr DoOneTile
	ldx PageIndex
	jsr Xminus16
	bne -
	DoOneTile:
	stx PageIndex
	lda TileRoutine,x
	beq +	       ; exit if tile not active
	jsr ChooseRoutine

; Pointer table to code

	.word ExitSub       ;($C45C) rts
	.word $FE3D
	.word $FE54
	.word $FE59
	.word $FE54
	.word $FE83

LFE3D:  inc TileRoutine,x
	lda #$00
	jsr SetTileAnim
	lda #$50
	sta TileDelay,x
	lda TileWRAMLo,x     ; low WRAM addr of blasted tile
	sta $00
	lda TileWRAMHi,x     ; high WRAM addr
	sta $01

LFE54:  lda #$02
	jmp UpdateTileAnim

LFE59:  lda FrameCount
	and #$03
	bne +       ; only update tile timer every 4th frame
	dec TileDelay,x
	bne +       ; exit if timer not reached zero
	inc TileRoutine,x
	ldy TileType,x
	lda Table19,y
	SetTileAnim:
	sta TileAnimIndex,x
	sta $0505,x
	lda #$00
	sta TileAnimDelay,x
*       rts

; Table used for indexing the animations in TileBlastAnim (see below)

Table19:
	.byte $18,$1C,$20,$00,$04,$08,$0C,$10,$24,$14

LFE83:  lda #$00
	sta TileRoutine,x       ; tile = respawned
	lda TileWRAMLo,x
	clc
	adc #$21
	sta $00
	lda TileWRAMHi,x
	sta $01
	jsr LFF3C
	lda $02
	sta $07
	lda $03
	sta $09
	lda $01
	lsr
	lsr
	and #$01
	sta $0B
	ldy #$00
	jsr LF186
	lda #$04
	clc
	adc ObjRadY
	sta $04
	lda #$04
	clc
	adc ObjRadX
	sta $05
	jsr LF1FA
	bcs Exit23
	jsr LF311
	lda #$50
	sta HealthLoChange
	jmp SubtractHealth		;($CE92)

	GetTileFramePtr:
	lda TileAnimFrame,x
	asl
	tay
	lda $97AF,y
	sta $02
	lda $97B0,y
	sta $03
Exit23: rts

	DrawTileBlast:
	lda PPUStrIndex
	cmp #$1F
	bcs Exit23
	ldx PageIndex
	lda TileWRAMLo,x
	sta $00
	lda TileWRAMHi,x
	sta $01
	jsr GetTileFramePtr
	ldy #$00
	sty $11
	lda ($02),y
	tax
	jsr Adiv16       ; / 16
	sta $04
	txa
	and #$0F
	sta $05
	iny
	sty $10
*       ldx $05
*       ldy $10
	lda ($02),y
	inc $10
	ldy $11
	sta ($00),y
	inc $11
	dex
	bne -
	lda $11
	clc
	adc #$20
	sec
	sbc $05
	sta $11
	dec $04
	bne --
	lda $01
	and #$04
	beq +
	lda $01
	ora #$0C
	sta $01
*       lda $01
	and #$2F
	sta $01
	jsr LC328
	clc
	rts

LFF3C:  lda $00
	tay
	and #$E0
	sta $02
	lda $01
	lsr
	ror $02
	lsr
	ror $02
	tya
	and #$1F
	jsr Amul8       ; * 8
	sta $03
	rts

UpdateTileAnim:
	ldx PageIndex
	ldy TileAnimDelay,x
	beq +
	dec TileAnimDelay,x
	bne ++
*       sta TileAnimDelay,x
	ldy TileAnimIndex,x
	lda TileBlastAnim,y
	cmp #$FE	    ; end of "tile-blast" animation?
	beq ++
	sta TileAnimFrame,x
	iny
	tya
	sta TileAnimIndex,x
	jsr DrawTileBlast
	bcc +
	ldx PageIndex
	dec TileAnimIndex,x
*	rts

*       inc TileRoutine,x
	pla
	pla
	rts

; Frame data for tile blasts

	TileBlastAnim:
	.byte $06,$07,$00,$FE
	.byte $07,$06,$01,$FE
	.byte $07,$06,$02,$FE
	.byte $07,$06,$03,$FE
	.byte $07,$06,$04,$FE
	.byte $07,$06,$05,$FE
	.byte $07,$06,$09,$FE
	.byte $07,$06,$0A,$FE
	.byte $07,$06,$0B,$FE
	.byte $07,$06,$08,$FE

	.byte $00
	.byte $00

;-----------------------------------------------[ RESET ]--------------------------------------------

RESET:
LFFB0:	SEI				;Disables interrupt
LFFB1:	CLD				;Sets processor to binary mode
LFFB2:	LDX #$00			;
LFFB4:	STX PPUControl0			;Clear PPU control registers
LFFB7:	STX PPUControl1			;
LFFBA:*	LDA PPUStatus			;
LFFBD:	BPL -				;Wait for VBlank
LFFBF:*	LDA PPUStatus			;
LFFC2:	BPL -				;
LFFC4:	ORA #$FF			;
LFFC6:	STA MMC1Reg0			;Reset MMC1 chip
LFFC9:	STA MMC1Reg1			;(MSB is set)
LFFCC:	STA MMC1Reg2			;
LFFCF:	STA MMC1Reg3			;
LFFD2:	JMP Startup			;($C01A)Do preliminary housekeeping.

;Not used.
LFFD5:	.byte $FF, $FF, $FF, $4C, $E4, $B3, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
LFFE5:	.byte $FF, $FF, $FF, $FF, $4D, $45, $54, $52, $4F, $49, $44, $E4, $8D, $00, $00, $38
LFFF5:	.byte $04, $01, $06, $01, $BC

;-----------------------------------------[ Interrupt vectors ]--------------------------------------

LBFFA: 	.word NMI			;($C0D9)NMI vector.
LBFFC:	.word RESET			;($FFB0)Reset vector.
LBFFE: 	.word RESET			;($FFB0)IRQ vector.