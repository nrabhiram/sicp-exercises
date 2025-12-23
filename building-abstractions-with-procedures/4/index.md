---
slug: exercise-1-4
name: Execrise 1.4
date: 23-12-25 01:24
---

Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

```racket
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

## Solution

If `b <= 0`, the operator is `-`. Otherwise, the operator is `+`. So, the result will always be the sum of `a` and the magnitude of `b`, i.e. `a + |b|`.
