---
slug: exercise-3-44
name: Exercise 3.44
date: 29-09-26 12:12
---

Consider the problem of transferring an amount from one account to another. Ben Bitdiddle claims that this can be accomplished with the following procedure, even if there are multiple people concurrently transferring money among multiple accounts, using any account mechanism that serializes deposit and withdrawal transactions, for example, the version of `make-account` in the text above.

```racket
(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))
```

Louis Reasoner claims that there is a problem here, and that we need to use a more sophisticated method, such as the one required for dealing with the exchange problem. Is Louis right? If not, what is the essential difference between the transfer problem and the exchange problem? (You should assume that the balance in `from-account` is at least `amount`.)

## Solution

No, Louis is wrong. The sequence of events for the transfer problem is different than the exchange one. The event for computing the difference b/w the two accounts isn't necessary for the transfer problem. We only have to perform the serialized operations for withdrawing and depositing the amount. Since these are serialized operations, only one process for an individual account can happen at a time. So even if multiple operations are happening on an account concurrently, and the events within a transfer operation are interleaved with other withdrawals and deposits, the final amount in each individual account after all of the operations are over will be correct.

**Note:** This is assuming that an additional event isn't necessary for checking that the minimum balance in `from-account` when the `transfer` is executed is always at least `amount`.
