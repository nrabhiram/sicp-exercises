---
slug: exercise-1-34
name: Exercise 1.34
date: 26-02-15 09:02
---

Suppose we define the procedure

```racket
(define (f g) (g 2))
```

Then we have

```racket
(f square)
4
(f (lambda (z) (* z (+ z 1))))
6
```

What happens if we (perversely) ask the interpreter to evaluate the combination `(f f)`? Explain.

## Solution

```racket
(f f)
(f 2)
(2 2)
```

We receive the following error: 

```
application: not a procedure;
 expected a procedure that can be applied to arguments
  given: 2
  context...:
  body of "/sicp-exercises/building-abstractions-with-procedures/34/solution.rkt"
```
