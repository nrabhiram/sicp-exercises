---
slug: exercise-2-13
name: Exercise 2.13
date: 26-03-12 09:06
---

Show that under the assumption of small percentage tolerances there is a simple formula for the approximate percentage tolerance of the product of two intervals in terms of the tolerances of the factors. You may simplify the problem by assuming that all numbers are positive.

Afer considerable work, Alyssa P. Hacker delivers her finished system. Several years later, after she has forgotten all
about it, she gets a frenzied call from an irate user, Lem E. Tweakit. It seems that Lem has noticed that the formula for parallel resistors can be written in two algebraically equivalent ways: `R1⋅R2 / R1+R2` and `1 / (1/R1 + 1/R2)`. 

He has written the following two programs, each of which computes the parallel-resistors formula differently:

```racket
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one (add-interval (div-interval one r1)
                       (div-interval one r2)))))
```

Lem complains that Alyssa’s program gives different answers for the two ways of computing. This is a serious complaint.

## Solution

If the bounds of both of the intervals are positive, and the percentage tolerances are small, and we know that the bounds of the resultant interval are the products of the lower bounds and upper bounds respectively, the `txty` terms can be ignored due to approximation.

```
x = [cₓ(1 - tₓ), cₓ(1 + tₓ)]
y = [cᵧ(1 - tᵧ), cᵧ(1 + tᵧ)]
r = [cₓcᵧ(1 - tᵧ - tₓ + tₓtᵧ), cₓcᵧ(1 + tᵧ + tₓ + tₓtᵧ)]
  = [cₓcᵧ(1 - (tₓ + tᵧ)), cₓcᵧ(1 + (tₓ + tᵧ))]
```

So, the formula for the approximate percentage tolerance of the product of two intervals in terms of the tolerances of the factors is the sum of the factors' tolerances.

```
t = tₓ + tᵧ
```
