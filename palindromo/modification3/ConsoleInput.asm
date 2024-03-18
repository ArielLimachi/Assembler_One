title palindromoconsole  ; Define el título de la ventana de la consola.
include "emu8086.inc"    ; Incluye la biblioteca emu8086 que proporciona varias macros útiles.

datos segment            ; Inicio del segmento de datos.
    buffer1 db 40 dup(?) ; Define un buffer de 40 bytes para almacenar la cadena de entrada.
    buffer2 db 40 dup(?) ; Define otro buffer de 40 bytes para almacenar la cadena sin espacios.
    tamanio equ 40       ; Define una constante para el tamaño de los buffers.
    size dw 0            ; Define una variable para almacenar el tamaño real de la cadena.
    
    null equ 0h          ; Define una constante para el carácter nulo.
    space equ 20h        ; Define una constante para el carácter de espacio.
    
     x db 2               ; Define una variable para la posición x del cursor en la pantalla.
    y db 3               ; Define una variable para la posición y del cursor en la pantalla.
datos ends               ; Fin del segmento de datos.

pila segment             ; Inicio del segmento de pila.
    dw 64 dup(0)         ; Define una pila de 64 palabras.
pila ends                ; Fin del segmento de pila.    

codigo segment           ; Inicio del segmento de código.
    inicio proc far      ; Inicio de la rutina principal.
        assume cs:codigo, ds:datos, ss:pila  ; Establece los segmentos de código, datos y pila.
        push ds          ; Guarda el valor actual de ds en la pila.
        mov ax, 0        ; Inicializa ax con 0.
        push ax          ; Guarda el valor de ax en la pila.
        
        mov ax, datos    ; Carga la dirección del segmento de datos en ax.
        mov ds, ax       ; Establece ds con la dirección del segmento de datos.
        mov es, ax       ; Establece es con la dirección del segmento de datos.
        
        ; CODE ------------------
              
        start:            ; Etiqueta de inicio del código principal.
        mov di, 0         ; Inicializa di con 0. di se usa como índice para buffer2.
        mov si, 0         ; Inicializa si con 0. si se usa como índice para buffer1.
        mov ax, 0         ; Inicializa ax con 0.
        mov bp, 0         ; Inicializa bp con 0.
        
        call CLEAR_SCREEN ; Limpia la pantalla.
        
        lea si, buffer1   ; Carga la dirección de buffer1 en si.
        mov dx, tamanio   ; Carga el tamaño máximo de la cadena en dx.
        call GET_STRING   ; Lee una cadena del usuario y la almacena en buffer1.
        
        mov cx, 39        ; Inicializa cx con 39. cx se usa como contador para el ciclo de copia.
        
        ; Inicialización del tamaño a 0 antes de copiar
        mov size, 0       ; Inicializa size con 0.
        
        ciclo_copiar:     ; Inicio del ciclo para copiar la cadena del usuario de buffer1 a buffer2.
        mov al, buffer1[si] ; Carga el carácter actual de buffer1 en al.
        cmp al, space     ; Compara el carácter actual con un espacio.
        je omitir_space   ; Si el carácter actual es un espacio, salta a la etiqueta omitir_space.
        cmp al, null      ; Compara el carácter actual con un carácter nulo.
        je verify         ; Si el carácter actual es un carácter nulo, salta a la etiqueta verify.

        ; Convertir a minúsculas
        ; Si 'A' <= al <= 'Z', entonces al = al + ('a' - 'A')
        cmp al, 'A'       ; Compara el carácter actual con 'A'.
        jl next           ; Si el carácter actual es menor que 'A', salta a la etiqueta next.
        cmp al, 'Z'       ; Compara el carácter actual con 'Z'.
        jg next           ; Si el carácter actual es mayor que 'Z', salta a la etiqueta next.
        add al, 20h       ; Si el carácter actual es una letra mayúscula, lo convierte a minúscula.

        next:             ; Etiqueta para saltar si el carácter actual no es una letra mayúscula.
        mov buffer2[di], al ; Almacena el carácter actual en buffer2.
        inc size          ; Incrementa size.
        inc di            ; Incrementa di.
        inc si            ; Incrementa si.
        loop ciclo_copiar ; Decrementa cx y repite el ciclo si cx no es 0.

        
        verify:           ; Etiqueta para verificar si la cadena en buffer2 es un palíndromo.
        mov si, 0         ; Inicializa si con 0.
        mov di, 0         ; Inicializa di con 0.
        mov ax, 0         ; Inicializa ax con 0.
        mov bp, 0         ; Inicializa bp con 0.
        mov cx, size      ; Carga el tamaño real de la cadena en cx.    
        
        cmp size, 1       ; Compara size con 1.
        je is_palindrome  ; Si size es 1, salta a la etiqueta is_palindrome.
        
        lea di, buffer2   ; Carga la dirección de buffer2 en di.
        mov si, di        ; Copia el valor de di en si.
        add si, size      ; Añade size a si para que apunte al final de la cadena.
        dec si            ; Decrementa si para que apunte al último carácter de la cadena.

        shr cx, 1         ; Divide cx por 2 porque solo necesitas comparar la primera mitad de la cadena con la segunda mitad.

        next_char:        ; Inicio del ciclo para comparar los caracteres de la cadena.
        mov al, [di]      ; Carga el carácter actual de buffer2 en al.
        mov bl, [si]      ; Carga el carácter correspondiente desde el final de buffer2 en bl.
        cmp al, bl        ; Compara los dos caracteres.
        jne not_palindrome ; Si los caracteres no son iguales, salta a la etiqueta not_palindrome.
        inc di            ; Incrementa di.
        dec si            ; Decrementa si.
        loop next_char    ; Decrementa cx y repite el ciclo si cx no es 0.
                
        
        is_palindrome:    ; Etiqueta para saltar si la cadena es un palíndromo.
        GOTOXY x, 7       ; Mueve el cursor a la posición (x, 7) en la pantalla.
        call PTHIS        ; Imprime la cadena siguiente en la pantalla.
        db 'Si es palindromo', 0 ; Define la cadena a imprimir.
        jmp exit          ; Salta a la etiqueta exit para terminar el programa.
        
        not_palindrome:   ; Etiqueta para saltar si la cadena no es un palíndromo.
        GOTOXY x, 7       ; Mueve el cursor a la posición (x, 7) en la pantalla.
        call PTHIS        ; Imprime la cadena siguiente en la pantalla.
        db 'No es palindromo', 0 ; Define la cadena a imprimir.
        jmp exit          ; Salta a la etiqueta exit para terminar el programa.
                           
                           
        omitir_space:     ; Etiqueta para saltar si el carácter actual de buffer1 es un espacio.
        inc si            ; Incrementa si.
        jmp ciclo_copiar  ; Salta a la etiqueta ciclo_copiar para continuar copiando los caracteres restantes.
        
        
        ; -----------------------
        
        ret               ; Retorna del procedimiento.
    inicio endp            ; Fin de la rutina principal.
    DEFINE_SCAN_NUM       ; Define la macro SCAN_NUM.
    DEFINE_PRINT_STRING   ; Define la macro PRINT_STRING.
    DEFINE_PRINT_NUM      ; Define la macro PRINT_NUM.
    DEFINE_PRINT_NUM_UNS  ; Define la macro PRINT
    DEFINE_PTHIS          ; Define la macro PTHIS.
    DEFINE_CLEAR_SCREEN   ; Define la macro CLEAR_SCREEN.
    DEFINE_GET_STRING     ; Define la macro GET_STRING.
 codigo ends             ; Fin del segmento de código.
 exit:                   ; Etiqueta para terminar el programa.
 END inicio              ; Indica el final del programa y el punto de entrada.