---
slug: exercise-2-95
name: Exercise 2.95
date: 11-07-26 17:23
---

Define *P*₁, *P*₂, and *P*₃ to be the polynomials

```
P1 : x² − 2x + 1,
P2 : 11x² + 7,
P3 : 13x + 5.
```

Now define *Q*₁ to be the product of *P*₁ and *P*₂ and *Q*₂ to be the product of *P*₁ and *P*₃, and use `greatest-common-divisor` ([Exercise 2.94](exercise-2-94)) to compute the GCD of *Q*₁ and *Q*₂. Note that the answer is not the same as *P*₁. This example introduces non-integer operations into the computation, causing difficulties with the GCD algorithm. To understand what is happening, try tracing `gcd-terms` while computing the GCD or try performing the division by hand.

## Solution

Here's my crude attempt at logging the traces from `gcd-terms` and `div-terms` (via `remainder-terms`).

```
=== GCD step start ===
L1: (11*x^4 + -22*x^3 + 18*x^2 + -14*x + 7)
L2: (13*x^3 + -21*x^2 + 3*x + 5)
=== GCD step end ===
=== DIV step start ===
dividend: (11*x^4 + -22*x^3 + 18*x^2 + -14*x + 7)
divisor:  (13*x^3 + -21*x^2 + 3*x + 5)
lead dividend term: 11*x^4
lead divisor term:  13*x^3
next quotient term: 11/13*x
subtracting: (143/13*x^4 + -231/13*x^3 + 33/13*x^2 + 55/13*x)
new dividend: (-55/13*x^3 + 201/13*x^2 + -237/13*x + 7)
=== DIV step start ===
dividend: (-55/13*x^3 + 201/13*x^2 + -237/13*x + 7)
divisor:  (13*x^3 + -21*x^2 + 3*x + 5)
lead dividend term: -55/13*x^3
lead divisor term:  13*x^3
next quotient term: -55/169
subtracting: (-715/169*x^3 + 1155/169*x^2 + -165/169*x + -275/169)
new dividend: (18954/2197*x^2 + -37908/2197*x + 1458/169)
=== DIV step start ===
dividend: (18954/2197*x^2 + -37908/2197*x + 1458/169)
divisor:  (13*x^3 + -21*x^2 + 3*x + 5)
lead dividend term: 18954/2197*x^2
lead divisor term:  13*x^3
divisor order > dividend order; quotient = (), remainder = dividend
=== DIV step end ===
rest quotient: (0)
rest remainder: (18954/2197*x^2 + -37908/2197*x + 1458/169)
=== DIV step end ===
rest quotient: (-55/169)
rest remainder: (18954/2197*x^2 + -37908/2197*x + 1458/169)
=== DIV step end ===
=== GCD step start ===
L1: (13*x^3 + -21*x^2 + 3*x + 5)
L2: (18954/2197*x^2 + -37908/2197*x + 1458/169)
=== GCD step end ===
=== DIV step start ===
dividend: (13*x^3 + -21*x^2 + 3*x + 5)
divisor:  (18954/2197*x^2 + -37908/2197*x + 1458/169)
lead dividend term: 13*x^3
lead divisor term:  18954/2197*x^2
next quotient term: 28561/18954*x
subtracting: (541345194/41641938*x^3 + -1082690388/41641938*x^2 + 41641938/3203226*x)
new dividend: (208209690/41641938*x^2 + -32032260/3203226*x + 5)
=== DIV step start ===
dividend: (208209690/41641938*x^2 + -32032260/3203226*x + 5)
divisor:  (18954/2197*x^2 + -37908/2197*x + 1458/169)
lead dividend term: 208209690/41641938*x^2
lead divisor term:  18954/2197*x^2
next quotient term: 457436688930/789281292852
subtracting: (8670255001979220/1734051000395844*x^2 + -17340510003958440/1734051000395844*x + 666942692459940/133388538491988)
new dividend: (0)
=== DIV step start ===
dividend: (0)
divisor:  (18954/2197*x^2 + -37908/2197*x + 1458/169)
dividend is empty; quotient = (), remainder = ()
=== DIV step end ===
rest quotient: (0)
rest remainder: (0)
=== DIV step end ===
rest quotient: (457436688930/789281292852)
rest remainder: (0)
=== DIV step end ===
=== GCD step start ===
L1: (18954/2197*x^2 + -37908/2197*x + 1458/169)
L2: (0)
=== GCD step end ===
p1-poly: (1*x^2 + -2*x + 1)
p2-poly: (11*x^2 + 7)
p3-poly: (13*x + 5)
q1-poly: (11*x^4 + -22*x^3 + 18*x^2 + -14*x + 7)
q2-poly: (13*x^3 + -21*x^2 + 3*x + 5)
gcd q1 q2: ((18954/2197)*x^2 + (-37908/2197)*x + (1458/169))
```

In `div-terms`, we use the long division method to get the quotient and remainder. To get the new dividend, we first divide the leading term of the dividend by the leading term of the divisor. Then, we multiply the divisor with this result, and subtract it from the dividend, thus obtaining our new dividend (with the leading term of the old dividend eliminated). In our system, currently, when we divide the leading terms, we end up with rational coefficients. And at every step of the long division, when an operation is performed b/w 2 terms and a rational coefficient is involved, there's a possibility that the size of the denominator increases. 

Our examination of the logs confirms this. One reason that the size of the numerator and denominator grows in the coefficients is because we no longer calculate the GCD in order to reduce the numerator and denominator terms to their lowest values when constructing a rational number. We can't really add this logic back either, because `make-rat` now uses the generic `div` procedure instead of the primitive `/` — we've extended our system to support rational functions.

This problem would still persist even if we somehow figured out a way to use the GCD to reduce rational numbers to their lowest forms. When we do the subtraction to get the new dividend, the leading term is eliminated, but the next term may still have a rational coefficient. Our program currently doesn't concern itself with normalization.

This doesn't mean that resultant GCD in our program is incorrect. Technically, it is equivalent to *P*₁ being a factor.

```
(18954/2197)x² + (-37908/2197)*x + 1458/169
= (18954/2197)x² + (-37908/2197)*x + 18954/2197
= (18954/2197)·(x² - 2x + 1)
```

Our result is basically *P*₁ multiplied by some other constant value. If *P*₁ is a common factor, than so is the product of some constant *c* (in our case, it's 18954/2197) and *P*₁.
