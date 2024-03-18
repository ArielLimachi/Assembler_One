# Members
- Luiggy Mamani Condori
- Axel Javier Ayala Siles
- Cristian Sebastian Barra Zurita

## Description
- Segments: The program defines three segments: data, stack and code. Data segments contain the variables and constants that will be used in the program. The stack segment is used to store temporary information during program execution. The code segment contains the program code.

- Initialization: At the beginning of the main procedure, the program saves the current value of the data segment (ds) on the stack and then sets it to the address of the data segment. It also sets the extra segment(s) with the same address.
String copy: The program copies the string from buffer1 to buffer2, omitting spaces and converting all characters to lowercase. This is done in the cycle_copy cycle. The program uses the index registers si and di to traverse buffer1 and buffer2 respectively. The cx register is used as a counter for the cycle.

- Palindrome check: Once the string has been copied and processed, the program checks to see if it is a palindrome. This is done by comparing the characters in symmetrical positions from the beginning and the end of the string. If all pairs of characters are the same, then the string is a palindrome. This part of the code is located under the verify tag.

- Output: If the string is a palindrome, the program displays the message 'If palindrome'. If it is not, it displays the message 'Not palindrome'. This part of the code is located under the is_palindrome and not_palindrome tags respectively.
Macros: The program uses several macros from the emu8086.inc library to perform operations such as clearing the screen (CLEAR_SCREEN), obtaining user input (GET_STRING), and displaying text on the screen (PTHIS).