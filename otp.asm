%include "io.mac"

section .text
    global otp
    extern printf

otp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the One Time Pad cipher

	xor 	eax, eax
	xor 	ebx, ebx
	criptare:
		; extragere caracter din plaintext
		mov 	al, byte [esi + ecx - 1]
		; extragere caracter din key
		mov 	bl, byte [edi + ecx - 1]
		; criptare si introducere in ciphertext
		xor 	al, bl
		mov 	byte[edx + ecx - 1], al
	loop criptare
	;; END One Time Pad Cipher

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
