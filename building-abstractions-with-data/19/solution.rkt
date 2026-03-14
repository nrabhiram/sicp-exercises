#lang sicp

(define (first-denomination cv)
  (car cv))
(define (except-first-denomination cv)
  (cdr cv))
(define (no-more? cv)
  (null? cv))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination
                 coin-values))
            (cc (- amount
                   (first-denomination
                    coin-values))
                coin-values)))))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (print-denominations cv)
  (cond ((no-more? cv) (display ""))
        (else
         (display (car cv))
         (if (no-more? (cdr cv))
             (display "")
             (display ", "))
         (print-denominations (cdr cv)))))

(define (assert coin-values amount expected-res)
  (newline)
  (display "--- TEST NUMBER OF WAYS TO MAKE CHANGE ---")
  (newline)
  (display "Denominations allowed: ")
  (print-denominations coin-values)
  (newline)
  (display "Amount to make change for: ")
  (display amount)
  (newline)
  (display "Expected number of ways: ")
  (display expected-res)
  (newline)
  (display "Actual number of ways: ")
  (display (cc amount coin-values))
  (newline)
  (display "--- END TEST ---")
  (newline))

;; tests
(assert us-coins 100 292)
(assert us-coins 10 4)
(assert us-coins 5 2)
(assert us-coins 0 1)
(assert (list 1 5 10 25 50) 100 292) ; order does not affect the result
