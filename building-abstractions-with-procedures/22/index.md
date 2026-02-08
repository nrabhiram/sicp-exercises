---
slug: exercise-1-22
name: Exercise 1.22
date: 26-02-07 23:52
---

Most Lisp implementations include a primitive called `runtime` that returns an integer that specifies the amount of time the system has been running (measured, for example, in microseconds). The following `timed-prime-test` procedure, when called with an integer *n*, prints *n* and checks to see if *n* is prime. If *n* is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.

```racket
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

Using this procedure, write a procedure `search-for-primes` that checks the primality of consecutive odd integers in a
specified range. Use your procedure to find the three smallest primes larger than 1000; larger than 10,000; larger than
100,000; larger than 1,000,000. Note the time needed to test each prime. Since the testing algorithm has order of growth of Θ(√*n*), you should expect that testing for primes around 10,000 should take about √10 times as long as testing for primes around 1000. Do your timing data bear this out? How well do the data for 100,000 and 1,000,000 support the Θ(√*n*) prediction? Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?

## Solution

| Prime Number      |  Time (µs) |
| :---------------- | :--------: |
| 1009              |      1     |
| 1013              |      2     |
| 1019              |      2     |
| 10007             |      4     |
| 10009             |      3     |
| 10037             |      2     |
| 100003            |      10    |
| 100019            |      9     |
| 100043            |      9     |
| 1000003           |      29    |
| 1000033           |      26    |
| 1000037           |      27    |

The average timing for computing the first 3 primes larger than:

- 1000 is 1.67
- 10000 is 3
- 100000 is 9.33
- 1000000 is 27.33

√10 is approximately 3.16. The factor by which the time increases when *n* increases from:

- 1000 to 10000 is 1.8
- 10000 to 100000 is 3.11
- 100000 to 1000000 is 2.93
