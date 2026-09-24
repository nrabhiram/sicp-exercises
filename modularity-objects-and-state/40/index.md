---
slug: exercise-3-40
name: Exercise 3.40
date: 24-09-26 17:07
---

Give all possible values of x that can result from executing

```racket
(define x 10)
(parallel-execute 
  (lambda () (set! x (* x x)))
  (lambda () (set! x (* x x x))))
```

Which of these possibilities remain if we instead use serialized procedures:

```racket
(define x 10)
(define s (make-serializer))
(parallel-execute 
  (s (lambda () (set! x (* x x))))
  (s (lambda () (set! x (* x x x)))))
```

## Solution

**Note:** Some of these values are repeated for different sequences of events. I've stated all of these sequences, instead of just listing out all of the unique possible results.

```
1,000,000: P1 sets x to 100 and P2 cubes that to set it to a million
1,000,000: P2 sets x to 1000, and P1 squares that to set it to a million
10,000: P1 accesses x once, reads 10, P2 sets x to 1000, and when P1 accesses x again, it reads 1000.
100,000: P2 accesses x once, reads 10, P1 sets x to 100, and when P2 accesses x the next two times, it reads 100.
10,000: P2 accesses x twice, reads 10 each time, P1 sets x to 100, and when P2 accesses x for the last time, it reads 100.
100: P2 accesses x thrice, P1 accesses x twice, P2 assigns 1000 to x, and P1 finally assigns 100 to x.
1000: P1 accesses x twice, P2 accesses x thrice, P1 assigns 100 to x, and P2 finally assigns 1000 to x
```

Only the first two possibilities remain if we use serialized procedures because reads and assignments can't be interleaved.
