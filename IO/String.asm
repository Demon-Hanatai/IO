EXTRN CoTaskMemAlloc:PROC
PUBLIC StringConcatenation
PUBLIC GetLength
.code
StringConcatenation Proc 
 local lpstr1:qword
 local lpstr2:qword 
 mov lpstr1,rcx
 mov lpstr1,rdx
 push rbx
 push rcx
 mov rcx, lpstr1
 push rcx
 call GetLength
 mov rbx, rax
 mov rcx, lpstr2
 push rcx
 call GetLength
 mov rcx, rax
 mov r13, rcx
 mov rax, rbx
 add rax, rcx
 push rax
 mov r14, rcx
 mov rcx, rax
 pop rax
 call CoTaskMemAlloc
 mov rcx, r14
 mov r12, rax
 mov rax, 0
 mov r8, qword ptr lpstr1
 mov r9, qword ptr lpstr2
 mov r10, 0
 mov rdx, 0
 call MoveByteStr1
 ret

MoveByteStr2 :
 mov al, byte ptr[r8 + rdx]
 mov byte ptr[r12 + rdx], al
 cmp rbx, 0
 je MoveByteStr1
 inc rdx
 dec rbx
 jmp MoveByteStr2

MoveByteStr1 :
 mov al, byte ptr[r9 + r10]
 lea r11, [r12 + rdx]
 mov byte ptr[r11 + r10], al
 cmp rcx, 0
 je done
 inc r10
 dec rcx
 jmp MoveByteStr1


 done :
  pop rcx
  pop rbx
  mov rax, r12
  ret
StringConcatenation ENDP

GetLength proc lpStr:qword
 mov lpStr,rcx
 push rdx
 mov rdx, 0
 mov rsi, qword ptr lpStr
 cmp byte ptr[rsi], 0
 je NullStr
 call StartSearching
 pop rdx
 ret

StartSearching :
 cmp byte ptr[rsi + rdx], 00h
 je Lengthfound
 INC rdx
 jmp StartSearching


Lengthfound :
 mov rax, rdx
 pop rdx
 ret

NullStr :
 ret
GetLength ENDP
END