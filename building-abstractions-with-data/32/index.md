---
slug: exercise-2-32
name: Exercise 2.32
date: 26-03-21 13:10
---

We can represent a set as a list of distinct elements, and we can represent the set of all subsets of the set as a list of lists. For example, if the set is `(1 2 3)`, then the set of all subsets is `(() (3) (2) (2 3) (1) (1 3)
(1 2) (1 2 3))`. Complete the following definition of a procedure that generates the set of subsets of a set and give a clear explanation of why it works:

```racket
(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map ⟨??⟩ rest)))))
```

## Solution

**What is a set?** A set can be represented as a list of distinct elements. The order of elements in the set doesn't matter.

**What is a subset?** A subset takes some of the elements in the original list.

Since the order of elements doesn't matter, all of the possible subsets that we can create can be calculated by finding all of the various combinations possible. In a combination, each element can either be included or excluded, i.e. there are 2 possible states. So, if the original list has *n* elements, the total number of subsets possible is 2*ⁿ*.

The reduction strategy for this problem is similar to the one for counting the number of ways to make change.

- First, we find all of the possible subsets without using the first element in the list. So, we find all of the subsets possible with only the sub-list, i.e. the `cdr` of the list.
- Then, we find all of the possible subsets by using the first element. So, we take all of the subsets found in the first step, and pre-pend the first element to them.
