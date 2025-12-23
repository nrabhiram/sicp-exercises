#lang sicp

(define (reverse list)
  (define (iter list reversed-list)
    (if (null? list)
        reversed-list
        (iter (cdr list)
              (cons (car list)
                    reversed-list))))
  (iter list nil))

(define (except-first-denomination coin-values)
  (cdr coin-values))
(define (first-denomination coin-values)
  (car coin-values))
(define (no-more? coin-values)
  (null? coin-values))

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
(define us-coins-reversed (reverse us-coins))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))
(cc 100 us-coins)
(cc 100 us-coins-reversed)
(cc 100 uk-coins)