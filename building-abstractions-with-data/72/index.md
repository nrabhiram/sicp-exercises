---
slug: exercise-2-72
name: Exercise 2.72
date: 26-05-19 02:19
---

Consider the encoding procedure that you designed in [Exercise 2.68](/exercise-2-68). What is the order of growth in the number of steps needed to encode a symbol? Be sure to include the number of steps needed to search the symbol list at each node encountered. To answer this question in general is difficult. Consider the special case where the relative frequencies of the *n* symbols are as described in [Exercise 2.71](/exercise-2-71), and give the order of growth (as a function of *n*) of the number of steps needed to encode the most frequent and least frequent symbols in the alphabet.

## Solution

As noted in [Exercise 2.68](/exercise-2-68), the maximum order of growth of steps to encode a symbol in a balanced and unbalanced tree is *O(n)* and *O(n²)* respectively. In an alphabet where the relative frequencies of the *n* symbols are as described in [Exercise 2.71](/exercise-2-71), the order of growth of steps for:

- the most frequent symbol is *O(1)* because the left branch has only one symbol that we need to search through before selecting it and hitting the leaf that holds the symbol.
- the least frequent symbol is *O(n²)*. We hit *n*-1 branches. At the last node before we hit the leaf, the list of symbols we get is `(a b)`, so the number of steps required is 1. At the next node, the list of symbols is `(c a b)`. Here, the number of steps required is 2. At the node right below the root, the number of steps required to find `a` is *n*-2. When we calculate the work performed by summing up the total number of steps, we get (*n*-2)(*n*-1)/2 (and an additional *n*-2 steps each time we search the left branch and fail to find `a` in the list of a single symbol).

| Symbol         | Order of growth |
|----------------|-----------------|
| Most frequent  | *O(1)*          |
| Least frequent | *O(n²)*         |
