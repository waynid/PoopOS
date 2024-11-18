    [org 0x7c00]             ; MEMORYLOCATION

; --- INITIALIZATION ---
mov ah, 0x0e             ; TELETYPEMODE
mov si, ASCIIART         ; LOADASCIIART

; --- ASCIIARTDISPLAY ---
MAINEMOJI:
lodsb                    ; LOADCHARACTER
cmp al, 0                ; ENDSTRING?
je MAINTEXT              ; GOTOSHOWTITLE
int 0x10                 ; PRINTCHARACTER
jmp MAINEMOJI            ; CONTINUELOOP

; --- TITLEDISPLAY ---
MAINTEXT:
mov si, TITLE            ; LOADTITLE
TEXTLOOP:
lodsb                    ; LOADCHARACTER
cmp al, 0                ; ENDSTRING?
je ANIMATIONSTART        ; GOTOANIMATION
int 0x10                 ; PRINTCHARACTER
jmp TEXTLOOP             ; CONTINUELOOP

; --- LOADINGANIMATION ---
ANIMATIONSTART:
mov cx, 0xffff           ; INFINITECOUNTER
LOADLOOP:
mov si, LOADINGFRAMES    ; LOADFRAMES
mov bx, 0                ; RESETINDEX
FRAMELOOP:
mov al, [si + bx]        ; LOADFRAME
cmp al, 0                ; ENDARRAY?
je NEXTFRAME             ; RESETFRAME
int 0x10                 ; PRINTFRAME
mov al, 0x08             ; BACKSPACE
int 0x10                 ; ERASEFRAME
inc bx                   ; NEXTFRAME
jmp FRAMELOOP            ; CONTINUELOOP

NEXTFRAME:
loop LOADLOOP            ; INFINITELOOP

; --- ENDPROGRAM ---
hlt                      ; HALTEXECUTION

; --- DATADEFINITIONS ---
ASCIIART db '💩  ', 0     ; SIMULATEDART
TITLE db 'PoopOS', 0      ; OPERATINGSYSTEMTITLE
LOADINGFRAMES db '|', '/', '-', '\\', 0 ; LOADINGANIMATIONFRAMES
times 510-($-$$) db 0     ; PADDINGBYTES
dw 0xaa55                ; BOOTSIGNATURE
