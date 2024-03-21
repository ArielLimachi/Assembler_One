; this short program for emu8086 shows how to keep constant temperature
; using heater and thermometer (between 60° to 80°),
; it is assumed that air temperature is lower 60°.
 
; thermometer.exe is started automatically from c:\emu8086\devices.
; it is also accessible from the "virtual devices" menu of the emulator.
 
#start=thermometer.exe#
 
; temperature rises fast, thus emulator should be set to run at the maximum speed.
 
; if closed, the thermometer window can be re-opened from emulator's "virtual devices" menu.
 
#make_bin#

name "thermo"

TEMP_LOW     equ 60
TEMP_HIGH    equ 80
PORT_THERMO  equ 125
PORT_HEATER  equ 127
ERROR_FLAG   equ 1;

start:
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
    jmp turnHeaterOn  ; If temperature exceeds 80°, turn on heater

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

