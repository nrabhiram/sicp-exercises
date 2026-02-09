---
slug: exercise-1-26
name: Exercise 1.26
date: 26-02-08 23:39
---

Louis Reasoner is having great difficulty doing [Exercise 1.24](exercise-1-24). His `fast-prime?` test seems to run more slowly than his `prime?` test. Louis calls his friend Eva Lu Ator over to help. When they examine Louis’s code, they find that he has rewritten the expmod procedure to use an explicit multiplication, rather than calling `square`:

```racket
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base
                       (expmod base (- exp 1) m))
                    m))))
```

“I don’t see what difference that could make,” says Louis. “I do.” says Eva. “By writing the procedure like that, you have transformed the Θ(log*n*) process into a Θ(*n*) process.” Explain.

## Solution

Louis' version of `expmod` uses `*` instead of `square`. We follow **applicative-order evaluation**, so the arguments are evaluated before applying the procedure.

When we use `square`, and the size of *n* doubles, the number of steps increases by 1.

```
(square (expmod base n m)) → a steps

(expmod base 2n m)
(square (expmod base n m)) → a + 1 steps
```

On the other hand, when we use `*`, and the size of *n* doubles, so does the number of steps

```
(expmod base n m) → a steps

(expmod base 2n m)
(* (expmod base n m) (expmod base n m)) → 2a + 1 steps
```

**Note**: The order of growth of space remains Θ(log*n*) for both implementations. Louis' implementation is tree recursive. The space required is determined by the maximum depth of the tree. At any point, only one branch is being actively evaluated. So, once the left `(expmod base (/ exp 2) m)` fully resolves, then the right one begins. Since each level halves `exp`, the tree has depth log(*n*), i.e. the order of growth for space is Θ(log*n*).
