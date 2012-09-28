Sorting in C
============

Implementations of [quicksort](http://en.wikipedia.org/wiki/Quicksort) and [mergesort](http://en.wikipedia.org/wiki/Merge_sort).

They are meant to be easy to read, as I'm studying and not _really_ worrying about performance. Sometimes I go with the naïve approach on purpose, to make the code easier on the eyes.

Yet, I believe these implementations are free of memory leaks and nasty things like that.

Testing
=======

These implementations are covered by integration tests. Run them with `make test`.

To create a new test, add a file under the `test` directory named `test_*.c`. Then add this name in `Makefile` in a variable called `_TESTS` and in the target `test`.
