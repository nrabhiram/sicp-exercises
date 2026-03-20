---
slug: exercise-2-24
name: Exercise 2.24
date: 26-03-15 23:03
---

Suppose we evaluate the expression `(list 1 (list 2 (list 3 4)))`. Give the result printed by the interpreter, the corresponding box-and-pointer structure, and the interpretation of this as a tree (as in Figure 2.6).

## Solution

The result printed by the interpreter would look like this:

```racket
(1 (2 (3 4)))
```

Here's what the box-and-pointer structure would look like:

```
[•|•]--->[•|/]
 |        |
 v        v
 1       [•|•]--->[•|/]
          |        |
          v        v
          2       [•|•]--->[•|/]
                   |        |
                   v        v
                   3        4     
```

And here's what the tree structure looks like:

```
    (1 (2 (3 4)))
       / \
      1   (2 (3 4))
            / \
           2   (3 4)
                / \
               3   4
```
