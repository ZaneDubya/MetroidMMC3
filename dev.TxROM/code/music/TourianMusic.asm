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

EscapeSQ2Data:
LB000:  .byte $C4                               ;
LB001:  .byte $B3                               ;3/4 seconds    +
LB002:  .byte $3E                               ;G4             |
LB003:  .byte $44                               ;A#4            | Repeat 4 times
LB004:  .byte $B4                               ;1 1/2 seconds  |
LB005:  .byte $42                               ;A4             +
LB006:  .byte $FF                               ;
LB007:  .byte $C2                               ;
LB008:  .byte $B6                               ;1 3/16 seconds +
LB009:  .byte $30                               ;C4             |
LB00A:  .byte $B9                               ;1/8 seconds    |
LB00B:  .byte $26                               ;G3             |
LB00C:  .byte $30                               ;C4             |
LB00D:  .byte $36                               ;D#4            |
LB00E:  .byte $B4                               ;1 1/2 seconds  |
LB00F:  .byte $34                               ;D4             |
LB010:  .byte $B6                               ;1 3/16 seconds |
LB011:  .byte $30                               ;C4             |
LB012:  .byte $B9                               ;1/8 seconds    |
LB013:  .byte $26                               ;G3             |
LB014:  .byte $30                               ;C4             |
LB015:  .byte $36                               ;D#4            |
LB016:  .byte $B4                               ;1 1/2 seconds  | Repeat 2 times
LB017:  .byte $34                               ;D4             |
LB018:  .byte $B6                               ;1 3/16 seconds |
LB019:  .byte $30                               ;C4             |
LB01A:  .byte $B9                               ;1/8 seconds    |
LB01B:  .byte $26                               ;G3             |
LB01C:  .byte $30                               ;C4             |
LB01D:  .byte $38                               ;E4             |
LB01E:  .byte $B4                               ;1 1/2 seconds  |
LB01F:  .byte $34                               ;D4             |
LB020:  .byte $B6                               ;1 3/16 seconds |
LB021:  .byte $30                               ;C4             |
LB022:  .byte $B9                               ;1/8 seconds    |
LB023:  .byte $26                               ;G3             |
LB024:  .byte $30                               ;C4             |
LB025:  .byte $38                               ;E4             |
LB026:  .byte $B4                               ;1 1/2 seconds  |
LB027:  .byte $34                               ;D4             +
LB028:  .byte $FF                               ;
LB029:  .byte $C2                               ;
LB02A:  .byte $B6                               ;1 3/16 seconds +
LB02B:  .byte $48                               ;C5             |
LB02C:  .byte $B9                               ;1/8 seconds    |
LB02D:  .byte $46                               ;B4             |
LB02E:  .byte $02                               ;No sound       |
LB02F:  .byte $48                               ;C5             |
LB030:  .byte $B6                               ;1 3/16 seconds |
LB031:  .byte $4C                               ;D5             |
LB032:  .byte $B2                               ;3/8 seconds    |
LB033:  .byte $48                               ;C5             |
LB034:  .byte $B6                               ;1 3/16 seconds |
LB035:  .byte $46                               ;B4             |
LB036:  .byte $B9                               ;1/8 second     |
LB037:  .byte $42                               ;A4             |
LB038:  .byte $02                               ;No sound       |
LB039:  .byte $46                               ;B4             | Repeat 2 times
LB03A:  .byte $B3                               ;3/4 seconds    |
LB03B:  .byte $48                               ;C5             |
LB03C:  .byte $3E                               ;G4             |
LB03D:  .byte $B6                               ;1 3/16 seconds |
LB03E:  .byte $3A                               ;F4             |
LB03F:  .byte $B9                               ;1/8 seconds    |
LB040:  .byte $3E                               ;G4             |
LB041:  .byte $02                               ;No sound       |
LB042:  .byte $3A                               ;F4             |
LB043:  .byte $B3                               ;3/4 seconds    |
LB044:  .byte $38                               ;E4             |
LB045:  .byte $30                               ;C4             |
LB046:  .byte $B4                               ;1 1/2 seconds  |
LB047:  .byte $36                               ;D#4            |
LB048:  .byte $B3                               ;3/4 seconds    |
LB049:  .byte $30                               ;C4             |
LB04A:  .byte $2E                               ;B3             +
LB04B:  .byte $FF                               ;
LB04C:  .byte $00                               ;End escape music.

EscapeSQ1Data:
LB04D:  .byte $C4                               ;
LB04E:  .byte $B3                               ;3/4 seconds    +
LB04F:  .byte $34                               ;D4             |
LB050:  .byte $3A                               ;F4             | Repeat 4 times
LB051:  .byte $B4                               ;1 1/2 seconds  |
LB052:  .byte $32                               ;C#4            +
LB053:  .byte $FF                               ;
LB054:  .byte $C2                               ;
LB055:  .byte $B4                               ;1 1/2 seconds  +
LB056:  .byte $2A                               ;A3             |
LB057:  .byte $28                               ;Ab3            |
LB058:  .byte $2A                               ;A3             |
LB059:  .byte $B6                               ;1 3/16 seconds |
LB05A:  .byte $28                               ;Ab3            |
LB05B:  .byte $B9                               ;1/8 seconds    |
LB05C:  .byte $26                               ;G3             |
LB05D:  .byte $24                               ;F#3            |
LB05E:  .byte $22                               ;F3             |
LB05F:  .byte $B6                               ;1 3/16 seconds |
LB060:  .byte $20                               ;E3             |
LB061:  .byte $B2                               ;3/8 seconds    |
LB062:  .byte $22                               ;F3             |
LB063:  .byte $B6                               ;1 3/16 seconds | Repeat 2 times
LB064:  .byte $28                               ;Ab3            |
LB065:  .byte $B9                               ;1/8 seconds    |
LB066:  .byte $26                               ;G3             |
LB067:  .byte $24                               ;F#3            |
LB068:  .byte $22                               ;F3             |
LB069:  .byte $B4                               ;1 1/2 seconds  |
LB06A:  .byte $26                               ;G3             |
LB06B:  .byte $B9                               ;1/8 seconds    |
LB06C:  .byte $22                               ;F3             |
LB06D:  .byte $20                               ;E3             |
LB06E:  .byte $22                               ;F3             |
LB06F:  .byte $26                               ;G3             |
LB070:  .byte $22                               ;F3             |
LB071:  .byte $26                               ;G3             |
LB072:  .byte $2A                               ;A3             |
LB073:  .byte $26                               ;G3             |
LB074:  .byte $2A                               ;A3             |
LB075:  .byte $2E                               ;B3             |
LB076:  .byte $2A                               ;A3             |
LB077:  .byte $2E                               ;B3             +
LB078:  .byte $FF                               ;
LB079:  .byte $C2                               ;
LB07A:  .byte $B9                               ;1/8 seconds    +
LB07B:  .byte $20                               ;E3             |
LB07C:  .byte $1E                               ;D#3            |
LB07D:  .byte $20                               ;E3             |
LB07E:  .byte $26                               ;G3             |
LB07F:  .byte $30                               ;C4             |
LB080:  .byte $38                               ;E4             |
LB081:  .byte $B2                               ;3/8 seconds    |
LB082:  .byte $3E                               ;G4             |
LB083:  .byte $38                               ;E4             |
LB084:  .byte $B0                               ;3/32 seconds   |
LB085:  .byte $24                               ;F#3            |
LB086:  .byte $20                               ;E3             |
LB087:  .byte $24                               ;F#3            |
LB088:  .byte $2A                               ;A3             |
LB089:  .byte $B9                               ;1/8 seconds    |
LB08A:  .byte $34                               ;D4             |
LB08B:  .byte $3A                               ;F4             |
LB08C:  .byte $3C                               ;F#4            |
LB08D:  .byte $B2                               ;3/8 seconds    |
LB08E:  .byte $42                               ;A4             |
LB08F:  .byte $3C                               ;F#4            |
LB090:  .byte $B2                               ;3/8 seconds    |
LB091:  .byte $3E                               ;G4             |
LB092:  .byte $B9                               ;1/8 seconds    |
LB093:  .byte $34                               ;D4             |
LB094:  .byte $02                               ;No sound       |
LB095:  .byte $2E                               ;B3             |
LB096:  .byte $B3                               ;3/4 seconds    |
LB097:  .byte $34                               ;D4             |
LB098:  .byte $B2                               ;3/8 seconds    |
LB099:  .byte $3E                               ;G4             |
LB09A:  .byte $3A                               ;F4             |
LB09B:  .byte $38                               ;E4             |
LB09C:  .byte $34                               ;D4             |
LB09D:  .byte $B9                               ;1/8 seconds    |
LB09E:  .byte $30                               ;C4             |
LB09F:  .byte $26                               ;G3             |
LB0A0:  .byte $30                               ;C4             |
LB0A1:  .byte $B9                               ;1/8 seconds    |
LB0A2:  .byte $34                               ;D4             |
LB0A3:  .byte $02                               ;No sound       |
LB0A4:  .byte $26                               ;G3             |
LB0A5:  .byte $B3                               ;3/4 seconds    | Repeat 2 times
LB0A6:  .byte $30                               ;C4             |
LB0A7:  .byte $B9                               ;1/8 seconds    |
LB0A8:  .byte $30                               ;C4             |
LB0A9:  .byte $20                               ;E3             |
LB0AA:  .byte $3E                               ;G4             |
LB0AB:  .byte $B9                               ;1/8 seconds    |
LB0AC:  .byte $34                               ;D4             |
LB0AD:  .byte $02                               ;No sound       |
LB0AE:  .byte $26                               ;G3             |
LB0AF:  .byte $3A                               ;F4             |
LB0B0:  .byte $38                               ;E4             |
LB0B1:  .byte $34                               ;D4             |
LB0B2:  .byte $30                               ;C4             |
LB0B3:  .byte $26                               ;G3             |
LB0B4:  .byte $24                               ;F#3            |
LB0B5:  .byte $22                               ;F3             |
LB0B6:  .byte $20                               ;E3             |
LB0B7:  .byte $22                               ;F3             |
LB0B8:  .byte $26                               ;G3             |
LB0B9:  .byte $22                               ;F3             |
LB0BA:  .byte $26                               ;G3             |
LB0BB:  .byte $28                               ;Ab3            |
LB0BC:  .byte $26                               ;G3             |
LB0BD:  .byte $28                               ;Ab3            |
LB0BE:  .byte $2C                               ;A#3            |
LB0BF:  .byte $28                               ;Ab3            |
LB0C0:  .byte $2C                               ;A#3            |
LB0C1:  .byte $B9                               ;1/8 seconds    |
LB0C2:  .byte $22                               ;F3             |
LB0C3:  .byte $20                               ;E3             |
LB0C4:  .byte $22                               ;F3             |
LB0C5:  .byte $20                               ;E3             |
LB0C6:  .byte $22                               ;F3             |
LB0C7:  .byte $20                               ;E3             |
LB0C8:  .byte $22                               ;F3             |
LB0C9:  .byte $1C                               ;D3             |
LB0CA:  .byte $22                               ;F3             |
LB0CB:  .byte $1C                               ;D3             |
LB0CC:  .byte $22                               ;F3             |
LB0CD:  .byte $1C                               ;D3             +
LB0CE:  .byte $FF                               ;

EscapeTriData:
LB0CF:  .byte $D0                               ;
LB0D0:  .byte $B2                               ;3/8 seconds    +
LB0D1:  .byte $3E                               ;G4             |
LB0D2:  .byte $B9                               ;1/8 seconds    | Repeat 16 times
LB0D3:  .byte $3E                               ;G4             |
LB0D4:  .byte $3E                               ;G4             |
LB0D5:  .byte $3E                               ;G4             +
LB0D6:  .byte $FF                               ;
LB0D7:  .byte $C2                               ;
LB0D8:  .byte $B2                               ;3/8 seconds    +
LB0D9:  .byte $2A                               ;A3             |
LB0DA:  .byte $B9                               ;1/8 seconds    |
LB0DB:  .byte $2A                               ;A3             |
LB0DC:  .byte $12                               ;A2             |
LB0DD:  .byte $2A                               ;A3             |
LB0DE:  .byte $B2                               ;3/8 seconds    |
LB0DF:  .byte $2A                               ;A3             |
LB0E0:  .byte $2A                               ;A3             |
LB0E1:  .byte $2A                               ;A3             |
LB0E2:  .byte $B9                               ;1/8 seconds    |
LB0E3:  .byte $2A                               ;A3             |
LB0E4:  .byte $2A                               ;A3             |
LB0E5:  .byte $2A                               ;A3             |
LB0E6:  .byte $B2                               ;3/8 seconds    |
LB0E7:  .byte $2A                               ;A3             |
LB0E8:  .byte $2A                               ;A3             |
LB0E9:  .byte $2A                               ;A3             |
LB0EA:  .byte $B9                               ;1/8 seconds    |
LB0EB:  .byte $2A                               ;A3             |
LB0EC:  .byte $2A                               ;A3             |
LB0ED:  .byte $2A                               ;A3             |
LB0EE:  .byte $B2                               ;3/8 seconds    |
LB0EF:  .byte $2A                               ;A3             |
LB0F0:  .byte $2A                               ;A3             |
LB0F1:  .byte $2A                               ;A3             |
LB0F2:  .byte $2A                               ;A3             |
LB0F3:  .byte $2A                               ;A3             |
LB0F4:  .byte $B9                               ;1/8 seconds    |
LB0F5:  .byte $2A                               ;A3             |
LB0F6:  .byte $12                               ;A2             |
LB0F7:  .byte $2A                               ;A3             |
LB0F8:  .byte $B2                               ;3/8 seconds    |
LB0F9:  .byte $26                               ;G3             |
LB0FA:  .byte $B9                               ;1/8 seconds    | Repeat 2 times
LB0FB:  .byte $0E                               ;G2             |
LB0FC:  .byte $26                               ;G3             |
LB0FD:  .byte $26                               ;G3             |
LB0FE:  .byte $B2                               ;3/8 seconds    |
LB0FF:  .byte $26                               ;G3             |
LB100:  .byte $B9                               ;1/8 seconds    |
LB101:  .byte $0E                               ;G2             |
LB102:  .byte $26                               ;G3             |
LB103:  .byte $26                               ;G3             |
LB104:  .byte $B2                               ;3/8 seconds    |
LB105:  .byte $22                               ;F3             |
LB106:  .byte $B9                               ;1/8 seconds    |
LB107:  .byte $0A                               ;F2             |
LB108:  .byte $22                               ;F3             |
LB109:  .byte $22                               ;F3             |
LB10A:  .byte $B2                               ;3/8 seconds    |
LB10B:  .byte $22                               ;F3             |
LB10C:  .byte $B9                               ;1/8 seconds    |
LB10D:  .byte $0A                               ;F2             |
LB10E:  .byte $22                               ;F3             |
LB10F:  .byte $22                               ;F3             |
LB110:  .byte $B2                               ;3/8 seconds    |
LB111:  .byte $20                               ;E3             |
LB112:  .byte $20                               ;E3             |
LB113:  .byte $B9                               ;1/8 seconds    |
LB114:  .byte $20                               ;E3             |
LB115:  .byte $20                               ;E3             |
LB116:  .byte $20                               ;E3             |
LB117:  .byte $B2                               ;3/8 seconds    |
LB118:  .byte $20                               ;E3             |
LB119:  .byte $B9                               ;1/8 seconds    |
LB11A:  .byte $34                               ;D4             |
LB11B:  .byte $30                               ;C4             |
LB11C:  .byte $34                               ;D4             |
LB11D:  .byte $38                               ;E4             |
LB11E:  .byte $34                               ;D4             |
LB11F:  .byte $38                               ;E4             |
LB120:  .byte $3A                               ;F4             |
LB121:  .byte $38                               ;E4             |
LB122:  .byte $3A                               ;F4             |
LB123:  .byte $3E                               ;G4             |
LB124:  .byte $3A                               ;F4             |
LB125:  .byte $3E                               ;G4             +
LB126:  .byte $FF                               ;
LB127:  .byte $C2                               ;
LB128:  .byte $B2                               ;3/8 seconds    +
LB129:  .byte $18                               ;C3             |
LB12A:  .byte $30                               ;C4             |
LB12B:  .byte $18                               ;C3             |
LB12C:  .byte $30                               ;C4             |
LB12D:  .byte $18                               ;C3             |
LB12E:  .byte $30                               ;C4             |
LB12F:  .byte $18                               ;C3             |
LB130:  .byte $30                               ;C4             |
LB131:  .byte $22                               ;F3             |
LB132:  .byte $22                               ;F3             |
LB133:  .byte $B1                               ;3/16 seconds   |
LB134:  .byte $22                               ;F3             |
LB135:  .byte $22                               ;F3             |
LB136:  .byte $B2                               ;3/8 seconds    |
LB137:  .byte $22                               ;F3             |
LB138:  .byte $20                               ;E3             |
LB139:  .byte $1C                               ;D3             |
LB13A:  .byte $18                               ;C3             |
LB13B:  .byte $16                               ;B2             |
LB13C:  .byte $14                               ;A#2            |
LB13D:  .byte $14                               ;A#2            |
LB13E:  .byte $14                               ;A#2            |
LB13F:  .byte $2C                               ;A#3            | Repeat 2 times
LB140:  .byte $2A                               ;A3             |
LB141:  .byte $2A                               ;A3             |
LB142:  .byte $B9                               ;1/8 seconds    |
LB143:  .byte $2A                               ;A3             |
LB144:  .byte $2A                               ;A3             |
LB145:  .byte $2A                               ;A3             |
LB146:  .byte $B2                               ;3/8 seconds    |
LB147:  .byte $2A                               ;A3             |
LB148:  .byte $28                               ;Ab3            |
LB149:  .byte $28                               ;Ab3            |
LB14A:  .byte $B9                               ;1/8 seconds    |
LB14B:  .byte $28                               ;Ab3            |
LB14C:  .byte $28                               ;Ab3            |
LB14D:  .byte $28                               ;Ab3            |
LB14E:  .byte $B2                               ;3/8 seconds    |
LB14F:  .byte $28                               ;Ab3            |
LB150:  .byte $26                               ;G3             |
LB151:  .byte $26                               ;G3             |
LB152:  .byte $B9                               ;1/8 seconds    |
LB153:  .byte $26                               ;G3             |
LB154:  .byte $26                               ;G3             |
LB155:  .byte $3E                               ;G4             |
LB156:  .byte $26                               ;G3             |
LB157:  .byte $26                               ;G3             |
LB158:  .byte $3E                               ;G4             +
LB159:  .byte $FF                               ;

EscapeNoiseData:
LB15A:  .byte $F0                               ;
LB15B:  .byte $B2                               ;3/8 seconds    +
LB15C:  .byte $01                               ;Drumbeat 00    |
LB15D:  .byte $04                               ;Drumbeat 01    | Repeat 48 times
LB15E:  .byte $01                               ;Drumbeat 00    |
LB15F:  .byte $04                               ;Drumbeat 01    +
LB160:  .byte $FF                               ;

MthrBrnRoomTriData:
LB161:  .byte $E0                               ;
LB162:  .byte $BA                               ;3/64 seconds   +
LB163:  .byte $2A                               ;A3             |
LB164:  .byte $1A                               ;C#3            |
LB165:  .byte $02                               ;No sound       |
LB166:  .byte $3A                               ;F4             |
LB167:  .byte $40                               ;Ab4            |
LB168:  .byte $02                               ;No sound       |
LB169:  .byte $1C                               ;D3             |
LB16A:  .byte $2E                               ;B3             |
LB16B:  .byte $38                               ;E4             |
LB16C:  .byte $2C                               ;A#3            |
LB16D:  .byte $3C                               ;F#4            |
LB16E:  .byte $38                               ;E4             |
LB16F:  .byte $02                               ;No sound       |
LB170:  .byte $40                               ;Ab4            |
LB171:  .byte $44                               ;A#4            |
LB172:  .byte $46                               ;B4             |
LB173:  .byte $02                               ;No sound       |
LB174:  .byte $1E                               ;D#3            |
LB175:  .byte $02                               ;No sound       | Repeat 32 times
LB176:  .byte $2C                               ;A#3            |
LB177:  .byte $38                               ;E4             |
LB178:  .byte $46                               ;B4             |
LB179:  .byte $26                               ;G3             |
LB17A:  .byte $02                               ;No sound       |
LB17B:  .byte $3A                               ;F4             |
LB17C:  .byte $20                               ;E3             |
LB17D:  .byte $02                               ;No sound       |
LB17E:  .byte $28                               ;Ab3            |
LB17F:  .byte $2E                               ;B3             |
LB180:  .byte $02                               ;No sound       |
LB181:  .byte $18                               ;C3             |
LB182:  .byte $44                               ;A#4            |
LB183:  .byte $02                               ;No sound       |
LB184:  .byte $46                               ;B4             |
LB185:  .byte $48                               ;C5             |
LB186:  .byte $4A                               ;C#5            |
LB187:  .byte $4C                               ;D5             |
LB188:  .byte $02                               ;No sound       |
LB189:  .byte $18                               ;C3             |
LB18A:  .byte $1E                               ;D#3            +
LB18B:  .byte $FF                               ;

MthrBrnRoomSQ1Data:
LB18C:  .byte $B8                               ;1/4 seconds
LB18D:  .byte $02                               ;No sound

;SQ1 music data runs down into the SQ2 music data.
MthrBrnRoomSQ2Data:
LB18E:  .byte $C8                               ;
LB18F:  .byte $B0                               ;3/32 seconds   +
LB190:  .byte $0A                               ;F2             | Repeat 8 times
LB191:  .byte $0C                               ;F#2            +
LB192:  .byte $FF                               ;
LB193:  .byte $C8                               ;
LB194:  .byte $0E                               ;G2             + Repeat 8 times
LB195:  .byte $0C                               ;F#2            +
LB196:  .byte $FF                               ;
LB197:  .byte $C8                               ;
LB198:  .byte $10                               ;Ab2            + Repeat 8 times
LB199:  .byte $0E                               ;G2             +
LB19A:  .byte $FF                               ;
LB19B:  .byte $C8                               ;
LB19C:  .byte $0E                               ;G2             + Repeat 8 times
LB19D:  .byte $0C                               ;F#2            +
LB19E:  .byte $FF                               ;
LB19F:  .byte $00                               ;End mother brain room music.