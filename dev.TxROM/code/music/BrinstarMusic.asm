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

BrinstarSQ1IndexData:
LB000:  .byte $C2                       ;
LB001:  .byte $B4                       ;1 1/2 seconds  +
LB002:  .byte $2E                       ;B3             | Repeat 2 times
LB003:  .byte $30                       ;C4             +
LB004:  .byte $FF                       ;
LB005:  .byte $C3                       ;
LB006:  .byte $B3                       ;3/4 seconds    +
LB007:  .byte $2E                       ;B3             |
LB008:  .byte $34                       ;D4             | Repeat 3 times
LB009:  .byte $30                       ;C4             |
LB00A:  .byte $3A                       ;F4             +
LB00B:  .byte $FF                       ;
LB00C:  .byte $B4                       ;1 1/2 seconds
LB00d:  .byte $2E                       ;B3
LB00E:  .byte $B3                       ;3/4 seconds
LB00F:  .byte $30                       ;C4
LB010:  .byte $34                       ;D4
LB011:  .byte $C3                       ;
LB012:  .byte $B6                       ;1 3/16 seconds +
LB013:  .byte $38                       ;E4             |
LB014:  .byte $B9                       ;1/8 seconds    |
LB015:  .byte $30                       ;C4             |
LB016:  .byte $26                       ;G3             | Repeat 3 times
LB017:  .byte $30                       ;C4             |
LB018:  .byte $B3                       ;3/4 seconds    |
LB019:  .byte $3A                       ;F4             |
LB01A:  .byte $34                       ;D4             +
LB01B:  .byte $FF                       ;
LB01C:  .byte $B4                       ;1 1/2 seconds
LB01D:  .byte $38                       ;E4
LB01E:  .byte $38                       ;E4
LB01F:  .byte $B2                       ;3/8 seconds
LB020:  .byte $3A                       ;F4
LB021:  .byte $30                       ;C4
LB022:  .byte $2A                       ;A3
LB023:  .byte $B9                       ;1/8 seconds
LB024:  .byte $30                       ;C4
LB025:  .byte $2C                       ;A#3
LB026:  .byte $30                       ;C4
LB027:  .byte $B2                       ;3/8 seconds
LB028:  .byte $34                       ;D4
LB029:  .byte $3A                       ;F4
LB02A:  .byte $B3                       ;3/4 seconds
LB02B:  .byte $30                       ;C4
LB02C:  .byte $B2                       ;3/8 seconds
LB02D:  .byte $36                       ;D#4
LB02E:  .byte $2A                       ;A3
LB02F:  .byte $22                       ;F3
LB030:  .byte $B9                       ;1/8 seconds
LB031:  .byte $18                       ;C3
LB032:  .byte $2C                       ;A#3
LB033:  .byte $18                       ;C3
LB034:  .byte $B2                       ;3/8 seconds
LB035:  .byte $1C                       ;D3
LB036:  .byte $22                       ;F3
LB037:  .byte $2C                       ;A#3
LB038:  .byte $B9                       ;1/8 seconds
LB039:  .byte $18                       ;C3
LB03A:  .byte $22                       ;F3
LB03B:  .byte $2A                       ;A3
LB03C:  .byte $B3                       ;3/4 seconds
LB03D:  .byte $2E                       ;B3
LB03E:  .byte $2A                       ;A3
LB03F:  .byte $26                       ;G3
LB040:  .byte $34                       ;D4
LB041:  .byte $B2                       ;3/8 seconds
LB042:  .byte $36                       ;D#4
LB043:  .byte $3A                       ;F4
LB044:  .byte $28                       ;Ab3
LB045:  .byte $B9                       ;1/8 seconds
LB046:  .byte $26                       ;G3
LB047:  .byte $22                       ;F3
LB048:  .byte $1E                       ;D#3
LB049:  .byte $B2                       ;3/8 seconds
LB04A:  .byte $22                       ;F3
LB04B:  .byte $2C                       ;A#3
LB04C:  .byte $26                       ;G3
LB04D:  .byte $B9                       ;1/8 seconds
LB04E:  .byte $22                       ;F3
LB04F:  .byte $44                       ;A#4
LB050:  .byte $34                       ;D4
LB051:  .byte $B4                       ;1 1/2 seconds
LB052:  .byte $34                       ;D4
LB053:  .byte $B3                       ;3/4 seconds
LB054:  .byte $2E                       ;B3
LB055:  .byte $26                       ;G3
LB056:  .byte $00                       ;End Brinstar music

BrinstarSQ2IndexData:
LB057:  .byte $C2                       ;
LB058:  .byte $B2                       ;3/8 seconds    +
LB059:  .byte $0E                       ;G2             |
LB05A:  .byte $B9                       ;1/8 seconds    |
LB05B:  .byte $0E                       ;G2             |
LB05C:  .byte $06                       ;D2             |
LB05D:  .byte $0E                       ;G2             |
LB05E:  .byte $B2                       ;3/8 seconds    |
LB05F:  .byte $0E                       ;G2             |
LB060:  .byte $B9                       ;1/8 seconds    |
LB061:  .byte $0E                       ;G2             |
LB062:  .byte $06                       ;D2             |
LB063:  .byte $0E                       ;G2             | Repeat 2 times
LB064:  .byte $B2                       ;3/8 seconds    |
LB065:  .byte $14                       ;A#2            |
LB066:  .byte $B9                       ;1/8 seconds    |
LB067:  .byte $14                       ;A#2            |
LB068:  .byte $0A                       ;F2             |
LB069:  .byte $14                       ;A#2            |
LB06A:  .byte $B2                       ;3/8 seconds    |
LB06B:  .byte $14                       ;A#2            |
LB06C:  .byte $B9                       ;1/8 seconds    |
LB06D:  .byte $14                       ;A#2            |
LB06E:  .byte $0A                       ;F2             |
LB06F:  .byte $14                       ;A#2            +
LB070:  .byte $FF                       ;
LB071:  .byte $C3                       ;
LB072:  .byte $B4                       ;1 1/2 seconds  +
LB073:  .byte $3E                       ;G4             |
LB074:  .byte $B6                       ;1 3/16 seconds |
LB075:  .byte $44                       ;A#4            |
LB076:  .byte $B0                       ;3/32 seconds   | Repeat 3 times
LB077:  .byte $42                       ;A4             |
LB078:  .byte $44                       ;A#4            |
LB079:  .byte $42                       ;A4             |
LB07A:  .byte $3A                       ;F4             +
LB07B:  .byte $FF                       ;
LB07C:  .byte $B4                       ;1 1/2 seconds
LB07D:  .byte $3E                       ;G4
LB07E:  .byte $3E                       ;G4
LB07F:  .byte $C3                       ;
LB080:  .byte $B6                       ;1 3/16 seconds +
LB081:  .byte $48                       ;C5             |
LB082:  .byte $B2                       ;3/8 seconds    |
LB083:  .byte $3E                       ;G4             |
LB084:  .byte $B6                       ;1 3/16 seconds |
LB085:  .byte $44                       ;A#4            | Repeat 3 times
LB086:  .byte $B0                       ;3/32 seconds   |
LB087:  .byte $42                       ;A4             |
LB088:  .byte $44                       ;A#4            |
LB089:  .byte $42                       ;A4             |
LB08A:  .byte $3A                       ;F4             +
LB08B:  .byte $FF                       ;
LB08C:  .byte $B4                       ;1 1/2 seconds
LB08D:  .byte $3E                       ;G4
LB08E:  .byte $26                       ;G3
LB08F:  .byte $B6                       ;1 3/16 seconds
LB090:  .byte $42                       ;A4
LB091:  .byte $B9                       ;1/8 seconds
LB092:  .byte $42                       ;A4
LB093:  .byte $3E                       ;G4
LB094:  .byte $42                       ;A4
LB095:  .byte $B3                       ;3/4 seconds
LB096:  .byte $44                       ;A#4
LB097:  .byte $B2                       ;3/8 seconds
LB098:  .byte $3A                       ;F4
LB099:  .byte $B9                       ;1/8 seconds
LB09A:  .byte $30                       ;C4
LB09B:  .byte $3A                       ;F4
LB09C:  .byte $3E                       ;G4
LB09D:  .byte $B6                       ;1 3/16 seconds
LB09E:  .byte $42                       ;A4
LB09F:  .byte $B9                       ;1/8 seconds
LB0A0:  .byte $42                       ;A4
LB0A1:  .byte $3E                       ;G4
LB0A2:  .byte $42                       ;A4
LB0A3:  .byte $B3                       ;3/4 seconds
LB0A4:  .byte $44                       ;A#4
LB0A5:  .byte $B2                       ;3/8 seconds
LB0A6:  .byte $3A                       ;F4
LB0A7:  .byte $B9                       ;1/8 seconds
LB0A8:  .byte $3A                       ;F4
LB0A9:  .byte $44                       ;A#4
LB0AA:  .byte $48                       ;C5
LB0AB:  .byte $B4                       ;1 1/2 seconds
LB0AC:  .byte $4C                       ;D5
LB0AD:  .byte $B3                       ;3/4 seconds
LB0AE:  .byte $48                       ;C5
LB0AF:  .byte $46                       ;B4
LB0B0:  .byte $B6                       ;1 3/16 seconds
LB0B1:  .byte $48                       ;C5
LB0B2:  .byte $B9                       ;1/8 seconds
LB0B3:  .byte $4E                       ;D#5
LB0B4:  .byte $4C                       ;D5
LB0B5:  .byte $48                       ;C5
LB0B6:  .byte $B3                       ;3/4 seconds
LB0B7:  .byte $4C                       ;D5
LB0B8:  .byte $B2                       ;3/8 seconds
LB0B9:  .byte $44                       ;A#4
LB0BA:  .byte $B9                       ;1/8 seconds
LB0BB:  .byte $44                       ;A#4
LB0BC:  .byte $4C                       ;D5
LB0BD:  .byte $52                       ;F5
LB0BE:  .byte $B4                       ;1 1/2 seconds
LB0BF:  .byte $54                       ;F#5
LB0C0:  .byte $54                       ;F#5

BrinstarTriangleIndexData:
LB0C1:  .byte $C4                       ;
LB0C2:  .byte $B4                       ;1 1/2 seconds  + Repeat 4 times
LB0C3:  .byte $02                       ;No sound       +
LB0C4:  .byte $FF                       ;
LB0C5:  .byte $C3                       ;
LB0C6:  .byte $B2                       ;3/8 seconds    +
LB0C7:  .byte $26                       ;G3             |
LB0C8:  .byte $B9                       ;1/8 seconds    |
LB0C9:  .byte $26                       ;G3             |
LB0CA:  .byte $3E                       ;G4             |
LB0CB:  .byte $34                       ;D4             |
LB0CC:  .byte $B2                       ;3/8 seconds    |
LB0CD:  .byte $26                       ;G3             |
LB0CE:  .byte $B9                       ;1/8 seconds    |
LB0CF:  .byte $26                       ;G3             |
LB0D0:  .byte $34                       ;D4             | Repeat 3 times
LB0D1:  .byte $26                       ;G3             |
LB0D2:  .byte $B2                       ;3/8 seconds    |
LB0D3:  .byte $2C                       ;A#3            |
LB0D4:  .byte $B9                       ;1/8 seconds    |
LB0D5:  .byte $2C                       ;A#3            |
LB0D6:  .byte $3A                       ;F4             |
LB0D7:  .byte $2C                       ;A#3            |
LB0D8:  .byte $B2                       ;3/8 seconds    |
LB0D9:  .byte $2C                       ;A#3            |
LB0DA:  .byte $B9                       ;1/8 seconds    |
LB0DB:  .byte $2C                       ;A#3            |
LBoDC:  .byte $3A                       ;F4             |
LB0DD:  .byte $2C                       ;A#3            +
LB0DE:  .byte $FF                       ;
LB0DF:  .byte $C4                       ;
LB0E0:  .byte $B2                       ;3/8 seconds    +
LB0E1:  .byte $26                       ;G3             |
LB0E2:  .byte $B9                       ;1/8 seconds    | Repeat 4 times
LB0E3:  .byte $34                       ;D4             |
LB0E4:  .byte $26                       ;G3             |
LB0E5:  .byte $26                       ;G3             +
LB0E6:  .byte $FF                       ;
LB0E7:  .byte $D0                       ;
LB0E8:  .byte $B9                       ;1/8 seconds    +                               
LB0E9:  .byte $18                       ;C3             |
LB0EA:  .byte $26                       ;G3             | Repeat 16 times
LB0EB:  .byte $18                       ;C3             |
LB0EC:  .byte $B2                       ;3/8 seconds    |
LB0ED:  .byte $18                       ;C3             +
LB0EE:  .byte $FF                       ;
LB0EF:  .byte $C2                       ;
LB0F0:  .byte $B2                       ;3/8 seconds    +
LB0F1:  .byte $1E                       ;D#3            |
LB0F2:  .byte $B9                       ;1/8 seconds    |
LB0F3:  .byte $1E                       ;D#3            |
LB0F4:  .byte $18                       ;C3             |
LB0F5:  .byte $1E                       ;D#3            |
LB0F6:  .byte $B2                       ;3/8 seconds    |
LB0F7:  .byte $1E                       ;D#3            |
LB0F8:  .byte $B9                       ;1/8 seconds    |
LB0F9:  .byte $1E                       ;D#3            |
LB0FA:  .byte $18                       ;C3             | Repeat 2 times
LB0FB:  .byte $1E                       ;D#3            |
LB0FC:  .byte $B2                       ;3/8 seconds    |
LB0FD:  .byte $1C                       ;D3             |
LB0FE:  .byte $B9                       ;1/8 seconds    |
LB0FF:  .byte $1C                       ;D3             |
LB100:  .byte $14                       ;A#2            |
LB101:  .byte $1C                       ;D3             |
LB102:  .byte $B2                       ;3/8 seconds    |
LB103:  .byte $1C                       ;D3             |
LB104:  .byte $B9                       ;1/8 seconds    |
LB105:  .byte $1C                       ;D3             |
LB106:  .byte $14                       ;A#2            |
LB107:  .byte $1C                       ;D3             +
LB108:  .byte $FF                       ;
LB109:  .byte $B2                       ;3/8 seconds
LB10A:  .byte $26                       ;G3
LB10B:  .byte $12                       ;A2
LB10C:  .byte $16                       ;B2
LB10D:  .byte $18                       ;C3
LB10E:  .byte $1C                       ;D3
LB10F:  .byte $20                       ;E3
LB110:  .byte $24                       ;F#3
LB111:  .byte $26                       ;G3
LB112:  .byte $B2                       ;3/8 seconds
LB113:  .byte $28                       ;Ab3
LB114:  .byte $B9                       ;1/8 seconds
LB115:  .byte $28                       ;Ab3
LB116:  .byte $1E                       ;D#3
LB117:  .byte $18                       ;C3
LB118:  .byte $B2                       ;3/8 seconds
LB119:  .byte $10                       ;Ab2
LB11A:  .byte $B9                       ;1/8 seconds
LB11B:  .byte $30                       ;C4
LB11C:  .byte $2C                       ;A#3
LB11D:  .byte $28                       ;Ab3
LB11E:  .byte $B2                       ;3/8 seconds
LB11F:  .byte $1E                       ;D#3
LB120:  .byte $1C                       ;D3
LB121:  .byte $18                       ;C3
LB122:  .byte $14                       ;A#2
LB123:  .byte $2A                       ;A3
LB124:  .byte $2A                       ;A3
LB125:  .byte $2A                       ;A3
LB126:  .byte $2A                       ;A3
LB127:  .byte $CC                       ;
LB128:  .byte $B9                       ;1/8 seconds    + Repeat 12 times
LB129:  .byte $2A                       ;A3             +
LB12A:  .BYTE $FF                       ;

BrinstarNoiseIndexData:
LB12B:  .byte $E8                       ;
LB12C:  .byte $B2                       ;3/8 seconds    +
LB12D:  .byte $04                       ;Drumbeat 01    |
LB12E:  .byte $04                       ;Drumbeat 01    |
LB12F:  .byte $04                       ;Drumbeat 01    | Repeat 40 times
LB130:  .byte $B9                       ;1/8 seconds    |
LB131:  .byte $04                       ;Drumbeat 01    |
LB132:  .byte $04                       ;Drumbeat 01    |
LB133:  .byte $04                       ;Drumbeat 01    +
LB134:  .byte $FF                       ;