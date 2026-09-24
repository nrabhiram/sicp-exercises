---
slug: exercise-3-41
name: Exercise 3.41
date: 25-09-26 00:50
---

Ben Bitdiddle worries that it would be better to implement the bank account as follows (where the commented line has been changed):

```racket
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (protected withdraw))
            ((eq? m 'deposit) (protected deposit))
            ((eq? m 'balance) 
             ((protected
               (lambda () balance)))) ; serialized
            (else
             (error "Unknown request: MAKE-ACCOUNT"
                    m))))
    dispatch))
```

because allowing unserialized access to the bank balance can result in anomalous behavior. Do you agree? Is there any scenario that demonstrates Ben’s concern?

## Solution

I don't agree with Ben that there's any anomalous behavior that can occur by merely accessing `balance`. The internal procedures, `withdraw` and `deposit`, are the only ones that manipulate `balance`. Sure, if executed concurrently, you might access an outdated version of `balance`'s value, but you can't change it in an unsafe way.
