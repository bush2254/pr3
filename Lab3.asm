; multi-segment executable file template.

data segment
    ; add your data here!   
    A DB ? 
    X DB ? 
    Y Dw ? 
    Y1 Db ? 
    Y2 Dw ? 
    PERENOS DB 13,10,"$" 
    VVOD_A DB 13,10,"Enter A=$" 
    VVOD_X DB 13,10,"Enter X=$",13,10 
    VIVOD_Y DB "Result Y=$" 
    pkey db "press any key...$" 
ends

code segment
start:
    ; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    
    XOR AX,AX
    MOV DX, OFFSET VVOD_A
    MOV AH, 9
    INT 21H
    
    METKA1:
    MOV AH, 1
    INT 21H
    CMP AL, "-"
    JNZ METKA2
    MOV BX, 1
    JMP METKA1
    
    METKA2:
    SUB AL, 30H
    TEST BX, BX
    JZ METKA3
    NEG AL
    
    METKA3:
    MOV A, AL
    XOR AX, AX
    XOR BX, BX
    MOV DX, OFFSET VVOD_X
    MOV AH, 9
    INT 21H
    
    METKA4:
    MOV AH, 1h
    INT 21H
    CMP AL, "-"
    JNZ METKA5
    MOV BX, 1
    JMP METKA4
    
    METKA5:
    SUB AL, 30H
    TEST BX, BX
    JZ METKA6
    NEG AL
    
    METKA6:
    MOV X, AL
    MOV AL, A
    ; GET Y1
    MOV Cl, 0h
    MOV Dl, X
    CMP Cl, Dl
    JG  @LEFT1
    Sub Dl,AL
    JMP @RETURN1
    @LEFT1:
    MOV Dl, X
    Neg Dl       
    @RETURN1: 
    MOV Y1, Dl
    ; GET Y2
     mov aX,0
    MOV Al,X      
    Mov bh,3h
    div Bh  
    CMP ah,1 
    JZ Ah,1 @LEFT2    
   Mov Al,7
    JMP @RETURN2
    @LEFT2:
    Mov Ah,A
    Add Ah,X
    Mov al,0 
    Mov al,ah
    @RETURN2:
    MOV Y2, Ax
    ; GET Y
    MOV AH, 0
    MOV AL, Y1
    CBW
    MOV CX, Y2
    Sub AX, CX
    MOV Y, AX
    
    MOV DX, OFFSET PERENOS
    XOR AX, AX
    MOV AH, 9
    INT 21H
    
    MOV DX, OFFSET VIVOD_Y
    MOV AH, 9
    INT 21H
    MOV CX, Y
    CMP Y, 0
    JGE METKA7
    NEG CX
    MOV BX, CX
    MOV DL, "-"
    MOV AH, 2
    INT 21H
    MOV DX, BX
    ADD DX, 30H
    INT 21H
    JMP METKA8
    
    METKA7:
    MOV DX, Y
    ADD DX, 30H
    MOV AH, 2H
    INT 21H
    
    METKA8:
    MOV DX, OFFSET PERENOS
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    
    MOV AX, 4C00H
    INT 21H
end start  ; set entry point and stop the assembler.