IDIR=include
ODIR=obj
SDIR=src
TDIR=test
BDIR=bin

CC=gcc
CFLAGS=-I$(IDIR) -Wall

_DEPS=array.h qsort.h mergesort.h
DEPS=$(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ=array.o qsort.o mergesort.o
OBJ=$(patsubst %,$(ODIR)/%,$(_OBJ))

_TESTS=qsort mergesort
TESTS=$(patsubst %,$(TDIR)/$(BDIR)/%,$(_TESTS))

all: compile

compile: $(OBJ)

compile_test: compile $(TESTS)

test: compile_test
	$(TDIR)/$(BDIR)/qsort
	$(TDIR)/$(BDIR)/mergesort

clean:
	rm -rf $(OBJ) $(TDIR)/$(BDIR)/*

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

$(TDIR)/$(BDIR)/%: $(TDIR)/test_%.c $(OBJ)
	$(CC) -o $@ $< $(CFLAGS) $(OBJ)
