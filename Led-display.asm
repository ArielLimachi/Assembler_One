; Integrantes: Luis Espinoza, Ignacion Villaruel, Josue Prado 
; Primer Cambio: Pedir por consola un numero y mostrar los multiplos del mismo en el led


; Leer un número desde la consola
mov ah, 1
int 21h

; Almacenar el caracter en una variable
mov dl, al

; Convertir el caracter a un valor numérico
sub dl, '0'

; Almacenar el valor numérico en AX
mov ax, dx

; Iniciar desde el valor ingresado
jmp x1

x1:
  out 199, ax  
  add ax, dx
jmp x1

hlt