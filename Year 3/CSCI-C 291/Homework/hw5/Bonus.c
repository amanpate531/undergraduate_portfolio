// The following code was written by Aman Patel
// February 18, 2020
// CSCI-C 291

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int packCharacters(char c1, char c2, char c3, char c4);

int main(void) {
	char c1;
	char c2;
	char c3;
	char c4;
	
	printf("Enter the first character: ");
	scanf(" %c", &c1);
	printf("Enter the second character: ");
	scanf(" %c", &c2);
	printf("Enter the third character: ");
	scanf(" %c", &c3);
	printf("Enter the fourth character: ");
	scanf(" %c", &c4);
	packCharacters(c1, c2, c3, c4);
	
	return 0;
}

int packCharacters(char c1, char c2, char c3, char c4) {
	unsigned int i1 = c1;
	unsigned int i2 = c2;
	unsigned int i3 = c3;
	unsigned int i4 = c4;
    printf("Your characters represented by an unsigned int are: %u\n", i1<<8 ^ i2<<8 ^ i3<<8 ^ i4<<8);
	return 0;
}
