#include <stdio.h>

void remove_duplicates(char *string) {
  char *current_letter;
  char *previous_letter;

  current_letter = string;

  while (*current_letter) {
    previous_letter = string;

    while (current_letter != previous_letter) {

      if (*current_letter == *previous_letter) {

        previous_letter = current_letter;
        while (*previous_letter) {
          *previous_letter = *(previous_letter + 1);
          previous_letter++;
        }

        break;
      }
      previous_letter++;
    }
    current_letter++;
  }
}

int main(int argc, const char *argv[]) {
  char string[] = "abcbde";

  remove_duplicates(string);

  printf("%s", string);

  return 0;
}
