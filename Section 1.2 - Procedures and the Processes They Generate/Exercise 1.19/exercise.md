# Exercise 1.19

There is a clever algorithm for computing the Fibonacci numbers in a logarithmic number of steps. Recall the transformation of the state variables `a` and `b` in the `fib-iter` process of Section 1.2.2:  `a ← a + b` and `b ← a`. Call this transformation `T`, and observe that applying `T` over and over again `n` times, starting with `1` and `0`, produces the pair `Fib(n+1)` and `Fib(n)`. In other words, the Fibonacci numbers are produced by applying `Tn`, the `nth` power of the transformation `T`, starting with the pair `(1, 0)`. 

Now consider `T` to be the special case of `p = 0` and `q = 1` in a family of transformations `Tpq`, where `Tpq` transforms the pair `(a, b)` according to `a ← bq + aq + ap` and `b ← bp + aq`.  Show that if we apply such a transformation `Tpq` twice, the effect is the same as using a single transformation `Tp′q′` of the same form, and compute `p′`and `q′` in terms of `p` and `q`. This gives us an explicit way to square these transformations, and thus we can compute `Tn` using successive squaring, as in the `fast-expt` procedure. Put this all together to complete the following procedure, which runs in a logarithmic number of steps:

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))
  (define (fib-iter a b p q count)
    (cond ((= count 0) b)
          ((even? count)
           (fib-iter a
                     b
                     ⟨??⟩ ; compute p′
                     ⟨??⟩ ; compute q′
                     (/ count 2)))
          (else (fib-iter (+ (* b q) (* a q) (* a p))
                          (+ (* b p) (* a q))
                          p
                          q
                          (- count 1)))))
```

# Solution

Let's try to compute the values of `p′`and `q′` in terms of `p` and `q`.

```
We start off with (a₀, b₀).

Upon applying transformation T once, we end up with (a₁, b₁).
Upon applying transformation T twice, we end up with (a₂, b₂).

Let's say that performing T′ once is equivalent to performing T twice.
We have to find the values of p′ and q′ in terms of p and q.

a₁ = b₀q + a₀q + a₀p --> Eqn 1
b₁ = b₀p + a₀q --> Eqn 2
b₂ = b₁p + a₁q --> Eqn 3

Substituting (1) and (2) in (3),

b₂ = (b₀p + a₀q)p + (b₀q + a₀q + a₀p)q
b₂ = b₀p² + a₀qp + b₀q² + a₀q² + a₀pq
b₂ = b₀(p²+q²) + a₀(q² + 2qp )

∴ p′ = p²+q²
∴ q′ = q² + 2pq
```