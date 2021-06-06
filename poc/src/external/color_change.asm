; MOV AH, 0x6    ; Scroll up function
; XOR AL, AL     ; Clear entire screen
; XOR CX, CX     ; Upper left corner CH=row, CL=column
; MOV DX, 184FH  ; lower right corner DH=row, DL=column 
; MOV BH, 1Eh    ; YellowOnBlue
; INT 10H

MOV BH, 1Eh    ; YellowOnBlue
INT 10H
mov al, 'h'
int 0x10
mov al, 'i'
int 0x10
mov al, 's'
int 0x10


jmp $
times 510-($-$$) db 0
dw 0xaa55