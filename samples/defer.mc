#include <stdio.h>

int main() {
  const char *s =
      "this is not going to appear because it's going to be reassigned";
  defer printf(" bark!\"\n");
  defer printf("%s", s);
  defer {
    defer printf(" woof");
    printf(" says");
  }
  printf("\"dog");
  s = " woof";
  return 0;
}
