; SupOS - классическая текстовая операционная система
; (C) Alex_vonSup & AcaplaStudios

org 0;
BOOT_SECTOR:
	;------------------------;
	mov  ah,00h	; video mode 80x24
	mov  al,03h	;
	int  10h	;
	mov ah,05h	; video page 0
	mov al,0	;
	int 10h		;
	
	mov bx,0	;
	mov dl,0	;
	mov dh,25	; cursor to string 25 == hide cursor
	mov ah,02h	;
	int 10h		;
	
	cli
	cld
	xor ax, ax;
	mov ds, ax;
	mov es, ax;
	mov ss, ax;
	mov sp, 8000h;
	sti

	mov dh, 0; head
	mov ch, 0; track
	mov cl, 2; sector
	mov ax, 0000h;
	mov es, ax; address to load
	mov bx, 0x8000;
	mov al, 30; number of read sectors (minimum 6)
	mov ah, 2h
	int 13h
	jmp far 0:8000h

times 0x200 - 2 - ($ - BOOT_SECTOR) db 0x90
db  055h, 0aah


org 8000h
REAL_MODE:
Start:
	mov  bp,Font
	mov  dx, 128
	mov  cx, 48
	mov  bx, 1000h
	mov  ax, 1100h
	int  10h;

	mov  bp,Font2
	mov  dx, 224
	mov  cx, 18
	mov  bx, 1000h
	mov  ax, 1100h
	int  10h;

	call CREAT_GDT
	cli
	mov eax, cr0
	or  al,  1
	mov cr0, eax
	jmp 0x0008:0x0000

	Font:
	;-------------;А
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
	;-------------;Б
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
	;-------------;В
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
	;-------------;Г
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
	;-------------;Д
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
	;-------------;Е
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
	;-------------;Ж
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
	;-------------;З
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
	;-------------;И
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
	;-------------;Й
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
	;-------------;К
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
	;-------------;Л
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
	;-------------;М
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
	;-------------;Н
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
	;-------------;О
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
	;-------------;П
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
	;-------------;Р
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
	;-------------;С
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
	;-------------;Т
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
	;-------------;У
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
	;-------------;Ф
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
	;-------------;Х
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
	;-------------;Ц
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
	;-------------;Ч
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
	;-------------;Ш
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
	;-------------;Щ
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
	;-------------;Ъ
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
	;-------------;Ы
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
	;-------------;Ь
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
	;-------------;Э
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
	;-------------;Ю
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
	;-------------;Я
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
	;-------------;а
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
	;-------------;б
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
	;-------------;в
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
	;-------------;г
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
	;-------------;д
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
	;-------------;е
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
	;-------------;ж
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
	;-------------;з
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
	;-------------;и
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
	;-------------;й
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
	;-------------;к
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
	;-------------;л
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
	;-------------;м
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
	;-------------;н
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
	;-------------;о
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
	;-------------;п
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
Font2:    ;-------------;р
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
	;-------------;с
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
	;-------------;т
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
	;-------------;у
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
	;-------------;ф
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
	;-------------;х
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
	;-------------;ц
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
	;-------------;ч
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
	;-------------;ш
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
	;-------------;щ
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
	;-------------;ъ
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
	;-------------;ы
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
	;-------------;ь
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
	;-------------;э
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
	;-------------;ю
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
	;-------------;я
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
Font3:    ;-------------;Ё
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
	;-------------;ё
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


CREAT_GDT:
	mov ax, 0400h
	mov es, ax

	; clear GDT (1024 elements)
	xor di, di
	mov cx, 2000h
	xor ax, ax
	rep stosb
	mov di, 8

    ; ~600 kb code, which can be loaded
    mov eax, 93fffh
    mov ebx, PROTECTED_MODE ; beginning
    mov cx,  90h + 08h + 4000h ; DPL=0, PRESENT=0x80, BIT_SYSTEM=0x10, CODE_EXEC_ONLY=0x8, BIT_DEFAULT_SIZE_32=0x4000
    call CREAT_DESCRIPTOR

    ; repeat segment but for data
    mov eax, 93fffh
    mov ebx, PROTECTED_MODE ; beginning
    mov cx,  90h + 02h + 4000h ; DATA_READ_WRITE=0x2
    call CREAT_DESCRIPTOR

    ; сегмент стека (256 кб)
    mov eax, 3FFFFh
    mov ebx, 100000h ; beginning in HI-mem
    mov cx,  90h + 02h + 4000h ; DATA_READ_WRITE=0x2
    call CREAT_DESCRIPTOR

    ; memory (es)
    mov eax, 0xFFFFF
    xor ebx, ebx
    mov cx,  90h + 02h + 8000h + 4000h ; GRANUL=0x8000
    call CREAT_DESCRIPTOR

    ; loading GDT [0x4000]
    mov  word [7C00h], 1FFFh
    mov  dword[7C02h], 4000h
    lgdt [7C00h]

    ; loading IDT
    mov  word [7C06h], 07FFh
    mov  dword[7C08h], 6000h
    lidt [7C06h]
    ret
;==============================================================================}
CREAT_DESCRIPTOR:
	stosw ; limit

    xchg  eax, ebx
    stosw ; address 0..15

    shr   eax, 16
    stosb ; addr 16..23

    xchg  eax, ebx
    mov   al, cl
    stosb ; config low

    shr   eax, 16
    or    al, ch
    stosb ; config + limit

    xchg  eax, ebx
    shr   ax, 8
    stosb ; addr 24..31

    ret

SIZE_OF_REAL_MODE = $ - REAL_MODE


PROTECTED_MODE:;
    org 0
    use32

.START:
	mov ax, 10h
    mov ds, ax
    mov ax, 18h
    mov ss, ax
    mov esp, 40000h
    mov ax, 20h
    mov es, ax
    mov ax, 0
    mov fs, ax
    mov gs, ax

MAIN:; KOD 3DES
	call SCREEN_80_25_CLEAR;
	call MOUSE_INIT;
	
	; mov  ecx, 80;
	; mov  edx, 24;
	; mov  ah,[CONSOLE_BKG];
	; mov  al, ' ';
	; .CONSOLE:; draw a line with CONSOLE_BKG at the bottom
		; dec  ecx;
		; call SCREEN_80_25_PRINT_AX_ECX_EDX;
		; test ecx, ecx;
		; jnz .CONSOLE;
	; mov  edx, 0;
	; mov  ecx, 80;
	; .STATUS_BAR:; draw a line with CONSOLE_BKG at the top
		; dec  ecx;
		; call SCREEN_80_25_PRINT_AX_ECX_EDX;
		; test ecx, ecx;
		; jnz .STATUS_BAR;
	
	mov  ecx, 0;
	mov  edx, 0;
	call SCREEN_80_25_CURSOR_ECX_EDX;
	mov  esi,.TEXTWELCOM;
	call SCREEN_80_25_PRINT_STR_ESI;
	call SCREEN_80_25_NEXT_LINE;
	xor  eax, eax;
	mov  al, 1;
	
; .LOOP0:
	; mov [.TEST_ASCII+eax], al;
	; inc  eax;
	; cmp  eax, 100h;
	; jne .LOOP0;

; mov  esi,.TEST_ASCII;
; call SCREEN_80_25_PRINT_STR_ESI;

.LOOP1:
	call MOUSE_READ;
	call SCANCODE_TO_LETTER;
	mov  al,[LETTER_1];
	mov [.INPUT], al;
	xor  eax, eax;
	
	xor  ecx, ecx;
	mov  edx, 03h;
	call SCREEN_80_25_CURSOR_ECX_EDX;
	mov  al,[BUTTON_1];
	call SCREEN_80_25_PRINT_NUM_EAX;
	
	inc  edx;
	call SCREEN_80_25_CURSOR_ECX_EDX;
	mov  al,[LETTER_1];
	call SCREEN_80_25_PRINT_NUM_EAX;
	
	inc  edx;
	call SCREEN_80_25_CURSOR_ECX_EDX;
	mov  esi,.INPUT;
	call SCREEN_80_25_PRINT_STR_ESI;
	
	jmp .LOOP1;

.TEST_ASCII: times 100h db 0;
.TEXTWELCOM: db 'Welcome to SupOS! Добро пожаловать в СупОС!', 0;
.TEXTPROBEL: db '     ', 0;
.TEXTMOUSEX: db 'Mouse   X =', 0;
.TEXTMOUSEY: db 'Mouse   Y =', 0;
.TEXTMOUSEI: db 'Mouse Info=', 0;
.TEXTBUTTON: db 'Scan Code =', 0;
.INPUT: db ' ', 0;

; CONSOLE: times 100h db 0;


; FUNCTIONS FOR ELEMENTS
; ELEM_TYPE:; EAX == type of element EDI
	; push EDI;
	; xor  EAX, EAX;
	; add  EDI, EL_TYP;
	; mov  AL,[EDI];
	; pop  DI;
	; ret;

; ELEM_FUN:; EAX == if element EDI is function; flag Z if element EDI is function
	; push EDI;
	; xor  EAX, EAX;
	; add  EDI, EL_FUN;
	; mov  AL,[EDI];
	; test AL, AL;
	; pop  DI;
	; ret;

; ELEM_NAME:; EAX == name of element EDI
	; push EDI;
	; add  EDI, EL_NAM;
	; mov  EAX,[EDI];
	; pop  EDI;
	; ret;

; ELEM_LTR:; EAX == first letter of name of element EDI
	; push EDI     ;
	; call ELEM_NAME ;
	; mov  EDI,EAX ;
	; mov  AL,[EDI];
	; pop  EDI     ;
	; ret;

; ELEM_VAL:; EAX == value of element EDI
	; push EDI;
	; add  EDI, EL_VAL;
	; mov  EAX,[EDI];
	; test EAX, EAX;
	; pop  EDI;
	; ret;

; ELEM_PREV:; EAX == previous element of element EDI
	; push EDI;
	; add  EDI, EL_PRE;
	; mov  EAX, [EDI];
	; test EAX,EAX;
	; pop  EDI;
	; ret;

; ELEM_NEXT:; EAX == next element of element EDI
	; push EDI;
	; add  EDI,EL_NEX;
	; mov  EAX,[EDI];
	; test EAX,EAX;
	; pop  EDI;
	; ret;

; ELEM_PAR:; EAX == parent of element EDI
	; push EDI;
	; add  EDI,EL_PAR;
	; mov  EAX,[EDI];
	; test EAX, EAX;
	; pop  EDI;
	; ret;

; ELEM_NEST:; EAX == first nested element of element EDI
	; push EDI;
	; add  EDI, EL_NES;
	; mov  EAX,[EDI];
	; test EAX, EAX;
	; pop  EDI;
	; ret;

; ELEM_COD:; EAX == code of element EDI
	; push edi; maybe here DI instead of DI
	; add  EDI, EL_COD;
	; mov  eax,[edi];
	; test eax, eax;
	; pop  edi;
	; ret;

; ; element structure
; EL_TYP = 0 ;
; EL_FUN = 1 ;
; EL_NAM = 4 ;
; EL_VAL = 8 ;
; EL_COD = 12;
; EL_PAR = 16;
; EL_PRE = 20;
; EL_NEX = 24;
; EL_NES = 28;


; FUNCTIONS FOR STRINGS
END_OF_STR_ESI_TO_ESI:;
	push Ecx;
	.LOOP:	mov  cl,[esi];
		test cl, cl;
		JZ  .END;
		inc  ESI;
		Jmp .LOOP;
	.END:
		pop ecx;
		ret;

ADD_LETTER_AL_TO_STR_ESI :;
	push ESI;
	call END_OF_STR_ESI_TO_ESI;
	mov [ESI], AL;
	inc  ESI;
	mov  byte[ESI], 0;
	pop  ESI;
	ret;

ADD_DEC_NUM_EAX_TO_STR_ESI:; add decimal number EAX to string ESI
	pushad
	mov ebx, 10;
	xor ecx, ecx;
	.LOOP1:
		xor  edx, edx;
		div  ebx;
		push edx;
		inc  ecx;
		test eax, eax;
		jnz .LOOP1;
	.LOOP2:
		pop  edx;
		add  dl,'0';
		mov  al, dl;
		call ADD_LETTER_AL_TO_STR_ESI;
		dec  ecx;
		test ecx, ecx;
		jnz .LOOP2;
	popad;
	ret;

ADD_HEX_NUM_EAX_TO_STR_ESI:; add hexademical number EAX to string ESI
	pushad
	mov ebx, 10h;
	xor ecx, ecx;
	.LOOP1:
		xor  edx, edx;
		div  ebx;
		push edx;
		inc  ecx;
		test eax, eax;
		jnz .LOOP1;
	.LOOP2:
		pop  edx;
		cmp  edx, 09;
		ja  .LET;
		add  dl,'0';
		jmp .NEXT;
		.LET:
			sub  dl, 09;
			add  dl,'A';
		.NEXT:
			mov  al, dl;
			call ADD_LETTER_AL_TO_STR_ESI;
			dec  ecx;
			test ecx, ecx;
			jnz .LOOP2;
	popad;
	ret;


; VARIABLES for PS/2
BUTTON_1: DB 0; scan code
MOUSE_I1: DB 0; info of mouse
MOUSE_X1: DB 0;
MOUSE_Y1: DB 0;
; OLD DATA
BUTTON_2: DB 0;
MOUSE_I2: DB 0;
MOUSE_X2: DB 0;
MOUSE_Y2: DB 0;

; FUNCTIONS FOR PS/2
MOUSE_INIT:;
	pushad;
	mov  al, 0A8h; turn on mouse
	call PS2_OUTPUT_AL_PORT64;
	mov  al, 0xD4; set standard settings
	call PS2_OUTPUT_AL_PORT64;
	mov  al, 0xF6;
	call PS2_OUTPUT_AL_PORT60;
	mov  al, 0xD4; turn on 'otpravka ot4etov'
	call PS2_OUTPUT_AL_PORT64;
	mov  al, 0xF4;
	call PS2_OUTPUT_AL_PORT60;
	popad;
	ret;

MOUSE_READ:;
	pushad;
	call PS2_INPUT_PORT64_AL;
	test al, 100000b;
	; jnz .READ_MOUSE;

	mov  al,[BUTTON_1];
	mov  [BUTTON_2],al;

	call PS2_READ_PORT60_AL
	mov  [BUTTON_1],al;
	jmp .END;
	.READ_MOUSE:
	jmp .END; remove it if .READ_MOUSE works
		mov  al,[MOUSE_I1]; save old coordinates
		mov [MOUSE_I2], al;
		mov  al,[MOUSE_X1];
		mov [MOUSE_X2], al;
		mov  al,[MOUSE_Y1];
		mov [MOUSE_Y2], al;
		call PS2_READ_PORT60_AL; read info byte
		mov [MOUSE_I1], al;
		not  al; count coordinate X
		mov  cl, al;
		SHL  al, 3;
		SHR  al, 7;
		mov  ah, al;
		call PS2_READ_PORT60_AL;
		sub  eax, 128;
		mov  dl, 3;
		div  dl;
		mov  ah, 0;
		mov [MOUSE_X1], al;
		mov  al, cl; count coordinate Y
		SHL  al, 2;
		SHR  al, 7;
		mov  ah, al;
		call PS2_READ_PORT60_AL;
		sub  eax, 128;
		mov  dl, 10;
		div  dl;
		mov  ah, 0;
		; mov  edx, 0;
		mov  edx, 25;
		sub  edx, eax;
		mov  eax, edx;
		mov [MOUSE_Y1], al;
		
		xor  ecx, ecx
		xor  edx, edx
		xor  eax, eax
		mov  cl,[MOUSE_X2]; clear old mouse position
		mov  dl,[MOUSE_Y2];
		mov  ah,[SCREEN_BCKG];
		mov  al, ' ';
		call SCREEN_80_25_PRINT_AX_ECX_EDX;
		mov  cl,[MOUSE_X1]; draw mouse
		mov  dl,[MOUSE_Y1];
		mov  ah, 10110000b;
		mov  al, ' ';
		call SCREEN_80_25_PRINT_AX_ECX_EDX;
	.END:
	popad;
	ret;

PS2_OUTPUT_AL_PORT64:;
	pushad;
	mov  cl, al;
	;.LOOP:
	;	in   AL, 64h;
	;	test AL, 2; 0000 0010b
	;	jz  .END;
	;	jmp .LOOP;
	.END:
		mov  al, cl;
		out  64h, al;
		popad;
		ret;

PS2_OUTPUT_AL_PORT60:;
	pushad;
	mov  cl, al;
	;.LOOP:
	;	in   AL, 64h;
	;	test AL, 2;
	;	jz  .END;
	;	jmp .LOOP;
	.END:
		mov   al, cl;
		out   60h,al;
		popad;
		ret;

PS2_READ_PORT60_AL:;
	;.LOOP:
	;	in   aL, 64h;
	;	test aL, 1;
	;	jnz .END;
	;	jmp .LOOP;
	;.END:
	in   al, 60h;
	ret;

PS2_INPUT_PORT64_AL :;
	;.LOOP:
	;	in   al, 64h;
	;	test al, 1;
	;	jnz .END;
	;	jmp .LOOP;
	.END:
	ret;

SCANCODE_TO_LETTER:;
	pushad;
	xor  ecx, ecx;
	xor  edx, edx;
	mov  cl,[BUTTON_1];
	mov  dl,[BUTTON_2];
	sub  cl, 129; scancode ESC == 129d
	sub  dl, 129;
	add  ecx,.letters;
	add  edx,.letters;
	mov  al, [ecx];
	mov  bl, [edx];
	mov [LETTER_1], al;
	mov [LETTER_2], bl;
	popad;
	ret;
	.letters: db 1bh, "1234567890-=", 01h, 09h, "йцукенгшщзхъ", 13, 11h, "фывапролджэё\\ячсмитьбю.", 0Eh;
	; spec.syms in ASCII:
		; ESC == 1Bh
		; TAB == 09h
		; BACKSPACE == 01h
		; ENTER == 13d
		; CTRL == 11h
		; SHIFT == 0Eh

; READ_KEYBOARD:;
	; pushad;
	
	; mov  al,[LETTER_1]; save old data
	; mov [LETTER_2], al;
	; mov  al,[BUTTON_1];
	; mov [LETTER_2], al;
	
	; mov  ah, 01h;
	; int  16h; call interrupt "check symbol"
	; jz  .END; if symbol isn't ready, quit
	
	; mov [LETTER_1], al;
	; mov [BUTTON_1], ah;
	
	; .END:
	; popad;
	; ret;


; VARIABLES
LETTER_1: DB 0; ascii of pressed button
LETTER_2: DB 0; previous pressed ascii

SCREEN_CURSOR_X: DD 0;
SCREEN_CURSOR_Y: DD 0;
SCREEN_BCKG: DB 01011111b;
; CONSOLE_BKG: DB 00111001b;

; FUNCTIONS FOR SCREEN
SCREEN_80_25_CURSOR_ECX_EDX:;
		pushad;
		cmp  ecx, 79;
		jb  .NEXT1;
		mov  ecx, 0;
	.NEXT1:
		cmp  edx, 24;
		jb  .NEXT2;
		mov  edx, 0;
	.NEXT2:
		mov [SCREEN_CURSOR_X], ecx;
		mov [SCREEN_CURSOR_Y], edx;
		popad;
		ret;

SCREEN_80_25_CLEAR:;
	pushad
	mov  ecx, 2000;
	mov  al, ' ';
	mov  ah,[SCREEN_BCKG];
	mov  EDI,0B8000h
	.LOOP:
		test ecx, ecx;
		jz  .END;
		MOV [ES:EDI], al;
		inc  EDI;
		MOV [ES:EDI],ah;
		inc  EDI;
		dec  ecx;
		jmp .LOOP;
	.END:
		popad;
		ret;

SCREEN_80_25_PRINT_AX_ECX_EDX:; print symbol AL with attributes AH
	pushad;
	mov  ebx, eax;
	mov  EDI, 0B8000h
	cmp  ecx, 79;
	ja  .END;
	cmp  edx, 24;
	ja  .END;
	mov  eax, 2; 1 symbol == 2 bytes
	mul  cl;
	mov  ecx, eax;
	mov  eax, 160;
	mul  dl;
	add  eax, ecx;
	add  edi, eax;
	test bl, bl;
	jz  .NEXT;
	MOV  byte[ES:EDI], bl;
.NEXT:
	inc  EDI;
	MOV  byte[ES:EDI], bh;
.END:
	popad;
	ret;

SCREEN_80_25_NEXT_POSITION:; move cursor to the next position
	pushad;
	mov  ecx,[SCREEN_CURSOR_X];
	mov  edx,[SCREEN_CURSOR_Y];
	cmp  ecx, 79;
	jae .NEXT_STR;
	inc  ecx;
	jmp .END;
	.NEXT_STR:
		mov  ecx, 0;
		inc  edx;
		cmp  edx, 24;
		jb  .END;
		mov  ecx, 0;
		mov  edx, 0;
	.END:
		mov [SCREEN_CURSOR_X], ecx;
		mov [SCREEN_CURSOR_Y], edx;
		call SCREEN_80_25_CURSOR_ECX_EDX;
		popad;
		ret;

SCREEN_80_25_NEXT_LINE:; move cursor to the next line
	pushad;
	mov  ecx,[SCREEN_CURSOR_X];
	mov  edx,[SCREEN_CURSOR_Y];
	.NEXT_STR:
		mov  ecx, 0;
		inc  edx;
		cmp  edx, 24;
		jb  .END;
		mov  ecx, 0;
		mov  edx, 0;
	.END:
		mov [SCREEN_CURSOR_X], ecx;
		mov [SCREEN_CURSOR_X], edx;
		call SCREEN_80_25_CURSOR_ECX_EDX;
		popad;
		ret;

SCREEN_80_25_PRINT_LETTER_AL:; print letter AL
	pushad;
	cmp  al, 13;
	jnz .NEXT;
	call SCREEN_80_25_NEXT_LINE;
	jmp .END;
	mov  ah,[SCREEN_BCKG];
	.NEXT:
		cmp  al, 09h;
		je  .TAB;
		cmp  al, ' ';
		jb  .END;
		mov  ecx,[SCREEN_CURSOR_X];
		mov  edx,[SCREEN_CURSOR_Y];
		call SCREEN_80_25_PRINT_AX_ECX_EDX;
		call SCREEN_80_25_NEXT_POSITION;
		jmp .END;
	.TAB:
		mov  al, ' ';
		call SCREEN_80_25_PRINT_AX_ECX_EDX; TAB == 4 SPACE
		inc  edx;
		call SCREEN_80_25_PRINT_AX_ECX_EDX;
		inc  edx;
		call SCREEN_80_25_PRINT_AX_ECX_EDX;
		inc  edx;
		call SCREEN_80_25_PRINT_AX_ECX_EDX;
	.END:
	popad;
	ret;

SCREEN_80_25_PRINT_STR_ESI:; print string ESI
	pushad;
	mov  ah,[SCREEN_BCKG];
	.LOOP:	mov  al,[esi];
		test al, al;
		jz  .END;
		call SCREEN_80_25_PRINT_LETTER_AL;
		inc  esi;
		jmp .LOOP;
	.END:
		popad;
		ret;

SCREEN_80_25_PRINT_NUM_EAX :; print number EAX
	pushad;
	mov  ESI,.BUFFER;
	mov  byte[ESI], 0;
	call ADD_DEC_NUM_EAX_TO_STR_ESI;
	call SCREEN_80_25_PRINT_STR_ESI;
	popad;
	ret;
	.BUFFER: times 10h db 0;

SCREEN_80_25_PRINT_HEX_NUM_EAX :; print hexademical number EAX
	pushad;
	mov  ESI,.BUFFER;
	mov  byte[ESI], 0;
	call ADD_HEX_NUM_EAX_TO_STR_ESI;
	call SCREEN_80_25_PRINT_STR_ESI;
	popad;
	ret;
	.BUFFER: times 10h db 0;


; FUNCTIONS FOR MEMORY
CLEAR_MEMORY_ESI_EDI:; clear memory [ESI, EDI)
      push  ESI; maybe PUSHAD here
	.LOOP:
		CMP  ESI, EDI;
		JAE .END;
		mov  byte[ESI], 0;
		INC  ESI;
		JMP .LOOP;
	.END:
		pop   ESI; maybe POPAD here
		ret

CLEAR_PLOT_EDI:; clear the plot of memory at EDI; addres EDI got in MEMORY_ALLOCATE
	pushad;
	SUB  EDI, 5;
	MOV  byte[DI], 0;
	inc  edi;
	mov  ecx,[edi];
	add  edi,4;
	mov  esi,edi;
	add  Edi,ECX;
	inc  edi;
	call CLEAR_MEMORY_ESI_EDI;
	popad;
	RET;

ALLOCATE_PLOT_SIZE_EDI_ADR_EDI:; allocate a plot of size EDI; EDI == address of the plot
	PUSHAD;
	MOV  ESI,[HEAP_START];
	.LOOP:
		MOV  AL,[ESI];
		INC  ESI;
		MOV  ECX,[ESI];
		TEST AL, AL;
		JNZ .NEXT;
		TEST ECX, ECX;
		JZ  .FREE;
		CMP  ECX, EDI;
		JZ  .FREE;
	.NEXT:
		ADD  ECX, 4;
		ADD  ESI, ECX;
		JMP .LOOP;

	.FREE:
		DEC  ESI;
		MOV  byte [ESI], 1;
		INC  ESI;
		MOV [ESI], EDI;
		ADD ESI, 4;
	POP  EDI;
	PUSH ESI;
	POPAD;
	RET;

; VARIABLES
HEAP_START: DW $; address of the beginning of the heap
HEAP_END:	DW $ + 8000h; address of the end of the heap

HELLO_WORLD: DB "Hello world. Привет, мир!",0;
END_OF_PROGRAM:; use to set the address of the HEAP START
;				Size of protected mode			Real code	boot sector
times 1474560 - ($ - PROTECTED_MODE.START) - SIZE_OF_REAL_MODE - 0x200 db 0x90; use to make the BIN size == floppy disk size
