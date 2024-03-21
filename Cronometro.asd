; Integrantes: Luis Espinoza, Ignacion Villaruel, Josue Prado 
; Tercer Cambio: Hacer un Cronometro por consola

    org 100h

; Definir el valor inicial de la hora
mov ch, 23  ; Horas (0-23)
mov cl, 59  ; Minutos (0-59)
mov dh, 58  ; Segundos (0-59)

start:
    ; Imprimir horas
    xor ax, ax      ; AX = 0
    mov al, ch      ; AL = horas
    call print_decimal

    mov ah, 2
    mov dl, ':' 
    int 21h

    ; Imprimir minutos
    xor ax, ax      ; AX = 0
    mov al, cl  
    call print_decimal

    mov ah, 2
    mov dl, ':' 
    int 21h

    ; Imprimir segundos
    xor ax, ax      ; AX = 0
    mov al, dh      ; AL = segundos
    call print_decimal

    ; Leer entrada del teclado
    mov ah, 0
    int 16h
    cmp al, 13      ; Si se presiona Enter (13 es el código ASCII para Enter)
    jne continue    ; Si no, continuar mostrando el reloj

    ; Salir del programa si se presiona Enter
    mov ah, 4Ch     ; Función de salida del programa
    int 21h

    continue:
    mov ah, 2
    mov dl, 13    
    int 21h
    mov dl, 10    
    int 21h

    ; Incrementar los segundos
    inc dh
    cmp dh, 60      ; Si dh >= 60
    jne skip_minute 
    mov dh, 0       
    inc cl          

    skip_minute:
    cmp cl, 60      ; Si cl >= 60
    jne skip_hour   
    mov cl, 0       
    inc ch          

    skip_hour:
    cmp ch, 24      ; SI ch >= 24
    jne start       
    mov ch, 0       

    jmp start       ; Bucle infinito para actualizar el reloj

; Subrutina para imprimir un número decimal de 8 bits
print_decimal:
    push ax         
    push bx         
    push cx         
    push dx         

    mov cx, 0       
    mov bx, 10      

loop_divide:
    mov dx, 0       
    div bx          ; AX = DX:AX / BX, DX = DX:AX % BX
    push dx         
    inc cx          
    cmp ax, 0       
    jnz loop_divide 

loop_print:
    pop dx          
    add dl, 30h     ; Convertir a ASCII
    mov ah, 2       
    int 21h         
    loop loop_print 

    pop dx          
    pop cx          
    pop bx          
    pop ax          
    ret             

