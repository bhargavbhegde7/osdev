[bits 32] ;set the cpu mode to 32 bit

VIDEO_MEMORY equ 0xb8000 ;set the video memory constant
WHITE_ON_BLACK equ 0x0f ;set the color attribute constant

print_string_pm:
	pusha	;push all general purpose registers into the stack
	mov edx, VIDEO_MEMORY ; set the 32 bit version of
												;	data segment tegister to the start of the video memory

print_string_pm_loop: ; set 1st byte to value of the character and 2nd byte to the attributes
	mov al, [ebx] ;move the contents of the ebx (that is the ASCII value) on lower AX
	mov ah, WHITE_ON_BLACK; set the color attributes on higher AX

	cmp al, 0 ; if the next character is 0 -> end of the string
	je print_string_pm_done ; end the function

	mov [edx], ax ; put the ah (which contains what you want to write on the screen) into the video memory

	add ebx, 1 ;increment to the next character
	add edx, 2 ;increment the video memory pointer by 2 since each character takes 2 bytes for displaying

	jmp print_string_pm_loop ; loop to print the next character

print_string_pm_done:
	popa
	ret
