# MCC Compiler

This is the mcc compiler, for the MC programming language. It is a fork of
clang/llvm.

To see the regular README for LLVM, see [README-LLVM.md](README-LLVM.md)

## What is the MC programming language?
 
MC is Matt's C, a toy language built as a fun side project.
It is a "C-like" language, meaning that it is based on C, and a primary goal
of MC is to be strictly a superset of C, meaning that C code should be valid MC
code as well, and all MC features should just be additional features on top of
C.

Currently, MC only offers two features:

* Structs with identical fields are considered identical
* Scope-based defer statement. See [this excellent blog post](
https://thephd.dev/c2y-the-defer-technical-specification-its-time-go-go-go
) by [ThePhD](https://github.com/ThePhD).

MC files should be labeled `.mc` for source files and `.mh` file for header files.

### MC code examples

Here are some examples (see more examples in the [`samples`](samples) directory
of the repo):

```C
int *x = malloc(SIZE * sizeof(int));
defer free(x);

int *z = malloc(SIZE * 2);
defer {
    free(z);
    printf("Z was freed\n");
}

for (int i = 0; i < SIZE; i++)
    x[i] = i;
```

```C
struct A {
    int x;
    int y;
};

struct B {
    int x;
    int y;
};

struct A foo() {
    struct B b = {
        .x = 1,
        .y = 2,
    };

    return b; // This is will fail to compile in regular C, but not MC.
}
```

### Future plans for MC

I plan on adding more features to MC. Some overlap to some degree with C++,
although they probably won't be implemented quite the same way.

Some features that I would like to work on adding in the future include:
* Simple method functions for structs
* Some form of reflection (probably as additional compiler `__builtin_...()`
functions)
* Some way to do namespacing
* Possibly some sort of builtin unit test system?

## Installation

As of right now, there is no specific way to install mcc. You will just have
to compile it yourself and run the generated `clang` binary.

## Building

First clone the repo. Since this is a fork of the LLVM repo, which is a very
large project, the repo is huge. I recommend this unless you want to commit
back upstream for some reason:

```sh
git clone --depth=1 https://github.com/matthewamend/mcc
cd mcc
```

To build, you want to enable the `clang` compiler feature of the repo.
This is how I recommend doing so:

```sh
cmake -B build -S llvm \
-DLLVM_ENABLE_PROJECTS=clang \
-DCMAKE_BUILD_TYPE=Release \ # Optional
-G "Unix Makefiles"

# MacOS
cmake --build build -j$(sysctl -n hw.ncpu)
# Linux
cmake --build build -j$(nproc)
```

If you follow these steps, then the compiler executable should be found at
`build/bin/clang`. This will be what you use to compile MC files.

## Usage

If you are familiar with using `clang`, then this should be very familiar.
It is virtually identical, except that mine adds support for the MC language.

```sh
build/bin/clang samples/defer.c -o defer
```

If you are on macOS, you may need to give it the sdk path. To do this, do your
normal command, with the addition of the `-isysroot $(xcrun --show-sdk-path)`.
You can also use a different path if you so choose.

## Contributing

I probably won't accept contributions, just because this is a fun little toy
project to learn about compilers and to have fun designing my own little
language. If you find this cool, and want to tell me, please feel free to do
so :-)

## License
mcc uses the regular license for the LLVM project, the
[Apache License v2.0 with LLVM Exceptions](https://llvm.org/LICENSE.txt).
