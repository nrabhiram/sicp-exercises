---
slug: exercise-2-91
name: Exercise 2.91
date: 23-06-26 21:41
---

A univariate polynomial can be divided by another one to produce a polynomial quotient and a polynomial remainder. For example, 

```
x⁵ − 1 / x² − 1 = x³ + x, remainder x - 1
```

Division can be performed via long division. That is, divide the highest-order term of the dividend by the highest-order term of the divisor. The result is the first term of the quotient. Next, multiply the result by the divisor, subtract that from the dividend, and produce the rest of the answer by recursively dividing the difference by the divisor. Stop when the order of the divisor exceeds the order of the dividend and declare the dividend to be the remainder. Also, if the dividend ever becomes zero, return zero as both quotient and remainder.

We can design a `div-poly` procedure on the model of `add-poly` and `mul-poly`. The procedure checks to see if the two
polys have the same variable. If so, `div-poly` strips off the variable and passes the problem to `div-terms`, which performs the division operation on term lists. `div-poly` finally reattaches the variable to the result supplied by `div-terms`. It is convenient to design `div-terms` to compute both the quotient and the remainder of a division. `div-terms` can take two term lists as arguments and return a list of the quotient term list and the remainder term list.

Complete the following definition of `div-terms` by filling in the missing expressions. Use this to implement `div-poly`, which takes two polys as arguments and returns a list of the quotient and remainder polys.

```racket
(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (let ((rest-of-result
                     ⟨compute rest of result recursively⟩ ))
                ⟨form complete result⟩ ))))))
```

## Solution

This problem made me ponder about how long division works in the first place. When we perform long division b/w integers, we first start with the highest digit of the dividend. Let's say that digit is some number *n*. When we divide the digit *n* by the divisor, we're calculating how *n* groups of the digit's place can be distributed equally amongst the divisor. The remainder is then coverted to groups of the next place's value and is added to the the *m* groups of the next place. Eventually, we either end up with 0 as the remainder, which means that the dividend could be divided by the divisor evenly, or we end up with a dividend that is lesser than the divisor, which means that we can't distribute the value further and are left with a remainder.

For example, [857 / 3](https://youtu.be/o8CQq4NbnhE). We start with 8 hundreds. Distribute 8 hundreds equally among 3: each gets 2 hundreds (with 2 hundreds left over). The 2 hundreds are converted to 20 tens, added to the 5 tens we already have, giving 25 tens. Distribute 25 tens equally among 3: each gets 8 tens (with 1 ten left over). The 1 ten is converted to 10 ones, added to the 7 ones, giving 17 ones. Distribute 17 ones equally among 3: each gets 5 (with 2 left over). Each of the 3 receives 285, remainder: 2.

In the case of integers, this is an efficient way to calculate how the dividend can be distributed equally amongst the divisor.

Univariate polynomial long division does the same thing. We want to see how the dividend can be distributed equally amongst the divisor. We start by multiplying the divisor with a value that eliminates the highest order term of the dividend when the product is subtracted from it. We keep adding the multipliers until we end up with a dividend whose highest order is lesser than the divisor's.
