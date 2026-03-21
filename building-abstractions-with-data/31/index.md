---
slug: exercise-2-31
name: Exercise 2.31
date: 26-03-21 10:32
---

Abstract your answer to [Exercise 2.30](exercise-2-30) to produce a procedure `tree-map` with the property that `square-tree` could be defined as

```racket
(define (square-tree tree) (tree-map square tree))
```
