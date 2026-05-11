---
slug: exercise-2-64
name: Exercise 2.64
date: 26-05-06 13:03
---

The following procedure `list->tree` converts an ordered list to a balanced binary tree. The helper procedure `partial-tree` takes as arguments an integer *n* and list of at least *n* elements and constructs a balanced tree containing the first *n* elements of the list. The result returned by `partial-tree` is a pair (formed with `cons`) whose `car` is the constructed tree and whose `cdr` is the list of elements not included in the tree.

```racket
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result 
               (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                     (cdr right-result)))
                (cons (make-tree this-entry 
                                 left-tree 
                                 right-tree)
                      remaining-elts))))))))
```

a. Write a short paragraph explaining as clearly as you can how `partial-tree` works. Draw the tree produced by `list->tree` for the list `(1 3 5 7 9 11)`.
b. What is the order of growth in the number of steps required by `list->tree` to convert a list of *n* elements?

## Solution

The convoluted syntactical structure of the program, caused by the nested `let` statements, can make it difficult to reason about what the program does and the type of process it generates. I found the following representation for the step-by-step evaluation of the expression `(partial-tree '(1 3 5 7 9 11) 6)` helpful with visualizing the evolution of the process generated and how the tree is built.

```
(partial-tree '(1 3 5 7 9 11) 6)
  left-size: 2
  left-result: (partial-tree '(1 3 5 7 9 11) 2)
                 left-size: 0
                 left-result: (partial-tree '(1 3 5 7 9 11) 0)
                              (cons '() '(1 3 5 7 9 11))
                 left-tree: '()
                 non-left-elts: '(1 3 5 7 9 11)
                 right-size: 1
                 this-entry: 1
                 right-result: (partial-tree '(3 5 7 9 11) 1)
                                 left-size: 0
                                 left-result: (partial-tree '(3 5 7 9 11) 0)
                                              (cons '() '(3 5 7 9 11))
                                 left-tree: '()
                                 non-left-elts: '(3 5 7 9 11)
                                 right-size: 0
                                 this-entry: 3
                                 right-result: (partial-tree '(5 7 9 11) 0)
                                               (cons '() '(5 7 9 11))
                               (cons '(3 () ())
                                     '(5 7 9 11))
               (cons '(1 () (3 () ()))
                     '(5 7 9 11))
  left-tree: '(1 () (3 () ()))
  non-left-elts: '(5 7 9 11)
  right-size: 3
  this-entry: 5
  right-result: (partial-tree '(7 9 11) 3)
                  left-size: 1
                  left-result: (partial-tree '(7 9 11) 1)
                                 left-size: 0
                                 left-result: (partial-tree '(7 9 11) 0)
                                              (cons '() '(7 9 11))
                                 left-tree: '()
                                 non-left-elts: '(7 9 11)
                                 right-size: 0
                                 this-entry: 7
                                 right-result: (partial-tree '(9 11) 0)
                                               (cons '() '(9 11))
                               (cons '(7 () ())
                                     '(9 11)) 
                  left-tree: '(7 () ())
                  non-left-elts: '(9 11)
                  right-size: 1
                  this-entry: 9
                  right-result: (partial-tree '(11) 1)
                                  left-size: 0
                                  left-result: (partial-tree '(11) 0)
                                               (cons '() '(11))
                                  left-tree: '()
                                  non-left-elts: '(11)
                                  right-size: 0
                                  this-entry: 11
                                  right-result: (partial-tree '() 0)
                                                (cons '() '())
                                (cons '(11 () ())
                                      '())
                (cons '(9 (7 () ()) (11 () ()))
                      '())
(cons '(5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))
      '())
```

`partial-tree` splits the ordered list into halves around the median element of the set. If the number of elements in the set is odd, we end up with equal halves. Otherwise, the size of the right half will be greater than the left by 1. 

If we've reached a terminal node, i.e. `n` is 1, we construct a tree:

- with this node value as the entry point, 
- and empty subtrees for the left and right branches, i.e. `left-size` and `right-size` is 0. 

This terminal node is peeled off from the front of the list of remaining elements and this tree we've just created, along with the list of remaining elements that need to be used to construct the full balanced tree, percolates upwards.

Let's assume that we've created an arbitrary left branch for the parent tree. We would have peeled enough elements while creating the `partial-tree` for the left branch that the next element in the ordered list (that has been passed upwards in the result of creating the `partial-tree` for the left branch) is the median of the first `n` elements in the original ordered list that was passed to this parent's `partial-tree`. So, we use it as the entry node, and pass the remaining elements to calculate the right subtree, which will have a size of `n - (left-size + 1)`.

The terminal node is a special case in which it's the median, since it's the only element in the list being considered.

Below is the tree that we construct when we evaluate `(list->tree '(1 3 5 7 9 11))`.

```
      5
     / \
    1   9
     \ / \
     3 7  11
```

When we call `partial-tree` to convert an ordered list of size *n* to a balanced tree, the number of steps, i.e. the number of calls to `partial-tree` is 2*n*+1. So, the order of growth of steps is *O(n)*. The order of growth of space is proportional to the longest chain of deferred `partial-tree` operations, which is equal to the maximum depth of the tree, i.e. *O(logn)*.
