---
slug: exercise-2-18
name: Exercise 2.18
date: 26-03-14 18:03
---

Define a procedure `reverse` that takes a list as argument and returns a list of the same elements in reverse order:

```racket
(reverse (list 1 4 9 16 25))
(25 16 9 4 1)
```

## Solution

You can write the `reverse` procedure using either a recursive or iterative approach.

In the recursive approach, 

- we `append` the reversed sublist to a list containing only the first element
- the terminating case is when we come across a `nil`, which signals that we have gone `cdr`'d our way through the entire list

```racket
(reverse (list 1 4 9 16 25))
(append (reverse (list 4 9 16 25)) (list 1))
(append (append (reverse (list 9 16 25)) (list 4)) (list 1))
(append (append (append (reverse (list 16 25)) (list 9)) (list 4)) (list 1))
(append (append (append (append (reverse (list 25)) (list 16)) (list 9)) (list 4)) (list 1))
(append (append (append (append (append (reverse nil) (list 25)) (list 16)) (list 9)) (list 4)) (list 1))
(append (append (append (append (append nil (list 25)) (list 16)) (list 9)) (list 4)) (list 1))
(append (append (append (append (list 25) (list 16)) (list 9)) (list 4)) (list 1))
(append (append (append (list 25 16) (list 9)) (list 4)) (list 1))
(append (append (list 25 16 9) (list 4)) (list 1))
(append (list 25 16 9 4) (list 1))
(list 25 16 9 4 1)
```

Technically, this process follows linear recursion. So, the space required is proportional to the maximum depth of the `append` calls, i.e. *n*. And the number of steps is 2*n* + 1. But, the `append` operation also bears a cost because it traverses through the entire sublist each time it's invoked. So, the additional number of steps is equal to 1 + 2 + ... + *n* - 1. This can be reduced to:

```
(n-1)(n-1+1)/2
(n)(n-1)/2
```

This means that the order of growth for steps is proportional to *n*².

In the iterative approach, at each step, we extract the first item of the sublist and create a pair with this item and the reversed list we're constructing (in that order). The number of steps required is *n* and the space required is constant.

| Approach  | Steps | Space |
|-----------|-------|-------|
| Recursive | Θ(n²) | Θ(n)  |
| Iterative | Θ(n)  | Θ(1)  |
