---
slug: exercise-3-39
name: Exercise 3.39
date: 24-09-26 16:43
---

Which of the five possibilities in the parallel execution shown above remain if we instead serialize execution as follows:

```racket
(define x 10)
(define s (make-serializer))
(parallel-execute
  (lambda () (set! x ((s (lambda () (* x x))))))
  (s (lambda () (set! x (+ x 1)))))
```

## Solution

Four of the five possibilities shown remain if we serialize execution like this. The interleaving the two accesses to `x` in *P1* isn't possible, but it's still possible to interleave the assignments. So, the only possibility that gets eliminated is the following:

```
110: P2 changes x from 10 to 11 between the two times that P1 accesses the value of x during the evaluation of (* x x).
```

All of the remaining scenarios are still possible.

```
101: P1 sets x to 100 and then P2 increments x to 101. 
121: P2 increments x to 11 and then P1 sets x to x * x. 
11: P2 accesses x, then P1 sets x to 100, then P2 sets x. 
100: P1 accesses x (twice), then P2 sets x to 11, then P1 sets x.
```
