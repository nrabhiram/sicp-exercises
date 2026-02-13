---
slug: exercise-1-29
name: Exercise 1.29
date: 26-02-12 18:17
---

Simpson’s Rule is a more accurate method of numerical integration than the method illustrated above. Using Simpson’s Rule, the integral of a function f between a and b is approximated as

```
h/3(y₀ + 4y₁ + 2y₂ + 4y₃ + 2y₄ + · · · + 2yₙ₋₂ + 4yₙ₋₁ + yₙ)
```

where *h* = (*b* − *a*)/*n*, for some even integer *n*, and *yₖ* = *f*(*a* + *kh*). (Increasing *n* increases the accuracy of the approximation.) Define a procedure that takes as arguments *f*, *a*, *b*, and *n* and returns the value of the integral, computed using Simpson’s Rule. Use your procedure to integrate `cube` between 0 and 1 (with *n* = 100 and *n* = 1000), and compare the results to those of the `integral` procedure shown above.

## Solution

For both values of 100 and 1000 for *n*, we get 0.25 exactly. Apparently, Simpson's Rule is exact for polynomials with a degree lesser than or equal to 3. A simple explanation is that the 4th order derivatives of terms with a degree <= 3 is 0, so the error terms vanish.
