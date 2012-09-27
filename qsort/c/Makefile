all: compile

compile:
	gcc -Wall qsort.c -o qsort

test: compile
	./qsort < test_case.txt

clean:
	rm qsort
