%include "io.mac"

section .bss
	haystack_len: resd 1
	needle_len: resd 1
	aux_ecx: resd 1

section .text
    global my_strstr
    extern printf

my_strstr:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     ecx, [ebp + 20]     ; haystack_len
    mov     edx, [ebp + 24]     ; needle_len
    ;; DO NOT MODIFY
    ;; TO DO: Implement my_strstr
start_strstr:
	xor 	eax, eax
	mov 	dword[haystack_len], ecx
	mov 	dword[needle_len], edx
	xor 	ecx, ecx ;; index pentru haystack
	xor 	edx, edx ;; index pentru needle

strstr:
	mov 	dword[aux_ecx], ecx
	mov 	al, byte[esi + ecx]
	mov 	cl, byte[ebx + edx]
	cmp 	al, cl
	jne 	loop
	mov 	ecx, dword[aux_ecx]
	mov 	[edi], ecx ;; se pune pozitia gasita a primului caracter in edi
egale: ;; se gaseste primul caracter identic in ambele siruri
	;; testare daca se gaseste substringul in string
	mov 	ecx, dword[aux_ecx]
	inc 	ecx
	inc 	edx
	mov 	dword[aux_ecx], ecx
	cmp 	edx, dword[needle_len]
	;; a fost gasit intregul substring si programul se termina
	je 		end
	mov 	al, byte[esi + ecx]
	mov 	cl, byte[ebx + edx]
	cmp 	al, cl
	je 		egale
	xor 	edx, edx ; se reseteaza edx pt ca nu a fost gasit intreg substringul
loop: ;; loop pentru while
	mov 	ecx, dword[aux_ecx]
	inc 	ecx
	cmp 	ecx, dword[haystack_len]
	jle 	strstr
not_found: ;;nu a fost gasit
	mov 	[edi], ecx
end: 
    ;; DO NOT MODIFY
	popa
    leave
    ret
    ;; DO NOT MODIFY
