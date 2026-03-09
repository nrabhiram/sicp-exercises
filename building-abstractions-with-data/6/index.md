---
slug: exercise-2-5
name: Exercise 2.5
date: 26-03-09 13:59
---

In case representing pairs as procedures wasn’t mind-boggling enough, consider that, in a language that can manipulate procedures, we can get by without numbers (at least insofar as nonnegative integers are concerned) by implementing 0 and the operation of adding 1 as

```racket
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
```

This representation is known as *Church numerals*, after its inventor, Alonzo Church, the logician who invented the λ-calculus. 

Define `one` and `two` directly (not in terms of `zero` and `add-1`). (Hint: Use substitution to evaluate `(add-1 zero)`). Give a direct definition of the addition procedure `+` (not in terms of repeated application of `add-1`).

## Solution

Given the implementation of `zero` and the operation `add-1`, we can use substitution to find the value of `one`.

```racket
(add-1 zero)
(add-1 (lambda (f) (lambda (x) x)))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
(lambda (f) (lambda (x) (f x)))
```

So, the `one` can be defined as follows:

```racket
(define one (lambda (f) (lambda (x) (f x))))
```

Now, we can use the implementation of `one` and `add-1` to find the value of `two`.

```racket
(add-1 one)
(add-1 (lambda (f) (lambda (x) (f x))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
(lambda (f) (lambda (x) (f (f x))))
```

`two` can be defined as follows:

```racket
(define two (lambda (f) (lambda (x) (f (f x)))))
```

By extrapolation, we can deduce that the procedure `add` is defined as shown:

```racket
(define (add a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))
```
