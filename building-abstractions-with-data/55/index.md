---
slug: exercise-2-55
name: Exercise 2.55
date: 26-04-24 21:46
---

Eva Lu Ator types to the interpreter the expression

```racket
(car ''abracadabra)
```

To her surprise, the interpreter prints back quote. Explain.

## Solution

`''abracadabra` is an alternate form for `(quote (quote abracadabra))`. The outer `quote` prevents the evaluation of the inner expression, and it gets treated as a literal list. This means that the result is a list with the following elements:

1. literal `quote`
2. literal `abracadabra`

So, when we `car` into this list, we get the first element, i.e. the symbol `quote`.
