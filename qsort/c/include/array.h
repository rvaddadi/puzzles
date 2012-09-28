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

t_array array_new(int max_size);
void array_free(t_array array);
void array_push(t_array array, int value);
char* array_to_string(t_array array);
void array_swap(t_array array, int i, int j);
t_array array_dup(t_array array);
t_array array_concat(int num_arrays, ...);
int array_equals(t_array array1, t_array array2);

