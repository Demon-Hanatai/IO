includelib Kernel32.lib
EXTRN GetStdHandle:PROC
EXTRN WriteConsoleA:PROC
EXTRN ReadConsoleA:PROC
EXTRN GetLength:PROC
EXTRN SetConsoleTitleA:PROC
PUBLIC WriteConsole
PUBLIC ReadLine
CONSOLE_READCONSOLE_CONTROL STRUCT 
   nLenght qword SIZEOF CONSOLE_READCONSOLE_CONTROL
   nInitialChars qword 0
   dwCtrlWakeupMask qword 0
   dwControlKeyState qword 0
CONSOLE_READCONSOLE_CONTROL ENDS
PUBLIC WriteConsole
PUBLIC ReadLine
PUBLIC ChangeCTitle
.data
   LastInput qword 0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,
                   0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0h,0
  _HWND QWORD 0h
   LastInputInfo CONSOLE_READCONSOLE_CONTROL <>
.code
WriteConsole PROC 
 local lptext:qword
 mov lptext,rcx
 sub rsp, 30
 push rcx
 push rax
 mov rcx, qword ptr lptext
 push rcx
 call GetLength
 mov r8, rax
 pop rcx
 mov rcx, -11
 call GetStdHandle
 mov rcx, rax
 mov rdx, qword ptr lptext
 mov r9, 0
 call WriteConsoleA
 pop rcx
 pop rax
 add rsp, 30
 ret
WriteConsole ENDP

ReadLine proc
    mov rcx,-10
    Call GetStdHandle
    mov [_HWND],rax
    mov rcx,[_HWND]
    lea rdx,[LastInput]
    mov r8,15
    lea r9, [LastInput+178h]
    lea rax,LastInputInfo
    push rax
    call ReadConsoleA
    cmp rax,1
    jnz failed
    mov r12,qword ptr [LastInput+178h]
    mov [LastInput+r12],00h
    pop rax
    lea rax,LastInput
    
    ret
    
    failed:
     pop rax
     ret

ReadLine endp
ChangeCTitle proc 
  call SetConsoleTitleA
  ret

ChangeCTitle endp
END 