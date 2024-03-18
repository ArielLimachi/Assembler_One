;- Samuel Escalera Herrera
;- Diego Figueroa Sevillanos
;- Santiago Caballero
;Cambio: Basic Calculator
org 100h   


include 'emu8086.inc'
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS

jmp inicio 


texto db 13,10,13,10,'Digite el Primer Numero: $'
texto2 db 13,10,13,10,'Digite el Segundo Numero: $'
texto3 db 13,10,13,10, 'La Suma Es: $'
texto4 db 13,10,'La Resta Es: $'
texto5 db 13,10,'La Multiplicacion Es: $'
texto6 db 13,10,'La Dision es: $'

num1 dw ? 
num2 dw ? 

inicio:

mov ah,09 
lea dx,texto 
int 21h

call SCAN_NUM 
mov num1,cx 

mov ah,09 
lea dx,texto2 
int 21h

call SCAN_NUM 
mov num2,cx 

mov ah,09
lea dx,texto3
int 21h

mov ax,num1 
add ax,num2 
call PRINT_NUM

mov ah,09
lea dx,texto4
int 21h
mov ax,num1 
sub ax,num2 
call PRINT_NUM



mov ah,09
lea dx,texto5
int 21h
mov ax,num1 
mov bx,num2 
mul bx 
call PRINT_NUM

mov ah,09
lea dx,texto6
int 21h
xor dx,dx 
mov ax,num1 
mov bx,num2 
div bx 
call PRINT_NUM


ret