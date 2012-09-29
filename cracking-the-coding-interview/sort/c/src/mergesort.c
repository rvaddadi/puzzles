#include "mergesort.h"

t_array* _array_mergesort_divide(t_array array);
t_array _array_mergesort_merge(t_array* arrays);

t_array array_mergesort(t_array array) {
  t_array sorted_array;
  t_array *divided_arrays;

  if (array->size <= 1) {
    sorted_array = array;
  }
  else {
    divided_arrays = _array_mergesort_divide(array);

    divided_arrays[0] = array_mergesort(divided_arrays[0]);
    divided_arrays[1] = array_mergesort(divided_arrays[1]);

    sorted_array = _array_mergesort_merge(divided_arrays);

    array_free(divided_arrays[0]);
    array_free(divided_arrays[1]);
    free(divided_arrays);
  }

  return sorted_array;
}

t_array* _array_mergesort_divide(t_array array) {
  t_array *arrays;
  t_array array_to_push;
  int element;
  int i;

  arrays = (t_array*) malloc(sizeof(t_array) * 2);

  arrays[0] = array_new(array->max_size);
  arrays[1] = array_new(array->max_size);

  for (i = 0; i < array->size; i++) {
    element = array->elements[i];

    array_to_push = arrays[(i < array->size / 2) ? 0 : 1];

    array_push(array_to_push, element);
  }

  return arrays;
}

t_array _array_mergesort_merge(t_array* arrays) {
  t_array merged_array;
  int *indexes;
  int index_to_push;

  merged_array = array_new(arrays[0]->max_size);

  indexes = (int*) malloc(sizeof(int) * 2);

  indexes[0] = 0;
  indexes[1] = 0;

  while (indexes[0] < arrays[0]->size || indexes[1] < arrays[1]->size) {

    if (indexes[0] >= arrays[0]->size) {
      index_to_push = 1;
    }
    else if (indexes[1] >= arrays[1]->size) {
      index_to_push = 0;
    }
    else if (arrays[0]->elements[indexes[0]] < arrays[1]->elements[indexes[1]]) {
      index_to_push = 0;
    }
    else {
      index_to_push = 1;
    }

    array_push(merged_array, arrays[index_to_push]->elements[indexes[index_to_push]]);
    indexes[index_to_push]++;
  }

  free(indexes);

  return merged_array;
}

