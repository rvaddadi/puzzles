#include "qsort.h"

int _array_qsort_get_pivot(t_array array, t_array *array_without_pivot);
t_array* _array_qsort_partition(t_array array, int pivot);

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

