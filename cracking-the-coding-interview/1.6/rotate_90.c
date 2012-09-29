#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void rotate_90(int **grid, int n) {
  int i;
  int j;
  int n_i;
  int n_j;
  int temp;
  double half_n;
  int half_n_floor;
  int half_n_ceil;

  half_n = (double)n / 2;
  half_n_floor = floor(half_n);
  half_n_ceil  = ceil(half_n);

  for (i = 0; i < half_n_floor; i++) {
    n_i = n - i - 1;
    for (j = 0; j < half_n_ceil; j++) {
      n_j = n - j - 1;

      temp           = grid[i  ][j  ];
      grid[i  ][j  ] = grid[n_j][i  ];
      grid[n_j][i  ] = grid[n_i][n_j];
      grid[n_i][n_j] = grid[j  ][n_i];
      grid[j  ][n_i] = temp;
    }
    printf("\n");
  }
}

void print_grid(int **grid, int n) {
  int i;
  int j;

  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
      printf("%d\t", grid[i][j]);
    }
    printf("\n");
  }
}

int main(int argc, const char *argv[]) {
  int **grid;
  int n;
  int i;
  int j;
  int element;

  n = 4;

  grid = (int**) malloc(sizeof(int*) * n);

  element = 1;
  for (i = 0; i < n; i++) {
    grid[i] = (int*) malloc(sizeof(int) * n);
    for (j = 0; j < n; j++) {
      grid[i][j] = element;
      element++;
    }
  }

  print_grid(grid, n);
  rotate_90 (grid, n);
  printf("\n\n");
  print_grid(grid, n);

  return 0;
}
