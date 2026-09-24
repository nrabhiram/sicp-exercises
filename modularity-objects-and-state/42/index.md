---
slug: exercise-3-42
name: Exercise 3.42
date: 25-09-26 01:25
---

Ben Bitdiddle suggests that it’s a waste of time to create a new serialized procedure in response to every `withdraw` and `deposit` message. He says that `make-account` could be changed so that the calls to `protected` are done outside the `dispatch` procedure. That is, an account would return the same serialized procedure (which was created at the same time as the account) each time it is asked for a withdrawal procedure.

```racket
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
    (let ((protected-withdraw (protected withdraw))
          (protected-deposit (protected deposit)))
      (define (dispatch m)
        (cond ((eq? m 'withdraw) protected-withdraw)
              ((eq? m 'deposit) protected-deposit)
              ((eq? m 'balance) balance)
              (else
               (error "Unknown request: MAKE-ACCOUNT"
                      m))))
      dispatch)))
```

Is this a safe change to make? In particular, is there any difference in what concurrency is allowed by these two versions of `make-account`?

## Solution

Yes, this change is safe. 

In the older approach, a freshly serialized procedure is returned each time a message is sent for withdrawing or depositing. But, the same serializer is used each time, so the constraint will still be applied, i.e. if a serialized procedure is called, none of the other procedures in the same serializer's set can be executed concurrently.

Now, in the newer approach, instead of creating a new serialized procedure each time, we use the same serializer, and create serialized procedures for `withdraw` and `deposit` only once, at construction of the account. This will also ensure that at any time, only one call to `withdraw` or `deposit` for a particular account is processed.
