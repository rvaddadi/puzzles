#include "array.h"
#include "mergesort.h"

t_array ordered_array;

void setup() {
  ordered_array = array_new(5);

  array_push(ordered_array, 1);
  array_push(ordered_array, 2);
  array_push(ordered_array, 3);
  array_push(ordered_array, 4);
  array_push(ordered_array, 5);
}

void teardown() {
  array_free(ordered_array);
}

void test_ordered() {
  t_array subject;

  subject = array_new(5);

  array_push(subject, 1);
  array_push(subject, 2);
  array_push(subject, 3);
  array_push(subject, 4);
  array_push(subject, 5);

  assert(array_equals(ordered_array, array_mergesort(subject)));

  array_free(subject);
}

void test_reverse() {
  t_array subject;

  subject = array_new(5);

  array_push(subject, 5);
  array_push(subject, 4);
  array_push(subject, 3);
  array_push(subject, 2);
  array_push(subject, 1);

  assert(array_equals(ordered_array, array_mergesort(subject)));

  array_free(subject);
}

void test_random() {
  t_array subject;

  subject = array_new(5);

  array_push(subject, 3);
  array_push(subject, 2);
  array_push(subject, 4);
  array_push(subject, 5);
  array_push(subject, 1);

  assert(array_equals(ordered_array, array_mergesort(subject)));

  array_free(subject);
}

int main() {
  setup();

  test_ordered();
  test_reverse();

  teardown();

  printf("\n\n%s\n\n", "All tests passed!!");
  return 0;
}

