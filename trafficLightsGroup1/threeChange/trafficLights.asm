; controlling external device with 8086 microprocessor.
; realistic test for c:\emu8086\devices\Traffic_Lights.exe

name "traffic"   


#start=Traffic_Lights.exe#   
#start=LED_Display.exe#

mov ax, all_red
out 4, ax


mov si, offset situation


next:
mov ax, [si]
out 4, ax 
            
            
; Wait for 5 seconds
;mov cx, 4Ch ; CX = 5000 (high word of delay time)
;mov dx, 4B40h ; DX = 4B40 (low word of delay time)
;mov ah, 86h ; Call BIOS - Wait function
;int 15h     ; Wait for specified time
; interrupciones, para ejecutar una accion en base a lo que esta ah
mov ah, 1h 
int 21h     

; ah en 0.
mov ah, 0  
mov bx, ax 

; 
; Convert ASCII character to situation index         
;0 es 30, esta restando
sub bx, '0' ; Convert ASCII character to integer     
; al tiene el caracter de consola, pero ahora tiene el valor de bl, restas 30
mov al, bl  ; bl esta el 4,
shl bx, 1   ;  

cmp al, 1
je primerCaso  ; saltar si es igual ...
                
cmp al, 2
je segundoCaso
                
cmp al, 3
je tercerCaso

cmp al, 4
je cuartoCaso

cmp al, 5
je quintoCaso
                
continue:
                
; Calculate the address of the selected situation
lea di, [situation] ; Load address of the situation array
add di, bx   ; Add the offset to get the address of the selected situation

mov si, di 
jmp next  

primerCaso:
    mov ax, 10000
    out 199, ax
    jmp continue 
    
segundoCaso:
    mov ax, 01000
    out 199, ax
    jmp continue    
    
tercerCaso:
    mov ax, 00100
    out 199, ax
    jmp continue
    
    
cuartoCaso:
    mov ax, 00010
    out 199, ax
    jmp continue    
    
        
quintoCaso:
    mov ax, 00001
    out 199, ax
    jmp continue    
    
;                        FEDC_BA98_7654_3210
situation        dw      0000_0011_0000_1100b
s1               dw      0000_0010_0100_1001b 
s2               dw      0000_0100_1001_0010b
s3               dw      0000_1001_0010_0100b
s4               dw      0000_1001_0000_1001b
s5               dw      0000_0010_0110_0100b
sit_end = $


all_red          equ     0000_0010_0100_1001b