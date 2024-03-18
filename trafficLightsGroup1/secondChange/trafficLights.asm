; controlling external device with 8086 microprocessor.
; realistic test for c:\emu8086\devices\Traffic_Lights.exe

#start=Traffic_Lights.exe#

name "traffic"   


mov ax, all_red
out 4, ax


mov si, offset situation


next:
mov ax, [si]
out 4, ax 

mov ah, 1h 
int 21h     

mov ah, 0  
mov bx, ax 

; Convert ASCII character to situation index
sub bx, '0'
shl bx, 1  

; Calculate the address of the selected situation
lea di, [situation]
add di, bx  

mov si, di 
jmp next  

;                        FEDC_BA98_7654_3210
situation        dw      0000_0011_0000_1100b
s1               dw      0000_0010_0100_1001b 
s2               dw      0000_0100_1001_0010b
s3               dw      0000_1001_0010_0100b
s4               dw      0000_1001_0000_1001b
s5               dw      0000_0010_0110_0100b
sit_end = $


all_red          equ     0000_0010_0100_1001b
