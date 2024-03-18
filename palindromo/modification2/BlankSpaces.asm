title palindromoconsole  
include "emu8086.inc"   

datos segment            
    buffer1 db 'Anita lava la Tina   ', 0 ; Define la cadena de texto directamente aquí.
    buffer2 db 40 dup(?)
    tamanio equ 40       
    size dw 0           
    
    null equ 0h          
    space equ 20h       
    
     x db 2             
    y db 1              
datos ends               

pila segment             
    dw 64 dup(0)        
pila ends                

codigo segment          
    inicio proc far      
        assume cs:codigo, ds:datos, ss:pila  ; Establece los segmentos de codigo, datos y pila.
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
        
        mov cx, 39        
        
        ; Inicializacion del tamano a 0 antes de copiar
        mov size, 0       
        
        ciclo_copiar:     
        mov al, buffer1[si] 
        cmp al, space     ; Compara el carácter actual con un espacio.
        je omitir_space   ; Si el caracter actual es un espacio, salta a la etiqueta omitir_space.
        cmp al, null      ; Compara el carácter actual con un caracter nulo.
        je verify         ; Si el caracter actual es un caracter nulo, salta a la etiqueta verify.

        ; Convertir a minúsculas
        ; Si 'A' <= al <= 'Z', entonces al = al + ('a' - 'A')
        cmp al, 'A'       
        jl next          
        cmp al, 'Z'       
        jg next           
        add al, 20h       

        next:             
        mov buffer2[di], al 
        inc size          
        inc di           
        inc si            
        loop ciclo_copiar 

        
        verify:           
        mov si, 0         ; Inicializa si con 0.
        mov di, 0         ; Inicializa di con 0.
        mov ax, 0         ; Inicializa ax con 0.
        mov bp, 0         ; Inicializa bp con 0.
        mov cx, size      ; Carga el tamano real de la cadena en cx.    
        
        cmp size, 1       
        je is_palindrome  
        
        lea di, buffer2   
        mov si, di       
        add si, size      
        dec si           

        shr cx, 1         

        next_char:        
        mov al, [di]      
        mov bl, [si]      
        cmp al, bl        
        jne not_palindrome
        inc di            
        dec si            
        loop next_char   
                
        
        is_palindrome:    
        GOTOXY x, 7       
        call PTHIS        
        db 'Si es palindromo', 0 
        jmp exit         
        
        not_palindrome:  
        GOTOXY x, 7       
        call PTHIS        
        db 'No es palindromo', 0 
        jmp exit          
                           
                           
        omitir_space:     
        inc si           
        jmp ciclo_copiar  
        
        
        ; -----------------------
        
        ret               
    inicio endp           
    DEFINE_SCAN_NUM       
    DEFINE_PRINT_STRING   
    DEFINE_PRINT_NUM     
    DEFINE_PRINT_NUM_UNS  
    DEFINE_PTHIS          
    DEFINE_CLEAR_SCREEN        
 codigo ends             
 exit:                  
 END inicio