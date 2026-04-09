---
slug: exercise-2-42
name: Exercise 2.42
date: 26-04-08 11:20
---

The “eight-queens puzzle” asks how to place eight queens on a chessboard so that no queen is in check from any other (i.e., no two queens are in the same row, column, or diagonal). One possible solution is shown in the figure below. One way to solve the puzzle is to work across the board, placing a queen in each column. Once we have placed *k*−1 queens, we must place the *k*th queen in a position where it does not check any of the queens already on the board. We can formulate this approach recursively: Assume that we have already generated the sequence of all possible ways to place *k*−1 queens in the first *k*−1 columns of the board. For each of these ways, generate an extended set of positions by placing a queen in each row of the *k*th column. Now filter these, keeping only the positions for which the queen in the *k*th column is safe with respect to the other queens. This produces the sequence of all ways to place *k* queens in the first *k* columns. By continuing this process, we will produce not only one solution, but all solutions to the puzzle.

```
. . . . . Q . .
. . Q . . . . .
Q . . . . . . .
. . . . . . Q .
. . . . Q . . .
. . . . . . . Q
. Q . . . . . .
. . . Q . . . .
```

We implement this solution as a procedure `queens`, which returns a sequence of all solutions to the problem of placing *n* queens on an *n*×*n* chessboard. `queens` has an internal procedure `queen-cols` that returns the sequence of all ways to place queens in the first *k* columns of the board.

```racket
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
```

In this procedure `rest-of-queens` is a way to place *k*−1 queens in the first *k*−1 columns, and `new-row` is a proposed row in which to place the queen for the *k*th column. Complete the program by implementing the representation for sets of board positions, including the procedure `adjoin-position`, which adjoins a new row-column position to a set of positions, and `empty-board`, which represents an empty set of positions. You must also write the procedure `safe?`, which determines for a set of positions, whether the queen in the *k*th column is safe with respect to the others. (Note that we need only check whether the new queen is safe — the other queens are already guaranteed safe with respect to each other.)

## Solution

`queens` is similar to the `permutations` example that was illustrated in this section. But, `permutations` creates a depth-first tree recursive process, because the recursive call happens in the `map` within the processing function of the `flatmap`, which creates a list of possible permutations which start with the iteration's current value. 

In the case of `queens`, the recursion is linear in nature. You end up with a deferred chain of `filter` and `flatmap` operations, until you hit `k = 0`, the terminating case. The terminal value that is returned is `(list nil)`, because we need to iterate at least once in the `flatmap`.

A position on the board is represented with a list of 2 values for the row and column respectively. When we calculate the number of ways to place the 1st queen on the board (somewhere on the first column), we end up with multiple lists, for each possible value for the row, i.e from 1 to `board-size`. At every step, each map value is a list of such positions. The flattened result will be a single list with each element being a list of positions for the queens, i.e. a potential solution that is later passed through the filter.

The total number of solutions is 92.
