%include "io.mac"

section .bss
    length: resd 1
    hexa_length: resd 1

section .data
    hexa db '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length
    ;; DO NOT MODIFY

    ;; Implement bin to hex
start_bin_to_hex:
    mov 	[length], ecx
    xor 	eax, eax
    xor 	ebx, ebx
	;; determinare lungimea cuvantului in hexa
    mov 	ax, word[length]
    mov 	cl, 4
    div 	cl
    mov 	bl, al
    cmp 	ah, 0
    je 		actualizare_ebx
back:
    mov 	[hexa_length], ebx
    mov 	ecx, [length]
    xor 	eax, eax
loop_bintohex: ;; se extrag cate 4 biti si sunt convertiti la hexa
    ;; contor pentru a numara cei 4 biti
    xor 	edi, edi
    mov 	al, byte[esi + ecx - 1]
    sub 	al, '0'
    add 	edi, eax
    dec 	ecx
    cmp 	ecx, 0
    je 		adaugare_ultim_caracter

    mov 	al, byte[esi + ecx - 1]
    sub 	al, '0'
    shl 	al, 1
    add 	edi, eax
    dec 	ecx
    cmp 	ecx, 0
    je 		adaugare_ultim_caracter

    mov 	al, byte[esi + ecx - 1]
    sub 	al, '0'
    shl 	al, 2
    add 	edi, eax
    dec 	ecx
    cmp 	ecx, 0
    je 		adaugare_ultim_caracter

    mov 	al, byte[esi + ecx - 1]
    sub 	al, '0'
    shl 	al, 3
    add 	edi, eax
    dec 	ecx

    mov 	al, byte[hexa + edi]
    mov 	byte[edx + ebx], al
    dec 	ebx
    
    cmp 	ecx, 0
    jg 		loop_bintohex
    jmp 	end
    ;; END bin to hex
    ;; DO NOT MODIFY
adaugare_ultim_caracter: ;; in vaz ca lungimea nu este multiplu de 4
    mov 	al, byte[hexa + edi]
    mov 	byte[edx + ebx], al
end:
    mov 	ebx, [hexa_length]
    inc 	ebx
    mov 	byte[edx + ebx], 0x0A ;; se pune un '\n'
    popa
    leave
    ret
    ;; DO NOT MODIFY
actualizare_ebx:
    dec 	ebx
    jmp 	back
