#include <stdio.h>
int main () {
  
  FILE *ofPtr;
  FILE *tfPtr;
  FILE *nfPtr;
  FILE *totalfPtr;

  double transDollar;
  int transAccount;
  char masterName[30];
  double masterBalance;
  int masterAccount;
  int accountCount = 0;
  double totalBalance = 0;
  
  ofPtr = fopen("oldmast.dat", "w");
  fprintf(ofPtr, "%s %lf %d\n", "AlanJones", 348.17, 100);
  fprintf(ofPtr, "%s %lf %d\n", "MarySmith", 27.19, 300);
  fprintf(ofPtr, "%s %lf %d\n", "SamSharp", 0.00, 500);
  fprintf(ofPtr, "%s %lf %d\n", "SuzyGreen", -14.22, 700);
  fprintf(ofPtr, "%s %lf %d\n", "JohnAbraham", 230.12, 900);
  fclose(ofPtr);
  
  tfPtr = fopen("trans.dat", "w");
  fprintf(tfPtr, "%d %lf\n", 100, 27.14);
  fprintf(tfPtr, "%d %lf\n", 300, 62.11);
  fprintf(tfPtr, "%d %lf\n", 400, 100.56);
  fprintf(tfPtr, "%d %lf\n", 900, 82.17);
  fclose(tfPtr);
  
  tfPtr = fopen ("trans.dat", "r");
  nfPtr = fopen ("newmast.dat", "w");
  while (!feof (tfPtr)) {
      fscanf (tfPtr, "%d %lf", &transAccount, &transDollar);
      ofPtr = fopen ("oldmast.dat", "r");
      while (!feof (ofPtr)) {
        fscanf (ofPtr, "%s %lf %d ", masterName, &masterBalance, &masterAccount);
	    if (masterAccount == transAccount) {
	      masterBalance = masterBalance - transDollar;
	      accountCount += 1;
	      totalBalance += masterBalance;
	      fprintf(nfPtr, "%s %lf %d\n", masterName, masterBalance, masterAccount);
	      break;
	    }
	    else if (masterAccount > transAccount)  {
	        printf("Unmatched transaction record for account number %d\n", transAccount);
	        break;
	    }
	    else if (feof(tfPtr)) {
		break;
	    }
      }
      fclose(ofPtr);
  }
  fclose(tfPtr);
  ofPtr = fopen("oldmast.dat", "r");
  while (!feof(ofPtr)) {
      fscanf (ofPtr, "%s %lf %d ", masterName, &masterBalance, &masterAccount);
      int matchFound = 0;
      tfPtr = fopen("trans.dat", "r");
      while (!feof(tfPtr)) {
          fscanf (tfPtr, "%d %lf ", &transAccount, &transDollar);
          if (masterAccount == transAccount) {
              matchFound = 1;
          }
      }
      fclose(tfPtr);
      if (matchFound == 0) {
	  accountCount += 1;
	  totalBalance += masterBalance;
          fprintf(nfPtr, "%s %lf %d\n", masterName, masterBalance, masterAccount);
      }
  }
  fclose(ofPtr);
  fclose(nfPtr);
  
  nfPtr = fopen("newmast.dat", "r");
  

  totalfPtr = fopen("totals.dat", "a");
  fprintf(totalfPtr, "Number of customers: %d, Total balance: %lf\n", accountCount, totalBalance);
}
