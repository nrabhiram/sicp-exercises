---
slug: exercise-2-26
name: Exercise 2.26
date: 26-03-15 23:32
---

Suppose we define `x` and `y` to be two lists:

```racket
(define x (list 1 2 3))
(define y (list 4 5 6))
```

What result is printed by the interpreter in response to evaluating each of the following expressions:

```racket
(append x y)
(cons x y)
(list x y)
```

## Solution

For `(append x y)`, we get:

```racket
(1 2 3 4 5 6)
```

For `(cons x y)`, we get:

```racket
(cons (cons 1 (cons 2 (cons 3 nil))) (cons 4 (cons 5 (cons 6 nil))))
((1 2 3) 4 5 6)
```

I've expanded the expression so that it's easier to visualize what is happening.

For `(list x y)`, we get:

```racket
((1 2 3) (4 5 6))
```
