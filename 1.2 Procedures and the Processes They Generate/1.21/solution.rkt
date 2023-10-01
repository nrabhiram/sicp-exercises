#lang sicp

(define (smallest-divisor n)
  (define (square x)
    (* x x))
  (define (divides? divisor)
    (= (remainder n divisor)
       0))
  (define (find test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor) test-divisor)
          (else (find (+ test-divisor 1)))))
  (find 2))

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)