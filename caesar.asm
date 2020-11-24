%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length
    ;; DO NOT MODIFY

    ;; TODO: Implement the caesar cipher

	xor 	eax, eax
	xor 	ebx, ebx
criptare:
	; extragere caracter din plaintext
	xor 	ebx, ebx
	mov 	al, byte[esi + ecx - 1]
	; se verifica daca a fost extrasa o litera
	cmp 	al, 'A'
	jl 		non_char
	cmp 	al, 'Z'
	jle 	found
	cmp 	al, 'a'
	jl 		non_char
	cmp 	al, 'z'
	jg 		non_char
	; gasit litera mica
	add 	ebx, eax
	add 	ebx, edi
	cmp 	ebx, 'z'
	jg 		rotate_lower	; se duce la rotate daca il depaseste pe 'z' 
	add 	eax, edi
	mov 	byte[edx + ecx - 1], al
	jmp 	end
rotate_lower:
	sub 	ebx, 'z'
	dec 	ebx
	mov 	al, 'a'
	add 	eax, ebx
	cmp 	eax, 'z' ; daca sare din nou de z se reia rotate
	jg 		actualizare_lower
	mov 	byte[edx + ecx - 1], al
	jmp 	end
found: ; gasit litera mare
	add 	ebx, eax
	add 	ebx, edi
	cmp 	ebx, 'Z'
	jg 		rotate_upper
	add 	eax, edi
	mov 	byte[edx + ecx - 1], al
	jmp 	end
rotate_upper:
	sub 	ebx, 'Z'
	dec 	ebx
	mov 	al, 'A'
	add 	eax, ebx
	cmp 	eax, 'Z' ; daca sare de 'Z' se reia rotate pana nu il mai depaseste
	jg 		actualizare_upper
	mov 	byte[edx + ecx - 1], al 
	jmp 	end
non_char: ; caracterul citit nu este litera
	mov 	byte[edx + ecx - 1], al
end:
	loop 	criptare
	;; END caesar cipher

    ;; DO NOT MODIFY
    popa
    leave
    ret
actualizare_lower:
	mov 	ebx, eax ; se actualizeaza ebx pentru litere mici
	jmp 	rotate_lower
actualizare_upper:
	mov 	ebx, eax ; se actualizaeaza ebx pentru litere mari
	jmp 	rotate_upper
    ;; DO NOT MODIFY
