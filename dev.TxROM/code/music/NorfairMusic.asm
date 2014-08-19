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

NorfairSQ1IndexData:
LB000:  .byte $C3                               ;
LB001:  .byte $B6                               ;1 3/16 seconds +
LB002:  .byte $26                               ;G3             |
LB003:  .byte $B3                               ;3/4 seconds    |
LB004:  .byte $22                               ;F3             |
LB005:  .byte $B2                               ;3/8 seconds    | Repeat 3 times
LB006:  .byte $2C                               ;A#3            |
LB007:  .byte $B6                               ;1 3/16 seconds |
LB008:  .byte $26                               ;G3             |
LB009:  .byte $B4                               ;1 1/2 seconds  |
LB00A:  .byte $22                               ;F3             +
LB00B:  .byte $FF                               ;
LB00C:  .byte $C2                               ;
LB00D:  .byte $B6                               ;1 3/16 seconds +
LB00E:  .byte $30                               ;C4             |
LB00F:  .byte $34                               ;D4             |
LB010:  .byte $B3                               ;3/4 seconds    |
LB011:  .byte $3A                               ;F4             | Repeat 2 times
LB012:  .byte $B1                               ;3/16 seconds   |
LB013:  .byte $38                               ;E4             |
LB014:  .byte $34                               ;D4             |
LB015:  .byte $B4                               ;1 1/2 seconds  |
LB016:  .byte $2A                               ;A3             +
LB017:  .byte $FF                               ;
LB018:  .byte $C2                               ;
LB019:  .byte $B3                               ;3/4 seconds    +
LB01A:  .byte $2A                               ;A3             |
LB01B:  .byte $B2                               ;3/8 seconds    |
LB01C:  .byte $2E                               ;B3             |
LB01D:  .byte $B3                               ;3/4 seconds    |
LB01E:  .byte $26                               ;G3             | Repeat 2 times
LB01F:  .byte $B2                               ;3/8 seconds    |
LB020:  .byte $2A                               ;A3             |
LB021:  .byte $B6                               ;1 3/16 seconds |
LB022:  .byte $22                               ;F3             |
LB023:  .byte $02                               ;No sound       +
LB024:  .byte $FF                               ;
LB025:  .byte $00                               ;End Norfair music

NorfairSQ2IndexData:
LB026:  .byte $C3                               ;
LB027:  .byte $B6                               ;1 3/16 seconds +
LB028:  .byte $1E                               ;D#3            |
LB029:  .byte $B3                               ;3/4 seconds    |
LB02A:  .byte $1A                               ;C#3            |
LB02B:  .byte $B2                               ;3/8 seconds    | Repeat 3 times
LB02C:  .byte $24                               ;F#3            |
LB02D:  .byte $B6                               ;1 3/16 seconds |
LB02E:  .byte $1E                               ;D#3            |
LB02F:  .byte $B4                               ;1 1/2 seconds  |
LB030:  .byte $1A                               ;C#3            +
LB031:  .byte $FF                               ;
LB032:  .byte $C2                               ;
LB033:  .byte $B6                               ;1 3/16 seconds +
LB034:  .byte $26                               ;G3             |
LB035:  .byte $2A                               ;A3             |
LB036:  .byte $30                               ;C4             |
LB037:  .byte $B1                               ;3/16 seconds   |
LB038:  .byte $20                               ;E3             |
LB039:  .byte $1C                               ;D3             |
LB03A:  .byte $B6                               ;1 3/16 seconds |
LB03B:  .byte $20                               ;E3             +
LB03C:  .byte $FF                               ;
LB03D:  .byte $C2                               ;
LB03E:  .byte $B1                               ;3/16 seconds   +
LB03F:  .byte $20                               ;E3             |
LB040:  .byte $12                               ;A2             |
LB041:  .byte $16                               ;B2             |
LB042:  .byte $20                               ;E3             |
LB043:  .byte $B2                               ;3/8 seconds    |
LB044:  .byte $24                               ;F#3            |
LB045:  .byte $B1                               ;3/16 seconds   |
LB046:  .byte $1C                               ;D3             |
LB047:  .byte $0E                               ;G2             |
LB048:  .byte $12                               ;A2             | Repeat 2 times
LB049:  .byte $1C                               ;D3             |
LB04A:  .byte $B2                               ;3/8 seconds    |
LB04B:  .byte $20                               ;E3             |
LB04c:  .byte $B1                               ;3/16 seconds   |
LB04D:  .byte $18                               ;C3             |
LB04E:  .byte $12                               ;A2             |
LB04F:  .byte $14                               ;A#2            |
LB050:  .byte $18                               ;C3             |
LB051:  .byte $14                               ;A#2            |
LB052:  .byte $B6                               ;1 3/16 seconds |
LB053:  .byte $12                               ;A2             |
LB054:  .byte $B1                               ;3/16 seconds   |
LB055:  .byte $02                               ;No sound       +
LB056:  .byte $FF                               ;

NorfairTriangleIndexData:
LB057:  .byte $C3                               ;
LB058:  .byte $B1                               ;3/16 seconds   +
LB059:  .byte $34                               ;D4             |
LB05A:  .byte $02                               ;No sound       |
LB05B:  .byte $3E                               ;G4             |
LB05C:  .byte $02                               ;No sound       |
LB05D:  .byte $42                               ;A4             |
LB05E:  .byte $02                               ;No sound       |
LB05F:  .byte $B3                               ;3/4 seconds    |
LB060:  .byte $30                               ;C4             | Repeat 3 times
LB061:  .byte $B1                               ;3/16 seconds   |
LB062:  .byte $3A                               ;F4             |
LB063:  .byte $02                               ;No sound       |
LB064:  .byte $B2                               ;3/8 seconds    |
LB065:  .byte $34                               ;D4             |
LB066:  .byte $B3                               ;3/4 seconds    |
LB067:  .byte $02                               ;No sound       |
LB068:  .byte $30                               ;C4             |
LB069:  .byte $02                               ;No sound       +
LB06A:  .byte $FF                               ;
LB06B:  .byte $C2                               ;
LB06C:  .byte $B2                               ;3/8 seconds    +
LB06D:  .byte $22                               ;F3             |
LB06E:  .byte $30                               ;C4             |
LB06F:  .byte $34                               ;D4             |
LB070:  .byte $26                               ;G3             |
LB071:  .byte $34                               ;D4             |
LB072:  .byte $38                               ;E4             |
LB073:  .byte $2C                               ;A#3            | Repeat 2 times
LB074:  .byte $34                               ;D4             |
LB075:  .byte $3A                               ;F4             |
LB076:  .byte $B3                               ;3/4 seconds    |
LB077:  .byte $18                               ;C3             |
LB078:  .byte $B2                               ;3/8 seconds    |
LB079:  .byte $2A                               ;A3             |
LB07A:  .byte $02                               ;No sound       +
LB07B:  .byte $FF                               ;
LB07C:  .byte $C2                               ;
LB07D:  .byte $B3                               ;3/4 seconds    +
LB07E:  .byte $1C                               ;D3             |
LB07F:  .byte $B2                               ;3/8 seconds    |
LB080:  .byte $20                               ;E3             |
LB081:  .byte $B3                               ;3/4 seconds    |
LB082:  .byte $18                               ;C3             | Repeat 2 times
LB083:  .byte $B2                               ;3/8 seconds    |
LB084:  .byte $1C                               ;D3             |
LB085:  .byte $14                               ;A#2            |
LB086:  .byte $14                               ;A#2            |
LB087:  .byte $02                               ;No sound       |
LB088:  .byte $B6                               ;1 3/16 seconds |
LB089:  .byte $02                               ;No sound       +
LB08A:  .byte $FF                               ;

NorfairNoiseIndexData:
LB08B:  .byte $E0                               ;
LB08C:  .byte $B2                               ;3/8 seconds    +
LB08D:  .byte $01                               ;Drumbeat 00    |
LB08E:  .byte $04                               ;Drumbeat 01    |
LB08F:  .byte $04                               ;Drumbeat 01    |
LB090:  .byte $01                               ;Drumbeat 00    |
LB091:  .byte $04                               ;Drumbeat 01    | Repeat 32 times
LB092:  .byte $04                               ;Drumbeat 01    |
LB093:  .byte $B6                               ;1 3/16 seconds |
LB094:  .byte $04                               ;Drumbeat 01    |
LB095:  .byte $04                               ;Drumbeat 01    |
LB096:  .byte $B2                               ;3/8 seconds    |
LB097:  .byte $01                               ;Drumbeat 00    +
LB098:  .byte $FF                               ;