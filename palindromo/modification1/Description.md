# Members
- Luiggy Mamani Condori
- Axel Javier Ayala Siles
- Cristian Sebastian Barra Zurita

## Description
This assembler program checks whether a string is a palindrome or not.

The program converts all uppercase letters to lowercase before performing the check, which means it is not case sensitive when determining whether the string is a palindrome. This is achieved using ASCII code.

## Functioning
1. We define the records that we are going to use to traverse the chain in two parts are defined, from the beginning and from the end. For this, the "di" pointers are used at the beginning of the string and another "if" pointer at the end of the string.

2. Divide the length of the string by 2 to determine how many comparisons to make.

3. A loop is started to compare the characters. In each iteration, one character from the start of the string is compared to one character from the end. If the characters are not the same, the program jumps to the "not_palindrome" tag.

4. Before comparing the characters, a conversion from uppercase to lowercase is performed if necessary using ASCII code.

5. When all characters match, a message is displayed indicating that the string is a palindrome. Otherwise, a message is displayed indicating that it is not a palindrome.