.model small
.stack 100h

#start=stepper_motor.exe#

.data
    prompt db 'Seleccione una opcion: $'
    option1 db '1. Realizar una rotacion de medio paso en sentido horario$'
    option2 db '2. Realizar una rotacion de medio paso en sentido anti-horario$'
    option3 db '3. Realizar una rotacion de un paso en sentido horario$'
    option4 db '4. Realizar una rotacion de un paso en sentido anti-horario$'
    newline db 13, 10, '$'

    ; half-step rotation:
    datcw    db 0000_0110b
             db 0000_0100b    
             db 0000_0011b
             db 0000_0010b
    
    ; bin data for counter-clock-wise
    ; half-step rotation:
    datccw   db 0000_0011b
             db 0000_0001b    
             db 0000_0110b
             db 0000_0010b
    
    
    ; bin data for clock-wise
    ; full-step rotation:
    datcw_fs db 0000_0001b
             db 0000_0011b    
             db 0000_0110b
             db 0000_0000b
    
    ; bin data for counter-clock-wise
    ; full-step rotation:
    datccw_fs db 0000_0100b
              db 0000_0110b    
              db 0000_0011b
              db 0000_0000b     

    buffer db ?          ; Buffer para la entrada del usuario


.code

main:
    mov ax, @data       ; Initialize data segment
    mov ds, ax 
       
    mov bx, offset datcw_fs ; start from clock-wise half-step.
    mov si, 0
    mov cx, 0 ; step counter

menu:
    ; Show menu prompt
    mov ah, 09h
    mov dx, offset prompt
    int 21h
    
    mov ah, 09h
    mov dx, offset newline
    int 21h

    ; Show options
    mov ah, 09h
    mov dx, offset option1
    int 21h

    mov ah, 09h
    mov dx, offset newline
    int 21h

    mov ah, 09h
    mov dx, offset option2
    int 21h

    mov ah, 09h
    mov dx, offset newline
    int 21h       
    
     mov ah, 09h
    mov dx, offset option3
    int 21h

    mov ah, 09h
    mov dx, offset newline
    int 21h

    mov ah, 09h
    mov dx, offset option4
    int 21h

    mov ah, 09h
    mov dx, offset newline
    int 21h

    ; Read user input
    mov ah, 01h
    int 21h

    ; Compare user input
    cmp al, '1'
    je option1_selected
    cmp al, '2'
    je option2_selected    
    cmp al, '3'
    je option3_selected
    cmp al, '4'
    je option4_selected

    ; Invalid option
    jmp menu

option1_selected:
    ; Move motor clockwise
    inc cx
    cmp cx, offset datccw_fs 
    
    mov ah, 09h
    mov dx, offset newline
    int 21h
    
    jmp menu

option2_selected:
    ; Move motor counter-clockwise
       
       
    mov ah, 09h
    mov dx, offset newline
    int 21h
       
    jmp menu


option3_selected:
    ; Move motor clockwise
    inc cx
    cmp cx, offset datccw_fs 
    
    mov ah, 09h
    mov dx, offset newline
    int 21h
    
    jmp menu

option4_selected:
    ; Move motor counter-clockwise
    
    mov ah, 09h
    mov dx, offset newline
    int 21h
    
    jmp menu