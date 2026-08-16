---
slug: exercise-3-19
name: Exercise 3.19
date: 17-08-26 01:58
---

Redo [Exercise 3.18](/exercise-3-18) using an algorithm that takes only a constant amount of space. (This requires a very clever idea.)

## Solution

I wouldn't have come up with the solution for this on my own even in a million years, so I had to look it up. There's an algorithm called the *Tortoise and Hare Algorithm* that checks if a linked list structure is cyclical. Let's say that 2 runners are racing against each other. How would you determine who's faster? If it's a straight path, whoever's ahead is the faster one. If it's a circular path, the faster runner will end up lapping the slower one.

In this algorithm, we have 2 pointers. The slower pointer `cdr`s through the list one at a time, whereas the faster one `cdr`s through it two at a time. We know that the structure isn't cyclical if one of the pointers can't jump further, i.e. it will cross the end of the structure if it makes a jump of 2 `cdr`s. Since the faster pointer will reach the end earlier (if there's one), it suffices to add these checks for just this pointer. If not, at some point, the gap b/w the faster and slower pointers will reduce and the faster pointer will lap the slower one. When we catch this moment, we know that the structure is cyclical.

It requires a constant amount of space, because unlike the previous solution, we don't have to maintain another list of distinct pairs; just a slow and fast pointer to the list in question will do.

In the case of a fully cyclic list (a non-cyclic prefix doesn't exist), at every step, the fast pointer moves one step ahead of the slow pointer. It'll take a total of *n* steps for the fast and slow pointers to be located at the same point again.

| Resource | Order of growth |
| -------- | --------------- |
| Steps    | O(n)            |
| Space    | O(1)            |

where *n* is the number of distinct pairs reachable from the starting pair.
