# Exercise 2.6

In case representing pairs as procedures wasn’t mind-boggling enough, consider that, in a language that can manipulate procedures, we can get by without numbers (at least insofar as nonnegative integers are concerned) by implementing 0 and the operation of adding 1 as

```scheme
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
```

This representation is known as *Church numerals*, after its inventor, Alonzo Church, the logician who invented the λ-calculus. 

Define `one` and `two` directly (not in terms of `zero` and `add-1`). (Hint: Use substitution to evaluate `(add-1 zero)`). Give a direct definition of the addition procedure `+` (not in terms of repeated application of `add-1`).

# Solution

Given the implementation of 0 and the operation of adding 1, the value of 1 is represented as follows:

```scheme
(add-1 zero)
(add-1 (lambda (f) (lambda (x) x)))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
(lambda (f) (lambda (x) (f x)))
```

Hence, `one` is defined as:

```scheme
(define one (lambda (f) (lambda (x) (f x))))
```

Similarly, the value of 2 is represented as follows:

```scheme
(add-1 one)
(add-1 (lambda (f) (lambda (x) (f x))))
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
(lambda (f) (lambda (x) (f (f x))))
```

And `two` is defined as:

```scheme
(define two (lambda (f) (lambda (x) (f (f x)))))
```

From this pattern, we can deduce that the addition of two numbers can be defined by a procedure as shown:

```scheme
(define (add a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))
```