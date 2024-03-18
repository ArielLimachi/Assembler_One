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

; wait 5 seconds (5 million microseconds)
mov     cx, 1Ch    ;    004C4B40h = 5,000,000
mov     dx, 4B40h
mov     ah, 86h
int     15h


add si, 2 ; next situation
cmp si, sit_end
jb  next
mov si, offset situation
jmp next


;                        FEDC_BA98_7654_3210
situation        dw      0000_0000_0000_0001b
s1               dw      0000_0000_0000_0001b
s2               dw      0000_0000_0000_0010b
s3               dw      0000_0000_0000_0100b
s4               dw      0000_0000_0000_1000b
s5               dw      0000_0000_0001_0000b
s6               dw      0000_0000_0010_0000b
s7               dw      0000_0000_0100_0000b
s8               dw      0000_0000_1000_0000b
s9               dw      0000_0001_0000_0000b
s10               dw      0000_0010_0000_0000b
s11              dw      0000_0100_0000_0000b
s12              dw      0000_1000_0000_0000b  
sit_end = $


all_red          equ     0000_0010_0100_1001b           




