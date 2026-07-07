---
slug: exercise-2-93
name: Exercise 2.93
date: 06-07-26 22:27
---

Modify the rational-arithmetic package to use generic operations, but change `make-rat` so that it does not attempt to reduce fractions to lowest terms. Test your system by calling `make-rational` on two polynomials to produce a rational function:

```racket
(define p1 (make-polynomial 'x '((2 1) (0 1))))
(define p2 (make-polynomial 'x '((3 1) (0 1))))
(define rf (make-rational p2 p1))
```

Now add `rf` to itself, using `add`. You will observe that this addition procedure does not reduce fractions to lowest terms.

## Solution

I ran into a pitfall while implementing the rational-arithmetic package using generic operations — we cause an infinite loop when we perform operations between 2 rational numbers/functions. The reason for using generic operations `add`, `sub`, `mul`, `div` in the rational package is so that we can have expressions with polynomials for both the numerator and denominator. 

Let's say we add 2 rational terms. We `add` the following products:

- `mul` of the first numerator and second denominator
- `mul` of the second numerator and first denominator

This gives us our new numerator. The `mul` of the two denominators gives us our new denominator. We construct our new rational term using these values. But, `apply-generic` tries to `drop` the result to its simplest form (since the `op` performed, `add`, is assumed to produce a result that can be dropped).

Let's say that the addends had numerators and denominators that were integers. This means that the resultant rational term also has a numerator and denominator that is an integer. 

When we try to drop the rational term, `rational->integer` is applied, which applies `div` to the numerator and denominator.

```racket
(put 'div '(integer integer)
     (lambda (x y) (make-rational x y)))
```

This ends up creating the same rational again, thus restarting the cycle.

This problem arises because we're trying to fit polynomials into the tower hierarchy of types. The simplest solution for this is to remove the `drop` logic altogether.

The final output we get when we try to `add` `rf` to itself is as shown:

```
p1-poly: (1*x^2 + 1)
p2-poly: (1*x^3 + 1)
rf-poly: (1*x^3 + 1) / (1*x^2 + 1)
add rf-poly to itself: (2*x^5 + 2*x^3 + 2*x^2 + 2) / (1*x^4 + 2*x^2 + 1)
```
