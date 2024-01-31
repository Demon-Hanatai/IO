; The StringToInt64 procedure
; Expects: RCX = address of the ASCII string
; Returns: RAX = the 64-bit integer value

PUBLIC StringToInt64

.code
StringToInt64 PROC
   
    mov r8, rcx           
    xor rax, rax           

convert_loop:
    movzx rcx, byte ptr [r8]
    test rcx, rcx
    jz conversion_done
    sub rcx, '0'
    imul rax, rax, 10
    add rax, rcx
    inc r8
    jmp convert_loop

conversion_done:
    ret

StringToInt64 ENDP
END
