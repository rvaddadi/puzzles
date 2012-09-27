#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <assert.h>

typedef struct s_array {
  int *elements;
  int size;
  int max_size;
} *t_array;

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

int _array_qsort_get_pivot(t_array array, t_array *array_without_pivot) {
  int pivot;

  assert(array->size > 0);

  *array_without_pivot = array_dup(array);

  pivot = (*array_without_pivot)->elements[(*array_without_pivot)->size - 1];
  (*array_without_pivot)->size--;

  return pivot;
}

t_array* _array_qsort_partition(t_array array, int pivot) {
  t_array *partitions;
  int element;
  int partition_to_push;
  int i;

  partitions = (t_array*) malloc(sizeof(t_array) * 2);
  partitions[0] = array_new(array->size);
  partitions[1] = array_new(array->size);

  for (i = 0; i < array->size; i++) {
    element = array->elements[i];

    partition_to_push = (element < pivot) ? 0 : 1;

    array_push(partitions[partition_to_push], element);
  }

  return partitions;
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

t_array array_qsort(t_array array) {
  t_array sorted_array;
  int pivot;
  t_array pivot_array;
  t_array array_without_pivot;
  t_array *partitions;

  if (array->size <= 0) {
    sorted_array = array;
  }
  else {
    pivot = _array_qsort_get_pivot(array, &array_without_pivot);

    pivot_array = array_new(1);
    array_push(pivot_array, pivot);

    partitions = _array_qsort_partition(array_without_pivot, pivot);

    sorted_array = array_concat(3, array_qsort(partitions[0]), pivot_array, array_qsort(partitions[1]));
  }

  return sorted_array;
}

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

