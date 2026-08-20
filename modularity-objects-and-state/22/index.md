---
slug: exercise-3-22
name: Exercise 3.22
date: 19-08-26 15:38
---

Instead of representing a queue as a pair of pointers, we can build a queue as a procedure with local state. The local state will consist of pointers to the beginning and the end of an ordinary list. Thus, the `make-queue` procedure will have the form

```racket
(define (make-queue)
  (let ((front-ptr . . . )
        (rear-ptr . . . ))
    ⟨definitions of internal procedures⟩
    (define (dispatch m) . . .)
    dispatch))
```

Complete the definition of `make-queue` and provide implementations of the queue operations using this representation.
