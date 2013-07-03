Bank - Ruby
===========

Install
-------

This solution is written in [Ruby][1]. It's tested in 2.0, but should work in
1.9 as well.

Usage
-----

```bash
$ ruby bin/bank [input-file]
```

`[input-file]` is a optional parameter, if none is passed, read from `stdin`.

That's not required, but it costs nothing to implement thanks to the
magic of `ARGF` so I thought I would put it anyways.

Run tests
---------

Install dependencies with:

```bash
$ bundle install
```

Run suite with:

```bash
$ bundle exec rspec
```


[1]: http://www.ruby-lang.org/
