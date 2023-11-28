# Exercise 2.13

Show that under the assumption of small percentage tolerances there is a simple formula for the approximate percentage tolerance of the product of two intervals in terms of the tolerances of the factors. You may simplify the problem by assuming that all numbers are positive.

After considerable work, Alyssa P. Hacker delivers her finished system. Several years later, after she has forgotten all about it, she gets a frenzied call from an irate user, Lem E. Tweakit. It seems that Lem has noticed that the formula for parallel resistors can be written in two algebraically equivalent ways:

```
Rₚ = (R₁R₂) / (R₁ + R₂)
```

and

```
Rₚ = 1 / (1/R₁ + 1/R₂)
```

He has written the following two programs, each of which computes the parallel-resistors formula differently:

```scheme
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

# Solution

For small tolerances, the tolerance of the product of two positive intervals will approximately be the sum of the component tolerances.

```
x = [cₓ(1 - Tₓ), cₓ(1 + Tₓ)]
y = [cᵧ(1 - Tᵧ), cᵧ(1 + Tᵧ)]
x * y = [cₓcᵧ(1 - Tₓ)(1 - Tᵧ), cₓcᵧ(1 + Tₓ)(1 + Tᵧ)]
    = [cₓcᵧ(1 - Tᵧ - Tₓ + TₓTᵧ), cₓcᵧ(1 + Tᵧ + Tₓ + TₓTᵧ)]
    = [cₓcᵧ(1 - (Tₓ + Tᵧ)), cacb(1 + (Tₓ + Tᵧ))]
```