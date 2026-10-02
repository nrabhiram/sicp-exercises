---
slug: exercise-3-46
name: Exercise 3.46
date: 01-10-26 12:46
---

Suppose that we implement `test-and-set!` using an ordinary procedure as shown in the text, without attempting to make the operation atomic. Draw a timing diagram like the one in Figure 3.29 to demonstrate how the mutex implementation can fail by allowing two processes to acquire the mutex at the same time.

## Solution

I'm too lazy to draw timing diagram, but here's an illustration of how implementing `test-and-set!` using an ordinary procedure is problematic. Assume that two processes try to concurrently acquire the mutex at the same time.

```
Process A reads false
Process B reads false
Process B sets true
Process A sets true
```

If the events are interleaved as shown above, both processes would have acquired the lock at the same time. This is a failure of our mutex implementation.
