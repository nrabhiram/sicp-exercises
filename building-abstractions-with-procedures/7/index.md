---
slug: exercise-1-7
name: Execrise 1.7
date: 25-12-25 18:28
---

The `good-enough?` test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing `good-enough?` is to watch how `guess` changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

## Solution

In the case of large numbers, we're thrown into an infinite loop because the guess converges and can't be further improved. In the case of small numbers, the computation terminates early and yields inaccurate results because the value of the improved guess quickly becomes smaller than the tolerance value.

**accuracy**: how close the guess is to the actual value

**precision**: the number of digits to which a guess can be specified

### Large Numbers

The range of real numbers is infinite. But the number of bits we have to represent a number is finite. Double precision floating-point numbers are represented in 64 bits:

- 1 bit for the sign
- 52 bits for the mantissa (aka significand), with an implicit leading bit
- 11 bits for the exponent

This is similar to how we represent numbers in scientific notation, except that we do it in `base-2`. The mantissa, i.e. the sum of the whole number and the fractional part always ranges b/w `1` and `2`, which means that the whole number is always a `1`. The fractional part, i.e. `1/2 + 1/4 + 1/8 + ...` will always be lesser than `1`.

```
2⁵³ = 10ᵃ
log₁₀ 2⁵ = log₁₀ 10ᵃ
53 x log₁₀ 2 = a log₁₀ 10
53 x 0.3010 = a
a = 15.953
```

In 53 bits, we can store 15-17 digits precisely. Numbers that are more precise than that can't be represented as accurately, and need to be rounded off to the closest number that can be represented in double precision.

For large numbers, the guess converges, and it can't be improved any further because the value it gets rounded to after the improvement is applied may be the same as the previous guess. The improved guess might lie b/w two consecutive numbers that can be represented in double precision, so it gets rounded back to the previous guess's value. If we're lucky, the approximation of the square of the guess and the approximation of the radicand will be them same, and the difference will be `0`, thus making the guess good enough, and terminating the computation. But, in most cases, we end up with a delta greater than our tolerance, and a guess value that can't be further improved.

### Small Numbers

In the case of numbers that are smaller than the tolerance value, we end up with inaccurate results. Although we can further improve the guess, the delta satisfies `good-enough?` and terminates the computation early.

### Relative Delta

This new approach of ensuring a guess is good enough by checking the percentage difference b/w the previous and current guess and respecting the scale of the numbers solves for both of our problems:

- converging guesses that can't be improved further due to approximation
- early termination of computation due to large tolerance values
