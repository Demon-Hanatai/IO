; The IntToString procedure
; Expects: RAX = 64-bit integer (QWORD) to be converted
;          RCX = address of the buffer to store the string
; Returns: nothing, but the buffer at RCX will contain the ASCII string

PUBLIC IntToString

.code
IntToString PROC
    mov rdi, rcx            ; Move the buffer address to RDI
    mov rbx, rax            ; Copy the number to RBX for manipulation
    add rdi, 20             ; Assuming buffer is at least 20 bytes (max digits in a 64-bit number + null terminator)
    mov byte ptr [rdi], 0   ; Null-terminate the string
    mov r14,20
    ; Handle zero explicitly (special case)
    test rbx, rbx
    jnz convert_number
    dec rdi
    mov byte ptr [rdi], '0'
    jmp done

convert_number:
    ; Convert each digit to ASCII
    mov rcx, 10             ; Set divisor to 10
reverse_loop:
    xor rdx, rdx            ; Clear RDX before division to avoid overflow
    div rcx                 ; Divide RBX by 10, result in RAX, remainder in RDX
    add dl, '0'             ; Convert the remainder to ASCII
    dec rdi                 ; Move back in the buffer
    dec r14
    mov [rdi], dl           ; Store the ASCII character
    cmp r14, 0h           ; Check if RBX is zero
    jnz reverse_loop        ; If not, keep processing
    jmp done

done:
    ret

IntToString ENDP
END
