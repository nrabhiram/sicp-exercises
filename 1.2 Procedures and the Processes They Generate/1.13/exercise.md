# Exercise 1.13

Prove that Fib(n) is the closest integer to `ϕ^n/√5`, where `ϕ = (1+√5)/2`.

**Hint**: Let `ψ = (1−√5)/2`

Use induction and the definition of the Fibonacci numbers to prove that `Fib(n) = (ϕ^n−ψ^n)/√5`.

# Solution

```
We know that Fib(n) = Fib(n-1) + Fib(n-2)

Fib(n) = (ϕ^(n-1) − ψ^(n-1))/√5 + (ϕ^(n-2) − ψ^(n-2))/√5
Fib(n) = [ϕ^n(1/ϕ + 1/ϕ^2)]/√5 + [ψ^n(1/ψ + 1/ψ^2)]/√5

Substituting the values for ϕ and ψ
Fib(n) = [ϕ^n{2/(1+√5) + 4/(1+√5)^2}]/√5 + [ψ^n{2/(1-√5) + 4/(1-√5)^2}]/√5
Fib(n) = [ϕ^n{(2(1+√5)+4)/(1+2√5+5)}]/√5 + [ψ^n{(2(1-√5)+4)/(1-2√5+5)}]/√5
Fib(n) = [ϕ^n{(6+2√5)/(6+2√5)}]/√5 + [ψ^n{(6-2√5)/(6-2√5)}]/√5
∴ Fib(n) = (ϕ^n − ψ^n)/√5

ϕ^n/√5 = Fib(n) + ψ^n/√5

-1 < ψ < 0
-1 < ψ^n < 1
-1/√5 < ψ^n/√5 < 1/√5

We know that √5 > 2

-1/2 < -1/√5 < ψ^n/√5 < 1/√5 < 1/2
Fib(n) - 1/2  < Fib(n) + ψ^n/√5 < Fib(n) + 1/2
Fib(n) - 1/2 < ϕ^n/√5 < Fib(n) + 1/2

∴ ψ^n/√5 will always be within 0.5 of Fib(n)
∴ Fib(n) is the closest integer to ψ^n/√5
```