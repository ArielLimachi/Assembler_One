## Members

-   Axel Ayala Siles
-   Cristian Sebastian Barra Zurita
-   Luiggy Mamani Condori

## Description

The code provides a way to check whether a text string entered by the user is a palindrome. A palindrome is a word or phrase that reads the same from left to right as from right to left. The program removes whitespace from the string, compares it with its inverted version, and then determines whether it is a palindrome or not, thus offering a simple tool for this type of analysis.

## Functioning

The code checks if a string entered by the user is a palindrome. To do so, it first prompts the user to enter a string of up to 40 characters through the console. This is accomplished using a specialized routine that waits for user input and stores the entered characters in a buffer in memory.

Once the string has been entered, the program proceeds to remove any white space it may contain.

Each pair of characters in the string is then compared, starting from the ends and moving toward the center. If at any time a pair of mismatched characters is found, it is concluded that the string is not a palindrome. Conversely, if all character pairs match, the string is determined to be a palindrome.
