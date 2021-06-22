// Fig. 10.3: fig10_03.c
// Card shuffling and dealing program using structures
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

#define CARDS 52
#define FACES 13

// card structure definition                  
struct card {                                 
   const char *face; // define pointer face   
   const char *suit; // define pointer suit   
}; 

typedef struct card Card; // new type name for struct card   

Card hand[5]; // creation of global hand array

// prototypes
void fillDeck(Card * const wDeck, const char * wFace[], 
   const char * wSuit[]);
void shuffle(Card * const wDeck);
void deal(const Card * const wDeck);
void hasPair(void);
void hasTwoPairs(void);
void hasThree(void);
void hasFour(void);
void hasFlush(void);
void hasStraight(void);
int cmpfunc (const void * a, const void * b);

int main(void)
{ 
   Card deck[CARDS]; // define array of Cards

   // initialize array of pointers
   const char *face[] = { "Ace", "Two", "Three", "Four", "Five",
      "Six", "Seven", "Eight", "Nine", "Ten",
      "Jack", "Queen", "King"};

   // initialize array of pointers
   const char *suit[] = { "Hearts", "Diamonds", "Clubs", "Spades"};

   srand(time(NULL)); // randomize

   fillDeck(deck, face, suit); // load the deck with Cards
   shuffle(deck); // put Cards in random order
   deal(deck); // deal 5 Cards
   printf("\n\n");
   hasPair(); // checks for pair
   printf("\n");
   hasTwoPairs(); // checks for two pairs
   printf("\n");
   hasThree(); // checks for three of a kind
   printf("\n");
   hasFour(); // checks for four of a kind
   printf("\n");
   hasFlush(); // checks for flush (same suit)
   printf("\n");
   hasStraight(); // checks for straight (consecutive card faces)
} 

// place strings into Card structures
void fillDeck(Card * const wDeck, const char * wFace[], 
   const char * wSuit[])
{ 
   // loop through wDeck
   for (size_t i = 0; i < CARDS; ++i) { 
      wDeck[i].face = wFace[i % FACES];
      wDeck[i].suit = wSuit[i / FACES];
   } 
} 

// shuffle cards
void shuffle(Card * const wDeck)
{ 
   // loop through wDeck randomly swapping Cards
   for (size_t i = 0; i < CARDS; ++i) { 
      size_t j = rand() % CARDS;
      Card temp = wDeck[i];      
      wDeck[i] = wDeck[j];
      wDeck[j] = temp;      
   } 
} 

// deal cards
void deal(const Card * const wDeck)
{ 
   // loop through wDeck
   // deals 5 cards
   for (size_t i = 0; i < 5; ++i) {
      printf("%5s of %-8s%s", wDeck[i].face, wDeck[i].suit,
         (i + 1) % 4 ? "  " : "\n");
   }
   memcpy(hand, wDeck, sizeof(hand));
}

// checks hand for a pair
void hasPair() {
    bool res;
	
	// counters for each possible number
    int aceCounter = 0;
    int twoCounter = 0;
    int threeCounter = 0;
    int fourCounter = 0;
    int fiveCounter = 0;
    int sixCounter = 0;
    int sevenCounter = 0;
    int eightCounter = 0;
    int nineCounter = 0;
    int tenCounter = 0;
    int jackCounter = 0;
    int queenCounter = 0;
    int kingCounter = 0;
	
    int i;
	// loops through hand and determines how many of each number there are 
	for (i = 0; i < 5; i++) {
        if (hand[i].face == "Ace") {
            aceCounter++;
        }
        if (hand[i].face == "Two") {
            twoCounter++;
        }
        if (hand[i].face == "Three") {
            threeCounter++;
        }
        if (hand[i].face == "Four") {
            fourCounter++;
        }
        if (hand[i].face == "Five") {
            fiveCounter++;
        }
        if (hand[i].face == "Six") {
            sixCounter++;
        }
        if (hand[i].face == "Seven") {
            sevenCounter++;
        }
        if (hand[i].face == "Eight") {
            eightCounter++;
        }
        if (hand[i].face == "Nine") {
            nineCounter++;
        }
        if (hand[i].face == "Ten") {
            tenCounter++;
        }
        if (hand[i].face == "Jack") {
            jackCounter++;
        }
        if (hand[i].face == "Queen") {
            queenCounter++;
        }
        if (hand[i].face == "King") {
            kingCounter++;
        }
    }
	// checks if at least one number is found twice in the hand
    if (aceCounter == 2 || twoCounter == 2 || threeCounter == 2 || fourCounter == 2 || fiveCounter == 2 || sixCounter == 2 || sevenCounter == 2 || eightCounter == 2 || nineCounter == 2 || tenCounter == 2 || jackCounter == 2 || queenCounter == 2 || kingCounter == 2) {
        res = true;
    }
    else {
        res = false;
    }
    if (res) {
        printf("The generated hand has a Pair.\n");
    }
    else {
        printf("The generated hand does not have a Pair.\n");
    }
}

// checks if hand contains two pairs
void hasTwoPairs() {

	// counter for pairs
    int pairCounter = 0;
	
	// counters for each possible number
    int aceCounter = 0;
    int twoCounter = 0;
    int threeCounter = 0;
    int fourCounter = 0;
    int fiveCounter = 0;
    int sixCounter = 0;
    int sevenCounter = 0;
    int eightCounter = 0;
    int nineCounter = 0;
    int tenCounter = 0;
    int jackCounter = 0;
    int queenCounter = 0;
    int kingCounter = 0;
    
	int i;
	// loops through hand, adds to number counters
	// if a number counter reaches 2, pairCounter is incremented
	// if a number counter surpasses 2, pairCounter is decremented
    for (i = 0; i < 5; i++) {
        if (hand[i].face == "Ace") {
            aceCounter++;
            if (aceCounter == 2) {
                pairCounter++;
            }
            if (aceCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Two") {
            twoCounter++;
            if (twoCounter == 2) {
                pairCounter++;
            }
            if (twoCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Three") {
            threeCounter++;
            if (threeCounter == 2) {
                pairCounter++;
            }
            if (threeCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Four") {
            fourCounter++;
            if (fourCounter == 2) {
                pairCounter++;
            }
            if (fourCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Five") {
            fiveCounter++;
            if (fiveCounter == 2) {
                pairCounter++;
            }
            if (fiveCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Six") {
            sixCounter++;
            if (sixCounter == 2) {
                pairCounter++;
            }
            if (sixCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Seven") {
            sevenCounter++;
            if (sevenCounter == 2) {
                pairCounter++;
            }
            if (sevenCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Eight") {
            eightCounter++;
            if (eightCounter == 2) {
                pairCounter++;
            }
            if (eightCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Nine") {
            nineCounter++;
            if (nineCounter == 2) {
                pairCounter++;
            }
            if (nineCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Ten") {
            tenCounter++;
            if (tenCounter == 2) {
                pairCounter++;
            }
            if (tenCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Jack") {
            jackCounter++;
            if (jackCounter == 2) {
                pairCounter++;
            }
            if (jackCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "Queen") {
            queenCounter++;
            if (queenCounter == 2) {
                pairCounter++;
            }
            if (queenCounter > 2) {
                pairCounter--;
            }
        }
        if (hand[i].face == "King") {
            kingCounter++;
            if (kingCounter == 2) {
                pairCounter++;
            }
            if (kingCounter > 2) {
                pairCounter--;
            }
        }
    }
	// checks if pairCounter is 2
    if (pairCounter == 2) {
        printf("The generated hand has Two Pairs.\n");
    }
    else {
        printf("The generated hand does not have Two Pairs.\n");
    }
}

// following function works in same way as pair, final check is for counter == 3 instead
void hasThree() {
    bool res;
    int aceCounter = 0;
    int twoCounter = 0;
    int threeCounter = 0;
    int fourCounter = 0;
    int fiveCounter = 0;
    int sixCounter = 0;
    int sevenCounter = 0;
    int eightCounter = 0;
    int nineCounter = 0;
    int tenCounter = 0;
    int jackCounter = 0;
    int queenCounter = 0;
    int kingCounter = 0;
    int i;
    for (i = 0; i < 5; i++) {
        if (hand[i].face == "Ace") {
            aceCounter++;
        }
        if (hand[i].face == "Two") {
            twoCounter++;
        }
        if (hand[i].face == "Three") {
            threeCounter++;
        }
        if (hand[i].face == "Four") {
            fourCounter++;
        }
        if (hand[i].face == "Five") {
            fiveCounter++;
        }
        if (hand[i].face == "Six") {
            sixCounter++;
        }
        if (hand[i].face == "Seven") {
            sevenCounter++;
        }
        if (hand[i].face == "Eight") {
            eightCounter++;
        }
        if (hand[i].face == "Nine") {
            nineCounter++;
        }
        if (hand[i].face == "Ten") {
            tenCounter++;
        }
        if (hand[i].face == "Jack") {
            jackCounter++;
        }
        if (hand[i].face == "Queen") {
            queenCounter++;
        }
        if (hand[i].face == "King") {
            kingCounter++;
        }
    }
    if (aceCounter == 3 || twoCounter == 3 || threeCounter == 3 || fourCounter == 3 || fiveCounter == 3 || sixCounter == 3 || sevenCounter == 3 || eightCounter == 3 || nineCounter == 3 || tenCounter == 3 || jackCounter == 3 || queenCounter == 3 || kingCounter == 3) {
        res = true;
    }
    else {
        res = false;
    }
    if (res) {
        printf("The generated hand has a Three of a Kind.\n");
    }
    else {
        printf("The generated hand does not have a Three of a Kind.\n");
    }
}

// following function works in same way as hasPair and hasThree, final check is for counter == 4 instead
void hasFour() {
    bool res;
    int aceCounter = 0;
    int twoCounter = 0;
    int threeCounter = 0;
    int fourCounter = 0;
    int fiveCounter = 0;
    int sixCounter = 0;
    int sevenCounter = 0;
    int eightCounter = 0;
    int nineCounter = 0;
    int tenCounter = 0;
    int jackCounter = 0;
    int queenCounter = 0;
    int kingCounter = 0;
    int i;
    for (i = 0; i < 5; i++) {
        if (hand[i].face == "Ace") {
            aceCounter++;
        }
        if (hand[i].face == "Two") {
            twoCounter++;
        }
        if (hand[i].face == "Three") {
            threeCounter++;
        }
        if (hand[i].face == "Four") {
            fourCounter++;
        }
        if (hand[i].face == "Five") {
            fiveCounter++;
        }
        if (hand[i].face == "Six") {
            sixCounter++;
        }
        if (hand[i].face == "Seven") {
            sevenCounter++;
        }
        if (hand[i].face == "Eight") {
            eightCounter++;
        }
        if (hand[i].face == "Nine") {
            nineCounter++;
        }
        if (hand[i].face == "Ten") {
            tenCounter++;
        }
        if (hand[i].face == "Jack") {
            jackCounter++;
        }
        if (hand[i].face == "Queen") {
            queenCounter++;
        }
        if (hand[i].face == "King") {
            kingCounter++;
        }
    }
    if (aceCounter == 4 || twoCounter == 4 || threeCounter == 4 || fourCounter == 4 || fiveCounter == 4 || sixCounter == 4 || sevenCounter == 4 || eightCounter == 4 || nineCounter == 4 || tenCounter == 4 || jackCounter == 4 || queenCounter == 4 || kingCounter == 4) {
        res = true;
    }
    else {
        res = false;
    }
    if (res) {
        printf("The generated hand has a Four of a Kind.\n");
    }
    else {
        printf("The generated hand does not have a Four of a Kind.\n");
    }
}

// checks if all cards in hand are of the same suit
void hasFlush() {
    bool res;
	
	// suit counters
    int spadeCounter = 0;
    int heartCounter = 0;
    int clubCounter = 0;
    int diamondCounter = 0;
    int i;
	// loops through hand, adding to suit counters
    for (i = 0; i < 5; i++) {
        if (hand[i].suit == "Spades") {
            spadeCounter++;
        }
        if (hand[i].suit == "Hearts") {
            heartCounter++;
        }
        if (hand[i].suit == "Clubs") {
            clubCounter++;
        }
        if (hand[i].suit == "Diamonds") {
            diamondCounter++;
        }
    }
	// checks if any of the suit counters is equal to 5 (all suits are same)
    if (heartCounter == 5 || clubCounter == 5 || diamondCounter == 5 || spadeCounter == 5) {
        res = true;
    }
    else {
        res = false;
    }
    if (res) {
        printf("The generated hand has a Flush.\n");
    }
    else {
        printf("The generated hand does not have a Flush.\n");
    }
}

// checks if hand has a sequence of five consecutive cards, regardless of suit
void hasStraight() {
    int values[5];
    bool res = true;
    int i;
	// loops through hand, converts string "face" to int "value"
    for (i = 0; i < 5; i++) {
        if (hand[i].face == "Ace") {
            values[i] = 1;
        }
        if (hand[i].face == "Two") {
            values[i] = 2;
        }
        if (hand[i].face == "Three") {
            values[i] = 3;
        }
        if (hand[i].face == "Four") {
            values[i] = 4;
        }
        if (hand[i].face == "Five") {
            values[i] = 5;
        }
        if (hand[i].face == "Six") {
            values[i] = 6;
        }
        if (hand[i].face == "Seven") {
            values[i] = 7;
        }
        if (hand[i].face == "Eight") {
            values[i] = 8;
        }
        if (hand[i].face == "Nine") {
            values[i] = 9;
        }
        if (hand[i].face == "Ten") {
            values[i] = 10;
        }
        if (hand[i].face == "Jack") {
            values[i] = 11;
        }
        if (hand[i].face == "Queen") {
            values[i] = 12;
        }
        if (hand[i].face == "King") {
            values[i] = 13;
        }
    }
	// sorts the values array in ascending order
    qsort(values, 5, sizeof(int), cmpfunc);
	// loops through values, checks if the current element is one less than the next element
    for (i = 0; i < 4; i++) {
        if (values[i] != (values[i + 1] - 1)) {
            res = false;
        }
    }
    if (res) {
        printf("The generated hand has a Straight.\n");
    }
    else {
        printf("The generated hand does not have a Straight.\n");
    }
}

// comparison function for use in hasStraight()
int cmpfunc (const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}



/**************************************************************************
 * (C) Copyright 1992-2015 by Deitel & Associates, Inc. and               *
 * Pearson Education, Inc. All Rights Reserved.                           *
 *                                                                        *
 * DISCLAIMER: The authors and publisher of this book have used their     *
 * best efforts in preparing the book. These efforts include the          *
 * development, research, and testing of the theories and programs        *
 * to determine their effectiveness. The authors and publisher make       *
 * no warranty of any kind, expressed or implied, with regard to these    *
 * programs or to the documentation contained in these books. The authors *
 * and publisher shall not be liable in any event for incidental or       *
 * consequential damages in connection with, or arising out of, the       *
 * furnishing, performance, or use of these programs.                     *
 *************************************************************************/

