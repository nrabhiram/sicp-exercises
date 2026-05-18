---
slug: exercise-2-68
name: Exercise 2.68
date: 26-05-18 21:55
---

The `encode` procedure takes as arguments a message and a tree and produces the list of bits that gives the encoded message.

```racket
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
```

`encode-symbol` is a procedure, which you must write, that returns the list of bits that encodes a given symbol according to a given tree. You should design `encode-symbol` so that it signals an error if the symbol is not in the tree at all. Test your procedure by encoding the result you obtained in [Exercise 2.67](/exercise-2-67) with the sample tree and seeing whether it is the same as the original sample message.

## Solution

The strategy for `encode-symbol` is that it goes through each one of the symbols contained by the node and compares it to the symbol we're currently encoding. If this node has the symbol we're examining, it means that we're in the right branch. So, we add the bit for this branch, and proceed with the encoding process by selecting the next branch that holds this symbol. 

At each level, the maximum amount of work done to verify whether the symbol exists below the node with *n* symbols is *n*. 

In the case of an unbalanced tree, i.e. one that leans to either the left or right, each time we select a branch, we only peel off one symbol. If the symbol we're looking for is at the furthest possible distance from the root node, the maximum amount of work required to encode it can be (approximately) calculated as shown:

```
nth level: 1 step
(n-1)th level: 2 steps
...
1st level: n-1 steps

total number of steps = 1 + 2 + ... + n-1
      = n(n-1)/2
```

**Note:** This work is done by the helper procedure `includes`, which iterates through the set of symbols one by one and compares each one with the symbol we're looking for.

So the order of growth of steps to encode a single symbol in an unbalanced tree is *O(n²)*, when *n* is the number of symbols in the alphabet. The total order of growth of steps to encode a full message is *O(k⋅n²)*. Each `append` would cost a maximum of *n* steps but this gets beaten by the *n²*, which grows faster.

The order of growth of space in an unbalanced tree can is *O(k + n)* where *k* is the length of symbols in the message, and *n* is the number of symbols in the alphabet because the maximum number of deferred operations possible is *k* `append` operations by `encode` and *n* `cons` operations by `encode-symbol`.

In the case of a balanced tree, each time we select a branch, the number of symbols below the node is halved. If the symbol we're looking for is at the furthest possible distance from the root node, the amount of work required to encode it can be (approximately) calculated as shown:

```
1st level: n/2 steps
2nd level: n/4 steps
...
(log₂n)th level: n/2^(log₂n) = n/n steps

total number of steps = n[1/2 + 1/4 + 1/8 ... + 1/n]
                      ≈ n(1)
                      ≈ n    
```

So the order of growth of steps to encode a single symbol in a balanced tree is *O(n)*, when *n* is the number of symbols in the alphabet. The total order of growth of steps to encode a full message is *O(k⋅n)*. Each `append` would cost a maximum of *n* steps, and including this work still gives us the same order of growth.

The order of growth of space in a balanced tree can is *O(k + logn)* where *k* is the length of symbols in the message, and *logn* is the depth of the encoding tree because the maximum number of deferred operations possible is *k* `append` operations by `encode` and *log₂n* `cons` operations by `encode-symbol`.

|            | Steps        | Space        |
|------------|--------------|--------------|
| Unbalanced | O(k⋅n²)      | O(k + n)     |
| Balanced   | O(k⋅n)       | O(k + log n) |
