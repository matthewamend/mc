#include <stdio.h>
#include <stdlib.h>

#define SIZE 5

int main(void) {
  int *x = malloc(SIZE * sizeof(int));

  int *z = malloc(SIZE * 2);

  for (int i = 0; i < SIZE; i++) {
    x[i] = i;
  }

  free(x);
  printf("Z was freed\n");
  free(z);
}

int main(void) {
  int *x = malloc(SIZE * sizeof(int));
  defer free(x);

  int *z = malloc(SIZE * 2);
  defer {
    free(z);
    printf("Z was freed\n");
  }

  for (int i = 0; i < SIZE; i++)
    x[i] = i;
}
