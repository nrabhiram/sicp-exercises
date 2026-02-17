---
slug: exercise-1-39
name: Exercise 1.39
date: 26-02-17 23:05
---

A continued fraction representation of the tangent function was published in 1770 by the German mathematician J.H. Lambert:

```
                x
tan x = ──────────────
                x²
        1 − ──────────
                 x²
            3 − ──────
                 5 − · · ·
```

where *x* is in radians. Define a procedure `(tan-cf x k)` that computes an approximation to the tangent function based on Lambert’s formula. `k` specifies the number of terms to compute, as in [Exercise 1.37](/exercise-1-37).
