---
slug: exercise-3-1
name: Exercise 3.1
date: 21-07-26 22:41
---

An *accumulator* is a procedure that is called repeatedly with a single numeric argument and accumulates its arguments into a sum. Each time it is called, it returns the currently accumulated sum. Write a procedure `make-accumulator` that generates accumulators, each maintaining an independent sum. The input to `make-accumulator` should specify the initial value of the sum; for example

```racket
(define A (make-accumulator 5))
(A 10)
15
(A 10)
25
```
