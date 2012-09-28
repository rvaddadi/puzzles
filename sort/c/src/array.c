#include "array.h"

t_array array_new(int max_size) {
  t_array new_array = (t_array) malloc(sizeof(struct s_array));

  new_array->elements   = (int*) malloc(sizeof(int) * max_size);
  new_array->size     = 0;
  new_array->max_size = max_size;

  return new_array;
}

void array_free(t_array array) {
  free(array->elements);
  free(array);
}

void array_push(t_array array, int value) {
  array->elements[array->size] = value;
  array->size++;
}

char* array_to_string(t_array array) {
  char *string = (char*) malloc(sizeof(char) * 1000);
  int i;

  if (array->size > 0) {
    sprintf(string, "%d", array->elements[0]);

    for (i = 1; i < array->size; i++) {
      sprintf(string, "%s, %d", string, array->elements[i]);
    }
  }

  return string;
}

void array_swap(t_array array, int i, int j) {
  int temp;

  temp = array->elements[i];
  array->elements[i] = array->elements[j];
  array->elements[j] = temp;
}

t_array array_dup(t_array array) {
  t_array array_dup;
  int element;
  int i;

  array_dup = array_new(array->max_size);

  for (i = 0; i < array->size; i++) {
    element = array->elements[i];

    array_push(array_dup, element);
  }

  return array_dup;
}

t_array array_concat(int num_arrays, ...) {
  va_list list_pointer;
  t_array *arrays;
  t_array array;
  t_array result_array;
  int element;
  int result_array_max_size;
  int array_index;
  int i;

  arrays = (t_array*) malloc(sizeof(t_array) * num_arrays);

  va_start(list_pointer, num_arrays);

  result_array_max_size = 0;

  for (array_index = 0; array_index < num_arrays; array_index++) {
    array = va_arg(list_pointer, t_array);

    arrays[array_index] = array;
    result_array_max_size += array->max_size;
  }

  va_end(list_pointer);

  result_array = array_new(result_array_max_size);

  for (array_index = 0; array_index < num_arrays; array_index++) {
    array = arrays[array_index];

    for (i = 0; i < array->size; i++) {
      element = array->elements[i];

      array_push(result_array, element);
    }
  }

  return result_array;
}

int array_equals(t_array array1, t_array array2) {
  int equals;
  int i;

  equals = array1->size == array2->size;

  for (i = 0; equals && i < array1->size; i++) {
    if (array1->elements[i] != array2->elements[i]) {
      equals = 0;
    }
  }

  return equals;
}

