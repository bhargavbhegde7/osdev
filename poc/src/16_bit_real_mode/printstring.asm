;prints only the first char
;todo print the whole string
;mov ah, 0x0e
mov ah, 0x13

mov bx, the_string
add bx, 0x7c00 ;because we [somehow] know that the boot sector code is ALWAYS loaded in the address 0x7c00
mov al, [bx] 	;move the __**CONTENTS**__ of the address of bx into al
int 0x10

jmp $

;the_secret holds the offset of the character 'X'
the_string:
db 'bhargav',0

times 510-($-$$) db 0
dw 0xaa55
