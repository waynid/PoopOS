[org 0x7c00]             ; MEMORY LOCATION

mov ah, 0x0e             ; TEXT MODE
mov si, message          ; LOAD MESSAGE

main:
lodsb                    ; READ CHARACTER
cmp al, 0                ; END?
je .fin                  ; IF YES, FINISH
int 0x10                 ; PRINT CHARACTER
jmp main                 ; LOOP

.fin:
hlt                      ; STOP

message db 'Poop', 0     ; TEXT "Poop"
times 510-($-$$) db 0    ; PADDING
dw 0xaa55                ; BOOT SIGNATURE
