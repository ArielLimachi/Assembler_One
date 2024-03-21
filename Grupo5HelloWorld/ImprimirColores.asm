org 100h

inicio:

    ; Mostrar mensaje para ingresar un número
    mov dx, offset msg
    mov ah, 9
    int 21h

    ; Solicitar número al usuario
    mov ah, 1
    int 21h
    sub al, 30h  ; Convertir el valor ASCII ingresado a un número decimal

    ; Realizar la selección de color según el número ingresado
    cmp al, 1
    je rojo
    cmp al, 2
    je amarillo
    cmp al, 3
    je verde

    ; Si el número ingresado no coincide con ninguna opción, volver a pedir la entrada
    jmp inicio

rojo:
    mov ax, 0600h
    mov bh, 47h
    mov cx, 0100h
    mov dx, 034fh
    int 10h

    ; Actualizar posición de la pantalla para el siguiente mensaje
    mov dx, offset siguiente_pos
    mov ah, 9
    int 21h

    jmp inicio

amarillo:
    mov ax, 0600h
    mov bh, 60h
    mov cx, 0400h
    mov dx, 074fh
    int 10h

    ; Actualizar posición de la pantalla para el siguiente mensaje
    mov dx, offset siguiente_pos
    mov ah, 9
    int 21h

    jmp inicio

verde:
    mov ax, 0600h
    mov bh, 2Eh
    mov cx, 0800h
    mov dx, 0b4fh
    int 10h

    ; Actualizar posición de la pantalla para el siguiente mensaje
    mov dx, offset siguiente_pos
    mov ah, 9
    int 21h

    jmp inicio

siguiente_pos:
    ; Posición de la pantalla para el siguiente mensaje
    mov dl, 0+1    ; Columna 0
    mov dh, 0+1   ; Fila 0
    ret

msg db "Ingrese un número (1 - rojo, 2 - amarillo, 3 - verde)", 0Dh, 0Ah, '$'

fin:
    mov ax, 4C00h
    int 21h
    ret