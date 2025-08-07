#include <assert.h>
#include <stdbool.h>
#include <stdio.h>

#define Result(T, E)                                                           \
  struct {                                                                     \
    bool is_ok;                                                                \
    union {                                                                    \
      T ok;                                                                    \
      E err;                                                                   \
    };                                                                         \
  }

Result(char *, int) foo(int y) {
  if (y != 3) {
    Result(char *, int) err;

    err.is_ok = false;
    err.err = 3;
    return err;
  }

  Result(char *, int) ok;
  ok.is_ok = true;
  ok.ok = ":)";

  return ok;
}

int main(void) {
  Result(char *, int) first;
  first = foo(3);
  assert(first.is_ok);

  Result(char *, int) second;
  second = foo(2);
  assert(!second.is_ok);
}
