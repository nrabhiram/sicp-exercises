# Exercise 1.7

The `good-enough?` test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. 

An alternative strategy for implementing `good-enough?` is to watch how `guess` changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

# Solution

The observations made are as follows:

1. For large numbers, the computation doesn't finish.
2. For small numbers, it yields inaccurate results.

## Floating Point Numbers

To get a better idea of how real numbers are represented in computers, we must understand how *floating point* encoding works.

1. Each number is represented by a finite number of bits. So, the number of *floating point numbers* that can be represented on a computer is finite.
2. Floating points are usually an approximation of a real number. This causes rounding issues.
3. As the size of numbers represented increases, the size of gap between two consecutive numbers will increase step by step.
4. 
    > Given any fixed number of bits, most calculations will produce quantities that cannot be exactly represented using that many bits. Therefore, the result of floating point must often be rounded in order to fit back into its finite representation. This rounding error is the characteristic feature of floating-point computation.
    >
    > – [What Every Computer Scientist Should Know About Floating-Point Arithmetic](https://docs.oracle.com/cd/E19957-01/806-3568/ncg_goldberg.html)


## Large Numbers

The computation doesn't finish for large numbers because the guess is getting close to the actual result. But, because of rounding errors, `(improve guess x)` can't improve the guess anymore. The smallest possible difference between `guess²` and `x` is larger than `0.001`. This is because with a number of this order of magnitude, the distance between two floating point numbers is greater than`0.001`.

If lucky, `(- (square guess) x)` is evaluated to exactly `0`. Otherwise, the gap between two consecutive numbers around `(square guess)` is more than `0.001` and `good-enough?` never becomes true. It will return the same number since `improve` has reached a fixed point due to rounding error.

## Small Numbers

Since we've hard-coded the amount of precision we want, we can't get accurate results if `x` is smaller than the precision of `0.001`. The iterations stop quickly, because the test assumes that the result is good enough. It's like measuring the size of a coin, `± 1m`. The result may be correct, but it isn't useful.

## Alternative

We can change `good-enough?` so that it no longer depends on `x` and instead depends on the `guess` and `improved-guess`.

```scheme
(define (good-enough? guess improved-guess)
  (< (/ (abs (- guess
                improved-guess))
        guess)
      0.00000000001))
```

**Note**: The number is arbitrary and is based on trial and error.

Now, the error is small **relative** to the size of the number computed.