---
slug: exercise-2-22
name: Exercise 2.22
date: 26-03-15 09:57
---

Louis Reasoner tries to rewrite the first squarelist procedure of [Exercise 2.21](/exercise-2-21) so that it evolves an iterative process:

```racket
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))
```

Unfortunately, defining `square-list` this way produces the answer list in the reverse order of the one desired. Why?

Louis then tries to fix his bug by interchanging the arguments to `cons`:

```racket
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))
```

This doesn’t work either. Explain.

## Solution

In the first solution, we're prepending each value to the list instead of appending. Here's how the result evolves from one step to the next.

```racket
(cons 1 nil)
(cons 4 (cons 1 nil))
(cons 9 (cons 4 (cons 1 nil)))
(cons 16 (cons 9 (cons 4 (cons 1 nil))))
```

We end up with a structure that violates the properties of a list. `nil` is to be used as a signal that we're at the end of the list. But, here, the first item in the sequence is a `nil`. To make a list, we need to set the `car` to the current element, and the `cdr` to be the sublist of elements we have so far. By flipping this, we get a nested structure that isn't a list.

```racket
(cons nil 1)
(cons (cons nil 1) 4)
(cons (cons (cons nil 1) 4) 9)
(cons (cons (cons (cons nil 1) 4) 9) 16)
```
