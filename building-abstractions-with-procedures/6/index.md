---
slug: exercise-1-6
name: Execrise 1.6
date: 23-12-25 15:38
---

Alyssa P. Hacker doesn’t see why `if` needs to be provided as a special form. “Why can’t I just define it as
an ordinary procedure in terms of `cond`?” she asks. Alyssa’s friend Eva Lu Ator claims this can indeed be done, and she defines a new version of `if`:

```racket
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
```

Eva demonstrates the program for Alyssa:

```racket
(new-if (= 2 3) 0 5)
5
(new-if (= 1 1) 0 5)
0
```

Delighted, Alyssa uses new-if to rewrite the square-root program:

```racket
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
```

What happens when Alyssa attempts to use this to compute square roots? Explain.

## Solution

This leads to an **infinite loop** when `sqrt-iter` is called, and the application of `new-if` is evaluated. `new-if` is a regular procedure. This means that all of the subexpressions are evaluated before `new-if` can be applied. This leads to a never-ending loop because the alternate expression is evaluated repeatedly and can't be further broken down.
