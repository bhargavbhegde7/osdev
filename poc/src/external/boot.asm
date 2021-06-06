; Assemble with:
;     nasm -f bin -o boot.bin boot.asm
; Test with:
;     qemu-system-i386 -fda boot.bin

org 7c00h
bits 16

section .text

main:
    xor ax, ax
    mov ds, ax
    mov es, ax         ; Set DS=ES=0 . Don't assume they are set by BIOS to
                       ;     what we expect
    mov ss, ax
    mov sp, 7c00h      ; Place SS:SP right below boot sector at 0x0000:0x7c00
    cld                ; Forward direction for instructions like LODSB etc.

    xor bx, bx         ; BH = Page zero, BL = 0 (ignored in text mode)
    mov si, HELLO      ; SI = Address of HELLO
    call _print_string

    ; Infinite loop to end bootloader
    cli
hltloop:
    hlt
    jmp hltloop

; Function _print_string
;     Uses Int 10h, AH=0Eh to print each character of a string
;     See: http://www.ctyme.com/intr/rb-0106.htm
;
; Function parameters
;     SI = address of NUL terminated string
;     BH = Page Number
;     BL = Foreground Color (Graphics mode only)
;
; Destroys:
;     SI
_print_string:
    push ax
    mov  ah, 0Eh       ; BIOS Int 10h/AH=0eh TTY output
.procchar:
    lodsb              ; Get next character from string DS:[SI], store in AL
                       ;     Increment SI by 1
    test al, al
    je   .finished     ; If NUL terminator we are finished
    int  10h           ; otherwise print character
    jmp  .procchar     ; process next character
.finished:
    pop ax
    ret

HELLO:
    db "Hello World!", 10, 13, 0

    times 510-($-$$) db 00h
bootsig:
    dw 0AA55h
