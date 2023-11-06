# Exercise 1.13

Prove that `Fib(n)` is the closest integer to `ϕⁿ/√5`, where `ϕ = (1+√5)/2`.

**Hint**: Let `ψ = (1−√5)/2`

Use induction and the definition of the Fibonacci numbers to prove that `Fib(n) = (ϕⁿ−ψⁿ)/√5`.

# Solution

```
We know that Fib(n) = Fib(n-1) + Fib(n-2)

Fib(n) = (ϕⁿ⁻¹ − ψⁿ⁻¹)/√5 + (ϕⁿ⁻² − ψⁿ⁻²)/√5
Fib(n) = [ϕⁿ(1/ϕ + 1/ϕ²)]/√5 - [ψⁿ(1/ψ + 1/ψ²)]/√5

Substituting the values for ϕ and ψ
Fib(n) = [ϕⁿ{2/(1+√5) + 4/(1+√5)²}]/√5 - [ψⁿ{2/(1-√5) + 4/(1-√5)²}]/√5
Fib(n) = [ϕⁿ{(2(1+√5)+4)/(1+2√5+5)}]/√5 - [ψⁿ{(2(1-√5)+4)/(1-2√5+5)}]/√5
Fib(n) = [ϕⁿ{(6+2√5)/(6+2√5)}]/√5 - [ψⁿ{(6-2√5)/(6-2√5)}]/√5
∴ Fib(n) = (ϕⁿ − ψⁿ)/√5

ϕⁿ/√5 = Fib(n) + ψⁿ/√5

-1 < ψ < 0
-1 < ψ^n < 1
-1/√5 < ψⁿ/√5 < 1/√5

We know that √5 > 2

-1/2 < -1/√5 < ψⁿ/√5 < 1/√5 < 1/2
Fib(n) - 1/2  < Fib(n) + ψⁿ/√5 < Fib(n) + 1/2
Fib(n) - 1/2 < ϕⁿ/√5 < Fib(n) + 1/2

∴ ϕⁿ/√5 will always be within 0.5 of Fib(n)
∴ Fib(n) is the closest integer to ϕⁿ/√5
```