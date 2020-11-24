%include "io.mac"

section .bss
	plaintext_len: 	resd 1
	key_len: 		resd 1
	aux_ecx: 		resd 1

section .text
    global vigenere
    extern printf

vigenere:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    ;; DO NOT MODIFY
	
    ;; TODO: Implement the Vigenere cipher

	; retinere valori pentru a putea folosi registrele
	mov 	[plaintext_len], ecx
	mov 	[key_len], ebx 
	xor 	ecx, ecx
	xor 	eax, eax
	xor 	ebx, ebx
	;; inceput while
	;; se parcurge sirul caracter cu caracter si se realizeaza criptarea
start:
	xor 	eax, eax
	cmp 	ebx, [key_len] ;; pozitia in key
	jge 	actualizare_ebx
back:
	xor 	eax, eax
	mov 	[aux_ecx], ecx ; retinere o copie a lui ecx
	mov 	al, byte[esi + ecx] ; extragere caracter din plaintext
	mov 	cl, byte[edi + ebx] ; extragere caracter din key
	; verificare daca este litera caracterul extras din plaintext
	cmp 	al, 'A'
	jl 		non_char
	cmp 	al, 'Z'
	jle 	found
	cmp 	al, 'a'
	jl 		non_char
	cmp 	al, 'z'
	jg 		non_char
	; gasit litera mica
	; prelucrarea caracterului si introducerea lui in cyphertext
	; asemanator cu caesar
	sub 	cl, 'A'
	add 	eax, ecx
	cmp 	eax, 'z'
	jg 		rotate_lower
	mov	 	ecx, dword[aux_ecx]
	mov 	byte[edx + ecx], al
	jmp 	end
found: ; gasit litera mare
	; prelucrarea caracterului si introducerea lui in cyphertext
	; asemanator cu caesar
	sub 	cl, 'A'
	add 	eax, ecx
	cmp 	eax, 'Z'
	jg 		rotate_upper
	mov 	ecx, dword[aux_ecx]
	mov 	byte[edx + ecx], al
	jmp 	end
rotate_lower:
	sub		al, 'z'
	dec 	al
	add 	al, 'a'
	cmp 	al, 'z'
	jg 		rotate_lower
	mov 	ecx, dword[aux_ecx]
	mov 	byte[edx + ecx], al
	jmp 	end
rotate_upper:
	sub 	al, 'Z'
	dec 	al
	add 	al, 'A'
	cmp 	al, 'Z'
	jg 		rotate_upper
	mov 	ecx, dword[aux_ecx]
	mov 	byte[edx + ecx], al
	jmp 	end
non_char:
	mov 	ecx, dword[aux_ecx]
	mov 	byte[edx + ecx], al
	jmp 	end_2
end:
	inc 	ebx
end_2:
	inc 	ecx
	cmp 	ecx, [plaintext_len]
	jle 	start
	;; End Vigenere Cipher
    ;; DO NOT MODIFY
    popa
    leave
    ret
actualizare_ebx: ;; cand se depaseste lungimea key-ului
	xor 	ebx, ebx
	jmp 	back
    ;; DO NOT MODIFY
