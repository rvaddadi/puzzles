#include <stdio.h>
#include <string.h>

void reverse(char *string) {
  int length;
  int half_length;
  char temp;
  int i;
  int j;

  length      = strlen(string);
  half_length = length / 2;

  for (i = 0; i < half_length; i++) {
    j = length - i - 1;
    temp = string[i];
    string[i] = string[j];
    string[j] = temp;
  }
}

int main(int argc, const char *argv[]) {
  char case_1[] = "abc";
  char case_2[] = "abcd";

  reverse(case_1);
  reverse(case_2);

  printf("case_1 = '%s', case_2 = '%s'", case_1, case_2);

  return 0;
}
