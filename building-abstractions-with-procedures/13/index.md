---
slug: exercise-1-13
name: Exercise 1.13
date: 26-01-09 12:56
---

Prove that Fib(n) is the closest integer to `ϕn/√5`, where `ϕ = (1 + √5)/2`. Hint: Let `ψ = (1 − √5)/2`. Use induction and the definition of the Fibonacci numbers (see Section 1.2.2) to prove that `Fib(n) = (ϕn − ψn)/√5`.

## Solution

```
Fib(n) = Fib(n-1) + Fib(n-2)
Fib(n) = (ϕⁿ⁻¹ − ψⁿ⁻¹)/√5 + (ϕⁿ⁻² − ψⁿ⁻²)/√5
Fib(n) = (ϕⁿ⁻¹ + ϕⁿ⁻²)/√5 - (ψⁿ⁻¹ − ψⁿ⁻²)/√5
Fib(n) = ϕⁿ[1/ϕ + 1/ϕ²]/√5 - ψⁿ[1/ψ + 1/ψ²]/√5

Substituting the values for ϕ and ψ
Fib(n) = ϕⁿ[2/(1 + √5) + 4/(1 + √5)²]/√5 - ψⁿ[2/(1 − √5) + 4/(1 - √5)²]/√5
Fib(n) = ϕⁿ{[2(1 + √5) + 4]/(1 + √5)²}/√5 - ψⁿ{[2(1 - √5) + 4]/(1 - √5)²}/√5
Fib(n) = ϕⁿ[(6 + 2√5)/(1 + √5)²√5] - ψⁿ[(6 - 2√5)/(1 - √5)²√5]
Fib(n) = ϕⁿ[(6 + 2√5)/(1 + 5 + 2√5)√5] - ψⁿ[(6 - 2√5)/(1 + 5 - 2√5)√5]
Fib(n) = ϕⁿ[(6 + 2√5)/(6 + 2√5)√5] - ψⁿ[(6 - 2√5)/(6 - 2√5)√5]
Fib(n) = ϕⁿ/√5 - ψⁿ/√5
∴ Fib(n) = (ϕⁿ − ψⁿ)/√5

ϕⁿ/√5 = Fib(n) + ψⁿ/√5

-1 < ψ < 0
-1 < ψⁿ < 1
-1/√5 < ψⁿ/√5 < 1/√5

We know that √5 > 2

-1/2 < -1/√5 < ψⁿ/√5 < 1/√5 < 1/2
Fib(n) - 1/2  < Fib(n) + ψⁿ/√5 < Fib(n) + 1/2
Fib(n) - 1/2 < ϕⁿ/√5 < Fib(n) + 1/2

∴ ϕⁿ/√5 will always be within 0.5 of Fib(n)
∴ Fib(n) is the closest integer to ϕⁿ/√5
```
