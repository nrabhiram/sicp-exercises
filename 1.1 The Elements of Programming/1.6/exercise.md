# Exercise 1.6

Alyssa P. Hacker doesn’t see why `if` needs to be provided as a special form. “Why can’t I just define it as an ordinary procedure in terms of cond?” she asks. Alyssa’s friend Eva Lu Ator claims this can indeed be done, and she defines a new version of `if`:

```scheme
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
```
Eva demonstrates the program for Alyssa:

```scheme
(new-if (= 2 3) 0 5)
5
(new-if (= 1 1) 0 5)
0
```

Delighted, Alyssa uses `new-if` to rewrite the *square-root* program:

```scheme
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
```
What happens when Alyssa attempts to use this to compute square roots? Explain.

# Solution

`new-if` is a procedure defined by the programmer. Unlike `if`, it isn't a special form. In `if`, if the *predicate* yields `#t`, the *consequent* is evaluated. Otherwise, if it yields `#f`, the *alternative* is evaluated.

`new-if` will follow *applicative-order evaluation*. So, all of the subexpressions are evaluated, and the operands are substituted as arguments for the procedure application defined by the operator.

This is problematic when `new-if` is used in `sqr-iter` as the *predicate*, *then-clause*, and *else-clause* are all evaluated before the procedure is applied. But, the *else-clause* is a call to the procedure itself. So, we end up in an infinite loop where we call the procedure `sqr-iter` recursively.
