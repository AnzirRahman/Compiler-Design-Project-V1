# Compiler Project

This project implements a simple compiler using Flex and Bison.  
It includes the following files:
- `lexer.l` – Lexical analyzer definitions.
- `parser.y` – Grammar and semantic actions.
- `Makefile` – Build instructions.
- Generated files (`lex.yy.c`, `parser.tab.c`, `parser.tab.h`) are created during the build.

## Building the Project
Run the following commands from the project root:
```
make
```
This will generate the necessary files and compile the executable (named `compiler`).

## Running the Compiler
To execute the compiler using the provided input file:
```
make run
```

## Cleaning Up
To remove generated files and the executable, run:
```
make clean
```

Enjoy building and testing your compiler!