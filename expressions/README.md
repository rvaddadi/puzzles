Expressions
===========

Solve simple mathematical expressions Kata.

Assumes well formed expressions with the following operations available:

| Operation | Meaning |
|---|---|
| `+` | Sum |
| `-` | Subtraction |
| `*` | Multiplication |
| `/` | Integer Division |
| `(...)` | Specify operations precedence |

Operations precedence follow mathematical conventions, multiplication and
division happening before sum and subtraction.

Examples
--------

```irb
> resolve '10 - 5 + 5 - 3'
#=> 7
> resolve '(5 + 2) * 10'
#=> 70
```

Run tests
---------

1. Install [Ruby][1] and [Bundler][2].
2. `$ bundle install`.
3. `$ rspec`.


[1]: http://www.ruby-lang.org/
[2]: http://bundler.io/
