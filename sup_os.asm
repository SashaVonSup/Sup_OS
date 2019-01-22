format binary
org 7C00h

BOOT:
    ; 3arpy34ik
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 07C00h
    sti
    
    call INIT_SCREEN
    
    times 510-($-07C00h) db 144
db 055h, 0AAh; Metka 3arpy3o4Horo cektopa


INIT_SCREEN:    ; Initializatia ekrana
    push ax
    mov  ah, 00h
    mov  al, 03h; text  80x25  16/8color
    int  10h
    mov  ah, 05h
    mov  al, 00h; video-stranitsa #0
    int  10h
    pop  ax
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

WRITE_SYM_AL_ATR_BL:    ; Pisat simbol AL s atributom BL
    push ax
    push bx
    push cx
    mov  ah, 09h
    mov  bh, [VID_PAG]
    mov  cx, 0001h
    int  10h
    pop  cx
    pop  bx
    pop  ax
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

VID_PAG: db 0; nomer videostranicy
CUR_X: db 0; stroka kursora
CUR_Y: db 0; stolbec kursora