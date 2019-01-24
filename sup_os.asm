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
    
    call INIT_SCREEN
    mov  al, 00h
    call CHOOSE_VID_PAGE_AL
    
    mov  dh, 00h
    mov  dl, 00h
    call SET_CURSOR_DH_DL
    mov  di, .STR0
    mov  bl, [.ATR0]
    call WRITE_STR_DI_ATR_BL
    inc  dh
    call SET_CURSOR_DH_DL
    mov  di, .STR1
    call WRITE_STR_DI_ATR_BL
    
    .ATR0: db 00000000b; 4ernym po belomu
    .STR0: db "Welcome to Sup_OS"
    .STR1: db "Press ENTER to load the system... "
    times 510-($-07C00h) db 144
    jmp far 0000:8000h
db 055h, 0AAh; Metka 3arpy3o4Horo cektopa

;=====================================================OSNOVNOY KOD=============================================================
org 8000h
MAIN:
    mov  al, 00h; zalit ves ekran
    mov  bh,[ATRIBUT]; vybrannym atributom
    call PAGE_DOWN_AL_STR_ATR_BH

;=================================================VSPOMOGATELNYE FUNCTII=======================================================
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

VID_PAG:  db 0; nomer videostranicy
CUR_X:    db 0; stroka kursora
CUR_Y:    db 0; stolbec kursora
ATRIBUT:  db 00110110b; Atribut simbola