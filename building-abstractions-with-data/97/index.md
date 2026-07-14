---
slug: exercise-2-97
name: Exercise 2.97
date: 14-07-26 09:09
---

a. Implement this algorithm as a procedure `reduce-terms` that takes two term lists `n` and `d` as arguments and returns a list `nn`, `dd`, which are `n` and `d` reduced to lowest terms via the algorithm given above. Also write a procedure `reduce-poly`, analogous to `add-poly`, that checks to see if the two polys have the same variable. If so, `reduce-poly` strips off the variable and passes the problem to `reduce-terms`, then reattaches the variable to the two term lists supplied by `reduce-terms`.
b. Define a procedure analogous to `reduce-terms` that does what the original `make-rat` did for integers:

```racket
(define (reduce-integers n d)
  (let ((g (gcd n d)))
    (list (/ n g) (/ d g))))
```

and define `reduce` as a generic operation that calls `apply-generic` to dispatch to either `reduce-poly` (for polynomial arguments) or `reduce-integers` (for `scheme-number` arguments). You can now easily make the rational-arithmetic package reduce fractions to lowest terms by having `make-rat` call `reduce` before combining the given numerator and denominator to form a rational number. The system now handles rational expressions in either integers or polynomials. To test your program, try the example at the beginning of this extended exercise:

```racket
(define p1 (make-polynomial 'x '((1 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 -1))))
(define p3 (make-polynomial 'x '((1 1))))
(define p4 (make-polynomial 'x '((2 1) (0 -1))))
(define rf1 (make-rational p1 p2))
(define rf2 (make-rational p3 p4))
(add rf1 rf2)
```

See if you get the correct answer, correctly reduced to lowest terms.

## Solution

The reduction works, but the system doesn't format polynomials to prevent them from having leading terms with a negative coefficient. This was my initial test result:

```
=== REDUCTION TEST ===
p1-poly:    (1*x^2 + -2*x + 1)
p2-poly:    (11*x^2 + 7)
p3-poly:    (13*x + 5)
q1-poly:    (11*x^4 + -22*x^3 + 18*x^2 + -14*x + 7)
q2-poly:    (13*x^3 + -21*x^2 + 3*x + 5)
gcd q1 q2:  (1*x^2 + -2*x + 1)
reduced q1: (11*x^2 + 7)
reduced q2: (13*x + 5)
=== EXERCISE TEST ===
p4-poly:     (1*x + 1)
p5-poly:     (1*x^3 + -1)
p6-poly:     (1*x)
p7-poly:     (1*x^2 + -1)
rf1-poly:    (-1*x + -1)/(-1*x^3 + 1)
rf2-poly:    (1*x)/(1*x^2 + -1)
rf-sum-poly: (-1*x^3 + -2*x^2 + -3*x + -1)/(-1*x^4 + -1*x^3 + 1*x + 1)
```

To fix this, in `reduce-terms`, before returning the list of `nn` and `dd`, we check if the leading coefficient of `dd` is negative. If so, we normalize our result by scaling the terms of both with a factor of -1.

```racket
(if (< (coeff (first-term dd-reduced)) 0)
    (list (scale-terms -1 nn-reduced)
          (scale-terms -1 dd-reduced))
    (list nn-reduced dd-reduced))
```

Now, our result is identical to the result from the beginning of the extended exercise.

```
=== REDUCTION TEST ===
p1-poly:    (1*x^2 + -2*x + 1)
p2-poly:    (11*x^2 + 7)
p3-poly:    (13*x + 5)
q1-poly:    (11*x^4 + -22*x^3 + 18*x^2 + -14*x + 7)
q2-poly:    (13*x^3 + -21*x^2 + 3*x + 5)
gcd q1 q2:  (1*x^2 + -2*x + 1)
reduced q1: (11*x^2 + 7)
reduced q2: (13*x + 5)
=== EXERCISE TEST ===
p4-poly:     (1*x + 1)
p5-poly:     (1*x^3 + -1)
p6-poly:     (1*x)
p7-poly:     (1*x^2 + -1)
rf1-poly:    (1*x + 1)/(1*x^3 + -1)
rf2-poly:    (1*x)/(1*x^2 + -1)
rf-sum-poly: (1*x^3 + 2*x^2 + 3*x + 1)/(1*x^4 + 1*x^3 + -1*x + -1)
```

Note that we check the leading coefficient of only the denominator, because it's the authority. A numerator with a negative sign simply means that the entire rational function is negative.
