---
slug: exercise-3-47
name: Exercise 3.47
date: 02-10-26 14:13
---

A semaphore (of size *n*) is a generalization of a mutex. Like a mutex, a semaphore supports acquire and release operations, but it is more general in that up to *n* processes can acquire it concurrently. Additional processes
that attempt to acquire the semaphore must wait for release operations. Give implementations of semaphores

a. in terms of mutexes
b. in terms of atomic `test-and-set!` operations.

## Solution

**Note:** The implementations assume that `test-and-set!` is atomic. So, whenever processes try to `acquire` or `release` the semaphore, the lock protecting the internal counter is acquired atomically. This ensures that updates to the counter can't be interleaved.
