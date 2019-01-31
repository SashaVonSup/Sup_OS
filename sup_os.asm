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
    inc  dl
    call SET_CURSOR_DH_DL
    
    .ATR0: db 00001111b; belym po 4ernomu
    .STR0: db "Welcome to Sup_OS!"
    .STR1: db "Press ENTER to load the system... "
    times 510-($-07C00h) db 144
    jmp far 0000:8000h
db 055h, 0AAh; Metka 3arpy3o4Horo cektopa

;=====================================================OSNOVNOY KOD=============================================================
org 8000h
MAIN:
    mov  al, 00h;      zalit ves ekran
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
    .BUFFER: db '                ', 0h

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
        mov  dh, [MOUSE_X2]; otrisovka mywy
        mov  dl, [MOUSE_Y2]
        call SET_CURSOR_DH_DL
        mov  bl, [ATRIBUT]
        mov  al, ' '
        call WRITE_SYM_AL_ATR_BL
        mov  dh, [MOUSE_X1]
        mov  dl, [MOUSE_Y1]
        call SET_CURSOR_DH_DL
        mov  bl, 10111000b; Atribut, kotorym risuetsya myw
        mov  al, ' '
        call WRITE_SYM_AL_ATR_BL
    .EXIT:
        popad
        ret

;===================================================GLOBALNYE PEREMENNYE=======================================================
VID_PAG:  db 0; nomer videostranicy
CUR_X:    db 0; stroka kursora
CUR_Y:    db 0; stolbec kursora
ATRIBUT:  db 00110110b; Atribut simbola

MOUSE_I1: dd 0; info mywy
MOUSE_X1: dd 0; 
MOUSE_Y1: dd 0;
BUTTON_1: dd 0; scan-code knopki

MOUSE_I2: dd 0; prowlye dannye o mywy
MOUSE_X2: dd 0
MOUSE_Y2: dd 0
BUTTON_2: dd 0