#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <assert.h>
#include <array.h>


int main() {
  FILE *test_case;
  char *line = (char*) malloc(sizeof(char) * 1000);
  char *element;
  t_array array;

  test_case = fopen("test_case.txt", "r");

  while (fgets(line, 1000, test_case) != NULL) {
    array = array_new(1000);

    for (element = strtok(line, " "); element != NULL; element = strtok(NULL, " ")) {
      array_push(array, atoi(element));
    }

    printf("%s\n", array_to_string(array_qsort(array)));

    array_free(array);
  }

  fclose(test_case);

  return 0;
}

