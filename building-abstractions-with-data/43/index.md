---
slug: exercise-2-43
name: Exercise 2.43
date: 26-04-09 10:38
---

Louis Reasoner is having a terrible time doing [Exercise 2.42](exercise-2-42). His `queens` procedure seems to work, but it runs extremely slowly. (Louis never does manage to wait long enough for it to solve even the 6 × 6 case.) When Louis asks Eva Lu Ator for help, she points out that he has interchanged the order of the nested mappings in the `flatmap`, writing it as

```racket
(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))
```

Explain why this interchange makes the program run slowly. Estimate how long it will take Louis’s program to solve the eight-queens puzzle, assuming that the program in [Exercise 2.42](exercise-2-42) solves the puzzle in time *T*.

## Solution

The process evolved by Louis's implementation is similar to the `permutation` example's — depth-first tree recursion. 

- We start at `k = 8` and `new-row = 1`. 
- The recursive call takes us to `k = 7` and `new-row = 1`.
- This repeats until we hit the terminal case, `k = 0`, because of the recursive call at `k = 1` and `new-row = 1`.
- This evaluates to `(list nil)`, so at `k = 1` and `new-row = 1`, we end up with a list of only one position, i.e. `(1 1)`.
- Now, we traverse horizontally, all the way to `new-row = 8`. After flattening the result of each `map`, we end up with a list of potential solutions, i.e. a list in which each element is a list of positions.
- This is the result of `(queen-cols 1)`, which is evaluated when `k = 2` and `new-row = 1`.
- We `adjoin` the position `(1 2)` to each of the lists of positions.
- We traverse horizontally till `new-row = 8` and flatten the results, i.e. the list of lists of positions generated from each `map`.
- This process repeats until we reach `k = 8` and `new-row = 1`.
- Then, we traverse horizontally.

Let's say that the size of the board is *n*. 

- At the `(m, 1)` level, we end up with a total of *n* calls to `(queen-cols 0)`.
- At the `(m, 2)` level, we end up with a total of *n* calls to `(queen-cols 1)`, which equals to a total of *n²* calls to `(queen-cols 0)`.

Upon extrapolation we end up with a total of *n⁽ⁿ⁻¹⁾* calls to `(queen-cols 0)`.

**Note:** There's only a single call to `(queen-cols 8)`. That is why we have a total of *n⁽ⁿ⁻¹⁾* calls and not *nⁿ*.

The correct answer follows a linear-recursive process. So, the number of steps is proportional to *n*.

When we examine the order of growth of space for both versions of the procedure, it's proportional to *n*. At any point, in Louis's procedure, the maximum depth of calls is *n*.


|                          | Original | Louis        |
| ------------------------ | -------- | ------------ |
| Order of growth of steps | *T*      | *T · n⁽ⁿ⁻¹⁾* |
| Order of growth of space | *O(n)*   | *O(n)*       |

This is an approximation and it is considering the worst case possible, in which none of the potential solutions are pruned out by `filter` in Louis's implementation and all of the incorrect ones are in the original implementation. If we remove the `filter` step in Louis's implementation, the observed result is closer to our estimation. Our takeaway should be that the time taken for Louis's implementation is orders of magnitude slower.
