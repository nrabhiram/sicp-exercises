---
slug: exercise-3-34
name: Exercise 3.34
date: 16-09-26 00:08
---

Louis Reasoner wants to build a squarer, a constraint device with two terminals such that the value of connector `b` on the second terminal will always be the square of the value `a` on the first terminal. He proposes the following simple device made from a multiplier:

```racket
(define (squarer a b)
  (multiplier a a b))
```

There is a serious flaw in this idea. Explain.

## Solution

The problem with this solution is that the constraint would determine the value of the square if the radicand's value was set. This is because both the values of the multiplicands are set, and the `multiplier` constraint is satisfied. But, if `user` sets `b`, the constraint doesn't handle setting the value of `a`, because the `multiplier` would need 2 values to determine the other.
