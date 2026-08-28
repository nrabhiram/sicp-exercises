---
slug: exercise-3-26
name: Exercise 3.26
date: 27-08-26 13:38
---

To search a table as implemented above, one needs to scan through the list of records. This is basically the unordered list representation of Section 2.3.3. For large tables, it may be more efficient to structure the table in a different manner. Describe a table implementation where the (key, value) records are organized using a binary tree, assuming that keys can be ordered in some way (e.g., numerically or alphabetically). (Compare [Exercise 2.66](/exercise-2-66) of Chapter 2.)

## Solution

To start with a smaller example first, I implemented 1D tables using the binary tree structure. Then, once I gained clarity and some confidence, I implemented it for the generalized *n*-dimensional table that was created in [Exercise 3.25](/exercise-3-25).

The structure of the node has to be modified slightly. Now, it has a left-branch, for nodes on the same level, but with key values that are smaller than the node in question. Similarly, a right-branch, but for key values that are larger. We also have a children field, which is a binary tree of nodes that are nested within this node. So, when we traverse through successive keys, we go through the binary tree of children for that node.

The orders of growth are as listed below (assuming that the binary trees are balanced):

| Procedure | Situation                              | Steps        | Space        |
| --------- | -------------------------------------- | --------     | ------------ |
| `lookup`  | general case                           | *Θ(k×log₂n)* | *Θ(1)*       |
| `insert!` | full key path already exists           | *Θ(k×log₂n)* | *Θ(1)*       |
| `insert!` | new chain of subtables must be created | *Θ(k×log₂n)* | *Θ(k+log₂n)* |

Here, *k* is the number of keys and *n* is the maximum number of records scanned at each level.

**Note:** The maximum depth for `insert!` is *k* `adjoin`s at each key level, and log₂*n* `adjoin`s for adding the new subtable to the existing tree of children. Either way, the `assoc` call and `adjoin` call each take log₂*n* steps. So, at each level we have somewhere between log₂*n* or 2×log₂*n* steps.
