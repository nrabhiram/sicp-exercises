---
slug: exercise-3-48
name: Exercise 3.48
date: 03-10-26 13:37
---

Explain in detail why the deadlock-avoidance method described above, (i.e., the accounts are numbered, and each process attempts to acquire the smaller-numbered account first) avoids deadlock in the exchange problem. Rewrite `serialized-exchange` to incorporate this idea. (You will also need to modify `make-account` so that each account is created with a number, which can be accessed by sending an appropriate message.)

## Solution

In this case, where:

- one person initiates an exchange between *a1* and *a2*,
- and another person initiates an exchange between *a2* and *a1*,

the ordering is different, but the operation is equivalent, since both exchanges, performed individually, would yield the same result. Because each process could acquire one lock and is waiting on the other lock needed to progress, we end up in a deadlock, where neither process can acquire the other resource.

If we preserve the ordering by attaching IDs to the accounts, we can guarantee that the locks are always acquired in a pre-determined order whenever an exchange is initiated.  Thus, if one process has acquired the lower-numbered account, another process trying to exchange the same accounts cannot acquire the higher-numbered account first; it must wait for the lower-numbered account. This prevents circular waiting, and therefore avoids deadlock.
