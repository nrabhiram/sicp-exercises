---
slug: exercise-1-36
name: Exercise 1.36
date: 26-02-17 19:09
---

Modify `fixed-point` so that it prints the sequence of approximations it generates, using the `newline` and `display` primitives shown in [Exercise 1.22](exercise-1-22). Then find a solution to *xˣ* = 1000 by finding a fixed point of *x* → log(1000)/log(*x*). (Use Scheme’s primitive `log` procedure, which computes natural logarithms.) Compare the number of steps this takes with and without average damping. (Note that you cannot start fixed-point with a guess of 1, as this would cause division by log(1) = 0.)

## Solution

The following is the sequence of approximations `fixed-point` generates if we don't use average damping.

```
guess value: 9.965784284662087 | attempt: 1
guess value: 3.004472209841214 | attempt: 2
guess value: 6.279195757507157 | attempt: 3
guess value: 3.759850702401539 | attempt: 4
guess value: 5.215843784925895 | attempt: 5
guess value: 4.182207192401397 | attempt: 6
guess value: 4.8277650983445906 | attempt: 7
guess value: 4.387593384662677 | attempt: 8
guess value: 4.671250085763899 | attempt: 9
guess value: 4.481403616895052 | attempt: 10
guess value: 4.6053657460929 | attempt: 11
guess value: 4.5230849678718865 | attempt: 12
guess value: 4.577114682047341 | attempt: 13
guess value: 4.541382480151454 | attempt: 14
guess value: 4.564903245230833 | attempt: 15
guess value: 4.549372679303342 | attempt: 16
guess value: 4.559606491913287 | attempt: 17
guess value: 4.552853875788271 | attempt: 18
guess value: 4.557305529748263 | attempt: 19
guess value: 4.554369064436181 | attempt: 20
guess value: 4.556305311532999 | attempt: 21
guess value: 4.555028263573554 | attempt: 22
guess value: 4.555870396702851 | attempt: 23
guess value: 4.555315001192079 | attempt: 24
guess value: 4.5556812635433275 | attempt: 25
guess value: 4.555439715736846 | attempt: 26
guess value: 4.555599009998291 | attempt: 27
guess value: 4.555493957531389 | attempt: 28
guess value: 4.555563237292884 | attempt: 29
guess value: 4.555517548417651 | attempt: 30
guess value: 4.555547679306398 | attempt: 31
guess value: 4.555527808516254 | attempt: 32
guess value: 4.555540912917957 | attempt: 33
guess value: 4.555532270803653 | attempt: 34
--- COMPUTATION ENDED ---
4.555532270803653
```

It takes 34 steps to converge to the fixed point without average damping.

The following is the sequence of approximations `fixed-point` generates if we do use average damping.

```
guess value: 5.9828921423310435 | attempt: 1
guess value: 4.922168721308343 | attempt: 2
guess value: 4.628224318195455 | attempt: 3
guess value: 4.568346513136242 | attempt: 4
guess value: 4.5577305909237005 | attempt: 5
guess value: 4.555909809045131 | attempt: 6
guess value: 4.555599411610624 | attempt: 7
guess value: 4.5555465521473675 | attempt: 8
guess value: 4.555537551999825 | attempt: 9
--- COMPUTATION ENDED ---
4.555537551999825
```

It takes 9 steps to converge to the fixed point with average damping.

We converge to the fixed point quicker if we use average damping.
