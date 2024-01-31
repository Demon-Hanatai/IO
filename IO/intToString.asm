; The IntToString procedure
; Expects: RAX = 64-bit integer (QWORD) to be converted
;          RCX = address of the buffer to store the string
; Returns: nothing, but the buffer at RCX will contain the ASCII string

PUBLIC IntToString

.code
IntToString PROC
    mov rdi, rcx            
    mov rbx, rax           
    add rdi, 20             
    mov byte ptr [rdi], 0   
    mov r14,20
    ; Handle zero explicitly (special case)
    test rbx, rbx
    jnz convert_number
    dec rdi
    mov byte ptr [rdi], '0'
    jmp done

convert_number:
    
    mov rcx, 10           
reverse_loop:
    xor rdx, rdx            
    div rcx               
    add dl, '0'            
    dec rdi               
    dec r14
    mov [rdi], dl          
    cmp r14, 0h          
    jnz reverse_loop        
    jmp done

done:
    ret

IntToString ENDP
END
