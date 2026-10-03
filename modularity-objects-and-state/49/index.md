---
slug: exercise-3-49
name: Exercise 3.49
date: 03-10-26 14:05
---

Give a scenario where the deadlock-avoidance mechanism described above does not work. (Hint: In the exchange problem, each process knows in advance which accounts it will need to get access to. Consider a situation where a process must get access to some shared resources before it can know which additional shared resources it will require.)

## Solution

Let's say that in our bank account example, each bank account also maintains a list of beneficiaries to whom a monthly amount is auto-paid. We have 2 accounts: *A* and *B*. Process 1 acquires the lock for *A* and finds its beneficiaries, amongst which one is *B*. At the same time, process 2 acquires the lock for *B* to process its own auto-payments, and discovers that one of *B*'s beneficiaries is *A*.

- Process 1 has the lock for *A* and needs the lock for *B* to proceed.
- Process 2 has the lock for *B* and needs the lock for *A* to proceed.

The deadlock-avoidance mechanism doesn't work here, because each process does not know which additional account it needs until after it has acquired its first account's lock and inspected its beneficiaries.
