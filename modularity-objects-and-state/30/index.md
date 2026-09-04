---
slug: exercise-3-30
name: Exercise 3.30
date: 04-09-26 15:22
---

Figure 3.27 shows a *ripple-carry adder* formed by stringing together *n* full-adders. This is the simplest form of parallel adder for adding two *n*-bit binary numbers. The inputs *A₁*, *A₂*, *A₃*, ..., *Aₙ* and *B₁*, *B₂*, *B₃*, ..., *Bₙ* are the two binary numbers to be added (each *Aₖ* and *Bₖ* is a 0 or a 1). The circuit generates *S₁*, *S₂*, *S₃*, ..., *Sₙ*, the *n* bits of the sum, and *C*, the carry from the addition. Write a procedure `ripple-carry-adder` that generates this circuit. The procedure should take as arguments three lists of *n* wires each — the *Aₖ*, the *Bₖ*, and the *Sₖ* — and also another wire *C*. The major drawback of the ripple-carry adder is the need to wait for the carry signals to propagate. What is the delay needed to obtain the complete output from an *n*-bit ripple-carry adder, expressed in terms of the delays for and-gates, or-gates, and inverters?

## Solution

Let's use the following labels for the sake brevity.

```
A = and-gate-delay
O = or-gate-delay
I = inverter-delay
```

In a half-adder, the delays for C and S respectively are:

```
C = A
S = max(O, A + I) + A
```

Because the or-gate branch and the and-gate -> inverter branch run in parallel before the final and-gate. This means that we get the value of the find and-gate only after both these branches propogate their values.

In a full-adder, the delays for SUM and Cout respectively are:

```
SUM = 2S = 2×max(O, A + I) + 2A
Cout = max(S, S + C) + O = S + C + O
```

To get the final carry value, it takes

```
nCout = nS + nC + nO
      = n×[max(O, A + I) + A] + nA + nO
      = n×max(O, A + I) + 2nA + nO
```
