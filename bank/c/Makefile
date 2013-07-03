default: compile

compile: bin/bank

bin/bank: src/bank.c
	gcc -Wall src/bank.c -o bin/bank

compile_debug:
	gcc -Wall -g src/bank.c -o bin/bank

test: test_simple

test_simple: compile
	bin/bank < test/simple

test_long: compile
	bin/bank < test/long

debug: compile_debug
	ddd bin/bank
