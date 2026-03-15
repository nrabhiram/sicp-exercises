---
slug: exercise-2-21
name: Exercise 2.21
date: 26-03-15 09:26
---

The procedure `square-list` takes a list of numbers as argument and returns a list of the squares of those numbers.

```racket
(square-list (list 1 2 3 4))
(1 4 9 16)
```

Here are two different definitions of `square-list`. Complete both of them by filling in the missing expressions:

```racket
(define (square-list items)
  (if (null? items)
      nil
      (cons ⟨??⟩ ⟨??⟩)))
(define (square-list items)
  (map ⟨??⟩ ⟨??⟩))
```
