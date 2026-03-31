---
slug: exercise-2-37
name: Exercise 2.37
date: 26-03-31 17:05
---

Suppose we represent vectors *v* = (*vᵢ*) as sequences of numbers, and matrices *m* = (*mᵢⱼ*) as sequences of vectors (the rows of the matrix). For example, the matrix

```
⎡ 1  2  3  4 ⎤
⎢ 4  5  6  6 ⎥
⎣ 6  7  8  9 ⎦
```

is represented as the sequence `((1 2 3 4) (4 5 6 6) (6 7 8 9))`. With this representation, we can use sequence operations to concisely express the basic matrix and vector operations. These operations (which are described in any book on matrix algebra) are the following:

| Procedure                | Result                                              |
| ------------------------ | --------------------------------------------------- |
| `(dot-product v w)`      | returns the sum *Σᵢvᵢwᵢ*                            |
| `(matrix-*-vector m v)`  | returns the vector **t**, where *tᵢ* = *Σⱼmᵢⱼvⱼ*    |
| `(matrix-*-matrix m n)`  | returns the matrix **p**, where *pᵢⱼ* = *Σₖmᵢₖnₖⱼ*   |
| `(transpose m)`          | returns the matrix **n**, where *nᵢⱼ* = *mⱼᵢ*       |

We can define the dot product as

```racket
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
```

Fill in the missing expressions in the following procedures for computing the other matrix operations. (The procedure
`accumulate-n` is defined in [Exercise 2.36](exercise-2-36).)

```racket
(define (matrix-*-vector m v)
  (map ⟨??⟩ m))
(define (transpose mat)
  (accumulate-n ⟨??⟩ ⟨??⟩ mat))
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map ⟨??⟩ m)))
```

## Solution

Took me a bit of time to visualize it, and I didn't want to rely on what I could recall from my Math eduction in 12th grade to blindly implement the solution. Expressing the results of `matrix-*-matrix` and `transpose` in English helped with this.

When we apply `transpose` to a matrix `m`, the rows of the resultant matrix are the columns of `m`.

When we apply `matrix-*-matrix` to `m` and `n`, provided the number of columns in `m` and the number of rows in `n` are equal, the resultant matrix `p` has the same number of rows as `m` and the same number of columns as `n`. An element `pᵢⱼ` has a value equal to the `dot-product` of the vectors formed by the *i*-th row of `m` and the *j*-th column of `n`, i.e. the *j*-th row of the `transpose` of `n`.

**Note:** The number of columns and rows in `n` and `m` must be equal because otherwise, the `dot-product` of the 2 required vectors would be invalid, as they don't have the same number of elements.
