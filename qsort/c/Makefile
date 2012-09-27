IDIR=include
ODIR=obj
SDIR=src

CC=gcc
CFLAGS=-I$(IDIR) -Wall

_DEPS=array.h qsort.h
DEPS=$(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ=array.o qsort.o
OBJ=$(patsubst %,$(ODIR)/%,$(_OBJ))

all: compile

compile: $(OBJ)

compile_test: compile

test: compile compile_test
	./qsort < test_case.txt

clean:
	rm -rf $(OBJ)

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)
