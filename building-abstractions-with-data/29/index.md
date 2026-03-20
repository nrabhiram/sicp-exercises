---
slug: exercise-2-29
name: Exercise 2.29
date: 26-03-20 18:13
---

A binary mobile consists of two branches, a left branch and a right branch. Each branch is a rod of a certain length, from which hangs either a weight or another binary mobile. We can represent a binary mobile using compound data by constructing it from two branches (for example, using `list`):

```racket
(define (make-mobile left right)
  (list left right))
```

A branch is constructed from a `length` (which must be a number) together with a `structure`, which may be either a
number (representing a simple weight) or another mobile:

```racket
(define (make-branch length structure)
  (list length structure))
```

- Write the corresponding selectors `left-branch` and `right-branch`, which return the branches of a mobile, and `branch-length` and `branch-structure`, which return the components of a branch.
- Using your selectors, define a procedure `total-weight` that returns the total weight of a mobile.
- A mobile is said to be *balanced* if the torque applied by its top-left branch is equal to that applied by its top right branch (that is, if the length of the left rod multiplied by the weight hanging from that rod is equal to the corresponding product for the right side) and if each of the submobiles hanging off its branches is balanced. Design a predicate that tests whether a binary mobile is balanced.
- Suppose we change the representation of mobiles so that the constructors are
  ```racket
  (define (make-mobile left right) (cons left right))
  (define (make-branch length structure)
    (cons length structure))
  ```
  How much do you need to change your programs to convert to the new representation?

## Solution

The change in representation of mobiles requires us to only change the selectors: `left-branch`, `right-branch`, `branch-length`, and `branch-structure`.

```racket
(define (left-branch m)
  (car m))
(define (right-branch m)
  (cdr m))
(define (branch-length b)
  (car b))
(define (branch-structure b)
  (cdr b))
```
