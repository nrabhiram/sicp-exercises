---
slug: exercise-1-23
name: Exercise 1.23
date: 26-02-08 12:09
---

The `smallest-divisor` procedure shown at the start of this section does lots of needless testing: After it checks to see if the number is divisible by 2 there is no point in checking to see if it is divisible by any larger even numbers. This suggests that the values used for `test-divisor` should not be 2, 3, 4, 5, 6, . . ., but rather 2, 3, 5, 7, 9, . . .. To implement this change, define a procedure `next` that returns 3 if its input is equal to 2 and otherwise returns its input plus 2. Modify the `smallest-divisor` procedure to use `(next test-divisor)` instead of `(+ test-divisor 1)`. With `timed-prime-test` incorporating this modified version of `smallest-divisor`, run the test for each of the 12 primes found in [Exercise 1.22](/exercise-1-22). Since this modification halves the number of test steps, you should expect it to run about twice as fast. Is this expectation confirmed? If not, what is the observed ratio of the speeds of the two algorithms, and how do you explain the fact that it is different from 2?

## Solution

| Prime Number      |  Time (µs) |  Improved Time (µs)  |   % Speedup   |
| :---------------- | :--------: | :------------------: | :-----------: |
| 1009              |      1     |          1           |     100%      |
| 1013              |      2     |          1           |     200%      |
| 1019              |      2     |          1           |     200%      |
| 10007             |      4     |          2           |     200%      |
| 10009             |      3     |          2           |     150%      |
| 10037             |      2     |          2           |     100%      |
| 100003            |      10    |          6           |     166.7%    |
| 100019            |      9     |          5           |     180%      |
| 100043            |      9     |          6           |     150%      |
| 1000003           |      29    |          15          |     193.3%    |
| 1000033           |      26    |          14          |     185.7%    |
| 1000037           |      27    |          14          |     192.8%    |

For most of these numbers, the speedup doesn't hit 200%. 7 out of the 12 numbers exist in the 150% to 193.3% range. To replace the evaluation of the combination `(+ a 1)`, we've introduced:

- a new procedure call
- a predicate that needs to be evaluated (for the first clause)
- an expression that needs to be evaluated (in the `else` or the first clause, depending on the value of the predicate)

```racket
(define (find-divisor a)
  (cond ((> (square a) n) n)
        ((divides? a) a)
        (else (find-divisor 
                (if (= a 2)
                    3
                    (+ a 2))))))
```

If we inline the conditional, we eliminate the procedure call, so there's a performance improvement.

```racket
(define (find-divisor a)
  (cond ((> (square a) n) n)
        ((divides? a) a)
        (else (find-divisor 
                (if #f
                    3
                    (+ a 2))))))
```

We can further improve the performance by eliminating the predicate, and consequently, the need to evaluate it.

**Note**: We have to start the `find-divisor` procedure with 3 instead of 2 because we'll anyway be calling `timed-prime-test` on only odd numbers. Odd numbers can't be divided by 2, regardless of whether they're prime or not. So, we can avoid testing for 2.
