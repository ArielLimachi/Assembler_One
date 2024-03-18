name "flags"

org 100h

;Author:
; - Samuel Escalera Herrera
; - Diego Hernan Figueroa
; - Santiago Caballero
; Orginal: Comparing one number by five
; Change: Compare two numbers with each other
game:  mov dx, offset msg1
       mov ah, 9
       int 21h
       
       mov ah, 1 
       int 21h

       cmp al, '0'
       jb stop

       cmp al, '9'
       ja stop
       
       mov bl, al
             
       mov dx, offset msg1
       mov ah, 9
       int 21h

       mov ah, 1 
       int 21h 
       
       cmp al, bl
       jb below
       ja above
       mov dx, offset equal
       jmp print
below: mov dx, offset below     
       jmp print
above: mov dx, offset above
print: mov ah, 9
       int 21h
       jmp game  ; loop.


stop: ret  ; stop


msg1 db "enter the first number or any other character to exit:  $"
msg2 db "enter the second number or any other character to exit:  $"
equal db " is equal!", 0Dh,0Ah, "$"
below_numers db " is below!" , 0Dh,0Ah, "$"
above_numbers db " is above!" , 0Dh,0Ah, "$"


