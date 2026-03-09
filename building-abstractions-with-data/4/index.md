---
slug: exercise-2-4
name: Exercise 2.4
date: 26-03-09 10:31
---

Here is an alternative procedural representation of pairs. For this representation, verify that `(car (cons x y))` yields `x` for any objects `x` and `y`.

```racket
(define (cons x y)
  (lambda (m) (m x y)))
(define (car z)
  (z (lambda (p q) p)))
```

What is the corresponding definition of `cdr`? (Hint: To verify that this works, make use of the substitution model of
Section 1.1.5.)

## Solution

In the applicative-order evaluation of expressions, we first evaluate the arguments and apply the procedure to them. Below are the verification steps for the correctness of `car`.

```racket
(car z)
(car (lambda (m) (m x y)))
((lambda (m) (m x y)) (lambda (p q) p))
((lambda (p q) p) x y)
x
```

The corresponding definition of `cdr` would look like this:

```racket
(define (cdr z)
  (z (lambda (p q) q)))
```
