// The following code was written by Aman Patel
// February 3, 2020
// CSCI-C 291

#include<stdio.h>
#include<stdbool.h>
#include<string.h>
#include <stdlib.h>

int assigned[6][12];
char names[72][80];
int row;
int column;
int firstBooked;
int businessBooked;
int economyBooked;
char firstName[31];
char lastName[15];
int booked;

bool isAssigned(int);
int boardingPass(char[]);
int viewSeatingMap(void);
int viewManifest(void);

int main(void) {
  char preferredClass;
  printf("Welcome to the Patel Airline Reservation System.\n");
  int counter = 0;
  while (counter < 72) {
    booked = 0;
    char seatWilling;
    char willing;
    int i;
    int temp = counter;
    int afterChoice;
    printf("Which class would you like to sit in today?\n\n\t\t\t Please type 'F' for \"first class\"\n\t\t\t Please type 'B' for \"business class\"\n\t\t\t Please type 'E' for \"economy class\"\n");
    scanf(" %c", &preferredClass);
    if (preferredClass == 'F' && booked == 0) {
      if (firstBooked == 12 && businessBooked != 18) {
        printf("The first class section of this flight is fully booked. Are you willing to downgrade to business class? (Y or N)\n");
        scanf(" %c", &willing);
        if (willing == 'Y') {
          preferredClass = 'B';
          printf("You have been downgraded to business class. Thank you!\n");
        }
        else {
          printf("Next flight leaves in three hours.\n");
          counter = counter - 1;
        }
      }
      else if (firstBooked == 12 && businessBooked == 18 && economyBooked != 42) {
        printf("The first class section of this flight is fully booked. Are you willing to downgrade to economy class? (Y or N)\n");
        scanf(" %c", &willing);
        if (willing == 'Y') {
          preferredClass = 'E';
          printf("You have been downgraded to economy class. Thank you!\n");
        }
        else {
          printf("Next flight leaves in three hours.\n");
          counter = counter - 1;
        }
      }
      else {
        row = rand() % 6;
        column = rand() % 2;
        while (isAssigned(assigned[row][column])) {
          row = rand() % 6;
          column = rand() % 2;
        }
        if (row == 0 || row == 5) {
          printf("The generated seat is a Window seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
            int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s", firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
            booked = 1;
            strcpy(firstName, "");
            strcpy(lastName, "");
          }
          else {
            row = rand() % 6;
            column = rand() % 2;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 2;
              }
              if (row == 2 || row == 3) {
                printf("The generated seat is an Aisle seat. Is this acceptable (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName);
                  printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  booked = 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                   int position = column * 6 + row;
                printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                booked = 1;
                strcpy(firstName, "");
                strcpy(lastName, "");
                break;
              }
            }
          }
        }
        else if (row == 2 || row == 3) {
          printf("The generated seat is a Aisle seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
              int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s",firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
            booked = 1;
            strcpy(firstName, "");
          }
          else {
            row = rand() % 6;
            column = rand() % 2;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 2;
              }
               if (row == 0 || row == 5) {
                printf("The generated seat is an Window seat. Is this acceptable? (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName); printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  booked = 1;
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                int position = column * 6 + row;
                 printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                strcpy(firstName, "");
                strcpy(lastName, "");
                booked = 1;
                break;
              }
            }
          }
        }
        else {
          int position = column * 6 + row;
          printf("Please enter your first and last name: ");
          scanf("%s %s", firstName, lastName);
          strcat(firstName, " ");
           strcat(firstName, lastName);
          strcpy(names[position], firstName);
          printf("Congratulations! Your seat has been booked.\n");
          assigned[row][column] = 1;
          firstBooked = firstBooked + 1;
          strcpy(firstName, "");
          strcpy(lastName, "");
          booked = 1;
        }
      }
    }
    if (preferredClass == 'B' && booked == 0) {
      if (businessBooked == 18 && firstBooked != 12) {
        printf("The business class section of this flight is fully booked. Are you willing to upgrade to first class? (Y or N)\n");
        scanf(" %c", &willing);
        if (willing == 'Y') {
          preferredClass = 'F';
          printf("You have been upgraded to first class. Thank you!\n");
        }
        else if(willing == 'N' && economyBooked != 42) {
          printf("Would you be willing to downgrade to economy? (Y or N)\n");
          scanf(" %c", &willing);
          if (willing == 'Y') {
              printf("You have been downgraded to economy. Thank you!\n");
              preferredClass = 'E';
          }
        }
        else {
          printf("Next flight leaves in three hours.\n");
          counter = counter - 1;
        }
      }
      else {
        row = rand() % 6;
        column = rand() % 3 + 2;
        while (isAssigned(assigned[row][column])) {
          row = rand() % 6;
          column = rand() % 3 + 2;
        }
        if (row == 0 || row == 5) {
          printf("The generated seat is a Window seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
            int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s", firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
             strcpy(firstName, "");
            strcpy(lastName, "");
            booked  = 1;
          }
          else {
            row = rand() % 6;
            column = rand() % 3 + 2;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 3 + 2;
              }
              if (row == 2 || row == 3) {
                printf("The generated seat is an Aisle seat. Is this acceptable (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName);
                  printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  booked = 1;
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                   int position = column * 6 + row;
                printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                strcpy(firstName, "");
                 strcpy(lastName, "");
                 booked = 1;
                break;
              }
            }
          }
        }
        else if (row == 2 || row == 3) {
          printf("The generated seat is a Aisle seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
              int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s",firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
            booked = 1;
            strcpy(firstName, "");
          }
          else {
            row = rand() % 6;
            column = rand() % 3 + 2;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 3 + 2;
              }
               if (row == 0 || row == 5) {
                printf("The generated seat is an Window seat. Is this acceptable? (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName); printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  booked = 1;
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                int position = column * 6 + row;
                 printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                strcpy(firstName, "");
                strcpy(lastName, "");
                booked = 1;
                break;
              }
            }
          }
        }
        else {
          int position = column * 6 + row;
          printf("Please enter your first and last name: ");
          scanf("%s %s", firstName, lastName);
          strcat(firstName, " ");
           strcat(firstName, lastName);
          strcpy(names[position], firstName);
          printf("Congratulations! Your seat has been booked.\n");
          assigned[row][column] = 1;
          firstBooked = firstBooked + 1;
          booked = 1;
          strcpy(firstName, "");
          strcpy(lastName, "");
        }
      }
    }
    if (preferredClass == 'E' && booked == 0) {
      if (firstBooked == 12) {
        printf("The first class section of this flight is fully booked. Are you willing to downgrade to business class? (Y or N)\n");
        scanf(" %c", &willing);
        if (willing == 'Y') {
          preferredClass = 'B';
          printf("You have been downgraded to business class. Thank you!\n");
        }
        else {
          printf("Next flight leaves in three hours.\n");
          counter = counter - 1;
        }
      }
      else {
        row = rand() % 6;
        column = rand() % 7 + 5;
        while (isAssigned(assigned[row][column])) {
          row = rand() % 6;
          column = rand() % 7 + 5;
        }
        if (row == 0 || row == 5) {
          printf("The generated seat is a Window seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
            int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s", firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
             strcpy(firstName, "");
            strcpy(lastName, "");
            booked = 1;
          }
          else {
            row = rand() % 6;
            column = rand() % 7 + 5;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 7 + 5;
              }
              if (row == 2 || row == 3) {
                printf("The generated seat is an Aisle seat. Is this acceptable (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName);
                  printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  booked = 1;
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                   int position = column * 6 + row;
                printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                strcpy(firstName, "");
                 strcpy(lastName, "");
                 booked = 1;
                break;
              }
            }
          }
        }
        else if (row == 2 || row == 3) {
          printf("The generated seat is a Aisle seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
              int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s",firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
            strcpy(firstName, "");
            booked = 1;
          }
          else {
            row = rand() % 6;
            column = rand() % 7 + 5;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 7 + 5;
              }
               if (row == 0 || row == 5) {
                printf("The generated seat is an Window seat. Is this acceptable? (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName); printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  booked = 1;
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                int position = column * 6 + row;
                 printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                strcpy(firstName, "");
                strcpy(lastName, "");
                booked = 1;
                break;
              }
            }
          }
        }
        else {
          int position = column * 6 + row;
          printf("Please enter your first and last name: ");
          scanf("%s %s", firstName, lastName);
          strcat(firstName, " ");
           strcat(firstName, lastName);
          strcpy(names[position], firstName);
          printf("Congratulations! Your seat has been booked.\n");
          assigned[row][column] = 1;
          firstBooked = firstBooked + 1;
          strcpy(firstName, "");
          strcpy(lastName, "");
          booked = 1;
        }
      }
    }
    if (preferredClass == 'F' && booked == 0) {
        row = rand() % 6;
        column = rand() % 2;
        while (isAssigned(assigned[row][column])) {
          row = rand() % 6;
          column = rand() % 2;
        }
        if (row == 0 || row == 5) {
          printf("The generated seat is a Window seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
            int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s", firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
            booked = 1;
            strcpy(firstName, "");
            strcpy(lastName, "");
          }
          else {
            row = rand() % 6;
            column = rand() % 2;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 2;
              }
              if (row == 2 || row == 3) {
                printf("The generated seat is an Aisle seat. Is this acceptable (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName);
                  printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  booked = 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                   int position = column * 6 + row;
                printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                booked = 1;
                strcpy(firstName, "");
                strcpy(lastName, "");
                break;
              }
            }
          }
        }
        else if (row == 2 || row == 3) {
          printf("The generated seat is a Aisle seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
              int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s",firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
            booked = 1;
            strcpy(firstName, "");
          }
          else {
            row = rand() % 6;
            column = rand() % 2;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 2;
              }
               if (row == 0 || row == 5) {
                printf("The generated seat is an Window seat. Is this acceptable? (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName);
                  printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  booked = 1;
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                int position = column * 6 + row;
                 printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                strcpy(firstName, "");
                strcpy(lastName, "");
                booked = 1;
                break;
              }
            }
          }
        }
        else {
          int position = column * 6 + row;
          printf("Please enter your first and last name: ");
          scanf("%s %s", firstName, lastName);
          strcat(firstName, " ");
           strcat(firstName, lastName);
          strcpy(names[position], firstName);
          printf("Congratulations! Your seat has been booked.\n");
          assigned[row][column] = 1;
          firstBooked = firstBooked + 1;
          strcpy(firstName, "");
          strcpy(lastName, "");
          booked = 1;
        }
    }
    if (preferredClass == 'E' && booked == 0) {
        row = rand() % 6;
        column = rand() % 7 + 5;
        while (isAssigned(assigned[row][column])) {
          row = rand() % 6;
          column = rand() % 7 + 5;
        }
        if (row == 0 || row == 5) {
          printf("The generated seat is a Window seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
            int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s", firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
             strcpy(firstName, "");
            strcpy(lastName, "");
            booked = 1;
          }
          else {
            row = rand() % 6;
            column = rand() % 7 + 5;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 7 + 5;
              }
              if (row == 2 || row == 3) {
                printf("The generated seat is an Aisle seat. Is this acceptable (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName);
                  printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  booked = 1;
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                   int position = column * 6 + row;
                printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                strcpy(firstName, "");
                 strcpy(lastName, "");
                 booked = 1;
                break;
              }
            }
          }
        }
        else if (row == 2 || row == 3) {
          printf("The generated seat is a Aisle seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
              int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s",firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
            strcpy(firstName, "");
            booked = 1;
          }
          else {
            row = rand() % 6;
            column = rand() % 7 + 5;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 7 + 5;
              }
               if (row == 0 || row == 5) {
                printf("The generated seat is an Window seat. Is this acceptable? (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName); printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  booked = 1;
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                int position = column * 6 + row;
                 printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                strcpy(firstName, "");
                strcpy(lastName, "");
                booked = 1;
                break;
              }
            }
          }
        }
        else {
          int position = column * 6 + row;
          printf("Please enter your first and last name: ");
          scanf("%s %s", firstName, lastName);
          strcat(firstName, " ");
           strcat(firstName, lastName);
          strcpy(names[position], firstName);
          printf("Congratulations! Your seat has been booked.\n");
          assigned[row][column] = 1;
          firstBooked = firstBooked + 1;
          strcpy(firstName, "");
          strcpy(lastName, "");
          booked = 1;
        }
      }
      if (preferredClass == 'B' && booked == 0) {
        row = rand() % 6;
        column = rand() % 3 + 2;
        while (isAssigned(assigned[row][column])) {
          row = rand() % 6;
          column = rand() % 3 + 2;
        }
        if (row == 0 || row == 5) {
          printf("The generated seat is a Window seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
            int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s", firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
             strcpy(firstName, "");
            strcpy(lastName, "");
            booked  = 1;
          }
          else {
            row = rand() % 6;
            column = rand() % 3 + 2;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 3 + 2;
              }
              if (row == 2 || row == 3) {
                printf("The generated seat is an Aisle seat. Is this acceptable (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName);
                  printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  booked = 1;
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                   int position = column * 6 + row;
                printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                strcpy(firstName, "");
                 strcpy(lastName, "");
                 booked = 1;
                break;
              }
            }
          }
        }
        else if (row == 2 || row == 3) {
          printf("The generated seat is a Aisle seat. Is this acceptable? (Y or N)\n");
          scanf(" %c", &seatWilling);
          if (seatWilling == 'Y') {
              int position = column * 6 + row;
            printf("Please enter your first and last name: ");
            scanf("%s %s",firstName, lastName);
            strcat(firstName, " ");
            strcat(firstName, lastName);
            strcpy(names[position], firstName);
            printf("Congratulations! Your seat has been booked.\n");
            assigned[row][column] = 1;
            firstBooked = firstBooked + 1;
            booked = 1;
            strcpy(firstName, "");
          }
          else {
            row = rand() % 6;
            column = rand() % 3 + 2;
            for (i = 0; i < 3; i++) {
              while (isAssigned(assigned[row][column])) {
                row = rand() % 6;
                column = rand() % 3 + 2;
              }
               if (row == 0 || row == 5) {
                printf("The generated seat is an Window seat. Is this acceptable? (Y or N)\n");
                scanf(" %c", &seatWilling);
                if (seatWilling == 'Y') {
                  int position = column * 6 + row;
                  printf("Please enter your first and last name: ");
                  scanf("%s %s", firstName, lastName);
                  strcat(firstName, " ");
                  strcat(firstName, lastName);
                  strcpy(names[position], firstName); printf("Congratulations! Your seat has been booked.\n");
                  assigned[row][column] = 1;
                  firstBooked = firstBooked + 1;
                  strcpy(firstName, "");
                  strcpy(lastName, "");
                  booked = 1;
                  break;
                }
              }
              else if(row == 1 || row == 4) {
                int position = column * 6 + row;
                 printf("Please enter your first and last name: ");
                scanf("%s %s", firstName, lastName);
                strcat(firstName, " ");
                strcat(firstName, lastName);
                strcpy(names[position], firstName);
                printf("Congratulations! Your seat has been booked.\n");
                assigned[row][column] = 1;
                firstBooked = firstBooked + 1;
                strcpy(firstName, "");
                strcpy(lastName, "");
                booked = 1;
                break;
              }
            }
          }
        }
        else {
          int position = column * 6 + row;
          printf("Please enter your first and last name: ");
          scanf("%s %s", firstName, lastName);
          strcat(firstName, " ");
           strcat(firstName, lastName);
          strcpy(names[position], firstName);
          printf("Congratulations! Your seat has been booked.\n");
          assigned[row][column] = 1;
          firstBooked = firstBooked + 1;
          booked = 1;
          strcpy(firstName, "");
          strcpy(lastName, "");
        }
    }
    if (preferredClass != 'F' && preferredClass != 'B' && preferredClass != 'E') {
      printf("Please select a valid class (Input is case-sensitive).");
      counter = counter - 1;
    }
    if (temp == counter) {
      printf("Thank you for choosing Patel Airlines. What would you like to do now?\n\t\t\t View Seating Map (1)\n\t\t\t Passenger Manifest (2)\n\t\t\t Print Boarding Pass (3)\n");
      scanf(" %d", &afterChoice);
      if (afterChoice == 1) {
        printf("\n");
        viewSeatingMap();
      }
      else if (afterChoice == 2) {
          printf("\n");
        viewManifest();
      }
      else if (afterChoice == 3) {
        printf("\n");
        char seatNumber[2];
        printf("Please enter your seat number: (e.g. 2D): ");
        scanf(" %s", &seatNumber);
        boardingPass(seatNumber);
      }
      else {
        printf("Invalid selection. Have a good day!");
      }
    }
    counter = counter + 1;
  }
}

bool isAssigned(int var) {
  return var == 1;
}
int boardingPass(char seatNumber[]) {
    int column = seatNumber[0] - 49;
    char rowChar = seatNumber[1];
    int row;
    char level;
    if (column == 0 || column == 1) {
        level = 'F';
    }
    if (column > 1 && column <= 4) {
      level = 'B';
    }
    if (column > 4 && column <= 11) {
      level = 'E';
    }

    if (rowChar == 'F') {
        row = 0;
    }
    else if (rowChar == 'E') {
        row = 1;
    }
    else if (rowChar == 'D') {
        row = 2;
    }
    else if (rowChar == 'C') {
        row = 3;
    }
    else if (rowChar == 'B') {
        row = 4;
    }
    else if (rowChar == 'A') {
        row = 5;
    }
    else {
        printf("Invalid seat number.\n");
        row = 0;
        column = 0;
    }
    if (isAssigned(assigned[row][column])) {
        int position = column * 6 + row;
        char fullName[31];
         strcpy(fullName, names[position]);
        printf("Name: %s, SEAT: %s, Level: %c\n", fullName, seatNumber, level);
    }
    else {
        printf("Seat Unassigned - No Boarding pass available.\n");
    }

}

int viewSeatingMap(void) {
  int i;
  int j;
  for (i = 0; i < 3; i++) {
    for (j = 0; j < 12; j++) {
      printf("%d ", assigned[i][j]);
    }
    printf("\n");
  }
  printf("\n");
  for (i = 0; i < 3; i++) {
    for (j = 0; j < 12; j++) {
         printf("%d ", assigned[i + 3][j]);
    }
    printf("\n");
  }
  printf("\n");
}
int viewManifest(void) {
    int i;
    int j;
    for (i = 0; i < 6; i++) {
        for (j = 0; j < 12; j++) {
            if (assigned[i][j] == 1) {
                int position = j * 6 + i;
                char fullName[31];
                char columnString[3];
                char level;
                sprintf(columnString, "%d", j + 1);
                char rowChar[1];
                if (i == 0) {
                    strcpy(rowChar, "F");
                }
                if (i == 1) {
                    strcpy(rowChar, "E");
                }
                if (i == 2) {
                    strcpy(rowChar, "D");
                }
                if (i == 3) {
                    strcpy(rowChar, "C");
                }
                if (i == 4) {
                    strcpy(rowChar, "B");
                }
                if (i == 5) {
                    strcpy(rowChar, "A");
                }
		printf("Seat number printing incorrectly, works on online C compiler\n");
                strcat(columnString, rowChar);
                strcpy(fullName, names[position]);
                if (j == 0 || j == 1) {
                  level = 'F';
                }
                if (j > 1 && j <= 4) {
                  level = 'B';
                }
                if (j > 4 && j <= 11) {
                  level = 'E';
                }
                printf("Name: %s, SEAT: %s, Level: %c\n", fullName, columnString, level);
            }
        }
    }
}
