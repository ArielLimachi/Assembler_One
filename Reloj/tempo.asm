; Integrantes: Luis Espinoza, Ignacion Villaruel, Josue Prado 
; Tercer Cambio: Hacer un temporizador por consola


org 100h

mov cl, 2   
mov dh, 5   

timer_start:
    xor ax, ax      
    mov al, cl      
    call print_decimal

    mov ah, 2
    mov dl, ':'     
    int 21h
    
    xor ax, ax      
    mov al, dh      
    call print_decimal

    mov ah, 2
    mov dl, 13      
    int 21h
    mov dl, 10      
    int 21h
 
    dec dh
    jns timer_continue 
  
    dec cl
    jns reset_seconds 

    jmp end_timer   

reset_seconds:
    mov dh, 59      
    jmp timer_continue

timer_continue:
    jmp timer_start 

end_timer:
    mov ah, 9
    lea dx, [msg_end] 
    int 21h

    mov ah, 4Ch
    int 21h

print_decimal:
    push ax         
    push bx         
    push cx         
    push dx         

    mov cx, 0       
    mov bx, 10      

loop_divide:
    mov dx, 0       
    div bx          
    push dx         
    inc cx          
    cmp ax, 0       
    jnz loop_divide 

loop_print:
    pop dx          
    add dl, 30h     
    mov ah, 2       
    int 21h         
    loop loop_print 

    pop dx          
    pop cx          
    pop bx          
    pop ax          
    ret             

msg_end db 'Fin del temporizador.', 13, 10, '$'  

ret
