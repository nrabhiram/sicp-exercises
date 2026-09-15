---
slug: exercise-3-35
name: Exercise 3.35
date: 16-09-26 00:41
---

Ben Bitdiddle tells Louis that one way to avoid the trouble in Exercise 3.34 is to define a squarer as a new primitive constraint. Fill in the missing portions in Ben’s outline for a procedure to implement such a constraint:

```racket
(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
      (if (< (get-value b) 0)
          (error "square less than 0: SQUARER"
                 (get-value b))
          ⟨alternative1⟩)
      ⟨alternative2⟩))
  (define (process-forget-value) ⟨body1⟩)
  (define (me request) ⟨body2⟩)
  ⟨rest of definition⟩
  me)
```
