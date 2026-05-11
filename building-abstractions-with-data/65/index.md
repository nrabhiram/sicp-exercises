---
slug: exercise-2-65
name: Exercise 2.65
date: 26-05-10 18:14
---

Use the results of [Exercise 2.63](/exercise-2-63) and [Exercise 2.64](/exercise-2-64) to give *Θ(n)* implementations of `union-set` and `intersection-set` for sets implemented as (balanced) binary trees.

## Solution

We know the `tree->list-2` has an order of growth of steps of *Θ(n)* and so does `list->tree`. We also know that the implementations of `union-set` and `intersection-set` also have an order of growth of *Θ(n)*. In this implementation for binary trees, we:

- transform the binary trees for the 2 sets into ordered lists using `tree->list-2`,
- apply the ordered list implementation of `union-set` or `intersection-set` accordingly to our results from the previous step,
- and finally transform the ordered list back to a balanced binary tree by applying `list->tree`

Since each of the individual steps has an order of growth of *Θ(n)*, the overall order of growth of steps will also be *Θ(n)*.
