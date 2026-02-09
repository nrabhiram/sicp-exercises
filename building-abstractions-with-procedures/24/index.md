---
slug: exercise-1-24
name: Exercise 1.24
date: 26-02-08 14:06
---

Modify the `timed-prime-test` procedure of [Exercise 1.22](/exercise-1-22) to use `fast-prime?` (the Fermat method), and test each of the 12 primes you found in that exercise. Since the Fermat test has Θ(log*n*) growth, how would you expect the time to test primes near 1,000,000 to compare with the time needed to test primes near 1000? Do your data bear this out? Can you explain any discrepancy you find?

## Solution

| Prime Number      | `prime?` Time (µs)  | `fast-prime?` Time (µs) |
| :---------------- |  :---------------:  |  :-------------------:  |
| 1009              |          1          |           2             |
| 1013              |          2          |           2             |
| 1019              |          2          |           2             |
| 10007             |          4          |           2             |
| 10009             |          3          |           2             |
| 10037             |          2          |           1             |
| 100003            |          10         |           2             |
| 100019            |          9          |           2             |
| 100043            |          9          |           2             |
| 1000003           |          29         |           2             |
| 1000033           |          26         |           2             |
| 1000037           |          27         |           2             |

The expected growth ideally should be that there's a fixed increment every time the input size is increased by a factor of 10. But, since the time taken for this input size is already so small, the logarithmic order of growth can't be observed.
