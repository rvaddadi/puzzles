#include "qsort.h"

void test_ordered() {
  t_array array;

  array = array_new(5);

  array_push(array, 1);
  array_push(array, 2);
  array_push(array, 3);
  array_push(array, 4);
  array_push(array, 5);

  printf("%s\n", array_to_string(array));

  array_free(array);
}

void test_reverse() {
  t_array array;

  array = array_new(5);

  array_push(array, 1);
  array_push(array, 2);
  array_push(array, 3);
  array_push(array, 4);
  array_push(array, 5);

  printf("%s\n", array_to_string(array));

  array_free(array);
}

int main() {
  test_ordered();
  test_reverse();

  assert(0);

  return 0;
}

