#lang sicp

(define (coin-change amount)
  (define (denomination type)
    (cond ((= type 1) 1)
          ((= type 2) 5)
          ((= type 3) 10)
          ((= type 4) 25)
          ((= type 5) 50)))
  (define (cc amount denomination-type)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (= denomination-type 0)) 0)
          (else (+ (cc amount
                       (- denomination-type
                          1))
                   (cc (- amount
                          (denomination denomination-type))
                       denomination-type)))))
  (cc amount 5))

(coin-change 100)
(coin-change 50)
(coin-change 10)