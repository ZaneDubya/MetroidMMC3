; METROID source code
; (C) 1986 NINTENDO
; Programmed by HAI YUKAMI, ZARU SOBAJIMA, 
;      GPZ SENGOKU, N.SHIOTANI, & M.HOUDAI
;Commented by Dirty McDingus (nmikstas@yahoo.com)
;Can be reassembled using Ophis.

;----------------------------[ Forward declarations ]---------------------------

;       Routine Name            Address ;Used By (World & AreaCommon could be the same...)
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
.alias  ExitSub                 $C45C   ;Title & AreaCommon
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
.alias  SelectSamusPal          $CB73   ;AreaCommon
.alias  SilenceMusic            $CB8E   ;Title
.alias  SFX_Door                $CBDA   ;AreaCommon
.alias  MotherBrainMusic        $CC03   ;AreaCommon 8CC0
.alias  TourianMusic            $CC07   ;AreaCommon 8CBB
.alias  SubtractHealth          $CE92   ;World
.alias  SetProjectileAnim       $D2FA   ;World
.alias  SetProjectileAnim2      $D2FD   ;AreaCommon
.alias  MapScrollRoutine        $DC1E   ;AreaCommon 8C4D
.alias  ClrObjCntrlIfFrameIsF7  $DD8B   ;AreaCommonJumpTable
.alias  AnimDrawObject          $DE47   ;AreaCommon 8BCE
.alias  UpdateEnemyAnim         $E094   ;World
.alias  VerticalRoomCentered    $E21B   ;World
.alias  SubtractFromZero00And01 $E449   ;AreaCommon
.alias  CheckYPlus8             $E770   ;AreaCommon
.alias  CheckNegativeYPlus8     $E77B   ;AreaCommon
.alias  UnknownE8F1             $E8F1
.alias  UnknownE8FC             $E8FC
.alias  MakeWRAMPtr             $E96A   ;AreaCommon
.alias  UnknownEB6E             $EB6E
.alias  AddFlagToEnData05       $F744   ;AreaCommon
.alias  GetEnemy8BValue         $F74B   ;AreaCommon
.alias  UpdateEnemyAnim0        $F410   ;
.alias  CheckObjectAttribs      $F416   ;
.alias  UpdateEnemyAnim1        $F438   ;
.alias  ResetAnimIndex          $F68D   ;
.alias  UnusedF83E              $F83E   ;
.alias  GetRandom_EnIdxFrCnt    $F852   ;
.alias  UnknownF85A             $F85A   ;
.alias  UnknownF870             $F870   ;
.alias  EnemyBGCrashDetection   $FA1E   ;AreaCommonJumpTable
.alias  UnknownFB88             $FB88   ;
.alias  UnknownFBB9             $FBB9   ;
.alias  UnknownFBCA             $FBCA   ;
.alias  DrawTileBlast           $FEDC   ;World