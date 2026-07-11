---
slug: exercise-2-94
name: Exercise 2.94
date: 08-07-26 15:59
---

Using `div-terms`, implement the procedure `remainder-terms` and use this to define `gcd-terms` as above. Now write a procedure `gcd-poly` that computes the polynomial GCD of two polys. (The procedure should signal an error if the two polys are not in the same variable.) Install in the system a generic operation `greatest-common-divisor` that reduces to `gcd-poly` for polynomials and to ordinary `gcd` for ordinary numbers. As a test, try

```racket
(define p1 (make-polynomial
            'x '((4 1) (3 -1) (2 -2) (1 2))))
(define p2 (make-polynomial 'x '((3 1) (1 -1))))
(greatest-common-divisor p1 p2)
```

and check your result by hand.

## Solution

The first polynomial, `p1`, can be factored as:

```
x⁴ - x³ - 2x² + 2x = x(x³ - x² - 2x + 2)
                    = x(x²(x - 1) -2(x - 1))
                    = x(x² - 2)(x - 1)
```

The second polynomial, `p2`, can be factored as:

```
x³ - x = x(x² - 1)
       = x(x - 1)(x + 1)
```

`p1` and `p2` have the factors: *x* and (*x* - 1) in common. The GCD is the product of all of the common factors, i.e. *x*² - *x*.

This is the output of our program:

```
p1-poly: (1*x^4 + -1*x^3 + -2*x^2 + 2*x)
p2-poly: (1*x^3 + -1*x)
gcd p1 p2: ((-1/1)*x^2 + (1/1)*x)
expected, up to a constant factor: (1*x^2 + -1*x)
```

A couple of things to note:

- We get rational coefficients for the GCD polynomial because division of integers in our system results in a rational number. 
- The signs of the terms in the polynomial are also inverted, i.e. the *x*² should be positive, and the *x* term negative. We get an additional factor of -1.
