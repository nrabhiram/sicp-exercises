---
slug: exercise-2-60
name: Exercise 2.60
date: 26-04-27 14:12
---

We specified that a set would be represented as a list with no duplicates. Now suppose we allow duplicates. For instance, the set {1, 2, 3} could be represented as the list `(2 3 2 1 3 2 2)`. Design procedures `element-of-set?`, `adjoin-set`, `union-set`, and `intersection-set` that operate on this representation. How does the efficiency of each compare with the corresponding procedure for the non-duplicate representation? Are there applications for which you would use this representation in preference to the non-duplicate one?

## Solution

| Procedure            | New       | Old       | Remarks                                            |
| -------------------- | --------- | --------- | -------------------------------------------------- |
| `element-of-set?`    | *Θ(n)*    | *Θ(n)*    | Same, but *n* can be larger due to duplicates      |
| `adjoin-set`         | *Θ(1)*    | *Θ(n)*    | No need to check for duplicates                    |
| `union-set`          | *Θ(n)*    | *Θ(n^2)*  | Only incur the `append` cost, no membership checks |
| `intersection-set`   | *Θ(n^2)*  | *Θ(n^2)*  | Same, but *n* can be larger due to duplicates      |


We would use this representation when we have a system that adds entrie(s) often and we don't care about duplicates. This means that our system relies heavily on `adjoin-set` and `union-set`. The tradeoff we have to consider is that the cost of `element-of-set?` and `intersection-set` will be higher because we'll have more duplicates in our representations of sets.
