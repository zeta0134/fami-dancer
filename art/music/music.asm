; Dn-FamiTracker exported music data: music.dnm
;

; Module header
	.word ft_song_list
	.word ft_instrument_list
	.word ft_sample_list
	.word ft_samples
	.word ft_groove_list
	.byte 0 ; flags
	.word 3600 ; NTSC speed
	.word 3000 ; PAL speed
	.word 1 ; N163 channels

; Instrument pointer list
ft_instrument_list:
	.word ft_inst_0
	.word ft_inst_1
	.word ft_inst_2
	.word ft_inst_3

; Instruments
ft_inst_0:
	.byte 9
	.byte $01
	.word ft_seq_n163_5
	.byte $08
	.byte $00
	.word ft_waves_0

ft_inst_1:
	.byte 0
	.byte $01
	.word ft_seq_2a03_0

ft_inst_2:
	.byte 0
	.byte $00

ft_inst_3:
	.byte 9
	.byte $01
	.word ft_seq_n163_10
	.byte $08
	.byte $00
	.word ft_waves_0

; Sequences
ft_seq_2a03_0:
	.byte $10, $FF, $00, $00, $0F, $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $01, $00
ft_seq_n163_5:
	.byte $18, $FF, $0E, $00, $0F, $0F, $0F, $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $03
	.byte $03, $02, $02, $02, $01, $01, $01, $00
ft_seq_n163_10:
	.byte $19, $FF, $0E, $00, $0F, $0F, $0F, $0F, $0E, $0E, $0D, $0D, $0C, $0C, $0B, $0B, $0A, $0A, $02, $02
	.byte $02, $02, $02, $02, $01, $01, $01, $01, $00

; N163 waves
ft_waves_0:
	.byte $10, $32, $54, $76, $98, $BA, $DC, $FE

; DPCM instrument list (pitch, sample index)
ft_sample_list:

; DPCM samples list (location, size, bank)
ft_samples:


; Groove list
ft_groove_list:
	.byte $00
; Grooves (size, terms)

; Song pointer list
ft_song_list:
	.word ft_song_0
	.word ft_song_1
	.word ft_song_2

; Song info
ft_song_0:
	.word ft_s0_frames
	.byte 1	; frame count
	.byte 64	; pattern length
	.byte 6	; speed
	.byte 120	; tempo
	.byte 0	; groove position
	.byte 0	; initial bank

ft_song_1:
	.word ft_s1_frames
	.byte 1	; frame count
	.byte 32	; pattern length
	.byte 3	; speed
	.byte 120	; tempo
	.byte 0	; groove position
	.byte 0	; initial bank

ft_song_2:
	.word ft_s2_frames
	.byte 4	; frame count
	.byte 64	; pattern length
	.byte 3	; speed
	.byte 120	; tempo
	.byte 0	; groove position
	.byte 0	; initial bank


;
; Pattern and frame data for all songs below
;

; Bank 0
ft_s0_frames:
	.word ft_s0f0
ft_s0f0:
	.word ft_s0p0c0, ft_s0p0c0, ft_s0p0c0, ft_s0p0c0, ft_s0p0c0, ft_s0p0c0
; Bank 0
ft_s0p0c0:
	.byte $00, $3F

; Bank 0
ft_s1_frames:
	.word ft_s1f0
ft_s1f0:
	.word ft_s1p0c0, ft_s1p0c1, ft_s1p0c1, ft_s1p0c1, ft_s1p0c1, ft_s1p0c1
; Bank 0
ft_s1p0c0:
	.byte $82, $07, $E1, $9B, $02, $93, $02, $49, $9B, $02, $3D, $9B, $02, $3D, $83, $9B, $02, $3D, $07

; Bank 0
ft_s1p0c1:
	.byte $00, $1F

; Bank 0
ft_s2_frames:
	.word ft_s2f0
	.word ft_s2f1
	.word ft_s2f2
	.word ft_s2f3
ft_s2f0:
	.word ft_s2p0c0, ft_s2p0c1, ft_s2p0c2, ft_s0p0c0, ft_s2p0c5, ft_s2p0c4
ft_s2f1:
	.word ft_s2p1c0, ft_s2p1c1, ft_s2p1c2, ft_s0p0c0, ft_s2p0c5, ft_s2p0c4
ft_s2f2:
	.word ft_s2p0c0, ft_s2p0c1, ft_s2p0c2, ft_s0p0c0, ft_s2p1c5, ft_s2p0c4
ft_s2f3:
	.word ft_s2p1c0, ft_s2p1c1, ft_s2p1c2, ft_s0p0c0, ft_s2p2c5, ft_s2p0c4
; Bank 0
ft_s2p0c0:
	.byte $E1, $93, $01, $91, $82, $FF, $1C, $01, $7F, $01, $82, $00, $FC, $28, $7F, $28, $7F, $83, $FF, $1C
	.byte $01, $82, $00, $1C, $7F, $F8, $28, $7F, $83, $FD, $28, $03, $F8, $28, $00, $7F, $00, $FD, $28, $03
	.byte $FC, $1C, $01, $7F, $01, $82, $00, $FD, $28, $7F, $FA, $28, $7F, $83, $E2, $93, $01, $FF, $21, $01
	.byte $7F, $01, $82, $00, $E1, $FC, $28, $7F, $28, $7F, $83, $FF, $1C, $01, $82, $00, $1C, $7F, $F8, $28
	.byte $7F, $83, $FD, $28, $03, $F8, $28, $00, $7F, $00, $FD, $28, $03, $FC, $1C, $01, $7F, $01, $82, $00
	.byte $FD, $28, $7F, $FA, $28, $83, $7F, $00

; Bank 0
ft_s2p0c1:
	.byte $00, $03, $E1, $FC, $23, $00, $7F, $00, $23, $00, $7F, $04, $F8, $23, $00, $7F, $00, $FD, $23, $03
	.byte $F8, $23, $00, $7F, $00, $FD, $23, $03, $7F, $03, $FD, $23, $00, $7F, $00, $FA, $23, $05, $FC, $24
	.byte $00, $7F, $00, $24, $00, $7F, $04, $F8, $24, $00, $7F, $00, $FD, $24, $03, $F8, $24, $00, $7F, $00
	.byte $FD, $24, $07, $FD, $24, $00, $7F, $00, $FA, $24, $01

; Bank 0
ft_s2p0c2:
	.byte $E2, $91, $84, $1C, $01, $7F, $01, $E0, $FC, $2B, $00, $7F, $00, $2B, $00, $7F, $04, $F8, $2B, $00
	.byte $7F, $00, $FD, $2B, $01, $7F, $01, $F8, $2B, $00, $7F, $00, $FD, $2B, $01, $7F, $05, $82, $00, $FD
	.byte $2B, $7F, $FA, $2B, $7F, $83, $E2, $15, $01, $7F, $01, $E0, $FC, $2D, $00, $7F, $00, $2D, $00, $7F
	.byte $04, $F8, $2D, $00, $7F, $00, $FD, $2D, $01, $7F, $01, $F8, $2D, $00, $7F, $00, $FD, $2D, $01, $7F
	.byte $05, $FD, $2D, $00, $7F, $00, $FA, $2D, $01

; Bank 0
ft_s2p0c4:
	.byte $96, $40, $00, $3F

; Bank 0
ft_s2p0c5:
	.byte $7F, $3F

; Bank 0
ft_s2p1c0:
	.byte $E1, $93, $01, $FF, $1A, $01, $7F, $01, $82, $00, $FC, $28, $7F, $28, $7F, $83, $FF, $1A, $01, $82
	.byte $00, $1A, $7F, $F8, $28, $7F, $83, $FD, $28, $03, $F8, $28, $00, $7F, $00, $FD, $28, $03, $FC, $1A
	.byte $01, $7F, $01, $82, $00, $FD, $28, $7F, $FA, $28, $7F, $83, $93, $01, $FF, $15, $01, $7F, $01, $82
	.byte $00, $FC, $28, $7F, $28, $7F, $83, $E0, $FF, $15, $01, $82, $00, $15, $7F, $E1, $F8, $28, $7F, $83
	.byte $FD, $28, $01, $FF, $17, $01, $F8, $27, $00, $7F, $00, $FD, $27, $03, $FC, $17, $01, $7F, $01, $82
	.byte $00, $FD, $27, $7F, $FA, $27, $83, $7F, $00

; Bank 0
ft_s2p1c1:
	.byte $00, $03, $E1, $FC, $26, $00, $7F, $00, $26, $00, $7F, $04, $F8, $26, $00, $7F, $00, $FD, $26, $03
	.byte $F8, $26, $00, $7F, $00, $FD, $26, $03, $7F, $03, $FD, $26, $00, $7F, $00, $FA, $26, $05, $FC, $24
	.byte $00, $7F, $00, $24, $00, $7F, $04, $F8, $24, $00, $7F, $00, $FD, $24, $03, $F8, $23, $00, $7F, $00
	.byte $FD, $23, $03, $7F, $03, $FD, $23, $00, $7F, $00, $FA, $23, $01

; Bank 0
ft_s2p1c2:
	.byte $E2, $1A, $01, $7F, $01, $E0, $FC, $2D, $00, $7F, $00, $2D, $00, $7F, $04, $F8, $2D, $00, $7F, $00
	.byte $FD, $2D, $01, $7F, $01, $F8, $2D, $00, $7F, $00, $FD, $2D, $01, $7F, $05, $FD, $2D, $00, $7F, $00
	.byte $FA, $2D, $01, $E2, $15, $01, $7F, $01, $E0, $FC, $2D, $00, $7F, $00, $2D, $00, $7F, $04, $F8, $2D
	.byte $00, $7F, $00, $FD, $2D, $01, $E2, $17, $01, $E0, $F8, $2A, $00, $7F, $00, $FD, $2A, $01, $7F, $05
	.byte $FD, $2A, $00, $7F, $00, $FA, $2A, $01

; Bank 0
ft_s2p1c5:
	.byte $E3, $10, $1F, $10, $1F

; Bank 0
ft_s2p2c5:
	.byte $E3, $0E, $1F, $09, $0F, $0B, $0F


; DPCM samples (located at DPCM segment)
