org 100h 
    
    msg db "VIVA BOLIVIA!$"

        ;  (Rojo)
        mov ax,0600h   
        mov bh,47h     
        mov cx,0000h   
        mov dx, 034fh  
        int 10h       

        ;  (Amarillo)
        mov ax,0600h   
        mov bh,60h     
        mov cx,0400h   
        mov dx, 074fh  
        int 10h        

        ;  (Verde)
        mov ax,0600h   
        mov bh,2Eh     
        mov cx,0800h   
        mov dx, 0b4fh  
        int 10h   
        
        ;muestra el mensaje
        mov dx , offset msg
        mov ah ,9
        int 21h     

        mov ax,0C07h       
        int 21h             
  ret   

