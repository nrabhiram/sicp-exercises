# Exercise 1.22

Most Lisp implementations include a primitive called `runtime` that returns an integer that specifies the amount of time the system has been running (measured, for example, in microseconds). The following `timed-prime-test` procedure, when called with an integer `n`, prints `n` and checks to see if `n` is prime. If `n` is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.

```scheme
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))
```

Using this procedure, write a procedure, `search-for-primes` that checks the primality of consecutive odd integers in a specified range. Use your procedure to find the three smallest primes larger than `1000`; larger than `10,000`; larger than `100,000`; larger than `1,000,000`. Note the time needed to test each prime. Since the testing algorithm has order of growth of `Θ(√n)`, you should expect that testing for primes around `10,000` should take about `√10` times as long as testing for primes around `1000`. Do your timing data bear this out? How well do the data for `100,000` and `1,000,000` support the `Θ(√n)` prediction? Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?

# Solution

| Prime Number      |  Time (µs) |
| :---------------- | :--------: |
| 1009              |      4     |
| 1013              |      4     |
| 1019              |      4     |
| 10007             |      10    |
| 10009             |      9     |
| 10037             |      9     |
| 100003            |      27    |
| 100019            |      26    |
| 100043            |      27    |
| 1000003           |      77    |
| 1000033           |      76    |
| 1000037           |      76    |

Approximately, testing for primes around `10,000` takes about `√10` times as long as testing for primes around `1000`, and so on. The result is compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation.