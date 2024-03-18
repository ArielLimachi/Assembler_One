# Traffic Lights

## Members

- García Villalobos Gabriela
- Herrera Rosales Leonardo Alberto
- Romero Claros Fabián

### Description

The second change made was to define 5 sequences for all traffic lights and the objective was to display the sequence according to the value of the input.

This was achieved by obtaining an input through port 21, then we converted the value obtained to ASCII, representing the index, we multiplied by 2 using a shift left since each situation occupies 2 bytes and finally we loaded the situation of the given index.
