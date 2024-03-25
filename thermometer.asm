; this short program for emu8086 shows how to keep constant temperature
; using heater and thermometer (between 60? to 80?),
; it is assumed that air temperature is lower 60?.
 
; thermometer.exe is started automatically from c:\emu8086\devices.
; it is also accessible from the "virtual devices" menu of the emulator.
 
#start=thermometer.exe#
 
; temperature rises fast, thus emulator should be set to run at the maximum speed.
 
; if closed, the thermometer window can be re-opened from emulator's "virtual devices" menu.
 
#make_bin#

name "thermo"

start:
     mov ah,01h
     int 21h  
     sub al,30h
     mov byte1[0],al
         
     mov ah,01h
     int 21h
     cmp al,13
     je suma
     sub al,30h 
     mov byte2[0],al 
     
     mov ah,01h
     int 21h
     cmp al,13
     je suma               
     sub al,30h
     mov byte3[0],al
        
     mov dl,0
     suma:    
     operar_con_unidad_low:
     cmp byte2[0],0
     jne operar_con_decena_low
     add dl,byte1[0]
     jmp  asignar_temp_low
     
     
     operar_con_decena_low:
     cmp byte3[0],0
     jne operar_con_centena_low
     mov ax,0
     mov al,byte1[0]
     mov bl,10
     mul bl
     add al,byte2[0]  
     mov dl,al
     jmp asignar_temp_low
      
     
     operar_con_centena_low:
     mov ax,0
     mov al,byte1[0]
     mov bl,100
     mul bl
     mov dl,al
     mov al,byte2[0]
     mov bl,10
     mul bl
     add dl,al
     add dl,byte3[0]  
     jmp asignar_temp_low
     
     asignar_temp_low:
     mov TEMP_LOW[0], dl
     
     mov ah,01h
     int 21h  
     sub al,30h
     mov byte1[0],al
         
     mov ah,01h
     int 21h
     cmp al,13
     je suma2
     sub al,30h 
     mov byte2[0],al 
     
     mov ah,01h
     int 21h
     cmp al,13
     je suma2              
     sub al,30h
     mov byte3[0],al
        
     
     suma2:    
     operar_con_unidad_high:
     mov dl,0
     cmp byte2[0],0
     jne operar_con_decena_high
     add dl,byte1[0]
     jmp  asignar_temp_high
     
     
     operar_con_decena_high:
     cmp byte3[0],0
     jne operar_con_centena_high
     mov ax,0
     mov al,byte1[0]
     mov bl,10
     mul bl
     add al,byte2[0]  
     mov dl,al
     jmp asignar_temp_high
      
     
     operar_con_centena_high:
     mov ax,0
     mov al,byte1[0]
     mov bl,100
     mul bl
     mov dl,al
     mov al,byte2[0]
     mov bl,10
     mul bl
     add dl,al
     add dl,byte3[0]  
     jmp asignar_temp_high
     
     asignar_temp_high:
     mov TEMP_HIGH[0], dl  
     
    ; Read temperature from thermometer
    in al, PORT_THERMO
    
    ; Check for I/O error (assuming failed read sets Carry flag)
    jc error_handler
    
    ; Check for valid temperature range (0-127 is a common assumption)
    cmp al, 0
    jl error_handler
    cmp al, 127
    jg error_handler
    
    ; Compare temperature
    cmp al, TEMP_LOW
    jl  turnHeaterOn

    cmp al, TEMP_HIGH
    jle turnHeaterOff
    jmp turnHeaterOn  ; If temperature exceeds 80?, turn on heater

turnHeaterOn:
    mov al, 1
    out PORT_HEATER, al   ; Turn heater on
    jmp continue

 
turnHeaterOff:
    mov al, 0
    out PORT_HEATER, al   ; Turn heater off
 

continue:
    jmp start   ; Endless loop


error_handler:
    mov al, ERROR_FLAG  ; Error flag
    jmp continue


TEMP_LOW     db 0
TEMP_HIGH    db 0;reservo 100 bites y lo q no use son "?
PORT_THERMO  equ 125
PORT_HEATER  equ 127
ERROR_FLAG   equ 1;   
byte1 db 0
byte2 db 0
byte3 db 0
