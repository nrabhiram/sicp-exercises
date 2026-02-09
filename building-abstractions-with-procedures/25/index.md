---
slug: exercise-1-25
name: Exercise 1.25
date: 26-02-08 18:35
---

Alyssa P. Hacker complains that we went to a lot of extra work in writing `expmod`. After all, she says,
since we already know how to compute exponentials, we could have simply written

```racket
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))
```

Is she correct? Would this procedure serve as well for our fast prime tester? Explain.

## Solution

The order of growth in both cases is Θ(log*n*). But, in this implementation, the size of the numbers we're dealing with are huge. The smallest prime number above 1000 is 1009. Let's say *a*, the value for which we apply Fermat's test, is 941. The value used in the test, *aⁿ*, is 3001 digits long.

```
If n has k digits, 
10^(k-1) <= n <= 10^k
k-1 <= log₁₀(n) <= k
k <= log₁₀(n) + 1
k = Floor(log₁₀(n) + 1)

No. of digits = Floor(log₁₀(aⁿ) + 1)
              = Floor(nlog₁₀(a) + 1)
              = Floor(1009 * 2.9736 + 1)
              = Floor(3000.36 + 1)
              = Floor(3001.36)
              = 3001
```

> A `fixnum` is an exact integer whose two’s complement representation fit into 31 bits on a 32-bit platform or 63 bits on a 64-bit platform; furthermore, no allocation is required when computing with `fixnums`. Such big numbers (`bignum`) will take up large memory space and the operations performed on them is much slower.

Operations like multiplication and remainder on `fixnum` can be seen as Θ(1). On `bignum` they have a much slower complexity.

On the other hand, the reduction step in `expmod` ensures that we deal with numbers that are around the same size as *n*. The intermediary numbers we deal with as the process evolves in Alyssa's implementation are very huge, and the performance takes a hit because it takes more time to perform operations on them.
