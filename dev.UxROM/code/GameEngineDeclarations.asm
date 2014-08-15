; METROID source code
; (C) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, 
;      GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Can be reassembled using Ophis.

;----------------------------[ Forward declarations ]---------------------------

;       Routine Name            Address ;Used By
.alias  ClearNameTables         $C158   ;Title
.alias  ClearNameTable0         $C16D   ;Title
.alias  EraseAllSprites         $C1A3   ;Title
.alias  RemoveIntroSprites      $C1BC   ;Title
.alias  ClearRAM_33_DF          $C1D4   ;Title
.alias  PreparePPUProcess_      $C20E   ;Title

.alias  ChooseRoutine           $C27C   ;World & Title
.alias  AddYToPtr02             $C2B3   ;Title
.alias  Adiv32                  $C2BE   ;World
.alias  Adiv16                  $C2BF   ;Title
.alias  Adiv8                   $C2C0   ;Title
.alias  Amul16                  $C2C5   ;World & Title
.alias  Amul8                   $C2C6   ;Title
.alias  ProcessPPUString        $C30C   ;Title
.alias  EraseTile               $C328   ;Title
.alias  WritePPUByte            $C36B   ;Title
.alias  PrepPPUPaletteString    $C37E   ;Title
.alias  TwosCompliment          $C3D4   ;World
.alias  Base10Subtract          $C3FB   ;World
.alias  WaitNMIPass             $C42C   ;Title
.alias  ScreenOff               $C439   ;Title
.alias  WaitNMIPass_            $C43F   ;Title
.alias  ScreenOn                $C447   ;Title
.alias  ExitSub                 $C45C   ;Title
.alias  ScreenNmiOff            $C45D   ;Title
.alias  VBOffAndHorzWrite       $C47D   ;Title
.alias  NmiOn                   $C487   ;Title
.alias  SetTimer                $C4AA   ;Title
.alias  ClearSamusStats         $C578   ;Title
.alias  InitEndGFX              $C5D0   ;Title
.alias  LoadSamusGFX            $C5DC   ;Title
.alias  InitGFX7                $C6D6   ;Title
.alias  BankTable               $CA30   ;Title
.alias  ChooseEnding            $CAF5   ;Title
.alias  SilenceMusic            $CB8E   ;Title
.alias  SubtractHealth          $CE92   ;World
.alias  SetProjectileAnim       $D2FA   ;World
.alias  UpdateEnemyAnim         $E094   ;World
.alias  VerticalRoomCentered    $E21B   ;World
.alias  DrawTileBlast           $FEDC   ;World