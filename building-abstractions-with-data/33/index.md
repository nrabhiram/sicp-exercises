---
slug: exercise-2-33
name: Exercise 2.33
date: 26-03-23 12:58
---

Fill in the missing expressions to complete the following definitions of some basic list-manipulation operations as accumulations:

```racket
(define (map p sequence)
  (accumulate (lambda (x y) ⟨??⟩) nil sequence))
(define (append seq1 seq2)
  (accumulate cons ⟨??⟩ ⟨??⟩))
(define (length sequence)
  (accumulate ⟨??⟩ 0 sequence))
```
