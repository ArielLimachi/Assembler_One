org 100h

mov ax, 3
int 10h  

mov ax, 1003h
mov bx, 0
int 10h

mov     ax, 0b800h
mov     ds, ax

mov [02h], 'V'
mov [04h], 'i'
mov [06h], 'v'
mov [08h], 'a'
mov [0ah], ' '
mov [0ch], 'B'
mov [0eh], 'o'
mov [10h], 'l'
mov [12h], 'i'
mov [14h], 'v'
mov [16h], 'i'
mov [18h], 'a'
mov [1ah], '!'


mov cx, 4
mov di, 03h                                          

r:  mov [di], 01000000b   
    add di, 2 
    loop r
    
mov cx, 5
mov di, 0bh 

a:  mov [di], 11100000b   
    add di, 2 
    loop a
    
mov cx, 4
mov di, 15h

v:  mov [di], 00100000b   
    add di, 2
    loop v
    
mov ah, 0
int 16h

ret