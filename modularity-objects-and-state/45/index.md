---
slug: exercise-3-45
name: Exercise 3.45
date: 29-09-26 12:46
---

Louis Reasoner thinks our bank-account system is unnecessarily complex and error-prone now that deposits and withdrawals aren’t automatically serialized. He suggests that `make-account-and-serializer` should have exported the serializer (for use by such procedures as `serialized-exchange`) in addition to (rather than instead of) using it to serialize accounts and deposits as `make-account` did. He proposes to redefine accounts as follows:

```racket
(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount)) balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (balance-serializer withdraw))
            ((eq? m 'deposit) (balance-serializer deposit))
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            (else (error "Unknown request: MAKE-ACCOUNT" m))))
  dispatch))
```

Then deposits are handled as with the original `make-account`:

```racket
(define (deposit account amount)
  ((account 'deposit) amount))
```

Explain what is wrong with Louis’s reasoning. In particular, consider what happens when `serialized-exchange` is called.

## Solution

When `serialized-exchange` is called, the process will be stuck when it tries to perform the withdrawal from the first account. This is because `serialized-exchange` is serialized by both `account1` and `account2`. So, if any procedures that exist in these individual account's serializer's set is executed, other procedures in the set can't be executed at the same time.

`serialized-exchange` and the `withdraw` are defined in `account1`'s serializer's set. Since the process for `serialized-exchange` is in progress, `withdraw` can't be executed.

I'm glad that this question was asked, because this was something I was thinking about before starting the set of exercises, and I came to the conclusion unprompted.
