title stepper_menu
include "emu8086.inc"      

#start=stepper_motor.exe#
#start=LED_Display.exe#

datos segment
    option db 2 dup(?)
    tamanio equ 2
    
    option_fs_right equ 'a'
    option_fs_left equ 'b'
    option_hf_right equ 'c'
    option_hf_left equ 'd'
    
    ; bin data for clock-wise
    ; half-step rotation:
    datcw db 0000_0110b
          db 0000_0100b    
          db 0000_0011b
          db 0000_0010b

    ; bin data for counter-clock-wise
    ; half-step rotation:
    datccw db 0000_0011b
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
              
    steps_before_direction_change = 8h ; 32 (decimal)              
    
    dat_selected db 4 dup(?)
    
    x db 0
    y db 0
datos ends

pila segment
    dw 64 dup(0)
pila ends       

codigo segment
    inicio proc far
        assume cs:codigo, ds:datos, ss:pila
        push ds
        mov ax, 0
        push ax
        
        mov ax, datos
        mov ds, ax
        mov es, ax
        
        ; CODE ------------------
              
        start:
        mov di, 0
        mov si, 0
        mov ax, 0
        mov bp, 0 
        
        call CLEAR_SCREEN
        
        GOTOXY x, y
        call PTHIS
        db '*******************************************', 0
        inc y
        
        GOTOXY x, y
        call PTHIS
        db '       MOTOR PASO A PASO', 0
        inc y
        
        GOTOXY x, y
        call PTHIS
        db '       Full Step Derecha (a)', 0
        inc y
        
        GOTOXY x, y
        call PTHIS
        db '       Full Step Izquierda (b)', 0
        inc y
        
        GOTOXY x, y
        call PTHIS
        db '       Half Step Derecha (c)', 0
        inc y
        
        GOTOXY x, y
        call PTHIS
        db '       Half Step Izquierda (d)', 0
        inc y
        
        GOTOXY x, y
        call PTHIS
        db '*******************************************', 0
        inc y

             
        GOTOXY x, y
        call PTHIS
        db ' >>> ', 0
        add x, 6
             
        GOTOXY x, y       
        
        lea si, option 
        mov dx, tamanio
        call GET_STRING
        
        mov cx, 39
        
        mov al, option[si]
        
        cmp al, option_fs_right
        je option_a
        
        cmp al, option_fs_left
        je option_b
        
        cmp al, option_hf_right
        je option_c
        
        jmp option_d
        
        option_a:
            lea si, datcw_fs
            lea di, dat_selected
            mov cx, 4
            rep movsb
            jmp start_stepper
            
        option_b:
            lea si, datccw_fs
            lea di, dat_selected
            mov cx, 4
            rep movsb
            jmp start_stepper
            
        option_c:
            lea si, datcw
            lea di, dat_selected
            mov cx, 4
            rep movsb
            jmp start_stepper
            
        option_d:
            lea si, datccw
            lea di, dat_selected
            mov cx, 4
            rep movsb
            jmp start_stepper
            
        start_stepper:
            mov bx, offset dat_selected
            mov si, 0
            mov cx, 0

            next_step:
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
            add bx, 4

            cmp bx, offset dat_selected    
            mov ax, 00001
            out 199, ax
            jbe next_step

            mov bx, offset dat_selected
            mov ax, 00010
            out 199, ax
            jmp next_step
        
        ret
    inicio endp   
    DEFINE_SCAN_NUM
    DEFINE_PRINT_STRING
    DEFINE_PRINT_NUM
    DEFINE_PRINT_NUM_UNS
    DEFINE_PTHIS
    DEFINE_CLEAR_SCREEN
    DEFINE_GET_STRING
 codigo ends         
 exit:
 END inicio