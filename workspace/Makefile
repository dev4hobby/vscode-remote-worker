# Makefile for hello.c

# Compiler and flags
CC = gcc
CFLAGS = -g

# Source and executable filenames
SRC = hello.c
EXECUTABLE = hello

all: $(EXECUTABLE)

$(EXECUTABLE): $(SRC)
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean

clean:
	rm -f $(EXECUTABLE)
