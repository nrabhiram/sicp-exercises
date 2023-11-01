# Exercise 1.23

The `smallest-divisor` procedure shown at the start of this section does lots of needless testing: After it checks to see if the number is divisible by 2 there is no point in checking to see if it is divisible by any larger even numbers. This suggests that the values used for `test-divisor` should not be `2, 3, 4, 5, 6...`, but rather `2, 3, 5, 7, 9...`.

To implement this change, define a procedure `next` that returns `3` if its input is equal to 2 and otherwise returns its input plus `2`. Modify the `smallest-divisor` procedure to use `(next test-divisor)` instead of `(+ test-divisor 1)`.

With `timed-prime-test` incorporating this modified version of `smallest-divisor`, run the test for each of the 12 primes found in Exercise 1.22.  Since this modification halves the number of test steps, you should expect it to run about twice as fast. Is this expectation confirmed? If not, what is the observed ratio of the speeds of the two algorithms, and how do you explain the fact that it is different from 2?

# Solution

| Prime Number      |  Time (µs) |  Improved Time (µs)  |   % Speedup   |
| :---------------- | :--------: | :------------------: | :-----------: |
| 1009              |      4     |          4           |     100%      |
| 1013              |      4     |          2           |     200%      |
| 1019              |      4     |          3           |     133.3%    |
| 10007             |      10    |          7           |     142.8%    |
| 10009             |      9     |          6           |     150%      |
| 10037             |      9     |          7           |     128.6%    |
| 100003            |      27    |          17          |     158.8%    |
| 100019            |      26    |          17          |     152.9%    |
| 100043            |      27    |          16          |     168.7%    |
| 1000003           |      77    |          49          |     157.1%    |
| 1000033           |      76    |          49          |     155.1%    |
| 1000037           |      76    |          49          |     155.1%    |

The speedup in the test ranges from `100%` to `200%`. A sizeable chunk of the tests lie more specifically in the range of `150%` to `168.7%`. This is lesser than the expected `200%`.

The reason for this is that we've introduced:

1. a new procedure call
2. a predicate that has to be evaluated
3. the consequent or alternative that has to be evaluated, depending on the value of the predicate

to replace the evaluation of a single combination `(+ test-divisor 1)`.

The performance improves if we compute the next value for `test-divisor` inline.

```
(define (find test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor) test-divisor)
        (else (find
                (if (= test-divisor 2)
                    3
                    (+ test-divisor 2))))))
(find 2)
```

We can further improve the performance by elminating the predicate, and consequently, the need to evaluate it.

```scheme
(define (find test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor) test-divisor)
        (else (find
                (if #f
                    3
                    (+ test-divisor 2))))))
(find 3)
```

**Note**: We have to start the `find` procedure with `3` instead of `2` because we'll be applying even numbers as the `test-divisor` for odd numbers. So, according to our new test, this leads to every odd number to be considered as a prime number.

## Conclusion

The improved algorithm has half as many steps, but we do not get a 200% speedup because of the extra work being done in computing the next value for `test-divisor`.