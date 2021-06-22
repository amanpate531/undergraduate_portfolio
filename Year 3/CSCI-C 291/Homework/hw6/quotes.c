#include <stdio.h>
#include <string.h>

char* clean_quotes(char* phrase, int length);

int main (void) {
  char johnString[15];
  char johnSingle[15];
  char johnDouble[15];
  char test[100];

  strcpy(johnString, "john");
  strcpy(johnSingle, "'john'");
  strcpy(johnDouble, "\"john\"");
  strcpy(test, "'Hi, I'm Aman. I'm not an \"avid\" 'collector' of 'Nintendo' products.\"'");

  printf("%s\n", johnString);
  printf("%s\n", johnSingle);
  printf("%s\n", johnDouble);
  printf("The single and double quotes are not ignored by C\n");
  printf("%s\n", clean_quotes(johnDouble, 8));
  printf("%s\n", clean_quotes(johnSingle, 8));
  printf("%s\n", clean_quotes(test, 100));
}

char* clean_quotes(char* phrase, int length) {
  int i;
  int j = 0;
  for (i == 0; i < length; i++) {
    if (phrase[i] != '"' && phrase[i] != '\\' && phrase[i] != '\'') {
      phrase[j++] = phrase[i];
    }
    else if (phrase[i] == '\'' && phrase[i+1] != ' ' && phrase[i-1] != ' ' && i != 0 && phrase[i+1] != '\0') {
      phrase[j++] = '\'';
    }
    else if (phrase[i+1] == '"' && phrase[i] == '\\') {
      phrase[j++] = '"';
    }
    else if (phrase[i+1] != '"' && phrase[i] == '\\') {
      phrase[j++] = '\\';
    }
  }
  if (j > 0) {
    phrase[j] = 0;
  }
  return phrase;
}
