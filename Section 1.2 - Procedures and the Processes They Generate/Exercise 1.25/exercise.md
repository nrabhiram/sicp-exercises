# Exercise 1.25

Alyssa P. Hacker complains that we went to a lot of extra work in writing `expmod`. After all, she says, since we already know how to compute exponentials, we could have simply written

```scheme
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))
```

Is she correct? Would this procedure serve as well for our fast prime tester? Explain.

# Solution

In this modified version of `expmod`, `(fast-expt base exp)` needs to be evaluated to get the exponent of `base^exp` before `remainder` can be applied. The issue with this is that it can lead to very large numbers.

The resultant value when we evaluate `(fast-expt 941 1009)`, i.e. the smallest prime number above 1000 (obtanined from the previous exercises), is 3001 digits long.

**Note**: The total amount of digits can be calculated as shown:

```
If n has k digits, 
10^(k-1) <= n <= 10^k
k-1 <= log₁₀(n) <= k
k <= log₁₀(n) + 1
k = Floor(log₁₀(n) + 1)

No. of digits = Floor(log₁₀(b^n) + 1)
              = Floor(nlog₁₀(b) + 1)
```

The size of the number increases the larger the value of `exp` gets.

*A `fixnum` is an exact integer whose two’s complement representation fit into 31 bits on a 32-bit platform or 63 bits on a 64-bit platform; furthermore, no allocation is required when computing with `fixnums`.*
*Such big numbers (`bignum`) will take up large memory space and the operations performed on them is much slower.*

Operations like multiplication and remainder on `fixnum` can be seen as Θ(1). On `bignum` they have a much slower complexity.

On the other hand, the original version of `expmod` deals with much smaller quantities and doesn't calculate the entire exponent value before applying `remainder`.