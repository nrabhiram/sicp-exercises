---
slug: exercise-3-20
name: Exercise 3.20
date: 17-08-26 22:07
---

Draw environment diagrams to illustrate the evaluation of the sequence of expressions

```racket
(define x (cons 1 2))
(define z (cons x x))
(set-car! (cdr z) 17)
(car x)
17
```

using the procedural implementation of pairs given above. (Compare [Exercise 3.11](/exercise-3-11).)

## Solution

A couple of caveats:

- The procedure objects for `set-y!` weren't drawn for the sake of brevity
- The call stack for `(car x)` wasn't drawn for the same reason
- In the final diagram, the environment for the original `x` pair should be read as having `x: 17`, not `x: 1`; the mutation from `set-car!` changes that binding. The diagram shows `x: 1` only as the initial value when that environment is first created

I got confused in between, so I'm writing the following just as a note to self:

> The enclosing environment an environment points to is the environment that the procedure object for which this environment was created, specifies. Ex. `(set-car! (cdr z) 17)` and `(cdr z)` point to the global environment. The resulting `(z 'cdr)` points to the environment created by the `z` pair. The argument expressions are evaluated in the environment where the procedure is called, and the resulting values are bound in the callee's new frame. But that does not mean the callee's frame points to the caller's frame.

In `(set-car! (cdr z) 17)`, the argument for `z` points to the `x` pair. When the body is evaluated, its two expressions are evaluated in sequence: first `((z 'set-car!) new-value)`, then `z`. In the first expression, the `dispatch` procedure is called, and subsequently, `set-x!` is applied to 17. This modifies the value of `x` in the `x` pair, i.e. the `car` value. Finally, `set-car!` returns its local parameter `z`, which in this call is the same dispatch procedure that global `x` points to.
