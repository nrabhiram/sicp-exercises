---
slug: exercise-2-27
name: Exercise 2.27
date: 26-03-16 00:23
---

Modify your `reverse` procedure of [Exercise 2.18](exercise-2-18) to produce a `deep-reverse` procedure that takes a list as argument and returns as its value the list with its elements reversed and with all sublists deep-reversed as well. For example,

```racket
(define x (list (list 1 2) (list 3 4)))

x
((1 2) (3 4))

(reverse x)
((3 4) (1 2))

(deep-reverse x)
((4 3) (2 1))
```
