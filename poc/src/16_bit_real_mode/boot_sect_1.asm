loop:					;this is just a manually defined tag
jmp loop				;the jump statement which takes us to our tag again
times 510-($-$$) db 0	;fill the remaining space with data ('0')
dw 0xaa55				;fill the last two bytes (one word) have to have aa55
						;so BIOS knows we are in the boot sector