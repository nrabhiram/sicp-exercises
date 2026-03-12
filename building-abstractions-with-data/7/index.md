---
slug: exercise-2-7
name: Exercise 2.7
date: 26-03-09 23:19
---

Alyssa’s program is incomplete because she has not specified the implementation of the interval abstraction. Here is a definition of the interval constructor:

```racket
(define (make-interval a b) (cons a b))
```

Define selectors `upper-bound` and `lower-bound` to complete the implementation.
