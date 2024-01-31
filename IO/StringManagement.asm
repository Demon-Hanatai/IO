;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Console ManageMent;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

EXTRN AllocConsole:PROC
EXTRN AttachConsole:PROC
PUBLIC CreateNewConsole ;Making the Function CreateNewConsole be access from other files

.code
  CreateNewConsole PROC
    call AllocConsole
    test rax,rax 
    jz failed
    mov rax,0

    failed:
      mov rax,1
      ret
  CreateNewConsole ENDP

  JoinConsole PROC
    local procid:qword
    mov procid,rax
    cmp procid,0
    jle InvaildProid
    sub rsp,500
    call AttachConsole
    add rsp,500
    test rax,rax
    jz InvaildProid
    mov rax,0
    ret


    InvaildProid:
     mov rax,1
     ret
  JoinConsole ENDP
END