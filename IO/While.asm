
PUBLIC WhileF

.code    
  WhileF PROC 
   Local Condition:qword
   Local Value:qword
   Local Function:qword
   mov Condition,rcx
   mov Value,rdx
   mov Function,r8
   @loop:
   call Function
   mov r8, Condition
   mov rax,qword ptr [r8]
   cmp rax,Value
   je Exit
   jmp @loop
   Exit:ret
  
  WhileF ENDP
  
END