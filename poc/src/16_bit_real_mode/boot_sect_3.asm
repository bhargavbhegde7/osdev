;org 0x7c00
mov ah, 0x0e

;first nope
mov al, '1'
int 0x10
mov al, the_secret ;label declared below
int 0x10

;second nope
mov al, '2'
int 0x10
mov al, [the_secret]
int 0x10

;third YES !!!
mov al, '3'
int 0x10
mov bx, the_secret
add bx, 0x7c00 ;because we [somehow] know that the boot sector code is ALWAYS loaded in the address 0x7c00
mov al, [bx] 	;move the __**CONTENTS**__ of the address at bx into al
int 0x10

;fourth YES !!!
mov al, '4'
int 0x10
mov al, [0x7c2d] ;0x2d + 0x7c00 = 0x7c2d ( here 0x2d is the address of 'x' that is the_secret )
int 0x10

jmp $

;the_secret holds the offset of the character 'X'
the_secret:
db 'X',0

times 510-($-$$) db 0
dw 0xaa55
