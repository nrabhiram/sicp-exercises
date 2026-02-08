#lang sicp

(define (smallest-divisor n)
  (define (divides? a n)
    (= (remainder n a) 0))
  (define (square a) (* a a))
  (define (find a)
    (cond ((> (square a) n) n)
          ((divides? a n) a)
          (else (find (+ a 1)))))

  (find 2))

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)
