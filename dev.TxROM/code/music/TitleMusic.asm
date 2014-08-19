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
LAC00:  .byte $C2                       ;
LAC01:  .byte $B4                       ;7/8 seconds    +
LAc02:  .byte $2A                       ;A3             |
LAC03:  .byte $30                       ;C4             | Repeat 2 times.
LAC04:  .byte $2E                       ;B3             |
LAC05:  .byte $2C                       ;A#3            +
LAC06:  .byte $FF                       ;
LAC07:  .byte $2A                       ;A3
LAC08:  .byte $2A                       ;A3
LAC09:  .byte $C2                       ;
LAC0A:  .byte $B0                       ;1/4 seconds    +
LAC0B:  .byte $3C                       ;F#4            |
LAC0C:  .byte $42                       ;A4             |
LAC0D:  .byte $4C                       ;D5             |
LAC0E:  .byte $54                       ;F#5            |
LAC0F:  .byte $B2                       ;7/32 seconds   |
LAC10:  .byte $5A                       ;A5             |
LAC11:  .byte $56                       ;G5             |
LAC12:  .byte $54                       ;F#5            |
LAC13:  .byte $B4                       ;7/8 seconds    |
LAC14:  .byte $4C                       ;D5             |
LAC15:  .byte $B0                       ;1/4 seconds    |
LAC16:  .byte $38                       ;E4             | Repeat 2 times.
LAC17:  .byte $3C                       ;F#4            |
LAC18:  .byte $3E                       ;G4             |
LAC19:  .byte $42                       ;A4             |
LAC1A:  .byte $B2                       ;7/32 seconds   |
LAC1B:  .byte $4C                       ;D5             |
LAC1C:  .byte $42                       ;A4             |
LAC1D:  .byte $B0                       ;1/4 seconds    |
LAC1E:  .byte $56                       ;G5             |
LAC1F:  .byte $54                       ;F#5            |
LAC20:  .byte $4C                       ;D5             |
LAC21:  .byte $42                       ;A4             |
LAC22:  .byte $B3                       ;7/16 seconds   |
LAC23:  .byte $3E                       ;G4             |
LAC24:  .byte $4C                       ;D5             +
LAC25:  .byte $FF                       ;
LAC26:  .byte $C2                       ;
LAC27:  .byte $B3                       ;7/16 seconds   +
LAC28:  .byte $4A                       ;C#5            |
LAC29:  .byte $B2                       ;7/32 seconds   |
LAC2A:  .byte $4C                       ;D5             |
LAC2B:  .byte $42                       ;A4             |
LAC2C:  .byte $54                       ;F#5            |
LAC2D:  .byte $50                       ;E5             |
LAC2E:  .byte $56                       ;G5             |
LAC2F:  .byte $54                       ;F#5            |
LAC30:  .byte $B1                       ;7/64 seconds   |
LAC31:  .byte $50                       ;E5             |
LAC32:  .byte $4C                       ;D5             | Repeat 2 times.
LAC33:  .byte $44                       ;A#4            |
LAC34:  .byte $3E                       ;G4             |
LAC35:  .byte $B2                       ;7/32 seconds   |
LAC36:  .byte $3C                       ;F#4            |
LAC37:  .byte $4C                       ;D5             |
LAC38:  .byte $B1                       ;7/64 seconds   |
LAC39:  .byte $40                       ;Ab4            |
LAC3A:  .byte $46                       ;B4             |
LAC3B:  .byte $B2                       ;7/32 seconds   |
LAC3C:  .byte $50                       ;E5             |
LAC3D:  .byte $4C                       ;D5             |
LAC3E:  .byte $50                       ;E5             +
LAC3F:  .byte $FF                       ;
LAC40:  .byte $C4                       ;
LAC41:  .byte $B3                       ;7/16 seconds   +
LAC42:  .byte $2A                       ;A3             |
LAC43:  .byte $30                       ;C4             | Repeat 4 times.
LAC44:  .byte $2E                       ;B3             |
LAC45:  .byte $2C                       ;A#3            +
LAC46:  .byte $FF                       ;
LAC47:  .byte $B4                       ;7/8 seconds
LAC48:  .byte $34                       ;D4
LAC49:  .byte $B3                       ;7/16 seconds
LAC4A:  .byte $38                       ;E4
LAC4B:  .byte $3E                       ;G4
LAC4C:  .byte $B4                       ;7/8 seconds
LAC4D:  .byte $3C                       ;F#4
LAC4E:  .byte $B3                       ;7/16 seconds
LAC4F:  .byte $3E                       ;G4
LAC50:  .byte $44                       ;A#4
LAC51:  .byte $B5                       ;1 13/16 seconds
LAC52:  .byte $34                       ;D4
LAC53:  .byte $B1                       ;7/64 seconds
LAC54:  .byte $2A                       ;A3
LAC55:  .byte $B6                       ;21/32 seconds
LAC56:  .byte $1C                       ;D3
LAC57:  .byte $B2                       ;7/32 seconds
LAC58:  .byte $02                       ;No sound
LAC59:  .byte $B5                       ;1 13/16 seconds
LAC5A:  .byte $26                       ;G3
LAC5B:  .byte $B1                       ;7/64 seconds
LAC5C:  .byte $24                       ;F#3
LAC5D:  .byte $B8                       ;21/64 seconds
LAC5E:  .byte $06                       ;D2
LAC5F:  .byte $12                       ;A2
LAC60:  .byte $1C                       ;D3
LAC61:  .byte $B9                       ;9/32 seconds
LAC62:  .byte $02                       ;No sound
LAC63:  .byte $B8                       ;21/64 seconds
LAC64:  .byte $24                       ;F#3
LAC65:  .byte $2A                       ;A3
LAC66:  .byte $34                       ;D4
LAC67:  .byte $B9                       ;9/32 seconds
LAC68:  .byte $02                       ;No sound
LAC69:  .byte $B5                       ;1 13/16 seconds
LAC6A:  .byte $38                       ;E4
LAC6B:  .byte $B1                       ;7/64 seconds
LAC6C:  .byte $2C                       ;A#3
LAC6D:  .byte $B3                       ;7/16 seconds
LAC6E:  .byte $26                       ;G3
LAC6F:  .byte $2A                       ;A3
LAC70:  .byte $B5                       ;1 13/16 seconds
LAC71:  .byte $2A                       ;A3
LAC72:  .byte $B1                       ;7/64 seconds
LAC73:  .byte $02                       ;No sound
LAC74:  .byte $B8                       ;21/64 seconds
LAC75:  .byte $26                       ;G3
LAC76:  .byte $24                       ;F#3
LAC77:  .byte $1C                       ;D3
LAC78:  .byte $B9                       ;9/32 seconds
LAC79:  .byte $02                       ;No sound
LAC7A:  .byte $B8                       ;21/64 seconds
LAC7B:  .byte $20                       ;E3
LAC7C:  .byte $1C                       ;D3
LAC7D:  .byte $20                       ;E3
LAC7E:  .byte $B9                       ;9/32 seconds
LAC7F:  .byte $02                       ;No sound
LAC80:  .byte $B4                       ;7/8 seconds
LAC81:  .byte $1C                       ;D3
LAC82:  .byte $B8                       ;21/64 seconds
LAC83:  .byte $26                       ;G3
LAC84:  .byte $2C                       ;A#3
LAC85:  .byte $34                       ;D4
LAC86:  .byte $B9                       ;9/32 seconds
LAC87:  .byte $02                       ;No sound
LAC88:  .byte $B8                       ;21/64 seconds
LAC89:  .byte $3E                       ;G4
LAC8A:  .byte $44                       ;A#4
LAC8B:  .byte $4C                       ;D5
LAC8C:  .byte $B9                       ;9/32 seconds
LAC8D:  .byte $02                       ;No sound
LAC8E:  .byte $C8                       ;
LAC8F:  .byte $B0                       ;1/4 seconds    +
LAC90:  .byte $3C                       ;F#4            |
LAC91:  .byte $42                       ;A4             |
LAC92:  .byte $3C                       ;F#4            |
LAC93:  .byte $42                       ;A4             |
LAC94:  .byte $42                       ;A4             |
LAC95:  .byte $46                       ;B4             |
LAC96:  .byte $42                       ;A4             |
LAC97:  .byte $46                       ;B4             | Repeat 8 times.
LAC98:  .byte $4C                       ;D5             |
LAC99:  .byte $50                       ;E5             |
LAC9A:  .byte $4C                       ;D5             |
LAC9B:  .byte $50                       ;E5             |
LAC9C:  .byte $50                       ;E5             |
LAC9D:  .byte $54                       ;F#5            |
LAC9E:  .byte $50                       ;E5             |
LAC9F:  .byte $54                       ;F#5            +
LACA0:  .byte $FF                       ;
LACA1:  .byte $C2                       ;
LACA2:  .byte $B4                       ;7/8 seconds    +
LACA3:  .byte $2A                       ;A3             |
LACA4:  .byte $B3                       ;7/16 seconds   |
LACA5:  .byte $34                       ;D4             |
LACA6:  .byte $B5                       ;1 13/16 seconds|
LACA7:  .byte $32                       ;C#4            |
LACA8:  .byte $B1                       ;7/64 seconds   |
LACA9:  .byte $2E                       ;B3             | Repeat 2 times.
LACAA:  .byte $B4                       ;7/8 seconds    |
LACAB:  .byte $2A                       ;A3             |
LACAC:  .byte $B3                       ;7/16 seconds   |
LACAD:  .byte $1C                       ;D3             |
LACAE:  .byte $B5                       ;1 13/16 seconds|
LACAF:  .byte $26                       ;G3             |
LACB0:  .byte $B1                       ;7/64 seconds   |
LACB1:  .byte $24                       ;F#3            +
LACB2:  .byte $FF                       ;
LACB3:  .byte $B4                       ;7/8 seconds
LACB4:  .byte $2A                       ;A3
LACB5:  .byte $B8                       ;21/64 seconds
LACB6:  .byte $18                       ;C3
LACB7:  .byte $26                       ;G3
LACB8:  .byte $30                       ;C4
LACB9:  .byte $B9                       ;9/32 seconds
LACBA:  .byte $02                       ;No sound
LACBB:  .byte $B8                       ;21/64 seconds
LACBC:  .byte $1C                       ;D3
LACBD:  .byte $26                       ;G3
LACBE:  .byte $30                       ;C4
LACBF:  .byte $B9                       ;9/32 seconds
LACC0:  .byte $02                       ;No sound
LACC1:  .byte $B4                       ;7/8 seconds
LACC2:  .byte $34                       ;D4
LACC3:  .byte $B8                       ;21/64 seconds
LACC4:  .byte $3A                       ;F4
LACC5:  .byte $30                       ;C4
LAcc6:  .byte $26                       ;G3
LACC7:  .byte $B9                       ;9/32 seconds
LACC8:  .byte $02                       ;No sound
LACC9:  .byte $B8                       ;21/64 seconds
LACCA:  .byte $3E                       ;G4
LACCB:  .byte $38                       ;E4
LACCC:  .byte $30                       ;C4
LACCD:  .byte $B9                       ;9/32 seconds
LACCE:  .byte $02                       ;No sound
LACCF:  .byte $B4                       ;7/8 seconds
LACD0:  .byte $34                       ;D4
LACD1:  .byte $B2                       ;7/32 seconds
LACD2:  .byte $1C                       ;D3
LACD3:  .byte $2A                       ;A3
LACD4:  .byte $26                       ;G3
LACD5:  .byte $30                       ;C4
LACD6:  .byte $C2                       ;
LACD7:  .byte $B0                       ;1/4 seconds    +
LACD8:  .byte $38                       ;E4             |
LACD9:  .byte $38                       ;E4             |
LACDA:  .byte $38                       ;E4             |
LACDB:  .byte $02                       ;No sound       |
LACDC:  .byte $02                       ;No sound       |
LACDD:  .byte $02                       ;No sound       |
LACDE:  .byte $38                       ;E4             |
LACDF:  .byte $38                       ;E4             | Repeat 2 times.
LACE0:  .byte $38                       ;E4             |
LACE1:  .byte $02                       ;No sound       |
LACE2:  .byte $38                       ;E4             |
LACE3:  .byte $38                       ;E4             |
LACE4:  .byte $38                       ;E4             |
LACE5:  .byte $38                       ;E4             |
LACE6:  .byte $38                       ;E4             |
LACE7:  .byte $02                       ;No sound       +
LACE8:  .byte $FF                       ;
LACE9:  .byte $B4                       ;7/8 seconds
LACEA:  .byte $38                       ;E4
LACEB:  .byte $B2                       ;7/32 seconds
LACEC:  .byte $02                       ;No sound
LACED:  .byte $B0                       ;1/4 seconds
LACEE:  .byte $1C                       ;D3
LACEF:  .byte $02                       ;No sound
LACF0:  .byte $1C                       ;D3
LACF1:  .byte $1C                       ;D3
LACF2:  .byte $B2                       ;7/32 seconds
LACF3:  .byte $06                       ;D2
LACF4:  .byte $00                       ;End of end music.

EndTriangleData:
LACF5:  .byte $CA                       ;
LACF6:  .byte $B0                       ;1/4 seconds    +
LACF7:  .byte $2A                       ;A3             |
LACF8:  .byte $2A                       ;A3             |
LACF9:  .byte $2A                       ;A3             |
LACFA:  .byte $02                       ;No sound       |
LACFB:  .byte $02                       ;No sound       |
LACFC:  .byte $02                       ;No sound       |
LACFD:  .byte $2A                       ;A3             | Repeat 10 times.
LACFE:  .byte $2A                       ;A3             |
LACFF:  .byte $2A                       ;A3             |
LAD00:  .byte $02                       ;No sound       |
LAD01:  .byte $2A                       ;A3             |
LAD02:  .byte $2A                       ;A3             |
LAD03:  .byte $2A                       ;A3             |
LAD04:  .byte $2A                       ;A3             |
LAD05:  .byte $2A                       ;A3             |
LAD06:  .byte $02                       ;No sound       +
LAD07:  .byte $FF                       ;
LAD08:  .byte $C2                       ;
LAD09:  .byte $B2                       ;7/32 seconds   +
LAD0A:  .byte $34                       ;D4             |
LAD0B:  .byte $34                       ;D4             |
LAD0C:  .byte $32                       ;C#4            |
LAD0D:  .byte $32                       ;C#4            |
LAD0E:  .byte $2E                       ;B3             |
LAD0f:  .byte $2E                       ;B3             |
LAD10:  .byte $2A                       ;A3             |
LAD11:  .byte $2A                       ;A3             | Repeat 2 times.
LAD12:  .byte $26                       ;G3             |
LAD13:  .byte $26                       ;G3             |
LAD14:  .byte $24                       ;F#3            |
LAD15:  .byte $24                       ;F#3            |
LAD16:  .byte $20                       ;E3             |
LAD17:  .byte $20                       ;E3             |
LAD18:  .byte $2A                       ;A3             |
LAD19:  .byte $2A                       ;A3             +
LAD1A:  .byte $FF                       ;
LAD1B:  .byte $C2                       ;
LAD1C:  .byte $26                       ;G3             +
LAD1D:  .byte $26                       ;G3             |
LAD1E:  .byte $24                       ;F#3            |
LAD1F:  .byte $24                       ;F#3            |
LAD20:  .byte $30                       ;C4             |
LAD21:  .byte $30                       ;C4             |
LAD22:  .byte $2E                       ;B3             |
LAD23:  .byte $2E                       ;B3             | Repeat 2 times.
LAD24:  .byte $2C                       ;A#3            |
LAD25:  .byte $2C                       ;A#3            |
LAD26:  .byte $2A                       ;A3             |
LAD27:  .byte $2A                       ;A3             |
LAD28:  .byte $28                       ;Ab3            |
LAD29:  .byte $28                       ;Ab3            |
LAD2A:  .byte $2A                       ;A3             |
LAD2B:  .byte $2A                       ;A3             +
LAD2C:  .byte $FF                       ;
LAD2D:  .byte $C8                       ;
LAD2E:  .byte $B0                       ;1/4 seconds    +
LAD2F:  .byte $1C                       ;D3             |
LAD30:  .byte $1C                       ;D3             |
LAD31:  .byte $1C                       ;D3             |
LAD32:  .byte $02                       ;No sound       |
LAD33:  .byte $02                       ;No sound       |
LAD34:  .byte $02                       ;No sound       |
LAD35:  .byte $1C                       ;D3             | Repeat 8 times.
LAD36:  .byte $1C                       ;D3             |
LAD37:  .byte $1C                       ;D3             |
LAD38:  .byte $02                       ;No sound       |
LAD39:  .byte $1C                       ;D3             |
LAD3A:  .byte $1C                       ;D3             |
LAD3B:  .byte $1C                       ;D3             |
LAD3C:  .byte $1C                       ;D3             |
LAD3D:  .byte $1C                       ;D3             |
LAD3E:  .byte $02                       ;No sound       +
LAD3F:  .byte $FF                       ;
LAD40:  .byte $D8                       ;
LAD41:  .byte $BA                       ;1/32 seconds   +
LAD42:  .byte $64                       ;D6             |
LAD43:  .byte $02                       ;No sound       |
LAD44:  .byte $64                       ;D6             |
LAD45:  .byte $02                       ;No sound       |
LAD46:  .byte $B9                       ;9/32 seconds   |
LAD47:  .byte $02                       ;No sound       |
LAD48:  .byte $BA                       ;1/32 Seconds   |
LAD49:  .byte $72                       ;A6             |
LAD4A:  .byte $02                       ;No sound       |
LAD4B:  .byte $72                       ;A6             |
LAD4C:  .byte $02                       ;No sound       |
LAD4D:  .byte $B9                       ;9/32 seconds   | Repeat 24 times.
LAD4E:  .byte $02                       ;No sound       |
LAD4F:  .byte $BA                       ;1/32 seconds   |
LAD50:  .byte $7C                       ;D7             |
LAD51:  .byte $02                       ;No sound       |
LAD52:  .byte $7C                       ;D7             |
LAD53:  .byte $02                       ;No sound       |
LAD54:  .byte $B9                       ;9/32 seconds   |
LAD55:  .byte $02                       ;No sound       |
LAD56:  .byte $BA                       ;1/32 seconds   |
LAD57:  .byte $72                       ;A6             |
LAD58:  .byte $02                       ;No sound       |
LAD59:  .byte $72                       ;A6             |
LAD5A:  .byte $02                       ;No sound       |
LAD5B:  .byte $B9                       ;9/32 seconds   |
LAD5C:  .byte $02                       ;No sound       +
LAD5D:  .byte $FF                       ;
LAD5E:  .byte $C4                       ;
LAD5F:  .byte $B1                       ;7/64 seconds   +
LAD60:  .byte $34                       ;D4             |
LAD61:  .byte $34                       ;D4             |
LAD62:  .byte $34                       ;D4             |
LAD63:  .byte $34                       ;D4             |
LAD64:  .byte $02                       ;No sound       |
LAD65:  .byte $24                       ;F#3            |
LAD66:  .byte $24                       ;F#3            |
LAD67:  .byte $24                       ;F#3            |
LAD68:  .byte $20                       ;E3             |
LAD69:  .byte $20                       ;E3             |
LAD6A:  .byte $20                       ;E3             |
LAD6B:  .byte $20                       ;E3             |
LAD6C:  .byte $2A                       ;A3             |
LAD6D:  .byte $2A                       ;A3             |
LAD6E:  .byte $2A                       ;A3             |
LAD6F:  .byte $2A                       ;A3             | Repeat 4 times.
LAD70:  .byte $02                       ;No sound       |
LAD71:  .byte $24                       ;F#3            |
LAD72:  .byte $24                       ;F#3            |
LAD73:  .byte $24                       ;F#3            |
LAD74:  .byte $24                       ;F#3            |
LAD75:  .byte $24                       ;F#3            |
LAD76:  .byte $24                       ;F#3            |
LAD77:  .byte $24                       ;F#3            |
LAD78:  .byte $B8                       ;21/64 seconds  |
LAD79:  .byte $26                       ;G3             |
LAD7A:  .byte $1C                       ;D3             |
LAD7B:  .byte $20                       ;E3             |
LAD7C:  .byte $B9                       ;9/32 seconds   |
LAD7D:  .byte $02                       ;No sound       |
LAD7E:  .byte $B8                       ;21/64 seconds  |
LAD7F:  .byte $2C                       ;A#3            |
LAD80:  .byte $2A                       ;A3             |
LAD81:  .byte $26                       ;G3             |
LAD82:  .byte $B9                       ;9/32 seconds   |
LAD83:  .byte $02                       ;No sound       +
LAD84:  .byte $FF                       ;
LAD85:  .byte $C3                       ;
LAD86:  .byte $B0                       ;1/4 seconds    +
LAD87:  .byte $34                       ;D4             |
LAD88:  .byte $34                       ;D4             |
LAD89:  .byte $34                       ;D4             |
LAD8A:  .byte $02                       ;No sound       |
LAD8B:  .byte $02                       ;No sound       |
LAD8C:  .byte $02                       ;No sound       |
LAD8D:  .byte $34                       ;D4             |
LAD8E:  .byte $34                       ;D4             |
LAD8F:  .byte $34                       ;D4             |
LAD90:  .byte $02                       ;No sound       |
LAD91:  .byte $34                       ;D4             |
LAD92:  .byte $34                       ;D4             |
LAD93:  .byte $34                       ;D4             |
LAD94:  .byte $34                       ;D4             | Repeat 3 times.
LAD95:  .byte $34                       ;D4             |
LAD96:  .byte $02                       ;No sound       |
LAD97:  .byte $2C                       ;A#3            |
LAD98:  .byte $2C                       ;A#3            |
LAD99:  .byte $2C                       ;A#3            |
LAD9A:  .byte $02                       ;No sound       |
LAD9B:  .byte $02                       ;No sound       |
LAD9C:  .byte $02                       ;No sound       |
LAD9D:  .byte $2C                       ;A#3            |
LAD9E:  .byte $2C                       ;A#3            |
LAD9F:  .byte $30                       ;C4             |
LADA0:  .byte $02                       ;No sound       |
LADA1:  .byte $30                       ;C4             |
LADA2:  .byte $30                       ;C4             |
LADA3:  .byte $30                       ;C4             |
LADA4:  .byte $30                       ;C4             |
LADA5:  .byte $30                       ;C4             |
LADA6:  .byte $02                       ;No sound       +
LADA7:  .byte $FF                       ;
LADA8:  .byte $C2                       ;
LADA9:  .byte $1C                       ;D3             +
LADAA:  .byte $1C                       ;D3             |
LADAB:  .byte $1C                       ;D3             |
LADAC:  .byte $02                       ;No sound       |
LADAD:  .byte $02                       ;No sound       |
LADAE:  .byte $02                       ;No sound       |
LADAF:  .byte $1C                       ;D3             | Repeat 2 times.
LADB0:  .byte $1C                       ;D3             |
LADB1:  .byte $1C                       ;D3             |
LADB2:  .byte $02                       ;No sound       |
LADB3:  .byte $1C                       ;D3             |
LADB4:  .byte $1C                       ;D3             |
LADB5:  .byte $1C                       ;D3             |
LADB6:  .byte $1C                       ;D3             |
LADB7:  .byte $1C                       ;D3             |
LADB8:  .byte $02                       ;No sound       +
LADB9:  .byte $FF                       ;
LADBA:  .byte $B4                       ;7/8 seconds
LADBB:  .byte $1C                       ;D3
LADBC:  .byte $B2                       ;7/32 seconds
LADBD:  .byte $02                       ;No sound
LADBE:  .byte $B0                       ;1/4 seconds
LADBF:  .byte $1C                       ;D3
LADC0:  .byte $02                       ;No sound
LADC1:  .byte $1C                       ;D3
LADC2:  .byte $1C                       ;D3
LADC3:  .byte $B2                       ;7/32 seconds
LADC4:  .byte $1C                       ;D3

EndSQ2Data:
LADC5:  .byte $C2                       ;
LADC6:  .byte $B4                       ;7/8 seconds    +
LADC7:  .byte $20                       ;E3             |
LADC8:  .byte $2A                       ;A3             | Repeat 2 times.
LADC9:  .byte $28                       ;Ab3            |
LADCA:  .byte $26                       ;G3             +
LADCB:  .byte $FF                       ;
LADCC:  .byte $20                       ;E3
LADCD:  .byte $20                       ;E3
LADCE:  .byte $C2                       ;
LADCF:  .byte $B0                       ;1/4 seconds    +
LADD0:  .byte $34                       ;D4             |
LADD1:  .byte $3C                       ;F#4            |
LADD2:  .byte $42                       ;A4             |
LADD3:  .byte $4C                       ;D5             |
LADD4:  .byte $B2                       ;7/32 seconds   |
LADD5:  .byte $54                       ;F#5            |
LADD6:  .byte $50                       ;E5             |
LADD7:  .byte $4C                       ;D5             |
LADD8:  .byte $B3                       ;7/16 seconds   |
LADD9:  .byte $42                       ;A4             | Repeat 2 times.
LADDA:  .byte $3C                       ;F#4            |
LADDB:  .byte $B3                       ;7/16 seconds   |
LADDC:  .byte $46                       ;B4             |
LADDD:  .byte $B2                       ;7/32 seconds   |
LADDE:  .byte $34                       ;D4             |
LADDF:  .byte $B1                       ;7/64 seconds   |
LADE0:  .byte $4C                       ;D5             |
LADE1:  .byte $B0                       ;1/4 seconds    |
LADE2:  .byte $42                       ;A4             |
LADE3:  .byte $3C                       ;F#4            |
LADE4:  .byte $B3                       ;7/16 seconds   |
LADE5:  .byte $38                       ;E4             |
LADE6:  .byte $46                       ;B4             +
LADE7:  .byte $FF                       ;
LADE8:  .byte $C2                       ;
LADE9:  .byte $B3                       ;7/16 seconds   +
LADEA:  .byte $38                       ;E4             |
LADEB:  .byte $B2                       ;7/32 seconds   |
LADEC:  .byte $3C                       ;F#4            |
LADED:  .byte $34                       ;D4             |
LADEE:  .byte $34                       ;D4             |
LADEF:  .byte $30                       ;C4             |
LADF0:  .byte $38                       ;E4             |
LADF1:  .byte $34                       ;D4             |
LADF2:  .byte $44                       ;A#4            | Repeat 2 times.
LADF3:  .byte $38                       ;E4             |
LADF4:  .byte $34                       ;D4             |
LADF5:  .byte $42                       ;A4             |
LADF6:  .byte $B1                       ;7/64 seconds   |
LADF7:  .byte $3A                       ;F4             |
LADF8:  .byte $40                       ;Ab4            |
LADF9:  .byte $B2                       ;7/32 seconds   |
LADFA:  .byte $46                       ;B4             |
LADFB:  .byte $3E                       ;G4             |
LADFC:  .byte $3E                       ;G4             +
LADFD:  .byte $FF                       ;
LADFE:  .byte $C4                       ;
LADFF:  .byte $B2                       ;7/32 seconds   +
LAE00:  .byte $3C                       ;F#4            |
LAE01:  .byte $42                       ;A4             |
LAE02:  .byte $4C                       ;D5             |
LAE03:  .byte $42                       ;A4             | Repeat 4 times.
LAE04:  .byte $3E                       ;G4             |
LAE05:  .byte $42                       ;A4             |
LAE06:  .byte $4C                       ;D5             |
LAE07:  .byte $3E                       ;G4             +
LAE08:  .byte $FF                       ;
LAE09:  .byte $C2                       ;
LAE0A:  .byte $72                       ;A6             +
LAE0B:  .byte $6E                       ;G6             |
LAE0C:  .byte $6C                       ;F#6            |
LAE0D:  .byte $68                       ;E6             |
LAE0E:  .byte $6E                       ;G6             |
LAE0F:  .byte $6C                       ;F#6            |
LAE10:  .byte $64                       ;D6             |
LAE11:  .byte $68                       ;E6             +
LAE12:  .byte $FF                       ;
LAE13:  .byte $B4                       ;7/8 seconds
LAE14:  .byte $4C                       ;D5
LAE15:  .byte $B3                       ;7/16 seconds
LAE16:  .byte $56                       ;G5
LAE17:  .byte $50                       ;E5
LAE18:  .byte $B4                       ;7/8 seconds
LAE19:  .byte $54                       ;F#5
LAE1A:  .byte $B3                       ;7/16 seconds
LAE1B:  .byte $56                       ;G5
LAE1C:  .byte $5C                       ;A#5
LAE1D:  .byte $B4                       ;7/8 seconds
LAE1E:  .byte $4C                       ;D5
LAE1F:  .byte $B3                       ;7/16 seconds
LAE20:  .byte $50                       ;E5
LAE21:  .byte $56                       ;G5
LAE22:  .byte $B4                       ;7/8 seconds
LAE23:  .byte $54                       ;F#5
LAE24:  .byte $B3                       ;7/16 seconds
LAE25:  .byte $56                       ;G5
LAE26:  .byte $5C                       ;A#5
LAE27:  .byte $C4                       ;
LAE28:  .byte $B1                       ;7/64 seconds   +
LAE29:  .byte $5A                       ;A5             |
LAE2A:  .byte $42                       ;A4             |
LAE2B:  .byte $56                       ;G5             |
LAE2C:  .byte $42                       ;A4             |
LAE2D:  .byte $54                       ;F#5            |
LAE2E:  .byte $42                       ;A4             |
LAE2F:  .byte $50                       ;E5             | Repeat 4 times.
LAE30:  .byte $42                       ;A4             |
LAE31:  .byte $56                       ;G5             |
LAE32:  .byte $3E                       ;G4             |
LAE33:  .byte $54                       ;F#5            |
LAE34:  .byte $3E                       ;G4             |
LAE35:  .byte $4C                       ;D5             |
LAE36:  .byte $3E                       ;G4             |
LAE37:  .byte $50                       ;E5             |
LAE38:  .byte $3E                       ;G4             +
LAE39:  .byte $FF                       ;
LAE3A:  .byte $C8                       ;
LAE3B:  .byte $B0                       ;1/4 seconds    +
LAE3C:  .byte $3C                       ;F#4            |
LAE3D:  .byte $3E                       ;G4             |
LAE3E:  .byte $3C                       ;F#4            |
LAE3F:  .byte $3E                       ;G4             |
LAE40:  .byte $42                       ;A4             |
LAE41:  .byte $46                       ;B4             |
LAE42:  .byte $42                       ;A4             | Repeat 8 times.
LAE43:  .byte $46                       ;B4             |
LAE44:  .byte $4C                       ;D5             |
LAE45:  .byte $50                       ;E5             |
LAE46:  .byte $4C                       ;D5             |
LAE47:  .byte $50                       ;E5             |
LAE48:  .byte $50                       ;E5             |
LAE49:  .byte $54                       ;F#5            |
LAE4A:  .byte $50                       ;E5             |
LAE4B:  .byte $54                       ;F#5            +
LAE4C:  .byte $FF                       ;
LAE4D:  .byte $C3                       ;
LAE4E:  .byte $B0                       ;1/4 seconds    +
LAE4F:  .byte $42                       ;A4             |
LAE50:  .byte $42                       ;A4             |
LAE51:  .byte $42                       ;A4             |
LAE52:  .byte $02                       ;No sound       |
LAE53:  .byte $02                       ;No sound       |
LAE54:  .byte $02                       ;No sound       |
LAE55:  .byte $42                       ;A4             |
LAE56:  .byte $42                       ;A4             |
LAE57:  .byte $42                       ;A4             |
LAE58:  .byte $02                       ;No sound       |
LAE59:  .byte $42                       ;A4             |
LAE5A:  .byte $42                       ;A4             |
LAE5B:  .byte $42                       ;A4             |
LAE5C:  .byte $42                       ;A4             |
LAE5D:  .byte $42                       ;A4             | Repeat 3 times.
LAE5E:  .byte $02                       ;No sound       |
LAE5F:  .byte $3A                       ;F4             |
LAE60:  .byte $3A                       ;F4             |
LAE61:  .byte $3A                       ;F4             |
LAE62:  .byte $02                       ;No sound       |
LAE63:  .byte $02                       ;No sound       |
LAE64:  .byte $02                       ;No sound       |
LAE65:  .byte $3A                       ;F4             |
LAE66:  .byte $3A                       ;F4             |
LAE67:  .byte $3E                       ;G4             |
LAE68:  .byte $02                       ;No sound       |
LAE69:  .byte $3E                       ;G4             |
LAE6A:  .byte $3E                       ;G4             |
LAE6B:  .byte $3E                       ;G4             |
LAE6C:  .byte $3E                       ;G4             |
LAE6D:  .byte $3E                       ;G4             |
LAE6E:  .byte $02                       ;No sound       +
LAE6F:  .byte $FF                       ;
LAE70:  .byte $C2                       ;
LAE71:  .byte $42                       ;A4             +
LAE72:  .byte $42                       ;A4             |
LAE73:  .byte $42                       ;A4             |
LAE74:  .byte $02                       ;No sound       |
LAE75:  .byte $02                       ;No sound       |
LAE76:  .byte $02                       ;No sound       |
LAE77:  .byte $42                       ;A4             |
LAE78:  .byte $42                       ;A4             | Repeat 2 times.
LAE79:  .byte $42                       ;A4             |
LAE7A:  .byte $02                       ;No sound       |
LAE7B:  .byte $42                       ;A4             |
LAE7C:  .byte $42                       ;A4             |
LAE7D:  .byte $42                       ;A4             |
LAE7E:  .byte $42                       ;A4             |
LAE7F:  .byte $42                       ;A4             |
LAE80:  .byte $02                       ;No sound       +
LAE81:  .byte $FF                       ;
LAE82:  .byte $B4                       ;7/8 seconds
LAE83:  .byte $2A                       ;A3
LAE84:  .byte $B2                       ;7/32 seconds
LAE85:  .byte $02                       ;No sound
LAE86:  .byte $B0                       ;1/4 seconds
LAE87:  .byte $2A                       ;A3
LAE88:  .byte $02                       ;No sound
LAE89:  .byte $2A                       ;A3
LAE8A:  .byte $2A                       ;A3
LAE8B:  .byte $B2                       ;7/32 seconds
LAE8C:  .byte $2A                       ;A3
LAE8D:  .byte $00                       ;End of end music.

EndNoiseData:
LAE8E:  .byte $CA                       ;
LAE8F:  .byte $B0                       ;1/4 seconds    +
LAE90:  .byte $04                       ;Drumbeat 01    |
LAE91:  .byte $04                       ;Drumbeat 01    |
LAE92:  .byte $04                       ;Drumbeat 01    |
LAE93:  .byte $01                       ;Drumbeat 00    |
LAE94:  .byte $01                       ;Drumbeat 00    |
LAE95:  .byte $01                       ;Drumbeat 00    |
LAE96:  .byte $04                       ;Drumbeat 01    |
LAE97:  .byte $04                       ;Drumbeat 01    | Repeat 10 times.
LAE98:  .byte $04                       ;Drumbeat 01    |
LAE99:  .byte $01                       ;Drumbeat 00    |
LAE9A:  .byte $04                       ;Drumbeat 01    |
LAE9B:  .byte $04                       ;Drumbeat 01    |
LAE9C:  .byte $04                       ;Drumbeat 01    |
LAE9D:  .byte $04                       ;Drumbeat 01    |
LAE9E:  .byte $04                       ;Drumbeat 01    |
LAE9F:  .byte $01                       ;Drumbeat 00    +
LAEA0:  .byte $FF                       ;
LAEA1:  .byte $D8                       ;
LAEA2:  .byte $B2                       ;7/32 seconds   +
LAEA3:  .byte $04                       ;Drumbeat 01    | Repeat 24 times.
LAEA4:  .byte $07                       ;Drumbeat 02    +
LAEA5:  .byte $FF                       ;
LAEA6:  .byte $C4                       ;
LAEA7:  .byte $B0                       ;1/4 seconds    +
LAEA8:  .byte $04                       ;Drumbeat 01    |
LAEA9:  .byte $04                       ;Drumbeat 01    |
LAEAA:  .byte $04                       ;Drumbeat 01    |
LAEAB:  .byte $01                       ;Drumbeat 00    |
LAEAC:  .byte $01                       ;Drumbeat 00    |
LAEAD:  .byte $01                       ;Drumbeat 00    |
LAEAE:  .byte $04                       ;Drumbeat 01    | Repeat 4 times.
LAEAF:  .byte $04                       ;Drumbeat 01    |
LAEB0:  .byte $04                       ;Drumbeat 01    |
LAEB1:  .byte $01                       ;Drumbeat 00    |
LAEB2:  .byte $04                       ;Drumbeat 01    |
LAEB3:  .byte $04                       ;Drumbeat 01    |
LAEB4:  .byte $04                       ;Drumbeat 01    |
LAEB5:  .byte $04                       ;Drumbeat 01    |
LAEB6:  .byte $04                       ;Drumbeat 01    |
LAEB7:  .byte $01                       ;Drumbeat 00    +
LAEB8:  .byte $FF                       ;
LAEB9:  .byte $C8                       ;
LAEBA:  .byte $B1                       ;7/64 seconds   +
LAEBB:  .byte $04                       ;Drumbeat 01    |
LAEBC:  .byte $B0                       ;1/4 seconds    |
LAEBD:  .byte $04                       ;Drumbeat 01    |
LAEBE:  .byte $04                       ;Drumbeat 01    |
LAEBF:  .byte $B1                       ;7/64 seconds   |
LAEC0:  .byte $04                       ;Drumbeat 01    |
LAEC1:  .byte $B0                       ;1/4 seconds    |
LAEC2:  .byte $04                       ;Drumbeat 01    |
LAEC3:  .byte $04                       ;Drumbeat 01    | Repeat 8 times.
LAEC4:  .byte $B1                       ;7/64 seconds   |
LAEC5:  .byte $04                       ;Drumbeat 01    |
LAEC6:  .byte $B0                       ;1/4 seconds    |
LAEC7:  .byte $04                       ;Drumbeat 01    |
LAEC8:  .byte $04                       ;Drumbeat 01    |
LAEC9:  .byte $B1                       ;7/64 seconds   |
LAECA:  .byte $07                       ;Drumbeat 02    |
LAECB:  .byte $B0                       ;1/4 seconds    |
LAECC:  .byte $04                       ;Drumbeat 01    |
LAECD:  .byte $04                       ;Drumbeat 01    +
LAECE:  .byte $FF                       ;
LAECF:  .byte $D0                       ;
LAED0:  .byte $B2                       ;7/32 seconds   + Repeat 16 times.
LAED1:  .byte $04                       ;Drumbeat01     +
LAED2:  .byte $FF                       ;
LAED3:  .byte $E0                       ;
LAED4:  .byte $B1                       ;7/64 seconds   +
LAED5:  .byte $04                       ;Drumbeat 01    | Repeat 32 times.
LAED6:  .byte $04                       ;Drumbeat 01    +
LAED7:  .byte $FF                       ;
LAED8:  .byte $E0                       ;
LAED9:  .byte $B0                       ;1/4 seconds    +
LAEDA:  .byte $04                       ;Drumbeat 01    |
LAEDB:  .byte $04                       ;Drumbeat 01    |
LAEDC:  .byte $B1                       ;7/64 seconds   |
LAEDD:  .byte $07                       ;Drumbeat 02    | Repeat 32 times.
LAEDE:  .byte $B0                       ;1/4 seconds    |
LAEDF:  .byte $0A                       ;Drumbeat 03    |
LAEE0:  .byte $04                       ;Drumbeat 01    |
LAEE1:  .byte $B1                       ;7/64 seconds   |
LAEE2:  .byte $07                       ;Drumbeat 02    +
LAEE3:  .byte $FF                       ;
LAEE4:  .byte $C8                       ;
LAEE5:  .byte $B0                       ;1/4 seconds    +
LAEE6:  .byte $04                       ;Drumbeat 01    |
LAEE7:  .byte $04                       ;Drumbeat 01    |
LAEE8:  .byte $04                       ;Drumbeat 01    |
LAEE9:  .byte $01                       ;Drumbeat 00    |
LAEEA:  .byte $01                       ;Drumbeat 00    |
LAEEB:  .byte $01                       ;Drumbeat 00    |
LAEEC:  .byte $04                       ;Drumbeat 01    | Repeat 8 times.
LAEED:  .byte $04                       ;Drumbeat 01    |
LAEEE:  .byte $04                       ;Drumbeat 01    |
LAEEF:  .byte $01                       ;Drumbeat 00    |
LAEF0:  .byte $04                       ;Drumbeat 01    |
LAEF1:  .byte $04                       ;Drumbeat 01    |
LAEF2:  .byte $04                       ;Drumbeat 01    |
LAEF3:  .byte $04                       ;Drumbeat 01    |
LAEF4:  .byte $04                       ;Drumbeat 01    |
LAEF5:  .byte $01                       ;Drumbeat 00    +
LAEF6:  .byte $FF                       ;
LAEF7:  .byte $B4                       ;7/8 seconds
LAEF8:  .byte $07                       ;Drumbeat 02
LAEF9:  .byte $B2                       ;7/32 seconds
LAEFA:  .byte $01                       ;Drumbeat 00
LAEFB:  .byte $B0                       ;1/4 seconds
LAEFC:  .byte $07                       ;Drumbeat 02
LAEFD:  .byte $01                       ;Drumbeat 00
LAEFE:  .byte $07                       ;Drumbeat 02
LAEFF:  .byte $07                       ;Drumbeat 02
LAF00:  .byte $B2                       ;7/32 seconds
LAF01:  .byte $07                       ;Drumbeat 02
LAF02:  .byte $00                       ;End of end music.

.advance $B000, $00

IntroSQ2Data:
LB000:  .byte $C2                       ;
LB001:  .byte $B4                       ;7/8 seconds    +
LB002:  .byte $64                       ;D6             |
LB003:  .byte $74                       ;A#6            |
LB004:  .byte $6A                       ;F6             |
LB005:  .byte $02                       ;No sound       | Repeat 2 times.
LB006:  .byte $64                       ;D6             |
LB007:  .byte $78                       ;C7             |
LB008:  .byte $74                       ;A#6            |
LB009:  .byte $02                       ;No sound       +
LB00A:  .byte $FF                       ;
LB00B:  .byte $C2                       ;
LB00C:  .byte $B2                       ;7/32 seconds   +
LB00D:  .byte $72                       ;A6             |
LB00E:  .byte $5A                       ;A5             |
LB00F:  .byte $6E                       ;G6             |
LB010:  .byte $56                       ;G5             |
LB011:  .byte $6C                       ;F#6            |
LB012:  .byte $54                       ;F#5            |
LB013:  .byte $68                       ;E6             | Repeat 2 times.
LB014:  .byte $50                       ;E5             |
LB015:  .byte $6E                       ;G6             |
LB016:  .byte $56                       ;G5             |
LB017:  .byte $6C                       ;F#6            |
LB018:  .byte $54                       ;F#5            |
LB019:  .byte $68                       ;E6             |
LB01A:  .byte $50                       ;E5             |
LB01B:  .byte $64                       ;D6             |
LB01C:  .byte $4C                       ;D5             +
LB01D:  .byte $FF                       ;
LB01E:  .byte $C4                       ;
LB01F:  .byte $72                       ;A6             +
LB020:  .byte $5A                       ;A5             |
LB021:  .byte $6E                       ;G6             |
LB022:  .byte $5A                       ;A5             |
LB023:  .byte $6C                       ;F#6            |
LB024:  .byte $5A                       ;A5             |
LB025:  .byte $68                       ;E6             |
LB026:  .byte $5A                       ;A5             | Repeat 4 times.
LB027:  .byte $6E                       ;G6             |
LB028:  .byte $56                       ;G5             |
LB029:  .byte $6C                       ;F#6            |
LB02A:  .byte $56                       ;G5             |
LB02B:  .byte $68                       ;E6             |
LB02C:  .byte $56                       ;G5             |
LB02D:  .byte $64                       ;D6             |
LB02E:  .byte $56                       ;G5             +
LB02F:  .byte $FF                       ;
LB030:  .byte $B2                       ;7/32 seconds
LB031:  .byte $5A                       ;A5
LB032:  .byte $B1                       ;7/64 seconds
LB033:  .byte $42                       ;A4
LB034:  .byte $B2                       ;7/32 seconds
LB035:  .byte $56                       ;G5
LB036:  .byte $B1                       ;7/64 seconds
LB037:  .byte $42                       ;A4
LB038:  .byte $B2                       ;7/32 seconds
LB039:  .byte $54                       ;F#5
LB03A:  .byte $B1                       ;7/64 seconds
LB03B:  .byte $42                       ;A4
LB03C:  .byte $B2                       ;7/32 seconds
LB03D:  .byte $50                       ;E5
LB03E:  .byte $B1                       ;7/64 seconds
LB03F:  .byte $42                       ;A4
LB040:  .byte $B2                       ;7/32 seconds
LB041:  .byte $5A                       ;A5
LB042:  .byte $B1                       ;7/64 seconds
LB043:  .byte $42                       ;A4
LB044:  .byte $B2                       ;7/32 seconds
LB045:  .byte $56                       ;G5
LB046:  .byte $B1                       ;7/64 seconds
LB047:  .byte $42                       ;A4
LB048:  .byte $B2                       ;7/32 seconds
LB049:  .byte $52                       ;F5
LB04A:  .byte $B1                       ;7/64 seconds
LB04B:  .byte $42                       ;A4
LB04C:  .byte $B2                       ;7/32 seconds
LB04D:  .byte $50                       ;E5
LB04E:  .byte $B1                       ;7/64 seconds
LB04F:  .byte $42                       ;A4
LB050:  .byte $B2                       ;7/32 seconds
LB051:  .byte $5A                       ;A5
LB052:  .byte $B1                       ;7/64 seconds
LB053:  .byte $44                       ;A#4
LB054:  .byte $B2                       ;7/32 seconds
LB055:  .byte $56                       ;G5
LB056:  .byte $B1                       ;7/64 seconds
LB057:  .byte $44                       ;A#4
LB058:  .byte $B2                       ;7/32 seconds
LB059:  .byte $52                       ;F5
LB05A:  .byte $B1                       ;7/64 seconds
LB05B:  .byte $44                       ;A#4
LB05C:  .byte $B2                       ;7/32 seconds
LB05D:  .byte $56                       ;G5
LB05E:  .byte $B1                       ;7/64 seconds
LB05F:  .byte $44                       ;A#4
LB060:  .byte $C4                       ;
LB061:  .byte $5A                       ;A5             +
LB062:  .byte $50                       ;E5             | Repeat 4 times.
LB063:  .byte $46                       ;B4             +
LB064:  .byte $FF                       ;
LB065:  .byte $C3                       ;
LB066:  .byte $58                       ;Ab5            +
LB067:  .byte $50                       ;E5             | Repeat 3 times.
LB068:  .byte $46                       ;B4             +
LB069:  .byte $FF                       ;
LB06A:  .byte $58                       ;Ab5
LB06B:  .byte $50                       ;E5
LB06C:  .byte $B0                       ;1/4 seconds
LB06D:  .byte $46                       ;B4
LB06E:  .byte $02                       ;No sound
LB06F:  .byte $E0                       ;
LB070:  .byte $B6                       ;21/32 seconds  +
LB071:  .byte $1C                       ;D3             | Repeat 32 times.
LB072:  .byte $B2                       ;7/32 seconds   |
LB073:  .byte $02                       ;No sound       +
LB074:  .byte $FF                       ;
LB075:  .byte $00                       ;End intro music.

IntroTriangleData:
LB076:  .byte $D0
LB077:  .byte $B6                       ;21/32 seconds  +
LB078:  .byte $2A                       ;A3             |
LB079:  .byte $B1                       ;7/64 seconds   | Repeat 16 times.
LB07A:  .byte $2A                       ;A3             |
LB07B:  .byte $B1                       ;7/64 seconds   |
LB07C:  .byte $02                       ;No sound       +
LB07D:  .byte $FF                       ;
LB07E:  .byte $B4                       ;7/8 seconds
LB07F:  .byte $4C                       ;D5
LB080:  .byte $60                       ;C6
LB081:  .byte $5E                       ;B5
LB082:  .byte $5C                       ;A#5
LB083:  .byte $54                       ;F#5
LB084:  .byte $60                       ;C6
LB085:  .byte $5C                       ;A#5
LB086:  .byte $56                       ;G5
LB087:  .byte $C2                       ;
LB088:  .byte $34                       ;D4             +
LB089:  .byte $48                       ;C5             |
LB08A:  .byte $46                       ;B4             |
LB08B:  .byte $44                       ;A#4            | Repeat 2 times.
LB08C:  .byte $3C                       ;F#4            |
LB08D:  .byte $48                       ;C5             |
LB08E:  .byte $44                       ;A#4            |
LB08F:  .byte $3E                       ;G4             +
LB090:  .byte $FF                       ;
LB091:  .byte $C2                       ;
LB092:  .byte $B2                       ;7/32 seconds   +
LB093:  .byte $34                       ;D4             |
LB094:  .byte $B1                       ;7/64 seconds   | Repeat 2 times.
LB095:  .byte $42                       ;A4             |
LB096:  .byte $B5                       ;1 13/16 seconds|
LB097:  .byte $4C                       ;D5             +
LB098:  .byte $FF                       ;
LB099:  .byte $C2                       ;
LB09A:  .byte $B2                       ;7/32 seconds   +
LB09B:  .byte $2C                       ;A#3            |
LB09C:  .byte $B1                       ;7/64 seconds   | Repeat 2 times.
LB09D:  .byte $3A                       ;F4             |
LB09E:  .byte $B5                       ;1 13/16 seconds|
LB09F:  .byte $48                       ;C5             +
LB0A0:  .byte $FF                       ;
LB0A1:  .byte $C2                       ;
LB0A2:  .byte $B2                       ;7/32 seconds   +
LB0A3:  .byte $1E                       ;D#3            |
LB0A4:  .byte $B1                       ;7/64 seconds   | Repeat 2 times.
LB0A5:  .byte $2C                       ;A#3            |
LB0A6:  .byte $B5                       ;1 13/16 seconds|
LB0A7:  .byte $36                       ;D#4            +
LB0A8:  .byte $FF                       ;
LB0A9:  .byte $C4                       ;
LB0AA:  .byte $B2                       ;7/32 seconds   +
LB0AB:  .byte $20                       ;E3             |
LB0AC:  .byte $B1                       ;7/64 seconds   | Repeat 4 times.
LB0AD:  .byte $2E                       ;B3             |
LB0AE:  .byte $B5                       ;1 13/16 seconds|
LB0AF:  .byte $38                       ;E4             +
LB0B0:  .byte $FF                       ;
LB0B1:  .byte $E0                       ;
LB0B2:  .byte $B6                       ;21/32 seconds  +
LB0B3:  .byte $2A                       ;A3             |
LB0B4:  .byte $B1                       ;7/64 seconds   | Repeat 32 times.
LB0B5:  .byte $2A                       ;A3             |
LB0B6:  .byte $B1                       ;7/64 seconds   |
LB0B7:  .byte $02                       ;No sound       +
LB0B8:  .byte $FF                       ;

IntroSQ1Data:
LB0B9:  .byte $D0                       ;
LB0BA:  .byte $B6                       ;21/32 seconds  +
LB0BB:  .byte $06                       ;D2             | Repeat 16 times.
LB0BC:  .byte $B2                       ;7/32 seconds   |
LB0BD:  .byte $02                       ;No sound       +
LB0BE:  .byte $FF                       ;
LB0BF:  .byte $C8                       ;
LB0C0:  .byte $B4                       ;7/8 seconds    + Repeat 8 times.
LB0C1:  .byte $02                       ;No sound       +
LB0C2:  .byte $FF                       ;
LB0C3:  .byte $B2                       ;7/32 seconds
LB0C4:  .byte $24                       ;F#3
LB0C5:  .byte $26                       ;G3
LB0C6:  .byte $2A                       ;A3
LB0C7:  .byte $2E                       ;B3
LB0C8:  .byte $34                       ;D4
LB0C9:  .byte $38                       ;E4
LB0CA:  .byte $3C                       ;F#4
LB0CB:  .byte $3E                       ;G4
LB0CC:  .byte $B6                       ;21/32 seconds
LB0CD:  .byte $42                       ;A4
LB0CE:  .byte $B1                       ;7/64 seconds
LB0CF:  .byte $3E                       ;G4
LB0D0:  .byte $3C                       ;F#4
LB0D1:  .byte $B6                       ;21/32 seconds
LB0D2:  .byte $3E                       ;G4
LB0D3:  .byte $B1                       ;7/64 seconds
LB0D4:  .byte $3C                       ;F#4
LB0D5:  .byte $38                       ;E4
LB0D6:  .byte $B6                       ;21/32 seconds
LB0D7:  .byte $34                       ;D4
LB0D8:  .byte $B2                       ;7/32 seconds
LB0D9:  .byte $42                       ;A4
LB0DA:  .byte $B4                       ;7/8 seconds
LB0DB:  .byte $4C                       ;D5
LB0DC:  .byte $B3                       ;7/16 seconds
LB0DD:  .byte $44                       ;A#4
LB0DE:  .byte $42                       ;A4
LB0DF:  .byte $3E                       ;G4
LB0E0:  .byte $3C                       ;F#4
LB0E1:  .byte $B6                       ;21/32 seconds
LB0E2:  .byte $38                       ;E4
LB0E3:  .byte $B2                       ;7/32 seconds
LB0E4:  .byte $3C                       ;F#4
LB0E5:  .byte $B6                       ;21/32 seconds
LB0E6:  .byte $42                       ;A4
LB0E7:  .byte $B2                       ;7/32 seconds
LB0E8:  .byte $4C                       ;D5
LB0E9:  .byte $B6                       ;21/32 seconds
LB0EA:  .byte $38                       ;E4
LB0EB:  .byte $B2                       ;7/32 seconds
LB0EC:  .byte $3C                       ;F#4
LB0ED:  .byte $B4                       ;7/8 seconds
LB0EE:  .byte $34                       ;D4
LB0EF:  .byte $B3                       ;7/16 seconds
LB0F0:  .byte $2A                       ;A3
LB0F1:  .byte $2E                       ;B3
LB0F2:  .byte $34                       ;D4
LB0F3:  .byte $38                       ;E4
LB0F4:  .byte $B6                       ;21/32 seconds
LB0F5:  .byte $34                       ;D4
LB0F6:  .byte $B2                       ;7/32 seconds
LB0F7:  .byte $2C                       ;A#3
LB0F8:  .byte $B4                       ;7/8 seconds
LB0F9:  .byte $26                       ;G3
LB0FA:  .byte $B5                       ;1 13/16 seconds
LB0FB:  .byte $38                       ;E4
LB0FC:  .byte $3C                       ;F#4
LB0FD:  .byte $42                       ;A4
LB0FE:  .byte $4C                       ;D5
LB0FF:  .byte $34                       ;D4
LB100:  .byte $3A                       ;F4
LB101:  .byte $48                       ;C5
LB102:  .byte $42                       ;A4
LB103:  .byte $36                       ;D#4
LB104:  .byte $3E                       ;G4
LB105:  .byte $4C                       ;D5
LB106:  .byte $44                       ;A#4
LB107:  .byte $42                       ;A4
LB108:  .byte $38                       ;E4
LB109:  .byte $2E                       ;B3
LB10A:  .byte $38                       ;E4
LB10B:  .byte $40                       ;Ab4
LB10C:  .byte $38                       ;E4
LB10D:  .byte $2E                       ;B3
LB10E:  .byte $38                       ;E4
LB10F:  .byte $E0                       ;
LB110:  .byte $B6                       ;21/32 seconds  +
LB111:  .byte $06                       ;D2             | Repeat 32 times.
LB112:  .byte $B2                       ;7/32 seconds   |
LB113:  .byte $02                       ;No sound       +
LB114:  .byte $FF                       ;

IntroNoiseIndexData:
LB115:  .byte $D0                       ;
LB116:  .byte $B4                       ;7/8 Seconds    + Repeat 16 times.
LB117:  .byte $04                       ;Drumbeat 01    +
LB118:  .byte $FF                       ;
LB119:  .byte $CC                       ;
LB11A:  .byte $B2                       ;7/32 Seconds   +
LB11B:  .byte $04                       ;Drumbeat 01    |
LB11C:  .byte $04                       ;Drumbeat 01    |
LB11D:  .byte $B5                       ;1 13/16 Seconds|
LB11E:  .byte $07                       ;Drumbeat 02    |
LB11F:  .byte $B0                       ;1/4 Seconds    |
LB120:  .byte $04                       ;Drumbeat 01    | Repeat 12 times.
LB121:  .byte $04                       ;Drumbeat 01    |
LB122:  .byte $B6                       ;21/32 Seconds  |
LB123:  .byte $04                       ;Drumbeat 01    |
LB124:  .byte $B1                       ;7/64 Seconds   |
LB125:  .byte $04                       ;Drumbeat 01    |
LB126:  .byte $04                       ;Drumbeat 01    +
LB127:  .byte $FF                       ;
LB128:  .byte $CA                       ;
LB129:  .byte $B1                       ;7/64 Seconds   +
LB12A:  .byte $04                       ;Drumbeat 01    |
LB12B:  .byte $04                       ;Drumbeat 01    |
LB12C:  .byte $04                       ;Drumbeat 01    | Repeat 10 times.
LB12D:  .byte $07                       ;Drumbeat 02    |
LB12E:  .byte $04                       ;Drumbeat 01    |
LB12F:  .byte $04                       ;Drumbeat 01    +
LB130:  .byte $FF                       ;
LB131:  .byte $E0                       ;
LB132:  .byte $B4                       ;7/8 Seconds    + Repeat 32 times.
LB133:  .byte $04                       ;Drumbeat 01    +
LB134:  .byte $FF                       ;