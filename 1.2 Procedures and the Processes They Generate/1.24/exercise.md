# Exercise 1.24

Modify the `timed-prime-test` procedure of Exercise 1.22 to use `fast-prime?` (the Fermat method), and test each of the 12 primes you found in that exercise. Since the Fermat test has `Θ(logn)` growth, how would you expect the time to test primes near 1,000,000 to compare with the time needed to test primes near 1000?  Do your data bear this out? Can you explain any discrepancy you find?

# Solution

| Prime Number      | `prime?` Time (µs)  | fast-prime? Time (µs) |
| :---------------- |  :---------------:  | :-------------------: |
| 1009              |          4          |           5           |
| 1013              |          4          |           4           |
| 1019              |          4          |           5           |
| 10007             |          10         |           6           |
| 10009             |          9          |           4           |
| 10037             |          9          |           5           |
| 100003            |          27         |           6           |
| 100019            |          26         |           5           |
| 100043            |          27         |           6           |
| 1000003           |          77         |           6           |
| 1000033           |          76         |           6           |
| 1000037           |          76         |           7           |

## Prime Test

The average time taken for the first 3 prime integers around 1000, 10 000, 100 000, and 1 000 000 respectively are:

- 4µs
- 9.33µs
- 26.67µs
- 76.33µs

We notice that for everytime n increases by a factor of 10, the time taken to compute increases by a factor of nearly 2.85 (≈ √10).

## Fermat Test

The average time taken for the first 3 prime integers around 1000, 10 000, 100 000, and 1 000 000 respectively are:

- 4.67µs
- 5µs
- 5.67µs
- 6.33µs

We notice that for everytime n increases by a factor of 10, the increment in time taken to compute is around 0.67µs.