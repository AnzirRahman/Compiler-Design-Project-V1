# Makefile for compiler project

# Files
LEXER = lexer.l
PARSER = parser.y
TARGET = compiler
INPUT = input.txt

# Build everything
all: $(TARGET)
	@echo "Running the compiler..."
	./$(TARGET) < $(INPUT)

# Compile the project
$(TARGET): lex.yy.c parser.tab.c
	gcc lex.yy.c parser.tab.c -o $(TARGET)

# Generate lex.yy.c and parser.tab.c/.h
lex.yy.c: $(LEXER) parser.tab.h
	flex $(LEXER)

parser.tab.c parser.tab.h: $(PARSER)
	bison -d $(PARSER)

# Clean everything
clean:
	rm -f lex.yy.c parser.tab.c parser.tab.h $(TARGET)

# Just run the compiler with current input
run:
	./$(TARGET) < $(INPUT)
