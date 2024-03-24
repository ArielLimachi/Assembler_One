;Grupo: Ignacion Ruben, Josue Prado, Luis Espinoza


; this is an example of out instruction.
; it writes values to virtual i/o port
; that controls the stepper-motor.
; c:\emu8086\devices\stepper_motor.exe is on port 7

#start=stepper_motor.exe#
#start=led_display.exe#


name "stepper"

#make_bin#

steps_before_direction_change = 9 ; 32 (decimal)

jmp start

; ========= data ===============



; bin data for clock-wise
; full-step rotation:
datcw_fs db 0000_0001b
         db 0000_0011b    
         db 0000_0110b
         db 0000_0000b

; bin data for counter-clock-wise
; full-step rotation:
datccw_fs db 0000_0100b
          db 0000_0110b    
          db 0000_0011b
          db 0000_0000b


start:
mov bx, offset datcw_fs ; start from clock-wise half-step.
mov si, 0
mov cx, 0 ; step counter

next_step:
; motor sets top bit when it's ready to accept new command
wait:   in al, 7     
        test al, 10000000b
        jz wait

mov al, [bx][si]
out 7, al

inc si

cmp si, 4
jb next_step
mov si, 0

inc cx
cmp cx, steps_before_direction_change
jb  next_step

mov cx, 0
add bx, 4 ; next bin data

cmp bx, offset datccw_fs  
mov ax, 1
out 199, ax
jbe next_step

mov bx, offset datcw_fs ; return to clock-wise half-step.
mov ax, 2
out 199, ax
jmp next_step



