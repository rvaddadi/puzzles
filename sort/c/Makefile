IDIR=include
ODIR=obj
SDIR=src
TDIR=test
BDIR=bin

CC=gcc
CFLAGS=-I$(IDIR) -Wall

_DEPS=array.h qsort.h
DEPS=$(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ=array.o qsort.o
OBJ=$(patsubst %,$(ODIR)/%,$(_OBJ))

_TESTS=qsort
TESTS=$(patsubst %,$(TDIR)/$(BDIR)/%,$(_TESTS))

all: compile

compile: $(OBJ)

compile_test: compile $(TESTS)

test: compile_test
	$(TDIR)/$(BDIR)/qsort

clean:
	rm -rf $(OBJ) $(TDIR)/$(BDIR)/*

$(ODIR)/%.o: $(SDIR)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

$(TDIR)/$(BDIR)/%: $(TDIR)/test_%.c $(OBJ)
	$(CC) -o $@ $< $(CFLAGS) $(OBJ)
