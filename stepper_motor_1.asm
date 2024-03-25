


; this is an example of out instruction.
; it writes values to virtual i/o port
; that controls the stepper-motor.
; c:\emu8086\devices\stepper_motor.exe is on port 7

#start=stepper_motor.exe#
#start=LED_Display.exe#


name "stepper"

#make_bin#

steps_before_direction_change = 8h ; 32 (decimal)


; ========= data ===============

; bin data for clock-wise
; half-step rotation:
datcw    db 0000_0110b
         db 0000_0100b    
         db 0000_0011b
         db 0000_0010b

; bin data for counter-clock-wise
; half-step rotation:
datccw   db 0000_0011b
         db 0000_0001b    
         db 0000_0110b
         db 0000_0010b


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

jmp menu

mov bx, offset datcw_fs ; start from clock-wise half-step.
mov si, 0
mov cx, 0 ; step counter

menu:
    mov ah, 09h               
    mov dx, offset menu_message    
    int 21h                   
    
    call get_steps
     
    mov ah, 09h               
    mov dx, offset control_message    
    int 21h
     
    mov ah, 01h  
    int 21h              
    cmp al, 'y' 
    je control_menu
    cmp al, 'n'
    je next_step

a_call:
   wait_a:   in al, 7      
          test al, 10000000b
          jz wait_a

          mov al, [bx][si]
          out 7, al
          
          inc si
          
          cmp si, 4
          jb a_call
          mov si, 0
          
          inc cx
          cmp cx, steps_before_direction_change 
          jb control_menu
          
          mov cx, 0
          add bx, 4 ; next bin data
          
          cmp bx, offset datcw    
          mov ax, 00100
          out 199, ax 
          je control_menu


b_call:   
   wait_b:   in al, 7  
          test al, 10000000b
          jz wait_b

          mov al, [bx][si]
          out 7, al
          
          inc si
          
          cmp si, 4
          jb b_call
          mov si, 0
          
          inc cx
          cmp cx, steps_before_direction_change 
          jb control_menu
          
          mov cx, 0
          add bx, 4
          
          cmp bx, offset datccw    
          mov ax, 01000
          out 199, ax 
          je control_menu 
          
c_call: 
      wait_c:   in al, 7    
          test al, 10000000b
          jz wait_c

          mov al, [bx][si]
          out 7, al
          
          inc si
          
          cmp si, 4
          jb c_call
          mov si, 0
          
          inc cx
          cmp cx, steps_before_direction_change 
          jb control_menu
          
          mov cx, 0
          add bx, 4
          
          cmp bx, offset datcw_fs    
          mov ax, 00001
          out 199, ax 
          je control_menu 
          
d_call: 
   wait_d:   in al, 7    
          test al, 10000000b
          jz wait_d

          mov al, [bx][si]
          out 7, al
          
          inc si
          
          cmp si, 4
          jb d_call
          mov si, 0
          
          inc cx
          cmp cx, steps_before_direction_change 
          jb control_menu
          
          mov cx, 0
          add bx, 4
          
          cmp bx, offset datccw_fs    
          mov ax, 00001
          out 199, ax 
          je control_menu                   

control_menu:
    mov ah, 09h               
    mov dx, offset control_menu_message    
    int 21h   
    
    mov ah, 01h  
    int 21h
    
    cmp al, 'a' 
    je a_call
      
    cmp al, 'b' 
    je b_call
       
    cmp al, 'c' 
    je c_call 
    
    cmp al, 'o' 
    je d_call 
    
    je control_menu
         
      


get_steps:
    mov ah, 09h               ; Función 09h - Escribir cadena de caracteres en la pantalla
    mov dx, offset steps_message    ; Dirección del mensaje a mostrar
    int 21h                   ; Llama a la interrupción para mostrar el mensaje
    mov ah, 01h               ; Función 01h - Leer un carácter desde STDIN
    int 21h                   ; Espera hasta que se presiona una tecla
    sub al, 30h               ; Convertir el carácter ASCII a su valor numérico
    mov steps_before_direction_change, al  ; Almacenar el valor ingresado en steps_before_direction_change 
    ret 
    

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
mov ax, 00001
out 199, ax
jbe next_step

mov bx, offset datcw_fs 
mov ax, 00010
out 199, ax
jmp next_step
                                                
menu_message db 'STEPPER MOTOR MENU: ', 0Dh, 0Ah, '$'
control_message db 0Ah, 'Do you want to control the stepper motor (y/n): ', 0Dh, 0Ah, '$' 
control_menu_message db 0Ah, 'Write: ', 0Ah, 'a: to clock-wise half step rotation', 0Ah, 'b: to counter-clock-wise half step rotation', 0Ah, 'c: to clock-wise full step rotation', 0Ah, 'd: to counter-clock-wise full step rotation', 0Dh, 0Ah, '$'
steps_message db 'Introduce the number of steps: ', 0Dh, 0Ah, '$'


