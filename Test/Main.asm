includelib 	Shlwapi.lib ;--> https://learn.microsoft.com/en-us/windows/win32/api/shlwapi/nf-shlwapi-strtointw
EXTRN WriteConsole:PROC
EXTRN WhileF:PROC
EXTRN ReadLine:PROC
EXTRN ExitProcess:PROC
EXTRN GetLength:PROC
EXTRN StringToInt64:PROC
EXTRN IntToString:PROC
.data
 LocalStorage qword 20 DUP(?)

.const
 EnterNumberMessage BYTE "Enter a number: ",0
 EnterSecondNumberMessage BYTE "Enter a Second Number: ",0
 InvaildInputMessage BYTE "Invaild Input Sorry < 3!",13,10,0
.code
Main PROC
 lea rcx,EnterNumberMessage
 call WriteConsole
 Call ReadLine
 lea rdi, LocalStorage
 mov rsi,rax
 mov rcx,rax
 call GetLength
 sub rax,2
 mov rcx,rax
 rep movsb
 lea rcx,LocalStorage
 call StringToInt64
 test rax,rax
 jz InvaildInput
 mov qword ptr [LocalStorage],rax
 lea rcx,EnterSecondNumberMessage
 call WriteConsole
 Call ReadLine
 lea rdi, LocalStorage + 8 ;8 Bytes forward
 mov rsi,rax
 mov rcx,rax
 call GetLength
 sub rax,2
 mov rcx,rax
 rep movsb
 mov rcx,OFFSET [LocalStorage +  8] ;8 Bytes forward
 call StringToInt64
 test rax,rax
 jz InvaildInput
 mov qword ptr [LocalStorage+8],rax
 ;;;Addition Starts here
 mov qword ptr [LocalStorage+8 * 20 - 8],0h
 mov rax, qword ptr [LocalStorage]
add rax, qword ptr [LocalStorage+8]
mov qword ptr [LocalStorage + 16], rax   ; Store the result in the buffer
mov rcx, OFFSET [LocalStorage + 16]      ; Pass the address of the result
call IntToString      

mov rcx,OFFSET [LocalStorage+ 8 * 2]
 call WriteConsole
 jmp ExitProcess
 ;;ExitProgram
 ExitProgram:
   mov rcx,0
   call ExitProcess

 InvaildInput:
  lea rcx,InvaildInputMessage
  call WriteConsole
  jmp Main
  

 
Main ENDP





END