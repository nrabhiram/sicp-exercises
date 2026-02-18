---
slug: exercise-1-42
name: Exercise 1.42
date: 26-02-18 17:43
---

 Let *f* and *g* be two one-argument functions. The composition *f* after *g* is defined to be the function *x →
 f(g(x))*. Define a procedure `compose` that implements composition.
 
 ```racket
((compose square inc) 6)
49
 ```
