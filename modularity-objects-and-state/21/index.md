---
slug: exercise-3-21
name: Exercise 3.21
date: 18-08-26 13:53
---

Ben Bitdiddle decides to test the queue implementation described above. He types in the procedures to the Lisp interpreter and proceeds to try them out:

```racket
(define q1 (make-queue))
(insert-queue! q1 'a)
((a) a)
(insert-queue! q1 'b)
((a b) b)
(delete-queue! q1)
((b) b)
(delete-queue! q1)
(() b)
```

“It’s all wrong!” he complains. “The interpreter’s response shows that the last item is inserted into the queue twice. And when I delete both items, the second `b` is still there, so the queue isn’t empty, even though it’s supposed to be.” Eva Lu Ator suggests that Ben has misunderstood what is happening. “It’s not that the items are going into the queue twice,” she explains. “It’s just that the standard Lisp printer doesn’t know how to make sense of the queue representation. If you want to see the queue printed correctly, you’ll have to define your own print procedure for queues.” Explain what Eva Lu is talking about. In particular, show why Ben’s examples produce the printed results that they do. Define a procedure `print-queue` that takes a queue as input and prints the sequence of items in the queue.

## Solution

Technically, since the queue is a sequence of items, it is represented using a list. In a queue, we add items at the end of the queue and remove items from the start of the queue, in a **FIFO** (first in first out) fashion. 

The problem with this representation though, is that when we want to add an item, we have to scan the entire list to find the end, before we can append this item. The only operation that we can perform to scan the list is successively `cdr`ing through it. This means that every insert operation has an order of growth of steps of *Θ(n)* (if the size of the queue is *n*).

We can modify the representation to make the insert operation have an order of growth of steps of *Θ(1)*, i.e. the number of steps is constant regardless of the queue size. We can do this by maintaining an additional pointer to the last item in the list. Whenever we want to insert an item, we can directly manipulate the `cdr` of this pointer to the last item, instead of finding it by scanning the entire list.

So, we maintain a pair of two pointers:

- The front pointer points to the beginning of the queue, i.e. the first pair in the list. This will give us access to the entire queue.
- The rear pointer points to the last item in the queue, i.e. the last pair in the list.

When we perform `(insert-queue! q1 'a)`, both the front and rear pointer point to the pair containing `a`, because it's the first item in the queue. When the queue structure is printed by the Lisp interpreter, it prints a structure where both the front and rear pointers refer to the same pair.

After we perform `(insert-queue! q1 'b)`, the old rear pointer's `cdr` is updated to append the pair for `b`. Then, the rear pointer is updated to point to this pair containing `b`. The front pointer will thus give us the full list with `a` and `b`.

When we perform `(delete-queue! q1)` for the first time, the first item in the queue is discarded. We do this by updating the front pointer to be the `cdr`. When we perform it for the second time the front pointer points to an empty list. Since the rear pointer didn't change during either of these operations, it continues to point to the pair that contains `b`. This isn't a problem, though. We check whether a queue is empty from the front, and not the back. If we try to perform an insert on this empty queue, it updates both the front and rear pointers to be the correct ones. If we try to perform a delete, it throws an error because there isn't anything in the queue to delete.

To accurately render the contents of the queue, our custom `print-queue` procedure must print the sequence of items by `cdr`ing through the underlying list in the queue by accessing the front pointer.
