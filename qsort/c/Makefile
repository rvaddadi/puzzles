CC=gcc
CFLAGS=-Wall

all: compile

compile:
	$(CC) $(CFLAGS) qsort.c -o qsort

test: compile
	./qsort < test_case.txt

clean:
	rm qsort
