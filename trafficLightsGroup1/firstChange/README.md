# Traffic Lights

## Members

- García Villalobos Gabriela
- Herrera Rosales Leonardo Alberto
- Romero Claros Fabián


### Description

The first change made was in the sequence of the lights, the objective was to manipulate the lights in such a way that they turn on one at a time per traffic light sequentially and once the 3 lights of one traffic light come on it would go on to the next. traffic light for it to carry out the sequence.

To achieve this we simply identified that the color sequences went from 3 to 3 bits, representing each traffic light:
1000 - green
; 0110 - yellow and red
; 0100 - yellow
; 0010 - red    

; 0100 - green
; 0010 - yellow
; 0001 - red

And based on this, we've just changed all the situations as we needed.