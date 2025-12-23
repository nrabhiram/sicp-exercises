#lang sicp

(define (coin-change amount)
  (define (denomination type)
    (cond ((= type 1) 1)
          ((= type 2) 5)
          ((= type 3) 10)
          ((= type 4) 25)
          ((= type 5) 50)))
  (define (cc amount denomination-type change-combinations)
    (cond ((= amount 0) (+ change-combinations 1))
          ((or (< amount 0) (= denomination-type 0)) change-combinations)
          (else (cc (- amount
                       (denomination denomination-type))
                    denomination-type
                    (cc amount
                        (- denomination-type
                           1)
                        change-combinations)))))
  (cc amount 5 0))

(coin-change 10)
(coin-change 50)
(coin-change 100)