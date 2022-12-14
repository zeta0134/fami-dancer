        .include "action53.inc"
        .include "chr.inc"
        .include "compression.inc"
        .include "kernel.inc"
        .include "nes.inc"
        .include "ppu.inc"
        .include "word_util.inc"
        .include "zeropage.inc"

.segment "RAM"
CurrentChrBank: .res 1

.segment "PRG1_8000"
        ; player
        .include "../build/animated_tiles/player.chr"
        ; weapons
        .include "../build/static_tiles/dagger.chr"
        .include "../build/static_tiles/broadsword.chr"
        .include "../build/static_tiles/longsword.chr"
        .include "../build/static_tiles/spear.chr"
        .include "../build/static_tiles/flail.chr"

        .include "../build/animated_tiles/horizontal_slash.chr"
        .include "../build/animated_tiles/vertical_slash.chr"
        .include "../build/animated_tiles/horizontal_slash_sfx.chr"
        .include "../build/animated_tiles/vertical_slash_sfx.chr"
        ; sprite effects
        .include "../build/animated_tiles/death_skull.chr"
        .include "../build/animated_tiles/damage_player.chr"

        ; enemies
        .include "../build/animated_tiles/slime_idle.chr"
        .include "../build/animated_tiles/smoke_puff.chr"
        .include "../build/animated_tiles/spider.chr"
        .include "../build/animated_tiles/spider_anticipate.chr"
        .include "../build/animated_tiles/zombie_idle.chr"
        .include "../build/animated_tiles/zombie_anticipate.chr"
        .include "../build/animated_tiles/birb_idle_left.chr"
        .include "../build/animated_tiles/birb_idle_right.chr"
        .include "../build/animated_tiles/birb_flying_left.chr"
        .include "../build/animated_tiles/birb_flying_right.chr"
        .include "../build/static_tiles/mole_hole.chr"
        .include "../build/animated_tiles/mole_idle.chr"
        .include "../build/animated_tiles/mole_throwing.chr"
        .include "../build/animated_tiles/wrench_projectile.chr"

        ; static level geometry
        .include "../build/static_tiles/floor.chr"
        .include "../build/static_tiles/disco_floor.chr"
        .include "../build/static_tiles/wall_face.chr"
        .include "../build/static_tiles/wall_top.chr"
        .include "../build/static_tiles/pit_edge.chr"
        .include "../build/static_tiles/pit_center.chr"
        .include "../build/static_tiles/exit_block.chr"
        .include "../build/static_tiles/exit_stairs.chr"

        ; treasures
        .include "../build/static_tiles/big_key.chr"
        .include "../build/static_tiles/gold_sack.chr"
        .include "../build/static_tiles/treasure_chest.chr"
        .include "../build/static_tiles/weapon_shadow.chr"
        .include "../build/static_tiles/small_heart.chr"

        ; hud
        .include "../build/static_tiles/empty_heart.chr"
        .include "../build/static_tiles/half_heart.chr"
        .include "../build/static_tiles/full_heart.chr" ; also the treasure icon
        .include "../build/static_tiles/map_icons.chr"

hud_font:
        .incbin "../art/raw_chr/font_chicago_reduced.chr"

title_chr:
        .incbin "../art/raw_chr/title.chr"

title_nametable:
        .incbin "../art/raw_nametables/title_screen.nam"

ANIMATED_TILE_TABLE_LENGTH = 20
animated_tile_table:
        .word $0000, smoke_puff
        .word $0040, slime_idle
        .word $0080, spider
        .word $00C0, spider_anticipate
        .word $0100, zombie_idle
        .word $0140, zombie_anticipate
        .word $0180, birb_idle_left
        .word $01C0, birb_idle_right
        .word $0200, birb_flying_left
        .word $0240, birb_flying_right
        .word $02C0, mole_throwing
        .word $0300, mole_idle
        .word $0340, wrench_projectile

        .word $1000, player
        .word $1040, death_skull

        .word $11C0, horizontal_slash
        .word $1200, vertical_slash
        .word $1240, horizontal_slash_sfx
        .word $1280, vertical_slash_sfx
        .word $12C0, damage_player


STATIC_TILE_TABLE_LENGTH = 23
static_tile_table:
        ; level geometry, ascending
        .word $0800, floor
        .word $0840, disco_floor
        .word $0880, wall_top
        .word $08C0, wall_face
        .word $0900, pit_edge
        .word $0940, pit_center ; pit non-edge
        ; treasures
        .word $0980, treasure_chest
        .word $09C0, big_key
        .word $0A00, gold_sack
        .word $0A40, weapon_shadow
        .word $0B00, small_heart
        ; interactables
        .word $0A80, exit_block
        .word $0AC0, exit_stairs
        ; hud, descending
        .word $0CC0, full_heart
        .word $0C80, half_heart
        .word $0C40, empty_heart
        .word $0C00, map_icons
        ; weapon sprites
        .word $1080, dagger
        .word $10C0, broadsword
        .word $1100, longsword
        .word $1140, spear
        .word $1180, flail
        ; static enemy poses
        .word $0280, mole_hole


; note: set PPUADDR and PPUCTRL appropriately before calling
.proc memcpy_ppudata
SourceAddr := R0
Length := R2
        ldy #0
loop:
        lda (SourceAddr), y
        sta PPUDATA
        inc16 SourceAddr
        dec16 Length
        lda Length
        ora Length+1
        bne loop
        rts
.endproc

.proc decompress_animated_tiles_to_chr_ram
MemcpySourceAddr := R0
DecompressionSourceAddr := R0

MemcpyLength := R2
DecompressionTargetAddr := R2

SpriteTableAddr := R4
SpriteTableLength := R6
SpriteTableIndex := R7

ChrBank := R8
        lda #ANIMATED_TILE_TABLE_LENGTH
        sta SpriteTableLength
        lda #0
        sta SpriteTableIndex
tile_loop:
        ldx SpriteTableIndex
        lda animated_tile_table + 2, x
        sta DecompressionSourceAddr
        lda animated_tile_table + 3, x
        sta DecompressionSourceAddr + 1

        st16 DecompressionTargetAddr, $0200 ; clobber shadow OAM since these are only 256 bytes each
        jsr decompress ; clobbers R0 - R3, R14-R15

        lda #0
        sta ChrBank
bank_loop:
        a53_set_chr ChrBank
        lda #$02
        sta MemcpySourceAddr+1
        lda ChrBank
        .repeat 6
        asl
        .endrepeat
        sta MemcpySourceAddr
        st16 MemcpyLength, 64
        ldx SpriteTableIndex
        lda animated_tile_table + 1, x
        sta PPUADDR
        lda animated_tile_table + 0, x
        sta PPUADDR
        jsr memcpy_ppudata
        inc ChrBank
        lda ChrBank
        cmp #4
        bne bank_loop

        dec SpriteTableLength
        beq done
        lda SpriteTableIndex
        clc
        adc #4
        sta SpriteTableIndex
        jmp tile_loop
done:
        rts
.endproc

.proc decompress_static_tiles_to_chr_ram
MemcpySourceAddr := R0
DecompressionSourceAddr := R0

MemcpyLength := R2
DecompressionTargetAddr := R2

SpriteTableAddr := R4
SpriteTableLength := R6
SpriteTableIndex := R7

ChrBank := R8
        lda #STATIC_TILE_TABLE_LENGTH
        sta SpriteTableLength
        lda #0
        sta SpriteTableIndex
tile_loop:
        ldx SpriteTableIndex
        lda static_tile_table + 2, x
        sta DecompressionSourceAddr
        lda static_tile_table + 3, x
        sta DecompressionSourceAddr + 1

        st16 DecompressionTargetAddr, $0200 ; clobber shadow OAM since these are only 256 bytes each
        jsr decompress ; clobbers R0 - R3, R14-R15

        lda #0
        sta ChrBank
bank_loop:
        a53_set_chr ChrBank
        ; for static tiles, duplicate the decompressed result four times
        st16 MemcpySourceAddr, $0200
        st16 MemcpyLength, 64
        ldx SpriteTableIndex
        lda static_tile_table + 1, x
        sta PPUADDR
        lda static_tile_table + 0, x
        sta PPUADDR
        jsr memcpy_ppudata
        inc ChrBank
        lda ChrBank
        cmp #4
        bne bank_loop

        dec SpriteTableLength
        beq done
        lda SpriteTableIndex
        clc
        adc #4
        sta SpriteTableIndex
        jmp tile_loop
done:
        rts
.endproc

.proc copy_hud_font_to_chr_ram
SourceAddr := R0
Length := R2
ChrBank := R8
        lda #0
        sta ChrBank
bank_loop:
        a53_set_chr ChrBank
        st16 SourceAddr, hud_font
        st16 Length, $0300
        set_ppuaddr #$0D00
        jsr memcpy_ppudata
        inc ChrBank
        lda ChrBank
        cmp #4
        bne bank_loop
        rts
.endproc

.proc copy_title_patterns_to_chr_ram
SourceAddr := R0
Length := R2
ChrBank := R8
        lda #0
        sta ChrBank
bank_loop:
        a53_set_chr ChrBank
        st16 SourceAddr, title_chr
        st16 Length, $1000
        set_ppuaddr #$0000
        jsr memcpy_ppudata
        inc ChrBank
        lda ChrBank
        cmp #4
        bne bank_loop
        rts
.endproc

.proc FAR_initialize_chr_ram_game
SourceAddr := R0
Length := R2
        lda #(VBLANK_NMI | BG_0000 | OBJ_1000)
        sta PPUCTRL ; set VRAM increment to +1

        ; THING!
        jsr decompress_animated_tiles_to_chr_ram
        jsr decompress_static_tiles_to_chr_ram
        jsr copy_hud_font_to_chr_ram

        rts
.endproc

.proc FAR_initialize_chr_ram_title
        lda #(VBLANK_NMI | BG_0000 | OBJ_1000)
        sta PPUCTRL ; set VRAM increment to +1

        ; First copy in the animated tiles, since we need the player sprite to be present
        jsr decompress_animated_tiles_to_chr_ram
        ; Now we need to copy in the title CHR graphics four times, just like we did with
        ; the HUD
        jsr copy_title_patterns_to_chr_ram

        ; and that's about it
        rts
.endproc

.proc FAR_init_nametables
Length := R0
        lda #(VBLANK_NMI | BG_0000 | OBJ_1000)
        sta PPUCTRL ; set VRAM increment to +1
        st16 Length, $0800
        set_ppuaddr #$2000
loop:
        lda #$80 ; static tile 0
        sta PPUDATA
        dec16 Length
        lda Length
        ora Length+1
        bne loop
        rts
.endproc

.proc write_nametable
DataAddr := R0
Length := R2
        st16 Length, $0400
        
        ldy #0
loop:
        lda (DataAddr), y ; static tile 0
        sta PPUDATA
        dec16 Length
        inc16 DataAddr
        lda Length
        ora Length+1
        bne loop
        rts
.endproc

.proc FAR_copy_title_nametable
DataAddr := R0
        lda #(VBLANK_NMI | BG_0000 | OBJ_1000)
        sta PPUCTRL ; set VRAM increment to +1

        ; HACK alert:
        ; NMI is not getting touched; copy this to both nametables
        ; redundantly and let whichever one is active be displayed.
        ; It's fine.
        set_ppuaddr #$2000
        st16 DataAddr, title_nametable
        jsr write_nametable

        set_ppuaddr #$2400
        st16 DataAddr, title_nametable
        jsr write_nametable

        rts
.endproc

chr_frame_pacing:
        .byte 0, 1, 1, 2, 2, 3, 3, 3

.proc FAR_sync_chr_bank_to_music
        lda DisplayedRowCounter
        and #%00000111
        tax
        lda chr_frame_pacing, x
        sta CurrentChrBank
        rts
.endproc