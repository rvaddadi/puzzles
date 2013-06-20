Bank
====

Solution for the coding challenge [Banco][1], from
[Olimpíada Brasileira de Informática][2].

Install
-------

This solution is written in [Ruby][3]. It's tested in 2.0, but should work in
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


[1]: http://olimpiada.ic.unicamp.br/pratique/programacao/nivel2/2012f2p2_banco
[2]: http://olimpiada.ic.unicamp.br/
[3]: http://www.ruby-lang.org/
