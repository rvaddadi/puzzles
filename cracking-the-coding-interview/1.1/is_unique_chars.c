#include <stdio.h>

int is_unique_chars(char *string) {
  char *p1;
  char *p2;

  p1 = string;

  while (*p1) {
    p2 = p1 + 1;

    while (*p2) {
      if (*p1 == *p2) {
        return 0;
      }

      p2++;
    }

    p1++;
  }

  return 1;
}

int main(int argc, const char *argv[]) {
  printf("1 = %d\n1 = %d\n0 = %d\n\n", is_unique_chars(""), is_unique_chars("abc"), is_unique_chars("abb"));

  return 0;
}
