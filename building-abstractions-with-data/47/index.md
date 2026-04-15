---
slug: exercise-2-47
name: Exercise 2.47
date: 26-04-14 22:55
---

Here are two possible constructors for frames:

```racket
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
```

For each constructor supply the appropriate selectors to produce an implementation for frames.
