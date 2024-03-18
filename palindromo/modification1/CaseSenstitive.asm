name "pali"
org 100h

jmp start

m1:
s db 'OSo' 
s_size = $ - m1 
db 0Dh,0Ah,'$' 

start:
mov dx, offset s 
mov ah, 9
int 21h

lea di, s 
mov si, di 
add si, s_size 
dec si 

mov cx, s_size 
cmp cx, 1 ; Compara con 1
je is_palindrome ; Si es igual a 1, es un palindromo

shr cx, 1 ; Divide por 2

next_char:
    mov al, [di] ; Carga el carácter en al
    cmp al, ' ' ; Comprueba si es un espacio
    je increment_di ; Si es un espacio, incrementa di y vuelve al inicio del bucle
    mov bl, [si] ; Carga el carácter en bl
    cmp bl, ' '
    je decrement_si ; Si es un espacio, decrementa si y vuelve al inicio del bucle
    
    cmp al , 'A' ; Compara al con 'A'
    jb not_upper ; Si al es menor que 'A', salta a not_upper
    cmp al , 'Z' ; Compara al con 'Z'
    ja not_upper ; Si al es mayor que 'Z', salta a not_upper          
    add al , 32 ; Si al está entre 'A' y 'Z', lo convierte a minuscula sumando 32
    
not_upper:
    cmp bl , 'A'
    jb not_upper_b
    cmp bl , 'Z'
    ja not_upper_b
    add bl , 32
    
not_upper_b:
     cmp al , bl ; Compara los caracteres
     jne not_palindrome ; Si no son iguales, no es un palíndromo
increment_di:
     inc di ; Incrementa di
decrement_si:
     dec si ; Decrementa si
     
loop next_char ; Repite para todos los caracteres

is_palindrome:  
   mov ah, 9
   mov dx, offset msg1 ; Muestra el mensaje de que es un palindromo
   int 21h
jmp stop

not_palindrome:
   mov ah, 9
   mov dx, offset msg2 ; Muestra el mensaje de que no es un palindromo
   int 21h
stop:

mov ah, 0 
int 16h

ret

msg1 db "  ¡Si es un palindromo!$"
msg2 db "  ¡No es un palindromo!$"