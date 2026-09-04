---
slug: exercise-3-29
name: Exercise 3.29
date: 04-09-26 13:38
---

Another way to construct an or-gate is as a compound digital logic device, built from and-gates and inverters. Define a procedure `or-gate` that accomplishes this. What is the delay time of the or-gate in terms of `and-gate-delay` and `inverter-delay`?

## Solution

The delay time of the or-gate would be

```
2×inverter-delay + and-gate-delay
```
