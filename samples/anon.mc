#include <assert.h>
#include <stdio.h>

struct {
  int x;
  int y;
} X;

struct Z {
  int x;
  int y;
};

struct {
  int x;
  int y;
} foo() {

  return (struct {
    int x;
    int y;
  }){
      .x = X.x,
      .y = X.y,
  };
}

int main(void) {
  X.x = 3;
  X.y = 7;

  struct {
    int x;
    int y;
  } p = foo();
  assert(p.x == 3 && p.y == 7);
  return 0;
}
