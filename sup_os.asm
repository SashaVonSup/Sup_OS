format binary
org 7C00h

BOOT:
    ; 3arpy34ik
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 7C00h
    sti
    
    ; Initiali3atia ekrana
    mov  ah, 00h
    mov  al, 03h; text  80x25  16/8color
    int  10h
    mov  ah, 05h
    mov  al, 00h; video-stranitsa #0
    int  10h
    
    ; Cursor v 1 positiu
    mov bx, 0
    mov dl, 0
    mov dh, 0
    mov ah, 02h
    int 10h  
	
    mov dh,0      ; head
    mov ch,0      ; track
    mov cl,2      ; 2 sector
    mov ax, 0000h
    mov es, ax    ; adres kuda 3arpyJaem
    mov bx, 8000h
    mov al, 6     ; kol-vo sectorov
    mov ah, 2h
    int 13h
    
    ;.ATR0: db 00001111b; belym po 4ernomu
    ;.STR0: db "Welcome to Sup_OS!"
    times 510-($-07C00h) db 144
    jmp far 0000:8000h
db 055h, 0AAh; Metka 3arpy3o4Horo cektopa

;=====================================================OSNOVNOY KOD=============================================================
org 8000h

MAIN:
    mov  al, 00h
    call CHOOSE_VID_PAGE_AL
    mov  al, 00h;      zalit ves ekran
    mov  bh, [ATRIBUT]; vybrannym atributom
    call PAGE_DOWN_AL_STR_ATR_BH
    call LOAD_FONT
    
    mov  bl, [ATRIBUT]
    mov  di, .TEST1
    call WRITE_STR_DI_ATR_BL
    mov  di, .TEST2
    call WRITE_STR_DI_ATR_BL
    mov  di, .TEST3
    call WRITE_STR_DI_ATR_BL
    mov  di, .TEST4
    call WRITE_STR_DI_ATR_BL
    mov  di, .SIGN_X
    call WRITE_STR_DI_ATR_BL
    mov  di, .SIGN_Y
    call WRITE_STR_DI_ATR_BL
    mov  di, .SIGN_BTN
    call WRITE_STR_DI_ATR_BL

    .REPEAT:
    	call PS2_READ
    	mov  dh, 4
    	mov  dl, 13
    	call SET_CURSOR_DH_DL
    	mov  ax, [MOUSE_I1]
    	call WRITE_DEC_NUM_AX_ATR_BL
	inc  dh
    	call SET_CURSOR_DH_DL
    	mov  ax, [MOUSE_X1]
    	call WRITE_DEC_NUM_AX_ATR_BL
	inc  dh
	call SET_CURSOR_DH_DL
    	mov  ax, [MOUSE_Y1]
    	call WRITE_DEC_NUM_AX_ATR_BL
    	inc  dh
	call SET_CURSOR_DH_DL
    	mov  ax, [BUTTON_1]
    	call WRITE_DEC_NUM_AX_ATR_BL
    	jmp  .REPEAT

    .TEST1:     db 'ÑÉÑåÑuÑäÑé ÑwÑu ÑuÑãÑv ÑèÑÑÑyÑá Ñ}ÑëÑsÑ{ÑyÑá ÑÜÑÇÑpÑ~ÑàÑÖÑxÑÉÑ{ÑyÑá ÑqÑÖÑ|ÑÄÑ{ ÑtÑp ÑrÑçÑÅÑuÑz ÑâÑpÑê', 13, 0
    .TEST2:     db 'ÑRÑ[ÑEÑYÑ] ÑGÑE ÑEÑZÑF Ñ^ÑSÑIÑV ÑMÑ`ÑCÑKÑIÑV ÑUÑQÑ@ÑNÑWÑTÑHÑRÑKÑIÑV ÑAÑTÑLÑOÑK ÑDÑ@ ÑBÑ\ÑPÑEÑJ ÑXÑ@Ñ_', 13, 0
    .TEST3:     db 'the quick brown fox jumps over the lazy dog', 13, 0
    .TEST4:     db 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG', 13, 0
    .SIGN_I:    db 'Mouse Info:     ', 13, 0
    .SIGN_X:    db 'Mouse X:        ', 13, 0
    .SIGN_Y:    db 'Mouse Y:        ', 13, 0
    .SIGN_BTN:  db 'Keyboard btn:   ', 13, 0

BUFFER: db 0
        times 0xff db ' '
        db 0

;=================================================VSPOMOGATELNYE FUNCTII=======================================================

LOAD_FONT:  ; 3arpy3ka wpiBtov
    pushad
    mov  bp, .Font
    mov  dx, 128
    mov  cx, 48
    mov  bx, 1000h
    mov  ax, 1100h
    int  10h
    mov  bp, .Font2
    mov  dx, 224
    mov  cx, 18
    mov  bx, 1000h
    mov  ax, 1100h
    int  10h
    
    .Font:
        ;-------------;Ñ@
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00011100b ;2
        DB 00010100b ;3
        DB 00010100b ;4
        DB 00010110b ;5
        DB 00100010b ;6
        DB 00100010b ;7
        DB 00100010b ;8
        DB 01111111b ;9
        DB 01000001b ;10
        DB 01000001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑA
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01111100b ;2
        DB 01000000b ;3
        DB 01000000b ;4
        DB 01000000b ;5
        DB 01111100b ;6
        DB 01000110b ;7
        DB 01000010b ;8
        DB 01000010b ;9
        DB 01000110b ;10
        DB 01111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑB
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01111100b ;2
        DB 01000010b ;3
        DB 01000010b ;4
        DB 01000110b ;5
        DB 01111100b ;6
        DB 01000110b ;7
        DB 01000010b ;8
        DB 01000010b ;9
        DB 01000110b ;10
        DB 01111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑC
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00111111b ;2
        DB 00100000b ;3
        DB 00100000b ;4
        DB 00100000b ;5
        DB 00100000b ;6
        DB 00100000b ;7
        DB 00100000b ;8
        DB 00100000b ;9
        DB 00100000b ;10
        DB 00100000b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑD
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00111111b ;2
        DB 00100001b ;3
        DB 00100001b ;4
        DB 00100001b ;5
        DB 00100001b ;6
        DB 00100001b ;7
        DB 00100001b ;8
        DB 00100001b ;9
        DB 01000001b ;10
        DB 11111111b ;11
        DB 10000000b ;12
        DB 10000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑE
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00111111b ;2
        DB 00100000b ;3
        DB 00100000b ;4
        DB 00100000b ;5
        DB 00111111b ;6
        DB 00100000b ;7
        DB 00100000b ;8
        DB 00100000b ;9
        DB 00100000b ;10
        DB 00111111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑG
        DB 00000000b ;0
        DB 00000000b ;1
        DB 10001000b ;2
        DB 01001001b ;3
        DB 00101010b ;4
        DB 00101010b ;5
        DB 00011100b ;6
        DB 00011100b ;7
        DB 00101010b ;8
        DB 01001001b ;9
        DB 01001001b ;10
        DB 10001000b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑH
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00111100b ;2
        DB 01000010b ;3
        DB 00000010b ;4
        DB 00000010b ;5
        DB 00111100b ;6
        DB 00000110b ;7
        DB 00000010b ;8
        DB 00000010b ;9
        DB 01000110b ;10
        DB 00111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑI
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01000001b ;2
        DB 01000011b ;3
        DB 01000111b ;4
        DB 01000101b ;5
        DB 01001101b ;6
        DB 01011001b ;7
        DB 01010001b ;8
        DB 01110001b ;9
        DB 01100001b ;10
        DB 01000001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑJ
        DB 00111000b ;0
        DB 00000000b ;1
        DB 01000001b ;2
        DB 01000011b ;3
        DB 01000111b ;4
        DB 01000101b ;5
        DB 01001101b ;6
        DB 01011001b ;7
        DB 01010001b ;8
        DB 01110001b ;9
        DB 01100001b ;10
        DB 01000001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑK
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01000010b ;2
        DB 01000100b ;3
        DB 01001100b ;4
        DB 01011000b ;5
        DB 01110000b ;6
        DB 01110000b ;7
        DB 01011000b ;8
        DB 01001100b ;9
        DB 01000100b ;10
        DB 01000010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑL
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00111110b ;2
        DB 00100010b ;3
        DB 00100010b ;4
        DB 00100010b ;5
        DB 00100010b ;6
        DB 00100010b ;7
        DB 01100010b ;8
        DB 01000010b ;9
        DB 01000010b ;10
        DB 11000010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑM
        DB 00000000b ;0
        DB 00000000b ;1
        DB 11000001b ;2
        DB 11100011b ;3
        DB 11100011b ;4
        DB 11110101b ;5
        DB 11010101b ;6
        DB 11010101b ;7
        DB 11001001b ;8
        DB 11000001b ;9
        DB 11000001b ;10
        DB 11000001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------ÑN
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01000001b ;2
        DB 01000001b ;3
        DB 01000001b ;4
        DB 01000001b ;5
        DB 01111111b ;6
        DB 01000001b ;7
        DB 01000001b ;8
        DB 01000001b ;9
        DB 01000001b ;10
        DB 01000001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑO
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00111100b ;2
        DB 01000010b ;3
        DB 11000001b ;4
        DB 10000001b ;5
        DB 10000001b ;6
        DB 10000001b ;7
        DB 10000001b ;8
        DB 10000011b ;9
        DB 01000010b ;10
        DB 00111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑP
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01111111b ;2
        DB 01000001b ;3
        DB 01000001b ;4
        DB 01000001b ;5
        DB 01000001b ;6
        DB 01000001b ;7
        DB 01000001b ;8
        DB 01000001b ;9
        DB 01000001b ;10
        DB 01000001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑQ
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01111100b ;2
        DB 01000110b ;3
        DB 01000010b ;4
        DB 01000010b ;5
        DB 01000110b ;6
        DB 01111000b ;7
        DB 01000000b ;8
        DB 01000000b ;9
        DB 01000000b ;10
        DB 01000000b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑR
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00011110b ;2
        DB 00110001b ;3
        DB 00100000b ;4
        DB 01000000b ;5
        DB 01000000b ;6
        DB 01000000b ;7
        DB 01000000b ;8
        DB 01100000b ;9
        DB 00100001b ;10
        DB 00011110b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑS
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01111111b ;2
        DB 00001000b ;3
        DB 00001000b ;4
        DB 00001000b ;5
        DB 00001000b ;6
        DB 00001000b ;7
        DB 00001000b ;8
        DB 00001000b ;9
        DB 00001000b ;10
        DB 00001000b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑT
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01000001b ;2
        DB 01100011b ;3
        DB 00100010b ;4
        DB 00110110b ;5
        DB 00010100b ;6
        DB 00011100b ;7
        DB 00001000b ;8
        DB 00001000b ;9
        DB 00011000b ;10
        DB 01110000b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑU
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00001000b ;2
        DB 00011110b ;3
        DB 00101010b ;4
        DB 01001001b ;5
        DB 01001001b ;6
        DB 01001001b ;7
        DB 01001001b ;8
        DB 01101010b ;9
        DB 00111100b ;10
        DB 00001000b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑV
        DB 00000000b ;0
        DB 00000000b ;1
        DB 11000011b ;2
        DB 01100110b ;3
        DB 00110100b ;4
        DB 00011100b ;5
        DB 00011000b ;6
        DB 00011100b ;7
        DB 00110100b ;8
        DB 00100110b ;9
        DB 01100011b ;10
        DB 11000001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑW
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01000001b ;2
        DB 01000001b ;3
        DB 01000001b ;4
        DB 01000001b ;5
        DB 01000001b ;6
        DB 01000001b ;7
        DB 01000001b ;8
        DB 01000001b ;9
        DB 01000001b ;10
        DB 01111111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑX
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01000001b ;2
        DB 01000001b ;3
        DB 01000001b ;4
        DB 01000001b ;5
        DB 01100001b ;6
        DB 00111111b ;7
        DB 00000001b ;8
        DB 00000001b ;9
        DB 00000001b ;10
        DB 00000001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑY
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01001001b ;2
        DB 01001001b ;3
        DB 01001001b ;4
        DB 01001001b ;5
        DB 01001001b ;6
        DB 01001001b ;7
        DB 01001001b ;8
        DB 01001001b ;9
        DB 01001001b ;10
        DB 01111111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑZ
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01001001b ;2
        DB 01001001b ;3
        DB 01001001b ;4
        DB 01001001b ;5
        DB 01001001b ;6
        DB 01001001b ;7
        DB 01001001b ;8
        DB 01001001b ;9
        DB 01001001b ;10
        DB 01111111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñ[
        DB 00000000b ;0
        DB 00000000b ;1
        DB 11100000b ;2
        DB 00100000b ;3
        DB 00100000b ;4
        DB 00100000b ;5
        DB 00111110b ;6
        DB 00100011b ;7
        DB 00100001b ;8
        DB 00100001b ;9
        DB 00100011b ;10
        DB 00111110b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñ\
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01000001b ;2
        DB 01000001b ;3
        DB 01000001b ;4
        DB 01000001b ;5
        DB 01111001b ;6
        DB 01000101b ;7
        DB 01000101b ;8
        DB 01000101b ;9
        DB 01001101b ;10
        DB 01111001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñ]
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01000000b ;2
        DB 01000000b ;3
        DB 01000000b ;4
        DB 01000000b ;5
        DB 01111100b ;6
        DB 01000110b ;7
        DB 01000010b ;8
        DB 01000010b ;9
        DB 01000110b ;10
        DB 01111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñ^
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00111100b ;2
        DB 01000010b ;3
        DB 00000001b ;4
        DB 00000001b ;5
        DB 00111111b ;6
        DB 00000001b ;7
        DB 00000001b ;8
        DB 00000011b ;9
        DB 01000010b ;10
        DB 00111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñ_
        DB 00000000b ;0
        DB 00000000b ;1
        DB 01001111b ;2
        DB 01011001b ;3
        DB 01010000b ;4
        DB 01010000b ;5
        DB 01110000b ;6
        DB 01010000b ;7
        DB 01010000b ;8
        DB 01010000b ;9
        DB 01001001b ;10
        DB 01001111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñ`
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00011110b ;2
        DB 00100010b ;3
        DB 00100010b ;4
        DB 00100010b ;5
        DB 00110010b ;6
        DB 00011110b ;7
        DB 00110010b ;8
        DB 00100010b ;9
        DB 01100010b ;10
        DB 01100010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñp
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 00011100b ;5
        DB 00100010b ;6
        DB 00000010b ;7
        DB 00111110b ;8
        DB 01000010b ;9
        DB 01000110b ;10
        DB 00111010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñq
        DB 00000000b ;0
        DB 00011110b ;1
        DB 00100000b ;2
        DB 00100000b ;3
        DB 01011110b ;4
        DB 01100010b ;5
        DB 01000001b ;6
        DB 01000001b ;7
        DB 01000001b ;8
        DB 01000001b ;9
        DB 00100010b ;10
        DB 00011100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñr
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01111100b ;5
        DB 01000010b ;6
        DB 01000010b ;7
        DB 01111100b ;8
        DB 01000010b ;9
        DB 01000010b ;10
        DB 01111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñs
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 00111111b ;5
        DB 00100000b ;6
        DB 00100000b ;7
        DB 00100000b ;8
        DB 00100000b ;9
        DB 00100000b ;10
        DB 00100000b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñt
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 00111110b ;5
        DB 00100010b ;6
        DB 00100010b ;7
        DB 00100010b ;8
        DB 01100010b ;9
        DB 01000010b ;10
        DB 11111111b ;11
        DB 10000001b ;12
        DB 10000001b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñu
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 00011110b ;5
        DB 00100011b ;6
        DB 01000001b ;7
        DB 01111111b ;8
        DB 01000000b ;9
        DB 01100000b ;10
        DB 00011111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñw
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 10001000b ;5
        DB 01001001b ;6
        DB 00101010b ;7
        DB 00011100b ;8
        DB 00101010b ;9
        DB 01101011b ;10
        DB 11001001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñx
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01111100b ;5
        DB 00000010b ;6
        DB 00000010b ;7
        DB 00111100b ;8
        DB 00000010b ;9
        DB 00000010b ;10
        DB 01111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñy
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01000010b ;5
        DB 01000110b ;6
        DB 01001110b ;7
        DB 01011010b ;8
        DB 01110010b ;9
        DB 01100010b ;10
        DB 01000010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñz
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00100100b ;2
        DB 00111000b ;3
        DB 00000000b ;4
        DB 01000010b ;5
        DB 01000110b ;6
        DB 01001110b ;7
        DB 01011010b ;8
        DB 01110010b ;9
        DB 01100010b ;10
        DB 01000010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñ{
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01000010b ;5
        DB 01001100b ;6
        DB 01010000b ;7
        DB 01100000b ;8
        DB 01011000b ;9
        DB 01001100b ;10
        DB 01000110b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñ|
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 00111110b ;5
        DB 00100010b ;6
        DB 00100010b ;7
        DB 00100010b ;8
        DB 00100010b ;9
        DB 01000010b ;10
        DB 11000010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñ}
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01100011b ;5
        DB 01010101b ;6
        DB 01010101b ;7
        DB 01010101b ;8
        DB 01001001b ;9
        DB 01000001b ;10
        DB 01000001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñ~
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01000010b ;5
        DB 01000010b ;6
        DB 01000010b ;7
        DB 01111110b ;8
        DB 01000010b ;9
        DB 01000010b ;10
        DB 01000010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑÄ
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 00011110b ;5
        DB 00100011b ;6
        DB 01000001b ;7
        DB 01000001b ;8
        DB 01000001b ;9
        DB 01100010b ;10
        DB 00111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑÅ
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01111110b ;5
        DB 01000010b ;6
        DB 01000010b ;7
        DB 01000010b ;8
        DB 01000010b ;9
        DB 01000010b ;10
        DB 01000010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
    .Font2:  ;-------------;ÑÇ
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01011110b ;5
        DB 01100011b ;6
        DB 01000001b ;7
        DB 01000001b ;8
        DB 01000001b ;9
        DB 01000010b ;10
        DB 01111100b ;11
        DB 01000000b ;12
        DB 01000000b ;13
        DB 01000000b ;14
        DB 00000000b ;15
        ;-------------;ÑÉ
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 00011110b ;5
        DB 00100000b ;6
        DB 01000000b ;7
        DB 01000000b ;8
        DB 01000000b ;9
        DB 01100000b ;10
        DB 00011110b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑÑ
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01111111b ;5
        DB 00001000b ;6
        DB 00001000b ;7
        DB 00001000b ;8
        DB 00001000b ;9
        DB 00001000b ;10
        DB 00001000b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;ÑÖ
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01000001b ;5
        DB 01100011b ;6
        DB 00100010b ;7
        DB 00100110b ;8
        DB 00010100b ;9
        DB 00010100b ;10
        DB 00011000b ;11
        DB 00011000b ;12
        DB 00010000b ;13
        DB 11100000b ;14
        DB 00000000b ;15
        ;-------------;ÑÜ
        DB 00000000b ;0
        DB 00001000b ;1
        DB 00001000b ;2
        DB 00001000b ;3
        DB 00011110b ;4
        DB 00101011b ;5
        DB 01001001b ;6
        DB 01001001b ;7
        DB 01001001b ;8
        DB 01001001b ;9
        DB 01101010b ;10
        DB 00111100b ;11
        DB 00001000b ;12
        DB 00001000b ;13
        DB 00001000b ;14
        DB 00000000b ;15
        ;-------------;Ñá
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01100011b ;5
        DB 00110110b ;6
        DB 00011100b ;7
        DB 00001100b ;8
        DB 00010110b ;9
        DB 00110011b ;10
        DB 01100001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñà
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01000010b ;5
        DB 01000010b ;6
        DB 01000010b ;7
        DB 01000010b ;8
        DB 01000010b ;9
        DB 01000010b ;10
        DB 01111111b ;11
        DB 00000001b ;12
        DB 00000001b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñâ
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01000010b ;5
        DB 01000010b ;6
        DB 01000010b ;7
        DB 00111110b ;8
        DB 00000010b ;9
        DB 00000010b ;10
        DB 00000010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñä
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01001001b ;5
        DB 01001001b ;6
        DB 01001001b ;7
        DB 01001001b ;8
        DB 01001001b ;9
        DB 01001001b ;10
        DB 01111111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñã
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01001001b ;5
        DB 01001001b ;6
        DB 01001001b ;7
        DB 01001001b ;8
        DB 01001001b ;9
        DB 01001001b ;10
        DB 01111111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñå
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 11100000b ;5
        DB 00100000b ;6
        DB 00100000b ;7
        DB 00111100b ;8
        DB 00100010b ;9
        DB 00100010b ;10
        DB 00111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñç
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01000001b ;5
        DB 01000001b ;6
        DB 01000001b ;7
        DB 01111001b ;8
        DB 01000101b ;9
        DB 01000101b ;10
        DB 01111001b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñé
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01000000b ;5
        DB 01000000b ;6
        DB 01000000b ;7
        DB 01111100b ;8
        DB 01000010b ;9
        DB 01000010b ;10
        DB 01111100b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñè
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01111100b ;5
        DB 00000110b ;6
        DB 00000010b ;7
        DB 01111110b ;8
        DB 00000010b ;9
        DB 00000110b ;10
        DB 01111000b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñê
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 01001111b ;5
        DB 01011001b ;6
        DB 01010000b ;7
        DB 01110000b ;8
        DB 01010000b ;9
        DB 01011001b ;10
        DB 01001111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñë
        DB 00000000b ;0
        DB 00000000b ;1
        DB 00000000b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 00011110b ;5
        DB 00100010b ;6
        DB 00100010b ;7
        DB 00011110b ;8
        DB 00110010b ;9
        DB 00100010b ;10
        DB 01100010b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
    .Font3:  ;-------------;ÑF
        DB 00100100b ;0
        DB 00000000b ;1
        DB 00111111b ;2
        DB 00100000b ;3
        DB 00100000b ;4
        DB 00100000b ;5
        DB 00111111b ;6
        DB 00100000b ;7
        DB 00100000b ;8
        DB 00100000b ;9
        DB 00100000b ;10
        DB 00111111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
        ;-------------;Ñv
        DB 00000000b ;0
        DB 00110110b ;1
        DB 00110110b ;2
        DB 00000000b ;3
        DB 00000000b ;4
        DB 00011110b ;5
        DB 00100011b ;6
        DB 01000001b ;7
        DB 01111111b ;8
        DB 01000000b ;9
        DB 01100000b ;10
        DB 00011111b ;11
        DB 00000000b ;12
        DB 00000000b ;13
        DB 00000000b ;14
        DB 00000000b ;15
    popad
    ret

;INIT_SCREEN:    ; Initializatia ekrana
;    push ax
;    mov  ah, 00h
;    mov  al, 03h; text  80x25  16/8color
;    int  10h
;    mov  ah, 05h
;    mov  al, 00h; video-stranitsa #0
;    int  10h
;    pop  ax
;    ret

CHOOSE_VID_PAGE_AL:     ; Vybor videostranicy AL
    push ax
    mov  ah, 05h
    int  10h
    pop ax
    ret

SET_CURSOR_DH_DL:   ; Ustanovit cursor v stroku DH, kolonku DL
    push bx
    push ax
    mov  bh, [VID_PAG]
    mov  ah, 02h
    int  10h
    mov  [CUR_X], dh
    mov  [CUR_Y], dl
    pop  ax
    pop  bx
    ret

PAGE_DOWN_AL_STR_ATR_BH: ;Listat AL strok vverh s atributom BH
    push cx
    push dx
    push ax
    mov  cx, 0000h ;Verhniy levyy ugol
    mov  dh, 24    ;Nijniy pravyy ugol (stroka
    mov  dl, 79    ;    i kolonka)
    mov  ah, 06h
    int  10h
    pop  ax
    pop  dx
    pop  cx
    ret

CUR_NEXT_STR:   ;Peredvinut cursor na 1 stroku vniz
    push dx
    cmp  byte[CUR_X], 23; Proverit, ne poslednyaya li eto stroka
    je  .MOV_PAG
    mov  dh, [CUR_X]
    mov  dl, [CUR_Y]
    inc  dh
    call SET_CURSOR_DH_DL
    .MOV_PAG:
        push ax
        push bx
        mov  al, 01h
        mov  bh, [ATRIBUT]
        call PAGE_DOWN_AL_STR_ATR_BH
        pop  bx
        pop  ax
    pop dx
    ret

CUR_NEXT_POS:   ; Peredvinut cursor na 1 posiciu
    push dx
    cmp  byte[CUR_Y], 79; Proverit, ne konec li eto stroki
    je  .MOV_STR
    mov  dh, [CUR_X]
    mov  dl, [CUR_Y]
    inc  dl
    call SET_CURSOR_DH_DL
    .MOV_STR:
        call CUR_NEXT_STR
        mov  dh, [CUR_X]
        mov  dl, 0
        call SET_CURSOR_DH_DL
    pop  dx
    ret

WRITE_SYM_AL_ATR_BL:    ; Pisat simbol AL s atributom BL
    pushad
    cmp  al, 09h; Proverka na TAB
    je   .TAB
    cmp  al, 13 ; Proverka na Enter
    je   .ENTER
    mov  ah, 09h
    mov  bh, [VID_PAG]
    mov  cx, 0001h
    int  10h
    jmp  .EXIT
    .TAB:
        mov  al, ' '
        mov  ah, 09h
        mov  bh, [VID_PAG]
        mov  cx, 0001h
        int  10h ; TAB == 4 space
        int  10h
        int  10h
        int  10h
        jmp  .EXIT
    .ENTER:
        call CUR_NEXT_STR
        mov  dh, 0h
        mov  dl, [CUR_Y]
        call SET_CURSOR_DH_DL
    .EXIT:
        popad
        ret

WRITE_STR_DI_ATR_BL:    ; Pisat stroku [DI] s atributom BL
    push di
    push ax
    .LOOP:
        cmp  byte[di], 0
        je  .EXIT
        mov  al, [di]
        call WRITE_SYM_AL_ATR_BL
        inc  di
        jmp .LOOP
    .EXIT:
        pop  ax
        pop  di
        ret

WRITE_DEC_NUM_AX_ATR_BL:    ;Pisat 4islo AX atributom BL
    pushad
    mov  di, .BUFFER
    mov  byte[di], 0
    call ADD_DEC_NUM_AX_TO_STR_DI
    call WRITE_STR_DI_ATR_BL
    popad
    ret
    .BUFFER: db '        ', 0h

END_OF_STR_DI_TO_SI:    ; Pomestit v SI adres 0 stroki DI
    mov  si, di
    .LOOP:
        cmp  byte[si], 0
        je   .EXIT
        inc  si
        jmp  .LOOP
    .EXIT:
        ret

ADD_SYM_AL_TO_STR_DI:   ; Dopisat k stroke DI simbol AL
    push si
    call END_OF_STR_DI_TO_SI
    mov  [si], al
    inc  si
    mov  byte[si], 0h
    pop  si
    ret

ADD_DEC_NUM_AX_TO_STR_DI:   ; Dopisat k stroke DI 4islo AX
    pushad
    mov  bx, 10; 10-ti4naya sistema s4isleniya
    xor  cx, cx
    .LOOP1:
        xor  dx, dx
        div  bx
        push dx
        inc  cx
        test ax, ax
        jnz  .LOOP1
    .LOOP2:
        pop  dx
        add  dl, '0'
        mov  al, dl
        call ADD_SYM_AL_TO_STR_DI
        dec  cx
        test cx, cx
        jnz  .LOOP2
    popad
    ret

OUTPUT_AL_PORT60:   ; Vyvod AL v port 60
    pushad
    mov  cl, al
    .LOOP:
        in   al, 64h
        test al, 2h; 0000 0010 b
        jz   .EXIT
        jmp  .LOOP
    .EXIT:
        mov   al, cl
        out   60h, al
        popad
        ret

OUTPUT_AL_PORT64:   ; Vyvod AL v port 64
    pushad
    mov  cl, al
    .LOOP:
        in   al, 64h
        test al, 2h; 0000 0010 b
        jz   .EXIT
        jmp  .LOOP
    .EXIT:
        mov   al, cl
        out   64h, al
        popad
        ret

INPUT_AL_PORT60:    ; 4tenie porta 60 v AL
    in   al, 60h
    ret

INPUT_AL_PORT64:    ; 4tenie porta 64 v AL
    .LOOP:
        in   al, 64h
        test al, 1h
        jnz .EXIT
        jmp .LOOP
    .EXIT:
        ret

INIT_PS2:   ; Initiali3atia myshy i klaviatury
    pushad
    mov  al, 0a8h
    call OUTPUT_AL_PORT64
    mov  al, 0xd4
    call OUTPUT_AL_PORT64
    mov  al, 0xf6
    call OUTPUT_AL_PORT60
    mov  al, 0xd4
    call OUTPUT_AL_PORT64
    mov  al, 0xf4
    call OUTPUT_AL_PORT60
    popad
    ret

PS2_READ:   ; 4tenie mywy i klavy
    pushad
    call INPUT_AL_PORT64
    test al, 100000b
    jnz .READ
    mov  ax, [BUTTON_1]
    mov  [BUTTON_2], ax
    call INPUT_AL_PORT60
    mov  [BUTTON_1], al
    jmp  .EXIT
    
    .READ:
        mov  ax, [MOUSE_I1]; sohranenie staryh zna4eniy
        mov  [MOUSE_I2], ax
        mov  ax, [MOUSE_X1]
        mov  [MOUSE_X2], ax
        mov  ax, [MOUSE_Y1]
        mov  [MOUSE_Y2], ax
        call INPUT_AL_PORT60; read info-byte mywy
        mov  [MOUSE_I1], al
        not  al
        mov  cl, al; sohranit info-byte v CL
        shl  al, 3
        shr  al, 7
        mov  ah, al
        call INPUT_AL_PORT60
        sub  ax, 128
        mov  dl, 3
        div  dl
        mov  ah, 0
        mov  [MOUSE_X1], ax
        mov  al, cl
        shl  al, 2
        shr  al, 7
        mov  ah, al
        call INPUT_AL_PORT60
        sub  ax, 128
        mov  dl, 10
        div  dl
        mov  ah, 0
        mov  dx, 0
        mov  dx, 25
        sub  dx, ax
        mov  ax, dx
        mov  [MOUSE_Y1], ax
        mov  dh, [MOUSE_X1]; otrisovka mywy
        mov  dl, [MOUSE_Y1]
        call SET_CURSOR_DH_DL; po idee, kursor posle etogo dolJen byt viden na meste mywi
    .EXIT:
        popad
        ret

;===================================================GLOBALNYE PEREMENNYE=======================================================
VID_PAG:  db 0; nomer videostranicy
CUR_X:    db 0; stroka kursora
CUR_Y:    db 0; stolbec kursora
ATRIBUT:  db 00110110b; Atribut simbola

MOUSE_I1: dw 0; info mywy
MOUSE_X1: dw 0; 
MOUSE_Y1: dw 0;
BUTTON_1: dw 0; scan-code knopki

MOUSE_I2: dw 0; prowlye dannye o mywy
MOUSE_X2: dw 0
MOUSE_Y2: dw 0
BUTTON_2: dw 0