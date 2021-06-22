// The following code was written by Aman Patel
// January 28, 2020
// CSCI-C 291

#include<stdio.h>

int main(void) {

// Initialization of all statistical variables
 int totalAll = 0;
 int totalInternational = 0;
 int totalDomestic = 0;
 int totalWeekly = 0;
 int totalHourly = 0;
 int totalCommission = 0;
 int totalPiece = 0;
 int currentNumber;
 unsigned char currentPaycode;
 printf("\nWelcome to the Salary Calculator");
 // while loop continues until the paycode entered is Q or q (quit)
 while(currentPaycode != 'Q' && currentPaycode != 'q') {
  printf("\nPlease enter one of the following codes:\n\n\t\t\tWeekly Workers (W or w)\n\t\t\tHourly Workers (H or h)\n\t\t\tCommission Workers (C or c)\n\t\t\tPieceworkers (P or p)\n\t\t\tQuit (Q or q)\n");
  scanf(" %c", &currentPaycode);
  // checks if first paycode is Q or q
  if (currentPaycode == 'Q' || currentPaycode == 'q') {
      printf("\nFinal Statistics:\nTotal for All employees: %d\nTotal for International employees: %d\nTotal for Domestic employees: %d\nTotal for Weekly Workers: %d\nTotal for Hourly Workers: %d\nTotal for Commission Workers: %d\nTotal for Pieceworkers: %d\n\n", totalAll, totalInternational, totalDomestic, totalWeekly, totalHourly, totalCommission, totalPiece);
      break;
  }
  printf("Enter the number of employees of that type: ");
  scanf(" %d", &currentNumber);
  // initialization of variables specific to each employee
  int currentHours;
  int currentSalary;
  char currentBackground;
  int currentWeekly;
  int currentHourly;
  int currentPiece;
  int currentPieceValue;
  int numberOfItems;
  int doWhileIterator = 0;
  int j = 0;
  int i;
  // compares value of currentPaycode to cases
  switch(currentPaycode) {
    case 'W':
        for (i = 0; i < currentNumber; i++) {
            printf("Enter the number of hours Employee %d worked: ", i + 1);
            scanf(" %d", &currentHours);
            printf("Enter the weekly salary for Employee %d: ", i + 1);
            scanf(" %d", &currentWeekly);
            printf("If the worker is international, please enter (I or i). Otherwise, enter (D or d): ");
            scanf(" %c", &currentBackground);
	    // checks if the employee is international
            if (currentBackground == 'I' || currentBackground == 'i') {
              if (currentHours > 20) {
                printf("\nEmployee %d worked too many hours this week.\n", i + 1);
                currentHours = 20;
              }
              currentSalary = currentWeekly;
	      // edits values of all relevant statistics and prints the current employees weekly wage
              totalAll = totalAll + currentSalary;
              totalInternational = totalInternational + currentSalary;
              totalWeekly = totalWeekly + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", i + 1, currentSalary);
            }
            else if (currentBackground == 'D' || currentBackground == 'd') {
	          currentSalary = currentWeekly;
              totalAll = totalAll + currentSalary;
              totalDomestic = totalDomestic + currentSalary;
              totalWeekly = totalWeekly + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", i + 1, currentSalary);
            }
            else {
              printf("Invalid input");
            }
        }
        break;
    case 'w':
	while(j < currentNumber) {
            printf("Enter the number of hours Employee %d worked: ", j+1);
            scanf(" %d", &currentHours);
            printf("Enter the weekly salary for Employee %d: ", j+1);
            scanf(" %d", &currentWeekly);
            printf("If the worker is international, please enter (I or i). Otherwise, enter (D or d): ");
            scanf(" %c", &currentBackground);
            if (currentBackground == 'I' || currentBackground == 'i') {
              if (currentHours > 20) {
                printf("\nEmployee %d worked too many hours this week.\n", j+1);
                currentHours = 20;
              }
              currentSalary = currentWeekly;
              totalAll = totalAll + currentSalary;
              totalInternational = totalInternational + currentSalary;
              totalWeekly = totalWeekly + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", j + 1, currentSalary);
            }
            else if (currentBackground == 'D' || currentBackground == 'd') {
	          currentSalary = currentWeekly;
              totalAll = totalAll + currentSalary;
              totalDomestic = totalDomestic + currentSalary;
              totalWeekly = totalWeekly + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", j + 1, currentSalary);
            }
            else {
              printf("Invalid input");
            }
	    j++;
        }
    break;
    case 'H':
    for (i = 0; i < currentNumber; i++) {
            printf("Enter the number of hours Employee %d worked: ", i + 1);
            scanf(" %d", &currentHours);
            printf("Enter the hourly wage for Employee %d: ", i + 1);
            scanf(" %d", &currentHourly);
            printf("If the worker is international, please enter (I or i). Otherwise, enter (D or d): ");
            scanf(" %c", &currentBackground);
            if (currentBackground == 'I' || currentBackground == 'i') {
              if (currentHours > 20) {
                printf("\nEmployee %d worked too many hours this week.\n", i + 1);
                currentHours = 20;
              }
              currentSalary = currentHourly;
              totalAll = totalAll + currentSalary;
              totalInternational = totalInternational + currentSalary;
              totalHourly = totalHourly + currentSalary;
              printf("\nEmployee %d earned $%d this week.\n\n", i + 1, currentSalary);
            }
            else if (currentBackground == 'D' || currentBackground == 'd') {
	          currentSalary = currentHourly;
              totalAll = totalAll + currentSalary;
              totalDomestic = totalDomestic + currentSalary;
              totalHourly = totalHourly + currentSalary;
              printf("\nEmployee %d earned $%d this week.\n\n", i + 1, currentSalary);
            }
            else {
              printf("Invalid input");
            }
        }
    break;
    case 'h':
    while(j < currentNumber) {
            printf("Enter the number of hours Employee %d worked: ", j+1);
            scanf(" %d", &currentHours);
            printf("Enter the hourly wage for Employee %d: ", j+1);
            scanf(" %d", &currentHourly);
            printf("If the worker is international, please enter (I or i). Otherwise, enter (D or d): ");
            scanf(" %c", &currentBackground);
            if (currentBackground == 'I' || currentBackground == 'i') {
              if (currentHours > 20) {
                printf("\nEmployee %d worked too many hours this week.\n", j+1);
                currentHours = 20;
              }
              if (currentHours > 10) {
                currentSalary = (10 * currentHourly) + (1.5 * (currentHours - 10) * currentHourly);
              }
              else {
                currentSalary = (currentHourly * currentHours);
              }
              totalAll = totalAll + currentSalary;
              totalInternational = totalInternational + currentSalary;
              totalHourly = totalHourly + currentSalary;
	          printf("\nEmployee %d earned $%d this week.\n\n", j + 1, currentSalary);
            }
            else if (currentBackground == 'D' || currentBackground == 'd') {
              if (currentHours > 10) {
                currentSalary = (10 * currentHourly) + (1.5 * (currentHours - 10) * currentHourly);
              }
              else {
                currentSalary = (currentHourly * currentHours);
              }
	          totalAll = totalAll + currentSalary;
              totalDomestic = totalDomestic + currentSalary;
              totalHourly = totalHourly + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", j + 1, currentSalary);
            }
            else {
              printf("Invalid input");
            }
	    j++;
        }
    break;
    case 'C':
    for (i = 0; i < currentNumber; i++) {
            printf("Enter the number of hours Employee %d worked: ", i + 1);
            scanf(" %d", &currentHours);
            printf("If the worker is international, please enter (I or i). Otherwise, enter (D or d): ");
            scanf(" %c", &currentBackground);
            if (currentBackground == 'I' || currentBackground == 'i') {
              if (currentHours > 20) {
                printf("\nEmployee %d worked too many hours this week.\n", i + 1);
                currentHours = 20;
              }
              currentSalary = (currentHours * 7.1) + 250;
              totalAll = totalAll + currentSalary;
              totalInternational = totalInternational + currentSalary;
              totalCommission = totalCommission + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", i + 1, currentSalary);
            }
            else if (currentBackground == 'D' || currentBackground == 'd') {
	          currentSalary = (currentHours * 7.1) + 250;
              totalAll = totalAll + currentSalary;
              totalDomestic = totalDomestic + currentSalary;
              totalCommission = totalCommission + currentSalary;
              printf("\nEmployee %d earned $%d this week.\n\n", i + 1, currentSalary);
            }
            else {
              printf("Invalid input");
            }
        }
    break;
    case 'c':
        do {
            printf("Enter the number of hours Employee %d worked: ", doWhileIterator + 1);
            scanf(" %d", &currentHours);
            printf("If the worker is international, please enter (I or i). Otherwise, enter (D or d): ");
            scanf(" %c", &currentBackground);
            if (currentBackground == 'I' || currentBackground == 'i') {
              if (currentHours > 20) {
                printf("\nEmployee %d worked too many hours this week.\n", doWhileIterator + 1);
                currentHours = 20;
              }
              currentSalary = (currentHours * 7.1) + 250;
              totalAll = totalAll + currentSalary;
              totalInternational = totalInternational + currentSalary;
              totalCommission = totalCommission + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", doWhileIterator + 1, currentSalary);
            }
            else if (currentBackground == 'D' || currentBackground == 'd') {
	            currentSalary = (currentHours * 7.1) + 250;
                totalAll = totalAll + currentSalary;
                totalDomestic = totalDomestic + currentSalary;
                totalCommission = totalCommission + currentSalary;
	        printf("\nEmployee %d earned $%d this week.\n\n", doWhileIterator + 1, currentSalary);
            }
            else {
                printf("Invalid input");
            }
            doWhileIterator++;
        } while(doWhileIterator < currentNumber);
        doWhileIterator = 0;
        break;
    case 'P':
    	do {
            printf("Enter the number of pieces Employee %d produced: ", doWhileIterator + 1);
            scanf(" %d", &currentPiece);
            printf("Enter the value of each piece for Employee %d: ", doWhileIterator + 1);
            scanf(" %d", &currentPieceValue);
            printf("If the worker is international, please enter (I or i). Otherwise, enter (D or d): ");
            scanf(" %c", &currentBackground);
            if (currentBackground == 'I' || currentBackground == 'i') {
              currentSalary = currentPiece * currentPieceValue;
              totalAll = totalAll + currentSalary;
              totalInternational = totalInternational + currentSalary;
              totalPiece = totalPiece + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", doWhileIterator + 1, currentSalary);
            }
            else if (currentBackground == 'D' || currentBackground == 'd') {
	          currentSalary = currentPiece * currentPieceValue;
              totalAll = totalAll + currentSalary;
              totalDomestic = totalDomestic + currentSalary;
              totalPiece = totalPiece + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", doWhileIterator + 1, currentSalary);
            }
            else {
              printf("Invalid input");
            }
            doWhileIterator++;
        } while (doWhileIterator < currentNumber);
    doWhileIterator = 0;
    break;
    case 'p':
    while(j < currentNumber) {
            printf("Enter the number of pieces Employee %d produced: ", j + 1);
            scanf(" %d", &currentPiece);
            printf("Enter the value of each piece for Employee %d: ", j + 1);
            scanf(" %d", &currentPieceValue);
            printf("If the worker is international, please enter (I or i). Otherwise, enter (D or d): ");
            scanf(" %c", &currentBackground);
            if (currentBackground == 'I' || currentBackground == 'i') {
              if (currentHours > 20) {
                printf("\nEmployee %d worked too many hours this week.\n", j+1);
                currentHours = 20;
              }
              currentSalary = currentPiece * currentPieceValue;
              totalAll = totalAll + currentSalary;
              totalInternational = totalInternational + currentSalary;
              totalPiece = totalPiece + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", j + 1, currentSalary);;
            }
            else if (currentBackground == 'D' || currentBackground == 'd') {
	          currentSalary = currentPiece * currentPieceValue;
              totalAll = totalAll + currentSalary;
              totalDomestic = totalDomestic + currentSalary;
              totalPiece = totalPiece + currentSalary;
	      printf("\nEmployee %d earned $%d this week.\n\n", j + 1, currentSalary);;
            }
            else {
              printf("Invalid input");
            }
	    j++;
        }
    break;
    default :
    // if the given paycode is not one of the preceding 8 cases, "Invalid paycode" is printed
    printf("Invalid paycode");
  }
 }
 
}
